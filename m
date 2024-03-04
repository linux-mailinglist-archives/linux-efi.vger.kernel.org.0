Return-Path: <linux-efi+bounces-695-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7029870030
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9421C23594
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E63238DF7;
	Mon,  4 Mar 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niYmfPlw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FD38DFC
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551229; cv=none; b=XSBxb3ANLN7PE3tvBNjI98MC9nmm7O4+oIal/tTsWkjBw7rYncZ5jnb5+aKmpf2v0O3wvFCWWLgEpgWMfbxvrmCPoDFIEiPdpB4Gfk2Cxw+pub2+u3+ZWmgB8HcXT/D+iX+8yVzs/NTlzioNnNYnvRVSUXTXzOQcCCV6JSjC6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551229; c=relaxed/simple;
	bh=+droq8Jdwu0zvb41EKZD5kluU85OjZuAdutWJGtuKGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L9V9yuXTCGye6/Nkk7F7KI8WXEOTVaQOzfO3sXf3iCxCTHntgNIcHUKES2Sx2jm/nIkC6For5zcKAusmbUK0pw4lRzxbdY6DXwFb2+X0gXo75m7ECPaZD3x2WgAQilow/dlNyGqejFBZKSIS9DZqIQaxU8/VoE6UzqprilDBUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niYmfPlw; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-412a44c72c1so23695795e9.1
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551226; x=1710156026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PR+FjOeWcopv2jkkhSZLk+LBPXj7PwoORd3Uf+ara+U=;
        b=niYmfPlwvUewrda/qtZ3G8ESILa2y/sNilH17rufl+qOasj4/axh0z7OQrmhL+UyTJ
         iB4s+w21qx8rSmx6IuJCGFFOu7qzGpHiYPI6fIoa4nA+044yPeITymph60mGAS1vD665
         +amAEXOi8MEeaxVQu5FFXiJpsQao7/yNx3T7VjSKNLxWko1cD2Dr2IA8j0oegfQS8zsJ
         O1d+9s/ktUWZ3jxZqupihrDM031VxKHip9tJDj3YSu5LZOG6ozZJ59VZosKg94Bxvl92
         /nh1OWdZvZrHrMeDYu8l6NRtTV4+ksw7G4QK2mIFTezxNjw9oe95mGXttbyHrE/4i0Xi
         OqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551226; x=1710156026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PR+FjOeWcopv2jkkhSZLk+LBPXj7PwoORd3Uf+ara+U=;
        b=WZYsylhSn2/6QYADnII5owlUGDH79fvW5Z6PLpY5F0SoMq2snZDqhDaoj83SJzPpC7
         5MOnb78mL70TV3IHSjo/8QEzLFCSwGNyygFtmlL+4eRjaOQgboCx/0bmYh99S0IPNT1+
         pVNRa7zmEhK/aULC7OeUIqAw60ULZLjtWeNZW7pEd8QzE0hsMSzs8Dp0o5DDxoFkpyVh
         v7uBc5GMc99YqgU65Y52UrdLNet9G204wohFmM2A4Ma0mc1GvjjfxgZlXWQAe1p2Xbm4
         jCC/6xOqgKhMQ7zobj9fqabH/TWzCr52sDA7K51jgQf9hvstWivoV5SjNJXe4SONkhua
         6Opg==
X-Gm-Message-State: AOJu0YzhKcO6KkFUT6XX09qnBH934oid//8TsiRTHtE/q3OGm1Luj54g
	9nd4r4/QjuVduhVimH5dNdBoDAd2DcqXiBlHdPQImcmT0hzkfq8p9ZJnjcBpUnvExvyybA==
X-Google-Smtp-Source: AGHT+IFi7fcyviiqSmmqut53aOvHJ9xWLOwvkc7VB2i86+WjICwKm+EV2IUoMAy5xZeP1NlpnauNNajB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3d8f:b0:412:e8a0:81c6 with SMTP id
 bi15-20020a05600c3d8f00b00412e8a081c6mr2073wmb.4.1709551225941; Mon, 04 Mar
 2024 03:20:25 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:41 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7661; i=ardb@kernel.org;
 h=from:subject; bh=RsUUoeowuevtAraD64hTD4eNkgzf+j6Ug4ZkwgaBM28=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpOt+Pd0Xq9gmtPW3Mc/PlhQ+vvyjM+3JW6qwQ19qfB
 yyaxa+u6ShlYRDjYJAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATMT3K8L9qY0lba1RZFOsz
 KdOzVeeSdxw6eHVez9vzgct2v/7IbCHOyHDxwVTt0KcBx5SLF8W5PlinxuNxaTqrZ0nYzFUxTxt frWYDAA==
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-23-ardb+git@google.com>
Subject: [PATCH stable-v6.1 03/18] x86/efistub: Simplify and clean up handover
 entry code
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit df9215f15206c2a81909ccf60f21d170801dce38 upstream ]

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-5-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/x86/boot.rst              |  2 +-
 arch/x86/boot/compressed/efi_mixed.S    | 22 +++++++++++---------
 arch/x86/boot/compressed/head_32.S      | 11 ----------
 arch/x86/boot/compressed/head_64.S      | 12 ++---------
 drivers/firmware/efi/libstub/x86-stub.c | 20 ++++++++++++++----
 5 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 894a19897005..bac3789f3e8f 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1416,7 +1416,7 @@ execution context provided by the EFI firmware.
 
 The function prototype for the handover entry point looks like this::
 
-    efi_main(void *handle, efi_system_table_t *table, struct boot_params *bp)
+    efi_stub_entry(void *handle, efi_system_table_t *table, struct boot_params *bp)
 
 'handle' is the EFI image handle passed to the boot loader by the EFI
 firmware, 'table' is the EFI system table - these are the first two
diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 8b02e507d3bb..d05f0250bbbc 100644
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
index 987ae727cf9f..8876ffe30e9a 100644
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
index 81458f77131b..b16408f715d7 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -474,19 +474,11 @@ SYM_CODE_START(startup_64)
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
index 9422fddfbc8f..9661d5a5769e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -774,9 +774,9 @@ static void __noreturn enter_kernel(unsigned long kernel_addr,
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
@@ -919,7 +919,19 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 
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
2.44.0.278.ge034bb2e1d-goog


