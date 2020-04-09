Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F01A2D70
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 03:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDIBol (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Apr 2020 21:44:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:23906 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgDIBol (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Apr 2020 21:44:41 -0400
IronPort-SDR: GP3X8Gi8iP+cH9ISjG3oxQo9DwKayHBAVCZdRW50s9qmvDQGVe6/16VPpciURyJByNEb2Oi7zA
 59L61dcuV0iA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 18:44:40 -0700
IronPort-SDR: gOnmBvFts9djdwO+fwjBN4ZwF2jOa3LrELVrzFqY+OWUDo5EFdGDU9XQnB0z6EN/wz996cgZNP
 +SaHn55xgDWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,360,1580803200"; 
   d="scan'208";a="242514066"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2020 18:44:38 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jMMFB-000Eiv-Mj; Thu, 09 Apr 2020 09:44:37 +0800
Date:   Thu, 09 Apr 2020 09:43:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 f5356a8c201bf2dfa3783b3894f31f8e96f94624
Message-ID: <5e8e7dd0.hLflH8uMWc9Gqk98%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: f5356a8c201bf2dfa3783b3894f31f8e96f94624  x86/efi: Add a prototype for efi_arch_mem_reserve()

elapsed time: 481m

configs tested: 144
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
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
h8300                    h8300h-sim_defconfig
s390                                defconfig
xtensa                          iss_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
arm64                            allmodconfig
arm                              allmodconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
c6x                  randconfig-a001-20200408
h8300                randconfig-a001-20200408
microblaze           randconfig-a001-20200408
nios2                randconfig-a001-20200408
sparc64              randconfig-a001-20200408
s390                 randconfig-a001-20200408
xtensa               randconfig-a001-20200408
csky                 randconfig-a001-20200408
openrisc             randconfig-a001-20200408
sh                   randconfig-a001-20200408
x86_64               randconfig-b001-20200408
x86_64               randconfig-b002-20200408
x86_64               randconfig-b003-20200408
i386                 randconfig-b001-20200408
i386                 randconfig-b002-20200408
i386                 randconfig-b003-20200408
x86_64               randconfig-c001-20200408
x86_64               randconfig-c002-20200408
x86_64               randconfig-c003-20200408
i386                 randconfig-c001-20200408
i386                 randconfig-c002-20200408
i386                 randconfig-c003-20200408
x86_64               randconfig-d001-20200409
x86_64               randconfig-d002-20200409
x86_64               randconfig-d003-20200409
i386                 randconfig-d001-20200409
i386                 randconfig-d002-20200409
i386                 randconfig-d003-20200409
x86_64               randconfig-e002-20200408
i386                 randconfig-e003-20200408
i386                 randconfig-e001-20200408
x86_64               randconfig-e001-20200408
x86_64               randconfig-e003-20200408
i386                 randconfig-e002-20200408
i386                 randconfig-f001-20200408
i386                 randconfig-f003-20200408
x86_64               randconfig-f003-20200408
x86_64               randconfig-f001-20200408
i386                 randconfig-f002-20200408
i386                 randconfig-h002-20200408
i386                 randconfig-h003-20200408
i386                 randconfig-h001-20200408
x86_64               randconfig-h001-20200408
x86_64               randconfig-h003-20200408
sparc                randconfig-a001-20200408
arm64                randconfig-a001-20200408
ia64                 randconfig-a001-20200408
arc                  randconfig-a001-20200408
arm                  randconfig-a001-20200408
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
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
