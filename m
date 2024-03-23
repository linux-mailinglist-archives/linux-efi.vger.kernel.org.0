Return-Path: <linux-efi+bounces-863-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA18877CC
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 10:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D5E1F21E45
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D6611A;
	Sat, 23 Mar 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mU4vMWbT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF1DDA7
	for <linux-efi@vger.kernel.org>; Sat, 23 Mar 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711186378; cv=none; b=TWP1ekxhXEH5w7lLN3uxbpovMspL75KRetjQRUPW98hIy5c9r081F4rfDTpZ84+N0T9EhC+CsIcgGL9ytoEMGgRHhZbPZdcWLeMbtSX0b9i7mBqdfcsgoy4964fag9Tt49HUUqmZOX71FHaxoX8VqXwp6mhS0T54pdb5uMOwamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711186378; c=relaxed/simple;
	bh=+n3XUGzCyALqo4r7Akm0QMF+sP8PkimKm205NAcXfC4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=scp5OXd0AsxliJXyOUpqTwDxgpYhJ+dwb8I9srH5KB2NXNF0bYGK+Q7JXfnT3Sm1S277ZUvHXJGQaVdLAoBnpg71EEz5nXd7Z+umRaoM7tgRMj55hBwDwTWtaB6WV+e8RX45oaO4KgpkZfEUl0vr7VBk+g8/0dHHIATiggCTi4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mU4vMWbT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711186375; x=1742722375;
  h=date:from:to:cc:subject:message-id;
  bh=+n3XUGzCyALqo4r7Akm0QMF+sP8PkimKm205NAcXfC4=;
  b=mU4vMWbTnTq82R7eXXHw765RV3tjMItmYjsqdH52tUgH8KH883IuX285
   wsJXCurnXfMp8m06wInvjSvMRlCuwUGTWdrxiXSXfai41ekMaC/bvRIB+
   NpyNgjDWxrjlZ4wirk6kroWTM9mCG2x6HaiKuOoHyn2BUZ9MhMYDGr9eA
   laxM2r3rUyKOvp0X7osokGW/mhQZqiMTwNRYHO9qAvTH05NBXGlPmYgy9
   7bw+BXSQcw1px9fGM8UrWVOqwTy8wGeRaeIqS5YX3EObjWen1tmIVCNIg
   U126VFNerwdJytiLDO0W7lCHPdTZZQMLgni+yYjdpCwFcqM10BlDBdMzX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="17632958"
X-IronPort-AV: E=Sophos;i="6.07,148,1708416000"; 
   d="scan'208";a="17632958"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2024 02:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,148,1708416000"; 
   d="scan'208";a="15211801"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 23 Mar 2024 02:32:54 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnxkB-000L25-2M;
	Sat, 23 Mar 2024 09:32:51 +0000
Date: Sat, 23 Mar 2024 17:32:30 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 917b3b926ae0d8d89803dcda5e8db81a3ef9288b
Message-ID: <202403231726.PrYIrtoD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 917b3b926ae0d8d89803dcda5e8db81a3ef9288b  x86/efistub: Don't clear BSS twice in mixed mode

elapsed time: 1020m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240323   gcc  
arc                   randconfig-002-20240323   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                   randconfig-004-20240323   gcc  
arm                        vexpress_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240323   gcc  
arm64                 randconfig-002-20240323   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240323   gcc  
csky                  randconfig-002-20240323   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240323   gcc  
i386         buildonly-randconfig-004-20240323   gcc  
i386         buildonly-randconfig-005-20240323   gcc  
i386                                defconfig   clang
i386                  randconfig-003-20240323   gcc  
i386                  randconfig-004-20240323   gcc  
i386                  randconfig-005-20240323   gcc  
i386                  randconfig-006-20240323   gcc  
i386                  randconfig-011-20240323   gcc  
i386                  randconfig-012-20240323   gcc  
i386                  randconfig-014-20240323   gcc  
i386                  randconfig-015-20240323   gcc  
i386                  randconfig-016-20240323   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240323   gcc  
loongarch             randconfig-002-20240323   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240323   gcc  
nios2                 randconfig-002-20240323   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240323   gcc  
parisc                randconfig-002-20240323   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc               randconfig-001-20240323   gcc  
powerpc               randconfig-002-20240323   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-003-20240323   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-002-20240323   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240323   gcc  
sh                    randconfig-002-20240323   gcc  
sh                             sh03_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240323   gcc  
sparc64               randconfig-002-20240323   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240323   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240323   clang
x86_64       buildonly-randconfig-002-20240323   clang
x86_64       buildonly-randconfig-003-20240323   clang
x86_64       buildonly-randconfig-005-20240323   clang
x86_64       buildonly-randconfig-006-20240323   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240323   clang
x86_64                randconfig-003-20240323   clang
x86_64                randconfig-004-20240323   clang
x86_64                randconfig-011-20240323   clang
x86_64                randconfig-013-20240323   clang
x86_64                randconfig-014-20240323   clang
x86_64                randconfig-015-20240323   clang
x86_64                randconfig-016-20240323   clang
x86_64                randconfig-071-20240323   clang
x86_64                randconfig-072-20240323   clang
x86_64                randconfig-073-20240323   clang
x86_64                randconfig-074-20240323   clang
x86_64                randconfig-076-20240323   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240323   gcc  
xtensa                randconfig-002-20240323   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

