Return-Path: <linux-efi+bounces-4169-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC49AFB825
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 18:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5B07AAC97
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CDB22A7F9;
	Mon,  7 Jul 2025 16:01:20 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6922AE7A;
	Mon,  7 Jul 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904080; cv=none; b=IxX34cDC75e9EWaTpZAdfNHwUYMjJMc7ieIoH3SouxtOh/om/0J/p4m+ia7/AoTWyhMEamjhmiBPerTdBodZh8AuGyBck0TXvd024cU6syiS1b4nupKGLU5jRw3YwWK4F0MKiIXfB0w39Poe2nD0fSdBw2KwSALrIL10yTdnOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904080; c=relaxed/simple;
	bh=HEsP6FRhBLVsu5oOeJ6JaIHNIKgCQ3Ji3HXcaP0CFGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wv6bcZSkcCwVsY3GviIFly4Fd+fShDIHr9o0qcKUTrE99wWRpQMTQMyK9xQeLcWkCnxQa0y0bT5XkFzUKGc9wWo+swwGSA8vpx9R1tqYfswbzFtVhyw671RKdrrhHgLktR/Cg5CzoR7SL9xcF6K9sezpqku92ZZMF3g+hX5kgOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-702cbfe860cso28930206d6.1;
        Mon, 07 Jul 2025 09:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904075; x=1752508875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azrhXwwSRqDs6WGR50i+jG0dov5Ufcqav5n6HBzRID8=;
        b=ZYs5a8/hxjDyxOo1TXe5ifQpQ3yueNFnfrycbLBgXHkAoC3P69Zvt+jkgGmvIezYBR
         15l9kacycQIl3sbSkqXf4unvBjRF1ic+Ubff0lV/wA85mPnZm8ec/fKan/oGkX/OALq8
         yYx96CF8Y/nNNYvGw35Eaw/MCVN+jKhEvfoHTZZ4zXQ0EDPU01O019ZrTnIYBRlMabyG
         rbAyWlqFdAoP8QxV5GZKxtpX0JwJaXDpiHmLnLax60bZi9sbyDI1YRXi+hA1PweBZjVU
         pru3unavQ3Buh0bgn32qnXcJo7StMRSmuIYTEWAl37+a2h5v0jkdRABDGUD0p/+zsfq9
         /WZg==
X-Forwarded-Encrypted: i=1; AJvYcCW08o+OjZNUJIr1ObVC8mKr+sHn9OKs9SJdIkrpA4v9ZGHPwMElxhB5dw7fpVSn+ahZNIS/LFsaBO8=@vger.kernel.org, AJvYcCXlotuhnomrk/Arwb1ZckWzJDYfBf9RVxeh+nP4P0yOjhz49naRNhDtjHhzMVJWZDDnClO5HnoF/3s4dm4h@vger.kernel.org
X-Gm-Message-State: AOJu0YzyK4YrqMnGQQWvCEgHTWO5vp1NO9Ehazwqqizuvj5gcYC9A8gw
	UCYXpoCcsHh9SswUliDOHEE55yu9sVKS0idLS81yAv4tFk/CmJ1uiTyP
X-Gm-Gg: ASbGnctcr1y47Ble71tHiceSEyS4edGvKNz+gehOAT5jddcp8loHcgCpx5rmU4kIZKW
	9ofzzxuv//tbeWy+MXaiBN0JICG9HaIcdyNFijZK4BJHJnOu9zxJx7VCrqE+hSHlILRj2GdhjBJ
	h5cvO/w7QPriwYIq711TR7xtfcgtLGofhu85rnDl64UZ38eVSveCmdoMEergWmzKKHIlvzirDsp
	DSm7dvT55q2tJrjufpIt3fyIr7oy8PK+2dWWUdm3yQLMu5JkuJbSGV5tY1AHz8CARFyc331bkai
	uIl3PQ/EC/XD+agBjHWMW026VTg0b1enEcxfqjGzoNLcfJ9hfmcjP+hsKhKjEOk=
X-Google-Smtp-Source: AGHT+IEOlg/bSsDjADvTwJGpi4Y7rLBkSH9ctdKfnIYXL5M/SPU4bB68Er44RJ6wCBK+aQ3iVIv6LQ==
X-Received: by 2002:a05:6214:230f:b0:702:daca:9038 with SMTP id 6a1803df08f44-702daca90d9mr76346856d6.22.1751904074741;
        Mon, 07 Jul 2025 09:01:14 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:1::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5af2esm60892326d6.104.2025.07.07.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:01:14 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Jul 2025 09:01:06 -0700
Subject: [PATCH 6/8] arm64: remove CONFIG_VMAP_STACK checks from stacktrace
 overflow logic
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm64_vmap-v1-6-8de98ca0f91c@debian.org>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
In-Reply-To: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-efi@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 leo.yan@arm.com, kernel-team@meta.com, mark.rutland@arm.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2266; i=leitao@debian.org;
 h=from:subject:message-id; bh=HEsP6FRhBLVsu5oOeJ6JaIHNIKgCQ3Ji3HXcaP0CFGo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoa+9DeToTKZ9P9+l4x99+gzDIF6u9TTjOCkFDY
 Dc8qs14QyWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGvvQwAKCRA1o5Of/Hh3
 bWGAD/wJAeOJY3J6xunWAWqNpO5kw4i663+Pxz8t1QmMI8SVOuASVwr0bVT5JYUpwMg5GXptiiy
 G1NokEQE/VG3X5pPG27SkTY1Q3Eoo1oU14xrk7sVxSQ9J5CnGEupty2+xDRpIeglWJEzmaJVKhR
 uMVldMmluY64L6UJm3e0+44rxUmMM8OW/DsI3+8CfX/xLALlkAOQ03r1JqaisYAtCEu6D0CrLyX
 iZaXIRWyVS6QPrgnEBDkzednMXLfVrrTG6aV+d5dFVWGI3FnIBcAu8PV1mc7r2BxhU+s+FAYA2e
 xxEmeac6GWZR4mcs3VYborzABwVpk4w6Skhttn/kyjH4qpK2wv+fjBLpderLOhDz+1FhFib478c
 a4BeUWhhzpvyxGxLLS9zyeRUpHj1n5LxETvagnWEm4FyeOrD8/C1QV2Z+tCKj02/4cBEHXMJ3zE
 m50pLQH/fuEKSuKM6j3nVm+rrG/sjYYlXgx658uMYdwhEbgzAPchIplLMJ9zw+zcmIFgPvs5HlB
 EnUrD4TeLY/2ukhHHCXUha6E6KqB1mJAbLsj+hacQXvvaXkSly2i16Aow9RlFRPrXeXqBcaAsIE
 3qed4v6QJpmXS/hDIYhxPwUhqObY0wzXWYQyOdXP7ETpwfsHKDo2Fu2eE2YjJTib6PYM/STkRj6
 vpLPlwIGJ9clv5g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

With VMAP_STACK now always enabled on arm64, remove all CONFIG_VMAP_STACK
conditionals from overflow stack handling in stacktrace code.

This change unconditionally defines the per-CPU overflow_stack and
stackinfo_get_overflow() helper in arch/arm64/include/asm/stacktrace.h,
and always includes the overflow stack in the stack_info array in
arch/arm64/kernel/stacktrace.c. Also, drop redundant CONFIG_VMAP_STACK
checks from SDEI stack declarations.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/include/asm/stacktrace.h | 6 +-----
 arch/arm64/kernel/stacktrace.c      | 4 +---
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 66ec8caa6ac0..6d3280932bf5 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -59,7 +59,6 @@ static inline bool on_task_stack(const struct task_struct *tsk,
 
 #define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1))
 
-#ifdef CONFIG_VMAP_STACK
 DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
 
 static inline struct stack_info stackinfo_get_overflow(void)
@@ -72,11 +71,8 @@ static inline struct stack_info stackinfo_get_overflow(void)
 		.high = high,
 	};
 }
-#else
-#define stackinfo_get_overflow()	stackinfo_get_unknown()
-#endif
 
-#if defined(CONFIG_ARM_SDE_INTERFACE) && defined(CONFIG_VMAP_STACK)
+#if defined(CONFIG_ARM_SDE_INTERFACE)
 DECLARE_PER_CPU(unsigned long *, sdei_stack_normal_ptr);
 DECLARE_PER_CPU(unsigned long *, sdei_stack_critical_ptr);
 
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 1d9d51d7627f..e823320fe031 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -332,10 +332,8 @@ kunwind_stack_walk(kunwind_consume_fn consume_state,
 	struct stack_info stacks[] = {
 		stackinfo_get_task(task),
 		STACKINFO_CPU(irq),
-#if defined(CONFIG_VMAP_STACK)
 		STACKINFO_CPU(overflow),
-#endif
-#if defined(CONFIG_VMAP_STACK) && defined(CONFIG_ARM_SDE_INTERFACE)
+#if defined(CONFIG_ARM_SDE_INTERFACE)
 		STACKINFO_SDEI(normal),
 		STACKINFO_SDEI(critical),
 #endif

-- 
2.47.1


