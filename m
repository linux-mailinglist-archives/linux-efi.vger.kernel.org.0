Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669ED281D07
	for <lists+linux-efi@lfdr.de>; Fri,  2 Oct 2020 22:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgJBUjK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Oct 2020 16:39:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:20713 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgJBUjK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 2 Oct 2020 16:39:10 -0400
IronPort-SDR: ZX97yxIXVC+wsLWQIzJL3A8YAYGvLQ5ugOaQdK+8+KY0YMrQBTGQJ9tAVWOLuASvdKpFkrdWkg
 NY55p2k0qMyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="163174716"
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="163174716"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 13:39:07 -0700
IronPort-SDR: q0usVWjHK0VvIGJQMBQa6o7jsZEgpY6qCGDo7DA2bq5QiEwO4Wr2PAR/X7PwM3yXyLXHQCe+K+
 jggUW3W30WaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="515280764"
Received: from lkp-server02.sh.intel.com (HELO 404f47266ee4) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 02 Oct 2020 13:39:06 -0700
Received: from kbuild by 404f47266ee4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kORpZ-00007H-Gq; Fri, 02 Oct 2020 20:39:05 +0000
Date:   Sat, 03 Oct 2020 04:38:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 6329be161cb9ff954137c64575bd1773a9059bcd
Message-ID: <5f778fc6.+eQr10K+q5qyw7e8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 6329be161cb9ff954137c64575bd1773a9059bcd  efi: efivars: remove deprecated sysfs interface

elapsed time: 724m

configs tested: 151
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                          allyesconfig
um                           x86_64_defconfig
mips                           mtx1_defconfig
powerpc                       holly_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      ppc6xx_defconfig
arm                         s3c2410_defconfig
arm                           viper_defconfig
powerpc                        warp_defconfig
powerpc                         wii_defconfig
mips                        nlm_xlr_defconfig
mips                       lemote2f_defconfig
alpha                               defconfig
arm                         lpc18xx_defconfig
powerpc                      ep88xc_defconfig
powerpc                      ppc64e_defconfig
arm                   milbeaut_m10v_defconfig
arm                          ep93xx_defconfig
arm                         palmz72_defconfig
sh                          rsk7203_defconfig
arm                          gemini_defconfig
powerpc                     rainier_defconfig
riscv                    nommu_k210_defconfig
m68k                       m5475evb_defconfig
arm                           tegra_defconfig
sh                           se7619_defconfig
mips                 decstation_r4k_defconfig
s390                       zfcpdump_defconfig
m68k                        m5307c3_defconfig
sh                           se7724_defconfig
um                             i386_defconfig
arm                       multi_v4t_defconfig
sh                        dreamcast_defconfig
arm                         bcm2835_defconfig
powerpc                          g5_defconfig
arm                         vf610m4_defconfig
sh                           se7343_defconfig
mips                          ath79_defconfig
powerpc                           allnoconfig
xtensa                generic_kc705_defconfig
alpha                            alldefconfig
powerpc                    mvme5100_defconfig
sh                            titan_defconfig
riscv                               defconfig
powerpc                     mpc512x_defconfig
arm                            lart_defconfig
mips                           jazz_defconfig
c6x                         dsk6455_defconfig
arm                        mini2440_defconfig
c6x                        evmc6474_defconfig
arm                          imote2_defconfig
sh                   sh7770_generic_defconfig
sparc                       sparc32_defconfig
mips                          ath25_defconfig
sh                          polaris_defconfig
sh                          kfr2r09_defconfig
m68k                        m5407c3_defconfig
xtensa                       common_defconfig
powerpc                       maple_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
arm                  colibri_pxa300_defconfig
arm                           sama5_defconfig
arm                           h5000_defconfig
sh                           se7780_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     mpc5200_defconfig
powerpc                      pcm030_defconfig
powerpc                       eiger_defconfig
arm                        spear6xx_defconfig
mips                         mpc30x_defconfig
arm                  colibri_pxa270_defconfig
m68k                           sun3_defconfig
sh                          lboxre2_defconfig
c6x                        evmc6678_defconfig
mips                  cavium_octeon_defconfig
s390                          debug_defconfig
sh                           se7751_defconfig
mips                          malta_defconfig
arm                        mvebu_v7_defconfig
arm                        vexpress_defconfig
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
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
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
powerpc                          allmodconfig
x86_64               randconfig-a004-20201002
x86_64               randconfig-a001-20201002
x86_64               randconfig-a002-20201002
x86_64               randconfig-a003-20201002
x86_64               randconfig-a005-20201002
x86_64               randconfig-a006-20201002
i386                 randconfig-a006-20201002
i386                 randconfig-a005-20201002
i386                 randconfig-a001-20201002
i386                 randconfig-a004-20201002
i386                 randconfig-a003-20201002
i386                 randconfig-a002-20201002
i386                 randconfig-a014-20201002
i386                 randconfig-a013-20201002
i386                 randconfig-a015-20201002
i386                 randconfig-a016-20201002
i386                 randconfig-a011-20201002
i386                 randconfig-a012-20201002
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
x86_64               randconfig-a012-20201002
x86_64               randconfig-a015-20201002
x86_64               randconfig-a014-20201002
x86_64               randconfig-a013-20201002
x86_64               randconfig-a011-20201002
x86_64               randconfig-a016-20201002

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
