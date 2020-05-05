Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620791C6216
	for <lists+linux-efi@lfdr.de>; Tue,  5 May 2020 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEEUal (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 May 2020 16:30:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:42208 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbgEEUak (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 5 May 2020 16:30:40 -0400
IronPort-SDR: lyWb/MR1+0Yew/c1FQ11kpamoux0rtpN8cYJLtjm/8Oeg4hQK/tXZkFy+o2RyCDCiUlzGTUqww
 LNchqOMMsHJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 13:30:39 -0700
IronPort-SDR: xKV3kN6OPB6Riz55ZuFeDGDm0gyT6eWIx+DWrtAa0RJxyDQ6p+jIHSIEWRF712oYlUhxtSV7U8
 Rj0a5E21ROkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; 
   d="scan'208";a="278000662"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 May 2020 13:30:36 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jW4D7-0003GW-5o; Wed, 06 May 2020 04:30:37 +0800
Date:   Wed, 06 May 2020 04:29:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 0b8d9fc9953fde4ea3eb3191d986ca2d01eb783c
Message-ID: <5eb1ccb7.kL4Es3m3nU0qFxti%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 0b8d9fc9953fde4ea3eb3191d986ca2d01eb783c  efi/libstub: Make efi_printk() input argument const char*

Warning in current branch:

drivers/firmware/efi/libstub/efi-stub-helper.c:35:43: sparse:    expected unsigned short [usertype] *
drivers/firmware/efi/libstub/efi-stub-helper.c:35:43: sparse: sparse: incorrect type in argument 1 (different type sizes)

Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-allyesconfig
    |-- drivers-firmware-efi-libstub-efi-stub-helper.c:sparse:expected-unsigned-short-usertype
    `-- drivers-firmware-efi-libstub-efi-stub-helper.c:sparse:sparse:incorrect-type-in-argument-(different-type-sizes)-expected-unsigned-short-usertype-got-ype

elapsed time: 480m

configs tested: 230
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
xtensa                       common_defconfig
mips                             allmodconfig
s390                             allyesconfig
h8300                       h8s-sim_defconfig
um                           x86_64_defconfig
m68k                           sun3_defconfig
nds32                             allnoconfig
powerpc                          g5_defconfig
powerpc                           allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                        generic_defconfig
ia64                          tiger_defconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
ia64                             alldefconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                       bvme6000_defconfig
m68k                          multi_defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
xtensa                          iss_defconfig
h8300                    h8300h-sim_defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                malta_kvm_guest_defconfig
mips                         tb0287_defconfig
mips                       capcella_defconfig
mips                           ip32_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                          ath79_defconfig
mips                        bcm63xx_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                      chrp32_defconfig
powerpc                             defconfig
powerpc                       holly_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
powerpc                  mpc866_ads_defconfig
powerpc                    amigaone_defconfig
powerpc                    adder875_defconfig
powerpc                     ep8248e_defconfig
powerpc                     mpc512x_defconfig
m68k                 randconfig-a001-20200502
mips                 randconfig-a001-20200502
nds32                randconfig-a001-20200502
alpha                randconfig-a001-20200502
parisc               randconfig-a001-20200502
riscv                randconfig-a001-20200502
m68k                 randconfig-a001-20200505
mips                 randconfig-a001-20200505
nds32                randconfig-a001-20200505
parisc               randconfig-a001-20200505
alpha                randconfig-a001-20200505
riscv                randconfig-a001-20200505
m68k                 randconfig-a001-20200503
mips                 randconfig-a001-20200503
nds32                randconfig-a001-20200503
alpha                randconfig-a001-20200503
parisc               randconfig-a001-20200503
riscv                randconfig-a001-20200503
h8300                randconfig-a001-20200503
nios2                randconfig-a001-20200503
microblaze           randconfig-a001-20200503
c6x                  randconfig-a001-20200503
sparc64              randconfig-a001-20200503
s390                 randconfig-a001-20200505
xtensa               randconfig-a001-20200505
sh                   randconfig-a001-20200505
openrisc             randconfig-a001-20200505
csky                 randconfig-a001-20200505
xtensa               randconfig-a001-20200503
openrisc             randconfig-a001-20200503
csky                 randconfig-a001-20200503
s390                 randconfig-a001-20200430
xtensa               randconfig-a001-20200430
csky                 randconfig-a001-20200430
openrisc             randconfig-a001-20200430
sh                   randconfig-a001-20200430
i386                 randconfig-b003-20200503
x86_64               randconfig-b002-20200503
i386                 randconfig-b001-20200503
x86_64               randconfig-b003-20200503
x86_64               randconfig-b001-20200503
i386                 randconfig-b002-20200503
i386                 randconfig-b003-20200505
x86_64               randconfig-b002-20200505
i386                 randconfig-b001-20200505
x86_64               randconfig-b001-20200505
x86_64               randconfig-b003-20200505
i386                 randconfig-b002-20200505
x86_64               randconfig-a002-20200503
i386                 randconfig-a002-20200503
i386                 randconfig-a003-20200503
i386                 randconfig-a001-20200503
x86_64               randconfig-c002-20200502
i386                 randconfig-c002-20200502
i386                 randconfig-c001-20200502
i386                 randconfig-c003-20200502
x86_64               randconfig-d001-20200505
i386                 randconfig-d003-20200505
i386                 randconfig-d001-20200505
x86_64               randconfig-d003-20200505
x86_64               randconfig-d002-20200505
i386                 randconfig-d002-20200505
i386                 randconfig-e003-20200505
x86_64               randconfig-e002-20200505
x86_64               randconfig-e003-20200505
x86_64               randconfig-e001-20200505
i386                 randconfig-e002-20200505
i386                 randconfig-e001-20200505
x86_64               randconfig-e003-20200503
x86_64               randconfig-e002-20200503
i386                 randconfig-e003-20200503
x86_64               randconfig-e001-20200503
i386                 randconfig-e002-20200503
i386                 randconfig-e001-20200503
i386                 randconfig-f003-20200505
x86_64               randconfig-f001-20200505
x86_64               randconfig-f003-20200505
i386                 randconfig-f001-20200505
i386                 randconfig-f002-20200505
i386                 randconfig-f003-20200503
x86_64               randconfig-f002-20200503
i386                 randconfig-f001-20200503
i386                 randconfig-f002-20200503
x86_64               randconfig-a003-20200505
x86_64               randconfig-a001-20200505
i386                 randconfig-a001-20200505
i386                 randconfig-a003-20200505
i386                 randconfig-a002-20200505
x86_64               randconfig-g003-20200503
i386                 randconfig-g003-20200503
i386                 randconfig-g002-20200503
x86_64               randconfig-g001-20200503
i386                 randconfig-g001-20200503
i386                 randconfig-g003-20200505
i386                 randconfig-g002-20200505
i386                 randconfig-g001-20200505
x86_64               randconfig-g002-20200505
i386                 randconfig-h002-20200505
i386                 randconfig-h001-20200505
i386                 randconfig-h003-20200505
x86_64               randconfig-h003-20200505
x86_64               randconfig-h001-20200505
ia64                 randconfig-a001-20200505
powerpc              randconfig-a001-20200505
arm                  randconfig-a001-20200505
arc                  randconfig-a001-20200505
sparc                randconfig-a001-20200505
ia64                 randconfig-a001-20200503
arm64                randconfig-a001-20200503
arc                  randconfig-a001-20200503
arm                  randconfig-a001-20200503
sparc                randconfig-a001-20200503
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
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
um                             i386_defconfig
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
