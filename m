Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF8563EDB
	for <lists+linux-efi@lfdr.de>; Sat,  2 Jul 2022 09:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiGBHAm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 2 Jul 2022 03:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBHAl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 2 Jul 2022 03:00:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCCD13D2C
        for <linux-efi@vger.kernel.org>; Sat,  2 Jul 2022 00:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656745240; x=1688281240;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=c97CPTziTOY7GTSJKyZyYi4vlb2Ns/bbQFZTZKj2CUg=;
  b=VQ3LB2awI2CL1Ug3wdIjVjF1X2pxApEzjqofdgPyIgrrdzZvu38qfeg2
   hxJ0vUUUBY2zsYKQ1Xf4s40wiQ95SNzLojeNm5sOfHv1IZxB5d77gjONr
   OvCu5Yme3BHQVNreZG/HAKwgvVGqVpKzNbQE/5TNJ1b6hHIBZS8HQmscI
   GqQ5YLHOZ6Je5BoUWfNT16IheiwRDhr63XwZgjrigT/s6M3aEJzK8F00V
   Wyk0TSvlKOBr0/wjsvMG2gMQNGAbwLFcNV1iiAITEGbDsoZm79QR81TyW
   v9R+re34NE21iYiL8KsD4MeSTczrCVyLqlXpzDY+6sJ7NLi9x/dn7dVnG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="369125994"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="369125994"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 00:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="768720358"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Jul 2022 00:00:38 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7X7O-000EvK-12;
        Sat, 02 Jul 2022 07:00:38 +0000
Date:   Sat, 02 Jul 2022 15:00:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS df3c9072ef90b19ee317afbef185b65537c701cf
Message-ID: <62bfed0f.81ggWSeZyXk1iKte%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: df3c9072ef90b19ee317afbef185b65537c701cf  Merge branch 'efivars-cleanup' into efi/next

elapsed time: 2304m

configs tested: 139
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                         db1xxx_defconfig
sh                         microdev_defconfig
riscv                    nommu_k210_defconfig
sh                             shx3_defconfig
arc                     haps_hs_smp_defconfig
m68k                          amiga_defconfig
arm                        mini2440_defconfig
arm                            xcep_defconfig
arm                         at91_dt_defconfig
sh                        sh7785lcr_defconfig
arm                            mps2_defconfig
mips                        bcm47xx_defconfig
sh                          rsk7203_defconfig
sparc64                          alldefconfig
arm                            zeus_defconfig
arm                             ezx_defconfig
powerpc                      ppc6xx_defconfig
powerpc                  storcenter_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                 canyonlands_defconfig
xtensa                  audio_kc705_defconfig
arc                              alldefconfig
arm                          pxa910_defconfig
arm                           imxrt_defconfig
mips                      loongson3_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     tqm8541_defconfig
powerpc                      ep88xc_defconfig
arm                            lart_defconfig
arm                           u8500_defconfig
m68k                                defconfig
sh                            migor_defconfig
arm                      jornada720_defconfig
arm                           stm32_defconfig
arm                         axm55xx_defconfig
mips                           ip32_defconfig
powerpc                     tqm8548_defconfig
m68k                       bvme6000_defconfig
xtensa                              defconfig
sh                  sh7785lcr_32bit_defconfig
mips                  decstation_64_defconfig
arm                        shmobile_defconfig
arm                          iop32x_defconfig
arm                           sama5_defconfig
sh                           se7712_defconfig
sh                                  defconfig
xtensa                       common_defconfig
mips                      maltasmvp_defconfig
arc                        nsimosci_defconfig
nios2                         3c120_defconfig
powerpc                      cm5200_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20220629
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220629
riscv                randconfig-r042-20220629
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                        maltaup_defconfig
powerpc                       ebony_defconfig
mips                        omega2p_defconfig
arm                             mxs_defconfig
powerpc                  mpc885_ads_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       netwinder_defconfig
powerpc                   microwatt_defconfig
powerpc                     akebono_defconfig
powerpc                        fsp2_defconfig
mips                       lemote2f_defconfig
powerpc                 mpc832x_rdb_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220629
hexagon              randconfig-r045-20220629

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
