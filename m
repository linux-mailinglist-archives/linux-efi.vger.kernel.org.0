Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EEE26BB89
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 06:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgIPEdz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Sep 2020 00:33:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:14632 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgIPEdy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Sep 2020 00:33:54 -0400
IronPort-SDR: iAiR/iIwL/1bjBYjoUq6gajfrlu8s8r4affJjwsZ1ifxWzWvny7RkSHepHpU5ueB5tG2ezk59K
 WjKtWV3n0T9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="159451044"
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="159451044"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 21:33:51 -0700
IronPort-SDR: nuYcLRFI9kx9pGw98v+OOWymH0D5c6SPRciI6aE73EneNdOeRMM2HCHRslfw8LrbA6lFPolfcv
 rIakW3cFvZsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="409419007"
Received: from lkp-server01.sh.intel.com (HELO 96654786cb26) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2020 21:33:50 -0700
Received: from kbuild by 96654786cb26 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kIP8f-0000Qx-HI; Wed, 16 Sep 2020 04:33:49 +0000
Date:   Wed, 16 Sep 2020 12:33:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 46908326c6b801201f1e46f5ed0db6e85bef74ae
Message-ID: <5f61958b.yu/jsTe9gN9xfehQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: 46908326c6b801201f1e46f5ed0db6e85bef74ae  efi: efibc: check for efivars write capability

elapsed time: 723m

configs tested: 173
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         rt305x_defconfig
arm                           corgi_defconfig
sparc64                             defconfig
powerpc                      ppc6xx_defconfig
m68k                            mac_defconfig
sh                             sh03_defconfig
arm                          prima2_defconfig
m68k                        m5272c3_defconfig
arm                          pxa168_defconfig
powerpc                      walnut_defconfig
powerpc                     ppa8548_defconfig
mips                        bcm63xx_defconfig
arm                      integrator_defconfig
arc                     nsimosci_hs_defconfig
sh                          urquell_defconfig
powerpc                     ep8248e_defconfig
arm                         assabet_defconfig
powerpc                     tqm8548_defconfig
sh                            hp6xx_defconfig
arm                           sunxi_defconfig
powerpc                    mvme5100_defconfig
arm                      footbridge_defconfig
arm                         palmz72_defconfig
arm                        vexpress_defconfig
mips                           ci20_defconfig
sh                               j2_defconfig
arm                          ixp4xx_defconfig
xtensa                              defconfig
mips                         cobalt_defconfig
sh                          rsk7264_defconfig
mips                      bmips_stb_defconfig
powerpc                        fsp2_defconfig
arc                             nps_defconfig
arm                            dove_defconfig
sh                     sh7710voipgw_defconfig
arm                         shannon_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                          g5_defconfig
powerpc                  storcenter_defconfig
m68k                           sun3_defconfig
i386                             alldefconfig
powerpc                     tqm5200_defconfig
m68k                        m5407c3_defconfig
mips                     loongson1c_defconfig
powerpc                       holly_defconfig
mips                      maltaaprp_defconfig
arm                         ebsa110_defconfig
arm                          gemini_defconfig
arc                           tb10x_defconfig
powerpc                     tqm8560_defconfig
powerpc                      ppc64e_defconfig
xtensa                          iss_defconfig
sh                           se7619_defconfig
powerpc64                        alldefconfig
powerpc                 mpc836x_mds_defconfig
xtensa                    xip_kc705_defconfig
arm                        spear6xx_defconfig
mips                           jazz_defconfig
powerpc                     rainier_defconfig
arm                         lpc18xx_defconfig
sh                   secureedge5410_defconfig
mips                  decstation_64_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
powerpc                       eiger_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      katmai_defconfig
sh                        apsh4ad0a_defconfig
powerpc                         wii_defconfig
arm                          exynos_defconfig
ia64                         bigsur_defconfig
arm                         bcm2835_defconfig
sh                           se7724_defconfig
mips                         db1xxx_defconfig
arm                             rpc_defconfig
powerpc                        warp_defconfig
sh                      rts7751r2d1_defconfig
arm                        shmobile_defconfig
powerpc                     taishan_defconfig
c6x                        evmc6474_defconfig
powerpc                      makalu_defconfig
mips                malta_kvm_guest_defconfig
sh                           se7751_defconfig
sh                   sh7770_generic_defconfig
ia64                            zx1_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                  iss476-smp_defconfig
mips                         tb0219_defconfig
arm                        mini2440_defconfig
arm                          lpd270_defconfig
mips                   sb1250_swarm_defconfig
mips                        bcm47xx_defconfig
sh                        dreamcast_defconfig
powerpc                     tqm8540_defconfig
powerpc                     kmeter1_defconfig
arm                          simpad_defconfig
mips                         tb0287_defconfig
sh                                  defconfig
powerpc                      ep88xc_defconfig
sh                   sh7724_generic_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200916
x86_64               randconfig-a004-20200916
x86_64               randconfig-a003-20200916
x86_64               randconfig-a002-20200916
x86_64               randconfig-a001-20200916
x86_64               randconfig-a005-20200916
i386                 randconfig-a004-20200916
i386                 randconfig-a006-20200916
i386                 randconfig-a003-20200916
i386                 randconfig-a001-20200916
i386                 randconfig-a002-20200916
i386                 randconfig-a005-20200916
i386                 randconfig-a015-20200916
i386                 randconfig-a014-20200916
i386                 randconfig-a011-20200916
i386                 randconfig-a013-20200916
i386                 randconfig-a016-20200916
i386                 randconfig-a012-20200916
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20200916
x86_64               randconfig-a011-20200916
x86_64               randconfig-a016-20200916
x86_64               randconfig-a012-20200916
x86_64               randconfig-a015-20200916
x86_64               randconfig-a013-20200916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
