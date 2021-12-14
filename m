Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38157473B7D
	for <lists+linux-efi@lfdr.de>; Tue, 14 Dec 2021 04:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhLNDZG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 22:25:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:55685 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233041AbhLNDZF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Dec 2021 22:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639452305; x=1670988305;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=N2S4LH4HfPZZ3gOn4/tRXzcIRDecyRye4gz2pOpCXQo=;
  b=gVanW/zSTM7BppenEiTRZOOFm5ayrkR32mbuR5A8miaM70wzTC8vgjym
   qDdtVys8UZ5C/uVjxi2HFocwgb6dqLsVVct3FvDlDdxvvpm7hRsTwEeKJ
   pa99OiLKDHwQ0JVl3ukV1zCYsgYtLLzC08Wd1PK9wRP1AeaxUZfrdIjxI
   AqXCMjLzoKnZ+YEof/z5ttfaEO3H5kXeeBFn8pKeWJqnn8Bmd9UxjRMMD
   h5y96K+q4y1MJb5PBpwNPYQGLATPEmn0jYLDJPBlv/pKm4IaXHeFvHs67
   R3VbGLe0qQ54vW67Y4BAetspd18I5BFZbipwLVi/CRlKSUNzRB+1TD+DI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="299667227"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="299667227"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 19:25:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="464903479"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 19:25:03 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwyR4-0007N5-QF; Tue, 14 Dec 2021 03:25:02 +0000
Date:   Tue, 14 Dec 2021 11:24:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 4bc5e64e6cf37007e436970024e5998ee0935651
Message-ID: <61b80e70.wpuF/2oBhhyzFldy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 4bc5e64e6cf37007e436970024e5998ee0935651  efi: Move efifb_setup_from_dmi() prototype from arch headers

elapsed time: 735m

configs tested: 168
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211213
sh                          landisk_defconfig
powerpc                         wii_defconfig
powerpc                      acadia_defconfig
arm                        magician_defconfig
arm                        oxnas_v6_defconfig
arc                        vdk_hs38_defconfig
powerpc                     pq2fads_defconfig
arm                           h5000_defconfig
powerpc                 mpc837x_mds_defconfig
openrisc                 simple_smp_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
sh                ecovec24-romimage_defconfig
mips                           xway_defconfig
arm                        keystone_defconfig
powerpc                   motionpro_defconfig
arm                       imx_v6_v7_defconfig
arm                         s5pv210_defconfig
powerpc                     taishan_defconfig
powerpc                          allyesconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
arc                     haps_hs_smp_defconfig
mips                     decstation_defconfig
mips                          rm200_defconfig
xtensa                  audio_kc705_defconfig
mips                           rs90_defconfig
powerpc                      ppc6xx_defconfig
powerpc                   currituck_defconfig
sparc                       sparc32_defconfig
arm                      integrator_defconfig
sh                     magicpanelr2_defconfig
powerpc                   bluestone_defconfig
mips                           mtx1_defconfig
m68k                       m5249evb_defconfig
s390                             allyesconfig
mips                           gcw0_defconfig
mips                         tb0219_defconfig
powerpc                       ebony_defconfig
arm                        trizeps4_defconfig
arm                         at91_dt_defconfig
arm                       spear13xx_defconfig
powerpc64                        alldefconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
i386                             alldefconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                    sam440ep_defconfig
m68k                       m5208evb_defconfig
m68k                         apollo_defconfig
powerpc                       holly_defconfig
sh                              ul2_defconfig
m68k                       bvme6000_defconfig
powerpc                 canyonlands_defconfig
arm                           sunxi_defconfig
mips                           ip22_defconfig
openrisc                         alldefconfig
mips                         bigsur_defconfig
arc                 nsimosci_hs_smp_defconfig
openrisc                            defconfig
powerpc                  iss476-smp_defconfig
m68k                          hp300_defconfig
mips                          malta_defconfig
powerpc                     ksi8560_defconfig
arc                          axs101_defconfig
powerpc                      obs600_defconfig
m68k                          atari_defconfig
mips                     loongson1c_defconfig
h8300                       h8s-sim_defconfig
arm                       multi_v4t_defconfig
mips                      loongson3_defconfig
arm                            qcom_defconfig
sh                           se7724_defconfig
mips                      bmips_stb_defconfig
mips                         mpc30x_defconfig
alpha                               defconfig
mips                        vocore2_defconfig
mips                      pic32mzda_defconfig
powerpc                     mpc512x_defconfig
m68k                          multi_defconfig
arm                  randconfig-c002-20211213
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a011-20211213
x86_64               randconfig-a012-20211213
x86_64               randconfig-a014-20211213
x86_64               randconfig-a013-20211213
x86_64               randconfig-a016-20211213
x86_64               randconfig-a015-20211213
i386                 randconfig-a013-20211213
i386                 randconfig-a011-20211213
i386                 randconfig-a016-20211213
i386                 randconfig-a014-20211213
i386                 randconfig-a015-20211213
i386                 randconfig-a012-20211213
arc                  randconfig-r043-20211213
riscv                randconfig-r042-20211213
s390                 randconfig-r044-20211213
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
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211213
arm                  randconfig-c002-20211213
riscv                randconfig-c006-20211213
mips                 randconfig-c004-20211213
i386                 randconfig-c001-20211213
s390                 randconfig-c005-20211213
powerpc              randconfig-c003-20211213
x86_64               randconfig-a006-20211213
x86_64               randconfig-a005-20211213
x86_64               randconfig-a001-20211213
x86_64               randconfig-a002-20211213
x86_64               randconfig-a003-20211213
x86_64               randconfig-a004-20211213
i386                 randconfig-a001-20211213
i386                 randconfig-a002-20211213
i386                 randconfig-a005-20211213
i386                 randconfig-a003-20211213
i386                 randconfig-a006-20211213
i386                 randconfig-a004-20211213
hexagon              randconfig-r045-20211213
hexagon              randconfig-r041-20211213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
