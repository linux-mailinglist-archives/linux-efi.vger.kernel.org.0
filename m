Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45F26A686B
	for <lists+linux-efi@lfdr.de>; Wed,  1 Mar 2023 08:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCAHxO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Mar 2023 02:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAHxN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Mar 2023 02:53:13 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916F1588A
        for <linux-efi@vger.kernel.org>; Tue, 28 Feb 2023 23:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677657192; x=1709193192;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AZ6Bm1vmIQHk2fnUitEBCmRhlD7sTPsnNKUbIbJfwCA=;
  b=T93iO4pWtoNiB95DQOox2/6xaBOiaHCawlpzW6Hz+K3MShjtzcBuYaOf
   02R7oWhynW6zBp2KScTLIY5JfRcxKQU5bki5LTVXN4+ba0yygaMDPANbg
   y/N58tY0yEK01lOox4gO1gjsm6LrU2FN7jwCWJfuNBcTXRKDGozTKVyD4
   pkhj7/mbkmCOUdKZOZd03Ju0rRLpWRylV3TarR2VpqmqllVRUmWb2yeQ/
   PuuYeGTRCHudeCQHhftbnRGEa2Z0NPiXbqeBPcgpgBiLSZFAJZJRS2vpy
   BHRd0iwDP0aQXCCi25eEFSjulLRWgzLx0CeAjx0V32PJnszAqE5w07oNM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="331826980"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="331826980"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 23:53:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="667754590"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="667754590"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2023 23:53:10 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXHGv-000609-2H;
        Wed, 01 Mar 2023 07:53:09 +0000
Date:   Wed, 01 Mar 2023 15:52:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 5aed793ff011549535e20b7b15bc705e828223b1
Message-ID: <63ff0458.xuYQ/kTif5Mu/eHk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 5aed793ff011549535e20b7b15bc705e828223b1  efi/libstub: smbios: Drop unused 'recsize' parameter

elapsed time: 724m

configs tested: 129
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230227   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230227   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r021-20230226   gcc  
arc                  randconfig-r033-20230226   gcc  
arc                  randconfig-r034-20230226   gcc  
arc                  randconfig-r035-20230226   gcc  
arc                  randconfig-r043-20230226   gcc  
arc                  randconfig-r043-20230227   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230227   clang
arm                                 defconfig   gcc  
arm                  randconfig-r031-20230227   gcc  
arm                  randconfig-r046-20230226   gcc  
arm                  randconfig-r046-20230227   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230227   clang
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230226   clang
csky         buildonly-randconfig-r003-20230227   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230227   gcc  
csky                 randconfig-r014-20230226   gcc  
csky                 randconfig-r014-20230227   gcc  
csky                 randconfig-r015-20230227   gcc  
csky                 randconfig-r016-20230227   gcc  
csky                 randconfig-r023-20230227   gcc  
csky                 randconfig-r035-20230227   gcc  
hexagon      buildonly-randconfig-r001-20230226   clang
hexagon              randconfig-r011-20230227   clang
hexagon              randconfig-r015-20230226   clang
hexagon              randconfig-r024-20230227   clang
hexagon              randconfig-r041-20230226   clang
hexagon              randconfig-r041-20230227   clang
hexagon              randconfig-r045-20230226   clang
hexagon              randconfig-r045-20230227   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230227   clang
i386                 randconfig-a002-20230227   clang
i386                 randconfig-a003-20230227   clang
i386                 randconfig-a004-20230227   clang
i386                 randconfig-a005-20230227   clang
i386                 randconfig-a006-20230227   clang
i386                 randconfig-a011-20230227   gcc  
i386                 randconfig-a012-20230227   gcc  
i386                 randconfig-a013-20230227   gcc  
i386                 randconfig-a014-20230227   gcc  
i386                 randconfig-a015-20230227   gcc  
i386                 randconfig-a016-20230227   gcc  
i386                 randconfig-r001-20230227   clang
i386                 randconfig-r033-20230227   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230226   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230227   gcc  
ia64                 randconfig-r022-20230227   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230226   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230227   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230226   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230227   gcc  
m68k                 randconfig-r025-20230227   gcc  
microblaze   buildonly-randconfig-r006-20230227   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230226   gcc  
mips                 randconfig-r032-20230227   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230226   gcc  
nios2                randconfig-r032-20230226   gcc  
openrisc     buildonly-randconfig-r002-20230227   gcc  
openrisc             randconfig-r006-20230227   gcc  
openrisc             randconfig-r016-20230226   gcc  
openrisc             randconfig-r026-20230226   gcc  
openrisc             randconfig-r036-20230226   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r025-20230226   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r022-20230226   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230226   clang
riscv                               defconfig   gcc  
riscv                randconfig-r031-20230226   gcc  
riscv                randconfig-r042-20230226   clang
riscv                randconfig-r042-20230227   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230226   clang
s390                 randconfig-r044-20230227   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r013-20230227   gcc  
sh                   randconfig-r036-20230227   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r004-20230226   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230227   clang
x86_64               randconfig-a002-20230227   clang
x86_64               randconfig-a003-20230227   clang
x86_64               randconfig-a004-20230227   clang
x86_64               randconfig-a005-20230227   clang
x86_64               randconfig-a006-20230227   clang
x86_64               randconfig-a011-20230227   gcc  
x86_64               randconfig-a012-20230227   gcc  
x86_64               randconfig-a013-20230227   gcc  
x86_64               randconfig-a014-20230227   gcc  
x86_64               randconfig-a015-20230227   gcc  
x86_64               randconfig-a016-20230227   gcc  
x86_64               randconfig-r005-20230227   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
