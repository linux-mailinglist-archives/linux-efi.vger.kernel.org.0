Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC886720D13
	for <lists+linux-efi@lfdr.de>; Sat,  3 Jun 2023 03:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbjFCB4S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 21:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjFCB4R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 21:56:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E57E47
        for <linux-efi@vger.kernel.org>; Fri,  2 Jun 2023 18:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685757375; x=1717293375;
  h=date:from:to:cc:subject:message-id;
  bh=1x8+eHEvrb+bjRfNPwSST2RNRGjEzaSLvjHo+3pO2DM=;
  b=M9DGAeNWNaxhkc+OSQbMifLpRHw4YAr4Psx+pYggWNyoz6uP3tidowiu
   UgUe2sW7B3m0n4OKD5CLD76Hmr2rynGo4hVNzzHirMdWcn/RImb1x1nun
   CyfF8/nAP8QLXNPv0yMjbTsxb8vNVFwrkPpx6AkAhQbcjgzqCiVYhENeP
   7w5Hz4rOixJrwrB0qvY12MjKu1WJ/toOiQbT895uOxzJGVGWOke4xp56Y
   TycfgSpQ66tngvNeIXUt0E3wzgTiWYHN8gEMbnYzNBtZqgKp+lWToLzll
   Qat8VcqViyY0bezM9tgtXaEJzaphAikf9Tg4ldKAoXyAn3l8i0aJ1AdY+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="345601108"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="345601108"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 18:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="737733857"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="737733857"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Jun 2023 18:56:12 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5GV1-00019l-0T;
        Sat, 03 Jun 2023 01:56:11 +0000
Date:   Sat, 03 Jun 2023 09:55:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 128d85761fe9ccd91ea685287c3472d09be6de29
Message-ID: <20230603015549.lfUTG%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 128d85761fe9ccd91ea685287c3472d09be6de29  efi/esrt: Allow ESRT access without CAP_SYS_ADMIN

elapsed time: 720m

configs tested: 113
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230602   gcc  
alpha                randconfig-r036-20230531   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                        multi_v5_defconfig   clang
arm                             mxs_defconfig   clang
arm                  randconfig-r006-20230531   clang
arm                  randconfig-r046-20230531   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230602   clang
csky                                defconfig   gcc  
csky                 randconfig-r031-20230531   gcc  
hexagon      buildonly-randconfig-r003-20230531   clang
hexagon              randconfig-r005-20230531   clang
hexagon              randconfig-r016-20230601   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i051-20230602   gcc  
i386                 randconfig-i052-20230602   gcc  
i386                 randconfig-i053-20230602   gcc  
i386                 randconfig-i054-20230602   gcc  
i386                 randconfig-i055-20230602   gcc  
i386                 randconfig-i056-20230602   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r004-20230531   gcc  
i386                 randconfig-r034-20230531   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230531   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k         buildonly-randconfig-r004-20230531   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230601   gcc  
m68k                 randconfig-r014-20230601   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r023-20230602   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                 randconfig-r003-20230531   clang
mips                          rm200_defconfig   clang
nios2                               defconfig   gcc  
parisc       buildonly-randconfig-r005-20230531   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230601   gcc  
parisc               randconfig-r022-20230602   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc              randconfig-r012-20230601   gcc  
powerpc              randconfig-r035-20230531   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230531   clang
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230531   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230531   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r015-20230601   gcc  
sh                          rsk7269_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r026-20230602   gcc  
sparc64              randconfig-r024-20230602   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
