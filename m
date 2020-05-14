Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3339C1D38A7
	for <lists+linux-efi@lfdr.de>; Thu, 14 May 2020 19:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgENRvo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 May 2020 13:51:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:44696 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgENRvn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 May 2020 13:51:43 -0400
IronPort-SDR: g1WL7XOnWO4nVpc+NqqwrTyfOWCK5kL71ZL44Q7EkA8Ojy2/mvWkUCyDw8dIShqdxKcNST73oC
 PSel8p4Rrozg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 10:51:43 -0700
IronPort-SDR: LaspyfbQJ2i7Hij3GU273Odd82bcODNGHM9mEZR5ldOTfwCuW98Fa9RYKLKonRhyTFv/7n581o
 1zNrOHZu0xCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="266325763"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 May 2020 10:51:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZI1F-0000Mj-2t; Fri, 15 May 2020 01:51:41 +0800
Date:   Fri, 15 May 2020 01:50:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 6d18c58caf5b45ee8fb0cd90e4e109605ad7d5c4
Message-ID: <5ebd84f6.eNc1RjPXl/o3/fCc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: 6d18c58caf5b45ee8fb0cd90e4e109605ad7d5c4  tpm: check event log version before reading final events

elapsed time: 483m

configs tested: 151
configs skipped: 10

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
nios2                               defconfig
arc                 nsimosci_hs_smp_defconfig
mips                          malta_defconfig
i386                                defconfig
arm                          exynos_defconfig
powerpc                      pmac32_defconfig
powerpc                     mpc5200_defconfig
arm                            qcom_defconfig
sh                               alldefconfig
arm                       aspeed_g5_defconfig
arm                        vexpress_defconfig
mips                         rt305x_defconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
powerpc                       holly_defconfig
arm                        oxnas_v6_defconfig
powerpc                           allnoconfig
sh                          sdk7780_defconfig
riscv                            alldefconfig
sh                             espt_defconfig
m68k                         amcore_defconfig
sh                          polaris_defconfig
arc                     haps_hs_smp_defconfig
mips                           jazz_defconfig
ia64                              allnoconfig
powerpc                          g5_defconfig
arm                  colibri_pxa300_defconfig
m68k                            q40_defconfig
ia64                        generic_defconfig
arm                        magician_defconfig
arm                          imote2_defconfig
s390                       zfcpdump_defconfig
powerpc                       maple_defconfig
sh                           se7722_defconfig
sh                          r7785rp_defconfig
h8300                            alldefconfig
arc                          axs101_defconfig
sh                            titan_defconfig
s390                                defconfig
ia64                             allmodconfig
sh                 kfr2r09-romimage_defconfig
c6x                        evmc6678_defconfig
sh                            shmin_defconfig
arm                        neponset_defconfig
sh                         microdev_defconfig
x86_64                              defconfig
arm                         s3c2410_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
sh                        sh7763rdp_defconfig
arm                             ezx_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         cobalt_defconfig
ia64                            zx1_defconfig
sh                         ecovec24_defconfig
mips                   sb1250_swarm_defconfig
mips                      fuloong2e_defconfig
m68k                          atari_defconfig
m68k                          sun3x_defconfig
mips                        jmr3927_defconfig
arm                        cerfcube_defconfig
ia64                         bigsur_defconfig
sh                          rsk7264_defconfig
m68k                        m5407c3_defconfig
sh                ecovec24-romimage_defconfig
riscv                    nommu_virt_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                              debian-10.3
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
mips                             allyesconfig
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
x86_64               randconfig-a012-20200514
x86_64               randconfig-a016-20200514
x86_64               randconfig-a015-20200514
x86_64               randconfig-a013-20200514
x86_64               randconfig-a014-20200514
x86_64               randconfig-a011-20200514
i386                 randconfig-a012-20200514
i386                 randconfig-a016-20200514
i386                 randconfig-a014-20200514
i386                 randconfig-a011-20200514
i386                 randconfig-a013-20200514
i386                 randconfig-a015-20200514
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
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
