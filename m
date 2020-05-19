Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EDA1DA14C
	for <lists+linux-efi@lfdr.de>; Tue, 19 May 2020 21:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgESTuI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 May 2020 15:50:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:31602 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgESTuH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 May 2020 15:50:07 -0400
IronPort-SDR: STXlRy+9nEX7xX/8gscW0BUZ+MWT9MJBPeeTbg0hvKiQ5lMZ2FnGm68MI+7J4foVSN4RXnm1Eq
 SssOsCWh2xew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 12:50:07 -0700
IronPort-SDR: vhOesVOFks9k6j3WqB6SV0zv2uIS2icxaj+/6PMo35zjPqx7Mvo8jRTK2pN4R1k1t/N6S+RsBN
 gFp7bK+XkICA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="411753494"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 May 2020 12:50:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jb8FW-000Cqf-Kg; Wed, 20 May 2020 03:50:02 +0800
Date:   Wed, 20 May 2020 03:49:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS e5fbadd1179cdadeaa44d71a9ec068c5bc100524
Message-ID: <5ec43864.k49PwbWiWW6m6JmK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: e5fbadd1179cdadeaa44d71a9ec068c5bc100524  efi/libstub: use pool allocation for the command line

i386-tinyconfig vmlinux size:

+-------+------------------------------------+--------------------------------------------------------------------------+
| DELTA |               SYMBOL               |                                  COMMIT                                  |
+-------+------------------------------------+--------------------------------------------------------------------------+
|   +96 | TOTAL                              | 4da0b2b7e675..e5fbadd1179c (ALL COMMITS)                                 |
|   +96 | TOTAL                              | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|   +96 | TEXT                               | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
| +1355 | balance_dirty_pages()              | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|  +615 | __setup_rt_frame()                 | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|  +136 | arch/x86/events/zhaoxin/built-in.* | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|  +113 | klist_release()                    | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|   +93 | change_clocksource()               | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|   +86 | release_bdi()                      | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|   +84 | kobject_release()                  | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|   -68 | bdi_put()                          | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|   -77 | kobject_put()                      | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|   -79 | timekeeping_notify()               | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|   -99 | klist_dec_and_del()                | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
|  -555 | do_signal()                        | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
| -1383 | balance_dirty_pages_ratelimited()  | de8c55208c38 efi/libstub: Fix mixed mode boot issue after macro refactor |
+-------+------------------------------------+--------------------------------------------------------------------------+

elapsed time: 592m

configs tested: 119
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
sparc                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
powerpc                  mpc866_ads_defconfig
h8300                    h8300h-sim_defconfig
arm                           sunxi_defconfig
arm                        magician_defconfig
sh                         microdev_defconfig
mips                              allnoconfig
arm                          exynos_defconfig
riscv                             allnoconfig
arm                       omap2plus_defconfig
sh                                  defconfig
sh                           se7722_defconfig
powerpc64                           defconfig
riscv                          rv32_defconfig
arc                        nsimosci_defconfig
arc                        vdk_hs38_defconfig
sh                           se7751_defconfig
arm                       netwinder_defconfig
arm                          iop32x_defconfig
mips                          ath25_defconfig
mips                         tb0287_defconfig
powerpc                      mgcoge_defconfig
um                           x86_64_defconfig
powerpc                  storcenter_defconfig
sh                            shmin_defconfig
powerpc                      tqm8xx_defconfig
arm                        shmobile_defconfig
arm                           stm32_defconfig
powerpc                       holly_defconfig
mips                         tb0226_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200519
i386                 randconfig-a005-20200519
i386                 randconfig-a001-20200519
i386                 randconfig-a003-20200519
i386                 randconfig-a004-20200519
i386                 randconfig-a002-20200519
i386                 randconfig-a012-20200519
i386                 randconfig-a014-20200519
i386                 randconfig-a016-20200519
i386                 randconfig-a011-20200519
i386                 randconfig-a015-20200519
i386                 randconfig-a013-20200519
x86_64               randconfig-a003-20200519
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
