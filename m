Return-Path: <linux-efi+bounces-2314-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2A9E8069
	for <lists+linux-efi@lfdr.de>; Sat,  7 Dec 2024 16:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EC5281C04
	for <lists+linux-efi@lfdr.de>; Sat,  7 Dec 2024 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7062322E;
	Sat,  7 Dec 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUb2J5b9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049C22C6C5
	for <linux-efi@vger.kernel.org>; Sat,  7 Dec 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733585271; cv=none; b=iGpeqOnQR/M244o1vXD3bRbK5ujtGpIsjZB9qlt4XwsIWiSYzuotdvDWvIfQRiBR3EAbS6H6Pp6UHDn7lQ4HQIOlm6ObVsc562HY0CSX40nb5dWEjGCPBelMQKNdhfz/Thnv/Nd4l3tfM3NTBQt3r553rKrlMcBHnYFtZpd5h2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733585271; c=relaxed/simple;
	bh=Tg6GZb4nxOoWFIKwAAcMkbUvNoGdvvt83XpgIlIKPvU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cS1G2OAWF1511TffRwDpikoURu0wneZ6+h1yWD+uERKWYm4yuwyru4Merr9bNC81tn9RHJ5lOKDfVTyNluWNU0sa9nHJhHiETQSldKSxZrVyGnQEAuEGRbytbycbMWb6axwK27WynoIQ9PyeEt8RJ1DdedbV66j8FSKobj2m33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUb2J5b9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733585269; x=1765121269;
  h=date:from:to:cc:subject:message-id;
  bh=Tg6GZb4nxOoWFIKwAAcMkbUvNoGdvvt83XpgIlIKPvU=;
  b=LUb2J5b9xWGEKXz6RkjadUw/IKY6kG4IImhBzXbg6vkujfmAWWIzZq72
   XCyfgI/MLb47bgkq/rhY51zncegNX02RLUBRmiHIEVsFf2Qlx+xfd+TNK
   AlyV5TJWdrC4oyrx8EOrkUZyhglEah8aWlNyRnWnI7z95ZOP6mhbOkkHR
   nZw+0laoOrhWBFmrEJ2owd6B2w3kFR5Gis6GT5QraSruHCWHKZRY4sKDk
   05GcZ62tX84GeL7twC507hyGajhYtgWkRiGjVKzvfN7zsACQOFvpbRcug
   4WQibwb34N5hd1QYmAJGfy0Y36cBL8F2wjTPfDJVQlgD1kqvTmJX7Tckh
   Q==;
X-CSE-ConnectionGUID: GVZVLMXSQoOPNS8rD47Ttg==
X-CSE-MsgGUID: SRb6hRpsQfa54xv2LnXipA==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="45328769"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="45328769"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 07:27:48 -0800
X-CSE-ConnectionGUID: oLFkePkaRcigVf7jylrQzA==
X-CSE-MsgGUID: agN2aPVsS1S/aAgdNRXGhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="99704571"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Dec 2024 07:27:47 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJwie-0002lz-3B;
	Sat, 07 Dec 2024 15:27:44 +0000
Date: Sat, 07 Dec 2024 23:24:14 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 0b2c29fb68f8bf3e87a9d88404aa6fdd486223e5
Message-ID: <202412072304.QblCobUn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 0b2c29fb68f8bf3e87a9d88404aa6fdd486223e5  efi/zboot: Limit compression options to GZIP and ZSTD

elapsed time: 1337m

configs tested: 213
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    clang-15
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241207    clang-19
arc                   randconfig-001-20241207    gcc-13.2.0
arc                   randconfig-002-20241207    clang-19
arc                   randconfig-002-20241207    gcc-13.2.0
arc                        vdk_hs38_defconfig    clang-20
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-15
arm                            hisi_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    gcc-13.2.0
arm                            mps2_defconfig    clang-15
arm                        multi_v5_defconfig    clang-20
arm                   randconfig-001-20241207    clang-19
arm                   randconfig-001-20241207    gcc-14.2.0
arm                   randconfig-002-20241207    clang-19
arm                   randconfig-002-20241207    gcc-14.2.0
arm                   randconfig-003-20241207    clang-19
arm                   randconfig-004-20241207    clang-19
arm                   randconfig-004-20241207    clang-20
arm                        realview_defconfig    clang-20
arm                        shmobile_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    clang-17
arm64                            alldefconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241207    clang-19
arm64                 randconfig-001-20241207    gcc-14.2.0
arm64                 randconfig-002-20241207    clang-19
arm64                 randconfig-002-20241207    gcc-14.2.0
arm64                 randconfig-003-20241207    clang-19
arm64                 randconfig-003-20241207    clang-20
arm64                 randconfig-004-20241207    clang-15
arm64                 randconfig-004-20241207    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241207    clang-19
csky                  randconfig-001-20241207    gcc-14.2.0
csky                  randconfig-002-20241207    clang-19
csky                  randconfig-002-20241207    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241207    clang-14
hexagon               randconfig-001-20241207    clang-19
hexagon               randconfig-002-20241207    clang-16
hexagon               randconfig-002-20241207    clang-19
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241207    clang-19
i386        buildonly-randconfig-002-20241207    clang-19
i386        buildonly-randconfig-003-20241207    clang-19
i386        buildonly-randconfig-003-20241207    gcc-12
i386        buildonly-randconfig-004-20241207    clang-19
i386        buildonly-randconfig-005-20241207    clang-19
i386        buildonly-randconfig-006-20241207    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241207    clang-19
loongarch             randconfig-001-20241207    gcc-14.2.0
loongarch             randconfig-002-20241207    clang-19
loongarch             randconfig-002-20241207    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-13.2.0
m68k                        stmark2_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    gcc-14.2.0
mips                        maltaup_defconfig    clang-17
mips                           mtx1_defconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-17
mips                   sb1250_swarm_defconfig    clang-20
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241207    clang-19
nios2                 randconfig-001-20241207    gcc-14.2.0
nios2                 randconfig-002-20241207    clang-19
nios2                 randconfig-002-20241207    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-13.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241207    clang-19
parisc                randconfig-001-20241207    gcc-14.2.0
parisc                randconfig-002-20241207    clang-19
parisc                randconfig-002-20241207    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    clang-15
powerpc                     akebono_defconfig    clang-17
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    gcc-14.2.0
powerpc                   currituck_defconfig    clang-15
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                 mpc832x_rdb_defconfig    clang-20
powerpc                 mpc832x_rdb_defconfig    gcc-13.2.0
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                      pmac32_defconfig    clang-15
powerpc               randconfig-001-20241207    clang-19
powerpc               randconfig-001-20241207    gcc-14.2.0
powerpc               randconfig-002-20241207    clang-19
powerpc               randconfig-002-20241207    clang-20
powerpc               randconfig-003-20241207    clang-15
powerpc               randconfig-003-20241207    clang-19
powerpc                     redwood_defconfig    gcc-14.2.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241207    clang-19
powerpc64             randconfig-001-20241207    gcc-14.2.0
powerpc64             randconfig-002-20241207    clang-19
powerpc64             randconfig-003-20241207    clang-17
powerpc64             randconfig-003-20241207    clang-19
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241207    gcc-14.2.0
riscv                 randconfig-002-20241207    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                                defconfig    gcc-14.2.0
s390                  randconfig-001-20241207    gcc-14.2.0
s390                  randconfig-002-20241207    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    clang-17
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    clang-20
sh                          landisk_defconfig    clang-20
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20241207    gcc-14.2.0
sh                    randconfig-002-20241207    gcc-14.2.0
sh                           se7343_defconfig    clang-15
sh                           se7724_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241207    gcc-14.2.0
sparc                 randconfig-002-20241207    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241207    gcc-14.2.0
sparc64               randconfig-002-20241207    gcc-14.2.0
um                               alldefconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241207    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241207    clang-19
x86_64      buildonly-randconfig-002-20241207    clang-19
x86_64      buildonly-randconfig-003-20241207    clang-19
x86_64      buildonly-randconfig-003-20241207    gcc-11
x86_64      buildonly-randconfig-004-20241207    clang-19
x86_64      buildonly-randconfig-005-20241207    clang-19
x86_64      buildonly-randconfig-006-20241207    clang-19
x86_64      buildonly-randconfig-006-20241207    gcc-12
x86_64                              defconfig    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-13.2.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                randconfig-001-20241207    gcc-14.2.0
xtensa                randconfig-002-20241207    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

