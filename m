Return-Path: <linux-efi+bounces-282-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FCA81D8CE
	for <lists+linux-efi@lfdr.de>; Sun, 24 Dec 2023 12:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D071C20BD5
	for <lists+linux-efi@lfdr.de>; Sun, 24 Dec 2023 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0415A20F5;
	Sun, 24 Dec 2023 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtmBdJ9K"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214620F9
	for <linux-efi@vger.kernel.org>; Sun, 24 Dec 2023 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703416070; x=1734952070;
  h=date:from:to:cc:subject:message-id;
  bh=XxS4ic/Ij65QaEoSbfhlQyeTzI8vD+ZoXPt039SnjxQ=;
  b=UtmBdJ9Kmjt16Gx0sFKzKzsqorO4Px/nJpaOxzxxcy8Mc1dHADVq0eHf
   b19otAtAhkQknwQE7g/I2j72NGYCgjlliFSOgLkZM//JC4efEqBnqkZJG
   rIa0Xk57crdQiX0k8pHwzl6IglXPOwP+Zbsvbpk0Sbyhzbtsbr16A4EmV
   xxlbcEmO+l8I5oiJ9cF7ALEcCxIz6EOhq5gIr1F+q6XYksyXmGDQ2E0Cb
   Ng4lEo8Uo3e3eaAYcUDWN/I4M0Tz24qhmAazCtGjsvAJ/r8QRmKvI8S9O
   tMuPo+m9+4ExRa/OhxKgnQ6zouNeYgF24n9MG20WlXqaY7H9SDQ8e9ZeD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="393396802"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="393396802"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 03:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="847998648"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="847998648"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Dec 2023 03:07:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHMJl-000CBP-0z;
	Sun, 24 Dec 2023 11:07:16 +0000
Date: Sun, 24 Dec 2023 19:04:27 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 4afa688d7141ae7a166d32224abbfd536acccfca
Message-ID: <202312241924.08THphUU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 4afa688d7141ae7a166d32224abbfd536acccfca  efi: memmap: fix kernel-doc warnings

elapsed time: 2908m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231224   gcc  
arc                   randconfig-002-20231224   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20231224   gcc  
arm                   randconfig-002-20231224   gcc  
arm                   randconfig-003-20231224   gcc  
arm                   randconfig-004-20231224   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231224   gcc  
arm64                 randconfig-002-20231224   gcc  
arm64                 randconfig-003-20231224   gcc  
arm64                 randconfig-004-20231224   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231224   gcc  
csky                  randconfig-002-20231224   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231224   clang
hexagon               randconfig-002-20231224   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231224   gcc  
i386         buildonly-randconfig-002-20231224   gcc  
i386         buildonly-randconfig-003-20231224   gcc  
i386         buildonly-randconfig-004-20231224   gcc  
i386         buildonly-randconfig-005-20231224   gcc  
i386         buildonly-randconfig-006-20231224   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231224   gcc  
i386                  randconfig-002-20231224   gcc  
i386                  randconfig-003-20231224   gcc  
i386                  randconfig-004-20231224   gcc  
i386                  randconfig-005-20231224   gcc  
i386                  randconfig-006-20231224   gcc  
i386                  randconfig-011-20231224   clang
i386                  randconfig-012-20231224   clang
i386                  randconfig-013-20231224   clang
i386                  randconfig-014-20231224   clang
i386                  randconfig-015-20231224   clang
i386                  randconfig-016-20231224   clang
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231224   gcc  
loongarch             randconfig-002-20231224   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231224   gcc  
nios2                 randconfig-002-20231224   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231224   gcc  
parisc                randconfig-002-20231224   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20231224   gcc  
powerpc               randconfig-002-20231224   gcc  
powerpc               randconfig-003-20231224   gcc  
powerpc64             randconfig-001-20231224   gcc  
powerpc64             randconfig-002-20231224   gcc  
powerpc64             randconfig-003-20231224   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                 randconfig-001-20231224   gcc  
riscv                 randconfig-002-20231224   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20231224   clang
s390                  randconfig-002-20231224   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                    randconfig-001-20231224   gcc  
sh                    randconfig-002-20231224   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20231224   gcc  
sparc64               randconfig-002-20231224   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20231224   gcc  
um                    randconfig-002-20231224   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231224   gcc  
xtensa                randconfig-002-20231224   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

