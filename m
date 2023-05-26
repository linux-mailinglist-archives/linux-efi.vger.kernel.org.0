Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60CE711CE6
	for <lists+linux-efi@lfdr.de>; Fri, 26 May 2023 03:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjEZBmo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 May 2023 21:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjEZBmn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 May 2023 21:42:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A26618D
        for <linux-efi@vger.kernel.org>; Thu, 25 May 2023 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685065362; x=1716601362;
  h=date:from:to:cc:subject:message-id;
  bh=e4Ydh+6uhGB6gls0rPpdb7eaBEhNR7r8ktIZhjERqBM=;
  b=ewaXIq//zR1a/8f6ZHtxr2lhonYlGmrO2GyhszI1LnFRvOpJmx09I872
   91H1RqIQpTIUesoLXqXlfLz6YJiNy/5ioC/BqcxhKVv7RGUPFB1RSabqF
   z4aWT77uvJhKAfAgGy90Q0HqQW9C13UZEuNWZmAYesslJUz3ARRjBKmOE
   4b6cK6SfqEqqpkEEqKbwTkrnRYC7EriQrd5SyTfjzDNujv7tvvefvMCTF
   C1zoK204pv4YFnTZjI2yNWwd7JtVl6WzZXcZ5PFHoGor+lv1H6amPQDye
   k2jzRUTln94haPvGotL55swKN7XVhjQ8nO7Uu6tiM+sB81x07qs/XCxZa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="417569585"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="417569585"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 18:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="794910452"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="794910452"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 May 2023 18:42:40 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2MTX-000HXH-2n;
        Fri, 26 May 2023 01:42:39 +0000
Date:   Fri, 26 May 2023 09:41:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 fd936fd8ac105ba3eb764185e8ba483c789c893e
Message-ID: <20230526014145.EoZGw%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: fd936fd8ac105ba3eb764185e8ba483c789c893e  efi: fix missing prototype warnings

elapsed time: 1044m

configs tested: 228
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc          buildonly-randconfig-r003-20230524   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r005-20230525   gcc  
arc                  randconfig-r043-20230524   gcc  
arc                  randconfig-r043-20230525   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                  randconfig-r021-20230525   clang
arm                  randconfig-r046-20230524   gcc  
arm                           sama5_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230524   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r036-20230524   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230525   gcc  
csky                 randconfig-r013-20230524   gcc  
hexagon              randconfig-r003-20230525   clang
hexagon              randconfig-r004-20230525   clang
hexagon              randconfig-r022-20230525   clang
hexagon              randconfig-r041-20230524   clang
hexagon              randconfig-r045-20230524   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230525   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230524   gcc  
i386                 randconfig-i001-20230525   clang
i386                 randconfig-i002-20230524   gcc  
i386                 randconfig-i002-20230525   clang
i386                 randconfig-i003-20230524   gcc  
i386                 randconfig-i003-20230525   clang
i386                 randconfig-i004-20230524   gcc  
i386                 randconfig-i004-20230525   clang
i386                 randconfig-i005-20230524   gcc  
i386                 randconfig-i005-20230525   clang
i386                 randconfig-i006-20230524   gcc  
i386                 randconfig-i006-20230525   clang
i386                 randconfig-i011-20230524   clang
i386                 randconfig-i011-20230525   gcc  
i386                 randconfig-i012-20230524   clang
i386                 randconfig-i012-20230525   gcc  
i386                 randconfig-i013-20230524   clang
i386                 randconfig-i013-20230525   gcc  
i386                 randconfig-i014-20230524   clang
i386                 randconfig-i014-20230525   gcc  
i386                 randconfig-i015-20230524   clang
i386                 randconfig-i015-20230525   gcc  
i386                 randconfig-i016-20230524   clang
i386                 randconfig-i016-20230525   gcc  
i386                 randconfig-i051-20230524   gcc  
i386                 randconfig-i051-20230525   clang
i386                 randconfig-i052-20230524   gcc  
i386                 randconfig-i052-20230525   clang
i386                 randconfig-i053-20230524   gcc  
i386                 randconfig-i053-20230525   clang
i386                 randconfig-i054-20230524   gcc  
i386                 randconfig-i054-20230525   clang
i386                 randconfig-i055-20230525   clang
i386                 randconfig-i056-20230525   clang
i386                 randconfig-i061-20230524   gcc  
i386                 randconfig-i061-20230525   clang
i386                 randconfig-i062-20230524   gcc  
i386                 randconfig-i062-20230525   clang
i386                 randconfig-i063-20230524   gcc  
i386                 randconfig-i063-20230525   clang
i386                 randconfig-i064-20230524   gcc  
i386                 randconfig-i064-20230525   clang
i386                 randconfig-i065-20230524   gcc  
i386                 randconfig-i065-20230525   clang
i386                 randconfig-i066-20230524   gcc  
i386                 randconfig-i066-20230525   clang
i386                 randconfig-i071-20230524   clang
i386                 randconfig-i071-20230525   gcc  
i386                 randconfig-i072-20230524   clang
i386                 randconfig-i072-20230525   gcc  
i386                 randconfig-i073-20230525   gcc  
i386                 randconfig-i074-20230525   gcc  
i386                 randconfig-i075-20230525   gcc  
i386                 randconfig-i076-20230525   gcc  
i386                 randconfig-i081-20230525   gcc  
i386                 randconfig-i082-20230525   gcc  
i386                 randconfig-i083-20230525   gcc  
i386                 randconfig-i084-20230525   gcc  
i386                 randconfig-i085-20230525   gcc  
i386                 randconfig-i086-20230525   gcc  
i386                 randconfig-i091-20230524   gcc  
i386                 randconfig-i091-20230525   clang
i386                 randconfig-i092-20230524   gcc  
i386                 randconfig-i092-20230525   clang
i386                 randconfig-i093-20230524   gcc  
i386                 randconfig-i093-20230525   clang
i386                 randconfig-i094-20230524   gcc  
i386                 randconfig-i094-20230525   clang
i386                 randconfig-i095-20230524   gcc  
i386                 randconfig-i095-20230525   clang
i386                 randconfig-i096-20230524   gcc  
i386                 randconfig-i096-20230525   clang
ia64         buildonly-randconfig-r005-20230524   gcc  
ia64                 randconfig-r022-20230525   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230525   gcc  
loongarch            randconfig-r026-20230525   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r004-20230525   gcc  
m68k                 randconfig-r032-20230524   gcc  
microblaze           randconfig-r006-20230525   gcc  
microblaze           randconfig-r012-20230524   gcc  
microblaze           randconfig-r015-20230524   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   clang
mips                 randconfig-r025-20230525   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230525   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230525   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230524   clang
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r011-20230524   clang
powerpc              randconfig-r014-20230524   clang
powerpc              randconfig-r033-20230525   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230524   clang
riscv                randconfig-r042-20230525   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r023-20230525   gcc  
s390                 randconfig-r044-20230524   clang
s390                 randconfig-r044-20230525   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230524   gcc  
sh                         ecovec24_defconfig   gcc  
sh                   randconfig-r021-20230525   gcc  
sh                   randconfig-r024-20230525   gcc  
sparc        buildonly-randconfig-r001-20230524   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230524   gcc  
sparc64              randconfig-r002-20230525   gcc  
sparc64              randconfig-r033-20230524   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230525   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230525   clang
x86_64               randconfig-a002-20230525   clang
x86_64               randconfig-a003-20230525   clang
x86_64               randconfig-a004-20230525   clang
x86_64               randconfig-a005-20230525   clang
x86_64               randconfig-a006-20230525   clang
x86_64               randconfig-a011-20230525   gcc  
x86_64               randconfig-a012-20230525   gcc  
x86_64               randconfig-a013-20230525   gcc  
x86_64               randconfig-a014-20230525   gcc  
x86_64               randconfig-a015-20230525   gcc  
x86_64               randconfig-a016-20230525   gcc  
x86_64               randconfig-r015-20230525   gcc  
x86_64               randconfig-r034-20230525   clang
x86_64               randconfig-x051-20230525   gcc  
x86_64               randconfig-x052-20230525   gcc  
x86_64               randconfig-x053-20230525   gcc  
x86_64               randconfig-x054-20230525   gcc  
x86_64               randconfig-x055-20230525   gcc  
x86_64               randconfig-x056-20230525   gcc  
x86_64               randconfig-x061-20230524   clang
x86_64               randconfig-x061-20230525   gcc  
x86_64               randconfig-x062-20230524   clang
x86_64               randconfig-x062-20230525   gcc  
x86_64               randconfig-x063-20230524   clang
x86_64               randconfig-x063-20230525   gcc  
x86_64               randconfig-x064-20230524   clang
x86_64               randconfig-x064-20230525   gcc  
x86_64               randconfig-x065-20230524   clang
x86_64               randconfig-x065-20230525   gcc  
x86_64               randconfig-x066-20230524   clang
x86_64               randconfig-x066-20230525   gcc  
x86_64               randconfig-x071-20230525   clang
x86_64               randconfig-x072-20230525   clang
x86_64               randconfig-x073-20230525   clang
x86_64               randconfig-x074-20230525   clang
x86_64               randconfig-x075-20230525   clang
x86_64               randconfig-x076-20230525   clang
x86_64               randconfig-x081-20230524   gcc  
x86_64               randconfig-x081-20230525   clang
x86_64               randconfig-x082-20230524   gcc  
x86_64               randconfig-x082-20230525   clang
x86_64               randconfig-x083-20230524   gcc  
x86_64               randconfig-x083-20230525   clang
x86_64               randconfig-x084-20230524   gcc  
x86_64               randconfig-x084-20230525   clang
x86_64               randconfig-x085-20230524   gcc  
x86_64               randconfig-x085-20230525   clang
x86_64               randconfig-x086-20230524   gcc  
x86_64               randconfig-x086-20230525   clang
x86_64               randconfig-x091-20230525   gcc  
x86_64               randconfig-x092-20230525   gcc  
x86_64               randconfig-x093-20230525   gcc  
x86_64               randconfig-x094-20230525   gcc  
x86_64               randconfig-x095-20230525   gcc  
x86_64               randconfig-x096-20230525   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230525   gcc  
xtensa               randconfig-r014-20230525   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
