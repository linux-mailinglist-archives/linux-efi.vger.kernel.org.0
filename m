Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69046509D2
	for <lists+linux-efi@lfdr.de>; Mon, 19 Dec 2022 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiLSKNL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Dec 2022 05:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiLSKNK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Dec 2022 05:13:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2578A444;
        Mon, 19 Dec 2022 02:13:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6410AB80D2E;
        Mon, 19 Dec 2022 10:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7B1C433D2;
        Mon, 19 Dec 2022 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671444786;
        bh=so62ehXrt0ugpolpXDq/vhciOHZFZ9Z/0bVRkGbhDyE=;
        h=From:To:Cc:Subject:Date:From;
        b=VuAtJpn1m+nCSNRBmNIusc0AHAFMcriDsUG6yWQXEc7DQZWU2o/8BMmhJAs9VECrE
         zzcKFvzMVyJBGdkCKhFMjMtjbcN5cqkg0619MSWfC1xRqKz4xvemVueJoSOQeqNfSp
         7R/aJh3adC/Lk5FuZJp0qZnC4DQNUME5pKDycN9/yc1gYP3f3RM5gdQHX4xv1PrwDe
         hg1S+IuR72E9/NjBmk23EB1l3xFZrgeg9xbGBcAjhDoVLAdlcTnTzk9zPsjJHz+hy8
         aOXmJxsVX44WGsQb/i3YoYr3c2NQJsgqgpgqUVosSUicbWGP+PuN3WHYplMUaRNEqn
         TIGN8RJR4R9rw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p7D9Y-0002ab-5M; Mon, 19 Dec 2022 11:13:48 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2] efi: random: fix NULL-deref when refreshing seed
Date:   Mon, 19 Dec 2022 11:12:37 +0100
Message-Id: <20221219101237.9872-1-johan+linaro@kernel.org>
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
Lenovo X13s with some firmware revisions, or more generally, whenever
the runtime services have been disabled (e.g. efi=noruntime or with
PREEMPT_RT).

Fixes: e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
Reported-by: Steev Klimaszewski <steev@kali.org>
Reported-by: Bjorn Andersson <andersson@kernel.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Changes in v2
 - amend commit message with a comment on this being needed whenever the
   runtime services have been disabled


 drivers/firmware/efi/efi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 31a4090c66b3..09716eebe8ac 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -429,7 +429,9 @@ static int __init efisubsys_init(void)
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

