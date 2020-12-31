Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41CB2E82A7
	for <lists+linux-efi@lfdr.de>; Fri,  1 Jan 2021 00:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgLaXYY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Dec 2020 18:24:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:31950 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgLaXYX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 31 Dec 2020 18:24:23 -0500
IronPort-SDR: t5Rz6lQDKTFbKwL3cuUY+n2bKyTQjyvzyQKRQHKpKS767eisdJwYURQhz4A3A/ared9LGPMNAN
 yefqco5YnE9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9851"; a="163812579"
X-IronPort-AV: E=Sophos;i="5.78,464,1599548400"; 
   d="scan'208";a="163812579"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2020 15:23:41 -0800
IronPort-SDR: c7qcJ2TUbfdMoXVFKTj19QgcLK6G7Nqc0vOXUN+6JVACNSOYfXlFcYVvwwB/FN3FlXGZxC/A96
 ZfN6qkptoh8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,464,1599548400"; 
   d="scan'208";a="401028870"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Dec 2020 15:23:39 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kv7IB-0005EF-87; Thu, 31 Dec 2020 23:23:39 +0000
Date:   Fri, 01 Jan 2021 07:23:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 355845b738e76445c8522802552146d96cb4afa7
Message-ID: <5fee5d76.hESoUCEK32lq7B8n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: 355845b738e76445c8522802552146d96cb4afa7  efi/apple-properties: Reinstate support for boolean properties

elapsed time: 720m

configs tested: 103
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
sh                          r7785rp_defconfig
mips                      bmips_stb_defconfig
arm                           omap1_defconfig
powerpc                     tqm8548_defconfig
arm                          pxa3xx_defconfig
arc                        vdk_hs38_defconfig
ia64                          tiger_defconfig
mips                          malta_defconfig
arm                           sunxi_defconfig
powerpc                     akebono_defconfig
m68k                          amiga_defconfig
mips                     loongson1c_defconfig
arm                          lpd270_defconfig
arm                          collie_defconfig
sh                   sh7724_generic_defconfig
mips                      pic32mzda_defconfig
arm                       aspeed_g5_defconfig
arm                           spitz_defconfig
powerpc                     tqm8540_defconfig
m68k                                defconfig
m68k                       m5475evb_defconfig
powerpc                 canyonlands_defconfig
arm                           corgi_defconfig
mips                       bmips_be_defconfig
arm                      integrator_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc836x_mds_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a015-20201231
x86_64               randconfig-a014-20201231
x86_64               randconfig-a011-20201231
x86_64               randconfig-a016-20201231
x86_64               randconfig-a013-20201231
x86_64               randconfig-a012-20201231
i386                 randconfig-a016-20201231
i386                 randconfig-a014-20201231
i386                 randconfig-a012-20201231
i386                 randconfig-a015-20201231
i386                 randconfig-a011-20201231
i386                 randconfig-a013-20201231
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201230
x86_64               randconfig-a014-20201230
x86_64               randconfig-a016-20201230
x86_64               randconfig-a011-20201230
x86_64               randconfig-a013-20201230
x86_64               randconfig-a012-20201230
x86_64               randconfig-a005-20201231
x86_64               randconfig-a006-20201231
x86_64               randconfig-a001-20201231
x86_64               randconfig-a002-20201231
x86_64               randconfig-a004-20201231
x86_64               randconfig-a003-20201231

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
