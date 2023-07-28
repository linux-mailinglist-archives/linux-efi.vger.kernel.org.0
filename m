Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D31766879
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 11:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjG1JNe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 05:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjG1JMn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 05:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9633AA3;
        Fri, 28 Jul 2023 02:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B27B62086;
        Fri, 28 Jul 2023 09:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6BAC433CA;
        Fri, 28 Jul 2023 09:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535459;
        bh=c76mFQXkhrkXL5RWLTi0/nzwnTHR2rfGMUFMRsLE2hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NvEZK00vMMJMWOsv9r1BLbQ91zvZ/xzA82G+epScrAXYWb5J6eRnF3UuSrz65NolC
         WEih0jZaiY2ff45vc/my8JBs7ni4sJpJo2RIXQQ1DmNFKaP1W0cJDyoAb8KqYALXgF
         O0RGMKz6D096n27AZiWYadj6y3DraWlVvNifTiX6UtxFNQVhtwsZhE9fLEMhKwO9AC
         dfyEpOd5DJLNd0KlGAN6SHu9MIyWDWLiiknxh2uL4JZEDWvWzOgCgGv1DIALq4L3Hn
         6Op8u8UR9R5hlVFpT0p935Ljm74tnOg4gSkgkZrPgldC53w/UE3fiwBB/IImstPITV
         IfRPT18vhhNzQ==
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v7 04/22] x86/efistub: Simplify and clean up handover entry code
Date:   Fri, 28 Jul 2023 11:08:58 +0200
Message-Id: <20230728090916.1538550-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728090916.1538550-1-ardb@kernel.org>
References: <20230728090916.1538550-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7453; i=ardb@kernel.org; h=from:subject; bh=c76mFQXkhrkXL5RWLTi0/nzwnTHR2rfGMUFMRsLE2hk=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVw6zKXzlzzl/FJcvuLtqz0qtWLZbO4VvdA8HGGjM+Je Wandr/oKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNpWcjIcGcuv47deyW1TNsV TF/Tkg5/njwluPPajibrn2e/vzoptYeRYfLX4tDXdbFnbXZPeTH/2uMCizkbAjxUk75Nc5rjJf0 3jx0A
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

Now that the EFI entry code in assembler is only used by the optional
and deprecated EFI handover protocol, and given that the EFI stub C code
no longer returns to it, most of it can simply be dropped.

While at it, clarify the symbol naming, by merging efi_main() and
efi_stub_entry(), making the latter the shared entry point for all
different boot modes that enter via the EFI stub.

The efi32_stub_entry() and efi64_stub_entry() names are referenced
explicitly by the tooling that populates the setup header, so these must
be retained, but can be emitted as aliases of efi_stub_entry() where
appropriate.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/arch/x86/boot.rst         |  2 +-
 arch/x86/boot/compressed/efi_mixed.S    | 22 +++++++++++---------
 arch/x86/boot/compressed/head_32.S      | 11 ----------
 arch/x86/boot/compressed/head_64.S      | 12 ++---------
 drivers/firmware/efi/libstub/x86-stub.c | 20 ++++++++++++++----
 5 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 33520ecdb37abfda..cdbca15a4fc23833 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -1417,7 +1417,7 @@ execution context provided by the EFI firmware.
 
 The function prototype for the handover entry point looks like this::
 
-    efi_main(void *handle, efi_system_table_t *table, struct boot_params *bp)
+    efi_stub_entry(void *handle, efi_system_table_t *table, struct boot_params *bp)
 
 'handle' is the EFI image handle passed to the boot loader by the EFI
 firmware, 'table' is the EFI system table - these are the first two
diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 4ca70bf93dc0bdcd..dcc562c8f7f35162 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -26,8 +26,8 @@
  * When booting in 64-bit mode on 32-bit EFI firmware, startup_64_mixed_mode()
  * is the first thing that runs after switching to long mode. Depending on
  * whether the EFI handover protocol or the compat entry point was used to
- * enter the kernel, it will either branch to the 64-bit EFI handover
- * entrypoint at offset 0x390 in the image, or to the 64-bit EFI PE/COFF
+ * enter the kernel, it will either branch to the common 64-bit EFI stub
+ * entrypoint efi_stub_entry() directly, or via the 64-bit EFI PE/COFF
  * entrypoint efi_pe_entry(). In the former case, the bootloader must provide a
  * struct bootparams pointer as the third argument, so the presence of such a
  * pointer is used to disambiguate.
@@ -37,21 +37,23 @@
  *  | efi32_pe_entry   |---->|            |            |       +-----------+--+
  *  +------------------+     |            |     +------+----------------+  |
  *                           | startup_32 |---->| startup_64_mixed_mode |  |
- *  +------------------+     |            |     +------+----------------+  V
- *  | efi32_stub_entry |---->|            |            |     +------------------+
- *  +------------------+     +------------+            +---->| efi64_stub_entry |
- *                                                           +-------------+----+
- *                           +------------+     +----------+               |
- *                           | startup_64 |<----| efi_main |<--------------+
- *                           +------------+     +----------+
+ *  +------------------+     |            |     +------+----------------+  |
+ *  | efi32_stub_entry |---->|            |            |                   |
+ *  +------------------+     +------------+            |                   |
+ *                                                     V                   |
+ *                           +------------+     +----------------+         |
+ *                           | startup_64 |<----| efi_stub_entry |<--------+
+ *                           +------------+     +----------------+
  */
 SYM_FUNC_START(startup_64_mixed_mode)
 	lea	efi32_boot_args(%rip), %rdx
 	mov	0(%rdx), %edi
 	mov	4(%rdx), %esi
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 	mov	8(%rdx), %edx		// saved bootparams pointer
 	test	%edx, %edx
-	jnz	efi64_stub_entry
+	jnz	efi_stub_entry
+#endif
 	/*
 	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
 	 * shadow space on the stack even if all arguments are passed in
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 987ae727cf9f0d04..8876ffe30e9a4819 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -150,17 +150,6 @@ SYM_FUNC_START(startup_32)
 	jmp	*%eax
 SYM_FUNC_END(startup_32)
 
-#ifdef CONFIG_EFI_STUB
-SYM_FUNC_START(efi32_stub_entry)
-	add	$0x4, %esp
-	movl	8(%esp), %esi	/* save boot_params pointer */
-	call	efi_main
-	/* efi_main returns the possibly relocated address of startup_32 */
-	jmp	*%eax
-SYM_FUNC_END(efi32_stub_entry)
-SYM_FUNC_ALIAS(efi_stub_entry, efi32_stub_entry)
-#endif
-
 	.text
 SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f7c11a0018477de8..279c2675883c6a0f 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -534,19 +534,11 @@ trampoline_return:
 	jmp	*%rax
 SYM_CODE_END(startup_64)
 
-#ifdef CONFIG_EFI_STUB
-#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+#if IS_ENABLED(CONFIG_EFI_MIXED) && IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL)
 	.org 0x390
-#endif
 SYM_FUNC_START(efi64_stub_entry)
-	and	$~0xf, %rsp			/* realign the stack */
-	movq	%rdx, %rbx			/* save boot_params pointer */
-	call	efi_main
-	movq	%rbx,%rsi
-	leaq	rva(startup_64)(%rax), %rax
-	jmp	*%rax
+	jmp	efi_stub_entry
 SYM_FUNC_END(efi64_stub_entry)
-SYM_FUNC_ALIAS(efi_stub_entry, efi64_stub_entry)
 #endif
 
 	.text
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 09c4210e4ef33864..1180ccd3cd426918 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -817,9 +817,9 @@ static void __noreturn enter_kernel(unsigned long kernel_addr,
  * return.  On failure, it will exit to the firmware via efi_exit() instead of
  * returning.
  */
-asmlinkage unsigned long efi_main(efi_handle_t handle,
-				  efi_system_table_t *sys_table_arg,
-				  struct boot_params *boot_params)
+void __noreturn efi_stub_entry(efi_handle_t handle,
+			       efi_system_table_t *sys_table_arg,
+			       struct boot_params *boot_params)
 {
 	unsigned long bzimage_addr = (unsigned long)startup_32;
 	unsigned long buffer_start, buffer_end;
@@ -964,7 +964,19 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 
 	enter_kernel(bzimage_addr, boot_params);
 fail:
-	efi_err("efi_main() failed!\n");
+	efi_err("efi_stub_entry() failed!\n");
 
 	efi_exit(handle, status);
 }
+
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+#ifndef CONFIG_EFI_MIXED
+extern __alias(efi_stub_entry)
+void efi32_stub_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
+		      struct boot_params *boot_params);
+
+extern __alias(efi_stub_entry)
+void efi64_stub_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
+		      struct boot_params *boot_params);
+#endif
+#endif
-- 
2.39.2

