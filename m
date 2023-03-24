Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8346C7646
	for <lists+linux-efi@lfdr.de>; Fri, 24 Mar 2023 04:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCXDeI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Mar 2023 23:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCXDeF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Mar 2023 23:34:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4396529141
        for <linux-efi@vger.kernel.org>; Thu, 23 Mar 2023 20:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679628844; x=1711164844;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JezNBC/b6PLknkNfqfNpzd2B5z4GfBj+AUd1IyXpyoE=;
  b=OKGUA1vww8P6t7fCE5Q9OygR8/jrvoYjS4qepIWOKqhe4WJlZ/A4ss1e
   mGUlDXLF9qGNm+/hvg3SqT3XGK/b0sMkiWaxOHRqJBjxY77ZZTDC5j/ql
   r11AUgWAWycrFHXM4wIaUXORYwomqPgQLgDsjACtomEp4H8sZ2ngbjUBr
   gihYiDadRh0NAs1gq8/600Ddf19CJqfW/LSaz8+uJUaO2g6py7lVnZl+L
   lRBt5aaqzkAo7HYEiLVqprk9l6130dAH+lJjXNKpzT2ZI9Qzm6RdYSocg
   8Dt2IpU/LxARTr/cIofC1AAxIavpHQ5gNS7C2JIbmcYEPFWMNFMm1S4h7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="328097331"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="328097331"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 20:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="746999275"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="746999275"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Mar 2023 20:33:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfYBf-000EwK-33;
        Fri, 24 Mar 2023 03:33:55 +0000
Date:   Fri, 24 Mar 2023 11:33:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 0b1d9debe30304f35c1211e6dcdca1935ce67240
Message-ID: <641d1a0e.coz0eqpst7IYsmbd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 0b1d9debe30304f35c1211e6dcdca1935ce67240  efi/libstub: randomalloc: Return EFI_OUT_OF_RESOURCES on failure

elapsed time: 722m

configs tested: 145
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230322   gcc  
alpha                randconfig-r026-20230322   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230323   gcc  
arc                  randconfig-r043-20230322   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230322   gcc  
arm                  randconfig-r023-20230322   clang
arm                  randconfig-r025-20230322   clang
arm                  randconfig-r046-20230322   clang
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230322   gcc  
arm64                randconfig-r025-20230323   clang
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r003-20230322   clang
hexagon              randconfig-r004-20230322   clang
hexagon              randconfig-r013-20230322   clang
hexagon              randconfig-r035-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230322   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r033-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230322   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230322   gcc  
loongarch            randconfig-r021-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230322   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                 randconfig-r023-20230322   gcc  
microblaze   buildonly-randconfig-r004-20230322   gcc  
microblaze   buildonly-randconfig-r006-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                 randconfig-r021-20230322   clang
mips                 randconfig-r034-20230322   gcc  
mips                           rs90_defconfig   clang
nios2        buildonly-randconfig-r004-20230322   gcc  
nios2        buildonly-randconfig-r005-20230322   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230322   gcc  
nios2                randconfig-r016-20230322   gcc  
nios2                randconfig-r024-20230323   gcc  
nios2                randconfig-r026-20230322   gcc  
nios2                randconfig-r035-20230322   gcc  
openrisc     buildonly-randconfig-r002-20230322   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r001-20230322   gcc  
openrisc             randconfig-r005-20230322   gcc  
openrisc             randconfig-r012-20230322   gcc  
openrisc             randconfig-r016-20230322   gcc  
openrisc             randconfig-r026-20230323   gcc  
openrisc             randconfig-r032-20230322   gcc  
openrisc             randconfig-r036-20230322   gcc  
parisc       buildonly-randconfig-r005-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230323   gcc  
parisc               randconfig-r031-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc      buildonly-randconfig-r003-20230322   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                 mpc834x_mds_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc              randconfig-c003-20230322   gcc  
powerpc              randconfig-r025-20230322   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230322   clang
riscv                randconfig-r024-20230322   gcc  
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230322   clang
s390                 randconfig-r003-20230322   clang
s390                 randconfig-r011-20230322   gcc  
s390                 randconfig-r031-20230322   clang
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230322   gcc  
sh                   randconfig-r014-20230322   gcc  
sh                   randconfig-r022-20230323   gcc  
sh                   randconfig-r024-20230322   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230322   gcc  
xtensa       buildonly-randconfig-r006-20230322   gcc  
xtensa                  nommu_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
