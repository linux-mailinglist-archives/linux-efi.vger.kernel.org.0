Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548256A78A8
	for <lists+linux-efi@lfdr.de>; Thu,  2 Mar 2023 02:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCBBCD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Mar 2023 20:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBBCD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Mar 2023 20:02:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E414ECFC
        for <linux-efi@vger.kernel.org>; Wed,  1 Mar 2023 17:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677718922; x=1709254922;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cP83i39nIdG3DTaAq4evScPp3MvYMGsJBnd54m/OxDE=;
  b=McCVTKA5MXLxFoiST6wockRwA6fv3rLBFnAldxNBLIDl0aRBIgUFLPH2
   BdH5erQ9Jej3b1fUCE2E1p6XEBcSfPmIaOAxZtkOrVUPDbermMFpCYVjM
   8L1l8Vot6W3MTQ+AJQfatp9ZNPkFHnkwhxSp8ApvlGEW2PlBwBmY0tijb
   BtARxGjzNITHk6t9Qg8uYdU2pDalc5+w0UXNU2dLejay9LQCJ4PUJBMI4
   EVS/otzYa4p9d7QUzhQyCGHEBhI09Y4UJ1XuDf4LmSJFh39PDyw+yCj7c
   yR8TYQCD0kRY7J1NqHGqHIKWhAx8yPsf7Z67+kjrcjNiet4b30ADveej0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="314242767"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="314242767"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="743634461"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="743634461"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2023 17:01:53 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXXKS-00001f-2R;
        Thu, 02 Mar 2023 01:01:52 +0000
Date:   Thu, 02 Mar 2023 09:00:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 112fd39a2722e1e872f1d30101aa2cca4de5ea86
Message-ID: <63fff545.+i5Pu+sZTlnl6CEv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 112fd39a2722e1e872f1d30101aa2cca4de5ea86  efi: libstub: Drop Altra quirk and SMBIOS handling

elapsed time: 729m

configs tested: 102
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230302   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230302   gcc  
alpha                randconfig-r036-20230302   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230302   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230302   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r031-20230302   clang
arm                  randconfig-r046-20230302   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230301   gcc  
arm64                randconfig-r022-20230302   clang
arm64                randconfig-r034-20230302   gcc  
csky         buildonly-randconfig-r005-20230302   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r032-20230301   gcc  
hexagon              randconfig-r041-20230302   clang
hexagon              randconfig-r045-20230302   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230227   clang
i386                 randconfig-a002-20230227   clang
i386                 randconfig-a003-20230227   clang
i386                 randconfig-a004-20230227   clang
i386                 randconfig-a005-20230227   clang
i386                 randconfig-a006-20230227   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230302   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230302   gcc  
loongarch            randconfig-r016-20230301   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230302   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r035-20230302   gcc  
microblaze           randconfig-r026-20230302   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230301   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r032-20230302   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230302   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230302   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230301   gcc  
s390                 randconfig-r044-20230302   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r006-20230302   gcc  
sh                   randconfig-r021-20230302   gcc  
sh                   randconfig-r023-20230302   gcc  
sh                   randconfig-r025-20230302   gcc  
sparc        buildonly-randconfig-r006-20230302   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r024-20230302   gcc  
sparc64              randconfig-r004-20230302   gcc  
sparc64              randconfig-r011-20230301   gcc  
sparc64              randconfig-r013-20230301   gcc  
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
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
