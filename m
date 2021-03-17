Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EE233E8D7
	for <lists+linux-efi@lfdr.de>; Wed, 17 Mar 2021 06:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCQFOh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Mar 2021 01:14:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:17903 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhCQFOb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Mar 2021 01:14:31 -0400
IronPort-SDR: mOsMUsPxIWs2L6QY8xj4FCL7fbG9LsLQ5pX/uuOBaNQPyHYCox+nuQWXpdQZ5P2wfIQZIKmWW4
 CwlUtX8kKYFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="168665300"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="168665300"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 22:14:29 -0700
IronPort-SDR: 39O8PSce9e5fbPnfffvC6YRAcyQjb4M4hb+Ju/RdZpzEPINXwHx1nS4W2DKiHWOS1rS49xtlY7
 6/NKyMM7kdXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440326684"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2021 22:14:28 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMOVn-0000W9-9B; Wed, 17 Mar 2021 05:14:27 +0000
Date:   Wed, 17 Mar 2021 13:14:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 854941b1caf5432705e5f3b3afbcea20107a5dc7
Message-ID: <6051902b.lRxhUFVxCVtLGYbS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 854941b1caf5432705e5f3b3afbcea20107a5dc7  efi: use 32-bit alignment for efi_guid_t literals

elapsed time: 723m

configs tested: 125
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
arm                          moxart_defconfig
m68k                         apollo_defconfig
sh                             espt_defconfig
powerpc                       holly_defconfig
powerpc                        icon_defconfig
arm                         hackkit_defconfig
arm                          gemini_defconfig
sh                               j2_defconfig
arm                         vf610m4_defconfig
powerpc                      pmac32_defconfig
powerpc                     akebono_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
arm                           u8500_defconfig
csky                                defconfig
powerpc                         ps3_defconfig
sh                           se7206_defconfig
arm                       netwinder_defconfig
arm                           spitz_defconfig
mips                        nlm_xlp_defconfig
xtensa                generic_kc705_defconfig
sh                        edosk7760_defconfig
openrisc                            defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         tb0287_defconfig
arm                        clps711x_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                          ep93xx_defconfig
powerpc                     mpc512x_defconfig
arm                         orion5x_defconfig
sh                          sdk7780_defconfig
mips                            ar7_defconfig
sh                           se7712_defconfig
s390                                defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     pseries_defconfig
arm                         assabet_defconfig
arm                        neponset_defconfig
arm                        trizeps4_defconfig
sh                        edosk7705_defconfig
mips                         tb0219_defconfig
nios2                         10m50_defconfig
powerpc               mpc834x_itxgp_defconfig
um                            kunit_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                           se7750_defconfig
arc                            hsdk_defconfig
arm                        vexpress_defconfig
arm                           h5000_defconfig
sparc                       sparc32_defconfig
ia64                         bigsur_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210316
i386                 randconfig-a005-20210316
i386                 randconfig-a002-20210316
i386                 randconfig-a003-20210316
i386                 randconfig-a004-20210316
i386                 randconfig-a006-20210316
x86_64               randconfig-a011-20210316
x86_64               randconfig-a016-20210316
x86_64               randconfig-a013-20210316
x86_64               randconfig-a014-20210316
x86_64               randconfig-a015-20210316
x86_64               randconfig-a012-20210316
i386                 randconfig-a013-20210316
i386                 randconfig-a016-20210316
i386                 randconfig-a011-20210316
i386                 randconfig-a012-20210316
i386                 randconfig-a015-20210316
i386                 randconfig-a014-20210316
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210316
x86_64               randconfig-a001-20210316
x86_64               randconfig-a005-20210316
x86_64               randconfig-a004-20210316
x86_64               randconfig-a003-20210316
x86_64               randconfig-a002-20210316

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
