Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2233FDB4
	for <lists+linux-efi@lfdr.de>; Thu, 18 Mar 2021 04:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCRDU7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Mar 2021 23:20:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:30847 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhCRDUt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Mar 2021 23:20:49 -0400
IronPort-SDR: lGlFYrilPHOmkhd9BEHZg7LpuAr8wK+ACihzfCZY75NZIGU2QCpwIFlH9hr8P2bMGKH007svj6
 HPsEhOu+9x+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="209583196"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="209583196"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 20:20:41 -0700
IronPort-SDR: WCOGWTA8W6JXgMu6cOzFXF2nKMTVbMqGHJfVEwQgPA8LLfxmtaiiqo1OwJ2T8Hi36WFhS6LbZ7
 LgQ5UBloWwug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="433655366"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2021 20:20:39 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMjDD-0000zX-9g; Thu, 18 Mar 2021 03:20:39 +0000
Date:   Thu, 18 Mar 2021 11:20:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 31bc510eb86b1a10c12281ce823d22aeb3c6275f
Message-ID: <6052c6f9.WggLAXQ8efH1PWBe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 31bc510eb86b1a10c12281ce823d22aeb3c6275f  efi: use 32-bit alignment for efi_guid_t literals

elapsed time: 728m

configs tested: 155
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                 mpc8540_ads_defconfig
arm                         at91_dt_defconfig
arc                            hsdk_defconfig
mips                        nlm_xlr_defconfig
sh                              ul2_defconfig
h8300                     edosk2674_defconfig
powerpc                     redwood_defconfig
mips                        qi_lb60_defconfig
powerpc                     taishan_defconfig
powerpc                          allmodconfig
mips                            gpr_defconfig
m68k                       bvme6000_defconfig
powerpc                      acadia_defconfig
arm                          pxa910_defconfig
sh                         ecovec24_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                            mmp2_defconfig
arm                         palmz72_defconfig
arm                          iop32x_defconfig
arm                        neponset_defconfig
powerpc                     kilauea_defconfig
parisc                generic-64bit_defconfig
powerpc                     asp8347_defconfig
arm                           tegra_defconfig
powerpc                      pmac32_defconfig
mips                           gcw0_defconfig
sh                         apsh4a3a_defconfig
powerpc                         wii_defconfig
powerpc                       eiger_defconfig
mips                       bmips_be_defconfig
m68k                        stmark2_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
arm                         assabet_defconfig
arc                              alldefconfig
arm                       multi_v4t_defconfig
arm                          moxart_defconfig
powerpc                          allyesconfig
mips                           ip32_defconfig
ia64                         bigsur_defconfig
arm                        multi_v7_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      chrp32_defconfig
mips                     loongson1b_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7619_defconfig
sh                        sh7757lcr_defconfig
arm                     eseries_pxa_defconfig
arm                            lart_defconfig
mips                      bmips_stb_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     skiroot_defconfig
sh                     sh7710voipgw_defconfig
powerpc                       ebony_defconfig
arm                      footbridge_defconfig
mips                        bcm47xx_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
arm                         lpc18xx_defconfig
arm                         lpc32xx_defconfig
alpha                            allyesconfig
sh                          lboxre2_defconfig
sh                             espt_defconfig
sh                   secureedge5410_defconfig
parisc                           allyesconfig
arc                        nsimosci_defconfig
xtensa                       common_defconfig
m68k                                defconfig
mips                       capcella_defconfig
arm                            mps2_defconfig
s390                       zfcpdump_defconfig
arm                     am200epdkit_defconfig
microblaze                          defconfig
xtensa                generic_kc705_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc837x_mds_defconfig
mips                      malta_kvm_defconfig
arm                           spitz_defconfig
sh                  sh7785lcr_32bit_defconfig
nios2                         3c120_defconfig
m68k                        mvme16x_defconfig
sh                        sh7763rdp_defconfig
powerpc                     sbc8548_defconfig
arm                      pxa255-idp_defconfig
arm                          exynos_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210317
x86_64               randconfig-a001-20210317
x86_64               randconfig-a005-20210317
x86_64               randconfig-a004-20210317
x86_64               randconfig-a003-20210317
x86_64               randconfig-a002-20210317
i386                 randconfig-a001-20210317
i386                 randconfig-a005-20210317
i386                 randconfig-a002-20210317
i386                 randconfig-a003-20210317
i386                 randconfig-a004-20210317
i386                 randconfig-a006-20210317
i386                 randconfig-a013-20210317
i386                 randconfig-a016-20210317
i386                 randconfig-a011-20210317
i386                 randconfig-a012-20210317
i386                 randconfig-a015-20210317
i386                 randconfig-a014-20210317
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210317
x86_64               randconfig-a016-20210317
x86_64               randconfig-a013-20210317
x86_64               randconfig-a014-20210317
x86_64               randconfig-a015-20210317
x86_64               randconfig-a012-20210317

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
