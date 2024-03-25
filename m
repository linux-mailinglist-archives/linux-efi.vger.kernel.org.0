Return-Path: <linux-efi+bounces-877-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A212D88A2BF
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 14:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FC41C3898E
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA2560EEB;
	Mon, 25 Mar 2024 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7iDHcSE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC515573C
	for <linux-efi@vger.kernel.org>; Mon, 25 Mar 2024 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355975; cv=none; b=B773CJNLGVzt9IRvur3CJUiz0VqwetttoPzBrKFE9XzX0M0j7eX9VlJM8HWgdcrNofbnrn69JpZv6oCl5Vqw9izqV55ptwhck/Dpt3rt0G3StB4E5r/hOhDZgVDCzfdCjxR9NZQCWFcrSJYizCv9WTR/Ell11uATFuuOLJchrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355975; c=relaxed/simple;
	bh=SGizC3gapS8NfbkM3XOEkDDU5UmnR2/hlqlUWsBHetQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uN7+7q+TCvu8uEBOah9aqC8kjZeMgoKtJgNBOw2VCQGuua6oB54BqhNdC0FdaC3gjpyACHdjNuCW4GERit1NmJXEBK+URhVx0JPB8AQqUff4iaHlbKQlzMEXPgbGaNs3jmA9Yd7Sbo/6V8L4jjXfnRcNLKSTGanG4vt0/YW8Fbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y7iDHcSE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so5076680276.3
        for <linux-efi@vger.kernel.org>; Mon, 25 Mar 2024 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711355972; x=1711960772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2fLR94SR79bSxw8I7/IlKTkcaE2ICrJ5mcsGwDMWWN0=;
        b=Y7iDHcSEkSznvqhgIuCM7khE/BWLfQfbPTwlTHJ4Oew0jy5ikl38jxj2WVVJj9NqoO
         coWA9TewSHTWA77kb1eRj3OiVnig3rg57IGBj3boElrY/GFnOs5hU7dWIM1FZpOsJXLW
         pJTwwI3/UbeUglkig0k/1PNusybj20HX9g9bRFv6g8rx3jM2Pqm63w0nPr+zf7mOdmFj
         dUOJAT8cbLa6uAHOTpnXWbG+aBqoZviamvWr0wNUTmZ+MK9UJ7QOWIkMfib8652vtK/T
         TYX6MVyg2UsDuwJutKwlNw4vialDnkkpaAZetpH/b8P8uRK6CZMB6OMQA8dtWvu/KMUY
         SGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711355972; x=1711960772;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2fLR94SR79bSxw8I7/IlKTkcaE2ICrJ5mcsGwDMWWN0=;
        b=rqmvNRDQFR9uvkJKs12QvQCEIyg4IYQhHMW3JrKxDldfEywWkJvIjtP8bivvSDUvwd
         6calsvX/aIvJWRKEusv/qG6U/qlxLNva5LsInah5X7ERnrYk40YZRc1msj0KKIM7Z7I4
         w5LaD8RsID4babpJ3ECzpe1ncuD8W+a+ZZQ0ZqEQYNI4TdQrGUMaT2tkGm4NybuBBceC
         mfePTwxsEVqkojwtibafVruwQ0vfuKoa8TFdu+hRgTLsXs2TjQZZlCymE9LbvLwDPHoB
         tf6KqxFHwcxctbDuMoI8kiyPptr1cPfxwd0mxAuwaWrN/8MH/hCQGfP9BQIMpLDuVYKP
         pxpg==
X-Gm-Message-State: AOJu0YyTrGLYYyWbOwLa/YXToVF8Nz0Q16HO5Flqytgg1egBby7LuP8V
	x8jMaaUKvSVLCqrO9pb5T693RsniB1UKMYvuIAMfpPceR7We1XEHHaS8rq1b2lbc8QOBXyKVGFV
	kXXVi+NmyWlbGPmHxpF4N0Nb4INAicgPzuDv5Uso1TnPSDoEa9asxeui1f5F2gwxa+9duw9NlRZ
	0+le0W3lp92haX/xWwjMQdZaVGdg==
X-Google-Smtp-Source: AGHT+IFcntcp9truao49sZOMDWg0yE7XtQx1liBUG5f8C29dSBQDwz6Xz3bnst60rixITk9c5cShOf3u
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2488:b0:dc6:ebd4:cca2 with SMTP id
 ds8-20020a056902248800b00dc6ebd4cca2mr251555ybb.11.1711355972614; Mon, 25 Mar
 2024 01:39:32 -0700 (PDT)
Date: Mon, 25 Mar 2024 09:39:06 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5208; i=ardb@kernel.org;
 h=from:subject; bh=/Ny80e491PWjWXrYVfz7/g+6aluKNyVbKBDz8PcwCLA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY3RQktleU+XR21Pb+fJyE/5S1R/z5s03fTrmQWmqTeDt
 oiGFh7oKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOJ72H4zVLEViPwS+TddIHz
 be8+fa76kTqTW7zi05Yp/1sLD2TvvcjwV6wyMDTW4G3YhD3Sv1YufnRwbX9nvsO1aeonncudY+4 c4gQA
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325083905.13163-2-ardb+git@google.com>
Subject: [PATCH] x86/efistub: Add missing boot_params for mixed mode compat entry
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Clayton Craft <clayton@craftyguy.net>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The native EFI stub entry point does not take a struct boot_params from
the boot loader, but creates it from scratch, and populates only the
fields that still have meaning in this context (command line, initrd
base and size, etc)

The original mixed mode implementation used the EFI handover protocol,
where the boot loader (i.e., GRUB) populates a struct boot_params and
passes it to a special EFI entry point that takes the struct boot_params
pointer as the third argument.

When the new mixed mode implementation was introduced, using a special
32-bit PE entrypoint in the 64-bit kernel, it adopted the usual
prototype, and relied on the EFI stub to create the struct boot_params
as usual. This is preferred because it makes the bootloader side much
easier to implement, as it does not need any x86-specific knowledge on
how struct boot_params and struct setup_header are put together.

However, one thing was missed: EFI mixed mode goes through startup_32()
*before* entering the 64-bit EFI stub, which is difficult to avoid given
that 64-bit execution requires page tables, which can only be populated
using 32-bit code, and this piece is what the mixed mode EFI stub relies
on. startup_32() accesses a couple of struct boot_params fields to
decide where to place the page tables.

startup_32() turns out to be quite tolerant to bogus struct boot_params,
given that ESI used to contain junk when entering via the new mixed mode
protocol. Only when commit

  e2ab9eab324c ("x86/boot/compressed: Move 32-bit entrypoint code into .text section")

started to zero ESI explicitly when entering via this boot path, boot
failures started to appear on some systems, presumably ones that unmap
page 0x0 or map it read-only.

The solution is to pass a special, temporary struct boot_params to
startup_32() via ESI, one that is sufficient for getting it to create
the page tables correctly and is discarded right after. This means
setting a minimal alignment of 4k, only to get the statically allocated
page tables line up correctly, and setting init_size to the executable
image size (_end - startup_32). This ensures that the page tables are
covered by the static footprint of the PE image.

Given that EFI boot no longer calls the decompressor and no longer pads
the image to permit the decompressor to execute in place, the same
temporary struct boot_params should be used in the EFI handover protocol
based mixed mode implementation as well, to prevent the page tables from
being placed outside of allocated memory.

Cc: Hans de Goede <hdegoede@redhat.com>
Fixes: e2ab9eab324c ("x86/boot/compressed: Move 32-bit entrypoint code into .text section")
Closes: https://lore.kernel.org/all/20240321150510.GI8211@craftyguy.net/
Reported-by: Clayton Craft <clayton@craftyguy.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 07873f269b7b..c7c108c0bcf0 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -15,10 +15,12 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/asm-offsets.h>
 #include <asm/msr.h>
 #include <asm/page_types.h>
 #include <asm/processor-flags.h>
 #include <asm/segment.h>
+#include <asm/setup.h>
 
 	.code64
 	.text
@@ -155,6 +157,7 @@ SYM_FUNC_END(__efi64_thunk)
 SYM_FUNC_START(efi32_stub_entry)
 	call	1f
 1:	popl	%ecx
+	leal	(efi32_boot_args - 1b)(%ecx), %ebx
 
 	/* Clear BSS */
 	xorl	%eax, %eax
@@ -169,6 +172,7 @@ SYM_FUNC_START(efi32_stub_entry)
 	popl	%ecx
 	popl	%edx
 	popl	%esi
+	movl	%esi, 8(%ebx)
 	jmp	efi32_entry
 SYM_FUNC_END(efi32_stub_entry)
 #endif
@@ -245,8 +249,6 @@ SYM_FUNC_END(efi_enter32)
  *
  * Arguments:	%ecx	image handle
  * 		%edx	EFI system table pointer
- *		%esi	struct bootparams pointer (or NULL when not using
- *			the EFI handover protocol)
  *
  * Since this is the point of no return for ordinary execution, no registers
  * are considered live except for the function parameters. [Note that the EFI
@@ -272,9 +274,18 @@ SYM_FUNC_START_LOCAL(efi32_entry)
 	leal	(efi32_boot_args - 1b)(%ebx), %ebx
 	movl	%ecx, 0(%ebx)
 	movl	%edx, 4(%ebx)
-	movl	%esi, 8(%ebx)
 	movb	$0x0, 12(%ebx)          // efi_is64
 
+	/*
+	 * Allocate some memory for a temporary struct boot_params, which only
+	 * needs the minimal pieces that will get us through startup_32().
+	 */
+	subl	$PARAM_SIZE, %esp
+	movl	%esp, %esi
+	movl	$PAGE_SIZE, BP_kernel_alignment(%esi)
+	movl	$_end - 1b, BP_init_size(%esi)
+	subl	$startup_32 - 1b, BP_init_size(%esi)
+
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -300,8 +311,7 @@ SYM_FUNC_START(efi32_pe_entry)
 
 	movl	8(%ebp), %ecx			// image_handle
 	movl	12(%ebp), %edx			// sys_table
-	xorl	%esi, %esi
-	jmp	efi32_entry			// pass %ecx, %edx, %esi
+	jmp	efi32_entry			// pass %ecx, %edx
 						// no other registers remain live
 
 2:	popl	%edi				// restore callee-save registers
-- 
2.44.0.396.g6e790dbe36-goog


