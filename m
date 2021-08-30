Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34AC3FAFE8
	for <lists+linux-efi@lfdr.de>; Mon, 30 Aug 2021 04:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhH3CtF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Aug 2021 22:49:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:53060 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234529AbhH3CtF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 29 Aug 2021 22:49:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="218238204"
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="218238204"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 19:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="459054939"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2021 19:48:10 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKXLF-0004ju-Nn; Mon, 30 Aug 2021 02:48:09 +0000
Date:   Mon, 30 Aug 2021 10:47:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 07b98091e0ab5049542997f6fbc08f98efa2ec1d
Message-ID: <612c46c5.BXy00erU4vdKFJsw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 07b98091e0ab5049542997f6fbc08f98efa2ec1d  efi/libstub: Simplify "Exiting bootservices" message

elapsed time: 722m

configs tested: 176
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210830
i386                 randconfig-c001-20210829
mips                 randconfig-c004-20210829
powerpc                     tqm5200_defconfig
xtensa                    smp_lx200_defconfig
arm                        realview_defconfig
arm                          ep93xx_defconfig
mips                        qi_lb60_defconfig
sparc64                          alldefconfig
arm                          iop32x_defconfig
sh                           sh2007_defconfig
arm                          ixp4xx_defconfig
nios2                         10m50_defconfig
sparc                       sparc64_defconfig
arm                     am200epdkit_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    sam440ep_defconfig
alpha                            alldefconfig
m68k                            q40_defconfig
arm                         mv78xx0_defconfig
arm                          simpad_defconfig
arm                          collie_defconfig
mips                        workpad_defconfig
powerpc                    amigaone_defconfig
powerpc                     sbc8548_defconfig
arm                       spear13xx_defconfig
sh                           se7780_defconfig
powerpc                 xes_mpc85xx_defconfig
s390                             allyesconfig
powerpc                       holly_defconfig
arm                        multi_v5_defconfig
powerpc                     mpc512x_defconfig
mips                         tb0219_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           sunxi_defconfig
sh                          r7780mp_defconfig
arm                          badge4_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc8315_rdb_defconfig
um                           x86_64_defconfig
openrisc                            defconfig
arm                         vf610m4_defconfig
xtensa                          iss_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                   rts7751r2dplus_defconfig
arm                         lpc18xx_defconfig
sparc64                             defconfig
powerpc                      obs600_defconfig
mips                     cu1000-neo_defconfig
sh                            shmin_defconfig
microblaze                      mmu_defconfig
m68k                        m5307c3_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                      ppc44x_defconfig
mips                        nlm_xlp_defconfig
mips                           gcw0_defconfig
sh                               alldefconfig
riscv                               defconfig
arm                         orion5x_defconfig
arm                         shannon_defconfig
arm                         hackkit_defconfig
nios2                         3c120_defconfig
riscv                            allmodconfig
powerpc                     powernv_defconfig
powerpc                  storcenter_defconfig
mips                         tb0226_defconfig
openrisc                         alldefconfig
arm                           sama5_defconfig
mips                        bcm47xx_defconfig
arm                            dove_defconfig
riscv                          rv32_defconfig
sh                          kfr2r09_defconfig
sparc                            alldefconfig
parisc                generic-32bit_defconfig
arm                        keystone_defconfig
arm                          pxa168_defconfig
mips                         rt305x_defconfig
arc                     haps_hs_smp_defconfig
arm                        shmobile_defconfig
mips                           rs90_defconfig
arm                            hisi_defconfig
x86_64                              defconfig
arm                       imx_v4_v5_defconfig
mips                     decstation_defconfig
powerpc64                           defconfig
mips                      loongson3_defconfig
arm                         bcm2835_defconfig
mips                  maltasmvp_eva_defconfig
sh                        apsh4ad0a_defconfig
m68k                             allyesconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210829
x86_64               randconfig-a016-20210829
x86_64               randconfig-a015-20210829
x86_64               randconfig-a012-20210829
x86_64               randconfig-a013-20210829
x86_64               randconfig-a011-20210829
i386                 randconfig-a016-20210830
i386                 randconfig-a011-20210830
i386                 randconfig-a015-20210830
i386                 randconfig-a014-20210830
i386                 randconfig-a012-20210830
i386                 randconfig-a013-20210830
i386                 randconfig-a011-20210829
i386                 randconfig-a016-20210829
i386                 randconfig-a012-20210829
i386                 randconfig-a014-20210829
i386                 randconfig-a013-20210829
i386                 randconfig-a015-20210829
arc                  randconfig-r043-20210829
riscv                randconfig-r042-20210829
s390                 randconfig-r044-20210829
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210829
i386                 randconfig-c001-20210829
arm                  randconfig-c002-20210829
riscv                randconfig-c006-20210829
x86_64               randconfig-c007-20210829
powerpc              randconfig-c003-20210829
mips                 randconfig-c004-20210829
x86_64               randconfig-a001-20210829
x86_64               randconfig-a006-20210829
x86_64               randconfig-a005-20210829
x86_64               randconfig-a003-20210829
x86_64               randconfig-a004-20210829
x86_64               randconfig-a002-20210829
i386                 randconfig-a001-20210829
i386                 randconfig-a006-20210829
i386                 randconfig-a005-20210829
i386                 randconfig-a004-20210829
i386                 randconfig-a003-20210829
hexagon              randconfig-r041-20210829
hexagon              randconfig-r045-20210829

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
