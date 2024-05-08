Return-Path: <linux-efi+bounces-1019-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3678C04CC
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 21:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D6D1F22813
	for <lists+linux-efi@lfdr.de>; Wed,  8 May 2024 19:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F0130A53;
	Wed,  8 May 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1/i2io5o"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386FB130A48
	for <linux-efi@vger.kernel.org>; Wed,  8 May 2024 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715195977; cv=none; b=JjYVy/0uHXZHdsFt7uLoXy2eFnPFeY0MRf+CGnBvUZVH/GjIigx7EM+T4d+Fs/rpOMqSVTCziM71Kadi70LDlfDtIzJ3jQsPpvi5XsCi8kvL8fZuLxmWovn/MgNRUgEsZmYvEvIt2Gy5PpVIyveTXfLRSWmzbPP8TWPu34950gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715195977; c=relaxed/simple;
	bh=YIVNY41R8E3i0qyQzpYxu5vSIyMEkNoTli1SIL3s7xg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eqk0QvCysU/2HQgSIERWe1E1n347Xt5f0LDvmJMVwxHOGg9iKhCcI3Fpt9rD+LuNQ5f4Tb/n+vAFGXFAIiPthcTgyYy1ZOp0rjbDR6eGYHbVHs6s3dys5KF4X5pIu/5BhPZz6wnfFGrMXkEGlHpsXZwcqQUfXP/TA3ozsmral8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1/i2io5o; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db17e8767cso1542071fa.3
        for <linux-efi@vger.kernel.org>; Wed, 08 May 2024 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715195973; x=1715800773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1uKlYjMTe4xfHBkLhM4fwrAS4H0Wd2FQ2UyNN+YPgM=;
        b=1/i2io5o+yUAKNufrkNKnrlHRqEG7ucxRXgpH73zSfgZfkeMZg57mnB621KbEn7E9x
         LB12510yD8FiUHF+NU2xhSjYmUsksbihYzx49T5XdqR/M/9G5V4kHAlKwW5Nvu3nyX7H
         d+ttaO01uRO8Tm/DNxzWLYiFduch/OirW0ngKcpbTvYm4kHHdbLBQB1igrhdzp/+aJOd
         72j3FRE7xSsVS6sOkyGs7OYiXlH2dF5eQ8/5nylLlDLjjk3ZCtvMxgCLE5mFqEvk0jzr
         yjT6PCxfvGN6tUEjZma4DuEwtXYHEzk5AlFVNTBUUhSKOeOMkvHmn5HkQzumj9ef1g0t
         6tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715195973; x=1715800773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1uKlYjMTe4xfHBkLhM4fwrAS4H0Wd2FQ2UyNN+YPgM=;
        b=cU7V/k02Cf/KYpxJgVP2PKuGXOPmcaluwJdNJ3MiDsWooOqv08buQTfewgiPK5p2Mb
         h83xy9ZI/b2TxxT9W8BSfNBbQPEwwhA3bkTtP2tHszycTVBRtWKlNzehG3E2Mk1a831/
         kbSjY7L4P5mcbPYvVUw49e9AiRS9iyDhUQl6yoGu7mgwVfll/f94mhAL9Ic6y28u4uoO
         DtnFOGwqQvg9E3fMWEH4HKcUUzbuCdXjtPwY6RiDi7DzKu/hlLNG22fJesT96pgt46nG
         NU+LBhadGMg73R8+I7XqbZQ9Ehy4DDjZLL6aPFY4aPauP/dRrmK/4WAnKDkSHxxbJ5NV
         wizg==
X-Forwarded-Encrypted: i=1; AJvYcCVOGXOIUSWt681Mv2M0WXYlWev4/ISIQEZXo8EUZMMDMFiYFGh0v9LMDuMHpyU+pQRQrVK1PU46iHXpSHsXYkaxbAcZ2kiBdztu
X-Gm-Message-State: AOJu0YyupTcDBNZaqqo6m/kJcb6+XkO8R2dS04pdIhhzxCN6yZuhapsR
	g/wrxV2+HvKQ5iWx2H5nSfSdGmAjZgH/ErRgbiAWcPXn3UcOZc9/boiSolqD6Lc=
X-Google-Smtp-Source: AGHT+IHeP5I15KzeyyHS9QyEylQJKB8BxwDLerdVkeWn4X1OoVdiknVfTODJicHq4kG+uWiKxO6g7A==
X-Received: by 2002:a2e:81a:0:b0:2e0:12f1:f827 with SMTP id 38308e7fff4ca-2e4479a2ca4mr23591601fa.43.1715195973157;
        Wed, 08 May 2024 12:19:33 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm32622515e9.29.2024.05.08.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:19:32 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ard Biesheuvel <ardb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 00/12] Make riscv use THP contpte support for arm64
Date: Wed,  8 May 2024 21:19:19 +0200
Message-Id: <20240508191931.46060-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows riscv to support napot (riscv equivalent to contpte) THPs by
moving arm64 contpte support into mm, the previous series [1] only merging
riscv and arm64 implementations of hugetlbfs contpte.

riscv contpte specification allows for different contpte sizes, although
only 64KB is supported for now. So in this patchset is implemented the
support of multiple contpte sizes, which introduces a few arch specific
helpers to determine what sizes are supported. Even though only one size
is supported on riscv, the implementation of the multi size support is to
show what it will look like when we support other sizes, and make sure
it does not regress arm64.

I tested arm64 using the cow kselftest and a kernel build with 4KB base
page size and 64KB contpte. riscv was tested with the same tests on *all*
contpte sizes that fit in the last page table level (support for PMD sizes
is not present here). Both arch were only tested on qemu.

Alexandre Ghiti (12):
  mm, arm64: Rename ARM64_CONTPTE to THP_CONTPTE
  mm, riscv, arm64: Use common ptep_get() function
  mm, riscv, arm64: Use common set_ptes() function
  mm, riscv, arm64: Use common ptep_get_lockless() function
  mm, riscv, arm64: Use common set_pte() function
  mm, riscv, arm64: Use common pte_clear() function
  mm, riscv, arm64: Use common ptep_get_and_clear() function
  mm, riscv, arm64: Use common ptep_test_and_clear_young() function
  mm, riscv, arm64: Use common ptep_clear_flush_young() function
  mm, riscv, arm64: Use common ptep_set_access_flags() function
  mm, riscv, arm64: Use common ptep_set_wrprotect()/wrprotect_ptes()
    functions
  mm, riscv, arm64: Use common
    get_and_clear_full_ptes()/clear_full_ptes() functions

 arch/arm64/Kconfig               |   9 -
 arch/arm64/include/asm/pgtable.h | 318 +++++---------
 arch/arm64/mm/Makefile           |   1 -
 arch/arm64/mm/contpte.c          | 408 ------------------
 arch/arm64/mm/hugetlbpage.c      |   6 +-
 arch/arm64/mm/mmu.c              |   2 +-
 arch/riscv/include/asm/kfence.h  |   4 +-
 arch/riscv/include/asm/pgtable.h | 206 +++++++++-
 arch/riscv/kernel/efi.c          |   4 +-
 arch/riscv/kernel/hibernate.c    |   2 +-
 arch/riscv/kvm/mmu.c             |  26 +-
 arch/riscv/mm/fault.c            |   2 +-
 arch/riscv/mm/init.c             |   4 +-
 arch/riscv/mm/kasan_init.c       |  16 +-
 arch/riscv/mm/pageattr.c         |   8 +-
 arch/riscv/mm/pgtable.c          |   6 +-
 include/linux/contpte.h          |  37 ++
 mm/Kconfig                       |   9 +
 mm/contpte.c                     | 685 ++++++++++++++++++++++++++++++-
 19 files changed, 1056 insertions(+), 697 deletions(-)
 delete mode 100644 arch/arm64/mm/contpte.c
 create mode 100644 include/linux/contpte.h

-- 
2.39.2


