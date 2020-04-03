Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C471E19E13D
	for <lists+linux-efi@lfdr.de>; Sat,  4 Apr 2020 01:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgDCXCS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Apr 2020 19:02:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:63296 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgDCXCS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Apr 2020 19:02:18 -0400
IronPort-SDR: IRKUKsgjqXxEohNXW9TWIMtwOqSIe7z77MYayIbsQ5gILawzvIAioEywIOKX3SqZJhWZcdcpNl
 e3hAX+Lp9ADg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 16:02:18 -0700
IronPort-SDR: 7X2FdEeSHnZud7U2di3W2CIpbLySTT+WfbNcqcpADFSzU7W42GaDPZkVI7HQlMDErZLgI2Bi44
 RLmTPlFWod2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,341,1580803200"; 
   d="scan'208";a="241248159"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Apr 2020 16:02:15 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKVK8-0007gr-OX; Sat, 04 Apr 2020 07:02:04 +0800
Date:   Sat, 04 Apr 2020 07:01:06 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 33da38529f13f938a73107aa2dc7c3b4e786967a
Message-ID: <5e87c032.59Gf9H9dKvGGOkeb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: 33da38529f13f938a73107aa2dc7c3b4e786967a  efi/libstub/x86: remove redundant assignment to pointer hdr

elapsed time: 481m

configs tested: 135
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
i386                                defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
m68k                           sun3_defconfig
sh                            titan_defconfig
powerpc                           allnoconfig
xtensa                       common_defconfig
ia64                             alldefconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                          iss_defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200403
x86_64               randconfig-a002-20200403
x86_64               randconfig-a003-20200403
i386                 randconfig-a001-20200403
i386                 randconfig-a002-20200403
i386                 randconfig-a003-20200403
nds32                randconfig-a001-20200403
m68k                 randconfig-a001-20200403
alpha                randconfig-a001-20200403
parisc               randconfig-a001-20200403
riscv                randconfig-a001-20200403
sparc64              randconfig-a001-20200403
h8300                randconfig-a001-20200403
nios2                randconfig-a001-20200403
microblaze           randconfig-a001-20200403
c6x                  randconfig-a001-20200403
s390                 randconfig-a001-20200403
xtensa               randconfig-a001-20200403
csky                 randconfig-a001-20200403
openrisc             randconfig-a001-20200403
sh                   randconfig-a001-20200403
x86_64               randconfig-e001-20200403
x86_64               randconfig-e002-20200403
x86_64               randconfig-e003-20200403
i386                 randconfig-e001-20200403
i386                 randconfig-e002-20200403
i386                 randconfig-e003-20200403
x86_64               randconfig-f001-20200403
x86_64               randconfig-f002-20200403
x86_64               randconfig-f003-20200403
i386                 randconfig-f001-20200403
i386                 randconfig-f002-20200403
i386                 randconfig-f003-20200403
x86_64               randconfig-g001-20200403
x86_64               randconfig-g002-20200403
x86_64               randconfig-g003-20200403
i386                 randconfig-g001-20200403
i386                 randconfig-g002-20200403
i386                 randconfig-g003-20200403
arm64                randconfig-a001-20200403
sparc                randconfig-a001-20200403
ia64                 randconfig-a001-20200403
arc                  randconfig-a001-20200403
arm                  randconfig-a001-20200403
powerpc              randconfig-a001-20200403
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
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
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
