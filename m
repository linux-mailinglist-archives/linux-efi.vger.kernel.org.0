Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF54C9B6E
	for <lists+linux-efi@lfdr.de>; Wed,  2 Mar 2022 03:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbiCBCvO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Mar 2022 21:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbiCBCvO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Mar 2022 21:51:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95C2AB475
        for <linux-efi@vger.kernel.org>; Tue,  1 Mar 2022 18:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646189432; x=1677725432;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eoHfgChYosAG3lrcJTD3TkkcHiPENUi6fz2udL4gAtM=;
  b=Ydf72jSni6rXd9FgWuU5pjwFFZrKuEttYSb603ioaFF2dCWVUpvrgRKC
   6nV8GUsL/1anRMIiC+c8IQ2HxyTTOhqvo2yPDxwlOJW56UjBrHYugFrDb
   Rb57GFPI20ZrUpInflZ1+6sfJkgsoh42gH45+x3FKipcFnUqPI4AmZrcl
   Z8H/U/Fh6/0KWlbSy4/3IuMAYueNGUNX2EcBjjbnATK8xM/nb4DKPCXbo
   pFrFAT6RwgyzsJReNxTU/3jpYhCoyoYJMsikkWDI1EaaeZ2xXHxY1aRwJ
   HO+4nHz5nDi8kWIVF6ECdvVJforHM4kIbZos4BV/O0Bd/6dB/HfI9inJY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233910642"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233910642"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:50:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="508042917"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2022 18:50:28 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPF4N-0000Uw-Ro; Wed, 02 Mar 2022 02:50:27 +0000
Date:   Wed, 02 Mar 2022 09:35:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 9feaf8b387ee0ece9c1d7add308776b502a35d0c
Message-ID: <621ec9e4.BidU9ih5nbQTv8jA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 9feaf8b387ee0ece9c1d7add308776b502a35d0c  efi: fix return value of __setup handlers

elapsed time: 1018m

configs tested: 172
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arc                        vdk_hs38_defconfig
m68k                       m5249evb_defconfig
powerpc                      pasemi_defconfig
sh                          kfr2r09_defconfig
mips                     loongson1b_defconfig
powerpc                 mpc837x_mds_defconfig
sh                     magicpanelr2_defconfig
h8300                       h8s-sim_defconfig
nios2                         10m50_defconfig
mips                           jazz_defconfig
nds32                               defconfig
powerpc                     tqm8548_defconfig
openrisc                 simple_smp_defconfig
sh                        sh7757lcr_defconfig
powerpc                         ps3_defconfig
arm                       multi_v4t_defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
m68k                       m5475evb_defconfig
sparc                       sparc64_defconfig
ia64                             alldefconfig
arm                          iop32x_defconfig
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        vocore2_defconfig
powerpc                      tqm8xx_defconfig
arm                         nhk8815_defconfig
mips                  maltasmvp_eva_defconfig
m68k                         amcore_defconfig
parisc64                         alldefconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
arm                        oxnas_v6_defconfig
arc                           tb10x_defconfig
arm                           h5000_defconfig
xtensa                       common_defconfig
powerpc                     redwood_defconfig
parisc                generic-64bit_defconfig
mips                          rb532_defconfig
um                               alldefconfig
sh                        edosk7705_defconfig
sh                          polaris_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
mips                            ar7_defconfig
powerpc                      arches_defconfig
powerpc                        warp_defconfig
mips                           ip32_defconfig
sh                            hp6xx_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7724_defconfig
h8300                            alldefconfig
arm                            zeus_defconfig
arm                         assabet_defconfig
sh                           se7343_defconfig
mips                  decstation_64_defconfig
sh                            migor_defconfig
m68k                        stmark2_defconfig
mips                       bmips_be_defconfig
arm                       imx_v6_v7_defconfig
microblaze                          defconfig
m68k                          multi_defconfig
riscv                    nommu_k210_defconfig
ia64                        generic_defconfig
csky                             alldefconfig
sh                          lboxre2_defconfig
arm                         axm55xx_defconfig
sh                         ecovec24_defconfig
sh                           se7780_defconfig
arm                  randconfig-c002-20220301
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220301
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220301
riscv                randconfig-c006-20220301
i386                          randconfig-c001
arm                  randconfig-c002-20220301
mips                 randconfig-c004-20220301
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                                 defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     mpc5200_defconfig
arm                          imote2_defconfig
powerpc                      walnut_defconfig
riscv                    nommu_virt_defconfig
arm                         bcm2835_defconfig
arm                         palmz72_defconfig
arm                         orion5x_defconfig
arm                        neponset_defconfig
powerpc                        fsp2_defconfig
arm                           spitz_defconfig
arm                        spear3xx_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
riscv                randconfig-r042-20220301
s390                 randconfig-r044-20220301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
