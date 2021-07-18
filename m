Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6223CC975
	for <lists+linux-efi@lfdr.de>; Sun, 18 Jul 2021 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhGRODo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Jul 2021 10:03:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:59781 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhGRODo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 18 Jul 2021 10:03:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10048"; a="211000618"
X-IronPort-AV: E=Sophos;i="5.84,249,1620716400"; 
   d="scan'208";a="211000618"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2021 07:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,249,1620716400"; 
   d="scan'208";a="430164002"
Received: from lkp-server01.sh.intel.com (HELO a467b34d8c10) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2021 07:00:44 -0700
Received: from kbuild by a467b34d8c10 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m57LX-0000JP-J6; Sun, 18 Jul 2021 14:00:43 +0000
Date:   Sun, 18 Jul 2021 22:00:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 2bab693a608bdf614b9fcd44083c5100f34b9f77
Message-ID: <60f433ff.8/TZDxC0fJQu3FoZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 2bab693a608bdf614b9fcd44083c5100f34b9f77  firmware/efi: Tell memblock about EFI iomem reservations

elapsed time: 722m

configs tested: 136
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       mainstone_defconfig
sh                          landisk_defconfig
arm                            lart_defconfig
mips                            ar7_defconfig
sh                               allmodconfig
arm                  colibri_pxa300_defconfig
powerpc                       ebony_defconfig
arm                         s3c6400_defconfig
arm                      footbridge_defconfig
arm                            hisi_defconfig
arm                       versatile_defconfig
nios2                         3c120_defconfig
arc                        vdk_hs38_defconfig
sh                            shmin_defconfig
powerpc                 canyonlands_defconfig
powerpc                        cell_defconfig
microblaze                      mmu_defconfig
h8300                     edosk2674_defconfig
mips                     cu1830-neo_defconfig
arm                         lpc18xx_defconfig
sh                          rsk7203_defconfig
arm                         at91_dt_defconfig
mips                           rs90_defconfig
powerpc                   bluestone_defconfig
powerpc                    amigaone_defconfig
m68k                       m5208evb_defconfig
powerpc                  storcenter_defconfig
um                                  defconfig
sh                          urquell_defconfig
powerpc                 mpc8313_rdb_defconfig
xtensa                  audio_kc705_defconfig
m68k                        m5272c3_defconfig
arm                          collie_defconfig
mips                  maltasmvp_eva_defconfig
arm                        spear6xx_defconfig
sh                        dreamcast_defconfig
m68k                           sun3_defconfig
microblaze                          defconfig
powerpc                      chrp32_defconfig
sh                           se7206_defconfig
arm                        mini2440_defconfig
powerpc                 mpc837x_mds_defconfig
sh                      rts7751r2d1_defconfig
arc                    vdk_hs38_smp_defconfig
mips                            gpr_defconfig
ia64                            zx1_defconfig
arm                         cm_x300_defconfig
riscv                            alldefconfig
arm                        realview_defconfig
powerpc                      ppc64e_defconfig
arm                         palmz72_defconfig
arm                     davinci_all_defconfig
sh                           se7751_defconfig
arm                           h5000_defconfig
sh                           se7780_defconfig
sh                          polaris_defconfig
powerpc                      ep88xc_defconfig
mips                          rb532_defconfig
powerpc                     tqm8560_defconfig
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
x86_64               randconfig-a005-20210718
x86_64               randconfig-a004-20210718
x86_64               randconfig-a002-20210718
x86_64               randconfig-a003-20210718
x86_64               randconfig-a006-20210718
x86_64               randconfig-a001-20210718
i386                 randconfig-a005-20210718
i386                 randconfig-a004-20210718
i386                 randconfig-a006-20210718
i386                 randconfig-a001-20210718
i386                 randconfig-a003-20210718
i386                 randconfig-a002-20210718
i386                 randconfig-a014-20210718
i386                 randconfig-a015-20210718
i386                 randconfig-a011-20210718
i386                 randconfig-a013-20210718
i386                 randconfig-a016-20210718
i386                 randconfig-a012-20210718
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210718
x86_64               randconfig-a013-20210718
x86_64               randconfig-a015-20210718
x86_64               randconfig-a012-20210718
x86_64               randconfig-a014-20210718
x86_64               randconfig-a011-20210718
x86_64               randconfig-a016-20210718

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
