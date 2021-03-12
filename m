Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDC933865D
	for <lists+linux-efi@lfdr.de>; Fri, 12 Mar 2021 08:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhCLHIE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 Mar 2021 02:08:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:11139 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231191AbhCLHHx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 12 Mar 2021 02:07:53 -0500
IronPort-SDR: z1CrvYWmhpJ61Erdm02SlGPrBpgA7rNWcvpok1YXABxYIYDvD7wIyiF6ZCSr32QFqbCqIJ0XQH
 CyTeAnJ6k5dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="273835748"
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="273835748"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 23:07:53 -0800
IronPort-SDR: HOQ7POhkN63wA7VogLkDG6DXEq8KtM5hzw0wC6gsqHN1MCKJxHtxUGDwCGYKp7dYBnsfo8JxqJ
 jUTFriKqXSvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="589481820"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2021 23:07:51 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKbtm-0001Dg-B4; Fri, 12 Mar 2021 07:07:50 +0000
Date:   Fri, 12 Mar 2021 15:07:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 db9b21d7497cac1f4ff45af10f24d03f9194ebee
Message-ID: <604b131a.NRV2uRufAtUrN4+8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: db9b21d7497cac1f4ff45af10f24d03f9194ebee  efi: use 32-bit alignment for efi_guid_t literals

elapsed time: 726m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                                 defconfig
arm                             mxs_defconfig
sh                   secureedge5410_defconfig
ia64                          tiger_defconfig
arm                           spitz_defconfig
ia64                             alldefconfig
mips                         rt305x_defconfig
arm                         mv78xx0_defconfig
arm                          exynos_defconfig
m68k                        m5272c3_defconfig
arm                         nhk8815_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                        qi_lb60_defconfig
powerpc                     tqm8555_defconfig
openrisc                 simple_smp_defconfig
um                           x86_64_defconfig
powerpc                    mvme5100_defconfig
mips                        jmr3927_defconfig
sh                            hp6xx_defconfig
arm                       mainstone_defconfig
powerpc                       eiger_defconfig
mips                      pistachio_defconfig
mips                        workpad_defconfig
openrisc                            defconfig
arm                     am200epdkit_defconfig
sh                 kfr2r09-romimage_defconfig
arm                       netwinder_defconfig
arm                        magician_defconfig
mips                        bcm63xx_defconfig
arm                         s3c6400_defconfig
sh                               allmodconfig
mips                        nlm_xlr_defconfig
powerpc                    ge_imp3a_defconfig
arm                          iop32x_defconfig
sparc                       sparc32_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc836x_mds_defconfig
arm                            qcom_defconfig
riscv                            alldefconfig
powerpc                     taishan_defconfig
arm                        neponset_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
mips                           rs90_defconfig
arm                        mini2440_defconfig
powerpc                     tqm8560_defconfig
powerpc                  iss476-smp_defconfig
arm                       aspeed_g4_defconfig
powerpc                     redwood_defconfig
mips                malta_qemu_32r6_defconfig
mips                           ci20_defconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210311
x86_64               randconfig-a001-20210311
x86_64               randconfig-a005-20210311
x86_64               randconfig-a002-20210311
x86_64               randconfig-a003-20210311
x86_64               randconfig-a004-20210311
i386                 randconfig-a001-20210312
i386                 randconfig-a005-20210312
i386                 randconfig-a002-20210312
i386                 randconfig-a003-20210312
i386                 randconfig-a004-20210312
i386                 randconfig-a006-20210312
i386                 randconfig-a001-20210311
i386                 randconfig-a005-20210311
i386                 randconfig-a003-20210311
i386                 randconfig-a002-20210311
i386                 randconfig-a004-20210311
i386                 randconfig-a006-20210311
i386                 randconfig-a013-20210311
i386                 randconfig-a016-20210311
i386                 randconfig-a011-20210311
i386                 randconfig-a014-20210311
i386                 randconfig-a015-20210311
i386                 randconfig-a012-20210311
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
x86_64               randconfig-a011-20210311
x86_64               randconfig-a016-20210311
x86_64               randconfig-a013-20210311
x86_64               randconfig-a015-20210311
x86_64               randconfig-a014-20210311
x86_64               randconfig-a012-20210311

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
