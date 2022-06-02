Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E42B53B106
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jun 2022 03:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiFBBFg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 21:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiFBBFe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 21:05:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CE827237C
        for <linux-efi@vger.kernel.org>; Wed,  1 Jun 2022 18:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654131933; x=1685667933;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tFjkRR5Ohf5vpdsKco/qiUT0mSKGXKMzvurYp0VSee8=;
  b=lrmmbW+dFCV5lQi1uf8Ieq7gPNChcqWuu8z6OyPC5lhsEioVFzd93cWg
   hXyf9oNllBN/3gqQMjwhzCPC4uGOFvapZtNlP6xGHz7D7tUm/ePyx3d2D
   GLDOG6BWCsMuOuLiefe73XrhYys5j0NMj0BE1/LQJLPtRXSf3LTruvKX7
   Vza7uUo3P0RpYvilCW0yV+wQgEhQ8QzGDsf84PkF7bXJhzx+9KQgpAP2Q
   YbTo5+KtthMNRYanr5aPiOd+qs83e9ayFwLwDaGjEqTRttUnevR+WSIRz
   UlvCPL50p5ZGcf8/ladCc4L7I9bpLk5uwmqQM+UuHUk4pDUcFxdMKTgVe
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="362154432"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="362154432"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 18:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="904718691"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jun 2022 18:05:31 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwZHH-0004bJ-5M;
        Thu, 02 Jun 2022 01:05:31 +0000
Date:   Thu, 02 Jun 2022 09:05:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 75ed63d919400b803691a0c757ee23c6f767a625
Message-ID: <62980cd3.Y7kdHunRW8Po9nvL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 75ed63d919400b803691a0c757ee23c6f767a625  efi: clean up Kconfig dependencies on CONFIG_EFI

elapsed time: 724m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
s390                       zfcpdump_defconfig
sh                          r7785rp_defconfig
sh                          rsk7201_defconfig
powerpc                    adder875_defconfig
ia64                        generic_defconfig
xtensa                    xip_kc705_defconfig
ia64                            zx1_defconfig
sh                           se7750_defconfig
arm                          badge4_defconfig
mips                       capcella_defconfig
arm                           tegra_defconfig
arm                        shmobile_defconfig
arm                       omap2plus_defconfig
arm                      footbridge_defconfig
mips                          rb532_defconfig
ia64                         bigsur_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        dreamcast_defconfig
parisc                generic-64bit_defconfig
ia64                             alldefconfig
arm                         lpc18xx_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                             rpc_defconfig
sh                          kfr2r09_defconfig
arm                        mini2440_defconfig
arm                           sunxi_defconfig
arm                        spear6xx_defconfig
arm                          pxa910_defconfig
sh                             shx3_defconfig
arc                          axs103_defconfig
sh                      rts7751r2d1_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                     magicpanelr2_defconfig
arm                           corgi_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220531
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
riscv                             allnoconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220531
s390                 randconfig-r044-20220531
riscv                randconfig-r042-20220531
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                 randconfig-c004-20220531
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220531
arm                  randconfig-c002-20220531
powerpc              randconfig-c003-20220531
riscv                randconfig-c006-20220531
powerpc                     tqm8540_defconfig
powerpc                     skiroot_defconfig
mips                          rm200_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220531
hexagon              randconfig-r045-20220531
hexagon              randconfig-r045-20220601
s390                 randconfig-r044-20220601
riscv                randconfig-r042-20220601
hexagon              randconfig-r041-20220601
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
