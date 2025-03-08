Return-Path: <linux-efi+bounces-2937-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01689A57A0D
	for <lists+linux-efi@lfdr.de>; Sat,  8 Mar 2025 13:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB5C1892D29
	for <lists+linux-efi@lfdr.de>; Sat,  8 Mar 2025 12:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC477183CCA;
	Sat,  8 Mar 2025 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4ewWwbA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661B8462
	for <linux-efi@vger.kernel.org>; Sat,  8 Mar 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741435579; cv=none; b=OYcVR71AO7UNBRr4qPIQtA3gYgBRJHY7mmfN0F/pCu96f8IRppHAF5mbL+UCimFVsOvH+rRbITYZGdsnkoljkYeg2Kt3v4QP6HDd3De2toSNkWpRR6PMq9I/K/sA0A71GZfMnnkHnRF5qEVnuKuRI70KZQe8JuV648Br4E60niM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741435579; c=relaxed/simple;
	bh=oVzZhsQNOgNW48CHKAi++cuNca+ZVSdRlZLIRXJBa20=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gyU2opl1m2oduoFJjiEwdf9Snbh+jCnWlwz4odygn1rjQmrH+NzMnfo/MRo3WNHLbXbwBSuSN09/2+BPuYTCZS5z5KGxModGlVUiTHur7vt1CnerTqk5KLbNcb8Ic6lrgiQuMNAY/RXaZAuqCe81OkaTuL6gpSmoEcnsqHEcu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4ewWwbA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741435578; x=1772971578;
  h=date:from:to:cc:subject:message-id;
  bh=oVzZhsQNOgNW48CHKAi++cuNca+ZVSdRlZLIRXJBa20=;
  b=a4ewWwbA9hD+q3xfMl/YgwNrnKVSUUCTf3Umcy7PANZAYaYKE/eNnwkY
   lrLanXaGByXCntzbG4l88bH2UWVnvfV/B/re9AnLMtDnEfw2hjIDcHLZd
   6oNcREYbele0+5NX43qoh7ZJaB7K0/MZTaJo+6Ff82ZbZJ5xggSmoXmct
   tFf9KrRM46Wn1HUpYqj9mt/j3+qsODcNeysB5RAA+L5M+YyBtQqjlokn6
   Gr9U385eho1RqIozoZ0YaAPgtbyi3DyBw1HSNAVULp2MJljOCAZr1U+Lh
   vE1214DDDe/Z4GQy4KDnw8Pf72B0wLkYV8tYsYZTa0SQMRLxZPyqjA8cL
   g==;
X-CSE-ConnectionGUID: VWMr9lmQQACwey5ZV/rwcA==
X-CSE-MsgGUID: G3j7NfE/QsKIlNUKcHV77w==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42185938"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="42185938"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 04:06:17 -0800
X-CSE-ConnectionGUID: IvhxQaCTQYGrz9aBD2wkIA==
X-CSE-MsgGUID: pT8NoCcFToW86ZQh25Mn6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="124145346"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 08 Mar 2025 04:06:16 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqswY-0001rs-0Z;
	Sat, 08 Mar 2025 12:06:14 +0000
Date: Sat, 08 Mar 2025 20:05:29 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 b6b227e36b5ad878260f5a3a1838f2d79d5e68e9
Message-ID: <202503082023.INiZtOxy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: b6b227e36b5ad878260f5a3a1838f2d79d5e68e9  efivarfs: Revert "allow creation of zero length files"

elapsed time: 1456m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250307    gcc-13.2.0
arc                  randconfig-002-20250307    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250307    clang-21
arm                  randconfig-002-20250307    gcc-14.2.0
arm                  randconfig-003-20250307    clang-19
arm                  randconfig-004-20250307    clang-21
arm64                randconfig-001-20250307    gcc-14.2.0
arm64                randconfig-002-20250307    clang-15
arm64                randconfig-003-20250307    gcc-14.2.0
arm64                randconfig-004-20250307    clang-15
csky                 randconfig-001-20250308    gcc-14.2.0
csky                 randconfig-002-20250308    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250308    clang-19
hexagon              randconfig-002-20250308    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250307    clang-19
i386       buildonly-randconfig-002-20250307    clang-19
i386       buildonly-randconfig-003-20250307    gcc-11
i386       buildonly-randconfig-004-20250307    clang-19
i386       buildonly-randconfig-005-20250307    gcc-12
i386       buildonly-randconfig-006-20250307    clang-19
loongarch            randconfig-001-20250308    gcc-14.2.0
loongarch            randconfig-002-20250308    gcc-14.2.0
nios2                randconfig-001-20250308    gcc-14.2.0
nios2                randconfig-002-20250308    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250308    gcc-14.2.0
parisc               randconfig-002-20250308    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250308    clang-18
powerpc              randconfig-002-20250308    gcc-14.2.0
powerpc              randconfig-003-20250308    gcc-14.2.0
powerpc64            randconfig-001-20250308    gcc-14.2.0
powerpc64            randconfig-003-20250308    clang-21
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250307    gcc-14.2.0
riscv                randconfig-002-20250307    clang-19
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250307    gcc-14.2.0
s390                 randconfig-002-20250307    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250307    gcc-14.2.0
sh                   randconfig-002-20250307    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250307    gcc-14.2.0
sparc                randconfig-002-20250307    gcc-14.2.0
sparc64              randconfig-001-20250307    gcc-14.2.0
sparc64              randconfig-002-20250307    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250307    clang-17
um                   randconfig-002-20250307    clang-21
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250307    clang-19
x86_64     buildonly-randconfig-002-20250307    gcc-12
x86_64     buildonly-randconfig-003-20250307    clang-19
x86_64     buildonly-randconfig-004-20250307    clang-19
x86_64     buildonly-randconfig-005-20250307    clang-19
x86_64     buildonly-randconfig-006-20250307    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250307    gcc-14.2.0
xtensa               randconfig-002-20250307    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

