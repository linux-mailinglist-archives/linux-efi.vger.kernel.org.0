Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD7B73F08C
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jun 2023 03:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjF0BbC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jun 2023 21:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjF0Bax (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Jun 2023 21:30:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF17173A
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 18:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687829449; x=1719365449;
  h=date:from:to:cc:subject:message-id;
  bh=QwAbZBRW/8ljOwc4jt3A373wq7kwacbVsuu++hJnkIg=;
  b=GFPrBqjLvyBlHi6DPSWVvc4xxKDxlOVjwKUJ8lNvj7oWVaYbH2w3kfAo
   gYNh00UB32Tf7Gi95jztfTAqPIvUiUKqpLNdSFdiBS91m2xNjZOSd/ljQ
   ZzBa3JANxD3Kb5tZoe/PJXpuI0f4jJrppflFfAmfnkL1vIAVUt/TeDC9u
   fV6/sbNYpd1/2rxCo6wom429WRCtqwCzF8BnuiZpWX9uYz+/fbOgEvXR0
   dI4Mmmh2tHRZUaDKpNdhsZZp4/cxo0IpLYhlc3HHWtci6R/AV1NqBzXQo
   s25U/6fiBlU0/jaVROQfYcP10cFy8e2VWE1g1TuGYFDtC9qrNi9ArEyma
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="364890157"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="364890157"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="716355104"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="716355104"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Jun 2023 18:30:47 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxXa-000BZV-2Z;
        Tue, 27 Jun 2023 01:30:46 +0000
Date:   Tue, 27 Jun 2023 09:30:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 36e60c0bb7d29e755e58136f8531708932838f3d
Message-ID: <202306270927.QSiuBL5p-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 36e60c0bb7d29e755e58136f8531708932838f3d  efivarfs: Expose RandomSeed variable but with limited permissions

elapsed time: 2342m

configs tested: 143
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r043-20230625   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                       netwinder_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r012-20230625   gcc  
arm                  randconfig-r014-20230625   gcc  
arm                  randconfig-r034-20230625   clang
arm                  randconfig-r046-20230625   gcc  
arm                         s5pv210_defconfig   clang
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230625   gcc  
arm64                randconfig-r022-20230625   clang
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230625   gcc  
hexagon              randconfig-r005-20230625   clang
hexagon              randconfig-r041-20230625   clang
hexagon              randconfig-r045-20230625   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230625   gcc  
i386         buildonly-randconfig-r005-20230625   gcc  
i386         buildonly-randconfig-r006-20230625   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230625   gcc  
i386                 randconfig-i002-20230625   gcc  
i386                 randconfig-i003-20230625   gcc  
i386                 randconfig-i004-20230625   gcc  
i386                 randconfig-i005-20230625   gcc  
i386                 randconfig-i006-20230625   gcc  
i386                 randconfig-i011-20230625   clang
i386                 randconfig-i012-20230625   clang
i386                 randconfig-i013-20230625   clang
i386                 randconfig-i014-20230625   clang
i386                 randconfig-i015-20230625   clang
i386                 randconfig-i016-20230625   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r032-20230625   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r025-20230625   gcc  
m68k                 randconfig-r035-20230625   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r021-20230625   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson2k_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                 randconfig-r006-20230625   clang
mips                 randconfig-r033-20230625   clang
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r004-20230625   gcc  
openrisc             randconfig-r015-20230625   gcc  
openrisc             randconfig-r036-20230625   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r002-20230625   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc                     redwood_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230625   gcc  
riscv                randconfig-r042-20230625   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230625   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230625   gcc  
sparc                randconfig-r031-20230625   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230625   gcc  
x86_64       buildonly-randconfig-r002-20230625   gcc  
x86_64       buildonly-randconfig-r003-20230625   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r026-20230625   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r016-20230625   gcc  
xtensa               randconfig-r024-20230625   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
