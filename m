Return-Path: <linux-efi+bounces-4168-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72242AFB826
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 18:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBEA189EECA
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF42264A1;
	Mon,  7 Jul 2025 16:01:17 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAE227B95;
	Mon,  7 Jul 2025 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904077; cv=none; b=QG0GYYhIVeudyg/jQBgYWWWzFuY9KFzBbMSKG0cCL8d97AGhTfsW6gC5GRwNoxJ/ji6dN8zBGZRNbiOArCjqnqEp9zRKXwoamIqEFuGQJXaHsqbKqw0XPmMP3DcBwGEjlb7NdY8l5GI/bGnbLi2WVboecUQcpxk80Eb2LTg00Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904077; c=relaxed/simple;
	bh=5drWDc5oXd3AK883ttFmO7WXoIPb6sPR/jXGD0pgwBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nmzk8MorTN5FI/x+hGrbxgE5pQorospCqDLlVYGa73gVjJS4DX9RBBBgZI0uj0suAWA2Wz2SEtx+dvVO5G8Cj2/WzjDkK+7mWUh8wRhri3SlKv33MJHZiFkbhleSSfPSQBlc51KY8TkO8cHb3owYQPS4Ac3yFgR5x0BPlJUmVkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d9e2f85ab4so1280285a.3;
        Mon, 07 Jul 2025 09:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904074; x=1752508874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrgNAnLwRn2xWXBcU7LK5V8pYA0AtM/f/iL+F5YZ9sg=;
        b=hij8gLzReA4N/VM/Lt/RzCv/nLEkyyTLqij/IJGNxmlhQvh6t0/8l2JNe10nzbY2aZ
         kImRWPLVDOB6Jcs3pY/C6oB5V2yKVXEWXULtCEHM8zDhlH6lonaBy9u/YzAG1HeR6tgB
         XZsku0DgBbUm+J6yemsDA/aPkcRe/jwVwP1OM5J1mym57ELO04NVsCFJ7ZPG+tjTO/dy
         +0i0fmN6Eh6Tgcwit5UvvNSsvhrLtxNQqd3c6bzW674UQd8s7miPF6TY4XrPbFJHUBuV
         knyY32uoA+GA+t8Ita1YB0p/FPu86Pwfl6xFUM60663CxM9w+SztGPR5KIbWPqO1KltO
         b7hA==
X-Forwarded-Encrypted: i=1; AJvYcCVYFLA3hNWOZRecVZVaVoVX6/nq1EV6u7RrU3ja/PeFujxz6AZVY7QGVm7g0AybGiiJsQ6hheBoLiA=@vger.kernel.org, AJvYcCXQonFawER/mzDIdlnIvxQZ2l6OzMYD/kNqfdaA7jZPXl1wLWNe9ELWfOCe3Vh1pGZGSIkN6P8kxIBIyk8C@vger.kernel.org
X-Gm-Message-State: AOJu0YyyUiotksGjQjj+wGtnSV1IuWKROjpUO2DYF9JBuf0jR5znTtiq
	E+Jie+shPuAxjz/2uXUuEEeLW6H0h1gH1cKIy8C1r1xulutv8NTX3+NE
X-Gm-Gg: ASbGnct7xkzSiKqFv2ncafz+wqRof8bDTOBeeHvlGTjZLS1QQZYG5MMX1oh9j4119QI
	AmnVrMR6Ulh4/MFS29U+IDudEMKN9FqPzPkiYUGvOO23ddINLqUuTfXC2TYNlic0mWx9ESXya19
	bSLxk3C1wQkfaNGmP125UKtJC0Qb8bFU0GSgl45TJxG5iYa01UZEgPU0DGJ/odV5efh9mkBSLhD
	Kon18R+yyBfj24tSREOtjwLtjcxkZ4jKeAxZdmFikTkcfI2i419CxjisnUgGBQCD3BOfiig9i69
	BupPjjti8xx9VrqMXIbzI7TmC+9eHUjuBQMCTAOhPkk4fyd5dYfm
X-Google-Smtp-Source: AGHT+IE9e54ymrDdjPY1o/eSOv9JmjvznkAlYOITwvMx+iy/OGxMy6N1ow+Ppm+kB1r46MxejqOcEA==
X-Received: by 2002:ad4:5cc2:0:b0:6fa:bbb7:602c with SMTP id 6a1803df08f44-702d16fd78emr129400066d6.29.1751904073666;
        Mon, 07 Jul 2025 09:01:13 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:5::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d51057sm60731306d6.62.2025.07.07.09.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:01:13 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Jul 2025 09:01:05 -0700
Subject: [PATCH 5/8] arm64: remove CONFIG_VMAP_STACK conditionals from
 traps overflow stack
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm64_vmap-v1-5-8de98ca0f91c@debian.org>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
In-Reply-To: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-efi@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 leo.yan@arm.com, kernel-team@meta.com, mark.rutland@arm.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=leitao@debian.org;
 h=from:subject:message-id; bh=5drWDc5oXd3AK883ttFmO7WXoIPb6sPR/jXGD0pgwBE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoa+9Dd1c+Eu7Q8qZ9IT1yzMt5+I30MUlacVUtQ
 d62wO7WMwyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGvvQwAKCRA1o5Of/Hh3
 bQ+jD/4qLHnbTKM2jtnVQQ/KCVDophWXDMw07kz6aF8q32Ugjy/o1fTsiKrH8qTii0iPPAyt7uJ
 MzIXUWZ9Lo+Q799/9XXQrOzJStfroaB9HhHt0cHVA0Lt5Zu63BTbDnT07VKR/JKjrpvKlwBdOfu
 Q50vPIIuGA5NNsvh1VD7/YGNufcreGbl3wboRuY4FA53GK/xJZ4S6yh+YZPP3gW1m1i80kXs3BK
 wfAlihysAA7hKRPmUaSF8NHpJg2XpwVNMs+9T/wLjqd2TPtBnnI39M3rvFRYuz0DXeTON7zHhn4
 76rSbx+uxB2onp1khrvS67w5sS8MUdmpaSmfYI115nMfgTvQ6sl1wWxtVewtPp1p5JBqAC+OsDJ
 t64nsXdYZbw3+QN4e4BQKe1H3/1780Mik0GFcH8tsdnF6FPFuRKRMcu/E2W8C+AKjDD5W1Zh9XB
 8MRfcfM/UuvyikCohm0qQ2GS73+gv1jqKMpA+74bvzc0puANYS2GK4WAL7QgOYNsyVWr4OfVY0a
 51FuJmAYuNxq9e3J5iEC6EVTr/AHX17Ecg2MCo+uUMYhmzqgBOcDS/dMXmYPW7BwbgwO6q5Nacn
 hr8xzIZ+/1kYdwHII1BW2mAeIVZnwnUCo4hKHmX58OQ11z5WWE5VtqrjLFzU8t9VXjllHKMDec7
 X5romVmBxbAi4MA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

With VMAP_STACK now always enabled on arm64, remove the
CONFIG_VMAP_STACK checks from overflow stack definitions and related
code in arch/arm64/kernel/traps.c. The overflow_stack and
panic_bad_stack() logic are now unconditionally included, simplifying
the source and matching the mandatory stack model.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/kernel/traps.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 9bfa5c944379..6acbcffca650 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -894,8 +894,6 @@ void bad_el0_sync(struct pt_regs *regs, int reason, unsigned long esr)
 			      "Bad EL0 synchronous exception");
 }
 
-#ifdef CONFIG_VMAP_STACK
-
 DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
 	__aligned(16);
 
@@ -927,7 +925,6 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
 	nmi_panic(NULL, "kernel stack overflow");
 	cpu_park_loop();
 }
-#endif
 
 void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
 {

-- 
2.47.1


