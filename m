Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2030F168CEC
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2020 07:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgBVGpF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Feb 2020 01:45:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:4805 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgBVGpF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 22 Feb 2020 01:45:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 22:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,471,1574150400"; 
   d="scan'208";a="229400689"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Feb 2020 22:45:02 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j5OX8-00059J-8j; Sat, 22 Feb 2020 14:45:02 +0800
Date:   Sat, 22 Feb 2020 14:44:45 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD REGRESSION
 c0cd4ad8a865f910e646f37b16566a2f408e63a4
Message-ID: <5e50cddd.xw5Z5awiP+b+F8JV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: c0cd4ad8a865f910e646f37b16566a2f408e63a4  efi: Bump the Linux EFI stub major version number to #1

Regressions in current branch:

drivers/firmware/efi/libstub/file.c:81 efi_open_volume() error: potentially dereferencing uninitialized 'io'.
drivers/firmware/efi/libstub/x86-stub.c:183 retrieve_apple_device_properties() error: potentially dereferencing uninitialized 'p'.
drivers/firmware/efi/libstub/x86-stub.c:387 efi_pe_entry() error: potentially dereferencing uninitialized 'image'.

Error ids grouped by kconfigs:

recent_errors
`-- x86_64-defconfig
    |-- drivers-firmware-efi-libstub-file.c-efi_open_volume()-error:potentially-dereferencing-uninitialized-io-.
    |-- drivers-firmware-efi-libstub-x86-stub.c-efi_pe_entry()-error:potentially-dereferencing-uninitialized-image-.
    `-- drivers-firmware-efi-libstub-x86-stub.c-retrieve_apple_device_properties()-error:potentially-dereferencing-uninitialized-p-.

TIMEOUT after 861m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 1

x86_64                            allnoconfig

configs tested: 145
configs skipped: 0

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              allnoconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200221
x86_64               randconfig-a002-20200221
x86_64               randconfig-a003-20200221
i386                 randconfig-a001-20200221
i386                 randconfig-a002-20200221
i386                 randconfig-a003-20200221
alpha                randconfig-a001-20200222
m68k                 randconfig-a001-20200222
mips                 randconfig-a001-20200222
nds32                randconfig-a001-20200222
parisc               randconfig-a001-20200222
riscv                randconfig-a001-20200222
nios2                randconfig-a001-20200221
c6x                  randconfig-a001-20200221
microblaze           randconfig-a001-20200221
sparc64              randconfig-a001-20200221
h8300                randconfig-a001-20200221
csky                 randconfig-a001-20200222
openrisc             randconfig-a001-20200222
s390                 randconfig-a001-20200222
sh                   randconfig-a001-20200222
xtensa               randconfig-a001-20200222
csky                 randconfig-a001-20200221
openrisc             randconfig-a001-20200221
s390                 randconfig-a001-20200221
sh                   randconfig-a001-20200221
xtensa               randconfig-a001-20200221
x86_64               randconfig-b001-20200221
x86_64               randconfig-b002-20200221
x86_64               randconfig-b003-20200221
i386                 randconfig-b001-20200221
i386                 randconfig-b002-20200221
i386                 randconfig-b003-20200221
x86_64               randconfig-d001-20200221
x86_64               randconfig-d002-20200221
x86_64               randconfig-d003-20200221
i386                 randconfig-d001-20200221
i386                 randconfig-d002-20200221
i386                 randconfig-d003-20200221
x86_64               randconfig-h001-20200221
x86_64               randconfig-h002-20200221
x86_64               randconfig-h003-20200221
i386                 randconfig-h001-20200221
i386                 randconfig-h002-20200221
i386                 randconfig-h003-20200221
arc                  randconfig-a001-20200221
arm                  randconfig-a001-20200221
arm64                randconfig-a001-20200221
ia64                 randconfig-a001-20200221
powerpc              randconfig-a001-20200221
sparc                randconfig-a001-20200221
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
