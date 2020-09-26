Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6453D279CCE
	for <lists+linux-efi@lfdr.de>; Sun, 27 Sep 2020 00:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIZWuH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Sep 2020 18:50:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:53397 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgIZWuH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 26 Sep 2020 18:50:07 -0400
IronPort-SDR: QZUZiohb1DivzQMktM6gKAd8xi1K3O8oxDGsvcZE1CWog+GNNgv58K/iWECGzZ5bUNAqLWMCOl
 JVrMm1ZzyQUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="149578491"
X-IronPort-AV: E=Sophos;i="5.77,307,1596524400"; 
   d="scan'208";a="149578491"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 15:49:59 -0700
IronPort-SDR: Z+JkFqhIe1an+sDv62FqQGsLrJlT/oA94M4++sVkU+QavurxkXcktM0cMM/1A5330YJPspqSpE
 G89Oem4j4Odg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,307,1596524400"; 
   d="scan'208";a="456338192"
Received: from lkp-server01.sh.intel.com (HELO 2dda29302fe3) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Sep 2020 15:49:57 -0700
Received: from kbuild by 2dda29302fe3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kMJ0v-0000bc-6m; Sat, 26 Sep 2020 22:49:57 +0000
Date:   Sun, 27 Sep 2020 06:49:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 cd26e76192cb416432d3b2bad33034055bbbd3b5
Message-ID: <5f6fc57d.1FhbIHFlRmRxk1HJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: cd26e76192cb416432d3b2bad33034055bbbd3b5  efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure

elapsed time: 720m

configs tested: 212
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                      axs103_smp_defconfig
arc                            hsdk_defconfig
arm                        multi_v5_defconfig
arm                          ixp4xx_defconfig
mips                      maltaaprp_defconfig
nds32                            alldefconfig
powerpc                       maple_defconfig
ia64                          tiger_defconfig
mips                        jmr3927_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         hackkit_defconfig
powerpc                         wii_defconfig
sh                           se7619_defconfig
powerpc                     kmeter1_defconfig
powerpc                      pcm030_defconfig
powerpc                       holly_defconfig
mips                       rbtx49xx_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                       imx_v4_v5_defconfig
openrisc                         alldefconfig
sh                           se7724_defconfig
powerpc                      cm5200_defconfig
sh                         ecovec24_defconfig
powerpc                           allnoconfig
powerpc                         ps3_defconfig
powerpc                     akebono_defconfig
powerpc                  mpc866_ads_defconfig
arc                        vdk_hs38_defconfig
mips                        nlm_xlp_defconfig
sh                          rsk7264_defconfig
sh                          sdk7786_defconfig
mips                    maltaup_xpa_defconfig
arm                         lpc32xx_defconfig
powerpc                     tqm8548_defconfig
sh                          landisk_defconfig
sh                            titan_defconfig
xtensa                    smp_lx200_defconfig
arm                       versatile_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7780_defconfig
mips                           ip28_defconfig
m68k                        m5407c3_defconfig
arm                              zx_defconfig
powerpc                          g5_defconfig
csky                             alldefconfig
microblaze                    nommu_defconfig
arm                         at91_dt_defconfig
m68k                        m5307c3_defconfig
mips                      bmips_stb_defconfig
m68k                       m5275evb_defconfig
mips                            gpr_defconfig
powerpc                        icon_defconfig
mips                         tb0287_defconfig
mips                         db1xxx_defconfig
arm                            dove_defconfig
arm                          pxa3xx_defconfig
arm                            qcom_defconfig
arm                           corgi_defconfig
arm                      tct_hammer_defconfig
powerpc                     rainier_defconfig
arm                        spear6xx_defconfig
mips                         tb0226_defconfig
sh                            hp6xx_defconfig
powerpc                  mpc885_ads_defconfig
arm                         lpc18xx_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                          pcm027_defconfig
arm                       aspeed_g4_defconfig
csky                                defconfig
powerpc                     ksi8560_defconfig
arm                            mps2_defconfig
um                            kunit_defconfig
sh                          urquell_defconfig
powerpc                 mpc8540_ads_defconfig
riscv                             allnoconfig
powerpc                     kilauea_defconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
arm                          tango4_defconfig
mips                          ath79_defconfig
openrisc                    or1ksim_defconfig
arm                     davinci_all_defconfig
ia64                            zx1_defconfig
powerpc                        cell_defconfig
arc                          axs103_defconfig
powerpc                      ep88xc_defconfig
m68k                          amiga_defconfig
arm                             rpc_defconfig
arm                             ezx_defconfig
m68k                             allyesconfig
sh                          rsk7269_defconfig
powerpc                      acadia_defconfig
sh                           se7721_defconfig
powerpc                    socrates_defconfig
arm                         vf610m4_defconfig
alpha                            allyesconfig
arm                         bcm2835_defconfig
powerpc               mpc834x_itxgp_defconfig
c6x                              allyesconfig
riscv                          rv32_defconfig
nds32                               defconfig
arc                    vdk_hs38_smp_defconfig
h8300                               defconfig
arm                     eseries_pxa_defconfig
c6x                        evmc6678_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm8540_defconfig
mips                 decstation_r4k_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                               defconfig
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
i386                 randconfig-a002-20200925
i386                 randconfig-a006-20200925
i386                 randconfig-a003-20200925
i386                 randconfig-a004-20200925
i386                 randconfig-a005-20200925
i386                 randconfig-a001-20200925
i386                 randconfig-a002-20200927
i386                 randconfig-a006-20200927
i386                 randconfig-a003-20200927
i386                 randconfig-a004-20200927
i386                 randconfig-a005-20200927
i386                 randconfig-a001-20200927
i386                 randconfig-a002-20200926
i386                 randconfig-a006-20200926
i386                 randconfig-a003-20200926
i386                 randconfig-a004-20200926
i386                 randconfig-a005-20200926
i386                 randconfig-a001-20200926
x86_64               randconfig-a011-20200925
x86_64               randconfig-a013-20200925
x86_64               randconfig-a014-20200925
x86_64               randconfig-a015-20200925
x86_64               randconfig-a012-20200925
x86_64               randconfig-a016-20200925
i386                 randconfig-a012-20200925
i386                 randconfig-a014-20200925
i386                 randconfig-a016-20200925
i386                 randconfig-a013-20200925
i386                 randconfig-a011-20200925
i386                 randconfig-a015-20200925
i386                 randconfig-a012-20200926
i386                 randconfig-a014-20200926
i386                 randconfig-a016-20200926
i386                 randconfig-a013-20200926
i386                 randconfig-a011-20200926
i386                 randconfig-a015-20200926
i386                 randconfig-a012-20200927
i386                 randconfig-a014-20200927
i386                 randconfig-a016-20200927
i386                 randconfig-a013-20200927
i386                 randconfig-a011-20200927
i386                 randconfig-a015-20200927
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200925
x86_64               randconfig-a003-20200925
x86_64               randconfig-a004-20200925
x86_64               randconfig-a002-20200925
x86_64               randconfig-a006-20200925
x86_64               randconfig-a001-20200925
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927
x86_64               randconfig-a011-20200926
x86_64               randconfig-a013-20200926
x86_64               randconfig-a014-20200926
x86_64               randconfig-a015-20200926
x86_64               randconfig-a012-20200926
x86_64               randconfig-a016-20200926

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
