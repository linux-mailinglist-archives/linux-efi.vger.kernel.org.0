Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC41D6BD5
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 21:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgEQTAH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 May 2020 15:00:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:23471 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgEQTAH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 17 May 2020 15:00:07 -0400
IronPort-SDR: SySCMsw52R3R1VyfXpjFDcIIpibM8uuM7V8vDYRxeyZxVegWEBM+OO7dcNs1NhcU1lxa5sXtEF
 Rpk+RZueKr7A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 12:00:06 -0700
IronPort-SDR: kP+av76GQi0C6uzt0nCVlTB/fP76SbVj1TeIpB26YI6fz4sFTtZMtNyxmKdDkEyCvoU0r8OG/i
 anhB1EOrlrkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,404,1583222400"; 
   d="scan'208";a="465537471"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 May 2020 12:00:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jaOW4-0001LK-Hk; Mon, 18 May 2020 03:00:04 +0800
Date:   Mon, 18 May 2020 02:59:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 b4f1874c62168159fdb419ced4afc77c1b51c475
Message-ID: <5ec18999.fm5jP26cATeQbWV+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: b4f1874c62168159fdb419ced4afc77c1b51c475  tpm: check event log version before reading final events

i386-tinyconfig vmlinux size:

+-------+------------------------------------+---------------------------------------------------------------------------+
| DELTA |               SYMBOL               |                                  COMMIT                                   |
+-------+------------------------------------+---------------------------------------------------------------------------+
|   +96 | TOTAL                              | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|   +96 | TEXT                               | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
| +1355 | balance_dirty_pages()              | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|  +615 | __setup_rt_frame()                 | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|  +136 | arch/x86/events/zhaoxin/built-in.* | a088b858f16a..b4f1874c6216 (ALL COMMITS)                                  |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 8f592ada59b3 efi/earlycon: Fix early printk for wider fonts               |
|  +136 | arch/x86/events/zhaoxin/built-in.* | e8da08a08823 efi: Pull up arch-specific prototype efi_systab_show_arch()  |
|  -136 | arch/x86/events/zhaoxin/built-in.* | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|  +113 | klist_release()                    | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|   +93 | change_clocksource()               | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|   +86 | release_bdi()                      | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|   +84 | kobject_release()                  | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|   -68 | bdi_put()                          | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|   -77 | kobject_put()                      | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|   -79 | timekeeping_notify()               | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|   -99 | klist_dec_and_del()                | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
|  -555 | do_signal()                        | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
| -1383 | balance_dirty_pages_ratelimited()  | fd6261959806 efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820 |
+-------+------------------------------------+---------------------------------------------------------------------------+

elapsed time: 504m

configs tested: 115
configs skipped: 23

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
sparc                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
sh                             sh03_defconfig
arm                         vf610m4_defconfig
h8300                               defconfig
m68k                        m5407c3_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
ia64                          tiger_defconfig
arm                        mini2440_defconfig
nios2                         10m50_defconfig
powerpc                      ppc40x_defconfig
arm                        oxnas_v6_defconfig
sh                           cayman_defconfig
powerpc                      mgcoge_defconfig
arm                            hisi_defconfig
sh                           sh2007_defconfig
openrisc                 simple_smp_defconfig
h8300                       h8s-sim_defconfig
mips                         db1xxx_defconfig
powerpc                     mpc512x_defconfig
sh                     sh7710voipgw_defconfig
arm                            lart_defconfig
mips                            ar7_defconfig
arm                         assabet_defconfig
mips                          ath25_defconfig
ia64                             allyesconfig
mips                          malta_defconfig
arm                          exynos_defconfig
m68k                                defconfig
xtensa                           allyesconfig
xtensa                         virt_defconfig
arm                      tct_hammer_defconfig
mips                          ath79_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20200517
x86_64               randconfig-a003-20200517
x86_64               randconfig-a006-20200517
x86_64               randconfig-a004-20200517
x86_64               randconfig-a001-20200517
x86_64               randconfig-a002-20200517
i386                 randconfig-a006-20200517
i386                 randconfig-a005-20200517
i386                 randconfig-a003-20200517
i386                 randconfig-a001-20200517
i386                 randconfig-a004-20200517
i386                 randconfig-a002-20200517
i386                 randconfig-a012-20200517
i386                 randconfig-a016-20200517
i386                 randconfig-a014-20200517
i386                 randconfig-a011-20200517
i386                 randconfig-a013-20200517
i386                 randconfig-a015-20200517
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
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
