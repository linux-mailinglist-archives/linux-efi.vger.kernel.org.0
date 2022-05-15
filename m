Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EAF5275C3
	for <lists+linux-efi@lfdr.de>; Sun, 15 May 2022 06:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiEOErE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 15 May 2022 00:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbiEOErE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 15 May 2022 00:47:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B522BF8
        for <linux-efi@vger.kernel.org>; Sat, 14 May 2022 21:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652590022; x=1684126022;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=drfAQXbFvXWhLlJYry1HszpTAauD1mypkSVmSYZqXXg=;
  b=n1U4X4y3jr+MJ3qNQsWEuPqKZKtp09Bz+M4tdfzAsFazLxTuwYNeTLW2
   gxGjVztfngt8oVfD4/haaoshLE0QCKrX4SR7GovUtl9lkPBkxl5bKHKl5
   vWyVJ4HWpt3dUYPki0rJMgCipnVaKqB2ZxmImpNSv2+4nk5bJ9tkaVnx2
   DDQCMevilhbp07KdSbSqrlZiVs8vhb0SIzsQ89rlz/LF100XJezzENZ22
   20Ojn/ZcTyJ1bQhBMwL/yF5ovIlNHIBtQuvn20bMxiKlAnd8PPCrdBg6D
   QsOwDdVTjuqryvKkDnfK1+RO+XZx9bz1T5r3QgUpoBL3A6J6fcIfdFrFB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="295852427"
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="295852427"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 21:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="521975664"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 May 2022 21:47:00 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nq69j-0001J1-SN;
        Sun, 15 May 2022 04:46:59 +0000
Date:   Sun, 15 May 2022 12:46:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS a6cfe03c34bad8c7f51aba49a73403e348c51d1f
Message-ID: <628085b3.7/p1+UkRWrf8dfdP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: a6cfe03c34bad8c7f51aba49a73403e348c51d1f  efi: stub: prefer mirrored memory for randomized allocations

elapsed time: 12757m

configs tested: 255
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                        clps711x_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                         tb0226_defconfig
m68k                             allmodconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
sh                ecovec24-romimage_defconfig
arm                           sunxi_defconfig
ia64                             alldefconfig
arm                          exynos_defconfig
h8300                    h8300h-sim_defconfig
m68k                       m5249evb_defconfig
m68k                       m5475evb_defconfig
arm                            pleb_defconfig
mips                          rb532_defconfig
sh                             sh03_defconfig
sh                   sh7724_generic_defconfig
m68k                          atari_defconfig
powerpc                       eiger_defconfig
powerpc                      cm5200_defconfig
ia64                         bigsur_defconfig
powerpc                     redwood_defconfig
mips                  decstation_64_defconfig
h8300                       h8s-sim_defconfig
sh                          kfr2r09_defconfig
sh                           se7712_defconfig
arm                         axm55xx_defconfig
arm                        spear6xx_defconfig
x86_64                           alldefconfig
powerpc                     tqm8548_defconfig
m68k                       bvme6000_defconfig
sh                          landisk_defconfig
csky                                defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7705_defconfig
arm                      footbridge_defconfig
sh                           se7750_defconfig
arc                         haps_hs_defconfig
powerpc                    klondike_defconfig
mips                        vocore2_defconfig
arc                        nsim_700_defconfig
sh                         ecovec24_defconfig
sh                               allmodconfig
sh                        dreamcast_defconfig
mips                 decstation_r4k_defconfig
powerpc64                        alldefconfig
arc                        nsimosci_defconfig
um                           x86_64_defconfig
mips                      loongson3_defconfig
sparc                            alldefconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     ep8248e_defconfig
sh                             espt_defconfig
arm                       multi_v4t_defconfig
arm                             ezx_defconfig
arm                        mini2440_defconfig
xtensa                              defconfig
arm                           sama5_defconfig
sh                         microdev_defconfig
powerpc                     stx_gp3_defconfig
mips                           jazz_defconfig
um                               alldefconfig
xtensa                    smp_lx200_defconfig
openrisc                    or1ksim_defconfig
m68k                          hp300_defconfig
sparc                       sparc64_defconfig
sh                          polaris_defconfig
sparc                               defconfig
sh                                  defconfig
xtensa                  audio_kc705_defconfig
mips                         mpc30x_defconfig
arm                            zeus_defconfig
arm                         lubbock_defconfig
sh                           se7343_defconfig
parisc                generic-32bit_defconfig
alpha                               defconfig
powerpc                      pasemi_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
alpha                            alldefconfig
m68k                        m5307c3_defconfig
arm                      integrator_defconfig
nios2                         10m50_defconfig
arm                          gemini_defconfig
powerpc                      pcm030_defconfig
powerpc                       holly_defconfig
sh                           se7721_defconfig
alpha                            allyesconfig
arm                          lpd270_defconfig
arc                           tb10x_defconfig
microblaze                          defconfig
mips                         db1xxx_defconfig
powerpc                   currituck_defconfig
mips                      maltasmvp_defconfig
powerpc                    adder875_defconfig
sparc64                             defconfig
sh                        apsh4ad0a_defconfig
sh                          lboxre2_defconfig
powerpc                      ppc6xx_defconfig
sh                          sdk7786_defconfig
arm                         lpc18xx_defconfig
powerpc                      chrp32_defconfig
s390                       zfcpdump_defconfig
arm                         s3c6400_defconfig
arm                           stm32_defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
arm                             rpc_defconfig
powerpc                mpc7448_hpc2_defconfig
nios2                            alldefconfig
arm                            lart_defconfig
powerpc                     pq2fads_defconfig
sh                 kfr2r09-romimage_defconfig
arc                              alldefconfig
arm                        shmobile_defconfig
sh                          sdk7780_defconfig
m68k                         amcore_defconfig
mips                            ar7_defconfig
arc                    vdk_hs38_smp_defconfig
mips                         bigsur_defconfig
ia64                            zx1_defconfig
sh                        sh7763rdp_defconfig
h8300                               defconfig
powerpc                    sam440ep_defconfig
sh                           se7722_defconfig
arm                          iop32x_defconfig
openrisc                            defconfig
arm                         at91_dt_defconfig
arm                           viper_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                  maltasmvp_eva_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220506
arm                  randconfig-c002-20220507
arm                  randconfig-c002-20220508
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220507
s390                 randconfig-r044-20220507
riscv                randconfig-r042-20220507
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220506
riscv                randconfig-c006-20220506
mips                 randconfig-c004-20220506
arm                  randconfig-c002-20220506
powerpc              randconfig-c003-20220507
riscv                randconfig-c006-20220507
mips                 randconfig-c004-20220507
arm                  randconfig-c002-20220507
powerpc              randconfig-c003-20220508
riscv                randconfig-c006-20220508
mips                 randconfig-c004-20220508
arm                  randconfig-c002-20220508
s390                 randconfig-c005-20220506
mips                         tb0219_defconfig
powerpc                     mpc5200_defconfig
arm                       cns3420vb_defconfig
arm                          collie_defconfig
mips                      pic32mzda_defconfig
arm                        vexpress_defconfig
arm                     davinci_all_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc8560_ads_defconfig
mips                      malta_kvm_defconfig
mips                          ath79_defconfig
arm                            mmp2_defconfig
arm                            dove_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
mips                       lemote2f_defconfig
arm                       aspeed_g4_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm5200_defconfig
arm                         s5pv210_defconfig
arm                       versatile_defconfig
i386                             allyesconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a004-20220509
i386                 randconfig-a006-20220509
i386                 randconfig-a002-20220509
i386                 randconfig-a003-20220509
i386                 randconfig-a001-20220509
i386                 randconfig-a005-20220509
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220506
riscv                randconfig-r042-20220506
hexagon              randconfig-r041-20220506
hexagon              randconfig-r045-20220509
hexagon              randconfig-r045-20220508
riscv                randconfig-r042-20220508
hexagon              randconfig-r041-20220509
hexagon              randconfig-r041-20220508

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
