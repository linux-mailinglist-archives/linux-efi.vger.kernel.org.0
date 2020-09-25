Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C00278506
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgIYKYY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Sep 2020 06:24:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:30951 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgIYKYY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 25 Sep 2020 06:24:24 -0400
IronPort-SDR: WmKSHHKaHP+ZxARSaACHKLn6g3/bBq3xgZ3FnBaWlruWHpuu6Ro9tGLbtf9sYTONnhWZlU15/1
 u82VxJaiAwWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="141479422"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="141479422"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 23:41:09 -0700
IronPort-SDR: W4a0n9eaSoOu9rutRKGKTDckMM2RlLMlC0kvT7kw/Qa/6GVVNHnJ+zqBiP2NRAn/wDLYrKZyve
 CrQxnyEiHmog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="512672405"
Received: from lkp-server01.sh.intel.com (HELO bb5857c652c6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2020 23:41:08 -0700
Received: from kbuild by bb5857c652c6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kLhPn-000056-ND; Fri, 25 Sep 2020 06:41:07 +0000
Date:   Fri, 25 Sep 2020 14:40:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS d0195a2a4c4d6f244939620b546036be2276ca57
Message-ID: <5f6d90d6.314MRq0wVvirDUHd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: d0195a2a4c4d6f244939620b546036be2276ca57  efi: efivars: remove deprecated sysfs interface

elapsed time: 721m

configs tested: 179
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7203_defconfig
nios2                         10m50_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                        mvme16x_defconfig
powerpc                       holly_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                               j2_defconfig
arm                       multi_v4t_defconfig
arm                        multi_v7_defconfig
powerpc                      tqm8xx_defconfig
arm                         bcm2835_defconfig
arm                           stm32_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
arm                     davinci_all_defconfig
m68k                       m5275evb_defconfig
powerpc                     tqm8548_defconfig
arm                         nhk8815_defconfig
arm                        clps711x_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
h8300                            alldefconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         rt305x_defconfig
arm                       mainstone_defconfig
powerpc64                           defconfig
xtensa                              defconfig
m68k                        stmark2_defconfig
powerpc                   motionpro_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
powerpc                     sbc8548_defconfig
sh                             shx3_defconfig
arm                           efm32_defconfig
powerpc                     akebono_defconfig
sh                         apsh4a3a_defconfig
sh                           se7712_defconfig
sh                        sh7757lcr_defconfig
powerpc                    adder875_defconfig
arc                      axs103_smp_defconfig
m68k                          amiga_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8540_defconfig
sh                      rts7751r2d1_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
mips                        bcm47xx_defconfig
mips                         tb0226_defconfig
m68k                          hp300_defconfig
sparc                            allyesconfig
sparc                       sparc32_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                         apollo_defconfig
powerpc                          g5_defconfig
mips                           rs90_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     stx_gp3_defconfig
xtensa                         virt_defconfig
arc                        nsim_700_defconfig
m68k                       bvme6000_defconfig
arm                        cerfcube_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc836x_mds_defconfig
mips                      pic32mzda_defconfig
powerpc                 mpc8560_ads_defconfig
mips                  decstation_64_defconfig
c6x                              alldefconfig
mips                 decstation_r4k_defconfig
arm                            qcom_defconfig
mips                  maltasmvp_eva_defconfig
arm                            xcep_defconfig
powerpc                  storcenter_defconfig
microblaze                      mmu_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                           se7750_defconfig
sh                        sh7763rdp_defconfig
powerpc                      pmac32_defconfig
mips                        workpad_defconfig
powerpc                     ep8248e_defconfig
mips                       capcella_defconfig
riscv                          rv32_defconfig
powerpc                     ppa8548_defconfig
x86_64                              defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200924
i386                 randconfig-a006-20200924
i386                 randconfig-a003-20200924
i386                 randconfig-a004-20200924
i386                 randconfig-a005-20200924
i386                 randconfig-a001-20200924
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
x86_64               randconfig-a011-20200925
x86_64               randconfig-a013-20200925
x86_64               randconfig-a014-20200925
x86_64               randconfig-a015-20200925
x86_64               randconfig-a012-20200925
x86_64               randconfig-a016-20200925
x86_64               randconfig-a011-20200923
x86_64               randconfig-a013-20200923
x86_64               randconfig-a014-20200923
x86_64               randconfig-a015-20200923
x86_64               randconfig-a012-20200923
x86_64               randconfig-a016-20200923
i386                 randconfig-a012-20200925
i386                 randconfig-a014-20200925
i386                 randconfig-a016-20200925
i386                 randconfig-a013-20200925
i386                 randconfig-a011-20200925
i386                 randconfig-a015-20200925
i386                 randconfig-a012-20200923
i386                 randconfig-a014-20200923
i386                 randconfig-a016-20200923
i386                 randconfig-a013-20200923
i386                 randconfig-a011-20200923
i386                 randconfig-a015-20200923
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200925
x86_64               randconfig-a003-20200925
x86_64               randconfig-a004-20200925
x86_64               randconfig-a002-20200925
x86_64               randconfig-a006-20200925
x86_64               randconfig-a001-20200925
x86_64               randconfig-a005-20200923
x86_64               randconfig-a003-20200923
x86_64               randconfig-a004-20200923
x86_64               randconfig-a002-20200923
x86_64               randconfig-a006-20200923
x86_64               randconfig-a001-20200923

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
