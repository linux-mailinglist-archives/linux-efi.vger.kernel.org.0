Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD96249797A
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jan 2022 08:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiAXHcV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Jan 2022 02:32:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:30617 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235991AbiAXHcV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 24 Jan 2022 02:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643009541; x=1674545541;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8zm3SW2rNX3GaDZEy+jIF17tUJ0Dtex3atv0aNW+LSA=;
  b=jd0iOXVi7oGTlJcWObUf8UkONidEVxJkA9wUs7ZVZo6tOj3536iFHQR/
   As/zf+yJHW1gbhOENdhczmLD8Ochf+S2tNncqg/dLhQIOOwX+kPrYBWYn
   qLGykPSbAEOTWCWVO8BJuM3hls8Bd51YWAThoOTZEKHLII+O1fuZlb4+V
   Oc4YCiO2fZVeRjUWBy+59mWRIV3U4acoRFETdP8iBgNwgQHLYnU33GfPO
   DPlfudmNfkcZpXiUpyy+mGOIVbKJgZaqeggjRRrdKlREMZRrMNsUIAaum
   yP7Yua5X8N3pef7Hvl5flg9fL9+qKbMoFFG8TdpXgowAKaaZrdHOziQLW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226658841"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226658841"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 23:32:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627393960"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Jan 2022 23:32:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBtpq-000Hro-Jj; Mon, 24 Jan 2022 07:32:18 +0000
Date:   Mon, 24 Jan 2022 15:31:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 f5390cd0b43c2e54c7cf5506c7da4a37c5cef746
Message-ID: <61ee55cd.qOOCdsVTEJEBL5EQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: f5390cd0b43c2e54c7cf5506c7da4a37c5cef746  efi: runtime: avoid EFIv2 runtime services on Apple x86 machines

elapsed time: 1279m

configs tested: 221
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
arc                 nsimosci_hs_smp_defconfig
arm                       imx_v6_v7_defconfig
xtensa                       common_defconfig
m68k                          multi_defconfig
mips                     decstation_defconfig
powerpc                     taishan_defconfig
powerpc                     mpc83xx_defconfig
sh                          r7780mp_defconfig
m68k                        m5407c3_defconfig
sh                         apsh4a3a_defconfig
arm                        cerfcube_defconfig
sh                           se7343_defconfig
sh                          urquell_defconfig
arm                       aspeed_g5_defconfig
powerpc64                        alldefconfig
openrisc                 simple_smp_defconfig
h8300                       h8s-sim_defconfig
arc                        vdk_hs38_defconfig
powerpc                      bamboo_defconfig
mips                        bcm47xx_defconfig
sh                          landisk_defconfig
powerpc                       eiger_defconfig
parisc                              defconfig
sh                           se7750_defconfig
powerpc                      cm5200_defconfig
sparc64                          alldefconfig
mips                         rt305x_defconfig
sh                            titan_defconfig
powerpc                      ppc6xx_defconfig
mips                        vocore2_defconfig
arm                         cm_x300_defconfig
powerpc                      pasemi_defconfig
arm                          badge4_defconfig
sh                          rsk7269_defconfig
arm                         vf610m4_defconfig
sh                            shmin_defconfig
parisc                           alldefconfig
powerpc                 mpc85xx_cds_defconfig
s390                          debug_defconfig
nios2                            alldefconfig
xtensa                           allyesconfig
mips                     loongson1b_defconfig
xtensa                generic_kc705_defconfig
mips                         tb0226_defconfig
sh                  sh7785lcr_32bit_defconfig
nds32                            alldefconfig
xtensa                  audio_kc705_defconfig
powerpc                      ppc40x_defconfig
sh                           se7619_defconfig
sh                           se7705_defconfig
um                             i386_defconfig
powerpc                     tqm8548_defconfig
mips                           ci20_defconfig
i386                             alldefconfig
sh                           se7780_defconfig
sh                           se7724_defconfig
arm                            lart_defconfig
arm                       multi_v4t_defconfig
sh                             shx3_defconfig
sh                         ap325rxa_defconfig
arc                         haps_hs_defconfig
h8300                            alldefconfig
sparc64                             defconfig
powerpc                   currituck_defconfig
h8300                    h8300h-sim_defconfig
sh                        edosk7705_defconfig
arm                       omap2plus_defconfig
powerpc                     rainier_defconfig
h8300                               defconfig
ia64                             alldefconfig
arm                      integrator_defconfig
arm                        clps711x_defconfig
powerpc                      ep88xc_defconfig
ia64                      gensparse_defconfig
arc                          axs103_defconfig
sh                          sdk7780_defconfig
arm                         lubbock_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                           u8500_defconfig
arm                           h5000_defconfig
arm                        oxnas_v6_defconfig
xtensa                  cadence_csp_defconfig
arm                        shmobile_defconfig
powerpc                     sequoia_defconfig
sh                            migor_defconfig
arm                  randconfig-c002-20220123
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220123
arc                  randconfig-r043-20220123
s390                 randconfig-r044-20220123
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220123
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
riscv                randconfig-c006-20220123
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220123
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220123
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc                     tqm5200_defconfig
arm                          imote2_defconfig
powerpc                       ebony_defconfig
mips                       rbtx49xx_defconfig
arm                        spear3xx_defconfig
mips                        qi_lb60_defconfig
mips                        bcm63xx_defconfig
powerpc                      obs600_defconfig
arm                          collie_defconfig
mips                   sb1250_swarm_defconfig
powerpc                   lite5200b_defconfig
arm                           sama7_defconfig
powerpc                    gamecube_defconfig
powerpc                      acadia_defconfig
powerpc                          allmodconfig
mips                            e55_defconfig
powerpc                     mpc512x_defconfig
mips                           ip22_defconfig
arm                         bcm2835_defconfig
riscv                          rv32_defconfig
powerpc                          g5_defconfig
arm                       versatile_defconfig
arm                        magician_defconfig
powerpc                  mpc885_ads_defconfig
mips                     cu1000-neo_defconfig
arm                         lpc32xx_defconfig
arm                        multi_v5_defconfig
arm                          ixp4xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
hexagon              randconfig-r045-20220123
hexagon              randconfig-r041-20220123

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
