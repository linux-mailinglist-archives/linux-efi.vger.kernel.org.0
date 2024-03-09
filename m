Return-Path: <linux-efi+bounces-791-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E120A876F74
	for <lists+linux-efi@lfdr.de>; Sat,  9 Mar 2024 08:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B03B20E59
	for <lists+linux-efi@lfdr.de>; Sat,  9 Mar 2024 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA02EAE9;
	Sat,  9 Mar 2024 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnWkPmvo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A42E64C
	for <linux-efi@vger.kernel.org>; Sat,  9 Mar 2024 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709967679; cv=none; b=NDohTFnXyq59eWdOT2MEv9Dl//QpDslRk/Rp36UGCUhFps5HKNFtxTXnbZANf4L7FyK7EvEiWc3QbUjFS+KD2fMjAAEyiP/nKrT9HLMbY+B4IwrXQdepdGFWCF7kNllB6Z6TtbQScheZTX30FN8dEyJ5whGGTqvg8Vf/Y99Vtus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709967679; c=relaxed/simple;
	bh=jRFbNPqWobIZo1l/+OsgbQQIDGhsa3P6VCCDddVwWgg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z/OAAx196oaPtihFf1JbUfm2so43lN+jBqSfcfqHX1OLj6+L/LpsBkiy12f+F8omuT94I3LYYtm3HUsRxRHUlIW4svrxBcPFkTjzIAmdZVqIZOClyyj1Z4glViiYBnWtxPpI1hYGSdNmCrjCrKT+Tgmkvvj8kWkiF2sfNfHRd7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnWkPmvo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709967678; x=1741503678;
  h=date:from:to:cc:subject:message-id;
  bh=jRFbNPqWobIZo1l/+OsgbQQIDGhsa3P6VCCDddVwWgg=;
  b=hnWkPmvolJebeNVW3alisemvqw7CI149Q1qPlcZOTfEaA8QKz1yC5eWi
   DjzRnWiOVO2jUJdCF/a4REeZ+I9aj13RI3OASfT7CYNUuuAudtDnhQsN/
   M2LZEdyOGEDjk8IHMAIfctZfXVR5E07yiIN70bn+ZuNd8llhpvnYtEUlC
   5iXtUCxr1BZ8TIlMwyFCYHrunDW/JzPH2v/I9eqRSIbqGuqCyL+6OB1NG
   eoKvb62zKZAV5osOMrclH0ZP4HnrraSBJH/PHrZ/E4+vx7IHb/ONXi9lt
   RrnzAcpROKpuu2GwpjW0aleiuS9df8cM9NXTabOO9V7+nzHsuezATC6Ye
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4876216"
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="4876216"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 23:01:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="10589324"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Mar 2024 23:01:15 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riqhl-00075c-1s;
	Sat, 09 Mar 2024 07:01:13 +0000
Date: Sat, 09 Mar 2024 15:01:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS WITH WARNING
 4749cfc7ffaa827b6ecc916ab8d09bae718688bc
Message-ID: <202403091507.kyEoVSL3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 4749cfc7ffaa827b6ecc916ab8d09bae718688bc  virt: efi_secret: Convert to platform remove callback returning void

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202403091104.pfjTGT8z-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/firmware/efi/libstub/efi-stub-helper.c:225:26: warning: field tagged_event within 'struct efistub_measured_event' is less aligned than 'TCG_PCClientTaggedEvent' (aka 'struct tdTCG_PCClientTaggedEvent') and is usually due to 'struct efistub_measured_event' being packed, which can lead to unaligned accesses [-Wunaligned-access]

Warning ids grouped by kconfigs:

clang_recent_errors
`-- arm-randconfig-001-20240309
    `-- drivers-firmware-efi-libstub-efi-stub-helper.c:warning:field-tagged_event-within-struct-efistub_measured_event-is-less-aligned-than-TCG_PCClientTaggedEvent-(aka-struct-tdTCG_PCClientTaggedEvent-)-and-

elapsed time: 1193m

configs tested: 153
configs skipped: 4

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240309   gcc  
arc                   randconfig-002-20240309   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                            mps2_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-002-20240309   gcc  
arm                   randconfig-004-20240309   gcc  
arm                        spear6xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240309   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240309   gcc  
csky                  randconfig-002-20240309   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240309   clang
i386         buildonly-randconfig-002-20240309   clang
i386                                defconfig   clang
i386                  randconfig-003-20240309   clang
i386                  randconfig-004-20240309   clang
i386                  randconfig-005-20240309   clang
i386                  randconfig-013-20240309   clang
i386                  randconfig-014-20240309   clang
i386                  randconfig-015-20240309   clang
i386                  randconfig-016-20240309   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240309   gcc  
loongarch             randconfig-002-20240309   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                      pic32mzda_defconfig   gcc  
mips                          rb532_defconfig   clang
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240309   gcc  
nios2                 randconfig-002-20240309   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240309   gcc  
parisc                randconfig-002-20240309   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                      makalu_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc                      ppc40x_defconfig   clang
powerpc               randconfig-001-20240309   gcc  
powerpc64             randconfig-001-20240309   gcc  
powerpc64             randconfig-002-20240309   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240309   gcc  
riscv                 randconfig-002-20240309   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20240309   gcc  
sh                    randconfig-002-20240309   gcc  
sh                          rsk7269_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240309   gcc  
sparc64               randconfig-002-20240309   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240309   clang
x86_64       buildonly-randconfig-003-20240309   clang
x86_64       buildonly-randconfig-006-20240309   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240309   clang
x86_64                randconfig-003-20240309   clang
x86_64                randconfig-005-20240309   clang
x86_64                randconfig-011-20240309   clang
x86_64                randconfig-012-20240309   clang
x86_64                randconfig-013-20240309   clang
x86_64                randconfig-076-20240309   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240309   gcc  
xtensa                randconfig-002-20240309   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

