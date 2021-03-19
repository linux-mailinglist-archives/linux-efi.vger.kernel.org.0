Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7683416A0
	for <lists+linux-efi@lfdr.de>; Fri, 19 Mar 2021 08:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhCSHcd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Mar 2021 03:32:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:44667 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234254AbhCSHcR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 19 Mar 2021 03:32:17 -0400
IronPort-SDR: gjVxpBV4lWtZ+FEcNTu3nGk4xF2/3aiNAR9q/ee1rsMES8oVjzpk+IsmcsPxsq+aO1Y6VzClN2
 X9+ZbjUPpxnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="169144994"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="169144994"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 00:32:16 -0700
IronPort-SDR: DJHDhjQeYZyQVodJyzswewVipvazfQDdIPXMP7AFHPSfvj3IaQ6AFrRIDWvoSc80OsD8dbFJ6A
 h+S6I73k4ZmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="412220384"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Mar 2021 00:32:15 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lN9cE-0001fC-De; Fri, 19 Mar 2021 07:32:14 +0000
Date:   Fri, 19 Mar 2021 15:31:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 70b3fcb4df36c4e4f5b99692d5a68adf9ffe7e78
Message-ID: <60545348.2nBWF6CgEOfawLez%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 70b3fcb4df36c4e4f5b99692d5a68adf9ffe7e78  firmware/efi: Fix a use after bug in efi_mem_reserve_persistent

elapsed time: 721m

configs tested: 133
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
riscv                            allyesconfig
i386                             allyesconfig
arc                          axs101_defconfig
sh                                  defconfig
ia64                        generic_defconfig
m68k                        mvme147_defconfig
riscv                    nommu_k210_defconfig
h8300                    h8300h-sim_defconfig
powerpc                     tqm8560_defconfig
mips                        nlm_xlp_defconfig
arc                                 defconfig
ia64                             allmodconfig
s390                          debug_defconfig
mips                         bigsur_defconfig
powerpc                         wii_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                            mps2_defconfig
powerpc                 linkstation_defconfig
xtensa                  audio_kc705_defconfig
mips                        vocore2_defconfig
powerpc                    ge_imp3a_defconfig
arm                          exynos_defconfig
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
arm                           sunxi_defconfig
sh                          urquell_defconfig
arm                        mvebu_v5_defconfig
mips                       capcella_defconfig
powerpc                 mpc834x_mds_defconfig
mips                 decstation_r4k_defconfig
sh                          lboxre2_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                       maple_defconfig
powerpc                    adder875_defconfig
sh                          kfr2r09_defconfig
arm                         lpc32xx_defconfig
s390                             alldefconfig
xtensa                         virt_defconfig
powerpc                 mpc832x_rdb_defconfig
csky                             alldefconfig
sh                   sh7724_generic_defconfig
mips                malta_qemu_32r6_defconfig
sh                           se7721_defconfig
sh                     magicpanelr2_defconfig
powerpc                    amigaone_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                      makalu_defconfig
arm                          pxa3xx_defconfig
m68k                       m5208evb_defconfig
m68k                       bvme6000_defconfig
powerpc                     kmeter1_defconfig
mips                     cu1830-neo_defconfig
powerpc                     pq2fads_defconfig
arm                          pcm027_defconfig
powerpc                      acadia_defconfig
sh                        edosk7705_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
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
