Return-Path: <linux-efi+bounces-696-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C50870032
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7624C1F23ABF
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E7138FA9;
	Mon,  4 Mar 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wwX68OGS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897A38FBC
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551231; cv=none; b=qeiQmGc/BncDxkJnzPv6H0UsJmM+pHFBg+nLqySuY2N9KIDaNRv3/10BIyJFqJIw8b76bxWbhw2Lu1FXQtLY/a1C7b1z5heORNbBoNk9WxlmLXMp5X64+nqdG9P7eD2kH4jWyE4aci7CgPxsVbTfSm5vbzPMhW+YkLCy0r3ihVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551231; c=relaxed/simple;
	bh=IRtAsKCgqioMV86j/XlQVejXr0chn7Jg2l0INTSDw3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oE2dRsc5YGivjtqaD2k1kQUjZ4DiucqdjWsA5jF36yVttvYSu1qDuTNnuL+mu543pADFlXvnLSFf68S3JU/Av1PWpxrtrL/YaSFLSSBIZbrWCEhBrkh/nHoMyRrPOfBpZY2eyOlW08AFsewwbVFKq4vev+jc4LnAaHOnKm2TkAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wwX68OGS; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-412db67aa46so8553815e9.3
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551228; x=1710156028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpAe7eLU8mDYBt7OVARjKhlYrQq6FvvfNqe6jLhmyJE=;
        b=wwX68OGS2LmEYvWGwNEuude9yiT815Vj1N8qg1d75sIz8BOuWXNEqQ0hMFY2e7YYT8
         b6QUE2u9qDDqAEM+jtBWOrnnnEbv3BSCnR5Lfdr/aRRXZ1T0alXLTARHJQCbce1WzuQo
         TfuADnF9PQsXSZQuD4j7W1GmwVmEw09ercF5oELZHpMRh72xE1/UOuTni1EI4pb7qzZe
         F8rSMBK4rjDRM4zlZHaJIqpRZFScDzcf7QhXaq6imySjjpImlkS6ytb2aMDMHVLi6Mfr
         TcHMY0x5NnIAHskkU1js/8k/iU2COia1gFX/Ent82QbIdx6dabhsGJqc3oTZ7JvuEcwx
         HN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551228; x=1710156028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpAe7eLU8mDYBt7OVARjKhlYrQq6FvvfNqe6jLhmyJE=;
        b=hy5S+S6QjYqbgkF0O4vEcyFpFvsuOavexyS3HlWBFxbnIlwYxpAI3nNw2C6jopk7rC
         f3/+kwKAST2OKNSBwGEaW/gSrKUJyf6pJYIUqmUgo+cfbvOXoTwwpJPzTrT9CiBNKW8Q
         johnQPBa4b9uBWIhGHx42qOL61toO8eMS9cHcAGagP/BMlEltbNqnB4r5fBVULxhK4Zk
         m2XLASo8G56un0mhCTw6NJ57xmOkG8fFgoHMEVLIAUW7ZLSRlkmfiJlnunygvlKRQvdn
         6i9lbcGkeZnnssiEGCEB1nvPcwgs/QcN31y+p0VSY7xGQwdbG0oK4HYHQP93t+cRK00Q
         FMuQ==
X-Gm-Message-State: AOJu0YwD16IKnjJVT/0T5fYKHg9VLfwdEhoYStPesH2baqamPmXThMgC
	G/8P6t+2poqOtd3Tf2Z1OTJCWaLcTwjOnYoldRAUyu4o+ThUK83K+Xt5EI1dzqr87Y9H7w==
X-Google-Smtp-Source: AGHT+IH1C52mIeaLjesQfAvO3S9jAjms5ikKy5xaCHyL/IMF+mQIS6VhBLKclxRnhGlAUkZyyWlisYAt
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:b8e:b0:412:e833:5795 with SMTP id
 fl14-20020a05600c0b8e00b00412e8335795mr4431wmb.1.1709551228063; Mon, 04 Mar
 2024 03:20:28 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:42 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3628; i=ardb@kernel.org;
 h=from:subject; bh=rKgJr0A5pxS9qrIepF6LrLvgYLtlR3KeiChgONo9nD4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpOj+Px8+a3j7wcSv9PmnSbs4S2XOKPj+XnX/3aEvp7
 AjLc/48HaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiXy4wMixYcJRPvFehPWZL
 +Js/TpaTN86+8zf0TuWB2LNOjWUdvUkM/137dz7gVyxmnH5ttfqHbQGdetKNu6XcpDQTqlst/3r c4wQA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-24-ardb+git@google.com>
Subject: [PATCH stable-v6.1 04/18] x86/decompressor: Avoid magic offsets for
 EFI handover entrypoint
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 12792064587623065250069d1df980e2c9ac3e67 upstream ]

The native 32-bit or 64-bit EFI handover protocol entrypoint offset
relative to the respective startup_32/64 address is described in
boot_params as handover_offset, so that the special Linux/x86 aware EFI
loader can find it there.

When mixed mode is enabled, this single field has to describe this
offset for both the 32-bit and 64-bit entrypoints, so their respective
relative offsets have to be identical. Given that startup_32 and
startup_64 are 0x200 bytes apart, and the EFI handover entrypoint
resides at a fixed offset, the 32-bit and 64-bit versions of those
entrypoints must be exactly 0x200 bytes apart as well.

Currently, hard-coded fixed offsets are used to ensure this, but it is
sufficient to emit the 64-bit entrypoint 0x200 bytes after the 32-bit
one, wherever it happens to reside. This allows this code (which is now
EFI mixed mode specific) to be moved into efi_mixed.S and out of the
startup code in head_64.S.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-6-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 20 +++++++++++++++++++-
 arch/x86/boot/compressed/head_64.S   | 18 ------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index d05f0250bbbc..deb36129e3a9 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -146,6 +146,16 @@ SYM_FUNC_START(__efi64_thunk)
 SYM_FUNC_END(__efi64_thunk)
 
 	.code32
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+SYM_FUNC_START(efi32_stub_entry)
+	add	$0x4, %esp		/* Discard return address */
+	popl	%ecx
+	popl	%edx
+	popl	%esi
+	jmp	efi32_entry
+SYM_FUNC_END(efi32_stub_entry)
+#endif
+
 /*
  * EFI service pointer must be in %edi.
  *
@@ -226,7 +236,7 @@ SYM_FUNC_END(efi_enter32)
  * stub may still exit and return to the firmware using the Exit() EFI boot
  * service.]
  */
-SYM_FUNC_START(efi32_entry)
+SYM_FUNC_START_LOCAL(efi32_entry)
 	call	1f
 1:	pop	%ebx
 
@@ -326,6 +336,14 @@ SYM_FUNC_START(efi32_pe_entry)
 	RET
 SYM_FUNC_END(efi32_pe_entry)
 
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+	.org	efi32_stub_entry + 0x200
+	.code64
+SYM_FUNC_START_NOALIGN(efi64_stub_entry)
+	jmp	efi_stub_entry
+SYM_FUNC_END(efi64_stub_entry)
+#endif
+
 	.section ".rodata"
 	/* EFI loaded image protocol GUID */
 	.balign 4
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index b16408f715d7..8bfb01510be4 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -286,17 +286,6 @@ SYM_FUNC_START(startup_32)
 	lret
 SYM_FUNC_END(startup_32)
 
-#if IS_ENABLED(CONFIG_EFI_MIXED) && IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL)
-	.org 0x190
-SYM_FUNC_START(efi32_stub_entry)
-	add	$0x4, %esp		/* Discard return address */
-	popl	%ecx
-	popl	%edx
-	popl	%esi
-	jmp	efi32_entry
-SYM_FUNC_END(efi32_stub_entry)
-#endif
-
 	.code64
 	.org 0x200
 SYM_CODE_START(startup_64)
@@ -474,13 +463,6 @@ SYM_CODE_START(startup_64)
 	jmp	*%rax
 SYM_CODE_END(startup_64)
 
-#if IS_ENABLED(CONFIG_EFI_MIXED) && IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL)
-	.org 0x390
-SYM_FUNC_START(efi64_stub_entry)
-	jmp	efi_stub_entry
-SYM_FUNC_END(efi64_stub_entry)
-#endif
-
 	.text
 SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 
-- 
2.44.0.278.ge034bb2e1d-goog


