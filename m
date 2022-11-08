Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC096217D1
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 16:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiKHPPY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 10:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiKHPPX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 10:15:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44FD186F8
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 07:15:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E5FD614E4
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 15:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C47C433D7;
        Tue,  8 Nov 2022 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667920521;
        bh=PvBh27PBFCXtaQOidNxO6/5nh6d8hNXS9H8TeEJQGWY=;
        h=From:To:Cc:Subject:Date:From;
        b=s1r61w9en84boi854UCmYMIKi+URkrejGTIqnlaUXCqsCQR0EumUvOMOa3/NQgqHa
         IOGJot8qHZjFfTdKFcdXPWUSsseD6FaxpXhLijTjW1rtr6IOPtR81lvFFvI/mdVLtV
         kowEpr7QuXXFM8bJbQ7NBqYzzsxLSogdoMnFJWD9sumo44Ux/pVWpTSZnquTcHmMi4
         WUAsQ5p+B1SjZQbUage81W8gc3CGIrt7UJ8mOy5BmK2pX2II3ei32dWkQ+pWnJFJHY
         IDdpyRf4EU7/thqL8sEGBWjd/ktuok/yRXGsm5zZPTjrlM+Z92h+yAAFFoM/9ptbsv
         Z3OuwaxRs6bDw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH] arm64: efi: Disable only the misbehaving runtime service on sync exceptions
Date:   Tue,  8 Nov 2022 16:15:09 +0100
Message-Id: <20221108151509.2250968-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4972; i=ardb@kernel.org; h=from:subject; bh=PvBh27PBFCXtaQOidNxO6/5nh6d8hNXS9H8TeEJQGWY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjanJ80PTGETJgys6kgJwZxUIz77EdYcHZ/wxrk78y sCw2lJyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2pyfAAKCRDDTyI5ktmPJA5zDA CXGiAN9bRURjddHoqlSB55gc3DSZAghsHOpY0Vqj8ACmNii/IkbTzzIs8EAZ/5U/20X04ORDjI3J76 pfNis9Ij+mvTU/GoOL6ZXI6bo+onEeYRg63CAvSCnxNYsLcmMAdXHkKafZwRyPUR0DsGfCyqA36HzK quyMdiX02AaYnAhEqwG6G2TRJBd84rFBEDCZ48Lb1ubAKBoc1fjlcCeVd1n4oyVSy1bUy7Tz3D2k1s KYizqIiL8m2qnFJxlzW8uT9l5KmiUhULbT02fch+MHlakpLNIyzFDucHY8knKxSqc/Uu8ffTJysl/j 8ld46XSBygXCLF1BNLbSTB5CIVgAqzjprcZiOq+O11JJEd06eMxCmndnE5O21ANOvlFG9moFjN2qTS J26ng13DVOB7b07qzXf2H3r37qeNl0WTCVYwrbV6eAFhCgWEgRz5HSgFPN6EstpCbiVeb/lnzfWwqc blG6+lEL6sU39m8oTdPw68mXthAO8jGzeT4PCMBIxiRDM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Alexandru reports that his Ampere Altra machine, whose buggy firmware
triggers a synchronous exception in its implementation of SetTime() when
called without SetVirtualAddressMap() having been called first, doesn't
quite recover from this, and starts spewing error messages into the log
that are unrelated to the buggy runtime service.

The driver in question is the EFI RTC driver, which should be fixed in
any case, as flooding the log like that (or doing any logging to the
kernel log at all on something whuch is not a severe issue) is not ok.

However, in this particular case, it would be beneficial for both
ordinary use as well as diagnostics regarding broken firmware if we only
prevent the broken runtime service from being called again, and permit
others (such as GetTime() which triggers the logging or the variable
services) from being used as normal.

So wire up the existing efi.runtime_supported_mask, and clear the
service's bit in the mask if the generic runtime service wrapper
observes a return value of EFI_ABORTED, which only happens if a service
call is aborted due to an exception. (EFI_ABORTED is not documented as a
valid error code for any of the EFI runtime services).

Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c                 |  1 -
 arch/x86/platform/efi/quirks.c          |  2 +-
 drivers/firmware/efi/runtime-wrappers.c |  6 ++++--
 include/linux/efi.h                     | 24 ++++++++++++------------
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index ee53f2a0aa03f54a..a3b8852f2698d9f7 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -153,7 +153,6 @@ asmlinkage efi_status_t __efi_rt_asm_recover(void);
 asmlinkage efi_status_t efi_handle_runtime_exception(const char *f)
 {
 	pr_err(FW_BUG "Synchronous exception occurred in EFI runtime service %s()\n", f);
-	clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 	return EFI_ABORTED;
 }
 
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index b0b848d6933afbcf..3f48fdf42d97dc1f 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -757,9 +757,9 @@ void efi_crash_gracefully_on_page_fault(unsigned long phys_addr)
 
 	/* Signal error status to the efi caller process */
 	efi_rts_work.status = EFI_ABORTED;
+	efi.runtime_supported_mask = 0;
 	complete(&efi_rts_work.efi_rts_comp);
 
-	clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 	pr_info("Froze efi_rts_wq and disabled EFI Runtime Services\n");
 
 	/*
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index f3e54f6616f02475..336b8bcec86d0127 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -60,8 +60,8 @@ struct efi_runtime_work efi_rts_work;
 ({									\
 	efi_rts_work.status = EFI_ABORTED;				\
 									\
-	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {			\
-		pr_warn_once("EFI Runtime Services are disabled!\n");	\
+	if (!efi_rt_services_supported(efi_rts_work.efi_rts_id)) {	\
+		pr_warn_ratelimited("EFI Runtime Service is disabled!\n");\
 		goto exit;						\
 	}								\
 									\
@@ -83,6 +83,8 @@ struct efi_runtime_work efi_rts_work;
 	else								\
 		pr_err("Failed to queue work to efi_rts_wq.\n");	\
 									\
+	if (efi_rts_work.status == EFI_ABORTED)				\
+		efi.runtime_supported_mask &= ~efi_rts_work.efi_rts_id;	\
 exit:									\
 	efi_rts_work.efi_rts_id = EFI_NONE;				\
 	efi_rts_work.status;						\
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 929d559ad41d29c6..61b252386d61cc4d 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1254,18 +1254,18 @@ extern unsigned long rci2_table_phys;
  */
 enum efi_rts_ids {
 	EFI_NONE,
-	EFI_GET_TIME,
-	EFI_SET_TIME,
-	EFI_GET_WAKEUP_TIME,
-	EFI_SET_WAKEUP_TIME,
-	EFI_GET_VARIABLE,
-	EFI_GET_NEXT_VARIABLE,
-	EFI_SET_VARIABLE,
-	EFI_QUERY_VARIABLE_INFO,
-	EFI_GET_NEXT_HIGH_MONO_COUNT,
-	EFI_RESET_SYSTEM,
-	EFI_UPDATE_CAPSULE,
-	EFI_QUERY_CAPSULE_CAPS,
+	EFI_GET_TIME			= EFI_RT_SUPPORTED_GET_TIME,
+	EFI_SET_TIME			= EFI_RT_SUPPORTED_SET_TIME,
+	EFI_GET_WAKEUP_TIME		= EFI_RT_SUPPORTED_GET_WAKEUP_TIME,
+	EFI_SET_WAKEUP_TIME		= EFI_RT_SUPPORTED_SET_WAKEUP_TIME,
+	EFI_GET_VARIABLE		= EFI_RT_SUPPORTED_GET_VARIABLE,
+	EFI_GET_NEXT_VARIABLE		= EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME,
+	EFI_SET_VARIABLE		= EFI_RT_SUPPORTED_SET_VARIABLE,
+	EFI_GET_NEXT_HIGH_MONO_COUNT	= EFI_RT_SUPPORTED_GET_NEXT_HIGH_MONOTONIC_COUNT,
+	EFI_RESET_SYSTEM		= EFI_RT_SUPPORTED_RESET_SYSTEM,
+	EFI_UPDATE_CAPSULE		= EFI_RT_SUPPORTED_UPDATE_CAPSULE,
+	EFI_QUERY_CAPSULE_CAPS		= EFI_RT_SUPPORTED_QUERY_CAPSULE_CAPABILITIES,
+	EFI_QUERY_VARIABLE_INFO		= EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO,
 };
 
 /*
-- 
2.35.1

