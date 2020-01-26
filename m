Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02921498BC
	for <lists+linux-efi@lfdr.de>; Sun, 26 Jan 2020 05:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAZEjz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Jan 2020 23:39:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:44232 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbgAZEjy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 25 Jan 2020 23:39:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 20:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,364,1574150400"; 
   d="scan'208";a="251654494"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2020 20:39:53 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ivZiC-000G2X-Iz; Sun, 26 Jan 2020 12:39:52 +0800
Date:   Sun, 26 Jan 2020 12:38:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS ee45b8ddb29733b7c68825b9ab0a9685adb9ffe4
Message-ID: <5e2d17d6.Zrnw5LrWB7kUAMR5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: ee45b8ddb29733b7c68825b9ab0a9685adb9ffe4  x86/ima: use EFI GetVariable only when available

elapsed time: 2497m

configs tested: 281
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-h001-20200125
x86_64               randconfig-h002-20200125
x86_64               randconfig-h003-20200125
i386                 randconfig-h001-20200125
i386                 randconfig-h002-20200125
i386                 randconfig-h003-20200125
x86_64               randconfig-f001-20200125
x86_64               randconfig-f002-20200125
x86_64               randconfig-f003-20200125
i386                 randconfig-f001-20200125
i386                 randconfig-f002-20200125
i386                 randconfig-f003-20200125
arc                  randconfig-a001-20200125
arm                  randconfig-a001-20200125
arm64                randconfig-a001-20200125
ia64                 randconfig-a001-20200125
powerpc              randconfig-a001-20200125
sparc                randconfig-a001-20200125
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
x86_64               randconfig-g001-20200126
x86_64               randconfig-g002-20200126
x86_64               randconfig-g003-20200126
i386                 randconfig-g001-20200126
i386                 randconfig-g002-20200126
i386                 randconfig-g003-20200126
x86_64               randconfig-h001-20200126
x86_64               randconfig-h002-20200126
x86_64               randconfig-h003-20200126
i386                 randconfig-h001-20200126
i386                 randconfig-h002-20200126
i386                 randconfig-h003-20200126
x86_64               randconfig-c001-20200126
x86_64               randconfig-c002-20200126
x86_64               randconfig-c003-20200126
i386                 randconfig-c001-20200126
i386                 randconfig-c002-20200126
i386                 randconfig-c003-20200126
alpha                randconfig-a001-20200125
m68k                 randconfig-a001-20200125
mips                 randconfig-a001-20200125
nds32                randconfig-a001-20200125
parisc               randconfig-a001-20200125
riscv                randconfig-a001-20200125
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
x86_64               randconfig-b001-20200125
x86_64               randconfig-b002-20200125
x86_64               randconfig-b003-20200125
i386                 randconfig-b001-20200125
i386                 randconfig-b002-20200125
i386                 randconfig-b003-20200125
arm                              allmodconfig
arm64                            allmodconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
csky                 randconfig-a001-20200126
openrisc             randconfig-a001-20200126
s390                 randconfig-a001-20200126
sh                   randconfig-a001-20200126
xtensa               randconfig-a001-20200126
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
x86_64               randconfig-e001-20200125
x86_64               randconfig-e002-20200125
x86_64               randconfig-e003-20200125
i386                 randconfig-e001-20200125
i386                 randconfig-e002-20200125
i386                 randconfig-e003-20200125
x86_64               randconfig-b001-20200126
x86_64               randconfig-b002-20200126
x86_64               randconfig-b003-20200126
i386                 randconfig-b001-20200126
i386                 randconfig-b002-20200126
i386                 randconfig-b003-20200126
alpha                randconfig-a001-20200126
m68k                 randconfig-a001-20200126
mips                 randconfig-a001-20200126
nds32                randconfig-a001-20200126
parisc               randconfig-a001-20200126
riscv                randconfig-a001-20200126
csky                 randconfig-a001-20200125
openrisc             randconfig-a001-20200125
s390                 randconfig-a001-20200125
xtensa               randconfig-a001-20200125
x86_64               randconfig-a001-20200126
x86_64               randconfig-a002-20200126
x86_64               randconfig-a003-20200126
i386                 randconfig-a001-20200126
i386                 randconfig-a002-20200126
i386                 randconfig-a003-20200126
x86_64               randconfig-c001-20200125
x86_64               randconfig-c002-20200125
x86_64               randconfig-c003-20200125
i386                 randconfig-c001-20200125
i386                 randconfig-c002-20200125
i386                 randconfig-c003-20200125
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
parisc                            allyesonfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
x86_64               randconfig-g001-20200125
x86_64               randconfig-g002-20200125
x86_64               randconfig-g003-20200125
i386                 randconfig-g001-20200125
i386                 randconfig-g002-20200125
i386                 randconfig-g003-20200125
x86_64               randconfig-d001-20200125
x86_64               randconfig-d002-20200125
x86_64               randconfig-d003-20200125
i386                 randconfig-d001-20200125
i386                 randconfig-d002-20200125
i386                 randconfig-d003-20200125
c6x                  randconfig-a001-20200126
h8300                randconfig-a001-20200126
microblaze           randconfig-a001-20200126
nios2                randconfig-a001-20200126
sparc64              randconfig-a001-20200126
arc                  randconfig-a001-20200126
arm                  randconfig-a001-20200126
arm64                randconfig-a001-20200126
ia64                 randconfig-a001-20200126
powerpc              randconfig-a001-20200126
sparc                randconfig-a001-20200126
arc                  randconfig-a001-20200124
arm                  randconfig-a001-20200124
arm64                randconfig-a001-20200124
ia64                 randconfig-a001-20200124
powerpc              randconfig-a001-20200124
sparc                randconfig-a001-20200124
x86_64               randconfig-a001-20200125
x86_64               randconfig-a002-20200125
x86_64               randconfig-a003-20200125
i386                 randconfig-a001-20200125
i386                 randconfig-a002-20200125
i386                 randconfig-a003-20200125
x86_64               randconfig-e001-20200126
x86_64               randconfig-e002-20200126
x86_64               randconfig-e003-20200126
i386                 randconfig-e001-20200126
i386                 randconfig-e002-20200126
i386                 randconfig-e003-20200126
c6x                  randconfig-a001-20200124
h8300                randconfig-a001-20200124
microblaze           randconfig-a001-20200124
nios2                randconfig-a001-20200124
sparc64              randconfig-a001-20200124
csky                 randconfig-a001-20200124
openrisc             randconfig-a001-20200124
s390                 randconfig-a001-20200124
sh                   randconfig-a001-20200124
xtensa               randconfig-a001-20200124
x86_64               randconfig-f001-20200126
x86_64               randconfig-f002-20200126
x86_64               randconfig-f003-20200126
i386                 randconfig-f001-20200126
i386                 randconfig-f002-20200126
i386                 randconfig-f003-20200126
c6x                  randconfig-a001-20200125
h8300                randconfig-a001-20200125
microblaze           randconfig-a001-20200125
nios2                randconfig-a001-20200125
sparc64              randconfig-a001-20200125
x86_64               randconfig-a001-20200124
x86_64               randconfig-a002-20200124
x86_64               randconfig-a003-20200124
i386                 randconfig-a001-20200124
i386                 randconfig-a002-20200124
i386                 randconfig-a003-20200124
x86_64               randconfig-b001-20200124
x86_64               randconfig-b002-20200124
x86_64               randconfig-b003-20200124
i386                 randconfig-b001-20200124
i386                 randconfig-b002-20200124
i386                 randconfig-b003-20200124
x86_64               randconfig-g001-20200124
x86_64               randconfig-g002-20200124
x86_64               randconfig-g003-20200124
i386                 randconfig-g001-20200124
i386                 randconfig-g002-20200124
i386                 randconfig-g003-20200124
sh                   randconfig-a001-20200125
x86_64               randconfig-d001-20200126
x86_64               randconfig-d002-20200126
x86_64               randconfig-d003-20200126
i386                 randconfig-d001-20200126
i386                 randconfig-d002-20200126
i386                 randconfig-d003-20200126
x86_64               randconfig-d001-20200124
x86_64               randconfig-d002-20200124
x86_64               randconfig-d003-20200124
i386                 randconfig-d001-20200124
i386                 randconfig-d002-20200124
i386                 randconfig-d003-20200124
alpha                randconfig-a001-20200124
m68k                 randconfig-a001-20200124
mips                 randconfig-a001-20200124
nds32                randconfig-a001-20200124
parisc               randconfig-a001-20200124
riscv                randconfig-a001-20200124

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
