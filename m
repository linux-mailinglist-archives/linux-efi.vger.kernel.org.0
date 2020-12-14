Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24B82D9244
	for <lists+linux-efi@lfdr.de>; Mon, 14 Dec 2020 05:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438589AbgLNEZZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Dec 2020 23:25:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:18749 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438573AbgLNEZZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 13 Dec 2020 23:25:25 -0500
IronPort-SDR: QeUCFm9PfboXG74JvJuGhFo8SVtWJwOU1m2CytQD7cDBgRHn6QTkZ0U1ELEGLDk/ny8rCI6qiZ
 7YR1ZMLcEytA==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="259378938"
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="259378938"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2020 20:24:43 -0800
IronPort-SDR: tj6bmZSZi/AB93OBqpaKTzbSZos7gh216swmHngn0MBTwyDbx8oKaMpR0fdicnP2N9n/gvewG6
 FbZgHz1oPuhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="335756386"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2020 20:24:42 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kofPd-00008n-PS; Mon, 14 Dec 2020 04:24:41 +0000
Date:   Mon, 14 Dec 2020 12:24:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 7b7ab8de753afd63b440db5cfb39a8c205d1103d
Message-ID: <5fd6e906.YzyjTBBhd1EuEBuy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 7b7ab8de753afd63b440db5cfb39a8c205d1103d  efi: efivars: remove deprecated sysfs interface

elapsed time: 723m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc8540_ads_defconfig
sparc64                          alldefconfig
arm                        magician_defconfig
powerpc                        cell_defconfig
powerpc                   bluestone_defconfig
sh                   secureedge5410_defconfig
c6x                         dsk6455_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
arm                            lart_defconfig
arm                   milbeaut_m10v_defconfig
sparc                       sparc32_defconfig
mips                           ip22_defconfig
xtensa                  nommu_kc705_defconfig
arm                    vt8500_v6_v7_defconfig
sh                         microdev_defconfig
alpha                            allyesconfig
arm                        neponset_defconfig
powerpc                     skiroot_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
x86_64               randconfig-a003-20201213
x86_64               randconfig-a006-20201213
x86_64               randconfig-a002-20201213
x86_64               randconfig-a005-20201213
x86_64               randconfig-a004-20201213
x86_64               randconfig-a001-20201213
i386                 randconfig-a001-20201213
i386                 randconfig-a004-20201213
i386                 randconfig-a003-20201213
i386                 randconfig-a002-20201213
i386                 randconfig-a005-20201213
i386                 randconfig-a006-20201213
i386                 randconfig-a014-20201213
i386                 randconfig-a013-20201213
i386                 randconfig-a012-20201213
i386                 randconfig-a011-20201213
i386                 randconfig-a016-20201213
i386                 randconfig-a015-20201213
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
x86_64               randconfig-a016-20201213
x86_64               randconfig-a012-20201213
x86_64               randconfig-a013-20201213
x86_64               randconfig-a015-20201213
x86_64               randconfig-a014-20201213
x86_64               randconfig-a011-20201213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
