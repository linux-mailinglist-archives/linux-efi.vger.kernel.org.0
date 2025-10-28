Return-Path: <linux-efi+bounces-5193-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CCFC1445E
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 12:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 379F0568BF2
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409C3054F9;
	Tue, 28 Oct 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1pl2zV3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC5306B1A
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649058; cv=none; b=nC5EDQVLaJRl1yuhuw1zCMY/NTz3Sm/0wtM8IwPsmT7Ud8aZrCOJ618BpyTT9m+EVBfOh0OtqAldkvHAoNZSq7+GOWFmsgjQp0mhMQ/NkO/WUqRq62kXW65hXiAZIIG9JGJNMKpc/7reB7pFPP5FMoz4TIO7iWGUwfG5cSh4hZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649058; c=relaxed/simple;
	bh=1KqnUup5Uvt5Yo1XNIDIiQ1bv9k1F2hZl1gBY/MMm2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvZkeLgaOvZ/ztwZlDB19DEW/yzBMVIf9ok0jg566pJLtNed9egP+TgJOJv7t3vrgHlslcxH0q7tMn/iU5bNY31LmfGeLzsm2a0hvqE4khQlwFFEzVyV5v35Gs/gQVY1eVSXaE6r+yiHPwjEFqmGItCvqyhigNbuJXHzMs/P10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1pl2zV3; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f5c80eebdso2434530d50.0
        for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761649056; x=1762253856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ35wOcr7F7ww0bBd5XJ/JWerNufHMcq0vPwHXh1FHM=;
        b=k1pl2zV3LSQuVho0xVx+i4kjdKZbGuCGRJmv4Y3a8fp/vz8lHa6f7hPpOsHxWb+MlU
         078Cy17C7nZ/v5B1RlcWT42uVYOAToz3hAPOGPJBnSCmRozXb0vbvWiMyNp+MathsW2t
         hJ2cw2Xp7wqXqRB7s/Sdzeep+8J+ZfZZ+GDLGnLNxPm1HoTMzPOZLnnqpQyXnnexLa5k
         FsGexJV313+rYAJxOWlazQPI4k9aqTjIgVF2U/B/GYRPfMdUiIsy/oEblR9VPBmbErbC
         wAYesK1AW2rWQ9OZVH3FtBDbJHNT93sfX8Kd+cK+VlbKlK1DP6Y8cD98FO+15kjakrPu
         tD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761649056; x=1762253856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJ35wOcr7F7ww0bBd5XJ/JWerNufHMcq0vPwHXh1FHM=;
        b=TxOX2COgbCHPlCpGR+Yrc+00bh6TkXUAVjJ4aSUqsdRAhR2z3/d+Csi/0IlSZ0rI1U
         Z3oZZ8SsKnhtyoZr3hDrcBcy07MS8NHOlm5ZeKHWY/ly2HJkHK+qLFWLThXCAqWVYOnz
         3rkfNJqb0nTDnTNmq18muTwt7D1xYeUAilVAVFOv6qnwgH9rsiG5wihp3ZWH1GvdEqaK
         PrClp/Sy7B9sZdBrjepvOUBIPW0nCqe6tJiwqKXQrJ2XPffk31tOtPtYiv/5ifTt7+DK
         Gww4dK04UgBzRhTNbhCbEMF2s+YUVOXDlqXBXRYItqMojsFhtcGLOIisvAmFwBZ2yvCH
         oOmg==
X-Forwarded-Encrypted: i=1; AJvYcCWZwAcaHEk095XvXtJ9HajsVs/08mtI5X0jYcVncqSA97ttuNDM265VSYDSGF/ecqN4vrGRM6ngEyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeuJM3pxs8TxFyNd+AMKGFIKL9UW/q3JSgiA87kbbP2RmsZMF6
	3PL9z9A+CF07J6aJCz9YPEmPDTQiJ//BLYRROzZAt/k/hun2ty41GtBW
X-Gm-Gg: ASbGncvo/j6YAjJbrlCirv8/EQsjkt34iYZwCLHRgccbCGqTmZYvCYQ7pDRqaETCBtD
	sEEzRpA8pKEMhDXMAP8kK2LQdy5iJst7Z+VUbPn+ibIrAvpYGWvqM4NkYjHb1YKUkbiNHvvFNgV
	PyS/slprwlCTeOcBDTEHkf9IHQMP+EYK1KPKuW7wbIf9yr01prHawjrOblKvDdIyGpYHf0VlEcO
	UzcbeG2BfMFV2QaA0/pgrXXz7e7b2iq9uSumGVYdhEPt16KMsrcnpNLhORFvxD9QeGNV5SntiLR
	DVIx3OpTBegPArLKKIKiHJdq/XELAwDz0526PZ77Azu/S5WnwKENc5eWFFEj3kjrKlfPBZXpDy9
	BQLpDc7znKAxn/1y6W6bwUVc007/CbMC2NB6GI/9/5+ZfTeHLQwoCDbEss5aYmm1oeziQl9Wr7I
	62UNWr4azS
X-Google-Smtp-Source: AGHT+IE5U5L7FKFd11F0WQt1XNgBpiVo/IPo5RbWpv/iMvxvj22k5V3U3KCHcVeLyLEWrxgu6b4b4w==
X-Received: by 2002:a05:690e:1503:b0:63e:1ee2:eb03 with SMTP id 956f58d0204a3-63f6ba8a0e8mr2831102d50.45.1761649055428;
        Tue, 28 Oct 2025 03:57:35 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1dde2bsm26598297b3.52.2025.10.28.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:57:34 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: dwmw@amazon.co.uk,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	hpa@zytor.com
Cc: x86@kernel.org,
	apopple@nvidia.com,
	thuth@redhat.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: [PATCH v2 2/2] efi/libstub: Fix page table access in 5-level to 4-level paging transition
Date: Tue, 28 Oct 2025 10:55:57 +0000
Message-ID: <20251028105637.769470-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028105637.769470-1-usamaarif642@gmail.com>
References: <20251028105637.769470-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When transitioning from 5-level to 4-level paging, the existing code
incorrectly accesses page table entries by directly dereferencing CR3
and applying PAGE_MASK. This approach has several issues:

- __native_read_cr3() returns the raw CR3 register value, which on
  x86_64 includes not just the physical address but also flags Bits
  above the physical address width of the system (i.e. above
  __PHYSICAL_MASK_SHIFT) are also not masked.
- The pgd value is masked by PAGE_SIZE which doesn't take into account
  the higher bits such as _PAGE_BIT_NOPTISHADOW.

Replace this with proper accessor functions:
- native_read_cr3_pa(): Uses CR3_ADDR_MASK properly clearing SME encryption
  bit and extracting only the physical address portion.
- mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
  flags above physical address (_PAGE_BIT_NOPTISHADOW in particular).

Fixes: cb1c9e02b0c1 ("x86/efistub: Perform 4/5 level paging switch from the stub")
Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
---
 drivers/firmware/efi/libstub/x86-5lvl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index f1c5fb45d5f7c..36b4a611f6adf 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -66,7 +66,7 @@ void efi_5level_switch(void)
 	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
 	bool need_toggle = want_la57 ^ have_la57;
 	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
-	u64 *cr3 = (u64 *)__native_read_cr3();
+	pgd_t *cr3 = (pgd_t *)native_read_cr3_pa();
 	u64 *new_cr3;
 
 	if (!la57_toggle || !need_toggle)
@@ -82,7 +82,7 @@ void efi_5level_switch(void)
 		new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
 	} else {
 		/* take the new root table pointer from the current entry #0 */
-		new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
+		new_cr3 = (u64 *)(pgd_val(cr3[0]) & PTE_PFN_MASK);
 
 		/* copy the new root table if it is not 32-bit addressable */
 		if ((u64)new_cr3 > U32_MAX)
-- 
2.47.3


