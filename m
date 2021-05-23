Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A5438D811
	for <lists+linux-efi@lfdr.de>; Sun, 23 May 2021 03:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhEWBJx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 May 2021 21:09:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:63677 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231479AbhEWBJx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 22 May 2021 21:09:53 -0400
IronPort-SDR: VnIgorMn6jYd2Wx1esDER7zNshj/l3rwSAkUiwqMBBVGDe4fXWal5rbyOz9B9vEboozFZMikO5
 O91R3jdhg7QQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9992"; a="262932295"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="262932295"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2021 18:08:26 -0700
IronPort-SDR: SxYThJWkDaSVsbyTYR8zdBfcKISEUaQO+bZet/Dwv1WHMOtlo+KNgKarB00cl9xh/QCCFyUAY0
 5BkVLkm80u0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441477072"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 22 May 2021 18:08:25 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lkcbQ-0000bg-Jw; Sun, 23 May 2021 01:08:24 +0000
Date:   Sun, 23 May 2021 09:07:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS bb11580f61b6c4ba5c35706abd927c8ac8c32852
Message-ID: <60a9aacd.sefxB3a4FJ5fQVrZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: bb11580f61b6c4ba5c35706abd927c8ac8c32852  x86/efi: Log 32/64-bit mismatch with kernel as an error

elapsed time: 723m

configs tested: 201
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                         alldefconfig
powerpc                 xes_mpc85xx_defconfig
i386                                defconfig
mips                          ath79_defconfig
sh                        sh7785lcr_defconfig
mips                     cu1830-neo_defconfig
mips                       bmips_be_defconfig
powerpc                     tqm8560_defconfig
sh                               j2_defconfig
arm                            pleb_defconfig
arm                         lubbock_defconfig
arm                        mvebu_v7_defconfig
sh                           se7619_defconfig
arm                             pxa_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8272_ads_defconfig
m68k                          amiga_defconfig
powerpc                     ppa8548_defconfig
arm                  colibri_pxa300_defconfig
mips                         tb0287_defconfig
openrisc                  or1klitex_defconfig
openrisc                            defconfig
arm                     am200epdkit_defconfig
sh                          rsk7264_defconfig
x86_64                           alldefconfig
powerpc                     pseries_defconfig
ia64                            zx1_defconfig
ia64                      gensparse_defconfig
powerpc                     mpc512x_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      ppc6xx_defconfig
arm                           h5000_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     skiroot_defconfig
um                           x86_64_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                         bigsur_defconfig
mips                          ath25_defconfig
arm                              alldefconfig
powerpc                       ebony_defconfig
sh                        edosk7760_defconfig
powerpc                      cm5200_defconfig
s390                             allmodconfig
powerpc                        cell_defconfig
arc                          axs101_defconfig
sh                          urquell_defconfig
sparc64                             defconfig
mips                          rb532_defconfig
mips                         tb0226_defconfig
sh                             shx3_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                           ip27_defconfig
sh                          kfr2r09_defconfig
mips                malta_qemu_32r6_defconfig
arm64                            alldefconfig
arm                          pxa3xx_defconfig
sh                          rsk7203_defconfig
sh                         apsh4a3a_defconfig
arm                             rpc_defconfig
arm                           sunxi_defconfig
powerpc                         ps3_defconfig
m68k                            q40_defconfig
mips                      bmips_stb_defconfig
ia64                        generic_defconfig
powerpc                    amigaone_defconfig
arc                           tb10x_defconfig
arm                        magician_defconfig
mips                       lemote2f_defconfig
mips                         rt305x_defconfig
sh                          landisk_defconfig
powerpc                     powernv_defconfig
sh                          r7780mp_defconfig
sh                        sh7757lcr_defconfig
sh                           se7705_defconfig
powerpc                       holly_defconfig
powerpc                     taishan_defconfig
powerpc                         wii_defconfig
sh                              ul2_defconfig
powerpc                      pasemi_defconfig
powerpc                      obs600_defconfig
um                             i386_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                 decstation_r4k_defconfig
arc                     haps_hs_smp_defconfig
arm                         vf610m4_defconfig
h8300                               defconfig
sh                      rts7751r2d1_defconfig
mips                         tb0219_defconfig
arm                          gemini_defconfig
sh                ecovec24-romimage_defconfig
mips                            gpr_defconfig
arc                          axs103_defconfig
sh                           se7750_defconfig
arm                           corgi_defconfig
mips                          malta_defconfig
mips                         mpc30x_defconfig
m68k                            mac_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210522
x86_64               randconfig-a006-20210522
x86_64               randconfig-a005-20210522
x86_64               randconfig-a003-20210522
x86_64               randconfig-a004-20210522
x86_64               randconfig-a002-20210522
i386                 randconfig-a001-20210522
i386                 randconfig-a005-20210522
i386                 randconfig-a002-20210522
i386                 randconfig-a004-20210522
i386                 randconfig-a003-20210522
i386                 randconfig-a006-20210522
i386                 randconfig-a001-20210523
i386                 randconfig-a005-20210523
i386                 randconfig-a002-20210523
i386                 randconfig-a003-20210523
i386                 randconfig-a004-20210523
i386                 randconfig-a006-20210523
x86_64               randconfig-a013-20210523
x86_64               randconfig-a014-20210523
x86_64               randconfig-a012-20210523
x86_64               randconfig-a016-20210523
x86_64               randconfig-a015-20210523
x86_64               randconfig-a011-20210523
i386                 randconfig-a016-20210523
i386                 randconfig-a011-20210523
i386                 randconfig-a015-20210523
i386                 randconfig-a012-20210523
i386                 randconfig-a014-20210523
i386                 randconfig-a013-20210523
i386                 randconfig-a016-20210522
i386                 randconfig-a011-20210522
i386                 randconfig-a015-20210522
i386                 randconfig-a012-20210522
i386                 randconfig-a014-20210522
i386                 randconfig-a013-20210522
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210523
x86_64               randconfig-b001-20210522
x86_64               randconfig-a006-20210523
x86_64               randconfig-a001-20210523
x86_64               randconfig-a005-20210523
x86_64               randconfig-a003-20210523
x86_64               randconfig-a004-20210523
x86_64               randconfig-a002-20210523
x86_64               randconfig-a013-20210522
x86_64               randconfig-a014-20210522
x86_64               randconfig-a012-20210522
x86_64               randconfig-a016-20210522
x86_64               randconfig-a015-20210522
x86_64               randconfig-a011-20210522

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
