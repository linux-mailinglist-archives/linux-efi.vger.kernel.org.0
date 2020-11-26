Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5376E2C5058
	for <lists+linux-efi@lfdr.de>; Thu, 26 Nov 2020 09:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgKZIYl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Nov 2020 03:24:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:49240 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729577AbgKZIYl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Nov 2020 03:24:41 -0500
IronPort-SDR: P5EE2qLVCnH+RYNfOSgiMG//SVKLXgnC6zp9puQe1yvHG0NhxvgBZChyQnjqMmbF0D1rCtLh30
 EejYnzFoDTNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="172410604"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="172410604"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 00:24:40 -0800
IronPort-SDR: /IoS6GpcalzQc+x6cmVPlccujnn/CupxTQKzfFg5n2U1aP8SF3HAPBg2rg75tSFpcF34f19Cui
 pGef/EuNa6Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="328288193"
Received: from lkp-server02.sh.intel.com (HELO 334d66ce2fbf) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2020 00:24:39 -0800
Received: from kbuild by 334d66ce2fbf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiCZy-00000m-EF; Thu, 26 Nov 2020 08:24:38 +0000
Date:   Thu, 26 Nov 2020 16:24:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 36a237526cd81ff4b6829e6ebd60921c6f976e3b
Message-ID: <5fbf6621.DuifaFxEmoYfbT7j%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: 36a237526cd81ff4b6829e6ebd60921c6f976e3b  efi: EFI_EARLYCON should depend on EFI

elapsed time: 720m

configs tested: 113
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
m68k                       m5208evb_defconfig
powerpc                      obs600_defconfig
arm                            pleb_defconfig
powerpc                        warp_defconfig
arm                            mps2_defconfig
m68k                          hp300_defconfig
arc                        vdk_hs38_defconfig
arm                            qcom_defconfig
m68k                        mvme147_defconfig
arm                            dove_defconfig
sh                   rts7751r2dplus_defconfig
s390                       zfcpdump_defconfig
powerpc                    ge_imp3a_defconfig
ia64                                defconfig
arm                       netwinder_defconfig
powerpc                   bluestone_defconfig
mips                        qi_lb60_defconfig
arm                         lubbock_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                       mainstone_defconfig
arm                          pcm027_defconfig
powerpc                       eiger_defconfig
um                            kunit_defconfig
powerpc                   motionpro_defconfig
arc                        nsim_700_defconfig
mips                        bcm47xx_defconfig
arm                           sunxi_defconfig
arm                         cm_x300_defconfig
powerpc                      ep88xc_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                   lite5200b_defconfig
h8300                    h8300h-sim_defconfig
powerpc                     tqm8540_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201126
i386                 randconfig-a003-20201126
i386                 randconfig-a002-20201126
i386                 randconfig-a005-20201126
i386                 randconfig-a001-20201126
i386                 randconfig-a006-20201126
i386                 randconfig-a004-20201125
i386                 randconfig-a003-20201125
i386                 randconfig-a002-20201125
i386                 randconfig-a005-20201125
i386                 randconfig-a001-20201125
i386                 randconfig-a006-20201125
x86_64               randconfig-a015-20201125
x86_64               randconfig-a011-20201125
x86_64               randconfig-a014-20201125
x86_64               randconfig-a016-20201125
x86_64               randconfig-a012-20201125
x86_64               randconfig-a013-20201125
i386                 randconfig-a012-20201126
i386                 randconfig-a013-20201126
i386                 randconfig-a011-20201126
i386                 randconfig-a016-20201126
i386                 randconfig-a014-20201126
i386                 randconfig-a015-20201126
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                               rhel-8.3
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20201125
x86_64               randconfig-a003-20201125
x86_64               randconfig-a004-20201125
x86_64               randconfig-a005-20201125
x86_64               randconfig-a002-20201125
x86_64               randconfig-a001-20201125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
