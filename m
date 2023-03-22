Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93836C41B5
	for <lists+linux-efi@lfdr.de>; Wed, 22 Mar 2023 05:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCVEuV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Mar 2023 00:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVEuV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Mar 2023 00:50:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA9E59807
        for <linux-efi@vger.kernel.org>; Tue, 21 Mar 2023 21:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679460620; x=1710996620;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+czlwGvkbCAJBZWojUYe9n9aK6+OXCHkHcBCMH8/PVQ=;
  b=Agqd1vKbM+X6TT/zfa22xlyLZkskaZqFnutvkY7ZLa9flRW/YtrHzKPU
   KYXSAio+k98KDCZByOaOeX1FDOfMLtEOOFlR9EoJ4i+1vx08YaaTlEEpD
   HVbdvhyZeu/qYtI6+raDSIZvibLTx2otyC4zJi6bdIL7x1cMBUaXPYwSs
   ArFZJmiXomKz7b6n+FsayfdVig+VFa0bDSphsOSvJQQ5sr4h5/pT0n+Ma
   upzRUUcqxYxgvjJGtu8klDaswaFU/HiWVZt4jNQYaGyItBtY6EjPITM6W
   RdvtVhRmbjSv9tWdDRJZ94O4UOO7loF0wqLwc/4PYL5PDHrunZEuxPE6o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="340663945"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="340663945"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 21:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="927695471"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="927695471"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Mar 2023 21:50:17 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peqQT-000Ctb-1C;
        Wed, 22 Mar 2023 04:50:17 +0000
Date:   Wed, 22 Mar 2023 12:50:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS bac363715a7c961076e568609a12f62003cd17b0
Message-ID: <641a88fb.4c2lhvxdz6V7tX3E%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: bac363715a7c961076e568609a12f62003cd17b0  efi/libstub: Look for initrd LoadFile2 protocol on image handle

elapsed time: 727m

configs tested: 200
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230320   gcc  
alpha        buildonly-randconfig-r002-20230319   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230319   gcc  
alpha                randconfig-r023-20230319   gcc  
alpha                randconfig-r031-20230319   gcc  
alpha                randconfig-r033-20230319   gcc  
alpha                randconfig-r036-20230319   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230320   gcc  
arc                  randconfig-r043-20230319   gcc  
arc                  randconfig-r043-20230320   gcc  
arc                  randconfig-r043-20230321   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                  randconfig-r046-20230319   gcc  
arm                  randconfig-r046-20230320   clang
arm                  randconfig-r046-20230321   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230319   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r003-20230320   gcc  
csky         buildonly-randconfig-r005-20230319   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230319   gcc  
csky                 randconfig-r005-20230319   gcc  
csky                 randconfig-r006-20230319   gcc  
csky                 randconfig-r022-20230319   gcc  
csky                 randconfig-r035-20230319   gcc  
hexagon                             defconfig   clang
hexagon              randconfig-r003-20230319   clang
hexagon              randconfig-r004-20230320   clang
hexagon              randconfig-r006-20230319   clang
hexagon              randconfig-r022-20230319   clang
hexagon              randconfig-r032-20230319   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r041-20230320   clang
hexagon              randconfig-r041-20230321   clang
hexagon              randconfig-r045-20230319   clang
hexagon              randconfig-r045-20230320   clang
hexagon              randconfig-r045-20230321   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230320   clang
i386                 randconfig-a002-20230320   clang
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230320   clang
i386                 randconfig-a004-20230320   clang
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230320   clang
i386                 randconfig-a006-20230320   clang
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230320   gcc  
i386                          randconfig-a011   clang
i386                 randconfig-a012-20230320   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230320   gcc  
i386                          randconfig-a013   clang
i386                 randconfig-a014-20230320   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230320   gcc  
i386                          randconfig-a015   clang
i386                 randconfig-a016-20230320   gcc  
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230319   gcc  
ia64                 randconfig-r023-20230319   gcc  
ia64                 randconfig-r033-20230319   gcc  
ia64                 randconfig-r036-20230319   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230320   gcc  
loongarch    buildonly-randconfig-r006-20230319   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r026-20230319   gcc  
loongarch            randconfig-r032-20230321   gcc  
loongarch            randconfig-r034-20230319   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230319   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230319   gcc  
m68k                 randconfig-r026-20230319   gcc  
microblaze   buildonly-randconfig-r005-20230320   gcc  
microblaze           randconfig-r014-20230319   gcc  
microblaze           randconfig-r015-20230319   gcc  
microblaze           randconfig-r024-20230319   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                 randconfig-r002-20230319   clang
mips                 randconfig-r026-20230319   gcc  
mips                        vocore2_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230319   gcc  
nios2                randconfig-r004-20230319   gcc  
nios2                randconfig-r016-20230320   gcc  
nios2                randconfig-r034-20230319   gcc  
nios2                randconfig-r034-20230321   gcc  
nios2                randconfig-r035-20230319   gcc  
openrisc     buildonly-randconfig-r002-20230319   gcc  
openrisc             randconfig-r001-20230319   gcc  
openrisc             randconfig-r011-20230319   gcc  
openrisc             randconfig-r021-20230319   gcc  
openrisc             randconfig-r024-20230319   gcc  
openrisc             randconfig-r025-20230319   gcc  
openrisc             randconfig-r033-20230321   gcc  
parisc       buildonly-randconfig-r003-20230319   gcc  
parisc       buildonly-randconfig-r004-20230319   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230319   gcc  
parisc               randconfig-r014-20230320   gcc  
parisc               randconfig-r022-20230319   gcc  
parisc               randconfig-r025-20230319   gcc  
parisc               randconfig-r031-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230319   clang
powerpc                   microwatt_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc              randconfig-r002-20230319   gcc  
powerpc              randconfig-r021-20230319   clang
powerpc              randconfig-r031-20230321   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230320   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230319   gcc  
riscv                randconfig-r006-20230319   gcc  
riscv                randconfig-r042-20230319   clang
riscv                randconfig-r042-20230320   gcc  
riscv                randconfig-r042-20230321   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230319   clang
s390         buildonly-randconfig-r006-20230320   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r023-20230319   clang
s390                 randconfig-r044-20230319   clang
s390                 randconfig-r044-20230320   gcc  
s390                 randconfig-r044-20230321   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230319   gcc  
sh                   randconfig-r011-20230319   gcc  
sh                   randconfig-r011-20230320   gcc  
sh                   randconfig-r013-20230319   gcc  
sh                   randconfig-r021-20230319   gcc  
sparc        buildonly-randconfig-r002-20230320   gcc  
sparc        buildonly-randconfig-r006-20230319   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230319   gcc  
sparc                randconfig-r012-20230319   gcc  
sparc                randconfig-r021-20230319   gcc  
sparc                randconfig-r032-20230319   gcc  
sparc                       sparc32_defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230320   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230320   clang
x86_64               randconfig-a003-20230320   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230320   clang
x86_64               randconfig-a005-20230320   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230320   clang
x86_64               randconfig-a011-20230320   gcc  
x86_64               randconfig-a012-20230320   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230320   gcc  
x86_64               randconfig-a014-20230320   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230320   gcc  
x86_64               randconfig-a016-20230320   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r006-20230320   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa       buildonly-randconfig-r006-20230320   gcc  
xtensa               randconfig-r001-20230319   gcc  
xtensa               randconfig-r013-20230319   gcc  
xtensa               randconfig-r015-20230319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
