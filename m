Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF94B2999BF
	for <lists+linux-efi@lfdr.de>; Mon, 26 Oct 2020 23:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394550AbgJZWgy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Oct 2020 18:36:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:59308 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394549AbgJZWgy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Oct 2020 18:36:54 -0400
IronPort-SDR: k62iMxMBceaSFxVXSMMi8+Yi77/pMYJI9pm8LxXczfg4gXKiJS7kC7yDyPhaNh8M/wNxtuLQZc
 kSsf9XaAA1aQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="167215162"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="167215162"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 15:36:53 -0700
IronPort-SDR: DsXw1Dn10CNPHrnAwOleX2E4r+496inil8nf5OR8pJ4Z4NGRpdU+rBZKAU0B/yfOhTxBIfj5lD
 rA9V9FppHVlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="322705686"
Received: from lkp-server01.sh.intel.com (HELO ca9e3ad0a302) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Oct 2020 15:36:52 -0700
Received: from kbuild by ca9e3ad0a302 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXB6h-0000Be-Ce; Mon, 26 Oct 2020 22:36:51 +0000
Date:   Tue, 27 Oct 2020 06:36:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 688eb28211abdf82a3f51e8997f1c8137947227d
Message-ID: <5f974f55.gXtWewi6JJREAN8r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 688eb28211abdf82a3f51e8997f1c8137947227d  efi/x86: Only copy the compressed kernel image in efi_relocate_kernel()

elapsed time: 722m

configs tested: 169
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            zeus_defconfig
arm                         ebsa110_defconfig
arm                        shmobile_defconfig
sparc                            allyesconfig
powerpc                     sequoia_defconfig
arm                          moxart_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                        fsp2_defconfig
powerpc                       maple_defconfig
mips                           gcw0_defconfig
alpha                            allyesconfig
arm                          ixp4xx_defconfig
mips                         cobalt_defconfig
sh                           se7705_defconfig
arm                        spear6xx_defconfig
arm                              zx_defconfig
mips                          malta_defconfig
alpha                               defconfig
arm                         mv78xx0_defconfig
sh                   secureedge5410_defconfig
mips                       rbtx49xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         tb0287_defconfig
mips                        workpad_defconfig
ia64                                defconfig
m68k                         amcore_defconfig
arm                          badge4_defconfig
powerpc                     stx_gp3_defconfig
sh                          rsk7264_defconfig
riscv                            allyesconfig
powerpc                     sbc8548_defconfig
arm                          exynos_defconfig
mips                         db1xxx_defconfig
mips                       bmips_be_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
mips                     decstation_defconfig
arm                       aspeed_g5_defconfig
arm                        realview_defconfig
mips                          ath79_defconfig
nios2                            alldefconfig
arm                            lart_defconfig
mips                            e55_defconfig
microblaze                          defconfig
arc                          axs103_defconfig
arm                         shannon_defconfig
nds32                               defconfig
arm                         s3c6400_defconfig
arm                         assabet_defconfig
sh                            shmin_defconfig
mips                           ip28_defconfig
c6x                        evmc6678_defconfig
m68k                       m5275evb_defconfig
powerpc                      makalu_defconfig
arm                         socfpga_defconfig
sh                        sh7763rdp_defconfig
arm                        mini2440_defconfig
arm                           spitz_defconfig
m68k                          multi_defconfig
arm                      jornada720_defconfig
powerpc                    gamecube_defconfig
ia64                            zx1_defconfig
microblaze                      mmu_defconfig
powerpc                     kilauea_defconfig
sh                        edosk7705_defconfig
x86_64                           allyesconfig
powerpc                      walnut_defconfig
c6x                        evmc6472_defconfig
mips                        nlm_xlp_defconfig
arc                        nsimosci_defconfig
sh                           se7780_defconfig
xtensa                generic_kc705_defconfig
sh                          polaris_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
m68k                       bvme6000_defconfig
mips                      pistachio_defconfig
sh                   sh7724_generic_defconfig
powerpc                 linkstation_defconfig
powerpc                      pmac32_defconfig
arm                          collie_defconfig
sh                          r7780mp_defconfig
m68k                        m5407c3_defconfig
riscv                            alldefconfig
xtensa                          iss_defconfig
mips                           ip22_defconfig
mips                malta_kvm_guest_defconfig
sh                           se7750_defconfig
powerpc                   bluestone_defconfig
powerpc                   lite5200b_defconfig
xtensa                              defconfig
arm                         cm_x300_defconfig
powerpc                     rainier_defconfig
powerpc                     pseries_defconfig
powerpc                      chrp32_defconfig
sh                          rsk7203_defconfig
powerpc64                           defconfig
sh                        dreamcast_defconfig
arm                      integrator_defconfig
arm                              alldefconfig
arm                           stm32_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201026
i386                 randconfig-a015-20201026
i386                 randconfig-a014-20201026
i386                 randconfig-a012-20201026
i386                 randconfig-a013-20201026
i386                 randconfig-a011-20201026
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
