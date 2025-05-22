Return-Path: <linux-efi+bounces-3765-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7004EAC0B0D
	for <lists+linux-efi@lfdr.de>; Thu, 22 May 2025 14:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A3B4E2D23
	for <lists+linux-efi@lfdr.de>; Thu, 22 May 2025 12:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DD928934B;
	Thu, 22 May 2025 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4AGFfCw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEB2135CB
	for <linux-efi@vger.kernel.org>; Thu, 22 May 2025 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915365; cv=none; b=X/2VyX0jyxiGgoGKff9kyLTNFuzkdGAvhgVWetQYJz012clpSrOVrOGZITg6yZy7m9HES+Ict5+V08KYneimZ0rFe4U2VvtW13uRGWpmJxs6/5uHwKU3fdevowyejF7d088rMIltmriJ7kOO5+pDsLKlZGEmJ9k1fL9PlZR1kYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915365; c=relaxed/simple;
	bh=k0zVEQoOBdxO789xTwHG4cxpO4F5fiGMGH6bPCaHcgI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UPF3GaCZAWVIb3ixDgSA5ZnTr3U8oVfxBhhlG9D/jJdxST1EXIEFyMvzquc21QbDVupI9ZgY0KE30LBiYdGl7dmCLEwjQJpS6V27aDEuLYKfb9vwbzT60hh+VoFkgiOa+0OtTN3qV5OLy2lLJ93mkR9YdumrTWIr7J39R66GCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4AGFfCw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747915363; x=1779451363;
  h=date:from:to:cc:subject:message-id;
  bh=k0zVEQoOBdxO789xTwHG4cxpO4F5fiGMGH6bPCaHcgI=;
  b=j4AGFfCwMlXEmuUkTQ8o8IaCIONLM9aD2NP/XX1l5g/Z4PhQVi/xLi9w
   D++f42XDXsaCua1FY9wV/FIXuyNMxGLXpaqAKWx1/EN7uHtkXFr3TglW+
   fDCbChtufpsXcNCVhHKjMRH4uJDOZlmN83oLFU0H62LnZf+4LY4gC5YMi
   rtTlxwlLtVOKU4FAjbX1LCXwhAX8hwys7pW71YtLA+6UdnNFss7UFfYWi
   Z5gytIwBsbeR5ADnaEe/nJLURYGpEwUNeYX+lotNJd+S019shwideLil/
   9ex+zb3OoCt2paAd7QHJAKnquz83QAthDPADMN+f/GytwSFcHrB2KrY/S
   w==;
X-CSE-ConnectionGUID: 3Y0XH/oWTfq09nJLCOlvEg==
X-CSE-MsgGUID: nK2oNkoBQ3mPsaY7sAqQAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49644345"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="49644345"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 05:02:42 -0700
X-CSE-ConnectionGUID: j2aXJNaIRPC5IqikiVqyDw==
X-CSE-MsgGUID: NAz6eow6TdewWzJaef9JIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="171560662"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 22 May 2025 05:02:40 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI4dC-000PIe-2a;
	Thu, 22 May 2025 12:02:38 +0000
Date: Thu, 22 May 2025 20:01:40 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:efi-sbat] BUILD SUCCESS
 0f9a1739dd0e1ca3942e51dc3ec18f0d68c23be5
Message-ID: <202505222030.WmWNcBgB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-sbat
branch HEAD: 0f9a1739dd0e1ca3942e51dc3ec18f0d68c23be5  efi: zboot specific mechanism for embedding SBAT section

elapsed time: 1296m

configs tested: 256
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                          axs103_defconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250522    clang-21
arc                   randconfig-001-20250522    gcc-15.1.0
arc                   randconfig-002-20250522    clang-21
arc                   randconfig-002-20250522    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                         bcm2835_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                            mmp2_defconfig    gcc-14.2.0
arm                          moxart_defconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                            mps2_defconfig    gcc-14.2.0
arm                       multi_v4t_defconfig    gcc-14.2.0
arm                   randconfig-001-20250522    clang-21
arm                   randconfig-002-20250522    clang-21
arm                   randconfig-003-20250522    clang-18
arm                   randconfig-003-20250522    clang-21
arm                   randconfig-004-20250522    clang-21
arm                   randconfig-004-20250522    gcc-7.5.0
arm                         socfpga_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250522    clang-21
arm64                 randconfig-002-20250522    clang-21
arm64                 randconfig-002-20250522    gcc-7.5.0
arm64                 randconfig-003-20250522    clang-21
arm64                 randconfig-004-20250522    clang-21
arm64                 randconfig-004-20250522    gcc-5.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250522    gcc-15.1.0
csky                  randconfig-001-20250522    gcc-9.3.0
csky                  randconfig-002-20250522    gcc-15.1.0
csky                  randconfig-002-20250522    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250522    clang-17
hexagon               randconfig-001-20250522    gcc-9.3.0
hexagon               randconfig-002-20250522    clang-21
hexagon               randconfig-002-20250522    gcc-9.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250522    clang-20
i386        buildonly-randconfig-001-20250522    gcc-12
i386        buildonly-randconfig-002-20250522    gcc-12
i386        buildonly-randconfig-003-20250522    gcc-12
i386        buildonly-randconfig-004-20250522    gcc-12
i386        buildonly-randconfig-005-20250522    gcc-12
i386        buildonly-randconfig-006-20250522    clang-20
i386        buildonly-randconfig-006-20250522    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250522    clang-20
i386                  randconfig-002-20250522    clang-20
i386                  randconfig-003-20250522    clang-20
i386                  randconfig-004-20250522    clang-20
i386                  randconfig-005-20250522    clang-20
i386                  randconfig-006-20250522    clang-20
i386                  randconfig-007-20250522    clang-20
i386                  randconfig-011-20250522    gcc-12
i386                  randconfig-012-20250522    gcc-12
i386                  randconfig-013-20250522    gcc-12
i386                  randconfig-014-20250522    gcc-12
i386                  randconfig-015-20250522    gcc-12
i386                  randconfig-016-20250522    gcc-12
i386                  randconfig-017-20250522    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250522    gcc-15.1.0
loongarch             randconfig-001-20250522    gcc-9.3.0
loongarch             randconfig-002-20250522    gcc-15.1.0
loongarch             randconfig-002-20250522    gcc-9.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    clang-21
m68k                            mac_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    gcc-14.2.0
mips                           ip32_defconfig    gcc-14.2.0
mips                     loongson1b_defconfig    gcc-14.2.0
mips                           mtx1_defconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
mips                         rt305x_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    clang-21
mips                   sb1250_swarm_defconfig    gcc-14.2.0
mips                           xway_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250522    gcc-9.3.0
nios2                 randconfig-002-20250522    gcc-9.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250522    gcc-6.5.0
parisc                randconfig-001-20250522    gcc-9.3.0
parisc                randconfig-002-20250522    gcc-12.4.0
parisc                randconfig-002-20250522    gcc-9.3.0
parisc64                         alldefconfig    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                 canyonlands_defconfig    clang-21
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    clang-21
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    clang-21
powerpc               randconfig-001-20250522    gcc-9.3.0
powerpc               randconfig-002-20250522    clang-21
powerpc               randconfig-002-20250522    gcc-9.3.0
powerpc               randconfig-003-20250522    gcc-7.5.0
powerpc               randconfig-003-20250522    gcc-9.3.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc                        warp_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250522    clang-21
powerpc64             randconfig-001-20250522    gcc-9.3.0
powerpc64             randconfig-002-20250522    gcc-10.5.0
powerpc64             randconfig-002-20250522    gcc-9.3.0
powerpc64             randconfig-003-20250522    gcc-7.5.0
powerpc64             randconfig-003-20250522    gcc-9.3.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250522    gcc-10.5.0
riscv                 randconfig-001-20250522    gcc-9.3.0
riscv                 randconfig-002-20250522    clang-18
riscv                 randconfig-002-20250522    gcc-10.5.0
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250522    clang-19
s390                  randconfig-001-20250522    gcc-10.5.0
s390                  randconfig-002-20250522    clang-18
s390                  randconfig-002-20250522    gcc-10.5.0
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                    randconfig-001-20250522    gcc-10.5.0
sh                    randconfig-001-20250522    gcc-13.3.0
sh                    randconfig-002-20250522    gcc-10.5.0
sh                    randconfig-002-20250522    gcc-13.3.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7206_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250522    gcc-10.5.0
sparc                 randconfig-001-20250522    gcc-14.2.0
sparc                 randconfig-002-20250522    gcc-10.5.0
sparc                 randconfig-002-20250522    gcc-6.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250522    gcc-10.5.0
sparc64               randconfig-001-20250522    gcc-14.2.0
sparc64               randconfig-002-20250522    gcc-10.5.0
sparc64               randconfig-002-20250522    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250522    gcc-10.5.0
um                    randconfig-001-20250522    gcc-12
um                    randconfig-002-20250522    gcc-10.5.0
um                    randconfig-002-20250522    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250522    clang-20
x86_64      buildonly-randconfig-002-20250522    clang-20
x86_64      buildonly-randconfig-002-20250522    gcc-12
x86_64      buildonly-randconfig-003-20250522    clang-20
x86_64      buildonly-randconfig-003-20250522    gcc-12
x86_64      buildonly-randconfig-004-20250522    clang-20
x86_64      buildonly-randconfig-004-20250522    gcc-12
x86_64      buildonly-randconfig-005-20250522    clang-20
x86_64      buildonly-randconfig-005-20250522    gcc-12
x86_64      buildonly-randconfig-006-20250522    clang-20
x86_64      buildonly-randconfig-006-20250522    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250522    clang-20
x86_64                randconfig-002-20250522    clang-20
x86_64                randconfig-003-20250522    clang-20
x86_64                randconfig-004-20250522    clang-20
x86_64                randconfig-005-20250522    clang-20
x86_64                randconfig-006-20250522    clang-20
x86_64                randconfig-007-20250522    clang-20
x86_64                randconfig-008-20250522    clang-20
x86_64                randconfig-071-20250522    gcc-12
x86_64                randconfig-072-20250522    gcc-12
x86_64                randconfig-073-20250522    gcc-12
x86_64                randconfig-074-20250522    gcc-12
x86_64                randconfig-075-20250522    gcc-12
x86_64                randconfig-076-20250522    gcc-12
x86_64                randconfig-077-20250522    gcc-12
x86_64                randconfig-078-20250522    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250522    gcc-10.5.0
xtensa                randconfig-001-20250522    gcc-14.2.0
xtensa                randconfig-002-20250522    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

