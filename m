Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68036FA09A
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjEHHGs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjEHHGC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392DF1CFD0;
        Mon,  8 May 2023 00:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A64261F88;
        Mon,  8 May 2023 07:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCD0C4339C;
        Mon,  8 May 2023 07:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529500;
        bh=cGAUD8iNyl2Jp4BQzqmRm+7QurWozlRhbNmhWh1rRE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=absfKyJLjfGHwejOEeDaiioXiSZMY0rzsRpNFBFNAQWOx4H1Tv/L5PwA9Pkd36Ger
         2xnNBOLrkmdCzT4r9WgZvPg3s/1MDPHkK9puNlgMdkFHlxs/1bpinhKcpBs3EVbH11
         vAKYQODpq1s8IWUoMapM4s9WX9pDfmklMV7FV6GERpAqFBuUwux6pYp+WOJS5+VoSh
         Y1QzfVo+uktl6J3iMaEdh79mH7ymtBga6Ud2WxmJhCJmxREqSIkhGSmBLg1jKwnAof
         I2gwkhoEF0MZT0+eR3GUTsZYjLmDh60Hz3SKy2V0hWjboO1y5EdTtsFIoEUqwkEJBq
         JhNqMxM+wJaiQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 19/20] x86: efistub: Clear BSS in EFI handover protocol entrypoint
Date:   Mon,  8 May 2023 09:03:29 +0200
Message-Id: <20230508070330.582131-20-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3719; i=ardb@kernel.org; h=from:subject; bh=cGAUD8iNyl2Jp4BQzqmRm+7QurWozlRhbNmhWh1rRE4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3kEJLX/JTguLyJS0j8f/LFn797D8j7X6fK2TLOf+e bs69PKbjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR7iuMDC+K319wWrO2uVju 3+XzecsOd5ezMdfNOqJnH/hy60xBO0uG/3mqC/RPJRV0++mZH3m/2GbqLtMQsZnlmmozOdqfX31 7ngEA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The so-called EFI handover protocol is value-add from the distros that
permits a loader to simply copy a PE kernel image into memory and call
an alternative entrypoint that is described by an embedded boot_params
structure.

Most implementations of this protocol do not bother to check the PE
header for minimum alignment, section placement, etc, and therefore also
don't clear the image's BSS, or even allocate enough memory for it.

Allocating more memory on the fly is rather difficult, but let's at
least clear the BSS explicitly when entering in this manner, so that the
decompressor's pseudo-malloc() does not get confused by global variables
that were not zero-initialized correctly.

Note that we shouldn't clear BSS before calling efi_main() if we are not
booting via the handover protocol, but this entrypoint is no longer
shared with the pure EFI entrypoint so we can ignore that case here.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_32.S      |  6 -----
 arch/x86/boot/compressed/head_64.S      |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c | 24 +++++++++++++++++---
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 3f9b80726070a8e7..cd9587fcd5084f22 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -137,12 +137,6 @@ SYM_FUNC_START(startup_32)
 	jmp	*%eax
 SYM_FUNC_END(startup_32)
 
-#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-SYM_FUNC_START(efi32_stub_entry)
-	jmp	efi_main
-SYM_FUNC_END(efi32_stub_entry)
-#endif
-
 	.text
 SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 320e2825ff0b32da..b7599cbbd2ea1136 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -458,7 +458,7 @@ SYM_CODE_END(startup_64)
 	.org 0x390
 SYM_FUNC_START(efi64_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
-	call	efi_main
+	call	efi_handover_entry
 SYM_FUNC_END(efi64_stub_entry)
 #endif
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 59076e16c1ac11ee..0528db3e36cf636b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -891,9 +891,9 @@ static void __noreturn enter_kernel(unsigned long kernel_addr,
  * On success, we jump to the relocated kernel directly and never return.
  * On failure, we exit to the firmware via efi_exit instead of returning.
  */
-asmlinkage void __noreturn efi_main(efi_handle_t handle,
-				    efi_system_table_t *sys_table_arg,
-				    struct boot_params *boot_params)
+static void __noreturn efi_main(efi_handle_t handle,
+				efi_system_table_t *sys_table_arg,
+				struct boot_params *boot_params)
 {
 	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
 	struct setup_header *hdr = &boot_params->hdr;
@@ -1002,3 +1002,21 @@ asmlinkage void __noreturn efi_main(efi_handle_t handle,
 
 	efi_exit(handle, status);
 }
+
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
+			struct boot_params *boot_params)
+{
+	extern char _bss[], _ebss[];
+
+	/* Ensure that BSS is zeroed when booting via the handover protocol */
+	memset(_bss, 0, _ebss - _bss);
+	efi_main(handle, sys_table_arg, boot_params);
+}
+
+#ifdef CONFIG_X86_32
+extern __alias(efi_handover_entry)
+void efi32_stub_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
+		      struct boot_params *boot_params);
+#endif
+#endif
-- 
2.39.2

