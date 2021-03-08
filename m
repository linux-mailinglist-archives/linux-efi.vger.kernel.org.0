Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71E933079F
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 06:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhCHFjz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 00:39:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:23375 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234597AbhCHFji (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 00:39:38 -0500
IronPort-SDR: SvLtR7+h5b7TdUVzpuNw4W1Jfi1k516u/XalNzSNUD4eMG/Vk9vCg9nGUP56qDFclaWkitfoKI
 KW9CbghBSJSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="175081514"
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="175081514"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 21:39:37 -0800
IronPort-SDR: 5frdGrKUVycK1Am7HfvlStneuEoDNuxz20RkALJDp/56cB/UWnjDTPphpH8bEFFZMPzPtULDEI
 YgsOiUwGD8Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="598723176"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Mar 2021 21:39:35 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lJ8cA-0000pD-Qk; Mon, 08 Mar 2021 05:39:34 +0000
Date:   Mon, 08 Mar 2021 13:38:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS af6e3e61fe5623a7890807b0b13004ecb876fa1f
Message-ID: <6045b86b.J965rPnsVAmud0sd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: af6e3e61fe5623a7890807b0b13004ecb876fa1f  efi/apple-properties: Handle device properties with software node API

elapsed time: 720m

configs tested: 154
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    amigaone_defconfig
powerpc                     redwood_defconfig
powerpc                     rainier_defconfig
arm                           spitz_defconfig
mips                         mpc30x_defconfig
mips                           ci20_defconfig
s390                       zfcpdump_defconfig
powerpc                     akebono_defconfig
arc                            hsdk_defconfig
powerpc                        warp_defconfig
mips                      loongson3_defconfig
m68k                                defconfig
powerpc                      chrp32_defconfig
mips                        qi_lb60_defconfig
arm                         mv78xx0_defconfig
mips                  decstation_64_defconfig
arm                        spear3xx_defconfig
arc                          axs103_defconfig
powerpc                       maple_defconfig
arm                       omap2plus_defconfig
sh                   sh7770_generic_defconfig
arm                          simpad_defconfig
sh                           se7722_defconfig
mips                         db1xxx_defconfig
arm                            pleb_defconfig
arm                           omap1_defconfig
s390                             allmodconfig
sh                   rts7751r2dplus_defconfig
sh                                  defconfig
arm                         s5pv210_defconfig
arm                            hisi_defconfig
ia64                         bigsur_defconfig
sparc                            allyesconfig
sh                             espt_defconfig
m68k                          sun3x_defconfig
sparc                       sparc64_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                          sdk7786_defconfig
arm                     am200epdkit_defconfig
mips                            gpr_defconfig
m68k                          hp300_defconfig
x86_64                           alldefconfig
arm                        mini2440_defconfig
sh                           se7343_defconfig
mips                           ip22_defconfig
sh                          sdk7780_defconfig
powerpc                      bamboo_defconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
powerpc                 mpc834x_itx_defconfig
parisc                           alldefconfig
mips                           rs90_defconfig
sparc64                             defconfig
m68k                            mac_defconfig
sh                           se7721_defconfig
nds32                               defconfig
mips                           ip27_defconfig
powerpc64                           defconfig
xtensa                    smp_lx200_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                          axs101_defconfig
powerpc                   bluestone_defconfig
xtensa                          iss_defconfig
mips                         tb0226_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210308
x86_64               randconfig-a001-20210308
x86_64               randconfig-a004-20210308
x86_64               randconfig-a002-20210308
x86_64               randconfig-a005-20210308
x86_64               randconfig-a003-20210308
i386                 randconfig-a005-20210307
i386                 randconfig-a003-20210307
i386                 randconfig-a002-20210307
i386                 randconfig-a004-20210307
i386                 randconfig-a006-20210307
i386                 randconfig-a001-20210307
i386                 randconfig-a005-20210308
i386                 randconfig-a003-20210308
i386                 randconfig-a002-20210308
i386                 randconfig-a006-20210308
i386                 randconfig-a004-20210308
i386                 randconfig-a001-20210308
i386                 randconfig-a016-20210307
i386                 randconfig-a012-20210307
i386                 randconfig-a013-20210307
i386                 randconfig-a014-20210307
i386                 randconfig-a011-20210307
i386                 randconfig-a015-20210307
i386                 randconfig-a016-20210308
i386                 randconfig-a012-20210308
i386                 randconfig-a014-20210308
i386                 randconfig-a013-20210308
i386                 randconfig-a011-20210308
i386                 randconfig-a015-20210308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210307
x86_64               randconfig-a001-20210307
x86_64               randconfig-a004-20210307
x86_64               randconfig-a005-20210307
x86_64               randconfig-a002-20210307
x86_64               randconfig-a003-20210307
x86_64               randconfig-a013-20210308
x86_64               randconfig-a016-20210308
x86_64               randconfig-a015-20210308
x86_64               randconfig-a014-20210308
x86_64               randconfig-a011-20210308
x86_64               randconfig-a012-20210308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
