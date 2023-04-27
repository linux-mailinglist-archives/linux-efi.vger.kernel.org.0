Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18D36F0406
	for <lists+linux-efi@lfdr.de>; Thu, 27 Apr 2023 12:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbjD0KRX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Apr 2023 06:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbjD0KRV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Apr 2023 06:17:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B938D187
        for <linux-efi@vger.kernel.org>; Thu, 27 Apr 2023 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682590640; x=1714126640;
  h=date:from:to:cc:subject:message-id;
  bh=u3z+REG66CCAJwqGIbpv2OpPkjPf6SWG9FC88TrxZLU=;
  b=nbqSUevHriDyZhpiQmG9/Y7ZDXJR3lDZ9Wq/yrzNB3+b4hnekB7qFuc6
   RDkNrVdIciocDVKvaGCHJ5QFlkTJpcWyYuCgXnrQ8gTRBPdZjW2SuJkY5
   R8pQV0OP1V+D1iNoSa2QyWvsWoc9ekCSjhGUpZkbDLqZ9jiTeqToQLBQf
   x99WwAcQqRo0xMuV0vCOOIHqUuxF3fzL5XxzZprvURHm+FgCIVf+oMH0J
   wUXYeIF5xRP9suI9X4Zl1UB+YG9228cjQ5+FHqDG9yn9FL/g5xzTRrRmS
   PcFKHlDyv3snHCeG6JMZfJtCLV723PI21USMhwKfGBVgdUdwrIsjiOoWd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="327713955"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="327713955"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 03:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="694327689"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="694327689"
Received: from lkp-server01.sh.intel.com (HELO 1e0e07564161) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Apr 2023 03:17:19 -0700
Received: from kbuild by 1e0e07564161 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prygg-0000AN-1w;
        Thu, 27 Apr 2023 10:17:18 +0000
Date:   Thu, 27 Apr 2023 18:16:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 026b85796ab4d52af56f8a1c60d2613983ecd845
Message-ID: <20230427101622.6x_fo%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 026b85796ab4d52af56f8a1c60d2613983ecd845  efi/zboot: arm64: Grab code size from ELF symbol in payload

elapsed time: 724m

configs tested: 100
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230426   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230426   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230426   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230426   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230426   clang
arm64        buildonly-randconfig-r005-20230426   clang
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230426   gcc  
hexagon              randconfig-r034-20230426   clang
hexagon              randconfig-r041-20230426   clang
hexagon              randconfig-r045-20230426   clang
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r022-20230426   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r025-20230426   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230426   gcc  
m68k                 randconfig-r014-20230426   gcc  
m68k                 randconfig-r023-20230426   gcc  
m68k                 randconfig-r036-20230426   gcc  
microblaze           randconfig-r005-20230426   gcc  
microblaze           randconfig-r006-20230426   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r035-20230426   gcc  
parisc       buildonly-randconfig-r006-20230426   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230426   gcc  
powerpc              randconfig-r013-20230426   gcc  
powerpc              randconfig-r016-20230426   gcc  
powerpc              randconfig-r024-20230426   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230426   gcc  
riscv                randconfig-r042-20230426   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r032-20230426   clang
s390                 randconfig-r044-20230426   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r031-20230426   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r003-20230426   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230426   gcc  
xtensa               randconfig-r026-20230426   gcc  
xtensa               randconfig-r033-20230426   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
