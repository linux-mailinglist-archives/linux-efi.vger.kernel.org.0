Return-Path: <linux-efi+bounces-569-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED1856B5E
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 18:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC06B1F214A3
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33D6136990;
	Thu, 15 Feb 2024 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NizVH7Fe"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1E21339A7
	for <linux-efi@vger.kernel.org>; Thu, 15 Feb 2024 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019011; cv=none; b=D01deG2RTocxWspELGSmrCxlf4Y3qI0RUk5m57x+pZ9aBF2UXHLAHjFRbzBHA6im1tUNtG1miw8iFS2Jr1aG1w284o5Fg5rL62GxUwlyr1//79k05nEDrF/DMv1uxvdutv6/dwEUBihb6YODwNFBBbi9FhpCiqckSPtDYTmixn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019011; c=relaxed/simple;
	bh=mx7PZJZ5OHLdZ5TKzdx45a3KI2Ugu1ECkjDg98uORAM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hBdIaMhcTjmGTDbVMm2+72L13/Nqe2dgcd5kAN/O+fXuiDCu9dFk77fAO2V+6zwmZHFEaSpCKX0WO+TVfY7PgiA9nnefufWQOuH8jlcQzCCD0z3bXvyA1F9obf3Xk1tAoBE1JSD+CNcHxcVFavfd3Oc+QDn47m+gEJKwFgJK2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NizVH7Fe; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708019011; x=1739555011;
  h=date:from:to:cc:subject:message-id;
  bh=mx7PZJZ5OHLdZ5TKzdx45a3KI2Ugu1ECkjDg98uORAM=;
  b=NizVH7FeeFXPtXs6tP4T2/8M29Fc9vy8S8E6BIft8ss82lnLu80MbdPR
   cE+QtO8YV+uLRahJsfCi3SiExBON2upzGEbWCSLT24Hy4G7sWW57nZBC+
   yuEtcpwr2tTrPSfg0pEejb8igUIicU3NQTmIq2SXSbYAmn1YrdI2DJ9mc
   vO8GU5QtIEobYENWkSaLSbR15cs4WQ7hxWoPIgXKaqdTS5zSQ32/aMpUE
   TnBKGGsLy7wwU2UlC1QxUFiEYbJe44jZVZIMe08IVIahUXsYIeAMy6wQ/
   AUEraG3Qdw7AjGG8rshy1lo39/vzgRWesKS1LR2NYTjHIxL5BudFmACqO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2260465"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2260465"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="34645765"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 15 Feb 2024 09:43:28 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rafle-0000h0-07;
	Thu, 15 Feb 2024 17:43:26 +0000
Date: Fri, 16 Feb 2024 01:42:28 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 e258b85f1c3c9122fe4592a0cf99669c60df35e1
Message-ID: <202402160126.QNLVxcQg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: e258b85f1c3c9122fe4592a0cf99669c60df35e1  efivarfs: Request at most 512 bytes for variable names

elapsed time: 1460m

configs tested: 142
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240215   gcc  
arc                   randconfig-002-20240215   gcc  
arm                               allnoconfig   clang
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                      integrator_defconfig   clang
arm                   randconfig-001-20240215   clang
arm                   randconfig-002-20240215   gcc  
arm                   randconfig-003-20240215   gcc  
arm                   randconfig-004-20240215   gcc  
arm                        shmobile_defconfig   gcc  
arm                        spear6xx_defconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240215   clang
arm64                 randconfig-002-20240215   clang
arm64                 randconfig-003-20240215   gcc  
arm64                 randconfig-004-20240215   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240215   gcc  
csky                  randconfig-002-20240215   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240215   clang
hexagon               randconfig-002-20240215   clang
i386         buildonly-randconfig-001-20240215   clang
i386         buildonly-randconfig-002-20240215   clang
i386         buildonly-randconfig-003-20240215   clang
i386         buildonly-randconfig-004-20240215   clang
i386         buildonly-randconfig-005-20240215   clang
i386         buildonly-randconfig-006-20240215   clang
i386                  randconfig-001-20240215   gcc  
i386                  randconfig-002-20240215   gcc  
i386                  randconfig-003-20240215   clang
i386                  randconfig-004-20240215   gcc  
i386                  randconfig-005-20240215   gcc  
i386                  randconfig-006-20240215   gcc  
i386                  randconfig-011-20240215   clang
i386                  randconfig-012-20240215   clang
i386                  randconfig-013-20240215   gcc  
i386                  randconfig-014-20240215   gcc  
i386                  randconfig-015-20240215   clang
i386                  randconfig-016-20240215   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240215   gcc  
loongarch             randconfig-002-20240215   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240215   gcc  
nios2                 randconfig-002-20240215   gcc  
openrisc                         allyesconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20240215   gcc  
parisc                randconfig-002-20240215   gcc  
powerpc                          allmodconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                      makalu_defconfig   clang
powerpc               randconfig-001-20240215   gcc  
powerpc               randconfig-002-20240215   clang
powerpc               randconfig-003-20240215   clang
powerpc                     tqm8555_defconfig   clang
powerpc64             randconfig-001-20240215   clang
powerpc64             randconfig-002-20240215   gcc  
powerpc64             randconfig-003-20240215   clang
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
riscv                 randconfig-001-20240215   gcc  
riscv                 randconfig-002-20240215   gcc  
s390                             alldefconfig   gcc  
s390                             allmodconfig   clang
s390                             allyesconfig   gcc  
s390                  randconfig-001-20240215   clang
s390                  randconfig-002-20240215   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240215   gcc  
sh                    randconfig-002-20240215   gcc  
sh                           se7343_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20240215   gcc  
sparc64               randconfig-002-20240215   gcc  
um                               allmodconfig   clang
um                               allyesconfig   gcc  
um                    randconfig-001-20240215   gcc  
um                    randconfig-002-20240215   gcc  
x86_64       buildonly-randconfig-001-20240215   clang
x86_64       buildonly-randconfig-002-20240215   clang
x86_64       buildonly-randconfig-003-20240215   gcc  
x86_64       buildonly-randconfig-004-20240215   gcc  
x86_64       buildonly-randconfig-005-20240215   clang
x86_64       buildonly-randconfig-006-20240215   gcc  
x86_64                randconfig-001-20240215   clang
x86_64                randconfig-002-20240215   clang
x86_64                randconfig-003-20240215   gcc  
x86_64                randconfig-004-20240215   clang
x86_64                randconfig-005-20240215   clang
x86_64                randconfig-006-20240215   clang
x86_64                randconfig-011-20240215   gcc  
x86_64                randconfig-012-20240215   gcc  
x86_64                randconfig-013-20240215   gcc  
x86_64                randconfig-014-20240215   gcc  
x86_64                randconfig-015-20240215   gcc  
x86_64                randconfig-016-20240215   clang
x86_64                randconfig-071-20240215   clang
x86_64                randconfig-072-20240215   clang
x86_64                randconfig-073-20240215   gcc  
x86_64                randconfig-074-20240215   gcc  
x86_64                randconfig-075-20240215   clang
x86_64                randconfig-076-20240215   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240215   gcc  
xtensa                randconfig-002-20240215   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

