Return-Path: <linux-efi+bounces-3954-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1023EAE65AA
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 14:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC23D3A4B0D
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9E28D8CA;
	Tue, 24 Jun 2025 12:56:11 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EA28A411;
	Tue, 24 Jun 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769771; cv=none; b=Zaa6V7lBBnrTN8cqI+yLC4hQuzwV9I4N3jY2r/ImuUshqGU7O7w1L8hm78eTeYxqTqmfqy0zhilzdvr+vOfjCvbIt7qHApWy22qbtNbhZU7sMBUDsGREi/7sU669xiCqakk4KuvlNDaFRMJXjCfJ+Pe+8kVrJun41vddKUcCpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769771; c=relaxed/simple;
	bh=cuqvs4eld47kMpQxlX4a66Aj/+sUNQEviegQV4TglH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pcPVUryzkg5SO6M2rkWgXGk9jizgcZNoD5BQYyisbNhfzgDFxGr+liI9QMfDx0o3nRomlMoHGji4Bd6SXb8mu8zAfliO9f39+Ulu1TS3BUyq9Kx+7m5SHsYUrlX5ibp8ZiEBUPKTEcLLp0VTJxoUTSJ8VkNCqiWmgOePa68BRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo10058385a12.3;
        Tue, 24 Jun 2025 05:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750769768; x=1751374568;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wd5pQO4TMLiiStgKcNv1qG91igXzuOqB+CW/7l3oonI=;
        b=Ch9MZruaJ3dAxp4itG0UoyWr3bvraXXh9+zfMNq0nmZ3EqTadHQSzqHJKV1N/id/v1
         dH/GN6JwzwzQUSmHGd2coZzlb3wqa5/G0RMLdbGdoKOyYBz77/oK1cuMdf7mc0gXkQGX
         J28Hii028WXSWbIrXF901qSNiac3fV1HjjAKKTWbL9FAYkyi70E6AVhfzt2pwpzZKFOy
         IHMT/tTkaN0zXFqrhrBgwtBPnkiGP7pwuCVYek8Ethf0NnyPXD3cP2IW79/cW7lLtGbD
         h/CIUlKZk+1E9xPkIaQTYeaw5f0LPqusMzzGTIwZqVD1wtuDabBaXNL4IDR4/eZ29MLU
         upoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlZCayaBch+dsPk5tArnz0XrsGfEXaJbchc1QBRnQ9FGMIMEP01JaIpDrofyiroQtAFllE2mFkYAo=@vger.kernel.org, AJvYcCWtMyMHY1e7YIT8cFxaf3XPuUi5fetb14nNYkF5GDXULvOroQKHKD8ks5CXPkfAWU0Wf30dh96kJQejm2vQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw518+o/nox7Tg1YyE3G8roKPdcevOmGuAdKYuXvQit7VJTsnlD
	z4gUrJ0BvyjbGq9e1d6yEpAcBbdt3q6OLL0aw6yMnfmC5O3L8ikcoxQ/
X-Gm-Gg: ASbGncs5fRoxPek4Y6zEBX/XuKBGwVoeGFteIgUYypRpuoHqXMVprFgV5yFfBICBnWt
	WonvVHpPLEzLIq1HfJ5vaG0kL0v9YhzhtUBAbOSfszTlinuiwzUsQwAgCOreCVzdS+tPHAy134M
	un3T3Kq3UtuiO1wRTP2lJDNnx9BDe0+omCsEn0oSk6bUciK2+Vp+hVkOclvp9ioyKm+QupppHML
	I0lulpRCcxjx0tCfP6DF+PwkLaq8nl6RdZiTwscJA8JmY7H1J4YcriYGLD2aKUTFrRKaQBd2Rl0
	jBx9UvWvXbBudrX+AXphU8mgOVF4YcE/C9aK3bXTb55twIVuHcXt
X-Google-Smtp-Source: AGHT+IFQFiDas2wGVOeEugta8Qce/28uCIIlkNQljybIhHbXyMiUBS5KHiP7ubJnsUoLTyQUFBS21w==
X-Received: by 2002:a17:907:1c95:b0:adb:449c:7621 with SMTP id a640c23a62f3a-ae057c0f672mr1747686066b.29.1750769767663;
        Tue, 24 Jun 2025 05:56:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ee4e32sm887089266b.57.2025.06.24.05.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 05:56:07 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 24 Jun 2025 05:55:53 -0700
Subject: [PATCH] arm64: efi: Fix KASAN false positive for EFI runtime stack
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-arm_kasan-v1-1-21e80eab3d70@debian.org>
X-B4-Tracking: v=1; b=H4sIAFigWmgC/x3MUQqAIBAFwKss7ztBV+rDq0SE1VZLZKEQQXT3o
 DnAPCiSVQoCPchyadEjIZCrCOMa0yJGJwQCW65tw97EvPdbLDEZP7jJsZWR7YyKcGaZ9f6vtnv
 fD9I++rpbAAAA
X-Change-ID: 20250623-arm_kasan-3b1d120ec20f
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: usamaarif642@gmail.com, Ard Biesheuvel <ardb@kernel.org>, 
 rmikey@meta.com, andreyknvl@gmail.com, kasan-dev@googlegroups.com, 
 linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1774; i=leitao@debian.org;
 h=from:subject:message-id; bh=cuqvs4eld47kMpQxlX4a66Aj/+sUNQEviegQV4TglH0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoWqBmoaEGY0Co/p8xMQtpfpmgTuCHGkMlV+q1t
 BKsgyWtbl+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFqgZgAKCRA1o5Of/Hh3
 bdsaEACmyscWIr3t0MIMFNGraHzVh9hvWTV6na3q1m1afnri47yEjl/+kME4vBNnvroir2ynG0o
 Y43r5iaBwxaB+URpN5iCHcqktnhCX+w9qeN5okvTo5geVnjQrgFpSugkrStqVd3XUXJZWecP1H5
 sVhm16coRcXJSbz6rOjRtVwqNzBpxQ/fYZgOl9II7k+0zFaozXqkQ29462BozXBcp5R/eFu4Qo8
 qNQUC8tsSoqRnpM6vDagP2r5evpSs0bLwTVOjGCBE4zKepqG/4j9RHr2McXgcvb5VNVZI1OlG1j
 BFLL1ktHmWDk6ZrupaSsyzAh3OX/5cdUV8T5aBmfwm5/sJyjEwfgIfXVX9M7Hp+O7rylnmmlxg7
 CcSVzlO17MxtNxxMnSEVLNl41jg6F8fLfeAp6CG0g/N3B0bkzhvdGY6MfuxTSluItEWXtvngiNC
 1VFdvFY5DmwguLAjouudsLTWjc2wOqPcbykPU1VKnXsWnBcJHk4YkyPKhSD2Qc7ekZw6R/vwzVR
 7PGD67q7uND0Cw0I2De5hyNwzlVZwGoDqpdcOF4B9aUF6K3isQGWvvCub/2UXA4WmErmJAeb8Z/
 XikwCGchi6d+NARnAxUtFoPQU+7bhUk2tkfoZFui0qvjOKWPmW4D+lOYzBANctlEbPhz6Y4iAl9
 1cEzMc/LXEis8Sg==
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
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/kernel/efi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 3857fd7ee8d46..d2af881a48290 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -15,6 +15,7 @@
 
 #include <asm/efi.h>
 #include <asm/stacktrace.h>
+#include <asm/vmap_stack.h>
 
 static bool region_is_misaligned(const efi_memory_desc_t *md)
 {
@@ -214,9 +215,11 @@ static int __init arm64_efi_rt_init(void)
 	if (!efi_enabled(EFI_RUNTIME_SERVICES))
 		return 0;
 
-	p = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, GFP_KERNEL,
-			   NUMA_NO_NODE, &&l);
-l:	if (!p) {
+	if (!IS_ENABLED(CONFIG_VMAP_STACK))
+		return -ENOMEM;
+
+	p = arch_alloc_vmap_stack(THREAD_SIZE, NUMA_NO_NODE);
+	if (!p) {
 		pr_warn("Failed to allocate EFI runtime stack\n");
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return -ENOMEM;

---
base-commit: a3e9ee4ad433efad9c172d5fcf63ff39b61c902f
change-id: 20250623-arm_kasan-3b1d120ec20f

Best regards,
--  
Breno Leitao <leitao@debian.org>


