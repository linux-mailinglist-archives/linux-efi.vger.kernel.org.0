Return-Path: <linux-efi+bounces-3823-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94FEAD0B8D
	for <lists+linux-efi@lfdr.de>; Sat,  7 Jun 2025 09:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C763B167D
	for <lists+linux-efi@lfdr.de>; Sat,  7 Jun 2025 07:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04FF1E1E04;
	Sat,  7 Jun 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iILYCz05"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B941CF7AF
	for <linux-efi@vger.kernel.org>; Sat,  7 Jun 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749280283; cv=none; b=c5Rn3x4L53vIugswIzmAxw0P47Nl7PykWo07DeN9liC1ubNuDwaHZ5Sjb2Izf9NlBWCRg4ljaMHooHErV6Sr9MTdh4TPXv324+fXsZG0oN87BIYavgOhkdti0S/BMxxHb55/kqoQi5n2TovsuT1pYdx1ZKpwmmvnPvDrde3JBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749280283; c=relaxed/simple;
	bh=p03KWlZ3VdY5EOE87pSv3vNQWyGcVN4BDxb06KPTc8o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YsPOaWHwluVyHgWdloNmPE0OdfqLbp73Bj2um46wZk4A39KVol8xGytT7/p7ViyNafRFboph6KIHEBRSoL3ztsuZVKqgvM7XRsvevX6ZJjcrXn3iduoPRIDBJPqG4jSQeieWBo6AFf30oUUZ6rEQgl4sM26SrgokYn0ZREVuELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iILYCz05; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749280281; x=1780816281;
  h=date:from:to:cc:subject:message-id;
  bh=p03KWlZ3VdY5EOE87pSv3vNQWyGcVN4BDxb06KPTc8o=;
  b=iILYCz05Sgw8kYVAqvXfnrLSPxMrpBHLrwyihrtUEpkbIf5cHzXklWS3
   6iIiMcwrd924EBh/v68ZJaj4K00I18SALXLMbB+gppiHNAjjGkpKAtIty
   l9SPEP36pC78rg0PTqAlySn2VUmFaLZmgS/K6PYGmgU2nSlxXn+yDyTyY
   2HFNq1ePrtr/a7+4se/uSS5fkzRGIDSnZyGBxqsP4Ouv9+e8QWov67mK7
   Uqo2VitYAujvDr7j3VfQXwYqsProjs4gCK9WFZaF8RmFYX7xj58xLE7Th
   cANPRegLkKkV1INZAcel0pI2cXEDdw+nIkcRn0+UrcTKsTnpydJtqAx0R
   g==;
X-CSE-ConnectionGUID: fpUsnKBoSyKgdTCZstILpg==
X-CSE-MsgGUID: 2OdPUTJfQ3W9SUhTofvWvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51334136"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="51334136"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 00:11:20 -0700
X-CSE-ConnectionGUID: k8+7Q7LNRdKGRnhXNOSITg==
X-CSE-MsgGUID: 5niabr6ISDKa4+Zq4nfjjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="151028466"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Jun 2025 00:11:19 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNni0-0005WT-1S;
	Sat, 07 Jun 2025 07:11:16 +0000
Date: Sat, 07 Jun 2025 15:10:29 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 76f6cf6676f4e2d83acdb7d93bba71340a95f5bb
Message-ID: <202506071519.UFs9aGXZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 76f6cf6676f4e2d83acdb7d93bba71340a95f5bb  efi: Drop preprocessor directives from zboot.lds

elapsed time: 867m

configs tested: 221
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20250607    clang-21
arc                   randconfig-001-20250607    gcc-15.1.0
arc                   randconfig-002-20250607    clang-21
arc                   randconfig-002-20250607    gcc-15.1.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                       imx_v4_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20250607    clang-21
arm                   randconfig-002-20250607    clang-21
arm                   randconfig-002-20250607    gcc-13.3.0
arm                   randconfig-003-20250607    clang-21
arm                   randconfig-003-20250607    gcc-15.1.0
arm                   randconfig-004-20250607    clang-21
arm                   randconfig-004-20250607    gcc-14.3.0
arm                       versatile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250607    clang-21
arm64                 randconfig-002-20250607    clang-21
arm64                 randconfig-003-20250607    clang-21
arm64                 randconfig-004-20250607    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250607    clang-21
csky                  randconfig-001-20250607    gcc-12.4.0
csky                  randconfig-002-20250607    clang-21
csky                  randconfig-002-20250607    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250607    clang-21
hexagon               randconfig-002-20250607    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250607    clang-20
i386        buildonly-randconfig-001-20250607    gcc-12
i386        buildonly-randconfig-002-20250607    gcc-12
i386        buildonly-randconfig-003-20250607    gcc-12
i386        buildonly-randconfig-004-20250607    gcc-12
i386        buildonly-randconfig-005-20250607    clang-20
i386        buildonly-randconfig-005-20250607    gcc-12
i386        buildonly-randconfig-006-20250607    clang-20
i386        buildonly-randconfig-006-20250607    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250607    gcc-12
i386                  randconfig-002-20250607    gcc-12
i386                  randconfig-003-20250607    gcc-12
i386                  randconfig-004-20250607    gcc-12
i386                  randconfig-005-20250607    gcc-12
i386                  randconfig-006-20250607    gcc-12
i386                  randconfig-007-20250607    gcc-12
i386                  randconfig-011-20250607    gcc-12
i386                  randconfig-012-20250607    gcc-12
i386                  randconfig-013-20250607    gcc-12
i386                  randconfig-014-20250607    gcc-12
i386                  randconfig-015-20250607    gcc-12
i386                  randconfig-016-20250607    gcc-12
i386                  randconfig-017-20250607    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250607    clang-21
loongarch             randconfig-001-20250607    gcc-13.3.0
loongarch             randconfig-002-20250607    clang-21
loongarch             randconfig-002-20250607    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           jazz_defconfig    gcc-15.1.0
mips                           mtx1_defconfig    clang-19
mips                         rt305x_defconfig    clang-21
mips                           xway_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                 randconfig-001-20250607    clang-21
nios2                 randconfig-001-20250607    gcc-10.5.0
nios2                 randconfig-002-20250607    clang-21
nios2                 randconfig-002-20250607    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250607    clang-21
parisc                randconfig-001-20250607    gcc-12.4.0
parisc                randconfig-002-20250607    clang-21
parisc                randconfig-002-20250607    gcc-12.4.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                       eiger_defconfig    clang-21
powerpc                   lite5200b_defconfig    clang-21
powerpc               randconfig-001-20250607    clang-21
powerpc               randconfig-001-20250607    gcc-10.5.0
powerpc               randconfig-002-20250607    clang-21
powerpc               randconfig-003-20250607    clang-21
powerpc                     tqm5200_defconfig    clang-19
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250607    clang-19
powerpc64             randconfig-001-20250607    clang-21
powerpc64             randconfig-002-20250607    clang-21
powerpc64             randconfig-003-20250607    clang-21
powerpc64             randconfig-003-20250607    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250607    clang-21
riscv                 randconfig-001-20250607    gcc-12
riscv                 randconfig-002-20250607    clang-16
riscv                 randconfig-002-20250607    gcc-12
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250607    clang-16
s390                  randconfig-001-20250607    gcc-12
s390                  randconfig-002-20250607    gcc-12
s390                  randconfig-002-20250607    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-15.1.0
sh                        dreamcast_defconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                          r7785rp_defconfig    clang-19
sh                    randconfig-001-20250607    gcc-12
sh                    randconfig-001-20250607    gcc-14.3.0
sh                    randconfig-002-20250607    gcc-12
sh                    randconfig-002-20250607    gcc-9.3.0
sh                          rsk7264_defconfig    clang-19
sparc                            alldefconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250607    gcc-10.3.0
sparc                 randconfig-001-20250607    gcc-12
sparc                 randconfig-002-20250607    gcc-12
sparc                 randconfig-002-20250607    gcc-12.4.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250607    gcc-12
sparc64               randconfig-001-20250607    gcc-9.3.0
sparc64               randconfig-002-20250607    gcc-12
sparc64               randconfig-002-20250607    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250607    clang-21
um                    randconfig-001-20250607    gcc-12
um                    randconfig-002-20250607    gcc-12
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250607    clang-20
x86_64      buildonly-randconfig-002-20250607    clang-20
x86_64      buildonly-randconfig-003-20250607    clang-20
x86_64      buildonly-randconfig-004-20250607    clang-20
x86_64      buildonly-randconfig-004-20250607    gcc-12
x86_64      buildonly-randconfig-005-20250607    clang-20
x86_64      buildonly-randconfig-005-20250607    gcc-12
x86_64      buildonly-randconfig-006-20250607    clang-20
x86_64      buildonly-randconfig-006-20250607    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20250607    clang-20
x86_64                randconfig-072-20250607    clang-20
x86_64                randconfig-073-20250607    clang-20
x86_64                randconfig-074-20250607    clang-20
x86_64                randconfig-075-20250607    clang-20
x86_64                randconfig-076-20250607    clang-20
x86_64                randconfig-077-20250607    clang-20
x86_64                randconfig-078-20250607    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250607    gcc-10.5.0
xtensa                randconfig-001-20250607    gcc-12
xtensa                randconfig-002-20250607    gcc-12
xtensa                randconfig-002-20250607    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

