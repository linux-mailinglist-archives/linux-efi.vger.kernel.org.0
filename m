Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD0B772AB8
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjHGQ2U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjHGQ1y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:27:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5259A1711;
        Mon,  7 Aug 2023 09:27:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB3EF61F1F;
        Mon,  7 Aug 2023 16:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CE0C433CA;
        Mon,  7 Aug 2023 16:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425670;
        bh=/S4KCSV2J8sNlaIOIQwe9xIMj2pJ5zcMXcXITNkBoIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMAMTzPZtrtXo9yX1e4/XadlX0586thsURHf3kbrcKOf61+49rNjM3cpJAXeI8wUB
         SCm28VoZAYd8bpHnBbA4JTI9xWy2rOYyUERxsGXgzCZOYLz4v9EoUuUycOwCdrTDRS
         qxBPd6jzv/jmlqileK3j1YYSpu6EXDoHmvM8LU9HWUrQ+j/Y0pX0laxHN9eyjMvDtB
         fL/4649SsrtMoslX68g2fPiooxmSJWopu4Z16or74OUsaVg3Gu4noXa7m7wzVOnbfR
         Vpq6KewKbWZKN4lq+YBUES0yo+U2mRnaPP7K8+WNzOiIDBZXgZLY0WS6wozCH72ONb
         TX0ittmOV+hSA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 04/23] x86/efistub: Simplify and clean up handover entry code
Date:   Mon,  7 Aug 2023 18:27:01 +0200
Message-Id: <20230807162720.545787-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7453; i=ardb@kernel.org; h=from:subject; bh=/S4KCSV2J8sNlaIOIQwe9xIMj2pJ5zcMXcXITNkBoIY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWitL9SsOD5/XxNP96HHC7i/S57droJ4/74dzy6a9UyJ qn2L2LpKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPZx8LI8EThSmVswE5Lzo1e azTu3/seNYG9KFjyRYHdZp7aerbnmgy/2R9+ndx4pSmv+DTrDJmvZ9Iytl836bHcua/qz3rWEI0 zjAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index f732426d3b483139..e6880208b9a1b90a 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -542,19 +542,11 @@ trampoline_return:
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
index 40a10db2d85e7942..3f3b3edf7a387d7c 100644
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

