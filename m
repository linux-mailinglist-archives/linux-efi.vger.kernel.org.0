Return-Path: <linux-efi+bounces-4171-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10799AFB82B
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 18:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01591AA17B7
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA122D9E6;
	Mon,  7 Jul 2025 16:01:21 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934CB227B95;
	Mon,  7 Jul 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904081; cv=none; b=PXZ/n42PYaL4R9eRT/KQR4I/lzCjMfzqBJ6IP71JtQSzftD5qW1GCGle976DmJ5LUnANiVvdnrxuZOy6kY5pJtsSDAXk5nnv7b29DdNgVhDg046jcFz28iFeEvMaxVywIltSDJmhRVyqAGg6yZ/GypWthuto+Om2eSPl7CvoH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904081; c=relaxed/simple;
	bh=SpJY3fhXbav7+6i1hQjyLYm6it6IH1zUVNjqCbrE6Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUGifiXL4RmJyxGiLFQ1xOZ/zLaZbBDh0MTYjAKutkw5oD4z8JlgJ4dPaB5TJ0VQdA9Jfy9cgVagE8zqDhI3H4lHM9xb7a0T67pK5RjsQKyFEGXfgaiKI9ZZEeYOP1MAJxM84XGvoqUOSRv+sPNjl3GLvi8e8bkjcLpkEvVhy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73afbe149afso1908806a34.1;
        Mon, 07 Jul 2025 09:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904078; x=1752508878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZyHbcEpIHcb4Jlgq55+r5DAR+ggDwdS7Cd6ZYrxC2k=;
        b=O6kW/pw9JTHKzzvocLZ5MxZb6iiox68R56A6PEYaYtcYjmKkXe69mUeDKogXcarWFZ
         WNX55zO4zf7TOi+QvrDvfAoivIGyNAkVjcUpyU5qFouW8/em//vtITKk608sbWa/L+v+
         VQYsA67sQaVl5cH5LVI3P4DaPkrNJzj5m3dyF9oBdVftFfp2qSkkI0zZvMc4ExNzvASU
         X+MZ9dbR50CWh6J36AHHLtjktrWNKZRXhw7p3qgLjFxu4+TM30SNBrZQcLUT9DvoWTwI
         xr4TFv7zIn3uVQNvSwGvOgPAvOih480zzUxqYFPdaCaUxUBhism7YO3ClRkMhjxgx1+3
         Pl/g==
X-Forwarded-Encrypted: i=1; AJvYcCVUWd89X9HAEWmvHivy99sbo3iiRF5aVe0wMqVQA8xW0Z+zhR3cYBGf0jBa/V3pyzpYTESYMv8lX7Q=@vger.kernel.org, AJvYcCXIkw85GqerWTIkQDfCyM4nPjnMIUzwgCu4ohgVFIUtXKlpdTZfGX/Wswbxa5fl0QfZgWqpodhQjqSLrLke@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt9ywn28QPJ0KJzWyjQY1PAffCjrBofWulySy2cqsxtYkW+gwu
	tUgzMEQDwhmDolHOKONCrqL2IRht7QXgILlvGUIPnqhgVWr2RWqIOwXJ
X-Gm-Gg: ASbGncuZFpENia/EP8fgAnKNVLfYcHyLtZEnuNJhOTMLp7FHkyzza+nTqCKuzlA5z6b
	HMdeHcCH2VLAs5lfywdfgaevy+L6Efs3+j+p3ITw+AXUekGQ8cSFBm3hynTqZxQ42skR2XsYGwq
	KcSDUN295YgI8VHT2SFLXrU4YWk0kZUJBUA1IJXDcgBlJoCKW8uq3cXZayTweGp2JyIwpHn+VDo
	GksRovg3xvZrOXsBggD1MzlzOUHa8OAE+NiM900C/fS0iIdDeRqtYlvqvwqtH9GCelo3AAve4Z0
	AvHRZuuAff2JB4y7BShobk95Dm3uGYi4UX1PwCKObY+Od7b78zHZ
X-Google-Smtp-Source: AGHT+IHt1sjKHYTGHSbsa3LdCzMj703Wfw0OjPmPEUwmP5aO/wwWD1Hxc2s+gXBcRn5ix8Gu2LXRmA==
X-Received: by 2002:a05:6830:6b04:b0:72b:782a:56d7 with SMTP id 46e09a7af769-73ca6745007mr10297544a34.23.1751904076752;
        Mon, 07 Jul 2025 09:01:16 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:2::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a79d83sm65557021cf.39.2025.07.07.09.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:01:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Jul 2025 09:01:08 -0700
Subject: [PATCH 8/8] arm64: remove CONFIG_VMAP_STACK checks from entry code
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm64_vmap-v1-8-8de98ca0f91c@debian.org>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
In-Reply-To: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-efi@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 leo.yan@arm.com, kernel-team@meta.com, mark.rutland@arm.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3002; i=leitao@debian.org;
 h=from:subject:message-id; bh=SpJY3fhXbav7+6i1hQjyLYm6it6IH1zUVNjqCbrE6Do=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoa+9DK2XBJNN33VPVxsbIlAeoiErIg0yYi/CMe
 lbtcKhUf7OJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGvvQwAKCRA1o5Of/Hh3
 baczEACH+7Iy/gS1E569TTC0JPxylOD1BvTxKYcTuK79Epss+CVFf/Ya8UxX5y5+3Cj9I/ifUjK
 IC8Xqa0Es/gvsQITiiALeWarykzD2PX/l1NRUMg4HSYLPrfRkfGgVv5DGw37+11gGXcivx4mORr
 l8mvcTYTFA6baG1/9vNRUEYqNOVEz5YmLIgxGb3Ht1LvgEdu7sEsMl3GywiWXONKRtWrL2iOrUP
 6AAb/F01FmxHgrXuW+KKBuw9nspPxcjwtBTmsc4xES1eD3zfcYNnHLCgR5osr7mxkw61x4PpgLH
 hF5ps2JgWxZWXYd4ep55SvUWSZlx6m21FDNT7hB91xQi0VjLOiAejob1cUuzfXPNIk7EDeRL7FO
 Ofyc3nytJWBpD7BvJ2IFRxBaK7r4dEQmc795w2GlVE4XuczhHeXNHQZMNip9/ZLzs4GaHqqKk5n
 S3MGjT/i1WNlKlEN1NwVP7Qn5MTUnhGyz997u5+71zomYeKObrZxRx8UjGYv4AAvwYDpm4RQGNe
 HqNdIWsouz2uwEW41YMzVN8dog6MYHIhx4WXc74GXa36y4v9ImK8fx1fNvLGkXpVMNz7UesNLA7
 uxKgwLNTVRVZcGvmKdCUIVkR0uxIa/MA4W8hZnWl3rp6If2jTMkg8hrpOP14RyLcBZAFFwqSbXM
 MEJMj0ToT+IrnTw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

With VMAP_STACK now always enabled on arm64, remove all CONFIG_VMAP_STACK
conditionals from entry handling in arch/arm64/kernel/entry-common.c and
arch/arm64/kernel/entry.S.

This change unconditionally includes the bad stack handling and overflow
detection logic, simplifying the code and reflecting the mandatory use of
VMAP_STACK for all arm64 kernel builds.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/kernel/entry-common.c | 2 --
 arch/arm64/kernel/entry.S        | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 7c1970b341b8..99a341ee7131 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -977,7 +977,6 @@ UNHANDLED(el0t, 32, fiq)
 UNHANDLED(el0t, 32, error)
 #endif /* CONFIG_COMPAT */
 
-#ifdef CONFIG_VMAP_STACK
 asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 {
 	unsigned long esr = read_sysreg(esr_el1);
@@ -986,7 +985,6 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 	arm64_enter_nmi(regs);
 	panic_bad_stack(regs, esr, far);
 }
-#endif /* CONFIG_VMAP_STACK */
 
 #ifdef CONFIG_ARM_SDE_INTERFACE
 asmlinkage noinstr unsigned long
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 5ae2a34b50bd..ea74cb7aac5b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -55,7 +55,6 @@
 	.endif
 
 	sub	sp, sp, #PT_REGS_SIZE
-#ifdef CONFIG_VMAP_STACK
 	/*
 	 * Test whether the SP has overflowed, without corrupting a GPR.
 	 * Task and IRQ stacks are aligned so that SP & (1 << THREAD_SHIFT)
@@ -97,7 +96,6 @@
 	/* We were already on the overflow stack. Restore sp/x0 and carry on. */
 	sub	sp, sp, x0
 	mrs	x0, tpidrro_el0
-#endif
 	b	el\el\ht\()_\regsize\()_\label
 .org .Lventry_start\@ + 128	// Did we overflow the ventry slot?
 	.endm
@@ -540,7 +538,6 @@ SYM_CODE_START(vectors)
 	kernel_ventry	0, t, 32, error		// Error 32-bit EL0
 SYM_CODE_END(vectors)
 
-#ifdef CONFIG_VMAP_STACK
 SYM_CODE_START_LOCAL(__bad_stack)
 	/*
 	 * We detected an overflow in kernel_ventry, which switched to the
@@ -568,7 +565,6 @@ SYM_CODE_START_LOCAL(__bad_stack)
 	bl	handle_bad_stack
 	ASM_BUG()
 SYM_CODE_END(__bad_stack)
-#endif /* CONFIG_VMAP_STACK */
 
 
 	.macro entry_handler el:req, ht:req, regsize:req, label:req
@@ -1003,7 +999,6 @@ SYM_CODE_START(__sdei_asm_handler)
 1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
 2:	str	x19, [x5]
 
-#ifdef CONFIG_VMAP_STACK
 	/*
 	 * entry.S may have been using sp as a scratch register, find whether
 	 * this is a normal or critical event and switch to the appropriate
@@ -1016,7 +1011,6 @@ SYM_CODE_START(__sdei_asm_handler)
 2:	mov	x6, #SDEI_STACK_SIZE
 	add	x5, x5, x6
 	mov	sp, x5
-#endif
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 	/* Use a separate shadow call stack for normal and critical events */

-- 
2.47.1


