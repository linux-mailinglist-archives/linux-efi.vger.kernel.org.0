Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA5518A33
	for <lists+linux-efi@lfdr.de>; Tue,  3 May 2022 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbiECQou (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 May 2022 12:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiECQot (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 May 2022 12:44:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2B72C107
        for <linux-efi@vger.kernel.org>; Tue,  3 May 2022 09:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651596076; x=1683132076;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Omf2leaYy8SkiNoY1fHWtecqvhHv3agTC+W+OYTxo5A=;
  b=imc751Lfu6Sg8cDbxBpcr/+wxpKLw4JNutHDLyihKwiGlpGbTafeFKT8
   hv2LhNZ3Z/9cCLf8Oucon/HKaVK5DtKkkEpkg657zGi7ShXHttDjlamEU
   hfMffEatejrnwy/xpjJRyfGeyRQ7HepzZLW8Cw9WGE33lftGlk5kMkGYl
   /rAD49y6i8SILXD05QQ12mwiZva3E3XHSAmN0rr3YmKAkXpA8vNglCGYH
   pUeYiUhJdL2qkMgFbrS2dyoKlx+nLY7iOnVycbxxBrl9N3lHPMz0R2t5h
   haDM1C7vReACeO7mGjOCdj+zwdb4QL88iYTD/XDe4v4QRvQnxjVZq2Nky
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="292715355"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="292715355"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 09:41:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="516638554"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 09:41:14 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlvaL-000AcV-EP;
        Tue, 03 May 2022 16:41:13 +0000
Date:   Wed, 04 May 2022 00:40:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 736e0f2179d3005d994ab5addd282988de2e4615
Message-ID: <62715af2.sPgztnRjOIiJa696%lkp@intel.com>
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
branch HEAD: 736e0f2179d3005d994ab5addd282988de2e4615  efi/arm64: libstub: run image in place if randomized by the loader

elapsed time: 7539m

configs tested: 276
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                           imxrt_defconfig
powerpc                    sam440ep_defconfig
arc                         haps_hs_defconfig
xtensa                          iss_defconfig
mips                         tb0226_defconfig
powerpc                      cm5200_defconfig
powerpc                       holly_defconfig
ia64                          tiger_defconfig
mips                         cobalt_defconfig
xtensa                           allyesconfig
powerpc                         ps3_defconfig
arc                     haps_hs_smp_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
mips                  decstation_64_defconfig
arm                            zeus_defconfig
s390                       zfcpdump_defconfig
arm                        realview_defconfig
arm                       multi_v4t_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
arm                         lubbock_defconfig
m68k                                defconfig
sh                          sdk7780_defconfig
powerpc                     tqm8555_defconfig
parisc                              defconfig
sh                         microdev_defconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
mips                           ip32_defconfig
arm                          lpd270_defconfig
riscv                            allyesconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                        cell_defconfig
parisc                generic-64bit_defconfig
arm                         cm_x300_defconfig
h8300                               defconfig
sh                          rsk7264_defconfig
sparc                            alldefconfig
powerpc                      ep88xc_defconfig
arc                          axs103_defconfig
powerpc                    klondike_defconfig
m68k                       m5208evb_defconfig
arc                              alldefconfig
sparc                       sparc64_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                       common_defconfig
ia64                         bigsur_defconfig
m68k                          sun3x_defconfig
arm                         nhk8815_defconfig
sh                        apsh4ad0a_defconfig
m68k                       m5275evb_defconfig
arm                          iop32x_defconfig
arm                           stm32_defconfig
arc                        nsim_700_defconfig
m68k                        m5272c3_defconfig
nios2                         3c120_defconfig
powerpc64                           defconfig
powerpc                     tqm8541_defconfig
mips                            gpr_defconfig
arm                            lart_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc8540_ads_defconfig
alpha                               defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
sh                          lboxre2_defconfig
m68k                           sun3_defconfig
powerpc                     taishan_defconfig
sh                          landisk_defconfig
arm                         lpc18xx_defconfig
arm                       omap2plus_defconfig
sh                          kfr2r09_defconfig
alpha                            alldefconfig
mips                      fuloong2e_defconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
powerpc                   motionpro_defconfig
m68k                       m5475evb_defconfig
m68k                       bvme6000_defconfig
sh                        edosk7760_defconfig
s390                          debug_defconfig
sh                      rts7751r2d1_defconfig
arm                        cerfcube_defconfig
arm                      integrator_defconfig
um                               alldefconfig
sh                          rsk7201_defconfig
arm                        oxnas_v6_defconfig
m68k                          multi_defconfig
mips                     loongson1b_defconfig
sh                         ecovec24_defconfig
arm                        multi_v7_defconfig
sh                ecovec24-romimage_defconfig
microblaze                          defconfig
powerpc                      ppc6xx_defconfig
powerpc                     pq2fads_defconfig
mips                     decstation_defconfig
powerpc                         wii_defconfig
s390                             allyesconfig
powerpc                    amigaone_defconfig
powerpc                       maple_defconfig
mips                      maltasmvp_defconfig
sh                             espt_defconfig
xtensa                    smp_lx200_defconfig
openrisc                            defconfig
sh                          urquell_defconfig
arm                       aspeed_g5_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
powerpc                   currituck_defconfig
mips                             allyesconfig
h8300                       h8s-sim_defconfig
sh                           sh2007_defconfig
powerpc                     mpc83xx_defconfig
i386                                defconfig
mips                           jazz_defconfig
powerpc                      makalu_defconfig
powerpc                      chrp32_defconfig
powerpc                     asp8347_defconfig
mips                       bmips_be_defconfig
sh                           se7206_defconfig
sh                   rts7751r2dplus_defconfig
parisc64                            defconfig
sh                        sh7763rdp_defconfig
m68k                             allmodconfig
openrisc                    or1ksim_defconfig
sh                           se7705_defconfig
m68k                         amcore_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220428
arm                  randconfig-c002-20220429
x86_64               randconfig-c001-20220502
i386                 randconfig-c001-20220502
arm                  randconfig-c002-20220502
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                               defconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a006-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a003-20220502
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
arc                  randconfig-r043-20220428
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
riscv                randconfig-c006-20220429
mips                 randconfig-c004-20220429
arm                  randconfig-c002-20220429
powerpc              randconfig-c003-20220429
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
arm                        vexpress_defconfig
arm                         palmz72_defconfig
arm                       cns3420vb_defconfig
riscv                    nommu_virt_defconfig
powerpc                  mpc866_ads_defconfig
arm                          moxart_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1830-neo_defconfig
arm64                            allyesconfig
arm                            mmp2_defconfig
powerpc                      katmai_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                           mtx1_defconfig
powerpc                      walnut_defconfig
arm                              alldefconfig
mips                            e55_defconfig
powerpc                        fsp2_defconfig
powerpc                   microwatt_defconfig
mips                       lemote2f_defconfig
arm                         bcm2835_defconfig
arm                          ep93xx_defconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
x86_64                           allyesconfig
mips                           ip28_defconfig
mips                      maltaaprp_defconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
arm                       aspeed_g4_defconfig
powerpc                      acadia_defconfig
arm                        magician_defconfig
arm                          ixp4xx_defconfig
riscv                          rv32_defconfig
mips                     cu1000-neo_defconfig
arm                             mxs_defconfig
powerpc                 linkstation_defconfig
mips                      bmips_stb_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a015-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a011-20220502
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220428
hexagon              randconfig-r041-20220428
riscv                randconfig-r042-20220428
s390                 randconfig-r044-20220428
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
