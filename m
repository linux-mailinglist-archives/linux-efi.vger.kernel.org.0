Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF934268F
	for <lists+linux-efi@lfdr.de>; Fri, 19 Mar 2021 20:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhCST4l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Mar 2021 15:56:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:5187 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhCST41 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 19 Mar 2021 15:56:27 -0400
IronPort-SDR: PBdXoEuawyImRyEdronTIJtuCwQKEN5p9/jetytel9BS5dEGJKhTc4tkpWPyT91D+HNKx4wXao
 b97kW9dENfYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="169893972"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="169893972"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 12:56:27 -0700
IronPort-SDR: FX6YViXdHwKj1nzy/ogXLOuttbN8W2IVlzHOVWkrCNAM3+HrAq8T8Knve2v9XUwo7HWfvQcwMM
 RhVJlzERbBwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="606705003"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2021 12:56:25 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lNLEP-000224-16; Fri, 19 Mar 2021 19:56:25 +0000
Date:   Sat, 20 Mar 2021 03:56:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 fb98cc0b3af2ba4d87301dff2b381b12eee35d7d
Message-ID: <605501e2.EDjz36J38Ypbth+H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: fb98cc0b3af2ba4d87301dff2b381b12eee35d7d  efi: use 32-bit alignment for efi_guid_t literals

elapsed time: 721m

configs tested: 177
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
mips                  maltasmvp_eva_defconfig
sh                               j2_defconfig
mips                       bmips_be_defconfig
arm                          collie_defconfig
powerpc                      walnut_defconfig
sh                             sh03_defconfig
sh                           se7343_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                                 defconfig
h8300                    h8300h-sim_defconfig
powerpc                     tqm8560_defconfig
mips                        nlm_xlp_defconfig
sh                                  defconfig
mips                     loongson1b_defconfig
m68k                        m5407c3_defconfig
sh                           se7712_defconfig
m68k                       m5275evb_defconfig
arm                           sunxi_defconfig
m68k                          hp300_defconfig
powerpc64                           defconfig
arm                          ep93xx_defconfig
sh                         ecovec24_defconfig
xtensa                  cadence_csp_defconfig
s390                          debug_defconfig
mips                         bigsur_defconfig
powerpc                         wii_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                            mps2_defconfig
powerpc                  storcenter_defconfig
s390                             alldefconfig
arm                            dove_defconfig
mips                            e55_defconfig
xtensa                generic_kc705_defconfig
arm                          exynos_defconfig
arm                          lpd270_defconfig
m68k                             allyesconfig
ia64                             allmodconfig
powerpc                 linkstation_defconfig
xtensa                  audio_kc705_defconfig
mips                        vocore2_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     tqm8548_defconfig
arm                         at91_dt_defconfig
sh                          r7780mp_defconfig
powerpc                      ppc6xx_defconfig
mips                          rb532_defconfig
openrisc                 simple_smp_defconfig
riscv                          rv32_defconfig
powerpc                    mvme5100_defconfig
arm64                            alldefconfig
ia64                          tiger_defconfig
um                           x86_64_defconfig
m68k                       m5208evb_defconfig
ia64                      gensparse_defconfig
sh                            migor_defconfig
powerpc                     kilauea_defconfig
xtensa                    xip_kc705_defconfig
powerpc                       ebony_defconfig
mips                          ath79_defconfig
sh                     sh7710voipgw_defconfig
s390                                defconfig
mips                      maltaaprp_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                       maple_defconfig
powerpc                    adder875_defconfig
sh                          kfr2r09_defconfig
arm                         lpc32xx_defconfig
xtensa                         virt_defconfig
powerpc                 mpc832x_rdb_defconfig
csky                             alldefconfig
sh                   sh7724_generic_defconfig
mips                malta_qemu_32r6_defconfig
sh                           se7721_defconfig
sh                     magicpanelr2_defconfig
powerpc                  mpc885_ads_defconfig
m68k                        m5307c3_defconfig
arm                        shmobile_defconfig
mips                      pic32mzda_defconfig
m68k                       m5249evb_defconfig
um                             i386_defconfig
arm                          pxa3xx_defconfig
m68k                       bvme6000_defconfig
powerpc                     kmeter1_defconfig
sh                        edosk7760_defconfig
mips                            ar7_defconfig
sh                             espt_defconfig
ia64                             alldefconfig
mips                     cu1830-neo_defconfig
powerpc                     pq2fads_defconfig
mips                             allyesconfig
arm                          pcm027_defconfig
powerpc                      acadia_defconfig
sh                        edosk7705_defconfig
powerpc                     tqm5200_defconfig
parisc                              defconfig
s390                             allmodconfig
arm                       versatile_defconfig
h8300                     edosk2674_defconfig
sh                            titan_defconfig
arc                           tb10x_defconfig
xtensa                          iss_defconfig
powerpc                      tqm8xx_defconfig
arm                         socfpga_defconfig
mips                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
i386                 randconfig-a001-20210319
i386                 randconfig-a005-20210319
i386                 randconfig-a003-20210319
i386                 randconfig-a002-20210319
i386                 randconfig-a006-20210319
i386                 randconfig-a004-20210319
x86_64               randconfig-a011-20210318
x86_64               randconfig-a016-20210318
x86_64               randconfig-a013-20210318
x86_64               randconfig-a015-20210318
x86_64               randconfig-a014-20210318
x86_64               randconfig-a012-20210318
i386                 randconfig-a013-20210318
i386                 randconfig-a016-20210318
i386                 randconfig-a011-20210318
i386                 randconfig-a014-20210318
i386                 randconfig-a015-20210318
i386                 randconfig-a012-20210318
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210318
x86_64               randconfig-a001-20210318
x86_64               randconfig-a005-20210318
x86_64               randconfig-a002-20210318
x86_64               randconfig-a003-20210318
x86_64               randconfig-a004-20210318

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
