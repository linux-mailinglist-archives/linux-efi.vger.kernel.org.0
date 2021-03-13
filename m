Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AD0339C4E
	for <lists+linux-efi@lfdr.de>; Sat, 13 Mar 2021 06:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCMFxy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Mar 2021 00:53:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:3401 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhCMFxr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 13 Mar 2021 00:53:47 -0500
IronPort-SDR: HHHsdE/ZdLNr/rAiXJg0UGiEyzBs2JzxsUzCqk2Sr3CERCSQ6saltKx17KwoQA3en9qF7ndPR8
 NRRi0Y81rjXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="176050996"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="176050996"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 21:53:47 -0800
IronPort-SDR: MqZxZgDv6eNPPmKgA06O9m/1sb5jaYKz5zTvFcx21NEu97mUrrEBYu83khOvtHpcqrORqxMtIe
 0tYPC4i44TIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="432145297"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2021 21:53:45 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKxDd-0001rP-8f; Sat, 13 Mar 2021 05:53:45 +0000
Date:   Sat, 13 Mar 2021 13:53:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS WITH WARNING
 e233b65935c946ba420ba1b5a42f9b5625861da8
Message-ID: <604c5367.7Efg4YC4eDNoTgeW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: e233b65935c946ba420ba1b5a42f9b5625861da8  efi: use explicit const efi_guid_t type for EFI_GUID literals

Warning reports:

https://lore.kernel.org/linux-efi/202103130142.pLqjh2Hg-lkp@intel.com

Warning in current branch:

arch/x86/platform/efi/efi_64.c:163:23: warning: passing argument 1 of 'virt_to_phys' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
arch/x86/platform/efi/efi_64.c:165:25: warning: passing argument 1 of 'slow_virt_to_phys' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- x86_64-allmodconfig
|   |-- arch-x86-platform-efi-efi_64.c:warning:passing-argument-of-slow_virt_to_phys-discards-const-qualifier-from-pointer-target-type
|   `-- arch-x86-platform-efi-efi_64.c:warning:passing-argument-of-virt_to_phys-discards-const-qualifier-from-pointer-target-type
`-- x86_64-allyesconfig
    |-- arch-x86-platform-efi-efi_64.c:warning:passing-argument-of-slow_virt_to_phys-discards-const-qualifier-from-pointer-target-type
    `-- arch-x86-platform-efi-efi_64.c:warning:passing-argument-of-virt_to_phys-discards-const-qualifier-from-pointer-target-type

elapsed time: 726m

configs tested: 129
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     tqm8541_defconfig
m68k                       m5475evb_defconfig
arm                             mxs_defconfig
powerpc64                        alldefconfig
arm                         s3c2410_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
mips                        nlm_xlp_defconfig
mips                   sb1250_swarm_defconfig
arm                             pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     pseries_defconfig
arm                        mini2440_defconfig
arm                        keystone_defconfig
sh                           se7780_defconfig
sh                         ap325rxa_defconfig
powerpc                      pcm030_defconfig
arm                          ep93xx_defconfig
mips                            gpr_defconfig
arm                          pxa168_defconfig
mips                           ip22_defconfig
arc                    vdk_hs38_smp_defconfig
riscv                             allnoconfig
powerpc                 mpc85xx_cds_defconfig
sh                                  defconfig
powerpc64                           defconfig
xtensa                          iss_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
sh                          r7785rp_defconfig
mips                    maltaup_xpa_defconfig
arm                         assabet_defconfig
arm                          ixp4xx_defconfig
powerpc                         ps3_defconfig
arm                         axm55xx_defconfig
arm                          moxart_defconfig
sh                             shx3_defconfig
mips                           gcw0_defconfig
m68k                             alldefconfig
sh                             espt_defconfig
powerpc                       eiger_defconfig
arm                          simpad_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7705_defconfig
sh                 kfr2r09-romimage_defconfig
arm                       cns3420vb_defconfig
powerpc                 mpc836x_mds_defconfig
nios2                         10m50_defconfig
sparc                       sparc64_defconfig
arc                           tb10x_defconfig
mips                         tb0226_defconfig
mips                     cu1830-neo_defconfig
sh                        edosk7705_defconfig
riscv                            allyesconfig
m68k                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210312
i386                 randconfig-a005-20210312
i386                 randconfig-a002-20210312
i386                 randconfig-a003-20210312
i386                 randconfig-a004-20210312
i386                 randconfig-a006-20210312
x86_64               randconfig-a011-20210312
x86_64               randconfig-a016-20210312
x86_64               randconfig-a013-20210312
x86_64               randconfig-a014-20210312
x86_64               randconfig-a015-20210312
x86_64               randconfig-a012-20210312
i386                 randconfig-a013-20210312
i386                 randconfig-a016-20210312
i386                 randconfig-a011-20210312
i386                 randconfig-a015-20210312
i386                 randconfig-a014-20210312
i386                 randconfig-a012-20210312
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210312
x86_64               randconfig-a001-20210312
x86_64               randconfig-a005-20210312
x86_64               randconfig-a003-20210312
x86_64               randconfig-a002-20210312
x86_64               randconfig-a004-20210312

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
