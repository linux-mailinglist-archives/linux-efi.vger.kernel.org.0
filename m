Return-Path: <linux-efi+bounces-698-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B5870037
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B841F23F9A
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6439AC2;
	Mon,  4 Mar 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LrdA76Dw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173D639AE4
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551235; cv=none; b=aIJeRiZtmFHgHLYhqoMmLRJV5Ro+kXn4W36XVDdOnjopw0j8unSA/ZbzJn1k7Cxt77losR1hg8nLZgviHLDCZcTF3dDECy94YPL4TEuvKEpq8KugHQYhS1ELVSmxJwmbok3+KfBqDRLErjDSHK6iDwPj3IUCvAjnvMuGK3Qgu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551235; c=relaxed/simple;
	bh=I5f5/UK0HxqN58ceYF9AUZMiIxoGygWtkjaXaKdIyKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lt6GWV11TMVtdMVxNRwM7Cll5Op0l+xVUcTSMnGdqBy+wF/5cB6BXFSqKiUiPL2cIVw562DrstQLIZxbTz6z4MeXO/9od3fB5q05mlELCWchIptkPhkwLtS2swj+oRVMu6kwmBBFit8RD4+wGofYi1XPF0LIO506hRkrkr3C4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LrdA76Dw; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33d29de76abso2127016f8f.3
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551232; x=1710156032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8rql2s0QLNWWKq3INYtoN7LFcvaQx1mxgf5kuyohcA=;
        b=LrdA76DwE5Sz9cUBxHICJ87bU0z7msnrb2Ggx9Wwa6DvnVEmoBwrsa8UZnx9ljvVlt
         qeJuCjhgQFfz6t1qYMhVnAv3uyMehnYAMMCGZ8j4TvfFwg2biU3S5sHF+wHSv3glbGCE
         yolC4sBh/IK0He/AtJGMZChF9zYvgojNFJQmyhU7Qthp+2TdGAQt4iVBuXeT/OV81r+H
         IUKMcpLS8GUU3U0CtphqICp/fWqPH97eEnBoR4lUukjCUZ1TOV127//cndCloh/G0Cxa
         +Oi7pxAIU488/fWnKiESjmfZebGZfUePd2jLFkIcGW8eIBAMwgyNBgR9hoVDpfUfSA1W
         Jq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551232; x=1710156032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8rql2s0QLNWWKq3INYtoN7LFcvaQx1mxgf5kuyohcA=;
        b=ooV01ZNEv4OjxxQ2dlNxs6MjAuOnLlB6OuSexPO3/cOV+2qeIgzZX/lkhCzxX261jY
         1kXJ95zb1VwRMsd4a/qnvv3xP1nVzzK+KRMcC+WGtUXFICnWF6jmqGEe+YGXjkBRKpHb
         tAGVTdWW8bUNG9hqM84g1Cj1r1UlRCWQUbU5m7Ca6VX8/QFmClD/WSdWaQRl3XhzkUfo
         4hjEdejOQTCMwBttwJDhdIkH3unVXiZ+yU2ma89bD3lxm7mymx+aXXhsZcehBHCs2Lfs
         hDZ+NBzXOanscUSVBO7YTmqTrUWgL2gb/2NBoudPdj22ZvFvgXcsGFHX86N+qHo1bcSg
         IINg==
X-Gm-Message-State: AOJu0YykVtQozf5vbiKrUaiIKEHJlN8ZMEuRpM2UX+J7Q7enyuskwESM
	mhoup7XndfSeRv3/+x6nRIswYspRzhdrVNNje2wMRCbcWEjUZ0QFlbA3NbwL+UPIcxRkFg==
X-Google-Smtp-Source: AGHT+IFPvvN/eRl2/sPdN88mT9O3xdpe3ZB21qIdbR4DxENWp3cErdhDFWUVwHtx7B7exaTHgMorI5uH
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:f74b:0:b0:33e:42bb:dc83 with SMTP id
 z11-20020adff74b000000b0033e42bbdc83mr1335wrp.6.1709551232415; Mon, 04 Mar
 2024 03:20:32 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:44 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5364; i=ardb@kernel.org;
 h=from:subject; bh=pHaEJ+mAQr4XQr4tmKr4CczlARcwJFRffBM8x5h0oic=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpugA9ufAbvakKrwL8/3RMP161cf9WKbdzb3qn1K2x6
 uA4YfOpo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEykM4CR4dOVpBtTDRb+OqCu
 vtpS7tsuhrvb4osuxK11FXgibvHoYx0jw5QLouVFBZ3BEk0Cspy77zXPuKK/b7uTDFPcrNqlZoI +/AA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-26-ardb+git@google.com>
Subject: [PATCH stable-v6.1 06/18] x86/decompressor: Move global symbol
 references to C code
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 24388292e2d7fae79a0d4183cc91716b851299cf upstream ]

It is no longer necessary to be cautious when referring to global
variables in the position independent decompressor code, now that it is
built using PIE codegen and makes an assertion in the linker script that
no GOT entries exist (which would require adjustment for the actual
runtime load address of the decompressor binary).

This means global variables can be referenced directly from C code,
instead of having to pass their runtime addresses into C routines from
asm code, which needs to happen at each call site. Do so for the code
that will be called directly from the EFI stub after a subsequent patch,
and avoid the need to duplicate this logic a third time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-20-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_32.S |  8 --------
 arch/x86/boot/compressed/head_64.S | 10 ++--------
 arch/x86/boot/compressed/misc.c    | 16 +++++++++-------
 3 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 8876ffe30e9a..3af4a383615b 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -168,13 +168,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
  */
 	/* push arguments for extract_kernel: */
 
-	pushl	output_len@GOTOFF(%ebx)	/* decompressed length, end of relocs */
 	pushl	%ebp			/* output address */
-	pushl	input_len@GOTOFF(%ebx)	/* input_len */
-	leal	input_data@GOTOFF(%ebx), %eax
-	pushl	%eax			/* input_data */
-	leal	boot_heap@GOTOFF(%ebx), %eax
-	pushl	%eax			/* heap area */
 	pushl	%esi			/* real mode pointer */
 	call	extract_kernel		/* returns kernel entry point in %eax */
 	addl	$24, %esp
@@ -202,8 +196,6 @@ SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
  */
 	.bss
 	.balign 4
-boot_heap:
-	.fill BOOT_HEAP_SIZE, 1, 0
 boot_stack:
 	.fill BOOT_STACK_SIZE, 1, 0
 boot_stack_end:
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 8bfb01510be4..9a0d83b4d266 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -485,13 +485,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 /*
  * Do the extraction, and jump to the new kernel..
  */
-	/* pass struct boot_params pointer */
+	/* pass struct boot_params pointer and output target address */
 	movq	%r15, %rdi
-	leaq	boot_heap(%rip), %rsi	/* malloc area for uncompression */
-	leaq	input_data(%rip), %rdx  /* input_data */
-	movl	input_len(%rip), %ecx	/* input_len */
-	movq	%rbp, %r8		/* output target address */
-	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
+	movq	%rbp, %rsi
 	call	extract_kernel		/* returns kernel entry point in %rax */
 
 /*
@@ -649,8 +645,6 @@ SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
  */
 	.bss
 	.balign 4
-SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
-
 SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
 	.balign 16
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 014ff222bf4b..e4e3e49fcc37 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,6 +330,11 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
+
+extern unsigned char input_data[];
+extern unsigned int input_len, output_len;
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -347,14 +352,11 @@ static size_t parse_elf(void *output)
  *             |-------uncompressed kernel image---------|
  *
  */
-asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
-				  unsigned char *input_data,
-				  unsigned long input_len,
-				  unsigned char *output,
-				  unsigned long output_len)
+asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 {
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
+	memptr heap = (memptr)boot_heap;
 	unsigned long needed_size;
 	size_t entry_offset;
 
@@ -412,7 +414,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	 * entries. This ensures the full mapped area is usable RAM
 	 * and doesn't include any reserved areas.
 	 */
-	needed_size = max(output_len, kernel_total_size);
+	needed_size = max_t(unsigned long, output_len, kernel_total_size);
 #ifdef CONFIG_X86_64
 	needed_size = ALIGN(needed_size, MIN_KERNEL_ALIGN);
 #endif
@@ -443,7 +445,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #ifdef CONFIG_X86_64
 	if (heap > 0x3fffffffffffUL)
 		error("Destination address too large");
-	if (virt_addr + max(output_len, kernel_total_size) > KERNEL_IMAGE_SIZE)
+	if (virt_addr + needed_size > KERNEL_IMAGE_SIZE)
 		error("Destination virtual address is beyond the kernel mapping area");
 #else
 	if (heap > ((-__PAGE_OFFSET-(128<<20)-1) & 0x7fffffff))
-- 
2.44.0.278.ge034bb2e1d-goog


