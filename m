Return-Path: <linux-efi+bounces-4292-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9282B028D9
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 03:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD45F580018
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 01:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1603EA63;
	Sat, 12 Jul 2025 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Labnglah"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769212AE6A
	for <linux-efi@vger.kernel.org>; Sat, 12 Jul 2025 01:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752285168; cv=none; b=k5cR7DAN0aXcfqOOjl0+J8TyXAuXMaJMEtBUncYy03RntkSFIS+icdgYMOnK5QOIT7ek5+OJ0BXALxt0snhp6cDQhtgqPvtnGjNPCGOFl2ESfVDUVfwZggF/WyEXbIYYqync8j8yboixmZMF0fHhlukUqfyWS9tfGGexZUTc38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752285168; c=relaxed/simple;
	bh=y4Udkt7HhEXYixGVVMw7CgmMsKJq4IlEQaOita+Pavw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C1oRbZ2H+Y+d3OXaJayGfch6tbXeMriTx5htdmIgjcfWheD1vTVVnbD3rJ1+zp0gTyKKBrqePGt1GR6UKVJH/WCOunzEnajn5BSP+v/bgaoE7DjfymOgC96sSuAc9MyjipCac79dvVNYIMdvEyhJALh7/wtE92rRxMcEg1dZqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Labnglah; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752285166; x=1783821166;
  h=date:from:to:cc:subject:message-id;
  bh=y4Udkt7HhEXYixGVVMw7CgmMsKJq4IlEQaOita+Pavw=;
  b=Labnglah9WbToc9X6Sm6eAstOSg3M1snXrtkCrx90A0D0BPfWahUsK5A
   Lf5udaaA61tCDZAySpY+WaxPQG+hzt/BQF0VMCRakBa6NPMXFYCFAUHK9
   K9ZUDL/72eFIlOBARt2Lk5VfGbGjhqBAVDwtK2Jn1HrpmCy4Ez7Uyw/fs
   zYV/F3COMqkjdb96sVHZNqoitM1YKXVi0j7QtuH0AnDMPVqBsR/K7nWKo
   PqDM9VqCnGC8z45efZV1hiBE2itaYsKrD8VTA3pLN68xrFzn4W4Xr+aau
   hgNFToJN4VPeKU5OAMpxcHQsC0vR2MWs+6kZjOkZ+rCx018GDJDl68wbo
   g==;
X-CSE-ConnectionGUID: P/nzOkPwSOe49/Pwasew1Q==
X-CSE-MsgGUID: xhEh57P7SHeOfASawCXNIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65159529"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="65159529"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 18:52:44 -0700
X-CSE-ConnectionGUID: cXTYzxs7SlCFiwkjhdyFwA==
X-CSE-MsgGUID: 5aBsWhDxSXmUMNLtRVg+zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="162173470"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Jul 2025 18:52:43 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaPPs-0006zD-31;
	Sat, 12 Jul 2025 01:52:40 +0000
Date: Sat, 12 Jul 2025 09:52:24 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 dedf090561dc6e1dcccf7b495a61bec57f2e7079
Message-ID: <202507120911.39rAdv70-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: dedf090561dc6e1dcccf7b495a61bec57f2e7079  rtc: efi: Add runtime check for the wakeup service capability

elapsed time: 1449m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250711    gcc-8.5.0
arc                   randconfig-002-20250711    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250711    clang-19
arm                   randconfig-002-20250711    clang-21
arm                   randconfig-003-20250711    gcc-15.1.0
arm                   randconfig-004-20250711    clang-20
arm                        spear6xx_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250711    clang-18
arm64                 randconfig-002-20250711    clang-21
arm64                 randconfig-003-20250711    gcc-12.3.0
arm64                 randconfig-004-20250711    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250711    gcc-14.3.0
csky                  randconfig-002-20250711    gcc-15.1.0
hexagon                          alldefconfig    clang-21
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250711    clang-19
hexagon               randconfig-002-20250711    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250711    gcc-12
i386        buildonly-randconfig-002-20250711    gcc-12
i386        buildonly-randconfig-003-20250711    clang-20
i386        buildonly-randconfig-004-20250711    clang-20
i386        buildonly-randconfig-005-20250711    gcc-11
i386        buildonly-randconfig-006-20250711    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250711    clang-21
loongarch             randconfig-002-20250711    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250711    gcc-10.5.0
nios2                 randconfig-002-20250711    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250711    gcc-12.4.0
parisc                randconfig-002-20250711    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                   motionpro_defconfig    clang-21
powerpc               randconfig-001-20250711    clang-18
powerpc               randconfig-002-20250711    clang-21
powerpc               randconfig-003-20250711    clang-21
powerpc                     sequoia_defconfig    clang-17
powerpc                     skiroot_defconfig    clang-21
powerpc64             randconfig-001-20250711    clang-21
powerpc64             randconfig-002-20250711    clang-21
powerpc64             randconfig-003-20250711    gcc-13.4.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250711    gcc-8.5.0
riscv                 randconfig-002-20250711    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250711    clang-21
s390                  randconfig-002-20250711    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250711    gcc-12.4.0
sh                    randconfig-002-20250711    gcc-15.1.0
sh                              ul2_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250711    gcc-10.3.0
sparc                 randconfig-002-20250711    gcc-12.4.0
sparc64               randconfig-001-20250711    gcc-8.5.0
sparc64               randconfig-002-20250711    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250711    clang-20
um                    randconfig-002-20250711    clang-19
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250711    clang-20
x86_64      buildonly-randconfig-002-20250711    clang-20
x86_64      buildonly-randconfig-003-20250711    clang-20
x86_64      buildonly-randconfig-004-20250711    gcc-12
x86_64      buildonly-randconfig-005-20250711    clang-20
x86_64      buildonly-randconfig-006-20250711    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250711    gcc-9.3.0
xtensa                randconfig-002-20250711    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

