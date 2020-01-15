Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAA013BB8E
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2020 09:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAOIzv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jan 2020 03:55:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:26293 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgAOIzv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Jan 2020 03:55:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 00:55:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="219907360"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jan 2020 00:55:49 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ireSr-00031E-BN; Wed, 15 Jan 2020 16:55:49 +0800
Date:   Wed, 15 Jan 2020 16:55:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD INCOMPLETE
 6e4ecdb3931ca2cd14737330966ca70b76bcf29b
Message-ID: <5e1ed38e.tikmDnmw/kC5MX3w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 6e4ecdb3931ca2cd14737330966ca70b76bcf29b  efi: Fix handling of multiple efi_fake_mem= entries

TIMEOUT after 2882m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 7

mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig

configs tested: 128
configs skipped: 0

c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64               randconfig-a001-20200114
x86_64               randconfig-a002-20200114
x86_64               randconfig-a003-20200114
i386                 randconfig-a001-20200114
i386                 randconfig-a002-20200114
i386                 randconfig-a003-20200114
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
x86_64               randconfig-h001-20200115
x86_64               randconfig-h002-20200115
x86_64               randconfig-h003-20200115
i386                 randconfig-h001-20200115
i386                 randconfig-h002-20200115
i386                 randconfig-h003-20200115
arc                  randconfig-a001-20200114
arm                  randconfig-a001-20200114
arm64                randconfig-a001-20200114
ia64                 randconfig-a001-20200114
powerpc              randconfig-a001-20200114
sparc                randconfig-a001-20200114
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-h001-20200114
i386                 randconfig-h002-20200114
i386                 randconfig-h003-20200114
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
csky                 randconfig-a001-20200114
openrisc             randconfig-a001-20200114
s390                 randconfig-a001-20200114
sh                   randconfig-a001-20200114
xtensa               randconfig-a001-20200114
arm                              allmodconfig
arm64                            allmodconfig
c6x                  randconfig-a001-20200114
h8300                randconfig-a001-20200114
microblaze           randconfig-a001-20200114
nios2                randconfig-a001-20200114
sparc64              randconfig-a001-20200114
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
x86_64               randconfig-f001-20200114
x86_64               randconfig-f002-20200114
x86_64               randconfig-f003-20200114
i386                 randconfig-f001-20200114
i386                 randconfig-f002-20200114
i386                 randconfig-f003-20200114
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
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
x86_64               randconfig-b002-20200114
i386                 randconfig-b001-20200114
i386                 randconfig-b002-20200114
i386                 randconfig-b003-20200114
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
