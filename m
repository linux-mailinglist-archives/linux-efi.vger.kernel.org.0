Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D999027986C
	for <lists+linux-efi@lfdr.de>; Sat, 26 Sep 2020 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIZKdG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Sep 2020 06:33:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:52442 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZKdG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 26 Sep 2020 06:33:06 -0400
IronPort-SDR: sVIsmdzNXVCrHmS9GsAKlZ+uv3D7vA2GIjUpsSwsVZT6B5f3lj0YiWAsVejJbzhOv3VQ3KrBWK
 JtWwkvFTGk0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="141159994"
X-IronPort-AV: E=Sophos;i="5.77,305,1596524400"; 
   d="scan'208";a="141159994"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 03:33:06 -0700
IronPort-SDR: 8c1BZN8YigQ+PprhA7XsZWsTgXfOvSX4MrG58ng/mHyCO58lMYFHX7z845z82zt87QUmVdkhxz
 ez6oygryl/7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,305,1596524400"; 
   d="scan'208";a="292303854"
Received: from lkp-server01.sh.intel.com (HELO 2dda29302fe3) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2020 03:33:05 -0700
Received: from kbuild by 2dda29302fe3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kM7Vo-0000S8-Qz; Sat, 26 Sep 2020 10:33:04 +0000
Date:   Sat, 26 Sep 2020 18:32:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 336af6a4686d885a067ecea8c3c3dd129ba4fc75
Message-ID: <5f6f18c0.DEXiEg16GuZfefmQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: 336af6a4686d885a067ecea8c3c3dd129ba4fc75  efivarfs: Replace invalid slashes with exclamation marks in dentries.

elapsed time: 723m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7751_defconfig
mips                      malta_kvm_defconfig
arm                             mxs_defconfig
powerpc                mpc7448_hpc2_defconfig
h8300                            alldefconfig
mips                           gcw0_defconfig
powerpc                    ge_imp3a_defconfig
m68k                       m5208evb_defconfig
sh                          sdk7786_defconfig
powerpc                        fsp2_defconfig
nios2                               defconfig
sh                          rsk7264_defconfig
mips                    maltaup_xpa_defconfig
arm                         lpc32xx_defconfig
powerpc                     tqm8548_defconfig
powerpc                   bluestone_defconfig
arc                     haps_hs_smp_defconfig
sh                          r7785rp_defconfig
arm                           stm32_defconfig
powerpc                     taishan_defconfig
sh                          landisk_defconfig
sh                            titan_defconfig
xtensa                    smp_lx200_defconfig
arm                       versatile_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7780_defconfig
arm                         at91_dt_defconfig
m68k                        m5307c3_defconfig
mips                      bmips_stb_defconfig
m68k                       m5275evb_defconfig
mips                            gpr_defconfig
powerpc                        icon_defconfig
xtensa                         virt_defconfig
sh                                  defconfig
sh                           se7724_defconfig
arm                            hisi_defconfig
i386                                defconfig
parisc                           allyesconfig
ia64                                defconfig
mips                        jmr3927_defconfig
sparc                       sparc64_defconfig
arm                       aspeed_g4_defconfig
csky                                defconfig
powerpc                     ksi8560_defconfig
arm                            mps2_defconfig
um                            kunit_defconfig
arm                     davinci_all_defconfig
arm                         hackkit_defconfig
ia64                          tiger_defconfig
ia64                            zx1_defconfig
powerpc                        cell_defconfig
arc                          axs103_defconfig
arm                             pxa_defconfig
mips                           xway_defconfig
arm                          iop32x_defconfig
powerpc                         wii_defconfig
sparc                       sparc32_defconfig
arm                        spear3xx_defconfig
c6x                         dsk6455_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc837x_mds_defconfig
sh                            migor_defconfig
microblaze                          defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                    socrates_defconfig
arm                         vf610m4_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200925
i386                 randconfig-a006-20200925
i386                 randconfig-a003-20200925
i386                 randconfig-a004-20200925
i386                 randconfig-a005-20200925
i386                 randconfig-a001-20200925
x86_64               randconfig-a011-20200925
x86_64               randconfig-a013-20200925
x86_64               randconfig-a014-20200925
x86_64               randconfig-a015-20200925
x86_64               randconfig-a012-20200925
x86_64               randconfig-a016-20200925
i386                 randconfig-a012-20200925
i386                 randconfig-a014-20200925
i386                 randconfig-a016-20200925
i386                 randconfig-a013-20200925
i386                 randconfig-a011-20200925
i386                 randconfig-a015-20200925
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200925
x86_64               randconfig-a003-20200925
x86_64               randconfig-a004-20200925
x86_64               randconfig-a002-20200925
x86_64               randconfig-a006-20200925
x86_64               randconfig-a001-20200925

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
