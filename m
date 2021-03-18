Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED7334113B
	for <lists+linux-efi@lfdr.de>; Fri, 19 Mar 2021 00:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhCRXxB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Mar 2021 19:53:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:28377 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhCRXxB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Mar 2021 19:53:01 -0400
IronPort-SDR: 4JozxgC8bJ4hR8SGVrwJDX05y33z1dNZXpvl/hKjBlEEpCQ/ZAgGc6jeWpnLVrfyXLPM4Bzump
 F2qXKBIL3+wQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="169714982"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="169714982"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 16:53:00 -0700
IronPort-SDR: eHFEeiaN+2AaqZpDA1hTunGuxzCFpWc9MnPFN/a7C1njXHj9bqRmvf7TuFUn6OYY6xvhWgBjzt
 dLjk2efrar2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="441108536"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Mar 2021 16:52:59 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lN2Rn-0001UC-6R; Thu, 18 Mar 2021 23:52:59 +0000
Date:   Fri, 19 Mar 2021 07:51:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS d272258400e00e203ef6d9ba5b8620d5582889b2
Message-ID: <6053e79f.CXd1N9i2xINj4nHA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: d272258400e00e203ef6d9ba5b8620d5582889b2  efi/apple-properties: Handle device properties with software node API

elapsed time: 722m

configs tested: 109
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
arm                       omap2plus_defconfig
powerpc                 mpc8560_ads_defconfig
sh                        apsh4ad0a_defconfig
s390                             alldefconfig
riscv                             allnoconfig
arm                        clps711x_defconfig
sparc                            alldefconfig
powerpc                        icon_defconfig
xtensa                  nommu_kc705_defconfig
xtensa                    xip_kc705_defconfig
sh                         apsh4a3a_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     skiroot_defconfig
arm                            qcom_defconfig
m68k                       m5249evb_defconfig
powerpc                     pseries_defconfig
powerpc                      ppc64e_defconfig
arm                          badge4_defconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
mips                  maltasmvp_eva_defconfig
mips                        qi_lb60_defconfig
xtensa                           alldefconfig
powerpc                    mvme5100_defconfig
arm64                            alldefconfig
ia64                          tiger_defconfig
arm                           sunxi_defconfig
m68k                       m5475evb_defconfig
sh                             espt_defconfig
powerpc                      ppc44x_defconfig
arm                          pxa3xx_defconfig
m68k                       m5208evb_defconfig
m68k                       bvme6000_defconfig
powerpc                     kmeter1_defconfig
mips                        vocore2_defconfig
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
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
