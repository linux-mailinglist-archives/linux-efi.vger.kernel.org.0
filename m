Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C8070CA89
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 22:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjEVUOW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjEVUOS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 16:14:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553FA9
        for <linux-efi@vger.kernel.org>; Mon, 22 May 2023 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684786457; x=1716322457;
  h=date:from:to:cc:subject:message-id;
  bh=/GfF7XU4CHFgQqhJGb2bqDl3rav/6cm3qY2LDQDoUos=;
  b=SyOcwBX+sS+H7CmFgpPlvDw1HJib1tJ3rQ60fhRe4J8eCOUG5pSoDX86
   JJjZlxv6WoPlGYZLU+xVFe/M/TGiK3uFZd27XosXyPR96AD+yE3jYcCYU
   4uQp7EJm8Si9EJtrxR2MWhMXmUpMFQxW7QBOrYGFse84pFB6if3gbJGon
   NJP3dZL+y9XswgxbzrjVEsHejVGzr5vlBPHztv3DI5awIkLLh0TQswf3g
   Q00jByOKzQFjgrldOucLFWxjKjAslJUCUd9KVti1e8+wMjOhnScVnO9ac
   ahUvNyrFPjPg08s3gx71YVF5xcOUvQs9lb3TZdTcwf2v7XiH0M9F+DfdK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="355379359"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="355379359"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 13:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="793456106"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="793456106"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 May 2023 13:14:15 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1Bv5-000D8V-0L;
        Mon, 22 May 2023 20:14:15 +0000
Date:   Tue, 23 May 2023 04:14:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 3610dc36f4fd767c382e5f9b234d19d0610eb950
Message-ID: <20230522201404.08axy%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230522162832/lkp-src/repo/*/efi
https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 3610dc36f4fd767c382e5f9b234d19d0610eb950  efi/libstub: zboot: Avoid eager evaluation of objcopy flags

elapsed time: 760m

configs tested: 222
configs skipped: 21

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230522   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230522   gcc  
alpha                randconfig-r004-20230522   gcc  
alpha                randconfig-r013-20230521   gcc  
alpha                randconfig-r014-20230521   gcc  
alpha                randconfig-r021-20230521   gcc  
alpha                randconfig-r023-20230521   gcc  
alpha                randconfig-r036-20230522   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230522   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230522   gcc  
arc                  randconfig-r006-20230522   gcc  
arc                  randconfig-r013-20230521   gcc  
arc                  randconfig-r014-20230521   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230522   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230521   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230521   clang
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230522   clang
arm64                randconfig-r012-20230521   gcc  
csky         buildonly-randconfig-r001-20230522   gcc  
csky         buildonly-randconfig-r003-20230522   gcc  
csky         buildonly-randconfig-r004-20230522   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230522   gcc  
csky                 randconfig-r012-20230521   gcc  
csky                 randconfig-r022-20230522   gcc  
csky                 randconfig-r024-20230522   gcc  
csky                 randconfig-r026-20230521   gcc  
csky                 randconfig-r035-20230521   gcc  
hexagon      buildonly-randconfig-r003-20230521   clang
hexagon              randconfig-r001-20230521   clang
hexagon              randconfig-r041-20230521   clang
hexagon              randconfig-r041-20230522   clang
hexagon              randconfig-r045-20230521   clang
hexagon              randconfig-r045-20230522   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-a011-20230522   clang
i386                 randconfig-a012-20230522   clang
i386                 randconfig-a013-20230522   clang
i386                 randconfig-a014-20230522   clang
i386                 randconfig-a015-20230522   clang
i386                 randconfig-a016-20230522   clang
i386                 randconfig-r036-20230522   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230522   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r004-20230521   gcc  
ia64                 randconfig-r016-20230521   gcc  
ia64                 randconfig-r023-20230521   gcc  
ia64                          tiger_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230521   gcc  
loongarch            randconfig-r011-20230521   gcc  
loongarch            randconfig-r012-20230522   gcc  
loongarch            randconfig-r022-20230521   gcc  
loongarch            randconfig-r034-20230521   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r005-20230521   gcc  
m68k                 randconfig-r024-20230522   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze           randconfig-r011-20230521   gcc  
microblaze           randconfig-r014-20230522   gcc  
microblaze           randconfig-r034-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                 randconfig-r015-20230521   clang
mips                 randconfig-r031-20230521   gcc  
mips                 randconfig-r032-20230521   gcc  
mips                 randconfig-r036-20230521   gcc  
mips                 randconfig-r036-20230522   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230522   gcc  
nios2                randconfig-r016-20230521   gcc  
nios2                randconfig-r025-20230521   gcc  
nios2                randconfig-r032-20230522   gcc  
openrisc     buildonly-randconfig-r006-20230521   gcc  
openrisc             randconfig-r003-20230522   gcc  
openrisc             randconfig-r006-20230521   gcc  
openrisc             randconfig-r015-20230522   gcc  
openrisc             randconfig-r032-20230521   gcc  
parisc       buildonly-randconfig-r005-20230521   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230522   gcc  
parisc               randconfig-r026-20230521   gcc  
parisc               randconfig-r036-20230521   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230522   clang
powerpc                      chrp32_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc              randconfig-r004-20230522   gcc  
powerpc              randconfig-r012-20230521   gcc  
powerpc              randconfig-r015-20230522   clang
powerpc              randconfig-r032-20230522   gcc  
powerpc              randconfig-r036-20230521   clang
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230521   gcc  
riscv                randconfig-r035-20230521   clang
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230521   clang
s390                 randconfig-r005-20230522   gcc  
s390                 randconfig-r006-20230522   gcc  
s390                 randconfig-r015-20230521   gcc  
s390                 randconfig-r021-20230522   clang
s390                 randconfig-r024-20230521   gcc  
s390                 randconfig-r033-20230522   gcc  
s390                 randconfig-r035-20230522   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230521   gcc  
sh           buildonly-randconfig-r005-20230522   gcc  
sh                               j2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r014-20230522   gcc  
sh                   randconfig-r025-20230522   gcc  
sh                   randconfig-r034-20230522   gcc  
sh                          sdk7786_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230522   gcc  
sparc                randconfig-r022-20230521   gcc  
sparc                randconfig-r023-20230522   gcc  
sparc                randconfig-r026-20230522   gcc  
sparc                randconfig-r033-20230521   gcc  
sparc                randconfig-r034-20230522   gcc  
sparc                randconfig-r035-20230522   gcc  
sparc64              randconfig-r002-20230521   gcc  
sparc64              randconfig-r002-20230522   gcc  
sparc64              randconfig-r006-20230521   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64               randconfig-a012-20230522   clang
x86_64               randconfig-a013-20230522   clang
x86_64               randconfig-a014-20230522   clang
x86_64               randconfig-a015-20230522   clang
x86_64               randconfig-a016-20230522   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64               randconfig-x071-20230522   gcc  
x86_64               randconfig-x072-20230522   gcc  
x86_64               randconfig-x073-20230522   gcc  
x86_64               randconfig-x074-20230522   gcc  
x86_64               randconfig-x075-20230522   gcc  
x86_64               randconfig-x076-20230522   gcc  
x86_64               randconfig-x081-20230522   gcc  
x86_64               randconfig-x082-20230522   gcc  
x86_64               randconfig-x083-20230522   gcc  
x86_64               randconfig-x084-20230522   gcc  
x86_64               randconfig-x085-20230522   gcc  
x86_64               randconfig-x086-20230522   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r013-20230521   gcc  
xtensa               randconfig-r031-20230522   gcc  
xtensa               randconfig-r033-20230521   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
