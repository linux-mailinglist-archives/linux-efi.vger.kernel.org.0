Return-Path: <linux-efi+bounces-867-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC021887B4B
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 02:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A1F1C20F0B
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 01:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789AB64A;
	Sun, 24 Mar 2024 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnPNLVPN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29C63B
	for <linux-efi@vger.kernel.org>; Sun, 24 Mar 2024 01:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711242746; cv=none; b=qiLViyoZ0oEkKLEjpxQo5c+9HojCvrrXr4r2pxJE9XXz+QoBWtoi2t3SOX8PepN/r7AWxQzaLhpjSIExLSgvP4dqXZu1mi/mCnO6kPDhR7yhq812fEFGUrR/KgY3tvg+BQUQpV2lDN6KarwGUxucDMOWhKEvcZ1TLqn9icm3da8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711242746; c=relaxed/simple;
	bh=hkCxR4RCSxpICTbea6vNM5Q1UfuSGhaBck3bgH66YRU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gdIBFSS2RWS0+5XakLYnDt2PY/9/5SSwTNHSrmeMlGd9jV1TzT6TLWHCpnKqr8K89sgMFCAvI6jDgOHAg/i5czkuOWayCIwO9OcBiRF6dVw9vO8CeksS9U2d0tfSEj9+KA7AcElJjn6ZhxT3FApzt+DuQ+92TFFXa/WYURZAjfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnPNLVPN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711242745; x=1742778745;
  h=date:from:to:cc:subject:message-id;
  bh=hkCxR4RCSxpICTbea6vNM5Q1UfuSGhaBck3bgH66YRU=;
  b=bnPNLVPNrLQyb5s3tB46pcMUZMTxRGlyKGfDCNTzTQUt3eWIJHTeYy4O
   w68Nv8HXzRExoSln/mTzIJBQzx7Df24NJs0J+wvii5NmJCHZSATsnqVit
   /lp/B4f0o/Ja7r1JRA3JYB3H1vlMekvkG1kwo/0xhkQDileVjTFWmK/0Q
   gSz/KHuWF87CeP0gtI1p+XFveSURIM9+35MbgDvZsN1ssSiLgnv23OU6K
   X7Fd0wK/q0OWorpYjA7JDhxgpvjVDhOK3sqGe5FaZxHIn2f9m5W8z42jm
   ejEnKuWRP5olf8frcfhLQYiauqP7akdpFfz+BOGoa710DClGmmVDxMODh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11022"; a="10071272"
X-IronPort-AV: E=Sophos;i="6.07,150,1708416000"; 
   d="scan'208";a="10071272"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2024 18:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,150,1708416000"; 
   d="scan'208";a="52717318"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Mar 2024 18:12:22 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1roCPL-000LZv-1Y;
	Sun, 24 Mar 2024 01:12:19 +0000
Date: Sun, 24 Mar 2024 09:12:02 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 8e6edb6d7924df5fb154b8b0a03ffef87d84b2d5
Message-ID: <202403240958.Hcxj8R6O-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 8e6edb6d7924df5fb154b8b0a03ffef87d84b2d5  efi: fix panic in kdump kernel

elapsed time: 726m

configs tested: 178
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
arc                   randconfig-001-20240323   gcc  
arc                   randconfig-002-20240323   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20240323   clang
arm                   randconfig-002-20240323   clang
arm                   randconfig-003-20240323   clang
arm                   randconfig-004-20240323   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240323   gcc  
arm64                 randconfig-002-20240323   gcc  
arm64                 randconfig-003-20240323   clang
arm64                 randconfig-004-20240323   clang
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
hexagon               randconfig-001-20240323   clang
hexagon               randconfig-002-20240323   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240323   gcc  
i386         buildonly-randconfig-002-20240323   clang
i386         buildonly-randconfig-003-20240323   clang
i386         buildonly-randconfig-004-20240323   gcc  
i386         buildonly-randconfig-005-20240323   gcc  
i386         buildonly-randconfig-006-20240323   clang
i386                                defconfig   clang
i386                  randconfig-001-20240323   clang
i386                  randconfig-002-20240323   clang
i386                  randconfig-003-20240323   gcc  
i386                  randconfig-004-20240323   gcc  
i386                  randconfig-005-20240323   gcc  
i386                  randconfig-006-20240323   gcc  
i386                  randconfig-011-20240323   gcc  
i386                  randconfig-012-20240323   gcc  
i386                  randconfig-013-20240323   clang
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
mips                          ath25_defconfig   clang
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
powerpc               randconfig-001-20240323   gcc  
powerpc               randconfig-002-20240323   gcc  
powerpc               randconfig-003-20240323   clang
powerpc                      tqm8xx_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240323   clang
powerpc64             randconfig-002-20240323   clang
powerpc64             randconfig-003-20240323   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240323   clang
riscv                 randconfig-002-20240323   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240323   clang
s390                  randconfig-002-20240323   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240323   gcc  
sh                    randconfig-002-20240323   gcc  
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
um                    randconfig-002-20240323   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240324   gcc  
x86_64       buildonly-randconfig-002-20240324   gcc  
x86_64       buildonly-randconfig-003-20240324   clang
x86_64       buildonly-randconfig-004-20240324   clang
x86_64       buildonly-randconfig-005-20240324   gcc  
x86_64       buildonly-randconfig-006-20240324   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240324   clang
x86_64                randconfig-002-20240324   clang
x86_64                randconfig-003-20240324   clang
x86_64                randconfig-004-20240324   clang
x86_64                randconfig-005-20240324   clang
x86_64                randconfig-006-20240324   gcc  
x86_64                randconfig-011-20240324   clang
x86_64                randconfig-012-20240324   gcc  
x86_64                randconfig-013-20240324   gcc  
x86_64                randconfig-014-20240324   gcc  
x86_64                randconfig-015-20240324   gcc  
x86_64                randconfig-016-20240324   clang
x86_64                randconfig-071-20240324   clang
x86_64                randconfig-072-20240324   gcc  
x86_64                randconfig-073-20240324   clang
x86_64                randconfig-074-20240324   clang
x86_64                randconfig-075-20240324   clang
x86_64                randconfig-076-20240324   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240323   gcc  
xtensa                randconfig-002-20240323   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

