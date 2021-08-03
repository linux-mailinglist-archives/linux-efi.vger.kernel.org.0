Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE683DF4D7
	for <lists+linux-efi@lfdr.de>; Tue,  3 Aug 2021 20:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbhHCSjJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Aug 2021 14:39:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:25165 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239134AbhHCSjI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Aug 2021 14:39:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="213483761"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="213483761"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 11:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="667331227"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2021 11:38:55 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mAzJX-000EAv-9G; Tue, 03 Aug 2021 18:38:55 +0000
Date:   Wed, 04 Aug 2021 02:37:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 c32ac11da3f83bb42b986702a9b92f0a14ed4182
Message-ID: <61098d04.So2Rviw3dS/F0AAF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: c32ac11da3f83bb42b986702a9b92f0a14ed4182  efi/libstub: arm64: Double check image alignment at entry

elapsed time: 727m

configs tested: 129
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210803
arm                          pxa3xx_defconfig
sh                           se7751_defconfig
arm                         assabet_defconfig
arm                          pxa910_defconfig
powerpc                 mpc8315_rdb_defconfig
parisc                              defconfig
ia64                                defconfig
x86_64                            allnoconfig
arm                         nhk8815_defconfig
arm                  colibri_pxa300_defconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
sh                         apsh4a3a_defconfig
riscv                            allyesconfig
powerpc                    socrates_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
sh                        sh7763rdp_defconfig
sh                          sdk7786_defconfig
mips                           ip27_defconfig
um                           x86_64_defconfig
arm                           h3600_defconfig
mips                        jmr3927_defconfig
arm                      footbridge_defconfig
mips                      maltasmvp_defconfig
powerpc                      walnut_defconfig
mips                            ar7_defconfig
m68k                       m5275evb_defconfig
arm                        spear3xx_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     powernv_defconfig
m68k                        mvme16x_defconfig
mips                       rbtx49xx_defconfig
powerpc                     ksi8560_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      bamboo_defconfig
arm                          ixp4xx_defconfig
powerpc                      ppc44x_defconfig
powerpc                  iss476-smp_defconfig
sh                                  defconfig
arm                          moxart_defconfig
sh                          kfr2r09_defconfig
arm                         palmz72_defconfig
ia64                             allmodconfig
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
i386                 randconfig-a004-20210803
i386                 randconfig-a005-20210803
i386                 randconfig-a002-20210803
i386                 randconfig-a006-20210803
i386                 randconfig-a001-20210803
i386                 randconfig-a003-20210803
x86_64               randconfig-a012-20210802
x86_64               randconfig-a016-20210802
x86_64               randconfig-a013-20210802
x86_64               randconfig-a011-20210802
x86_64               randconfig-a014-20210802
x86_64               randconfig-a015-20210802
i386                 randconfig-a012-20210803
i386                 randconfig-a011-20210803
i386                 randconfig-a015-20210803
i386                 randconfig-a013-20210803
i386                 randconfig-a014-20210803
i386                 randconfig-a016-20210803
x86_64               randconfig-a002-20210803
x86_64               randconfig-a004-20210803
x86_64               randconfig-a006-20210803
x86_64               randconfig-a003-20210803
x86_64               randconfig-a001-20210803
x86_64               randconfig-a005-20210803
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210803
x86_64               randconfig-c001-20210802
x86_64               randconfig-a002-20210802
x86_64               randconfig-a004-20210802
x86_64               randconfig-a006-20210802
x86_64               randconfig-a003-20210802
x86_64               randconfig-a001-20210802
x86_64               randconfig-a005-20210802
x86_64               randconfig-a012-20210803
x86_64               randconfig-a016-20210803
x86_64               randconfig-a013-20210803
x86_64               randconfig-a011-20210803
x86_64               randconfig-a014-20210803
x86_64               randconfig-a015-20210803

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
