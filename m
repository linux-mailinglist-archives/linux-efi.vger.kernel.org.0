Return-Path: <linux-efi+bounces-981-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DC58B27A6
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 19:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D8CB213A0
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5130714E2CD;
	Thu, 25 Apr 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChT/Srxf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0851482EF
	for <linux-efi@vger.kernel.org>; Thu, 25 Apr 2024 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714066632; cv=none; b=n1RHNXHhgSU8nQM7scxuP9dX8A0rcU0lWylSDo+/b9j0PFuKVDx9hXWuIED7pA45tEYEiHrAORCdP4ege5LDjeRmelkkUdvOBHPY0+Y4lQe3In37apPoqLhK7ELNBqh9NFKJ0GymV5EuMTZXHm3R8XgmKjf3/ioBIGBE6pX2wQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714066632; c=relaxed/simple;
	bh=0epV5HRm8/mnKhOEL1lls3LZw/nCThK8S+rYbqMeMlA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IiRyPqBylGivQ10yu5V9iUQghvcdCBLJXsluVowpBTOD3SZcsU3IkHc/zpllJDM06wB1t1iv5mskrUa/fqLNltB2vlakPlEcKvYomUa8M0PuPFs4KITmrasQbODYFpPXMjsSsvBl0Vi3lIap76J/J6eESPKyQA82FP9m8if0cAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChT/Srxf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714066630; x=1745602630;
  h=date:from:to:cc:subject:message-id;
  bh=0epV5HRm8/mnKhOEL1lls3LZw/nCThK8S+rYbqMeMlA=;
  b=ChT/SrxfqZsDYY53iMPyyOqiaHtg15F70yntMPEPCZggozTdS41cXG6F
   nH0u8yAobNgY/pZE30TqBrucNBwt0d5cRquqhOl3xK2SR+4CFu/mnNZFq
   LMoTnMguf8Q0LC2tlNBpIlMYTDwrsoAaGeNO/+s7mJQPXUh0YQG+QJoor
   FV40mXbUFZT/DF2oxv8Xh0Lso2f54J66XCD7oUh5DANcqq6Sr6ZbeNxEu
   k5PrthhBbloEwT0ILokvF1t3PqFUFpF+CaqvYbYnAmlpUtCqEdUzOkUoJ
   RfwUM5T9QEm9xkw9BM9RJfNYXyAEAj+8Hh3SqlZZlCemmLAUs0uzQZcAh
   Q==;
X-CSE-ConnectionGUID: 8H7K4NdHRyaGx6RodjXDPg==
X-CSE-MsgGUID: wKAhZE1HT9W+TiX1eBuo8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9892208"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9892208"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:37:09 -0700
X-CSE-ConnectionGUID: NQEd+EpXR2qGy3tLrNfYTA==
X-CSE-MsgGUID: A35GPHQ2QqCXqRfC5ZsRrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25030775"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 25 Apr 2024 10:37:08 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s031t-0002f3-2r;
	Thu, 25 Apr 2024 17:37:05 +0000
Date: Fri, 26 Apr 2024 01:36:08 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 1c5a1627f48105cbab81d25ec2f72232bfaa8185
Message-ID: <202404260105.9AygrL3I-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 1c5a1627f48105cbab81d25ec2f72232bfaa8185  efi/unaccepted: touch soft lockup during memory accept

elapsed time: 1459m

configs tested: 126
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
arc                          axs101_defconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240425   clang
arm                   randconfig-002-20240425   clang
arm                   randconfig-003-20240425   clang
arm                   randconfig-004-20240425   clang
arm                         s3c6400_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240425   clang
hexagon               randconfig-002-20240425   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240425   gcc  
i386         buildonly-randconfig-003-20240425   gcc  
i386         buildonly-randconfig-006-20240425   gcc  
i386                  randconfig-004-20240425   gcc  
i386                  randconfig-013-20240425   gcc  
i386                  randconfig-014-20240425   gcc  
i386                  randconfig-015-20240425   gcc  
i386                  randconfig-016-20240425   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                     loongson1c_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-003-20240425   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
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
sh                 kfr2r09-romimage_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240425   clang
um                           x86_64_defconfig   clang
x86_64       buildonly-randconfig-002-20240425   gcc  
x86_64       buildonly-randconfig-006-20240425   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   clang
x86_64                randconfig-004-20240425   gcc  
x86_64                randconfig-005-20240425   gcc  
x86_64                randconfig-011-20240425   gcc  
x86_64                randconfig-014-20240425   gcc  
x86_64                randconfig-072-20240425   gcc  
x86_64                randconfig-073-20240425   gcc  
x86_64                randconfig-076-20240425   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

