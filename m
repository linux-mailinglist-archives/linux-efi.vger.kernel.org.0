Return-Path: <linux-efi+bounces-2778-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83DBA2F5D2
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 18:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D8D163DDF
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965C825B666;
	Mon, 10 Feb 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olHAv1Lq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7B2253B0
	for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209808; cv=none; b=tX+XKm5L/wF/AOBCPkGCwnMmUvBsunnJ6Edxu9Tnco4dQN+CIbC2fTdKLASn3ERFFEXkmVJO0CNyIu/LWbKOptzOLLn1HEv8n0XaV+OF3H27f59C9vAvVD9nAOzWORtrQ2Bl2ssIcXGpmJSkfhYy+lEiCiZQQBrDHdU97i0AIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209808; c=relaxed/simple;
	bh=k39SCFeSHAU4CYdRvtTwQK6t3nFmgSLXRcx+MAbvLOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e+27ymyee6ouLSH16r7KTZzmFS/8rydJ57oo6C35Tw9uHR4nvF0hkkfyzoK9jFJ/LYaT7E+0WFcEDgr6y9R8IoRRMYM682kpR19toMv5biuJgE5oS+A/X/RX0O4LMwywc4M/Qj0AmcQzGHE69Yt3CordeAlyOyNzBNqwWbIvDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olHAv1Lq; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38de0923dbaso513406f8f.0
        for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 09:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739209805; x=1739814605; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iCkblRi5eUoBW/pssVZErNimz/PZ82lgWhxEO8/ACJs=;
        b=olHAv1LqbFADvLVY7Cg0xjfw8y2Ced6rA7qzATje48BD4Gay0y3yqTdyBVVibQECX/
         tfDQVFGZEDcTqoiE9Wc/MfdnyIjgb7R5ujm8SJotajv7TgerJD9QUDAwr2l/ReWH4LZh
         7lnaZjld7vrXYicXV4ig9ja77Sho3cc3raT6nJZI6ehi3Rtp1RScZS0It6f9umY9kEgf
         n1nDuXtlD8XusOjlzwefPLjQJNHdO+x428M7Mxge/wiuKWe3r1qCF0uhRKLA6JH4T0o7
         ov1Rq9d0RIu4iunc/gPk1uw1x4GKOVu2xo2zk73w/Ygk3V6DWmuynhzowJVAO3LyDtEp
         H5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209805; x=1739814605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCkblRi5eUoBW/pssVZErNimz/PZ82lgWhxEO8/ACJs=;
        b=WH0YGUFaetX6QaR+osaYGdOpd73nsaf3Kutc2Z/HA3uywwpEN3l5jZlQVOjYacxfXH
         js56tl0dVqmzXE55J/0eIpzlqjjmkW9LaBldFHmT9gymUv95k9MMberaMilX6w9vmVWv
         Gs87GkSDJnW6laQoDsO8b8Figw8g/YLuLhJz90wPCCIVo8ymmcT7Qgm9HoWdtejLhX7j
         btECHlZFj0E3x6pL2magLEG6QXjsYsKgqHYkS2I5cpLZVWCkYPEzY54FPaaO6Sn79fgW
         Bv+tl0M9DPU8wR1C0breSnNYLxs8SEYRpn0tHw/Zv0/b2EHHhj9VZury2yRpwvVwUnS+
         /2XA==
X-Gm-Message-State: AOJu0YxSh55e/BZK0R1Tj1KWcakZI9CAwdsdxHb/jiNnMb0o0hj+62t5
	9hDmzyHGItKA0Lu/lLAXjInxOCRT86O0KeAE3bAqTzDRU+NmnCIaaOuQvstTRfcVQ0OQvLSADPk
	HRt4UNvxjUwi7H+4pBMRdIor+ydRZywwMGuHIUWNeXTlezzb6Cz5BOdiYwniP954qrFcNAnTX5I
	OEKx3ANNa2u7X6pDq/iHLK/sePMA==
X-Google-Smtp-Source: AGHT+IGjAGv3fwkytnbmpQPB16snyWZnYfJ4yOE1arZGK8Mjb1nOZou16lBvQeu9nn0m0EsCa9XRalUK
X-Received: from wmbea15.prod.google.com ([2002:a05:600c:674f:b0:439:38a1:e52])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6d8b:0:b0:38d:e016:a67b
 with SMTP id ffacd0b85a97d-38de41be85fmr538811f8f.39.1739209805125; Mon, 10
 Feb 2025 09:50:05 -0800 (PST)
Date: Mon, 10 Feb 2025 18:49:44 +0100
In-Reply-To: <20250210174941.3251435-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210174941.3251435-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=ardb@kernel.org;
 h=from:subject; bh=/dO898kQXEjoQLrU/9r0JGYqSR+mG5aN2BZaklDsnBo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX2VjbnWyoAsrQP6J67N2Rw7Y9WXn3/+2ortybonx7Hsz
 uI6q73rOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEmK0ZGQ5LvRM+vD75fuSr
 bemFLnbSfk2L3kiyVD4zZGt6l2+zooPhf+1rF0lRRQ+9qsync07mV++Z9+8ab0LYujC5kiXM2uk HWAA=
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210174941.3251435-11-ardb+git@google.com>
Subject: [PATCH v2 2/7] x86/efi/mixed: Check CPU compatibility without relying
 on verify_cpu()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hdegoede@redhat.com, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In order for the EFI mixed mode startup code to be reusable in a context
where the legacy decompressor is not used, replace the call to
verify_cpu() [which performs an elaborate set of checks] with a simple
check against the 'long mode' bit in the appropriate CPUID leaf.

This is reasonable, given that EFI support is implied when booting in
this manner, and so there is no need to consider very old CPUs when
performing this check.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 22 ++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index d681e30c6732..b7886e2591fc 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -279,24 +279,20 @@ SYM_FUNC_END(efi32_entry)
  *			       efi_system_table_32_t *sys_table)
  */
 SYM_FUNC_START(efi32_pe_entry)
-	pushl	%ebp
-	movl	%esp, %ebp
 	pushl	%ebx				// save callee-save registers
-	pushl	%edi
-
-	call	verify_cpu			// check for long mode support
-	testl	%eax, %eax
-	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
-	jnz	2f
 
-	movl	8(%ebp), %ecx			// image_handle
-	movl	12(%ebp), %edx			// sys_table
+	/* Check whether the CPU supports long mode */
+	movl	$0x80000001, %eax		// assume extended info support
+	cpuid
+	btl	$29, %edx			// check long mode bit
+	jnc	1f
+	leal	8(%esp), %esp			// preserve stack alignment
+	movl	(%esp), %ecx			// image_handle
+	movl	4(%esp), %edx			// sys_table
 	jmp	efi32_entry			// pass %ecx, %edx
 						// no other registers remain live
-
-2:	popl	%edi				// restore callee-save registers
+1:	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
 	popl	%ebx
-	leave
 	RET
 SYM_FUNC_END(efi32_pe_entry)
 
-- 
2.48.1.362.g079036d154-goog


