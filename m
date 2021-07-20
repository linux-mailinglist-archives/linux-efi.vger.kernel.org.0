Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6C3D03C0
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 23:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhGTUcf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 16:32:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:38973 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234908AbhGTU1h (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 16:27:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272443360"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="272443360"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 14:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="432306840"
Received: from lkp-server02.sh.intel.com (HELO 1b5a72ed9419) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2021 14:07:10 -0700
Received: from kbuild by 1b5a72ed9419 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5wxK-0000P1-AT; Tue, 20 Jul 2021 21:07:10 +0000
Date:   Wed, 21 Jul 2021 05:06:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 47e1e233e9d822dfda068383fb9a616451bda703
Message-ID: <60f73acd.nN5YgscQrX1XA458%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 47e1e233e9d822dfda068383fb9a616451bda703  efi/mokvar: Reserve the table only if it is in boot services data

elapsed time: 725m

configs tested: 139
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         cm_x300_defconfig
sh                          rsk7264_defconfig
sh                           se7724_defconfig
powerpc                     ep8248e_defconfig
powerpc                     pseries_defconfig
powerpc                 mpc834x_mds_defconfig
arm                  colibri_pxa300_defconfig
arm                       netwinder_defconfig
powerpc                    gamecube_defconfig
riscv                               defconfig
m68k                           sun3_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                          allyesconfig
mips                     loongson1c_defconfig
xtensa                          iss_defconfig
sh                           se7343_defconfig
xtensa                  nommu_kc705_defconfig
arm                        mvebu_v5_defconfig
arm                         lubbock_defconfig
arm                   milbeaut_m10v_defconfig
um                               alldefconfig
powerpc                  iss476-smp_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
sh                          rsk7203_defconfig
arm                         lpc32xx_defconfig
sh                              ul2_defconfig
nds32                            alldefconfig
mips                           ip28_defconfig
arm                          pxa3xx_defconfig
arm                             rpc_defconfig
powerpc                      katmai_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 xes_mpc85xx_defconfig
um                           x86_64_defconfig
sh                               j2_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            mmp2_defconfig
arm                         bcm2835_defconfig
powerpc                      mgcoge_defconfig
riscv                            alldefconfig
microblaze                          defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
arc                      axs103_smp_defconfig
xtensa                       common_defconfig
powerpc                     kilauea_defconfig
powerpc                   motionpro_defconfig
m68k                          atari_defconfig
sh                ecovec24-romimage_defconfig
arm                    vt8500_v6_v7_defconfig
mips                           ci20_defconfig
arm                        trizeps4_defconfig
h8300                     edosk2674_defconfig
powerpc                     tqm8548_defconfig
sh                   rts7751r2dplus_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210720
x86_64               randconfig-a006-20210720
x86_64               randconfig-a001-20210720
x86_64               randconfig-a005-20210720
x86_64               randconfig-a004-20210720
x86_64               randconfig-a002-20210720
i386                 randconfig-a005-20210720
i386                 randconfig-a003-20210720
i386                 randconfig-a004-20210720
i386                 randconfig-a002-20210720
i386                 randconfig-a001-20210720
i386                 randconfig-a006-20210720
i386                 randconfig-a004-20210719
i386                 randconfig-a006-20210719
i386                 randconfig-a003-20210719
i386                 randconfig-a002-20210719
i386                 randconfig-a005-20210719
i386                 randconfig-a001-20210719
i386                 randconfig-a016-20210720
i386                 randconfig-a013-20210720
i386                 randconfig-a012-20210720
i386                 randconfig-a014-20210720
i386                 randconfig-a011-20210720
i386                 randconfig-a015-20210720
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210720
x86_64               randconfig-a011-20210720
x86_64               randconfig-a016-20210720
x86_64               randconfig-a013-20210720
x86_64               randconfig-a014-20210720
x86_64               randconfig-a012-20210720
x86_64               randconfig-a015-20210720

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
