Return-Path: <linux-efi+bounces-4422-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180B6B0AF4A
	for <lists+linux-efi@lfdr.de>; Sat, 19 Jul 2025 12:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAF9188B7DC
	for <lists+linux-efi@lfdr.de>; Sat, 19 Jul 2025 10:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9616F155725;
	Sat, 19 Jul 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0uAVvIb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445A2397B0
	for <linux-efi@vger.kernel.org>; Sat, 19 Jul 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752920042; cv=none; b=qOkD3PIGkxHRoM9aXvCKGncqG/Yc2osrkjm1CttcuVSViR+OO0jru441cWdG9w0JIAZV3We7LCyqs3NROXd/toD88znZX5+HFX9DqLfW8LQt8qsxaQgbau+hABN4LOQrVughIpdeMRpUDV1A1jpRzLO6qS18PERCX15hB+A8q3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752920042; c=relaxed/simple;
	bh=oEmZumk7iSbFFo/5zfw6sEtknJ3Vp6mZ62vusVwtj/s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SuEe8klJ+dvR/PN1HEXfa8cX0NhxGLURS7peALAAl3ntFC8D6cd36oWwGRsntyemkkb4oQy8Lv4tmE4YuxxtLDWEyQ5b24CttuQ4sxVYLuB9bW2s4V3QC08Wpzk5qnJLiq8YfHmIOuaJyeTdbRye7DLbTWimNTpcOlVX+csKotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0uAVvIb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752920041; x=1784456041;
  h=date:from:to:cc:subject:message-id;
  bh=oEmZumk7iSbFFo/5zfw6sEtknJ3Vp6mZ62vusVwtj/s=;
  b=G0uAVvIbSIiijYy0pyujEvEc0bIQu350yb6CoRKR6vuMsAU33EvISEC7
   X04Bf+R2Wq8ESOOyzp49dlHxi16v3WvpKkbA9KjHDdwPEsVjFRrTPICU+
   uBEc8CWmr4NXBK3oaSbOMtpm0RIkQW5zwTjwBklJ3FF4qb71h7nXXv1Np
   5JGiPKJdgYudoC7eSVgIAmpl+ztKJGyn+y3bXb1Pr7nIYVcUgKJJ8nSpY
   CjwtpHGpTnEEIUQy+o/htBBxHsUa4wZtj8VwsnWVsSESNAJ0LNHTT6uZR
   rO2SOfb7lCt01jm3JJep/GFSSskjlFGRcWR6vSkvXUdsOmoahIwZX4CSI
   Q==;
X-CSE-ConnectionGUID: r/joEFlmTcy2IeTj6u0BEw==
X-CSE-MsgGUID: qw5blHH6TVGD5+2Z5cCJaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="66649074"
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="66649074"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 03:14:00 -0700
X-CSE-ConnectionGUID: u5YxCOPcQEe/M4ASpC4F7g==
X-CSE-MsgGUID: pkserOzjTyei7o0sYBFveQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="159117975"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Jul 2025 03:13:58 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ud4Zo-000FPZ-0b;
	Sat, 19 Jul 2025 10:13:56 +0000
Date: Sat, 19 Jul 2025 18:13:33 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 64e135f1eaba0bbb0cdee859af3328c68d5b9789
Message-ID: <202507191821.grPpq30V-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 64e135f1eaba0bbb0cdee859af3328c68d5b9789  efivarfs: Fix memory leak of efivarfs_fs_info in fs_context error paths

elapsed time: 1451m

configs tested: 216
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-21
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250718    gcc-10.5.0
arc                   randconfig-001-20250719    clang-20
arc                   randconfig-002-20250718    gcc-8.5.0
arc                   randconfig-002-20250719    clang-20
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250718    gcc-8.5.0
arm                   randconfig-001-20250719    clang-20
arm                   randconfig-002-20250718    gcc-8.5.0
arm                   randconfig-002-20250719    clang-20
arm                   randconfig-003-20250718    gcc-8.5.0
arm                   randconfig-003-20250719    clang-20
arm                   randconfig-004-20250718    gcc-10.5.0
arm                   randconfig-004-20250719    clang-20
arm                        spear6xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250718    gcc-13.4.0
arm64                 randconfig-001-20250719    clang-20
arm64                 randconfig-002-20250718    gcc-8.5.0
arm64                 randconfig-002-20250719    clang-20
arm64                 randconfig-003-20250718    clang-21
arm64                 randconfig-003-20250719    clang-20
arm64                 randconfig-004-20250718    gcc-8.5.0
arm64                 randconfig-004-20250719    clang-20
csky                              allnoconfig    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250718    gcc-15.1.0
csky                  randconfig-001-20250719    gcc-11.5.0
csky                  randconfig-002-20250718    gcc-15.1.0
csky                  randconfig-002-20250719    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250718    clang-21
hexagon               randconfig-001-20250719    gcc-11.5.0
hexagon               randconfig-002-20250718    clang-21
hexagon               randconfig-002-20250719    gcc-11.5.0
i386        buildonly-randconfig-001-20250718    gcc-12
i386        buildonly-randconfig-001-20250719    clang-20
i386        buildonly-randconfig-002-20250718    clang-20
i386        buildonly-randconfig-002-20250719    clang-20
i386        buildonly-randconfig-003-20250718    gcc-12
i386        buildonly-randconfig-003-20250719    clang-20
i386        buildonly-randconfig-004-20250718    gcc-11
i386        buildonly-randconfig-004-20250719    clang-20
i386        buildonly-randconfig-005-20250718    gcc-12
i386        buildonly-randconfig-005-20250719    clang-20
i386        buildonly-randconfig-006-20250718    clang-20
i386        buildonly-randconfig-006-20250719    clang-20
i386                  randconfig-001-20250719    clang-20
i386                  randconfig-002-20250719    clang-20
i386                  randconfig-003-20250719    clang-20
i386                  randconfig-004-20250719    clang-20
i386                  randconfig-005-20250719    clang-20
i386                  randconfig-006-20250719    clang-20
i386                  randconfig-007-20250719    clang-20
i386                  randconfig-011-20250719    clang-20
i386                  randconfig-012-20250719    clang-20
i386                  randconfig-013-20250719    clang-20
i386                  randconfig-014-20250719    clang-20
i386                  randconfig-015-20250719    clang-20
i386                  randconfig-016-20250719    clang-20
i386                  randconfig-017-20250719    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250718    gcc-15.1.0
loongarch             randconfig-001-20250719    gcc-11.5.0
loongarch             randconfig-002-20250718    gcc-15.1.0
loongarch             randconfig-002-20250719    gcc-11.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip32_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250718    gcc-8.5.0
nios2                 randconfig-001-20250719    gcc-11.5.0
nios2                 randconfig-002-20250718    gcc-11.5.0
nios2                 randconfig-002-20250719    gcc-11.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250718    gcc-14.3.0
parisc                randconfig-001-20250719    gcc-11.5.0
parisc                randconfig-002-20250718    gcc-13.4.0
parisc                randconfig-002-20250719    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250718    gcc-9.5.0
powerpc               randconfig-001-20250719    gcc-11.5.0
powerpc               randconfig-002-20250718    gcc-11.5.0
powerpc               randconfig-002-20250719    gcc-11.5.0
powerpc               randconfig-003-20250718    clang-17
powerpc               randconfig-003-20250719    gcc-11.5.0
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250718    clang-18
powerpc64             randconfig-001-20250719    gcc-11.5.0
powerpc64             randconfig-002-20250718    clang-21
powerpc64             randconfig-002-20250719    gcc-11.5.0
powerpc64             randconfig-003-20250719    gcc-11.5.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250718    clang-21
riscv                 randconfig-001-20250719    gcc-13.4.0
riscv                 randconfig-002-20250718    clang-16
riscv                 randconfig-002-20250719    gcc-13.4.0
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250718    clang-21
s390                  randconfig-001-20250719    gcc-13.4.0
s390                  randconfig-002-20250718    clang-21
s390                  randconfig-002-20250719    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250718    gcc-15.1.0
sh                    randconfig-001-20250719    gcc-13.4.0
sh                    randconfig-002-20250718    gcc-15.1.0
sh                    randconfig-002-20250719    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250718    gcc-15.1.0
sparc                 randconfig-001-20250719    gcc-13.4.0
sparc                 randconfig-002-20250718    gcc-11.5.0
sparc                 randconfig-002-20250719    gcc-13.4.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250718    gcc-10.5.0
sparc64               randconfig-001-20250719    gcc-13.4.0
sparc64               randconfig-002-20250718    clang-20
sparc64               randconfig-002-20250719    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250718    gcc-12
um                    randconfig-001-20250719    gcc-13.4.0
um                    randconfig-002-20250718    gcc-12
um                    randconfig-002-20250719    gcc-13.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250718    clang-20
x86_64      buildonly-randconfig-001-20250719    clang-20
x86_64      buildonly-randconfig-002-20250718    gcc-12
x86_64      buildonly-randconfig-002-20250719    clang-20
x86_64      buildonly-randconfig-003-20250718    gcc-12
x86_64      buildonly-randconfig-003-20250719    clang-20
x86_64      buildonly-randconfig-004-20250718    clang-20
x86_64      buildonly-randconfig-004-20250719    clang-20
x86_64      buildonly-randconfig-005-20250718    clang-20
x86_64      buildonly-randconfig-005-20250719    clang-20
x86_64      buildonly-randconfig-006-20250718    clang-20
x86_64      buildonly-randconfig-006-20250719    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250719    gcc-11
x86_64                randconfig-002-20250719    gcc-11
x86_64                randconfig-003-20250719    gcc-11
x86_64                randconfig-004-20250719    gcc-11
x86_64                randconfig-005-20250719    gcc-11
x86_64                randconfig-006-20250719    gcc-11
x86_64                randconfig-007-20250719    gcc-11
x86_64                randconfig-008-20250719    gcc-11
x86_64                randconfig-071-20250719    clang-20
x86_64                randconfig-072-20250719    clang-20
x86_64                randconfig-073-20250719    clang-20
x86_64                randconfig-074-20250719    clang-20
x86_64                randconfig-075-20250719    clang-20
x86_64                randconfig-076-20250719    clang-20
x86_64                randconfig-077-20250719    clang-20
x86_64                randconfig-078-20250719    clang-20
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250718    gcc-8.5.0
xtensa                randconfig-001-20250719    gcc-13.4.0
xtensa                randconfig-002-20250718    gcc-12.5.0
xtensa                randconfig-002-20250719    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

