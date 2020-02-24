Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB61B169DD7
	for <lists+linux-efi@lfdr.de>; Mon, 24 Feb 2020 06:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgBXFnW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 00:43:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:27909 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgBXFnV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 24 Feb 2020 00:43:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 21:43:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,479,1574150400"; 
   d="scan'208";a="435797571"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2020 21:43:19 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j66WU-000EH6-SD; Mon, 24 Feb 2020 13:43:18 +0800
Date:   Mon, 24 Feb 2020 13:42:28 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD REGRESSION
 dc235d62fc60a6549238eda7ff29769457fe5663
Message-ID: <5e536244.WaSFhAJYEhoCuS4l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: dc235d62fc60a6549238eda7ff29769457fe5663  efi: Bump the Linux EFI stub major version number to #1

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

TIMEOUT after 485m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 9

mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
riscv                            allmodconfig
riscv                            allyesconfig

configs tested: 129
configs skipped: 32

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
sparc                            allyesconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
arm                              allmodconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200224
x86_64               randconfig-a002-20200224
x86_64               randconfig-a003-20200224
i386                 randconfig-a002-20200224
i386                 randconfig-a001-20200224
i386                 randconfig-a003-20200224
nds32                randconfig-a001-20200224
mips                 randconfig-a001-20200224
riscv                randconfig-a001-20200224
parisc               randconfig-a001-20200224
alpha                randconfig-a001-20200224
m68k                 randconfig-a001-20200224
nios2                randconfig-a001-20200224
c6x                  randconfig-a001-20200224
sparc64              randconfig-a001-20200224
microblaze           randconfig-a001-20200224
h8300                randconfig-a001-20200224
openrisc             randconfig-a001-20200224
sh                   randconfig-a001-20200224
s390                 randconfig-a001-20200224
xtensa               randconfig-a001-20200224
csky                 randconfig-a001-20200224
x86_64               randconfig-b001-20200223
i386                 randconfig-b002-20200223
i386                 randconfig-b003-20200223
x86_64               randconfig-b003-20200223
x86_64               randconfig-b002-20200223
i386                 randconfig-b001-20200223
i386                 randconfig-c003-20200224
i386                 randconfig-c001-20200224
x86_64               randconfig-c001-20200224
x86_64               randconfig-c003-20200224
x86_64               randconfig-c002-20200224
i386                 randconfig-c002-20200224
i386                 randconfig-d002-20200224
x86_64               randconfig-d002-20200224
x86_64               randconfig-d003-20200224
i386                 randconfig-d001-20200224
x86_64               randconfig-d001-20200224
i386                 randconfig-d003-20200224
x86_64               randconfig-e001-20200224
x86_64               randconfig-e002-20200224
x86_64               randconfig-e003-20200224
i386                 randconfig-e001-20200224
i386                 randconfig-e002-20200224
i386                 randconfig-e003-20200224
x86_64               randconfig-e002-20200223
i386                 randconfig-e001-20200223
x86_64               randconfig-e003-20200223
i386                 randconfig-e003-20200223
x86_64               randconfig-e001-20200223
i386                 randconfig-e002-20200223
x86_64               randconfig-f003-20200223
x86_64               randconfig-f002-20200223
x86_64               randconfig-f001-20200223
i386                 randconfig-f001-20200223
i386                 randconfig-f003-20200223
i386                 randconfig-f002-20200223
x86_64               randconfig-g001-20200224
i386                 randconfig-g002-20200224
i386                 randconfig-g003-20200224
x86_64               randconfig-g003-20200224
i386                 randconfig-g001-20200224
x86_64               randconfig-g002-20200224
i386                 randconfig-h003-20200223
i386                 randconfig-h002-20200223
x86_64               randconfig-h002-20200223
x86_64               randconfig-h003-20200223
i386                 randconfig-h001-20200223
x86_64               randconfig-h001-20200223
arm64                randconfig-a001-20200224
ia64                 randconfig-a001-20200224
powerpc              randconfig-a001-20200224
arm                  randconfig-a001-20200224
arc                  randconfig-a001-20200224
sparc                randconfig-a001-20200224
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
