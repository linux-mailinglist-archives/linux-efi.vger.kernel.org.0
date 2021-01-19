Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6743E2FAF1E
	for <lists+linux-efi@lfdr.de>; Tue, 19 Jan 2021 04:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbhASD3f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Jan 2021 22:29:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:19346 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbhASD31 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 18 Jan 2021 22:29:27 -0500
IronPort-SDR: nwPr0/JHY4rgFO5jE/mF1DF0cq7cPAq9ahdyvezoTQenXmfVKjlLhhk2FR7JolPaSjhBSpUXsV
 vf1nBC5fHi9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="175369603"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="175369603"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 19:28:45 -0800
IronPort-SDR: +lZfLBOEIVqWI4n34m0yIL+8xkS/hDEmHLyC39ZnTI7XQ6F4mx8Z+TdTmlpxbq3ZI9X413wexL
 VgVcdOhlEVpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="347039913"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2021 19:28:44 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l1hhD-0004gF-Sh; Tue, 19 Jan 2021 03:28:43 +0000
Date:   Tue, 19 Jan 2021 11:28:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS c90dd16f9fe2eb1d749d41d144695ee188bfce01
Message-ID: <600651e0.1ruWKCJVwqiNJXzK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: c90dd16f9fe2eb1d749d41d144695ee188bfce01  efi: efivars: remove deprecated sysfs interface

elapsed time: 727m

configs tested: 137
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                 kfr2r09-romimage_defconfig
sparc64                             defconfig
arm                          pxa910_defconfig
powerpc                    amigaone_defconfig
ia64                                defconfig
arm                           tegra_defconfig
arm                          collie_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                         ps3_defconfig
mips                      loongson3_defconfig
ia64                             alldefconfig
sh                          polaris_defconfig
s390                             allyesconfig
m68k                        mvme147_defconfig
arm                          tango4_defconfig
powerpc                  iss476-smp_defconfig
powerpc                      tqm8xx_defconfig
arc                          axs101_defconfig
nios2                         3c120_defconfig
powerpc                      bamboo_defconfig
ia64                             allyesconfig
powerpc                     skiroot_defconfig
nds32                               defconfig
arm                          gemini_defconfig
um                           x86_64_defconfig
arc                     nsimosci_hs_defconfig
s390                       zfcpdump_defconfig
powerpc                      ep88xc_defconfig
powerpc                      mgcoge_defconfig
arm                            xcep_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         nhk8815_defconfig
h8300                     edosk2674_defconfig
mips                     decstation_defconfig
mips                malta_qemu_32r6_defconfig
arm                         s3c2410_defconfig
sh                              ul2_defconfig
m68k                          multi_defconfig
openrisc                         alldefconfig
mips                           xway_defconfig
sparc                       sparc32_defconfig
mips                       lemote2f_defconfig
arm                          imote2_defconfig
powerpc                      pcm030_defconfig
sh                   sh7724_generic_defconfig
xtensa                    smp_lx200_defconfig
arm                             ezx_defconfig
arm                           viper_defconfig
arm                            zeus_defconfig
mips                      bmips_stb_defconfig
arm                            hisi_defconfig
arm                     am200epdkit_defconfig
arm                         vf610m4_defconfig
arm                        shmobile_defconfig
arm                       netwinder_defconfig
parisc                generic-32bit_defconfig
powerpc                      katmai_defconfig
powerpc                     tqm8548_defconfig
h8300                               defconfig
mips                          rm200_defconfig
arm                        magician_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                generic_kc705_defconfig
powerpc                     tqm5200_defconfig
m68k                         amcore_defconfig
xtensa                       common_defconfig
sh                            hp6xx_defconfig
i386                             alldefconfig
m68k                            q40_defconfig
powerpc                 mpc8560_ads_defconfig
mips                    maltaup_xpa_defconfig
csky                                defconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210118
i386                 randconfig-a001-20210118
x86_64               randconfig-a015-20210118
x86_64               randconfig-a013-20210118
x86_64               randconfig-a012-20210118
x86_64               randconfig-a016-20210118
x86_64               randconfig-a011-20210118
x86_64               randconfig-a014-20210118
i386                 randconfig-a011-20210118
i386                 randconfig-a012-20210118
i386                 randconfig-a016-20210118
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210118
x86_64               randconfig-a006-20210118
x86_64               randconfig-a001-20210118
x86_64               randconfig-a003-20210118
x86_64               randconfig-a005-20210118
x86_64               randconfig-a002-20210118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
