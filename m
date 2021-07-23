Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79163D33E2
	for <lists+linux-efi@lfdr.de>; Fri, 23 Jul 2021 07:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhGWEYl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Jul 2021 00:24:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:11345 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhGWEYl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 23 Jul 2021 00:24:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211868138"
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="211868138"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 22:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="502374757"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jul 2021 22:05:11 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6nN0-0001G0-W0; Fri, 23 Jul 2021 05:05:10 +0000
Date:   Fri, 23 Jul 2021 13:04:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 5bb60b28ce5bee48838c3fdc667c7247e722b34d
Message-ID: <60fa4df1.RYHI938Wwk1WVsge%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 5bb60b28ce5bee48838c3fdc667c7247e722b34d  efistub: arm64: relax 2M alignment again for relocatable kernels

elapsed time: 1110m

configs tested: 146
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210722
i386                 randconfig-c001-20210723
parisc                           alldefconfig
mips                  maltasmvp_eva_defconfig
mips                           mtx1_defconfig
arm                          exynos_defconfig
mips                           ip22_defconfig
alpha                            alldefconfig
sh                          r7780mp_defconfig
arc                        nsimosci_defconfig
mips                        workpad_defconfig
sh                   sh7724_generic_defconfig
powerpc                     redwood_defconfig
sh                         apsh4a3a_defconfig
xtensa                  audio_kc705_defconfig
arm                         cm_x300_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
arc                         haps_hs_defconfig
arm                        mini2440_defconfig
m68k                          atari_defconfig
powerpc                 mpc832x_mds_defconfig
arm                           u8500_defconfig
mips                           ci20_defconfig
powerpc                           allnoconfig
powerpc                         ps3_defconfig
m68k                         apollo_defconfig
sparc                            alldefconfig
sh                          lboxre2_defconfig
s390                       zfcpdump_defconfig
sh                         ap325rxa_defconfig
x86_64                           allyesconfig
powerpc                      bamboo_defconfig
mips                       lemote2f_defconfig
m68k                          hp300_defconfig
sh                              ul2_defconfig
powerpc                      chrp32_defconfig
sh                          polaris_defconfig
mips                        bcm47xx_defconfig
nios2                               defconfig
powerpc                   motionpro_defconfig
m68k                        m5407c3_defconfig
arm                       aspeed_g5_defconfig
sh                             espt_defconfig
arm                          collie_defconfig
mips                             allyesconfig
powerpc                       ppc64_defconfig
powerpc                   microwatt_defconfig
m68k                        mvme147_defconfig
microblaze                          defconfig
mips                           ip32_defconfig
h8300                               defconfig
powerpc                        icon_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20210722
x86_64               randconfig-a006-20210722
x86_64               randconfig-a001-20210722
x86_64               randconfig-a005-20210722
x86_64               randconfig-a004-20210722
x86_64               randconfig-a002-20210722
i386                 randconfig-a005-20210722
i386                 randconfig-a003-20210722
i386                 randconfig-a004-20210722
i386                 randconfig-a002-20210722
i386                 randconfig-a001-20210722
i386                 randconfig-a006-20210722
i386                 randconfig-a005-20210723
i386                 randconfig-a003-20210723
i386                 randconfig-a004-20210723
i386                 randconfig-a002-20210723
i386                 randconfig-a001-20210723
i386                 randconfig-a006-20210723
i386                 randconfig-a016-20210722
i386                 randconfig-a013-20210722
i386                 randconfig-a012-20210722
i386                 randconfig-a011-20210722
i386                 randconfig-a014-20210722
i386                 randconfig-a015-20210722
i386                 randconfig-a016-20210723
i386                 randconfig-a013-20210723
i386                 randconfig-a012-20210723
i386                 randconfig-a011-20210723
i386                 randconfig-a014-20210723
i386                 randconfig-a015-20210723
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210723
x86_64               randconfig-c001-20210722
x86_64               randconfig-b001-20210722
x86_64               randconfig-a011-20210722
x86_64               randconfig-a016-20210722
x86_64               randconfig-a013-20210722
x86_64               randconfig-a014-20210722
x86_64               randconfig-a012-20210722
x86_64               randconfig-a015-20210722
x86_64               randconfig-a003-20210723
x86_64               randconfig-a006-20210723
x86_64               randconfig-a001-20210723
x86_64               randconfig-a005-20210723
x86_64               randconfig-a004-20210723
x86_64               randconfig-a002-20210723

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
