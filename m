Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731D82DA6E4
	for <lists+linux-efi@lfdr.de>; Tue, 15 Dec 2020 04:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgLODg7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Dec 2020 22:36:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:50241 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgLODgu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Dec 2020 22:36:50 -0500
IronPort-SDR: 7ixVyhWQFa4meuSyZRTH/iK5/QUgUmxbSrmOnhVtXfSm93+wv0iZ+I+KsLvKu6QlsDIdet5q2k
 KiW6o0vlWEZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="161873542"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="161873542"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 19:36:07 -0800
IronPort-SDR: JpMZreuBAFndPzePJe7dYnEO87hpSge6WwyzbdM0eSR+i5lf/bq0gjxBs0LRCf13xGTawppiFi
 rHWp+n4ij6kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="341338312"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2020 19:36:06 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kp188-0000ZM-6Y; Tue, 15 Dec 2020 03:36:04 +0000
Date:   Tue, 15 Dec 2020 11:35:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 9e5e3919781dc9120b86623dcd5b0661fe6a0acc
Message-ID: <5fd82f09.UbFqengeqrVfqZ0k%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 9e5e3919781dc9120b86623dcd5b0661fe6a0acc  efi: efivars: remove deprecated sysfs interface

elapsed time: 723m

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
powerpc                       maple_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
h8300                     edosk2674_defconfig
sh                          sdk7780_defconfig
m68k                           sun3_defconfig
arm                            u300_defconfig
arm                       aspeed_g4_defconfig
arm                        shmobile_defconfig
mips                            ar7_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                          g5_defconfig
powerpc                     stx_gp3_defconfig
powerpc                         ps3_defconfig
powerpc                      obs600_defconfig
sh                ecovec24-romimage_defconfig
sh                   sh7770_generic_defconfig
powerpc                     kmeter1_defconfig
mips                        nlm_xlp_defconfig
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
i386                 randconfig-a001-20201214
i386                 randconfig-a004-20201214
i386                 randconfig-a003-20201214
i386                 randconfig-a002-20201214
i386                 randconfig-a006-20201214
i386                 randconfig-a005-20201214
x86_64               randconfig-a016-20201214
x86_64               randconfig-a012-20201214
x86_64               randconfig-a013-20201214
x86_64               randconfig-a015-20201214
x86_64               randconfig-a014-20201214
x86_64               randconfig-a011-20201214
i386                 randconfig-a014-20201214
i386                 randconfig-a013-20201214
i386                 randconfig-a012-20201214
i386                 randconfig-a011-20201214
i386                 randconfig-a015-20201214
i386                 randconfig-a016-20201214
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
x86_64               randconfig-a003-20201214
x86_64               randconfig-a006-20201214
x86_64               randconfig-a002-20201214
x86_64               randconfig-a005-20201214
x86_64               randconfig-a004-20201214
x86_64               randconfig-a001-20201214

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
