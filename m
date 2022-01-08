Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9014882AE
	for <lists+linux-efi@lfdr.de>; Sat,  8 Jan 2022 10:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiAHJFs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Jan 2022 04:05:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:2783 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbiAHJFr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 8 Jan 2022 04:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641632747; x=1673168747;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Nt+5fxqWUBhG+R7NH/cQ+EJ3cdsdDszTyyGTOJqYGZE=;
  b=Z+1Z8yjPE+WsDKmLnlxG8kTUdcJ0vhQjmhaEBKsDpU6WUuW/gLn1UyVf
   PwssZ2B36gIeVIu9WWNbWIBoNLwKy0pG1RHcJB3HHaGYb7whVP9wZ3Rya
   W2yY0iVJk4frlwQoAYa62SaajC9/rekSQsHI4a+jiEH20RtfZyvpEuYih
   0yZPOAesFXkEQfSz223k7LegrbPMPnj+gQdjwGnDpb+TVsoCClO9+m/US
   4jBCIUC2mR2XAwsBFtwhEkVOvxp8Rf7qutOh2r0FLUy02hLCxmwrrNBoj
   VrYbXYoXyfHC3LFDKwLB2xPll1RrFI+IAAeHFH3nyGAsKCheEjSikYNnr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="222987933"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="222987933"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 01:05:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="514102984"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2022 01:05:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n67fV-0000SC-AT; Sat, 08 Jan 2022 09:05:45 +0000
Date:   Sat, 08 Jan 2022 17:05:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 42f4046bc4ba56c6e4d2af7a9d7f70eaa563daec
Message-ID: <61d953bc.7psJ1B6K83HsiOQL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 42f4046bc4ba56c6e4d2af7a9d7f70eaa563daec  efi: use default_groups in kobj_type

elapsed time: 2068m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
arm                          iop32x_defconfig
powerpc                 canyonlands_defconfig
powerpc                     mpc83xx_defconfig
ia64                         bigsur_defconfig
sh                        edosk7760_defconfig
powerpc                    sam440ep_defconfig
arm64                            alldefconfig
riscv             nommu_k210_sdcard_defconfig
um                             i386_defconfig
mips                  maltasmvp_eva_defconfig
mips                           jazz_defconfig
arm                       aspeed_g5_defconfig
parisc                generic-64bit_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     pq2fads_defconfig
mips                          rb532_defconfig
sh                             shx3_defconfig
ia64                      gensparse_defconfig
arm                         cm_x300_defconfig
arm                           h3600_defconfig
sh                           se7721_defconfig
sh                          sdk7780_defconfig
xtensa                           alldefconfig
arm                  randconfig-c002-20220107
arm                  randconfig-c002-20220108
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
parisc                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20220107
x86_64               randconfig-a001-20220107
x86_64               randconfig-a006-20220107
x86_64               randconfig-a002-20220107
x86_64               randconfig-a004-20220107
x86_64               randconfig-a003-20220107
i386                 randconfig-a005-20220107
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
i386                 randconfig-a003-20220107
x86_64               randconfig-a015-20220108
x86_64               randconfig-a012-20220108
x86_64               randconfig-a014-20220108
x86_64               randconfig-a013-20220108
x86_64               randconfig-a011-20220108
x86_64               randconfig-a016-20220108
i386                 randconfig-a012-20220108
i386                 randconfig-a016-20220108
i386                 randconfig-a015-20220108
i386                 randconfig-a014-20220108
i386                 randconfig-a011-20220108
i386                 randconfig-a013-20220108
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
mips                           mtx1_defconfig
powerpc                     skiroot_defconfig
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
i386                 randconfig-a012-20220107
i386                 randconfig-a016-20220107
i386                 randconfig-a014-20220107
i386                 randconfig-a015-20220107
i386                 randconfig-a011-20220107
i386                 randconfig-a013-20220107
x86_64               randconfig-a005-20220108
x86_64               randconfig-a001-20220108
x86_64               randconfig-a004-20220108
x86_64               randconfig-a006-20220108
x86_64               randconfig-a003-20220108
x86_64               randconfig-a002-20220108
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107
s390                 randconfig-r044-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
