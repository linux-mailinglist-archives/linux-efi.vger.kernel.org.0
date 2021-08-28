Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8D43FA323
	for <lists+linux-efi@lfdr.de>; Sat, 28 Aug 2021 04:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhH1C2C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 22:28:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:51568 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232555AbhH1C2B (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 22:28:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="217776545"
X-IronPort-AV: E=Sophos;i="5.84,358,1620716400"; 
   d="scan'208";a="217776545"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 19:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,358,1620716400"; 
   d="scan'208";a="517586376"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2021 19:27:10 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJo3q-00034J-6h; Sat, 28 Aug 2021 02:27:10 +0000
Date:   Sat, 28 Aug 2021 10:26:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 1be72c8e0786727df375f11c8178ce7e65eea20e
Message-ID: <61299ecc.FVrNN0GUrDnqEZA7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 1be72c8e0786727df375f11c8178ce7e65eea20e  efi: cper: check section header more appropriately

elapsed time: 733m

configs tested: 136
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210827
arc                            hsdk_defconfig
arm                         lpc32xx_defconfig
sh                           sh2007_defconfig
arm                         cm_x300_defconfig
mips                           ip27_defconfig
powerpc                 mpc8313_rdb_defconfig
s390                             alldefconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     tqm8548_defconfig
ia64                      gensparse_defconfig
sh                        sh7785lcr_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       netwinder_defconfig
openrisc                 simple_smp_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      tqm8xx_defconfig
arm                         at91_dt_defconfig
mips                     loongson1b_defconfig
arm                         s5pv210_defconfig
xtensa                           alldefconfig
sh                        edosk7705_defconfig
sh                           se7722_defconfig
sh                           se7751_defconfig
ia64                        generic_defconfig
sh                          rsk7201_defconfig
sh                           se7780_defconfig
powerpc                        warp_defconfig
m68k                        mvme147_defconfig
arm                          badge4_defconfig
xtensa                       common_defconfig
arm                        spear6xx_defconfig
mips                         db1xxx_defconfig
arm                         vf610m4_defconfig
m68k                        m5272c3_defconfig
xtensa                              defconfig
um                                  defconfig
powerpc                     akebono_defconfig
m68k                       m5249evb_defconfig
arm                             ezx_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         bcm2835_defconfig
powerpc                      makalu_defconfig
m68k                          multi_defconfig
arm                         lpc18xx_defconfig
arm                        vexpress_defconfig
powerpc                      ppc44x_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7343_defconfig
arm                         nhk8815_defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210827
x86_64               randconfig-a015-20210827
x86_64               randconfig-a016-20210827
x86_64               randconfig-a013-20210827
x86_64               randconfig-a012-20210827
x86_64               randconfig-a011-20210827
i386                 randconfig-a011-20210827
i386                 randconfig-a016-20210827
i386                 randconfig-a012-20210827
i386                 randconfig-a014-20210827
i386                 randconfig-a013-20210827
i386                 randconfig-a015-20210827
arc                  randconfig-r043-20210827
riscv                randconfig-r042-20210827
s390                 randconfig-r044-20210827
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210827
i386                 randconfig-c001-20210827
arm                  randconfig-c002-20210827
riscv                randconfig-c006-20210827
powerpc              randconfig-c003-20210827
x86_64               randconfig-c007-20210827
mips                 randconfig-c004-20210827
x86_64               randconfig-a005-20210827
x86_64               randconfig-a001-20210827
x86_64               randconfig-a006-20210827
x86_64               randconfig-a003-20210827
x86_64               randconfig-a004-20210827
x86_64               randconfig-a002-20210827
i386                 randconfig-a006-20210827
i386                 randconfig-a001-20210827
i386                 randconfig-a002-20210827
i386                 randconfig-a005-20210827
i386                 randconfig-a004-20210827
i386                 randconfig-a003-20210827

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
