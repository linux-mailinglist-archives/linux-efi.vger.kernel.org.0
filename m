Return-Path: <linux-efi+bounces-4165-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6647AFB820
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 18:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7CE189E4F9
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807EA226177;
	Mon,  7 Jul 2025 16:01:14 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACCE225409;
	Mon,  7 Jul 2025 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904074; cv=none; b=sWU2/aUjt/dP0fPwKrUs8a509CXXxcIkZSVfBf+ni0222Sv/Be921xULFmrpC3hhjjd1jwi0+pg6+A4gjp8j5R43vYB2DmjBRqWmOiqHgbcEDuxB63bP3K6QmCG04kTRq7VcM8PImjCL5J5Avf/490Qt3CYKnXZjOeCZl+iqIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904074; c=relaxed/simple;
	bh=AWcDwEaXce/sX/AWhtimr7eCGYzpjHt9k/AolPLC7d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVECGOKewp9qVN7KM5aW8/gLWS/2mEWS8OkEe0/d1zpawyQYKwIRI08SeCSjTxi09qZh9MQeWZIwTTxv/g8l3fubwLhSD9GaqWZ54kT/aAJCbqMohBjAVEw+6dri3trWiVWoXHN9ZokFeNNW4zHW1+IC3MUT2QFXIUDnLQVlQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a585dc5f4aso43220741cf.2;
        Mon, 07 Jul 2025 09:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904071; x=1752508871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFSE80Z52FJNEJJjSL/hUkB6ZfO89AG8l158WQvBna0=;
        b=spRJveAIzc//T0y2AT6Nlw4gMhDnELl8P6Ao+faAyzOlFrq9s/YtqFr38SUjXL8+kd
         Cooqd7dFY11eh5WbIoct4fDLYsjxXhpUEkArd03WrM9eYMCDlFnA8AlZduNPBYGgQu1p
         OyA4c+/ebe/LfHi7P7UVLfsNCXPiy/UBuCuujrbdkmmp86cCSPoEvrXshi4VKQXbTktU
         XFlvwYPVl1NC2xKAHUdYFTScI2NypJ1hLjXvpvedHNI3t2qiJ5cikKUJ28U02lXdpK2P
         KZPiGFdo3RdcttfIVDGpwUpaGH5YBmDmnR80Cu4BzQB9I5z/fcb3qVKzynKI3SsFY/KR
         zaLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgaUSt1bvOuR3gB4SRdvSidtO6joYCPWlYi9XPPg75W9q7V1dvLN7+Uy09pMJ+AQ+jsHoQqLqqgD8=@vger.kernel.org, AJvYcCX3YH7pcuDbfPFJtFfdfo2JRAF1LbnYA0mVwOzvC25znHY+cuCxryX+hB2yTzrczYx4OWqn8lhpbODs95iy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8eUcDxA7VCyxwdy94z8jjsDmRq6XwvHVHuTyt71Krf5YJ+ia5
	AWYDyiDgJxelFCSW7F7J83PYFQyYNfMntGbOWhsql5QimtM0c78nCR3/
X-Gm-Gg: ASbGncsz+h0Fm8XBRp+TrxElXs1TGcORaGYNmfL5Thr2rONtlzEQhrPeqffwIDqKXS3
	VJupcsNS4EQEbWrZ8KpXxJi+RY8ERrZ/9gu1nSeqVgQqmSZhsOZvvxmN7SG+Zo/oVDdVyeR7GEO
	o9HOazdPgLBoT2Ff5ue07fiAn+wwmz11EAsVhK21uOUzLlhRennH8/dNVhV5g/oASPeEASjx0DD
	dePWIf6Qs4ZAeGk1AMS09tGuQUhb1f9JR6XJQ9Bm2JY6Tn6U188e7+bAXD4QPLvAFwZcvaf04Fr
	zB2Ddi5558exlqPrFseS37jn+m57NLZfQGP3RpBCo42kQpzACgiOr1hgV0JB91E=
X-Google-Smtp-Source: AGHT+IG2bDjz8U/jivIfo537GoxBEUIliWuiKoH7wAKCcIPUVfYDbgzZkFIFWWe60PAaWYZnb9UavA==
X-Received: by 2002:a05:622a:4e8c:b0:4a4:31c5:fc8a with SMTP id d75a77b69052e-4a9a69abec4mr145687111cf.47.1751904070356;
        Mon, 07 Jul 2025 09:01:10 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:1::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a7a9e9sm65925241cf.50.2025.07.07.09.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:01:09 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Jul 2025 09:01:02 -0700
Subject: [PATCH 2/8] arm64: efi: Remove CONFIG_VMAP_STACK check
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm64_vmap-v1-2-8de98ca0f91c@debian.org>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
In-Reply-To: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-efi@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 leo.yan@arm.com, kernel-team@meta.com, mark.rutland@arm.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=leitao@debian.org;
 h=from:subject:message-id; bh=AWcDwEaXce/sX/AWhtimr7eCGYzpjHt9k/AolPLC7d4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoa+9DX54jFJTcy8xfqR9DrHCzMBCal79scVSM9
 jDCLskwppyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGvvQwAKCRA1o5Of/Hh3
 bax4D/9MnLN2FeTuY4JCgIXmAL/UBGsGnXZX/ppObPSfuS3pvWI9ahzc9cBKO22ZeStDUDZEuml
 zDUmaDcXnzGPLOLo4JTg6FiEsgEvO3RaW8Wv7tiue76uKah5gUO4ROuq2TKYCaunQkHFAQzItcX
 x9xN60cmf/78rROdj0y8Tf/nzLt8p6/X6wJ/Q3VuVWZKsMZNhztyeIysjqK7RH9zZ68jM+g+k/3
 n1UDQaN3GzxO32sOEc+RlOJiMsSiMV/kW1ezYAXovVFo5bGdIihJXhqV2kCjJN5G9deHf9jKFhy
 velPTGXMAGQAPY425E2KE8cN0jLAbdwc7EPzVOuMwLk5SihJJtTzwQ/pUrQZQG0BR9cY6F9wlfp
 qX+mlgpUaLojQ2k4oUSOfe5OsI6XwCmyq+E6EYrveGbOkg2sFYEqoVG836TJSr63eVmNvl686Zu
 ZxOmOQdxki+fDQ54AMDEuBPzWkZVbbIeF+RvXtp41lWgHTp5Vo6423fx0rUdzu8r+xB1wHAnE7d
 tPEve+xhW9vN1NjkDmXl0/Iu4sDyi1Pbi+bqH31qyTxXq84MBehRjTNqZaqHJCR5aiusR7pVUw1
 olDRILYLMTxksa2sVJb3CqBFaAaCJSw1VNmmfZQQSbeyqymtibkezL4hR5CgFleTqUUQu+ye0I9
 fXIf/Na0qPRXruw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Remove the CONFIG_VMAP_STACK check in arm64_efi_rt_init() since
VMAP_STACK is now always enabled on arm64.

The arch_alloc_vmap_stack() call will fail to build if VMAP_STACK
is not set, providing sufficient protection without the explicit
runtime check.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/kernel/efi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 62230d6dd919..6c371b158b99 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -215,11 +215,6 @@ static int __init arm64_efi_rt_init(void)
 	if (!efi_enabled(EFI_RUNTIME_SERVICES))
 		return 0;
 
-	if (!IS_ENABLED(CONFIG_VMAP_STACK)) {
-		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-		return -ENOMEM;
-	}
-
 	p = arch_alloc_vmap_stack(THREAD_SIZE, NUMA_NO_NODE);
 	if (!p) {
 		pr_warn("Failed to allocate EFI runtime stack\n");

-- 
2.47.1


