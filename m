Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF227E3B8
	for <lists+linux-efi@lfdr.de>; Wed, 30 Sep 2020 10:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgI3I32 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Sep 2020 04:29:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:10651 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgI3I30 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 30 Sep 2020 04:29:26 -0400
IronPort-SDR: rrssQznbaU8/8rt65eWvZXu+ZGhrUDFX4WIxXQM8boQtxh3aDe3HG0FY6/lADAMmAEIOH5BNvQ
 bmLe+qYkIt0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="142404389"
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="142404389"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 01:29:25 -0700
IronPort-SDR: wB0MJwzxVt3KVZVO1pu2d3TTeEOth7tcgbCAQkZp/sCxxN8C76RE9uVUsQgnvbUEMKH8Jx1q39
 JZuS1fEX+eww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="351463721"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2020 01:29:23 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNXUJ-000095-7Q; Wed, 30 Sep 2020 08:29:23 +0000
Date:   Wed, 30 Sep 2020 16:28:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 1e560e69302ff557718d55f2375daf8fd8d0142d
Message-ID: <5f7441ad.XQk+Q7Ei6/x6Um1X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 1e560e69302ff557718d55f2375daf8fd8d0142d  efi: efivars: remove deprecated sysfs interface

elapsed time: 724m

configs tested: 168
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 xes_mpc85xx_defconfig
arc                      axs103_smp_defconfig
arc                         haps_hs_defconfig
arm                         orion5x_defconfig
riscv                               defconfig
arm                           h3600_defconfig
powerpc                          g5_defconfig
arm                       spear13xx_defconfig
mips                           ip22_defconfig
arm                         nhk8815_defconfig
ia64                        generic_defconfig
mips                       rbtx49xx_defconfig
powerpc                      pmac32_defconfig
powerpc64                        alldefconfig
sh                        sh7785lcr_defconfig
riscv                            alldefconfig
arm                           viper_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                       m5275evb_defconfig
powerpc                       eiger_defconfig
powerpc                     mpc512x_defconfig
um                            kunit_defconfig
sh                     magicpanelr2_defconfig
powerpc                    amigaone_defconfig
sh                           se7751_defconfig
mips                      malta_kvm_defconfig
powerpc                     rainier_defconfig
arm                           efm32_defconfig
arm                      tct_hammer_defconfig
powerpc                        icon_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8541_defconfig
sh                        sh7763rdp_defconfig
mips                    maltaup_xpa_defconfig
arm                         ebsa110_defconfig
sparc                       sparc32_defconfig
arm                          pxa168_defconfig
m68k                                defconfig
sh                          lboxre2_defconfig
mips                           gcw0_defconfig
powerpc                    gamecube_defconfig
arm                             ezx_defconfig
sh                        dreamcast_defconfig
arm                       omap2plus_defconfig
powerpc                    socrates_defconfig
parisc                generic-64bit_defconfig
xtensa                  audio_kc705_defconfig
s390                       zfcpdump_defconfig
powerpc                      ep88xc_defconfig
sh                         apsh4a3a_defconfig
arm                            u300_defconfig
arm                             mxs_defconfig
arm                         lpc32xx_defconfig
mips                        vocore2_defconfig
arc                          axs103_defconfig
arc                        vdk_hs38_defconfig
c6x                        evmc6457_defconfig
arm                         s3c6400_defconfig
arm                           sama5_defconfig
powerpc                    mvme5100_defconfig
powerpc                        fsp2_defconfig
mips                      pic32mzda_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                       multi_v4t_defconfig
sh                             shx3_defconfig
microblaze                          defconfig
mips                   sb1250_swarm_defconfig
mips                malta_kvm_guest_defconfig
h8300                     edosk2674_defconfig
mips                         tb0219_defconfig
sh                          r7780mp_defconfig
m68k                       m5249evb_defconfig
mips                       capcella_defconfig
c6x                                 defconfig
um                           x86_64_defconfig
arm                        multi_v7_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200929
i386                 randconfig-a002-20200929
i386                 randconfig-a003-20200929
i386                 randconfig-a004-20200929
i386                 randconfig-a005-20200929
i386                 randconfig-a001-20200929
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
x86_64               randconfig-a011-20200929
x86_64               randconfig-a013-20200929
x86_64               randconfig-a015-20200929
x86_64               randconfig-a014-20200929
x86_64               randconfig-a016-20200929
x86_64               randconfig-a012-20200929
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
i386                 randconfig-a012-20200929
i386                 randconfig-a016-20200929
i386                 randconfig-a014-20200929
i386                 randconfig-a013-20200929
i386                 randconfig-a015-20200929
i386                 randconfig-a011-20200929
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930
x86_64               randconfig-a005-20200929
x86_64               randconfig-a003-20200929
x86_64               randconfig-a004-20200929
x86_64               randconfig-a002-20200929
x86_64               randconfig-a006-20200929
x86_64               randconfig-a001-20200929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
