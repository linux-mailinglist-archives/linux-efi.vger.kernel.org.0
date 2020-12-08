Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208FE2D36D1
	for <lists+linux-efi@lfdr.de>; Wed,  9 Dec 2020 00:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbgLHXRQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Dec 2020 18:17:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:5810 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbgLHXRQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Dec 2020 18:17:16 -0500
IronPort-SDR: wwB2n8Z7e29OrMEMuBkaO6TWIjuKdzaBbIaknQ39kaRU8BdChLKIrc7O4sYzz3a6xnKsg1o+H6
 AmmEVV6sG4gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="153796296"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="153796296"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 15:16:36 -0800
IronPort-SDR: rsKVPS/Em35/OBAzPYTjq4K59mkMKdVi0+cBDEKdRGv0//Dbj7yBJ9ko1g+4JSb575xnF0lMBz
 mlzWd8WqCNLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="370570205"
Received: from lkp-server01.sh.intel.com (HELO 4e633a5ce5ea) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2020 15:16:34 -0800
Received: from kbuild by 4e633a5ce5ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmmDi-00000P-9o; Tue, 08 Dec 2020 23:16:34 +0000
Date:   Wed, 09 Dec 2020 07:16:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS b27ca384049075401be4ccef5c664f66142f7028
Message-ID: <5fd00946.VfrJ8kbFZ4NKeL+x%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: b27ca384049075401be4ccef5c664f66142f7028  efi: efivars: remove deprecated sysfs interface

elapsed time: 725m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
parisc                           alldefconfig
mips                           mtx1_defconfig
sh                          r7785rp_defconfig
arm                        keystone_defconfig
sh                         ecovec24_defconfig
powerpc                      makalu_defconfig
powerpc                      tqm8xx_defconfig
sh                          landisk_defconfig
sh                        edosk7760_defconfig
arm                          lpd270_defconfig
arm                           corgi_defconfig
c6x                        evmc6678_defconfig
m68k                         apollo_defconfig
powerpc                     ep8248e_defconfig
sh                           se7343_defconfig
arm                            qcom_defconfig
powerpc                      mgcoge_defconfig
sh                             espt_defconfig
mips                        maltaup_defconfig
m68k                          sun3x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
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
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201208
x86_64               randconfig-a012-20201208
x86_64               randconfig-a013-20201208
x86_64               randconfig-a014-20201208
x86_64               randconfig-a015-20201208
x86_64               randconfig-a011-20201208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
