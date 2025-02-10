Return-Path: <linux-efi+bounces-2780-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90752A2F5D8
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 18:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ABB167EE1
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4A82566E0;
	Mon, 10 Feb 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsqVLuBc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35EC25B67F
	for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209812; cv=none; b=nSthLQyZ+WO+hsWELcjUUz7oLhpgRCSeBEbAXm+l/JBZKQ7uqEqHiSBKSMcZKpMX98NyfIbprTzxAGOuu8UN7N0lJVzcS4Uj9pdNTLK1WNgOKpvqUjhgmXdkRVjxqz6jZPy9SEK14uKk6+PYW1HmmK1ipyFRraDPYhzMTrdxIVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209812; c=relaxed/simple;
	bh=BPQL4qz+CwE1nln0yB0Q+bmvIJrYUTyUpIosm0Fn90c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VZamsijCBejTetmfSVPLJZfGyzBMk4k4JxBDGoOOwUhLYRIulOIhXPsUVaBVG7IxW+pxMJVVQhrZQfOJxLc0CL48J6C+19JT0oncHgSoScvbvMPtStIAcONAjuyEwxvVA+Kb6B3+WtvV8w4fCuqGRpKvmjZ5ZRgUl7dSonVhazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RsqVLuBc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c489babso2096035e9.1
        for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 09:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739209809; x=1739814609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hh74QRVg975Yn36UPeoHsaCV8mpHRm2Eeaz4w9agUgo=;
        b=RsqVLuBc7IqX6fcGeV/HRmBnTxoKGVjpMeInvDVye2necl21pB3zervqzuvl/7bKW5
         7oqqSSNqdCfWx9giZoEZanVgBML6baDVcpfMhySJqjAbHqToNFwjZehKzK48bIQtfp/x
         BNMBuHShvV77m2xYzBOiSahk5HHX/QiMrsvOKkvdQGTP/LJ6apJ/NUTw1Kk63kZbe4a6
         U73NsizCwnM9TYpPCds6iXqcEAOd28Ubv6O/6OQYrSSTsveXpl5FptFx1EWQBiyNRBTq
         cmuEKvGdKJ8tE1od7Kw2EhGrxhjC2fAtefsRnJ67WthYRv1mHxj9zFz1TfYpua4ELGfN
         t9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209809; x=1739814609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hh74QRVg975Yn36UPeoHsaCV8mpHRm2Eeaz4w9agUgo=;
        b=ZqtzsosHYhXO26W17SHyk0hd2YrhF8p9MeU0dP2khHrl19WK2IDII2YpxAjCjiheFr
         OmL0vdGSCeuRGoqkezjyMz0c1aNaEZGg2qDSjvg/WWvPIz26LhtfLxr4ZvoUvh0M+KEi
         GOrM8Gv3HM281dA9WwYtZ83/Awx4OZYzTutYKhSL3rEbPCBkdmxy2pU2oBspkGPp9enn
         mN1hVJz5FHHcKqsUBeaAKLdbGxsDXitxHlBbv9iKHcO3JNH/hLa6oDrXIvTWRcq8lcxn
         QI49Z3geasZ6qef+zsG/X/rQdpcZtUfNRGsTd56CsMPVbzUpCOSYoH0CuKCdutjkARVA
         GN3Q==
X-Gm-Message-State: AOJu0YyClvMJ+/JNKdF0BUm6wwCvChX3M3MbLC8tEA+U/ZvaWmmuDs2O
	VRZ3sHuAbgShavsnVU48G4owODs1ZgBXSRDhUadtqMHWg0gmIpBSFhunMeHRr294J4N3TFpk4cX
	13LcP3Yvl1dAEjg33dIDWVhADQ8MF2YnZkb5Fwy/wF9oFJcNkD0TgI9yQTTTtjNUx/FC2fPRl2l
	rZQkiG4KEqkMDTCVX3q8qjN2GufA==
X-Google-Smtp-Source: AGHT+IFwMpjejKGq4zSaHHg3Yrb1Cdc7Qvm2uJhPIf6PcN5QjlB9F0ngBMiQQbc0uf1hRx6vvOIkMLNn
X-Received: from wmqd12.prod.google.com ([2002:a05:600c:34cc:b0:439:4c05:bc93])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64a1:0:b0:38d:e092:3ced
 with SMTP id ffacd0b85a97d-38de0923ea3mr3197232f8f.7.1739209809182; Mon, 10
 Feb 2025 09:50:09 -0800 (PST)
Date: Mon, 10 Feb 2025 18:49:46 +0100
In-Reply-To: <20250210174941.3251435-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210174941.3251435-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; i=ardb@kernel.org;
 h=from:subject; bh=AQk1Sy/0lsOpbE/ScFnaBLKdmk/x/n9ewr/JrO+BO7s=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX2VjeWXTvGDxVPVgu/MeLw17wVb9c+kU1Ydyf82bHPaa
 JHsXVTeUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyfhrDb3bmt9bHj6TPCmRz
 uu/zYIFm02WF2NUB/O6Tq/vbH2QefMTwv3JVndSc5VzvLr8r2Rh7cOn3AJuHX5w9dk/85S4895l NER8A
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210174941.3251435-13-ardb+git@google.com>
Subject: [PATCH v2 4/7] x86/efi/mixed: Set up 1:1 mapping of lower 4GiB in the stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hdegoede@redhat.com, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In preparation for dropping the dependency on startup_32 entirely in the
next patch, add the code that sets up the 1:1 mapping of the lower 4 GiB
of system RAM to the mixed mode stub.

The reload of CR3 after the long mode switch will be removed in a
subsequent patch, when it is no longer needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 0b6b37b08f82..dca916c3e6f0 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -18,6 +18,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/msr.h>
 #include <asm/page_types.h>
+#include <asm/pgtable_types.h>
 #include <asm/processor-flags.h>
 #include <asm/segment.h>
 #include <asm/setup.h>
@@ -52,6 +53,9 @@ SYM_FUNC_START(startup_64_mixed_mode)
 	mov	0(%rdx), %edi
 	mov	4(%rdx), %esi
 
+	leaq	(pte + 5 * PAGE_SIZE)(%rip), %rax
+	movq	%rax, %cr3		// reload after startup_32
+
 	/* Switch to the firmware's stack */
 	movl	efi32_boot_sp(%rip), %esp
 	andl	$~7, %esp
@@ -267,11 +271,32 @@ SYM_FUNC_START_LOCAL(efi32_entry)
 	movl	$_end - 1b, BP_init_size(%esi)
 	subl	$startup_32 - 1b, BP_init_size(%esi)
 
+	call	1f
+1:	pop	%edi
+
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
 
+	/* Set up 1:1 mapping */
+	leal	(pte - 1b)(%edi), %eax
+	movl	$_PAGE_PRESENT | _PAGE_RW | _PAGE_PSE, %ecx
+	leal	(_PAGE_PRESENT | _PAGE_RW)(%eax), %edx
+2:	movl	%ecx, (%eax)
+	addl	$8, %eax
+	addl	$PMD_SIZE, %ecx
+	jnc	2b
+
+	movl	$PAGE_SIZE, %ecx
+	.irpc	l, 0123
+	movl	%edx, \l * 8(%eax)
+	addl	%ecx, %edx
+	.endr
+	addl	%ecx, %eax
+	movl	%edx, (%eax)
+	movl	%eax, %cr3
+
 	jmp	startup_32
 SYM_FUNC_END(efi32_entry)
 
@@ -322,3 +347,7 @@ SYM_DATA_LOCAL(efi32_boot_ds, .word 0)
 SYM_DATA_LOCAL(efi32_boot_sp, .long 0)
 SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
 SYM_DATA(efi_is64, .byte 1)
+
+	.bss
+	.balign PAGE_SIZE
+SYM_DATA_LOCAL(pte, .fill 6 * PAGE_SIZE, 1, 0)
-- 
2.48.1.362.g079036d154-goog


