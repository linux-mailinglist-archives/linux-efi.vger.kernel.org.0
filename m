Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C917A64E888
	for <lists+linux-efi@lfdr.de>; Fri, 16 Dec 2022 10:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLPJQU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Dec 2022 04:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPJQT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Dec 2022 04:16:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC6829CA5;
        Fri, 16 Dec 2022 01:16:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54B3761F58;
        Fri, 16 Dec 2022 09:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0FAC433EF;
        Fri, 16 Dec 2022 09:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671182176;
        bh=LQ6WvU/8VYqSkymhRGk1M2D2cUZNcEEJNASg72U+chI=;
        h=From:To:Cc:Subject:Date:From;
        b=NluIm6tjLFbZNvYdy96AFVqdQT5NtNGdq5Mjn0NZ+eBB6pkCdPBtei86AVcdpIhMK
         fTtzB6lZTDNJtYPtFOH0zT7Ci5CcHk1Kf49fX06LRh/PKaQx+yfkOY1vhy96ciR9wi
         P7mN94QuOX2BowB5KiqrtXf6NTG+Rv0G8Ea/VtIjvVv253t2HPbd7CI2fCHsBtwvdG
         VOs8+M0Fhxuh380DuclnDF0TNMiPuf2a8JyZ37tlbBI5c1wY40REqf+rLCXAqZRmeh
         HwVpxo983Ap2Z2CbwaEejGHudCmXwoHykMVIr5fLPx5cTV9wDqDYT+RtEHJPVHopb7
         FIWicAS0T5wag==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p66pl-0001ei-IZ; Fri, 16 Dec 2022 10:16:50 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH] efi: random: fix NULL-deref when refreshing seed
Date:   Fri, 16 Dec 2022 10:15:14 +0100
Message-Id: <20221216091514.6298-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Do not try to refresh the RNG seed in case the firmware does not support
setting variables.

This is specifically needed to prevent a NULL-pointer dereference on the
Lenovo X13s with some firmware revisions.

Fixes: e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
Reported-by: Steev Klimaszewski <steev@kali.org>
Reported-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/firmware/efi/efi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 2e168e5b97de..1a9e2f70c550 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -432,7 +432,9 @@ static int __init efisubsys_init(void)
 		platform_device_register_simple("efi_secret", 0, NULL, 0);
 #endif
 
-	execute_with_initialized_rng(&refresh_nv_rng_seed_nb);
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
+		execute_with_initialized_rng(&refresh_nv_rng_seed_nb);
+
 	return 0;
 
 err_remove_group:
-- 
2.37.4

