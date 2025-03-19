Return-Path: <linux-efi+bounces-3038-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE44A68883
	for <lists+linux-efi@lfdr.de>; Wed, 19 Mar 2025 10:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74E4188CD5D
	for <lists+linux-efi@lfdr.de>; Wed, 19 Mar 2025 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AC4213245;
	Wed, 19 Mar 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbdzEG/c"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75409253F0D
	for <linux-efi@vger.kernel.org>; Wed, 19 Mar 2025 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377239; cv=none; b=f6odcaQanOynqh/0X8MRlcKxKcuXtwXxp2BpUy7NkOceZY3Xt3t7Acvr+d1qBSLvAbnvydWYQ8Mw5rdQAmhzzRAxHfU/3JtLnYbwLizMtuLURtmJSJ7naGz7DTHVCOkC02fxQr0VR1fku6+ZCPHz5gVqECk0EL5+R6U41IRUfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377239; c=relaxed/simple;
	bh=M0qcAEJ/KuyNTMTzl2aIiVwn+k3Bv13qmzqMjFs51NA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cq6HOHsl6xZjRgqHqLo4IsQ8z7siEnUnumuVqKlsc96aY4W/FHSZl94QnnGJp6U2I1v4LWhGpW8ZmRpHB2bVLvUcsc+XVjcZacKzGwvMELbXNZOESM45qdmM51wEzDNGULLwLNFY6mLwhh1+PfZJj4/pZ7NFf0ZLrh/7fTWGflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbdzEG/c; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742377237; x=1773913237;
  h=date:from:to:cc:subject:message-id;
  bh=M0qcAEJ/KuyNTMTzl2aIiVwn+k3Bv13qmzqMjFs51NA=;
  b=YbdzEG/cucC3Sjb2czL1DLGGoq8V8U0vxAWfPPbTWpo8dcf31dElQu1R
   g3accG5BmFHFFPzhtOTSfnRq2d07OC4nN8wp4wmthB/AON+lx9GlI+Fzc
   GSMxz8TV7rlBWRQ5Hf2YMlLGBo88ne29HEWkm4B/mPvE6k3HxwCFM9zhx
   QE6Mh90ee60tIr4wAf3k91nyRcdNUkurtWshHia0RNby4j5g4DEtqGQdl
   TbxVosBwX1irjRjqhga/vuqPI+8jGuT+EF26CLoc32Ir1pub4FcuG/2zn
   EVuyIT/RJclAwUF7zNhbzN8SxlOPVp49c8SSieOeHcUJZXSSGlXUxhMEL
   g==;
X-CSE-ConnectionGUID: YGt4eZhLQjmt39lgKlmZrA==
X-CSE-MsgGUID: MSnwzH+LQu2LHEfD5HerRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54191163"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54191163"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 02:40:36 -0700
X-CSE-ConnectionGUID: dNi9iZgBSpu3J7LFrzPyyA==
X-CSE-MsgGUID: NHv2qevuTxGFro2tnF5D0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="159699480"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 19 Mar 2025 02:40:35 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tupuW-000EY5-2w;
	Wed, 19 Mar 2025 09:40:29 +0000
Date: Wed, 19 Mar 2025 17:40:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 11092db5b57377ac99e6339cfd16ca35ef011f3c
Message-ID: <202503191706.9iPRaWGb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 11092db5b57377ac99e6339cfd16ca35ef011f3c  efivarfs: fix NULL dereference on resume

elapsed time: 1454m

configs tested: 267
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-9.3.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.3.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-10.5.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250318    gcc-8.5.0
arc                   randconfig-001-20250319    gcc-7.5.0
arc                   randconfig-002-20250318    gcc-8.5.0
arc                   randconfig-002-20250319    gcc-7.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-13.3.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-13.3.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250318    gcc-14.2.0
arm                   randconfig-001-20250319    gcc-7.5.0
arm                   randconfig-002-20250318    clang-21
arm                   randconfig-002-20250319    gcc-7.5.0
arm                   randconfig-003-20250318    gcc-14.2.0
arm                   randconfig-003-20250319    gcc-7.5.0
arm                   randconfig-004-20250318    clang-21
arm                   randconfig-004-20250319    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-13.3.0
arm64                             allnoconfig    gcc-8.5.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250318    clang-21
arm64                 randconfig-001-20250319    gcc-7.5.0
arm64                 randconfig-002-20250318    clang-14
arm64                 randconfig-002-20250319    gcc-7.5.0
arm64                 randconfig-003-20250318    gcc-13.3.0
arm64                 randconfig-003-20250319    gcc-7.5.0
arm64                 randconfig-004-20250318    gcc-6.5.0
arm64                 randconfig-004-20250319    gcc-7.5.0
csky                              allnoconfig    gcc-13.3.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250318    gcc-14.2.0
csky                  randconfig-001-20250319    gcc-10.5.0
csky                  randconfig-002-20250318    gcc-14.2.0
csky                  randconfig-002-20250319    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-13.3.0
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250318    clang-21
hexagon               randconfig-001-20250319    gcc-10.5.0
hexagon               randconfig-002-20250318    clang-17
hexagon               randconfig-002-20250319    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250318    clang-20
i386        buildonly-randconfig-001-20250319    gcc-12
i386        buildonly-randconfig-002-20250318    clang-20
i386        buildonly-randconfig-002-20250319    gcc-12
i386        buildonly-randconfig-003-20250318    clang-20
i386        buildonly-randconfig-003-20250319    gcc-12
i386        buildonly-randconfig-004-20250318    clang-20
i386        buildonly-randconfig-004-20250319    gcc-12
i386        buildonly-randconfig-005-20250318    clang-20
i386        buildonly-randconfig-005-20250319    gcc-12
i386        buildonly-randconfig-006-20250318    clang-20
i386        buildonly-randconfig-006-20250319    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250319    gcc-11
i386                  randconfig-002-20250319    gcc-11
i386                  randconfig-003-20250319    gcc-11
i386                  randconfig-004-20250319    gcc-11
i386                  randconfig-005-20250319    gcc-11
i386                  randconfig-006-20250319    gcc-11
i386                  randconfig-007-20250319    gcc-11
i386                  randconfig-011-20250319    gcc-12
i386                  randconfig-012-20250319    gcc-12
i386                  randconfig-013-20250319    gcc-12
i386                  randconfig-014-20250319    gcc-12
i386                  randconfig-015-20250319    gcc-12
i386                  randconfig-016-20250319    gcc-12
i386                  randconfig-017-20250319    gcc-12
loongarch                        allmodconfig    gcc-12.4.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-13.3.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250318    gcc-14.2.0
loongarch             randconfig-001-20250319    gcc-10.5.0
loongarch             randconfig-002-20250318    gcc-14.2.0
loongarch             randconfig-002-20250319    gcc-10.5.0
m68k                             allmodconfig    gcc-12.4.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-11.5.0
m68k                              allnoconfig    gcc-5.5.0
m68k                             allyesconfig    gcc-12.4.0
m68k                             allyesconfig    gcc-6.5.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-12.4.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                       allyesconfig    gcc-12.4.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-11.5.0
mips                              allnoconfig    gcc-14.2.0
mips                            gpr_defconfig    clang-18
mips                           ip22_defconfig    gcc-14.2.0
mips                           ip28_defconfig    clang-18
mips                      pic32mzda_defconfig    gcc-14.2.0
mips                         rt305x_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250318    gcc-9.3.0
nios2                 randconfig-001-20250319    gcc-10.5.0
nios2                 randconfig-002-20250318    gcc-5.5.0
nios2                 randconfig-002-20250319    gcc-10.5.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-10.5.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-10.5.0
parisc                           allmodconfig    gcc-5.5.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-5.5.0
parisc                           allyesconfig    gcc-10.5.0
parisc                           allyesconfig    gcc-9.3.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250318    gcc-8.5.0
parisc                randconfig-001-20250319    gcc-10.5.0
parisc                randconfig-002-20250318    gcc-14.2.0
parisc                randconfig-002-20250319    gcc-10.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-10.5.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-8.5.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-10.5.0
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                    gamecube_defconfig    clang-18
powerpc                   motionpro_defconfig    clang-18
powerpc                 mpc8315_rdb_defconfig    clang-18
powerpc               randconfig-001-20250318    clang-21
powerpc               randconfig-001-20250319    gcc-10.5.0
powerpc               randconfig-002-20250318    clang-21
powerpc               randconfig-002-20250319    gcc-10.5.0
powerpc               randconfig-003-20250318    gcc-14.2.0
powerpc               randconfig-003-20250319    gcc-10.5.0
powerpc                     taishan_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    clang-18
powerpc64             randconfig-001-20250318    clang-21
powerpc64             randconfig-001-20250319    gcc-10.5.0
powerpc64             randconfig-002-20250318    gcc-14.2.0
powerpc64             randconfig-002-20250319    gcc-10.5.0
powerpc64             randconfig-003-20250318    gcc-8.5.0
powerpc64             randconfig-003-20250319    gcc-10.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-10.5.0
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-7.5.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-10.5.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250318    clang-21
riscv                 randconfig-001-20250319    gcc-6.5.0
riscv                 randconfig-002-20250318    clang-21
riscv                 randconfig-002-20250319    gcc-6.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-9.3.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-13.2.0
s390                             allyesconfig    gcc-9.3.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250318    clang-15
s390                  randconfig-001-20250319    gcc-6.5.0
s390                  randconfig-002-20250318    gcc-12.4.0
s390                  randconfig-002-20250319    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-10.5.0
sh                                allnoconfig    gcc-11.5.0
sh                               allyesconfig    gcc-14.2.0
sh                               allyesconfig    gcc-9.3.0
sh                                  defconfig    gcc-12
sh                          lboxre2_defconfig    gcc-14.2.0
sh                          polaris_defconfig    clang-18
sh                    randconfig-001-20250318    gcc-14.2.0
sh                    randconfig-001-20250319    gcc-6.5.0
sh                    randconfig-002-20250318    gcc-7.5.0
sh                    randconfig-002-20250319    gcc-6.5.0
sh                   secureedge5410_defconfig    clang-18
sparc                            allmodconfig    gcc-6.5.0
sparc                            allmodconfig    gcc-9.3.0
sparc                             allnoconfig    gcc-11.5.0
sparc                             allnoconfig    gcc-6.5.0
sparc                 randconfig-001-20250318    gcc-14.2.0
sparc                 randconfig-001-20250319    gcc-6.5.0
sparc                 randconfig-002-20250318    gcc-14.2.0
sparc                 randconfig-002-20250319    gcc-6.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250318    gcc-11.5.0
sparc64               randconfig-001-20250319    gcc-6.5.0
sparc64               randconfig-002-20250318    gcc-11.5.0
sparc64               randconfig-002-20250319    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-15
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250318    clang-21
um                    randconfig-001-20250319    gcc-6.5.0
um                    randconfig-002-20250318    gcc-12
um                    randconfig-002-20250319    gcc-6.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250318    clang-20
x86_64      buildonly-randconfig-001-20250319    gcc-12
x86_64      buildonly-randconfig-002-20250318    clang-20
x86_64      buildonly-randconfig-002-20250319    gcc-12
x86_64      buildonly-randconfig-003-20250318    clang-20
x86_64      buildonly-randconfig-003-20250319    gcc-12
x86_64      buildonly-randconfig-004-20250318    clang-20
x86_64      buildonly-randconfig-004-20250319    gcc-12
x86_64      buildonly-randconfig-005-20250318    gcc-12
x86_64      buildonly-randconfig-005-20250319    gcc-12
x86_64      buildonly-randconfig-006-20250318    gcc-12
x86_64      buildonly-randconfig-006-20250319    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250319    clang-20
x86_64                randconfig-002-20250319    clang-20
x86_64                randconfig-003-20250319    clang-20
x86_64                randconfig-004-20250319    clang-20
x86_64                randconfig-005-20250319    clang-20
x86_64                randconfig-006-20250319    clang-20
x86_64                randconfig-007-20250319    clang-20
x86_64                randconfig-008-20250319    clang-20
x86_64                randconfig-071-20250319    gcc-12
x86_64                randconfig-072-20250319    gcc-12
x86_64                randconfig-073-20250319    gcc-12
x86_64                randconfig-074-20250319    gcc-12
x86_64                randconfig-075-20250319    gcc-12
x86_64                randconfig-076-20250319    gcc-12
x86_64                randconfig-077-20250319    gcc-12
x86_64                randconfig-078-20250319    gcc-12
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-11.5.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250318    gcc-14.2.0
xtensa                randconfig-001-20250319    gcc-6.5.0
xtensa                randconfig-002-20250318    gcc-7.5.0
xtensa                randconfig-002-20250319    gcc-6.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

