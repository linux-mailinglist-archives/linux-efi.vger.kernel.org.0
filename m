Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A906755434F
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jun 2022 09:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiFVGoi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Jun 2022 02:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiFVGoi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Jun 2022 02:44:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967863466F
        for <linux-efi@vger.kernel.org>; Tue, 21 Jun 2022 23:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655880277; x=1687416277;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D/W30SGZAQY9abUmtfDX3Yg9zX/IusAFKM7rkqeBjgI=;
  b=JX7bzFdPmC3ScdUU0uzfmiMgdp/icGSEXQ2Q3O3hNdtQFwaqLSx4Uqfa
   FHs/OjMeBQ/AJS3uIUk2wGo+l8EKIYeIz+NyqVVsb8ZZSgVFWNt7lmQg/
   +FwCkNwulTXTj19labxAic8wIK/nYlYrgkW35AGal1AmpqY+8V2sjP+Pf
   wIMLLf2pvcmmY/Z9dmW4ULIRWNXCNbRgNXrwNzqOwh5I1FL2WDtC/iW0w
   zEimdkITs9Xyra2HvD5HWLV86neKXl5gXQHtak0as9p3FNATY6nWTC4uH
   2BcI/YAZBsKQkFGbtt/W6iJff56atv/AOHnak1FE6Qz6QEburtehuNIwu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260151693"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="260151693"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 23:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="655502574"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jun 2022 23:44:35 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3u6N-0000wr-BF;
        Wed, 22 Jun 2022 06:44:35 +0000
Date:   Wed, 22 Jun 2022 14:44:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 aa6d1ed107eba26f49933216cffe797253914132
Message-ID: <62b2ba47.2aTEhyZEHC/C57jS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: aa6d1ed107eba26f49933216cffe797253914132  efi/x86: libstub: Fix typo in __efi64_argmap* name

elapsed time: 806m

configs tested: 100
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220622
sh                           se7780_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     mpc83xx_defconfig
sh                          urquell_defconfig
sparc                       sparc64_defconfig
m68k                          multi_defconfig
alpha                            alldefconfig
mips                       bmips_be_defconfig
powerpc                      mgcoge_defconfig
arm                        shmobile_defconfig
arc                          axs103_defconfig
arm                           stm32_defconfig
ia64                             alldefconfig
sh                                  defconfig
ia64                      gensparse_defconfig
mips                           ci20_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7724_defconfig
arm                        realview_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                         wii_defconfig
sh                          sdk7786_defconfig
arm                         axm55xx_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
arm                      integrator_defconfig
um                             i386_defconfig
arm                         vf610m4_defconfig
powerpc                      pasemi_defconfig
m68k                            q40_defconfig
sh                          kfr2r09_defconfig
riscv                               defconfig
arm                         lubbock_defconfig
m68k                        mvme147_defconfig
sh                          rsk7201_defconfig
alpha                               defconfig
arc                                 defconfig
s390                             allmodconfig
s390                                defconfig
arm64                               defconfig
ia64                                defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220622
ia64                             allmodconfig
riscv                             allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
s390                             alldefconfig
mips                        qi_lb60_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220622
s390                 randconfig-r044-20220622
hexagon              randconfig-r045-20220622
riscv                randconfig-r042-20220622

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
