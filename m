Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6F6083CE
	for <lists+linux-efi@lfdr.de>; Sat, 22 Oct 2022 05:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJVDUq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Oct 2022 23:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJVDUp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Oct 2022 23:20:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD5C21E117
        for <linux-efi@vger.kernel.org>; Fri, 21 Oct 2022 20:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666408843; x=1697944843;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kGhbADLZomTSWkvVXnueHC4EDMNNUiGk2J1lO+dLY8k=;
  b=RxzX4I2dS4gSmxGjR8pMyM9no+xcRsvUU9YrIu+HGPOJyx/tDKZSwkZ+
   HtznyhHNG2M2xgh+C3DUCUd39KAEM6uHfIjcinkn/xqI/W2jQjZ8U5EDX
   pGYOHTqP5RuGDvodep+SEp96hBuY4jTzPGPB1R9iHllfx7Vum9mf3pofT
   08lsgEQLQSviGtzCkImIaqHyr9dPpJQHIr57K1PBW38bXweC6lL0FB9nx
   EtRm5yhWbzuTRPVOLD4iBNysg5VkULmo03GvNQxf7HvX7gmHasuLGArUv
   /ZpUFAZ8lcnh9NCUso97jdGNH2hZc1yWChS2cPXByKya1VbYhgpajZX0Z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="287550021"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="287550021"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 20:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="581821772"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="581821772"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Oct 2022 20:20:40 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1om53w-0003HK-0i;
        Sat, 22 Oct 2022 03:20:40 +0000
Date:   Sat, 22 Oct 2022 11:20:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 32d3f1d8ba584936cce0e874f6df0177f2169a37
Message-ID: <6353616d.BIjeTH2MmN8bnRoL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 32d3f1d8ba584936cce0e874f6df0177f2169a37  efi: libstub: Deduplicate ftrace command line argument filtering

elapsed time: 723m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
alpha                               defconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
s390                             allmodconfig
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
m68k                             allmodconfig
i386                                defconfig
alpha                            allyesconfig
s390                             allyesconfig
m68k                             allyesconfig
arc                  randconfig-r043-20221019
arc                              allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a013
x86_64                        randconfig-a004
x86_64                        randconfig-a011
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                             allyesconfig
arm                                 defconfig
i386                          randconfig-a003
x86_64                               rhel-8.3
x86_64                        randconfig-a015
arm                              allyesconfig
x86_64                           allyesconfig
arm64                            allyesconfig
i386                          randconfig-a005
arc                           tb10x_defconfig
sh                            titan_defconfig
powerpc                     pq2fads_defconfig
arm                         nhk8815_defconfig
arm                       omap2plus_defconfig
arm                        clps711x_defconfig
powerpc                 linkstation_defconfig
arc                            hsdk_defconfig
openrisc                 simple_smp_defconfig
arc                              alldefconfig
m68k                          atari_defconfig
powerpc                     tqm8548_defconfig
arm                          lpd270_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                           u8500_defconfig
csky                                defconfig
parisc                generic-64bit_defconfig
i386                          randconfig-c001
sh                           se7722_defconfig
sparc                       sparc32_defconfig
sh                          sdk7786_defconfig
parisc                           alldefconfig
mips                      fuloong2e_defconfig
arm                        multi_v7_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
m68k                           virt_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                  randconfig-r043-20221022
s390                 randconfig-r044-20221022
riscv                randconfig-r042-20221022
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
ia64                          tiger_defconfig
arm                        mvebu_v7_defconfig
mips                    maltaup_xpa_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                            q40_defconfig
m68k                        mvme147_defconfig
nios2                            allyesconfig
arm                            zeus_defconfig
sh                               alldefconfig
loongarch                         allnoconfig

clang tested configs:
riscv                randconfig-r042-20221019
hexagon              randconfig-r045-20221019
hexagon              randconfig-r041-20221019
s390                 randconfig-r044-20221019
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                 randconfig-a011-20221017
i386                          randconfig-a002
i386                 randconfig-a013-20221017
i386                 randconfig-a012-20221017
i386                 randconfig-a014-20221017
i386                          randconfig-a006
i386                 randconfig-a016-20221017
i386                          randconfig-a004
i386                 randconfig-a015-20221017
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
arm                        vexpress_defconfig
mips                       rbtx49xx_defconfig
arm                           spitz_defconfig
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
x86_64                        randconfig-k001
arm                       netwinder_defconfig
mips                        maltaup_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   microwatt_defconfig
arm                         orion5x_defconfig
powerpc                      obs600_defconfig
arm                            mmp2_defconfig
arm                      pxa255-idp_defconfig
mips                          ath79_defconfig
powerpc                      acadia_defconfig
arm                             mxs_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
