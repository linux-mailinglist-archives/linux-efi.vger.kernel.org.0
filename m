Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C182D4C24
	for <lists+linux-efi@lfdr.de>; Wed,  9 Dec 2020 21:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgLIUpm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Dec 2020 15:45:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:31126 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733019AbgLIUpg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Dec 2020 15:45:36 -0500
IronPort-SDR: 0P7oZp9H/2gxdtsfltLUEtfIiqJGVJ4SgkDZx3fssMqp3E5XCaEgg+cECPwcgBF92iWmcDBZjO
 hYojB8RNPGTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="235742337"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="235742337"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 12:44:46 -0800
IronPort-SDR: 3yuQXS0vnYAiU8BNgToAjFIUiiwxw0ZW9xgtwfk4tamfRSCySQXmNBe1jNxEcZ7IU7MPFBoWiA
 nct+AJtYe30A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="375659771"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2020 12:44:44 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kn6KK-0000S0-4A; Wed, 09 Dec 2020 20:44:44 +0000
Date:   Thu, 10 Dec 2020 04:44:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 0d013943a149b584f910dede95f23e147170e6c5
Message-ID: <5fd13730.FCZ4vNjKPNQZcPfF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 0d013943a149b584f910dede95f23e147170e6c5  efi: efivars: remove deprecated sysfs interface

elapsed time: 722m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
arm                         lpc18xx_defconfig
sh                          rsk7203_defconfig
arm                            qcom_defconfig
arm                     eseries_pxa_defconfig
mips                     loongson1b_defconfig
powerpc                     tqm5200_defconfig
powerpc                     sequoia_defconfig
c6x                              alldefconfig
arm                          ixp4xx_defconfig
sh                          lboxre2_defconfig
arm                             mxs_defconfig
powerpc                      ppc40x_defconfig
powerpc                     mpc83xx_defconfig
m68k                        m5272c3_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
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
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
