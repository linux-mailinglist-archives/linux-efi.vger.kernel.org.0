Return-Path: <linux-efi+bounces-5191-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C60C143BC
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 12:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3041C5E5DC0
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF70304BA8;
	Tue, 28 Oct 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfPJFzVZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F525487C
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649056; cv=none; b=EAlqU9s+Ie21iylnpXLFTxayJH8aBGixP29xuloWasrOx8O1xEyDRyoNiNCOy6c6IJJTBi1T8+5w1LOGbbnjJ9x5vtq0r3UMKIjbYASiVL8XFH3UrCU8Owvbg/0oy20dtHL7bOS4BJGSkjdwKIGS3G2NZaWdaJyTQW4THd35QRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649056; c=relaxed/simple;
	bh=RdFi9B1xaFI5S7ACFIioFSiqRWi0o5djZe42hthAnQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+d8IU7K2k3TMRrNBG868h9bzFdcqfUtiS3au/dE2e23mhutAGXWpfSvVGcre2FWfRvAfEawmbxT2g3L2+IK/6rnxi3NnyulQnMnS/QwPw+ZXaavCn1cMCXjBfdsLKIj2j8H9xoZea2g94gNri3Ndk5fcoAg9p4Y1bZ9itcT1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfPJFzVZ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7815092cd22so75245727b3.2
        for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 03:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761649052; x=1762253852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCicNmBtkxf7RoTr6oW3I01/BO6dQKtL8u3BkddbZOQ=;
        b=gfPJFzVZXCFs0hA3CHarGNhm2BbnVViLYjS8h8U3Qo3rhfEyf3Xia4woVDlOTaFI2T
         OxSsivKOuOVl3X1wCXRZ0JyXIIy/KLgcydn/VwMJJ9llfxGmc9za3aZQkkTp+hGdLsE9
         Fwnlq1yCQVPa7xp3hTJ1Lripnmw1zH/PddN2vdouaj0+4wMDhKUh49H5k28j5k/jvBED
         92WlR2g84f82rUHJ537XP8yV5xyq2tJDa/mwSN+YkYD/I/Wa39xwkcJ8CP/1hCabxIES
         AZGquoqse5GDW5Y9KKokyMXRYAAyuoFP6DMnPJL9+wPrCYDp4++zEwV9Rd4zOehkNwvz
         YSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761649052; x=1762253852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCicNmBtkxf7RoTr6oW3I01/BO6dQKtL8u3BkddbZOQ=;
        b=GlV9LRQbAyZbFb8ZVXBPqQgZk2+U4K6MdRK++xanPeTju62x0koIyLDI/GrdO3r+De
         lFTuQ6PFzX6Oqk/9vUWsC2WpRX88CSod0F0dzzqEieOAkjWSnYT40BmK98dnHq2j7GUu
         m2QPg/y6oV7X8XEYXf+t2nbjfGgsCdMqOHikxojBeOohrW7aQzgj13ig55KdnM3awJ5E
         t5LGL9xMnrCdLZMmk7qJhAGKrLXJw56HbajDhyoLs71RyP5Ausu8vgD5uWe+X+MUAtE3
         LvhRi0Bph7951n3YcsLFkzUO17z/2tE1Esae/S8CfCf88jd09JWICJFooHVKnrS3yMsz
         nJ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXPWMfP8GLpAunNRA0K7f5z7TWDKK9BoP9um5jupAeZrg7N3JxLku8DQmeIUxH75aFV6RnZ7511uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf3fz5QaJ0qwFSTVeLJTCZOIg6AIJ/CPJwaRQucWLTaag72wjo
	laWmh/yIgH4/tmMk3hRZ+p7lo5VaoFExTA911xH7JrHe9adhcmff//51
X-Gm-Gg: ASbGncumGEyDN+mY6Iax0dMqTpkUUXXYrpMZo6/mdeXD89TsrpGfRVueRIjAlvbRif1
	94EMqOOjxv05zMcP4/w/wxJJZHSa0BARDGUWMW8OhOhFcxb8wkgKwb/TKR1m8yXv1ZfA4Q0f7eA
	l8shi/xjc6pB4dOXLyns1WBmJPP0VcSgQ2hklfhlz31sYy1ILM4SNxibim2J3humAoefyTq9LjE
	i9o/Z7TwUiFPy5vj9Azn+97Bl/g9K/YB7xwzRZpnMNHhQehIEYDna6CdSG5EVbH1XGMETJ28+c3
	mk6BOZApq7Xa8sIl8GKTaNKdyfqU/ak1cCHGFhxE0in+K8DoAMTNstwgbhpy9Wo5jGC8VW9v1xI
	usCOvzF/hqYwk5cfKmhTogrYOImg5uwJmDWh6sCOkVa9ycOQLKFYIK8ZJyrHz2vg3mQDa8J/W7G
	a/D6p/q2dbig==
X-Google-Smtp-Source: AGHT+IEi2f0dgYE9Vk92a9SmD0HH1iyYIXi0n9OL2O+HDNZl+ryMSfq/CMdNRR9eXmOYCxlxyZ85ag==
X-Received: by 2002:a05:690c:6d0d:b0:783:796c:c1a9 with SMTP id 00721157ae682-78617f61d33mr29339177b3.37.1761649052434;
        Tue, 28 Oct 2025 03:57:32 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed196a0dsm26357697b3.27.2025.10.28.03.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:57:31 -0700 (PDT)
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
Subject: [PATCH v2 0/2] x86: Fix kexec 5-level to 4-level paging transition
Date: Tue, 28 Oct 2025 10:55:55 +0000
Message-ID: <20251028105637.769470-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses critical bugs in the kexec path when transitioning
from a kernel using 5-level page tables to one using 4-level page tables.

The root cause is improper handling of PGD entry value during the page level
transition. Specifically PGD entry value is masked with PAGE_MASK instead of
PTE_PFN_MASK, failing to account for high-order software bits like
_PAGE_BIT_NOPTISHADOW (bit 58).

When bit 58 (_PAGE_BIT_NOPTISHADOW) is set in the source kernel, the target
4-level kernel doesn't recognize it and fails to mask it properly, leading
to kexec failure.

Patch 1: Fixes the x86 boot compressed code path by replacing direct CR3
dereferencing with read_cr3_pa() and using PTE_PFN_MASK instead
of PAGE_MASK.

Patch 2: Applies the same fix to the EFI stub code path. (Done in a
separate patch as Fixes tag is different).


Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>

The patches are based on aaa9c3550b60d6259d6ea8b1175ade8d1242444e (next-20251022)

v1 -> v2:
- Remove patch 3 from v1 to fix kexec for source kernel in 5-level to 4-level
  transition where the 4 level kernel doesnt have patch 1 and 2 (Dave Hansen)
- Add include for asm/pgtable.h to fix build for x86_64-allnoconfig (kernel test bot)
- Use native_read_cr3_pa and for both paths (Ard Biesheuvel)
 
Usama Arif (2):
  x86/boot: Fix page table access in 5-level to 4-level paging
    transition
  efi/libstub: Fix page table access in 5-level to 4-level paging
    transition

 arch/x86/boot/compressed/pgtable_64.c   | 11 +++++++----
 drivers/firmware/efi/libstub/x86-5lvl.c |  4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.47.3


