Return-Path: <linux-efi+bounces-418-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7414B8308C7
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jan 2024 15:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09338286C79
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jan 2024 14:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98D2110F;
	Wed, 17 Jan 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjIGRnCO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0F20DD3
	for <linux-efi@vger.kernel.org>; Wed, 17 Jan 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503071; cv=none; b=ktFxF6LSwhFoWEq6pUphUMxEMw9oNUcTe3XkWlyhS6Ayizcj8MM36RRuL7OiTaJ5aOZ5WfnldbR7FU6GCRLKZ96bWs5GzTeyxXiKy/9Z1gqulab1WYhMNIciHIPVOuTm+BB58Nf/KpGkGi6o3OR4cOuwUIzyFBCOxWifB1ZtRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503071; c=relaxed/simple;
	bh=veTNgg470P9Pf+sWicAAGt0rx9OjL8KXTFzKVI6rZn0=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:User-Agent; b=D8r0qC59y0EBRAZzVi4Vk1Lh7Bf5wGF+/nABrPquSqP5uVwVkHrvbUv1l7/7I3snTLs4bZv+Wco6PQx82EQEpuFicUMPn2Z/viIi9eNOUqW2vmQFeops6qCha1YHIfi8iYi51TjR9l81kiu4fdpvT0LKx12+CZNbuGrbVg3DFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjIGRnCO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705503069; x=1737039069;
  h=date:from:to:cc:subject:message-id;
  bh=veTNgg470P9Pf+sWicAAGt0rx9OjL8KXTFzKVI6rZn0=;
  b=FjIGRnCObG5AvOH/TuAnnghf86d3DMvGrFL8edu47lm54F56KVvZLnB4
   NKdkx6vxrUcGxmbY0XTXrLVsUGhRQffhAo5cQlNTdW4xhoGD4ebfqKQAn
   cMacHiG6S7BX5AGKMPPC0UkCrtsXqWglO/0WQwZIMoFpG4IZI4xCRGB4+
   R6fe0tbXaqcde7yk3OtodCQIhmybDqcgy7LWRHt3qELKPrc080UjG+ABm
   i4Cgze36keJ2p8zHW0/6GP4lSZAwfnmaEBSBn6xwWBiwgKsM8QmH10KiP
   8G/mzPLoxTYIXxAKeoluxUUN7YdVvWAcumlLY8OYKYz8dh1HBGhaJy/I7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="18774036"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="18774036"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 06:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="903548995"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="903548995"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jan 2024 06:51:07 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQ7Fx-00026E-03;
	Wed, 17 Jan 2024 14:51:05 +0000
Date: Wed, 17 Jan 2024 22:50:51 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 0e9ce09fde3a54d8911ceaa2063dc37d04c027ee
Message-ID: <202401172248.Qx5Y9ozS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 0e9ce09fde3a54d8911ceaa2063dc37d04c027ee  riscv/efistub: Tighten ELF relocation check

elapsed time: 1458m

configs tested: 181
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240117   gcc  
arc                   randconfig-002-20240117   gcc  
arm                               allnoconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                   randconfig-001-20240117   gcc  
arm                   randconfig-002-20240117   gcc  
arm                   randconfig-003-20240117   gcc  
arm                   randconfig-004-20240117   gcc  
arm                           sama5_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240117   gcc  
arm64                 randconfig-002-20240117   gcc  
arm64                 randconfig-003-20240117   gcc  
arm64                 randconfig-004-20240117   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240117   gcc  
csky                  randconfig-002-20240117   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240117   gcc  
i386         buildonly-randconfig-002-20240117   gcc  
i386         buildonly-randconfig-003-20240117   gcc  
i386         buildonly-randconfig-004-20240117   gcc  
i386         buildonly-randconfig-005-20240117   gcc  
i386         buildonly-randconfig-006-20240117   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240117   gcc  
i386                  randconfig-002-20240117   gcc  
i386                  randconfig-003-20240117   gcc  
i386                  randconfig-004-20240117   gcc  
i386                  randconfig-005-20240117   gcc  
i386                  randconfig-006-20240117   gcc  
i386                  randconfig-011-20240117   clang
i386                  randconfig-012-20240117   clang
i386                  randconfig-013-20240117   clang
i386                  randconfig-014-20240117   clang
i386                  randconfig-015-20240117   clang
i386                  randconfig-016-20240117   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240117   gcc  
loongarch             randconfig-002-20240117   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       alldefconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240117   gcc  
nios2                 randconfig-002-20240117   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240117   gcc  
parisc                randconfig-002-20240117   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     ksi8560_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc               randconfig-001-20240117   gcc  
powerpc               randconfig-002-20240117   gcc  
powerpc               randconfig-003-20240117   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64             randconfig-001-20240117   gcc  
powerpc64             randconfig-002-20240117   gcc  
powerpc64             randconfig-003-20240117   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20240117   gcc  
riscv                 randconfig-002-20240117   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                    randconfig-001-20240117   gcc  
sh                    randconfig-002-20240117   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240117   gcc  
sparc64               randconfig-002-20240117   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240117   gcc  
um                    randconfig-002-20240117   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240117   gcc  
x86_64       buildonly-randconfig-002-20240117   gcc  
x86_64       buildonly-randconfig-003-20240117   gcc  
x86_64       buildonly-randconfig-004-20240117   gcc  
x86_64       buildonly-randconfig-005-20240117   gcc  
x86_64       buildonly-randconfig-006-20240117   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240117   gcc  
x86_64                randconfig-012-20240117   gcc  
x86_64                randconfig-013-20240117   gcc  
x86_64                randconfig-014-20240117   gcc  
x86_64                randconfig-015-20240117   gcc  
x86_64                randconfig-016-20240117   gcc  
x86_64                randconfig-071-20240117   gcc  
x86_64                randconfig-072-20240117   gcc  
x86_64                randconfig-073-20240117   gcc  
x86_64                randconfig-074-20240117   gcc  
x86_64                randconfig-075-20240117   gcc  
x86_64                randconfig-076-20240117   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240117   gcc  
xtensa                randconfig-002-20240117   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

