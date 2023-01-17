Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1DC66DDFF
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 13:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjAQMqQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 07:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbjAQMqK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 07:46:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37321207F;
        Tue, 17 Jan 2023 04:46:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E9A061333;
        Tue, 17 Jan 2023 12:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C23AC433F1;
        Tue, 17 Jan 2023 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673959559;
        bh=R4MUqRfYUuD7hD15Z2VAffe0lvOKWbQwgywpMdRQ0Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIzQDTNa2+d8GV2wAYso+GyeWBDaiFO4GQ8XNuZOAN7CC2NlmKSz+Dgy0ITBFYGso
         oN+yWT3CYO3ELix6rt/nMBT+zBiFu3Qc/sUwWbPJY3mRs3xmqxpDjtw463FH8ild2d
         Rvit2N5RRjsRH16lsnWge6QOvTAwgMgrtJQPaW3k/z4KgKBHcZ6mrpleIul8liwbVO
         KK5QPL5vsk75Va/Hm8idpXY32nYLKMEMwSsra4fbq7O1b2EszayTZDGvQseiZIqebW
         Hyqdwovkz1V803neN10xbWWrbC/GrNoeyLjqRFOdU+T7oCBpphDePF8Jvw3zGVwoGI
         VCX9qWuxlDX0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHlM5-0004Mp-JV; Tue, 17 Jan 2023 13:46:21 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] efi: efivars: make efivar_supports_writes() return bool
Date:   Tue, 17 Jan 2023 13:43:10 +0100
Message-Id: <20230117124310.16594-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230117124310.16594-1-johan+linaro@kernel.org>
References: <20230117124310.16594-1-johan+linaro@kernel.org>
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

For consistency with the new efivar_is_available() function, change the
return type of efivar_supports_writes() to bool.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/firmware/efi/vars.c | 2 +-
 include/linux/efi.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index d6b2c4f9a575..aa5ba38f81ff 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -110,7 +110,7 @@ int efivars_unregister(struct efivars *efivars)
 }
 EXPORT_SYMBOL_GPL(efivars_unregister);
 
-int efivar_supports_writes(void)
+bool efivar_supports_writes(void)
 {
 	return __efivars && __efivars->ops->set_variable;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2124e55c02d6..f6b107da1cbc 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1061,7 +1061,7 @@ bool efivar_is_available(void);
 static inline bool efivar_is_available(void) { return false; }
 #endif
 
-int efivar_supports_writes(void);
+bool efivar_supports_writes(void);
 
 int efivar_lock(void);
 int efivar_trylock(void);
-- 
2.38.2

