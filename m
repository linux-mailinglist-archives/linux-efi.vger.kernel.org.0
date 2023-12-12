Return-Path: <linux-efi+bounces-192-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DF080E9A1
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 12:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBCE2812C0
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667455CD19;
	Tue, 12 Dec 2023 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBucjKJ0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A3A0
	for <linux-efi@vger.kernel.org>; Tue, 12 Dec 2023 03:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702379311; x=1733915311;
  h=date:from:to:cc:subject:message-id;
  bh=/SGfiAxm+YJ2FkhGzVApi5eWb8E0JKOMNPIwqEXorJE=;
  b=mBucjKJ0WS33/O/SzlY4Zf5N8UtT7arcPQVjrjzJ93nh+QX5s3nnFFZL
   VHTb2FXYxQ+SBS31bF14DHcoY1Jb3c7KYFMOku62pms5wflwZfdRGsXoL
   HfkgP6/f8ThtIRauaYYjJqB/urIwrd73qlvisPKL5QahmAgeMuqGYcOpo
   y6nCqpxVIE8dd93LUJ1txHOnLM7pQrpQKoOR9ZBsI022BZkgNPfH23hqp
   AckJRua3ddK36LLeRXWVMHTxl0ao3vaH1xD6R69hVNY9/vwaJffiYPUmw
   b9d+hNVnCsECjHQd6DswTEi2NovkDoZscp75mFNrqqdXIv48bzRK7YmeB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480987297"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="480987297"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 03:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="14924908"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 12 Dec 2023 03:08:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rD0cl-000J5k-0r;
	Tue, 12 Dec 2023 11:08:27 +0000
Date: Tue, 12 Dec 2023 19:07:37 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 94f7f6182c72ba642c1f20111681f9cc8621c95f
Message-ID: <202312121934.vVhB0xeR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 94f7f6182c72ba642c1f20111681f9cc8621c95f  efivarfs: automatically update super block flag

elapsed time: 1459m

configs tested: 174
configs skipped: 2

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
arc                   randconfig-001-20231212   gcc  
arc                   randconfig-002-20231212   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20231212   gcc  
arm                   randconfig-002-20231212   gcc  
arm                   randconfig-003-20231212   gcc  
arm                   randconfig-004-20231212   gcc  
arm                        realview_defconfig   gcc  
arm                           sama7_defconfig   clang
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231212   gcc  
arm64                 randconfig-002-20231212   gcc  
arm64                 randconfig-003-20231212   gcc  
arm64                 randconfig-004-20231212   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231212   gcc  
csky                  randconfig-002-20231212   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231212   clang
hexagon               randconfig-002-20231212   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231211   clang
i386         buildonly-randconfig-002-20231211   clang
i386         buildonly-randconfig-003-20231211   clang
i386         buildonly-randconfig-004-20231211   clang
i386         buildonly-randconfig-005-20231211   clang
i386         buildonly-randconfig-006-20231211   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231211   clang
i386                  randconfig-002-20231211   clang
i386                  randconfig-003-20231211   clang
i386                  randconfig-004-20231211   clang
i386                  randconfig-005-20231211   clang
i386                  randconfig-006-20231211   clang
i386                  randconfig-011-20231211   gcc  
i386                  randconfig-012-20231211   gcc  
i386                  randconfig-013-20231211   gcc  
i386                  randconfig-014-20231211   gcc  
i386                  randconfig-015-20231211   gcc  
i386                  randconfig-016-20231211   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231212   gcc  
loongarch             randconfig-002-20231212   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                           ip32_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231212   gcc  
nios2                 randconfig-002-20231212   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231212   gcc  
parisc                randconfig-002-20231212   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                 linkstation_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                    mvme5100_defconfig   clang
powerpc               randconfig-001-20231212   gcc  
powerpc               randconfig-002-20231212   gcc  
powerpc               randconfig-003-20231212   gcc  
powerpc64             randconfig-001-20231212   gcc  
powerpc64             randconfig-002-20231212   gcc  
powerpc64             randconfig-003-20231212   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231212   gcc  
riscv                 randconfig-002-20231212   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231212   clang
s390                  randconfig-002-20231212   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231212   gcc  
sh                    randconfig-002-20231212   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231212   gcc  
sparc64               randconfig-002-20231212   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231212   gcc  
um                    randconfig-002-20231212   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231212   gcc  
x86_64       buildonly-randconfig-002-20231212   gcc  
x86_64       buildonly-randconfig-003-20231212   gcc  
x86_64       buildonly-randconfig-004-20231212   gcc  
x86_64       buildonly-randconfig-005-20231212   gcc  
x86_64       buildonly-randconfig-006-20231212   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231212   clang
x86_64                randconfig-002-20231212   clang
x86_64                randconfig-003-20231212   clang
x86_64                randconfig-004-20231212   clang
x86_64                randconfig-005-20231212   clang
x86_64                randconfig-006-20231212   clang
x86_64                randconfig-011-20231212   gcc  
x86_64                randconfig-012-20231212   gcc  
x86_64                randconfig-013-20231212   gcc  
x86_64                randconfig-014-20231212   gcc  
x86_64                randconfig-015-20231212   gcc  
x86_64                randconfig-016-20231212   gcc  
x86_64                randconfig-071-20231212   gcc  
x86_64                randconfig-072-20231212   gcc  
x86_64                randconfig-073-20231212   gcc  
x86_64                randconfig-074-20231212   gcc  
x86_64                randconfig-075-20231212   gcc  
x86_64                randconfig-076-20231212   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231212   gcc  
xtensa                randconfig-002-20231212   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

