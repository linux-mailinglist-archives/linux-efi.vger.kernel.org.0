Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472BB1DC55F
	for <lists+linux-efi@lfdr.de>; Thu, 21 May 2020 04:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgEUCtj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 22:49:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:45495 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgEUCtj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 May 2020 22:49:39 -0400
IronPort-SDR: n4ggT4wiahbnZBko/TKB2hFWIp16IFAjKiI1SBh9VYxVCuKtbv2sf0HW9RUjvQNRNY45V0py/2
 x2BDvex39e3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 19:49:38 -0700
IronPort-SDR: MnRZlhfhulzGXlo28t9jBMVg/REyf2bl6hc5Jxvc8UnOobBJxJD0z/HBu1KtrHYRwm9i5w6ZdQ
 NDGY/xuy/YGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400"; 
   d="scan'208";a="253849398"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 May 2020 19:49:36 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jbbH6-00050w-BP; Thu, 21 May 2020 10:49:36 +0800
Date:   Thu, 21 May 2020 10:48:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 3727a532f27c2c43db2658c2402a0aff4caad3fd
Message-ID: <5ec5ec09.LRZSo4AQVihWC4Vq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 3727a532f27c2c43db2658c2402a0aff4caad3fd  efi/libstub: use pool allocation for the command line

i386-tinyconfig vmlinux size:

+-------+------------------------------------+--------------------------------------------------------------------------+
| DELTA |               SYMBOL               |                                  COMMIT                                  |
+-------+------------------------------------+--------------------------------------------------------------------------+
|   +96 | TOTAL                              | 4da0b2b7e675..3727a532f27c (ALL COMMITS)                                 |
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

elapsed time: 537m

configs tested: 98
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
sparc                            allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
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
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
mips                              allnoconfig
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
i386                 randconfig-a001-20200520
i386                 randconfig-a004-20200520
i386                 randconfig-a006-20200520
i386                 randconfig-a003-20200520
i386                 randconfig-a002-20200520
i386                 randconfig-a005-20200520
x86_64               randconfig-a013-20200520
x86_64               randconfig-a015-20200520
x86_64               randconfig-a016-20200520
x86_64               randconfig-a012-20200520
x86_64               randconfig-a014-20200520
x86_64               randconfig-a011-20200520
i386                 randconfig-a013-20200520
i386                 randconfig-a012-20200520
i386                 randconfig-a015-20200520
i386                 randconfig-a011-20200520
i386                 randconfig-a016-20200520
i386                 randconfig-a014-20200520
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
um                               allmodconfig
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
