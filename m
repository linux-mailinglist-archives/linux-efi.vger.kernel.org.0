Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA46029A6C0
	for <lists+linux-efi@lfdr.de>; Tue, 27 Oct 2020 09:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509040AbgJ0Ikd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Oct 2020 04:40:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:54043 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509124AbgJ0Ikc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 27 Oct 2020 04:40:32 -0400
IronPort-SDR: 2LlonA7TWvmya2lNcX/3D8PBuw1J7ez6PmlYSRfVe+6nsB2Y/UENcSAcJsi7riw2lKruqyQrhn
 GoFivzWBuikw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155825060"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="155825060"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 01:40:25 -0700
IronPort-SDR: XF9qUsb1YNZQwaVR1Z+eWFi7cRAMOMDua0USzmYbKpkiQWDHm/D8+E0hMyWSUzbwU/2xEIdmJy
 S3g9xNSAnrjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="424351236"
Received: from lkp-server01.sh.intel.com (HELO ef28dff175aa) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Oct 2020 01:40:23 -0700
Received: from kbuild by ef28dff175aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXKWl-0000AI-7Z; Tue, 27 Oct 2020 08:40:23 +0000
Date:   Tue, 27 Oct 2020 16:39:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 fe5186cf12e30facfe261e9be6c7904a170bd822
Message-ID: <5f97dcd0.laXi0VuiBLKprcZp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: fe5186cf12e30facfe261e9be6c7904a170bd822  efivarfs: fix memory leak in efivarfs_create()

elapsed time: 1325m

configs tested: 195
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            zeus_defconfig
arm                         ebsa110_defconfig
arm                        shmobile_defconfig
sparc                            allyesconfig
powerpc                     sequoia_defconfig
arm                          moxart_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                        fsp2_defconfig
arm                            qcom_defconfig
m68k                        mvme16x_defconfig
arm                        trizeps4_defconfig
sh                          landisk_defconfig
powerpc                      obs600_defconfig
mips                     decstation_defconfig
arm                           sama5_defconfig
m68k                       m5249evb_defconfig
mips                    maltaup_xpa_defconfig
sh                             sh03_defconfig
ia64                             alldefconfig
arm                           sunxi_defconfig
powerpc                        icon_defconfig
sh                     magicpanelr2_defconfig
mips                         tb0219_defconfig
arm                             mxs_defconfig
powerpc                       holly_defconfig
ia64                             allyesconfig
arm                          pxa910_defconfig
sh                           se7705_defconfig
arm                        spear6xx_defconfig
arm                              zx_defconfig
mips                          malta_defconfig
alpha                               defconfig
arm                         mv78xx0_defconfig
sh                   secureedge5410_defconfig
mips                       rbtx49xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                generic_kc705_defconfig
arm                           h3600_defconfig
arm                         s3c2410_defconfig
mips                           gcw0_defconfig
m68k                             alldefconfig
mips                          rb532_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                           sun3_defconfig
c6x                        evmc6474_defconfig
sh                          rsk7269_defconfig
mips                      pic32mzda_defconfig
sh                          rsk7264_defconfig
riscv                            allyesconfig
powerpc                     sbc8548_defconfig
arm                          exynos_defconfig
mips                         tb0287_defconfig
mips                         db1xxx_defconfig
mips                       bmips_be_defconfig
h8300                    h8300h-sim_defconfig
xtensa                         virt_defconfig
powerpc                 linkstation_defconfig
mips                      bmips_stb_defconfig
parisc                generic-32bit_defconfig
arm                      integrator_defconfig
arm                          simpad_defconfig
arm                        realview_defconfig
riscv                    nommu_virt_defconfig
powerpc                      ppc6xx_defconfig
arm                       versatile_defconfig
powerpc                     tqm8540_defconfig
h8300                            alldefconfig
arm                         shannon_defconfig
nds32                               defconfig
arm                         s3c6400_defconfig
arm                         assabet_defconfig
sh                            shmin_defconfig
mips                           ip28_defconfig
c6x                        evmc6678_defconfig
m68k                       m5275evb_defconfig
powerpc                      makalu_defconfig
i386                             alldefconfig
powerpc                      mgcoge_defconfig
arm                            lart_defconfig
mips                     loongson1c_defconfig
arm                        mvebu_v5_defconfig
ia64                         bigsur_defconfig
x86_64                           allyesconfig
powerpc                      walnut_defconfig
c6x                        evmc6472_defconfig
mips                        nlm_xlp_defconfig
arc                        nsimosci_defconfig
sh                           se7780_defconfig
sh                        edosk7760_defconfig
arm                             rpc_defconfig
sh                              ul2_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                          allyesconfig
powerpc                 mpc8313_rdb_defconfig
ia64                        generic_defconfig
m68k                        m5272c3_defconfig
sh                   sh7724_generic_defconfig
powerpc                      pmac32_defconfig
arm                          collie_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       multi_v4t_defconfig
mips                malta_kvm_guest_defconfig
sh                           se7750_defconfig
powerpc                   bluestone_defconfig
powerpc                   lite5200b_defconfig
xtensa                              defconfig
arm                         cm_x300_defconfig
riscv                            alldefconfig
powerpc                     rainier_defconfig
powerpc                     pseries_defconfig
mips                      fuloong2e_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     redwood_defconfig
arc                      axs103_smp_defconfig
ia64                                defconfig
powerpc                      acadia_defconfig
powerpc                     tqm8560_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ppc64_defconfig
arc                     nsimosci_hs_defconfig
arm                           stm32_defconfig
powerpc                    gamecube_defconfig
mips                      pistachio_defconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201026
i386                 randconfig-a015-20201026
i386                 randconfig-a014-20201026
i386                 randconfig-a012-20201026
i386                 randconfig-a013-20201026
i386                 randconfig-a011-20201026
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
