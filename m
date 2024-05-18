Return-Path: <linux-efi+bounces-1049-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA778C8F7E
	for <lists+linux-efi@lfdr.de>; Sat, 18 May 2024 05:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2453BB212AF
	for <lists+linux-efi@lfdr.de>; Sat, 18 May 2024 03:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD629A2;
	Sat, 18 May 2024 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDlCguil"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643041FBA
	for <linux-efi@vger.kernel.org>; Sat, 18 May 2024 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716003277; cv=none; b=AzRwG1NnAE3hywBfZQw2Ja3/fy0JIrvPDNSGezFmzKpFHlMe2vjzFFEc1KGVa5Bb4JRNNMvepgZOYHx6sa/LCYZDi8zRZMkmD2cXVA2RLVBhHwH3qcbg04DLpA7koE+hCHAbSZDJSplys/uRUas3LF3AgTOCVHcJ3Exh+jDGL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716003277; c=relaxed/simple;
	bh=yMDMx9sqTDuP+y0yDdDPGhoBwDneRfEablxnoZFf1k0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cJhiG+m9fDtp6ZTPtPbeIwfnI5PjVEhpL8GgIaA97njqhWfBDXLute6utOGCfN4ayaFa3J0t5F1XGaUsjOuZBnsgUsQhJ8KpfPKLEP1gRCZM5i7w2U9XdLe7FkiA93s0n9kdUc8KQqBCBn5vTfknBQJcY567eZ8N79s2ZrTESSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDlCguil; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716003275; x=1747539275;
  h=date:from:to:cc:subject:message-id;
  bh=yMDMx9sqTDuP+y0yDdDPGhoBwDneRfEablxnoZFf1k0=;
  b=RDlCguil4MdMOS/5l0KJUwHNvgk/d3V4ExU+6nrxzFV4uBfbijrELlrJ
   KOBIGrdQbsAyxzwMM271XPR0llOAmuNvAXAmd8GyhwmtILk/zwWgvvmbm
   nvJbXAM10CyYi1528bamG5gWYBYOHegg3cT8+jJJLU1kn7G+4XdKptRGU
   jXmHpgQyJuAqn+km534c50UxalSyY+uqodBpI/IrCYL8lWxFxXoUcxxWB
   fnHVscu0FdidjOT3UC5nEfmXNvJS5JmaJPVjLkfXtJ2x+8d5g3uuFr1ci
   YVUtzndfiZwpGOfeGwXbjRaBgo6q3oUqjBO+btbmDl1B/QgNcuODJZdsY
   g==;
X-CSE-ConnectionGUID: kvXWVpdgTQefFdygFWO/eA==
X-CSE-MsgGUID: vQD7DabbRymYlCysMokgqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="15148626"
X-IronPort-AV: E=Sophos;i="6.08,169,1712646000"; 
   d="scan'208";a="15148626"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 20:34:35 -0700
X-CSE-ConnectionGUID: P0WYhxwnS1q49v6QyE3JyQ==
X-CSE-MsgGUID: HA4iFOB+RzSW+xFvlXQ6HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,169,1712646000"; 
   d="scan'208";a="36400963"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 17 May 2024 20:34:34 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8Aq7-0001aa-0u;
	Sat, 18 May 2024 03:34:31 +0000
Date: Sat, 18 May 2024 11:34:28 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 15aa8fb852f995dd234a57f12dfb989044968bb6
Message-ID: <202405181126.tS05xWA3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 15aa8fb852f995dd234a57f12dfb989044968bb6  x86/efistub: Omit physical KASLR when memory reservations exist

elapsed time: 737m

configs tested: 155
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
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240518   gcc  
arc                   randconfig-002-20240518   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mps2_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20240518   gcc  
arm                   randconfig-002-20240518   clang
arm                   randconfig-003-20240518   gcc  
arm                   randconfig-004-20240518   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240518   clang
arm64                 randconfig-002-20240518   gcc  
arm64                 randconfig-003-20240518   clang
arm64                 randconfig-004-20240518   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240518   gcc  
csky                  randconfig-002-20240518   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240518   clang
hexagon               randconfig-002-20240518   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240518   gcc  
i386         buildonly-randconfig-002-20240518   gcc  
i386         buildonly-randconfig-003-20240518   gcc  
i386         buildonly-randconfig-004-20240518   clang
i386         buildonly-randconfig-005-20240518   clang
i386         buildonly-randconfig-006-20240518   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240518   clang
i386                  randconfig-002-20240518   clang
i386                  randconfig-003-20240518   gcc  
i386                  randconfig-004-20240518   gcc  
i386                  randconfig-005-20240518   clang
i386                  randconfig-006-20240518   gcc  
i386                  randconfig-011-20240518   gcc  
i386                  randconfig-012-20240518   clang
i386                  randconfig-013-20240518   clang
i386                  randconfig-014-20240518   gcc  
i386                  randconfig-015-20240518   clang
i386                  randconfig-016-20240518   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240518   gcc  
loongarch             randconfig-002-20240518   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240518   gcc  
nios2                 randconfig-002-20240518   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240518   gcc  
parisc                randconfig-002-20240518   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc               randconfig-001-20240518   clang
powerpc               randconfig-002-20240518   clang
powerpc               randconfig-003-20240518   clang
powerpc                     taishan_defconfig   clang
powerpc64                        alldefconfig   clang
powerpc64             randconfig-001-20240518   gcc  
powerpc64             randconfig-002-20240518   gcc  
powerpc64             randconfig-003-20240518   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240518   gcc  
riscv                 randconfig-002-20240518   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240518   clang
s390                  randconfig-002-20240518   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240518   gcc  
sh                    randconfig-002-20240518   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240518   gcc  
sparc64               randconfig-002-20240518   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240518   clang
um                    randconfig-002-20240518   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240518   gcc  
xtensa                randconfig-002-20240518   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

