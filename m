Return-Path: <linux-efi+bounces-2534-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56475A06449
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 19:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2602188984A
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 18:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0D6200138;
	Wed,  8 Jan 2025 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jix/gzmO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4803F201016
	for <linux-efi@vger.kernel.org>; Wed,  8 Jan 2025 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360567; cv=none; b=CipuvMTfoEMWN5CkKepwiA0CUE9PN92rSTG279/lv4Yum01fiY6uYoPPxNzkehdpO35apLeGWfVzfOZAeQINLrbKnDPhpRy+E3nJObpd6Dv/+DdtOGO6lhAunSMwBeXEuS1ny6rnimlUJSfcJRTGFDV+b3M5Cz305F3f/ybo0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360567; c=relaxed/simple;
	bh=c5n7Z3abIRGd7MR68fFwDHml88PuxivLHK+FOz6bahM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kcVFP7FEBOEG/DElO+Ue5mhAfYACjzb7ZnzT3zbJNiyFFJy9WXdZyPxU6FKYpvXh8cXAoMRSnAOweeGPcz3unA8szYl7zA+EU8v+BglSqOj0/x31l/stqZoOZ8VDslqb1DoJla+df+AaDOXXP2+mzGA1N+0wqerWE8RppoHmewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jix/gzmO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361a8fc3bdso573445e9.2
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2025 10:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736360564; x=1736965364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jijnO+/vwt5TKuw0t4KuJDIurPSMvqe04KWFl33HmU=;
        b=Jix/gzmOF/k5t27gD4BEi1xuaarf/ehlgq2U63/ZO7KOmkwnQar1IlDNk5EXhhiIGW
         3/LzkwjlFMoiV8wGoC1bxJb5dx9BV0FOmcA2ong4H1yp08YhqiF1NpFaqfZTa/0YF3UK
         YcWzBn7/WssfDbCT5nyTpy3cOW9tjOnbqhxfaa9v+y7eNnDMUk+eznuHnIpUTrTb9e5E
         RX+vGpKpaUJxzXqWPkk0wLH4LrRqz/sqULS/6k7Uk7bfQG80zZh4RFzNet17qvAUbzBk
         wLcJ0jC2SWWdEQ6TGc37Jpnzk/Nxc86Ip+XVHBxD8FJM6ydphll4OImPptO2ZeY98MAw
         0lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360564; x=1736965364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jijnO+/vwt5TKuw0t4KuJDIurPSMvqe04KWFl33HmU=;
        b=QFijOD6GKKeCv2/D6qTleH64PtlA3q9VjC7QlHsy8QcRwuKl0ULK16qQ7poWtEz3Ph
         44Cmn5OhP6CDJRlTf4h2YlkFOBN13LdJuHJNa4yBqX4Znfw07uodkxSfd1as5twZbzqn
         Z148Xig/88Q3e7og44mSz4fbfuAFJI70SL36jS9cSdT3XPnxAf6SZo0n9ht7XuJvMzsa
         uRaIbyB4Sn6cH0TbqijZzlp7mng3AIebuYxV0sWtyscWMKZ4iEdPXbj8PV0PHsmLAow3
         R47VEbF97AafcfRLz09FRI7uk8wA54/b89N/gAW+XwKieShtJKHp/az9VWeB13PeadLW
         EghA==
X-Gm-Message-State: AOJu0Yz7zVzChD3/BXZ4Vj1SKj6FVGF9CmKh3ZS2/1fdn404CQGqaFS7
	ZLQ3OrDRPyobJoe1YLXOecx697VnCvC/OTd5N+aaDlUYMYIUaQJl0ghPSR/79u5K5RYQoa1kFQd
	0OewDWgGVTSjZWpyszd1tVE/9F69MvvodNjPfrugEnHQxVv0iymOBCp5rUwNZV47EzX4EZJGSA4
	1J+O0MiKmXINhXPXkaZFFzaGxA4w==
X-Google-Smtp-Source: AGHT+IGsWWOOSsGzdHXgbonkA2unx1gvF35gsxnWe+/5Cdm+oQJdMRSriAFbRZRqPIPuudPDtnoy6aZb
X-Received: from wmbay2.prod.google.com ([2002:a05:600c:1e02:b0:436:e67f:5b4c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3514:b0:434:a367:2bd9
 with SMTP id 5b1f17b1804b1-436e26a607fmr36080415e9.14.1736360564695; Wed, 08
 Jan 2025 10:22:44 -0800 (PST)
Date: Wed,  8 Jan 2025 19:22:20 +0100
In-Reply-To: <20250108182218.1453754-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108182218.1453754-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=ardb@kernel.org;
 h=from:subject; bh=B7tjid52pXcEHwxSjXgczIOJflt5UduLd+Wztt1NSa0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIb3uUAyjgLf3nTpelz3LQjM3n+83rqnRufqn2fT9zkrmW
 5uPO87sKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO5fIaRYWr33fcPJVe15GyZ
 /WCVs6Wq889lpa82B/EpVb9ZwvprYiMjw9/uqDDuchdPRkWZ+uvcTXGGSnc/uCZGzJr8Nn1W2T4 +JgA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108182218.1453754-9-ardb+git@google.com>
Subject: [PATCH 1/6] x86/efi/mixed: Check CPU compatibility without relying on verify_cpu()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, kees@kernel.org, Ard Biesheuvel <ardb@kernel.org>
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
index 876fc6d46a13..067e10eb7897 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -293,24 +293,20 @@ SYM_FUNC_END(efi32_entry)
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
2.47.1.613.gc27f4b7a9f-goog


