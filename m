Return-Path: <linux-efi+bounces-4172-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F30AFB82D
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 18:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D568C1AA2C46
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E72230BEF;
	Mon,  7 Jul 2025 16:01:23 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3D22DA1C;
	Mon,  7 Jul 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904082; cv=none; b=EGrt2gwKSJHnDZGi9fOw1P0pcTxPJM9kthoZ3y03EAPA4A+gdb3E0w/9xUqPFzjUCyPdMOhRg0s0vov+iSK/ErtmOCtQ1rS9Q2c99A3kQLU6tyqqGsfeWJXM2yC0zD13+bZ3GSLWnb7B4QF102YQD+iSPeoNcgk7wxbtdE8Jg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904082; c=relaxed/simple;
	bh=XwtnCAizPM4mNONRdmM+LWN86wthex6fymK/baD6ebY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7b7o8qKeJLHolGSQ3w99KosL4uBL3aeTh9q9HvPi43bvs3mC1guAOtUg/RBVYM+r73O05Rif4WlkvAQALdRzerF4f/KgzGZc0KBizIDq2lU6kITgWrgVw1uUC4KnaV2uqbdaUk8tNRJSrPJtUh8/gA4kNdkswOSJexqFZD9PKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d9e2f85b77so1802885a.2;
        Mon, 07 Jul 2025 09:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904080; x=1752508880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUXQYJBwA1uXvCLtyUP2xQTMFYJ+RrG3hsh4utkJxmY=;
        b=t8ITvL1oezzFKA1SXud64ck7+4ziyzmdAzN8i3cbtJSvxkSZb6+ZL4luku3WqAI+2u
         ErkiY3oU0ksUP/neem+RD4r08MWvRyDk5v0zc35Ql86Mnd60g92ihs4i5VO1WyeLj0uz
         CAYb4EslfHbS6xBOCymJ2puHYrfntB/WKGETPLzIl3ko0xxLrggphu8LcLb8JIDEblhX
         4JyC8dA7OvsMR1VSGfXsMfxIrC6JhDxCRu2Xfr2wyhdX6ifKR4uBSsiebsqVD7aEH5dc
         Tshs8vO+nBXJAS9j/NW5tHTWnEnXBJctU+7Dp4PQqfmvMyEj0LMWPyPT94u0PVDvgini
         7+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXLE65/nPN6CGngEb3lOAryjL6IObegfBVWMM5e5kbmp0cwYXLbLJKVWWUnYj/lewlY7etLgZkBNirkLPGQ@vger.kernel.org, AJvYcCXv4/9tE1eJHin1Tc5tIsrqY5CYE92M1EC8cK3WCSZ+QiV+rIWRQ2uqvWtl/+SH9vTldprlOiYjDg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhofEgGJ2qpPQL+s7MWWIYXM+PoBnm/U2tEpLq4sY4d3IL1wz
	gfW4Kdp1guf6cesNotw0/QRDNP+oMfiZzeSfoB2ZhVQ0XXyvEMlG3muu9IoSDJKX+wI=
X-Gm-Gg: ASbGnctbJSWVt0HiSw720bPxBEBIkrF+5CG9FSyWh8YQP8TRxwwMxkG6su1N+BY319u
	GXunIC3D3UDIXYGkAaX41ADHbQ3dvv8N16c7ULXWeM9370zSuovi6BtEFNopCB25m6t0zTdX2bA
	KGVhT7Rl05qYk+uWpiclTLcJS775vyH750ExfQDU++cxOifWpXajtni/zp9KVW4zG1fkPZnET5i
	SHQVxxjHGwnM5byjE6vZbR58ZdSSeQuhUEYoGAsmNZTHc18rwLUDe6muEvupt6x2m/XgrOxOado
	uuE89nSaA/bfkW/uBR10R2hUNyNvG9jryXeqm1qzCr18auRcMcwh4g==
X-Google-Smtp-Source: AGHT+IEYTHvTkTF6zJvYOnCbSBqGLN3AcGqauqLf5dj2dNagR9TYhmsTSLG+AMquAUaI9gWUZKIT4g==
X-Received: by 2002:a05:620a:40d3:b0:7d5:e3e9:72ef with SMTP id af79cd13be357-7d5ef4e251dmr1463325585a.2.1751904075735;
        Mon, 07 Jul 2025 09:01:15 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:71::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd93f73sm631776185a.4.2025.07.07.09.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:01:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Jul 2025 09:01:07 -0700
Subject: [PATCH 7/8] arm64: remove CONFIG_VMAP_STACK checks from SDEI stack
 handling
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm64_vmap-v1-7-8de98ca0f91c@debian.org>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
In-Reply-To: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-efi@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 leo.yan@arm.com, kernel-team@meta.com, mark.rutland@arm.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=leitao@debian.org;
 h=from:subject:message-id; bh=XwtnCAizPM4mNONRdmM+LWN86wthex6fymK/baD6ebY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoa+9Dn4x8YaJSTfJb7G6Cqhkv+jOC8ONk9zFsQ
 iJ/WqLC2JeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGvvQwAKCRA1o5Of/Hh3
 bdBaD/0WnjGPnhJAL5zph1bBb1N+rPYW83xmPGrHb/uE8ea/eHdf9sjhMixTh4XIS2rWn+BoJIJ
 yrzVYU9b1GCCy7EKVnZR57WdC2QjLYLIy+06DrLmMFP9w/HgXYBNyZlqkgrLySg/0iLeSe5YITF
 ZtoyaK89w3z4ZWgZHxssNnOU+CtqEpWGAdr7ABlGRK+tMTWtX+OWgkXsJ7YlgLusVoCF+Q3BQnM
 0/kceN+nBMjFrTcHcFdR51pHofMZWp52FXcLcME03j8CQPL9v4T29LSXMix2fthIGSt9k7xnQBM
 pRsh5Yl61agtI3jd9uyaIX39pp/T/+XP1pncmXsIISPjH7b0NJ/zK4grwB4pn/EwNHCsNAPCVDx
 OBMC/JXUq37wv3Kh+g33WR5IVJAD0dVIW4gqayr/eZsYfmaN0ZLcJlwfyCz94gbA+FlhSQ3AyMr
 epM20hCAWFByqbyBUdbtztTy1GvCqfkds1S3zU2KRNO9Y2gsLfaoj+6JM1tMxc/xau43Bn9CB2D
 D+pRSiXs4WoXkXdpxN/khuJeTxOAmFRvwSqtLX9uN91LTS3FPLjhubLBMogjtKnxBhCI+P8st2A
 ZnTYEoi0LeqOBkd2WB5VHzThRHEg4nsWc03pJbFqs5oqrHMAUIuRjaKe8ll+6fsTvBztX/qR2YY
 oSuXfvD7AMaGXmQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

With VMAP_STACK now always enabled on arm64, remove all
CONFIG_VMAP_STACK conditionals from SDEI stack allocation and
initialization in arch/arm64/kernel/sdei.c.

This change unconditionally defines the SDEI stack pointers and replaces
runtime checks with BUILD_BUG_ON() assertions, ensuring that the code is
only built when VMAP_STACK is enabled. This simplifies the logic and
reflects the mandatory use of VMAP_STACK for all arm64 kernel builds.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/kernel/sdei.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 255d12f881c2..6f24a0251e18 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -34,10 +34,8 @@ unsigned long sdei_exit_mode;
 DECLARE_PER_CPU(unsigned long *, sdei_stack_normal_ptr);
 DECLARE_PER_CPU(unsigned long *, sdei_stack_critical_ptr);
 
-#ifdef CONFIG_VMAP_STACK
 DEFINE_PER_CPU(unsigned long *, sdei_stack_normal_ptr);
 DEFINE_PER_CPU(unsigned long *, sdei_stack_critical_ptr);
-#endif
 
 DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
 DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
@@ -65,8 +63,7 @@ static void free_sdei_stacks(void)
 {
 	int cpu;
 
-	if (!IS_ENABLED(CONFIG_VMAP_STACK))
-		return;
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
 
 	for_each_possible_cpu(cpu) {
 		_free_sdei_stack(&sdei_stack_normal_ptr, cpu);
@@ -91,8 +88,7 @@ static int init_sdei_stacks(void)
 	int cpu;
 	int err = 0;
 
-	if (!IS_ENABLED(CONFIG_VMAP_STACK))
-		return 0;
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
 
 	for_each_possible_cpu(cpu) {
 		err = _init_sdei_stack(&sdei_stack_normal_ptr, cpu);

-- 
2.47.1


