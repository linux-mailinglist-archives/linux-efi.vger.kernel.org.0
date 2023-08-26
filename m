Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DFE78975B
	for <lists+linux-efi@lfdr.de>; Sat, 26 Aug 2023 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjHZOZY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Aug 2023 10:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjHZOYx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 26 Aug 2023 10:24:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B332102
        for <linux-efi@vger.kernel.org>; Sat, 26 Aug 2023 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693059891; x=1724595891;
  h=date:from:to:cc:subject:message-id;
  bh=ELk+pDUJ8Ws8zUHcbRy9bwLlmugTKHYyVgAKsuOg1wU=;
  b=LYnET0lCVYI4/OrtvA9XxccqMt+4Vuojxdl7uuosflezmmpVPlpGclqM
   9J1JZTloWNf6FKheVKoB+2SL1+GgA6XO9X3YLqVbu++amTreK/uS93C/6
   2wiY3hw35o2xauHhfLRvwuWD+/4sOG2S6hF166g5cIr9PgV2iFq5c0Gfw
   rOhghu4I1ZUZvcq0PgbINt4RAlnxiCyjFEH/p2D0U0EX2e4zoR51r10MX
   rPpj/siW44JZZD5NhdDTGxz6LSt0HyRI8G/vm4r3Ic7RvdJ7qO643Ucjf
   SJERGUN5RpYNT3kfp39fIJC5E0Boog0YEi0nS1GyZ0M+gNZwNNY8M0AqV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="438821903"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="438821903"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 07:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="827867423"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="827867423"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2023 07:24:48 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZuDV-0004lk-2H;
        Sat, 26 Aug 2023 14:24:45 +0000
Date:   Sat, 26 Aug 2023 22:24:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 b2eb6b8e2ae0415205d307574087923e733fb020
Message-ID: <202308262220.BQNDm7Dl-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: b2eb6b8e2ae0415205d307574087923e733fb020  efi/unaccepted: Use ACPI reclaim memory for unaccepted memory table

elapsed time: 3023m

configs tested: 115
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230824   gcc  
arc                  randconfig-r003-20230824   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230824   gcc  
arm                  randconfig-r026-20230824   gcc  
arm                  randconfig-r034-20230824   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230824   clang
arm64                randconfig-r036-20230824   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon               randconfig-001-20230824   clang
hexagon               randconfig-002-20230824   clang
i386                                defconfig   gcc  
i386                 randconfig-r014-20230824   clang
i386                 randconfig-r024-20230824   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230824   gcc  
loongarch            randconfig-r013-20230824   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r012-20230824   gcc  
microblaze           randconfig-r022-20230824   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230824   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r002-20230824   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r015-20230824   clang
powerpc              randconfig-r031-20230824   gcc  
powerpc64            randconfig-r001-20230824   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230824   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230824   clang
s390                 randconfig-r023-20230824   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r005-20230824   gcc  
sh                   randconfig-r016-20230824   gcc  
sh                   randconfig-r025-20230824   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230824   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r035-20230824   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r006-20230824   clang
um                   randconfig-r033-20230824   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r004-20230824   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
