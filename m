Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA573D70C9
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jul 2021 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhG0IFg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jul 2021 04:05:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:49377 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235897AbhG0IEo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 27 Jul 2021 04:04:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="199576378"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="199576378"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 01:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="498688446"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2021 01:03:42 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m8I3x-0006dS-RV; Tue, 27 Jul 2021 08:03:41 +0000
Date:   Tue, 27 Jul 2021 16:03:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 6dec88b1f3caee8c8460ac199a6c6ea702c85603
Message-ID: <60ffbdb9.brYLTO6djY7kUi8L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 6dec88b1f3caee8c8460ac199a6c6ea702c85603  efi/libstub: arm64: Double check image alignment at entry

elapsed time: 946m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210726
sh                          landisk_defconfig
arm                            lart_defconfig
powerpc                      katmai_defconfig
arm                          pxa168_defconfig
powerpc                       ebony_defconfig
sh                          sdk7780_defconfig
powerpc                      ppc64e_defconfig
powerpc                     sbc8548_defconfig
arm                          iop32x_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          g5_defconfig
mips                           rs90_defconfig
riscv                    nommu_virt_defconfig
m68k                        mvme147_defconfig
sh                     magicpanelr2_defconfig
powerpc                 linkstation_defconfig
sparc                               defconfig
sh                          r7785rp_defconfig
ia64                          tiger_defconfig
arm                           spitz_defconfig
ia64                             alldefconfig
powerpc                    sam440ep_defconfig
riscv                    nommu_k210_defconfig
i386                             allyesconfig
arc                            hsdk_defconfig
sh                        sh7785lcr_defconfig
powerpc                     kilauea_defconfig
mips                     cu1830-neo_defconfig
sh                          urquell_defconfig
mips                        bcm47xx_defconfig
arm                          exynos_defconfig
powerpc                     stx_gp3_defconfig
sh                   sh7770_generic_defconfig
sh                              ul2_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
ia64                             allmodconfig
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
i386                                defconfig
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210726
x86_64               randconfig-a006-20210726
x86_64               randconfig-a001-20210726
x86_64               randconfig-a005-20210726
x86_64               randconfig-a004-20210726
x86_64               randconfig-a002-20210726
i386                 randconfig-a005-20210726
i386                 randconfig-a003-20210726
i386                 randconfig-a004-20210726
i386                 randconfig-a002-20210726
i386                 randconfig-a001-20210726
i386                 randconfig-a006-20210726
x86_64               randconfig-a011-20210727
x86_64               randconfig-a016-20210727
x86_64               randconfig-a013-20210727
x86_64               randconfig-a014-20210727
x86_64               randconfig-a012-20210727
x86_64               randconfig-a015-20210727
i386                 randconfig-a016-20210726
i386                 randconfig-a013-20210726
i386                 randconfig-a012-20210726
i386                 randconfig-a011-20210726
i386                 randconfig-a014-20210726
i386                 randconfig-a015-20210726
i386                 randconfig-a016-20210727
i386                 randconfig-a013-20210727
i386                 randconfig-a012-20210727
i386                 randconfig-a011-20210727
i386                 randconfig-a014-20210727
i386                 randconfig-a015-20210727
riscv                            allyesconfig
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
x86_64               randconfig-c001-20210726
x86_64               randconfig-a003-20210725
x86_64               randconfig-a006-20210725
x86_64               randconfig-a001-20210725
x86_64               randconfig-a005-20210725
x86_64               randconfig-a004-20210725
x86_64               randconfig-a002-20210725
x86_64               randconfig-a003-20210727
x86_64               randconfig-a006-20210727
x86_64               randconfig-a001-20210727
x86_64               randconfig-a005-20210727
x86_64               randconfig-a004-20210727
x86_64               randconfig-a002-20210727
x86_64               randconfig-a011-20210726
x86_64               randconfig-a016-20210726
x86_64               randconfig-a013-20210726
x86_64               randconfig-a014-20210726
x86_64               randconfig-a012-20210726
x86_64               randconfig-a015-20210726

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
