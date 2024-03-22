Return-Path: <linux-efi+bounces-852-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B259D8870BF
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 17:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69561C225AF
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB793F9FE;
	Fri, 22 Mar 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYDd4VbJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150CB482F3
	for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124283; cv=none; b=dlbu3ktyXa84TFTZthKwNXU78B56eN82E+h/1J1J9H4eHErtog0QFTkglzVT2FZ+cdufBw9zRt2HP2eGoIt0p5j8qVh+US9FJy30Rztk4bJFlXMpJbH1g6vqYuhZbCptecIxsLh9La+9yaqzYunvvbys0anxVKoUyoYAy83d290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124283; c=relaxed/simple;
	bh=KDgSKuf5jsTvODdbosLQnDzjM8pa6OCJZw23Vg3NwQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MsFjljIVteuNlu+03f9lr9MlBHE2AWAODSXMglimXUiiWHpk8fFim9VOnzMB1NFrRgXi0v2kOdG7LuZNdBhh38Kjyb+7Aecfsoyo+3lUarKeRIr7AwnPUMilA8cnZ2wf1uygVtXD2HFplytcfgojV6xUI+Rebhy9ad7qC+EGcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYDd4VbJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ccc3cfa39so34483417b3.2
        for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711124281; x=1711729081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bnQftzsxfuYjCdhXSIw10rBhXkr1xEqK5KDlXaV9zBE=;
        b=lYDd4VbJbfUP5XA+rBkUsVQs9izk3PdZUWLL1VzLMwWx9LAJ2WVmt225aTiyoA4F6T
         F7Xg7XDhD+YyPF7GWoWicfXRxGK3oGu03sYIxxU5+QR10+jAkAtS+xHs27YksZCBkd/c
         R9Up0gX/O6m0pkmGqYL90dXst1A4q9WYj8E3T0uwrgwHvcWI/RwFy70OXsMwm1d/vdM8
         QcKKQ3HHJSP5icVuWP/5VeOCqLMxr4Ds1W9PXde2C9pGoEmWTnpPA9yBO06++x0KouKq
         xFrhe64uFc0ZVnFyUareDVVn8DSxKGiKUqADqBmLgdBtPhgytLQituJL4Ijq9xP/V7mW
         FG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711124281; x=1711729081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnQftzsxfuYjCdhXSIw10rBhXkr1xEqK5KDlXaV9zBE=;
        b=FLGUMTaey+iGi1qWu9FQWvNgIr3Pv0oA0SqMePJNpg6kwRTTDl9cVLp3KvtTOXOjPe
         k5UFVyVt0+uL2Mz2vMySiGWgOVW/t4q3dy1Tez9TWc+8CL5ZCPZf8Lm5mhXrGxiluBHS
         Cl3kk5wXlVPKgzj/v7rEnK7/r++qN5vns1T0VBJcZYiUzFUMfqU90XIesEOoXS7aCytP
         msHVjB27yxUSrjCVVgt+kwn6EYXZn+WBmk7ck4g2caoWKCmBq/GEro6cV/aFIay9eINK
         62CaOwVNrHH2+kJmdmrvFxGGoOoyruycDzenQguqEhVMFf2pQFyzx+UaWO07v/p9y32j
         rDEQ==
X-Gm-Message-State: AOJu0YxHsga3n+BdJ2Kws/V18zWtnoXXAMY+Ht8GX9G2xcsw6VhB2JiW
	TnM2dRfcsWbg6ehyWokfzYP9n7YewLfxEs6msfmLpC288G07F6b+jUg7StOM/2cwmwm+pR2QQSZ
	p9nRDHCfykOPfHgws+UynbhdqOTlEpsUX58XwUaHdhwPFrqirwneHXqTzb3FXg8t8mZOBug0hdV
	+efumBRUIeP/xU4IstnUkOMP47YA==
X-Google-Smtp-Source: AGHT+IH8bNQPE9w9IgOi6tZJGBFASylyELWhmbh1FIC2Y4LDfkiD2LwqdvyQ+4pb5OqSDxAJBlJjrb1W
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1b8d:b0:dcb:b9d7:2760 with SMTP id
 ei13-20020a0569021b8d00b00dcbb9d72760mr790731ybb.13.1711124280944; Fri, 22
 Mar 2024 09:18:00 -0700 (PDT)
Date: Fri, 22 Mar 2024 17:17:53 +0100
In-Reply-To: <20240322161751.3046943-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322161751.3046943-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2941; i=ardb@kernel.org;
 h=from:subject; bh=+b7B6W3cE7froQr7wlC6YEOPK254Pa6C+qhwajlp0aA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXvesMdmetK/yzpf7DWTf+f/sm8HW8yHoec9Zhe7vCmM
 DQw6eH7jlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRSG9Ghp3LN7FvkFQ/klfg
 LTbz35SgHW1FOxkTikOcdzTpTta4+ZHhf4HVT4WLvfKnjwpKXnsSH2grV6gUeOS6XVvWwRNntmR uYgAA
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322161751.3046943-5-ardb+git@google.com>
Subject: [PATCH 1/2] x86/efistub: Call mixed mode boot services on the
 firmware's stack
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Clayton Craft <clayton@craftyguy.net>, 
	stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Normally, the EFI stub calls into the EFI boot services using the stack
that was live when the stub was entered. According to the UEFI spec,
this stack needs to be at least 128k in size - this might seem large but
all asynchronous processing and event handling in EFI runs from the same
stack and so quite a lot of space may be used in practice.

In mixed mode, the situation is a bit different: the bootloader calls
the 32-bit EFI stub entry point, which calls the decompressor's 32-bit
entry point, where the boot stack is set up, using a fixed allocation
of 16k. This stack is still in use when the EFI stub is started in
64-bit mode, and so all calls back into the EFI firmware will be using
the decompressor's limited boot stack.

Due to the placement of the boot stack right after the boot heap, any
stack overruns have gone unnoticed. However, commit

  5c4feadb0011983b ("x86/decompressor: Move global symbol references to C code")

moved the definition of the boot heap into C code, and now the boot
stack is placed right at the base of BSS, where any overruns will
corrupt the end of the .data section.

While it would be possible to work around this by increasing the size of
the boot stack, doing so would affect all x86 systems, and mixed mode
systems are a tiny (and shrinking) fraction of the x86 installed base.

So instead, record the firmware stack pointer value when entering from
the 32-bit firmware, and switch to this stack every time a EFI boot
service call is made.

Cc: <stable@kernel.org> # v6.1+
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index f4e22ef774ab..c21afc9c84f1 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -83,6 +83,10 @@ SYM_FUNC_START(__efi64_thunk)
 	movq	0x38(%rsp), %rbx
 	movq	0x40(%rsp), %rax
 
+	/* Switch to the firmware's stack */
+	movq	%rsp, %r11
+	movl	efi32_boot_sp(%rip), %esp
+
 	/*
 	 * Convert x86-64 ABI params to i386 ABI
 	 */
@@ -120,7 +124,7 @@ SYM_FUNC_START(__efi64_thunk)
 	pushq	%rax
 	lretq
 
-1:	addq	$64, %rsp
+1:	movq	%r11, %rsp
 	movq	%rdi, %rax
 
 	pop	%rbx
@@ -254,6 +258,9 @@ SYM_FUNC_START_LOCAL(efi32_entry)
 	/* Store firmware IDT descriptor */
 	sidtl	(efi32_boot_idt - 1b)(%ebx)
 
+	/* Store firmware stack pointer */
+	movl	%esp, (efi32_boot_sp - 1b)(%ebx)
+
 	/* Store boot arguments */
 	leal	(efi32_boot_args - 1b)(%ebx), %ebx
 	movl	%ecx, 0(%ebx)
@@ -318,5 +325,6 @@ SYM_DATA_END(efi32_boot_idt)
 
 SYM_DATA_LOCAL(efi32_boot_cs, .word 0)
 SYM_DATA_LOCAL(efi32_boot_ds, .word 0)
+SYM_DATA_LOCAL(efi32_boot_sp, .long 0)
 SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
 SYM_DATA(efi_is64, .byte 1)
-- 
2.44.0.396.g6e790dbe36-goog


