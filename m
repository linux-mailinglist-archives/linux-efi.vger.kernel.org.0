Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E11E2B73D3
	for <lists+linux-efi@lfdr.de>; Wed, 18 Nov 2020 02:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKRBl2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Nov 2020 20:41:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:55080 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgKRBl2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Nov 2020 20:41:28 -0500
IronPort-SDR: 3xdbOYEemAGTsibl2kxBU+T9oJGrKkxi2lFn8dJ0zu8M7HpkzOkzKc3jNRQhp90EhuRT/JxCkW
 KjkIEaInLNtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="167537728"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="167537728"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 17:41:27 -0800
IronPort-SDR: tFSK/cEdR4m2TLVOhtPz8+RFClsVPZMnaaOp5z90rm6qhAvXqYSrUdNv+w/STdzn/8ndl26h+r
 eBA6Lf6XbL2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="359129325"
Received: from lkp-server01.sh.intel.com (HELO d102174a0e0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2020 17:41:26 -0800
Received: from kbuild by d102174a0e0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfCTN-0000Ep-PQ; Wed, 18 Nov 2020 01:41:25 +0000
Date:   Wed, 18 Nov 2020 09:40:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 006405b324c071ebdcb5f6ebdc853edf8a8b7690
Message-ID: <5fb47ba8.pCB0CLlbzI9tNtsL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 006405b324c071ebdcb5f6ebdc853edf8a8b7690  ARM: head.S: explicitly map DT even if it lives in the first physical section

elapsed time: 721m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         10m50_defconfig
powerpc                       eiger_defconfig
m68k                        mvme147_defconfig
xtensa                          iss_defconfig
mips                           ci20_defconfig
arm                         axm55xx_defconfig
arm                         lpc18xx_defconfig
arm                          moxart_defconfig
arm                           u8500_defconfig
m68k                            mac_defconfig
arm                              alldefconfig
m68k                          hp300_defconfig
arm                          gemini_defconfig
arm                      tct_hammer_defconfig
mips                        bcm47xx_defconfig
powerpc                     tqm8541_defconfig
powerpc                 mpc832x_rdb_defconfig
arc                        nsim_700_defconfig
powerpc                      pmac32_defconfig
mips                         mpc30x_defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
i386                 randconfig-a006-20201117
i386                 randconfig-a005-20201117
i386                 randconfig-a001-20201117
i386                 randconfig-a002-20201117
i386                 randconfig-a004-20201117
i386                 randconfig-a003-20201117
x86_64               randconfig-a015-20201117
x86_64               randconfig-a011-20201117
x86_64               randconfig-a014-20201117
x86_64               randconfig-a013-20201117
x86_64               randconfig-a016-20201117
x86_64               randconfig-a012-20201117
i386                 randconfig-a012-20201117
i386                 randconfig-a014-20201117
i386                 randconfig-a016-20201117
i386                 randconfig-a011-20201117
i386                 randconfig-a015-20201117
i386                 randconfig-a013-20201117
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
x86_64               randconfig-a003-20201117
x86_64               randconfig-a005-20201117
x86_64               randconfig-a004-20201117
x86_64               randconfig-a002-20201117
x86_64               randconfig-a001-20201117
x86_64               randconfig-a006-20201117

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
