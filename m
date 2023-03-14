Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAF36BA2AE
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 23:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCNWp6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCNWp5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 18:45:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DA222CA3
        for <linux-efi@vger.kernel.org>; Tue, 14 Mar 2023 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678833956; x=1710369956;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rmo1VGE76fn8u1d6OB3aJjwhUD7qQvSaLvvN6HuNys8=;
  b=cag8Cmjh/ibEDek2eMyCBfJxR/koX1wksoMkwFDB7b2nJ6VcoKAZbQ3A
   fmPjo5qKCqdRrQBNhlo+UmHs1dyT/pmQHdQaUqyKJd389Q+4ZbEZcCDTy
   FlmG01TIlaW2oDOaiDK5a49z3Ea1rYHxfpTBu11NsBDe00sFdSg2kkoC2
   dx0g8wi1TQ2D+Sv1Wr5CKh7rDgc/YbCri6w2MUHUbohAESSxspAULtNPm
   8wEwmJJqhHEz50OR60PywRPiQ8uwHBTUtxlq6tc7C3qbJD2FZ3PLJGiVz
   e6CR575nNu1lTsfrRuIl3ka6P2/0pzkWS4FyzXueEdJbRTSDS5IjvQOp5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="339100084"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="339100084"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 15:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="672514121"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="672514121"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Mar 2023 15:45:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcDOz-0007F1-1T;
        Tue, 14 Mar 2023 22:45:53 +0000
Date:   Wed, 15 Mar 2023 06:44:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD REGRESSION
 ef3efc2af044f6da5bb8c55e99f2398081d99c09
Message-ID: <6410f8e8.fyjdHRwDeSkUFLMV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: ef3efc2af044f6da5bb8c55e99f2398081d99c09  efi: libstub: Use relocated version of kernel's struct screen_info

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303132020.S9CriCjt-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303142336.P1ZcCB9r-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ld.lld: error: undefined hidden symbol: __efistub__edata
ld.lld: error: undefined hidden symbol: __efistub__end
ld.lld: error: undefined hidden symbol: __efistub__start
ld.lld: error: undefined hidden symbol: __efistub__start_kernel
ld.lld: error: undefined hidden symbol: __efistub_screen_info

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- riscv-randconfig-r025-20230313
|   |-- ld.lld:error:undefined-hidden-symbol:__efistub__edata
|   |-- ld.lld:error:undefined-hidden-symbol:__efistub__end
|   |-- ld.lld:error:undefined-hidden-symbol:__efistub__start
|   |-- ld.lld:error:undefined-hidden-symbol:__efistub__start_kernel
|   `-- ld.lld:error:undefined-hidden-symbol:__efistub_screen_info
|-- riscv-randconfig-r026-20230313
|   |-- ld.lld:error:undefined-hidden-symbol:__efistub__edata
|   |-- ld.lld:error:undefined-hidden-symbol:__efistub__end
|   |-- ld.lld:error:undefined-hidden-symbol:__efistub__start
|   |-- ld.lld:error:undefined-hidden-symbol:__efistub__start_kernel
|   `-- ld.lld:error:undefined-hidden-symbol:__efistub_screen_info
`-- riscv-randconfig-r042-20230313
    |-- ld.lld:error:undefined-hidden-symbol:__efistub__edata
    |-- ld.lld:error:undefined-hidden-symbol:__efistub__end
    |-- ld.lld:error:undefined-hidden-symbol:__efistub__start
    |-- ld.lld:error:undefined-hidden-symbol:__efistub__start_kernel
    `-- ld.lld:error:undefined-hidden-symbol:__efistub_screen_info

elapsed time: 729m

configs tested: 139
configs skipped: 14

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230312   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230313   clang
arm                  randconfig-r006-20230312   gcc  
arm                  randconfig-r011-20230312   clang
arm                  randconfig-r026-20230312   clang
arm                  randconfig-r034-20230313   clang
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230312   clang
arm64                randconfig-r004-20230312   clang
arm64                randconfig-r005-20230312   clang
csky                                defconfig   gcc  
csky                 randconfig-r014-20230313   gcc  
csky                 randconfig-r036-20230313   gcc  
hexagon              randconfig-r006-20230313   clang
hexagon              randconfig-r013-20230312   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                 randconfig-a003-20230313   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                 randconfig-a005-20230313   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                 randconfig-a011-20230313   clang
i386                 randconfig-a012-20230313   clang
i386                 randconfig-a013-20230313   clang
i386                 randconfig-a014-20230313   clang
i386                 randconfig-a015-20230313   clang
i386                 randconfig-a016-20230313   clang
i386                 randconfig-r024-20230313   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r006-20230312   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r014-20230312   gcc  
ia64                 randconfig-r015-20230313   gcc  
ia64                 randconfig-r016-20230313   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230312   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230312   gcc  
m68k                 randconfig-r005-20230312   gcc  
m68k                 randconfig-r032-20230312   gcc  
microblaze           randconfig-r006-20230312   gcc  
microblaze           randconfig-r006-20230313   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230312   gcc  
mips                 randconfig-r001-20230313   clang
mips                 randconfig-r003-20230313   clang
mips                 randconfig-r033-20230312   gcc  
mips                 randconfig-r035-20230312   gcc  
nios2        buildonly-randconfig-r001-20230313   gcc  
nios2        buildonly-randconfig-r006-20230313   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230312   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230313   gcc  
riscv                randconfig-r012-20230313   clang
riscv                randconfig-r022-20230313   clang
riscv                randconfig-r025-20230313   clang
riscv                randconfig-r032-20230313   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230312   gcc  
s390         buildonly-randconfig-r002-20230312   gcc  
s390         buildonly-randconfig-r003-20230312   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230313   gcc  
sh           buildonly-randconfig-r003-20230313   gcc  
sh           buildonly-randconfig-r005-20230313   gcc  
sh                   randconfig-r022-20230312   gcc  
sh                   randconfig-r023-20230313   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230313   gcc  
sparc                randconfig-r021-20230312   gcc  
sparc                randconfig-r023-20230312   gcc  
sparc                randconfig-r034-20230312   gcc  
sparc64              randconfig-r001-20230313   gcc  
sparc64              randconfig-r013-20230313   gcc  
sparc64              randconfig-r015-20230312   gcc  
sparc64              randconfig-r024-20230312   gcc  
sparc64              randconfig-r033-20230313   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r004-20230313   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64               randconfig-a002-20230313   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64               randconfig-a004-20230313   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64               randconfig-a006-20230313   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64               randconfig-a012-20230313   clang
x86_64               randconfig-a013-20230313   clang
x86_64               randconfig-a014-20230313   clang
x86_64               randconfig-a015-20230313   clang
x86_64               randconfig-a016-20230313   clang
x86_64               randconfig-r002-20230313   gcc  
x86_64               randconfig-r035-20230313   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230312   gcc  
xtensa               randconfig-r036-20230312   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
