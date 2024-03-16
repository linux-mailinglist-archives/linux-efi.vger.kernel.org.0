Return-Path: <linux-efi+bounces-825-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D678F87D92A
	for <lists+linux-efi@lfdr.de>; Sat, 16 Mar 2024 08:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069251C20E04
	for <lists+linux-efi@lfdr.de>; Sat, 16 Mar 2024 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB85DDD3;
	Sat, 16 Mar 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2lIrNyY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB42DDC9
	for <linux-efi@vger.kernel.org>; Sat, 16 Mar 2024 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710574242; cv=none; b=IA7sfJEQkmAi6lJY0hEWLjR86qMaWiLh/Mznn4x84qTVwCGxkJwrcf0/B4bTRLfV4vx9UhOZPLgSOTdWwBxuYgxevvdUsEnFooBrnyGG1Hd5Wg2s9Qw9UnXzTUmNERsAdVXBL2psTULABnXtv4u/0U3KakTYAlz9dcfK2w6scBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710574242; c=relaxed/simple;
	bh=NGzu2ezYmrFtucnsTuQwl+3LAZMns1z0DPRwGZoBFcU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mzzvZIrUnz3f13R/mim7EceoopnhBUdhhbxvUI+gUQg+DUsbIa4tOu+YryBenRnnuI2lsO8VwWUi3Y7MHlcEM2Qhuk1C1pMHWDOPITYb182ntk87y4IgFnpSJpOKUeUjwvFSnLY5PhlpFK3k2t2blZwisndoXD2YcIj0rFJInSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2lIrNyY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710574241; x=1742110241;
  h=date:from:to:cc:subject:message-id;
  bh=NGzu2ezYmrFtucnsTuQwl+3LAZMns1z0DPRwGZoBFcU=;
  b=f2lIrNyYXk+Asjlul9mmJw48MvlljwXE6RJufpAatbNT8ZNxKRLR9q20
   VrkNBUgfu7Khj0iWsGPxgKOjfSOGqpBK7aY8JJpl7KReJ1dUEutoQjKeN
   7oB8VEjpcvjBKdWRWVNOXXFzataOP4IEZzw6Izv76NxkIkJSTrV+t8rys
   xuWXQqI8CDYHWo/e8UzFUGHw4POEFz+03f6R20/OYeKV2mVgm4m6uTwI4
   KZQvWMHvnDUue12Q69tMWzivizNpPMcBCDZdO34SG8wn0bYvpmIpuV3sf
   1qjjXfK99yTi/ugu99YPAwlz91C9iiXgb/7H1bi4o9lqCqkDW3OTNNDxy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5390093"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5390093"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 00:30:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="12987522"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Mar 2024 00:30:38 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlOV2-000FAe-0I;
	Sat, 16 Mar 2024 07:30:36 +0000
Date: Sat, 16 Mar 2024 15:30:04 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 b3810c5a2cc4a6665f7a65bed5393c75ce3f3aa2
Message-ID: <202403161500.uyjl8w9p-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: b3810c5a2cc4a6665f7a65bed5393c75ce3f3aa2  x86/efistub: Clear decompressor BSS in native EFI entrypoint

elapsed time: 724m

configs tested: 114
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
arc                   randconfig-001-20240316   gcc  
arc                   randconfig-002-20240316   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                        mvebu_v5_defconfig   gcc  
arm                        mvebu_v7_defconfig   clang
arm                             mxs_defconfig   clang
arm                         nhk8815_defconfig   clang
arm                   randconfig-001-20240316   gcc  
arm                   randconfig-002-20240316   gcc  
arm                   randconfig-003-20240316   gcc  
arm                   randconfig-004-20240316   gcc  
arm                        realview_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240316   gcc  
arm64                 randconfig-002-20240316   clang
arm64                 randconfig-003-20240316   clang
arm64                 randconfig-004-20240316   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240316   gcc  
csky                  randconfig-002-20240316   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240316   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240316   gcc  
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
mips                          ath25_defconfig   clang
mips                         bigsur_defconfig   gcc  
mips                           jazz_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                     stx_gp3_defconfig   clang
powerpc                     tqm8560_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

