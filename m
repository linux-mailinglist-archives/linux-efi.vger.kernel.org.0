Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998D76BE874
	for <lists+linux-efi@lfdr.de>; Fri, 17 Mar 2023 12:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCQLlH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Mar 2023 07:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCQLlG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Mar 2023 07:41:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EC53B225
        for <linux-efi@vger.kernel.org>; Fri, 17 Mar 2023 04:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679053230; x=1710589230;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SZ8l2oVvf9iJXS1cQnYaqWeaIRl84CR4sO1JvoVXjWk=;
  b=mpMnn/CB9t6NxaM93aWEkT9WcuVQCXCKYtvmk0BqTFQ2reoq7OI1Oqna
   66X8SZ6JxTQbfGtZ+7xC7SrJReCBzIHxAgr0gP4dop2g/3NknOS00TdEm
   pl6InDJRshAxY9LxXo6boyh1EA5e5z05scsLbsfY3VkNOC+9pGDnZbuMu
   1LUfF0K4GVGxDSUXmKC7JJcjvT9kRjOjIkKqvMV6X/9cRdb3JdvMc68tu
   EZYldEMHCB/v8sfOQF84FRb1YzMVbqyRbh3Rs/Av2gIdcW+4E9oSfws6A
   hdm5A9CIFiWLRtPVdb6NM3ffERIzQrvYepnu//y3Ou/RwOTnh09hYDUYF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="400818631"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="400818631"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 04:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="749224210"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="749224210"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2023 04:39:11 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pd8QL-0009K8-2v;
        Fri, 17 Mar 2023 11:39:05 +0000
Date:   Fri, 17 Mar 2023 19:38:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 03870ad6e047a922e761c07902e41b4ce43e744d
Message-ID: <6414512b.iKA8CGMq3EcQWU70%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 03870ad6e047a922e761c07902e41b4ce43e744d  efi/libstub: smbios: Drop unused 'recsize' parameter

elapsed time: 727m

configs tested: 215
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230313   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230313   gcc  
alpha                randconfig-r005-20230312   gcc  
alpha                randconfig-r006-20230312   gcc  
alpha                randconfig-r006-20230313   gcc  
alpha                randconfig-r021-20230312   gcc  
alpha                randconfig-r024-20230312   gcc  
alpha                randconfig-r032-20230312   gcc  
alpha                randconfig-r034-20230313   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r001-20230313   gcc  
arc                  randconfig-r004-20230312   gcc  
arc                  randconfig-r005-20230313   gcc  
arc                  randconfig-r006-20230313   gcc  
arc                  randconfig-r012-20230312   gcc  
arc                  randconfig-r031-20230312   gcc  
arc                  randconfig-r033-20230312   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                           imxrt_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                  randconfig-r004-20230312   gcc  
arm                  randconfig-r005-20230312   gcc  
arm                  randconfig-r013-20230313   gcc  
arm                  randconfig-r016-20230313   gcc  
arm                  randconfig-r021-20230313   gcc  
arm                  randconfig-r025-20230313   gcc  
arm                  randconfig-r033-20230313   clang
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230312   clang
arm64                randconfig-r012-20230313   clang
arm64                randconfig-r013-20230312   gcc  
arm64                randconfig-r015-20230312   gcc  
arm64                randconfig-r034-20230313   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230312   gcc  
csky                 randconfig-r004-20230313   gcc  
csky                 randconfig-r005-20230317   gcc  
csky                 randconfig-r013-20230312   gcc  
csky                 randconfig-r023-20230312   gcc  
csky                 randconfig-r031-20230313   gcc  
csky                 randconfig-r032-20230313   gcc  
hexagon              randconfig-r002-20230312   clang
hexagon              randconfig-r016-20230313   clang
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
i386                          randconfig-c001   gcc  
i386                 randconfig-r002-20230313   gcc  
i386                 randconfig-r003-20230313   gcc  
i386                 randconfig-r004-20230313   gcc  
i386                 randconfig-r005-20230313   gcc  
i386                 randconfig-r032-20230313   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230313   gcc  
ia64                 randconfig-r002-20230313   gcc  
ia64                 randconfig-r006-20230313   gcc  
ia64                 randconfig-r011-20230312   gcc  
ia64                 randconfig-r012-20230312   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230317   gcc  
loongarch            randconfig-r003-20230313   gcc  
loongarch            randconfig-r003-20230317   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r006-20230313   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                 randconfig-r002-20230312   gcc  
m68k                 randconfig-r002-20230317   gcc  
m68k                 randconfig-r004-20230312   gcc  
m68k                 randconfig-r004-20230313   gcc  
m68k                 randconfig-r006-20230312   gcc  
m68k                 randconfig-r031-20230313   gcc  
m68k                 randconfig-r035-20230313   gcc  
m68k                           sun3_defconfig   gcc  
microblaze           randconfig-r001-20230312   gcc  
microblaze           randconfig-r001-20230313   gcc  
microblaze           randconfig-r003-20230312   gcc  
microblaze           randconfig-r006-20230312   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                      pic32mzda_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230312   gcc  
nios2                randconfig-r005-20230312   gcc  
nios2                randconfig-r012-20230312   gcc  
nios2                randconfig-r014-20230312   gcc  
nios2                randconfig-r025-20230312   gcc  
nios2                randconfig-r036-20230313   gcc  
openrisc             randconfig-r014-20230313   gcc  
openrisc             randconfig-r021-20230313   gcc  
openrisc             randconfig-r035-20230312   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230312   gcc  
parisc               randconfig-r005-20230313   gcc  
parisc               randconfig-r006-20230313   gcc  
parisc               randconfig-r014-20230312   gcc  
parisc               randconfig-r014-20230313   gcc  
parisc               randconfig-r023-20230313   gcc  
parisc               randconfig-r036-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc              randconfig-r003-20230313   gcc  
powerpc              randconfig-r016-20230312   gcc  
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230313   clang
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230313   clang
s390                 randconfig-r016-20230312   gcc  
s390                 randconfig-r031-20230313   gcc  
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh           buildonly-randconfig-r002-20230313   gcc  
sh                               j2_defconfig   gcc  
sh                   randconfig-r016-20230312   gcc  
sh                   randconfig-r036-20230312   gcc  
sh                              ul2_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230313   gcc  
sparc                randconfig-r002-20230313   gcc  
sparc                randconfig-r014-20230313   gcc  
sparc                randconfig-r015-20230312   gcc  
sparc                randconfig-r015-20230313   gcc  
sparc                randconfig-r016-20230313   gcc  
sparc                randconfig-r023-20230312   gcc  
sparc                randconfig-r033-20230313   gcc  
sparc                randconfig-r035-20230313   gcc  
sparc64              randconfig-r001-20230312   gcc  
sparc64              randconfig-r002-20230312   gcc  
sparc64              randconfig-r004-20230312   gcc  
sparc64              randconfig-r004-20230313   gcc  
sparc64              randconfig-r013-20230312   gcc  
sparc64              randconfig-r022-20230312   gcc  
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
x86_64               randconfig-k001-20230313   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r033-20230313   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230312   gcc  
xtensa               randconfig-r001-20230313   gcc  
xtensa               randconfig-r003-20230312   gcc  
xtensa               randconfig-r005-20230313   gcc  
xtensa               randconfig-r015-20230312   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
