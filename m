Return-Path: <linux-efi+bounces-4120-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C57AF9309
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 14:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF97C5A2217
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E43928A3F7;
	Fri,  4 Jul 2025 12:47:23 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC62D8DB1;
	Fri,  4 Jul 2025 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633243; cv=none; b=PSmdEO3Mo7klrGbZGeYzho02xLt3oTPSuhZv7y0kJpYm1Wd8GkonD9uVtvdcMMWslU8qgu8MxGQ3r470NBuzwUm/17QliXC8wLH3x0VxLi0cufbcTntt/v+d0vsq0e0lIyYBsowxwaT4aAIY27Z8GbK1T703bQUUTJQnakwmSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633243; c=relaxed/simple;
	bh=nHYuH6tChVt5qIWjfOe/wW/MwpJhNrg5zTlmP7KwkUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jOotGhMTx4IPaxm3aUdkR1bQ5ItkVuOjsbT8x65oXoqfvfmHrHE+T8ZCLOpxX3Z0XVlfyFURp1aICg9f6bYjhHS49QL7aEb6M6jejMvSTcbUUsUy18jsWbSg518Rp3QcXTmlnLoDiyOv9FjvrNFw6LFizhPV+obyALI0yD848Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c79bedc19so1506967a12.3;
        Fri, 04 Jul 2025 05:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633239; x=1752238039;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmBJIHqOp4ler4vBmcjf5ac2fSEeELNLUvkG6S/lhig=;
        b=Vg8B5vlax94Wu7xgk9momQP2SexcNCrihQ9eVcFm3pQf2mSJhhv5uSV2mg0qqnP6Xu
         /Xq2hdCKiw5bGk6vE/uIWt1GR6ZNkzkP1rkym3imgCNRfJVDAzyh4wnEvjjZyErZtfDF
         Jo69LN7cZJD+S5E5rtApxJALi5eZc+thq7mdv9NkRIK3+R8w8CNpORCANnHtiYbyjrPI
         3LFihQz8C6d6DgujuJfB74cjQL1cskE7PcHjzWeiubYGHe63NiHj2eJOPYHMtbzTjYas
         AqmUJUrCxYiYzY+lXyzqU2eKvWZUhGGKsEL+iWSovCpRrdYmnCzXWYhE1ES85GZfrcTM
         0nUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEK+yd40+1qf0fnxNDzqrsOtIr2MUtdJXfU3/lg6FYbzLPau319Z//CNFlyjvM+KJPGiGcknUDJ45kV6tk@vger.kernel.org, AJvYcCW661rovPNYF245zXPRq7iq5ytJ1TnTG6bih+w80X+esMgkfQx2NSraHZcXbZ/VaGZvqWGilam7bFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7jk4tg3IPzkoGoi8ydWVL+mEJaYz1cOhuXlsUlBQ2JV1Kg2Q
	iU+1ZzcdyScEsCcJ0FGqHFLoBPLzhB71GpYHN3Iyb+gkgJObgf7rQmXl
X-Gm-Gg: ASbGncus07JrmRWWTlYUkOnypkv103k7qJfuwzLp46G35Jf5KQIn1HLUb1xdX7bma3R
	W//Ef+504ixOrDZ7zXdNTMF/LACrmX9feJ3uTgsZ6/v0fNMMQbG6/WCCT7fL+Prb5AUI22kOJrD
	Ck3kwVG/hAf8lycDnzaIKBb0Y2zQQv3Yc4RmxbtV5Lay0KQSEuda5DAm1FxPNc5Sy/Er/1MdzaH
	RlWkaawI1+a33guiSbaGKnGb9jYGbZZFfRcaNyDbMFLn8XH2K/+QuE1/jNoNlGZWDvBcAwuCnmo
	GwYyqBTf4DVLCu1o/IicytHK1AXQluClxcesu7X2hmWlYPq6Sr4xzQ==
X-Google-Smtp-Source: AGHT+IGY5NR0TFPMOMBYaRv+wFU/0enDu6wTkrwt9iQwPL63rdfAnrB6Pk0nVOpnxHAZOBwFtJRTog==
X-Received: by 2002:a05:6402:354a:b0:60c:421f:1357 with SMTP id 4fb4d7f45d1cf-60fd30d0fb5mr2017145a12.13.1751633239231;
        Fri, 04 Jul 2025 05:47:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca695d66sm1295796a12.17.2025.07.04.05.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:47:18 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 04 Jul 2025 05:47:07 -0700
Subject: [PATCH v2] arm64: efi: Fix KASAN false positive for EFI runtime
 stack
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-arm_kasan-v2-1-32ebb4fd7607@debian.org>
X-B4-Tracking: v=1; b=H4sIAErNZ2gC/03MSwrDIBAA0KvIrLXopD9c9R4lFI2TZCjVoEVag
 ncvDRS6fYu3QqHMVMCKFTJVLpwiWIFSwDC7OJHiAFYAajzoI3bK5cft7oqLqvMmGNQ0oB5BClg
 yjfzarmsvBcxcnim/t7qar/6W/d9SjTIKDZ01Od+Fk74E8uziLuUJ+tbaB8eBScmjAAAA
X-Change-ID: 20250623-arm_kasan-3b1d120ec20f
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: usamaarif642@gmail.com, Ard Biesheuvel <ardb@kernel.org>, 
 rmikey@meta.com, andreyknvl@gmail.com, kasan-dev@googlegroups.com, 
 linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, leo.yan@arm.com, kernel-team@meta.com, 
 mark.rutland@arm.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078; i=leitao@debian.org;
 h=from:subject:message-id; bh=nHYuH6tChVt5qIWjfOe/wW/MwpJhNrg5zTlmP7KwkUg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZ81VFvHF7PJ6tVUQPcHhUtDROIBPyQcmYm6JZ
 GUZHPerTDKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGfNVQAKCRA1o5Of/Hh3
 bYrbD/98qZZ8aLRXNLcokbh0chd6hghgMJY2Hz9GIVuk8KR71cJ09i9ySDkQqp2H1C61uWz+Eq2
 bD8FgXQTheK9Q29T5Xk6sMWGeE//NWZbj7vIjNyMWRdZODE5U4we0rvzLte8OD+4jLhICAozmIk
 OYkDIvz5tk6E99tkHyNwJ8od3UBRXBgsjuKvLhuuQZNlhtw7qvAjMHo5mKkPMUpuLZ1KBbWbIFx
 b7/bp0LBn05ZwX+ditk6pADUXYhWii2nxsoYqrQV8+q8vCcUgtvPBLBjSAaOcO3TVS6n7KOO2w8
 YKQG1BoHsdugXN6mPUhnCzcb2mVZD5ropVSH0s7p1kHVOiKGCiCQ0+hgJ4S8j5Cs0S1HvXn8bSk
 03j2TgoZUyPUFw9LNqOp0KLsk+Xxu4tCzYqa0EX00Fk7CvLhEVY4ulc+RClJ+c9drHUaJjXTWfn
 3itAPTWWQjVyo47oYEC+gPqWVk2f4xIqMNEdT8JWvCXrzzscqFAwylFhkH5kSEsDWIZ+1jsbg/a
 OlgL99AjUboOO1kCS9TJ6jOh4DWANwUmk7xjxDL0j1EIMlWhd4ecEbz3Q0QV2c80eVpDkcPqFUb
 uV23K5ppxBdzKmtBkcCjHyOzFYDGFjcDHnj9nSYODDAJelUnnDLSFK5RxoGzOhEdY/IxWrfysdJ
 fDr37mZQNUeJAUg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

KASAN reports invalid accesses during arch_stack_walk() for EFI runtime
services due to vmalloc tagging[1]. The EFI runtime stack must be allocated
with KASAN tags reset to avoid false positives.

This patch uses arch_alloc_vmap_stack() instead of __vmalloc_node() for
EFI stack allocation, which internally calls kasan_reset_tag()

The changes ensure EFI runtime stacks are properly sanitized for KASAN
while maintaining functional consistency.

Link: https://lore.kernel.org/all/aFVVEgD0236LdrL6@gmail.com/ [1]
Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Clear the EFI_RUNTIME_SERVICES in efi.flags before returning (Mark/Catalin)
- Link to v1: https://lore.kernel.org/r/20250624-arm_kasan-v1-1-21e80eab3d70@debian.org
---
 arch/arm64/kernel/efi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 3857fd7ee8d46..62230d6dd919c 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -15,6 +15,7 @@
 
 #include <asm/efi.h>
 #include <asm/stacktrace.h>
+#include <asm/vmap_stack.h>
 
 static bool region_is_misaligned(const efi_memory_desc_t *md)
 {
@@ -214,9 +215,13 @@ static int __init arm64_efi_rt_init(void)
 	if (!efi_enabled(EFI_RUNTIME_SERVICES))
 		return 0;
 
-	p = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, GFP_KERNEL,
-			   NUMA_NO_NODE, &&l);
-l:	if (!p) {
+	if (!IS_ENABLED(CONFIG_VMAP_STACK)) {
+		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+		return -ENOMEM;
+	}
+
+	p = arch_alloc_vmap_stack(THREAD_SIZE, NUMA_NO_NODE);
+	if (!p) {
 		pr_warn("Failed to allocate EFI runtime stack\n");
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return -ENOMEM;

---
base-commit: 6b9fd8857b9fc4dd62e7cd300327f0e48dd76642
change-id: 20250623-arm_kasan-3b1d120ec20f

Best regards,
--  
Breno Leitao <leitao@debian.org>


