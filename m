Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984546BFD6E
	for <lists+linux-efi@lfdr.de>; Sun, 19 Mar 2023 00:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCRXRB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Mar 2023 19:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRXRA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 Mar 2023 19:17:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861D286A3
        for <linux-efi@vger.kernel.org>; Sat, 18 Mar 2023 16:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679181418; x=1710717418;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=K3pHgn5WmYPWdJ/0FbZPhDKNa5piNj6rMW824vkhKxM=;
  b=YOak/75uZvgPmJBCowclZHohyhv1iV4HMzEe4iVJ4tuF4rnbd9jpcbHo
   joKwJpOfXE0KuaR8ZobjjrLERrJZv8+xB9OnIvWUIAdtxFhtyeLfHduh1
   XtT3NxriQcqcBCsCgnZxkeUCjCvjdVCswQTwpM52tikNrphSN3iDyTF50
   7V4pnT4XUrbSG40A4EEV04YACPFxDByNkcV5aA/HqUaiVMnkAJ9UZxxKi
   iDqtB2W0EoLXrx8ApmHyuQMZ7lQ7R15r29xkOt7FAezQPupVlvtMgVyQG
   LnsgL8BlZ7zivek5emlDn/H0OCIieOFIPWxpVZHt4Iprt31Zenhi+si7U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="424744416"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="424744416"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 16:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="683052946"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="683052946"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Mar 2023 16:16:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdfnE-000AIv-1F;
        Sat, 18 Mar 2023 23:16:56 +0000
Date:   Sun, 19 Mar 2023 07:16:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 1ca8f339d8693884feb0e14d2905f4b05418640b
Message-ID: <6416465b.BsMzYmaFIT5gLoAI%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 1ca8f339d8693884feb0e14d2905f4b05418640b  efi: libstub: Look for initrd LoadFile2 protocol on image handle

elapsed time: 722m

configs tested: 315
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230313   gcc  
alpha        buildonly-randconfig-r002-20230313   gcc  
alpha        buildonly-randconfig-r002-20230319   gcc  
alpha        buildonly-randconfig-r004-20230313   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230313   gcc  
alpha                randconfig-r016-20230312   gcc  
alpha                randconfig-r016-20230313   gcc  
alpha                randconfig-r021-20230313   gcc  
alpha                randconfig-r026-20230313   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc          buildonly-randconfig-r002-20230313   gcc  
arc          buildonly-randconfig-r004-20230312   gcc  
arc          buildonly-randconfig-r005-20230313   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r006-20230313   gcc  
arc                  randconfig-r014-20230312   gcc  
arc                  randconfig-r022-20230313   gcc  
arc                  randconfig-r024-20230313   gcc  
arc                  randconfig-r026-20230312   gcc  
arc                  randconfig-r031-20230312   gcc  
arc                  randconfig-r034-20230312   gcc  
arc                  randconfig-r035-20230319   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arc                  randconfig-r043-20230318   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                         bcm2835_defconfig   clang
arm          buildonly-randconfig-r004-20230313   gcc  
arm          buildonly-randconfig-r005-20230313   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                  randconfig-r001-20230312   gcc  
arm                  randconfig-r003-20230313   clang
arm                  randconfig-r011-20230312   clang
arm                  randconfig-r036-20230312   gcc  
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm                  randconfig-r046-20230318   clang
arm                       spear13xx_defconfig   clang
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230313   gcc  
arm64                randconfig-r034-20230313   gcc  
csky         buildonly-randconfig-r005-20230313   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230312   gcc  
csky                 randconfig-r006-20230319   gcc  
csky                 randconfig-r014-20230313   gcc  
csky                 randconfig-r025-20230312   gcc  
csky                 randconfig-r026-20230312   gcc  
csky                 randconfig-r035-20230312   gcc  
hexagon      buildonly-randconfig-r001-20230319   clang
hexagon      buildonly-randconfig-r003-20230319   clang
hexagon      buildonly-randconfig-r006-20230319   clang
hexagon              randconfig-r013-20230312   clang
hexagon              randconfig-r023-20230312   clang
hexagon              randconfig-r033-20230312   clang
hexagon              randconfig-r035-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r041-20230318   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
hexagon              randconfig-r045-20230318   clang
hexagon              randconfig-r045-20230319   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
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
i386                 randconfig-r004-20230313   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230313   gcc  
ia64         buildonly-randconfig-r002-20230312   gcc  
ia64         buildonly-randconfig-r003-20230313   gcc  
ia64         buildonly-randconfig-r005-20230312   gcc  
ia64         buildonly-randconfig-r006-20230312   gcc  
ia64                                defconfig   gcc  
ia64                        generic_defconfig   gcc  
ia64                 randconfig-r006-20230313   gcc  
ia64                 randconfig-r013-20230313   gcc  
ia64                 randconfig-r014-20230312   gcc  
ia64                 randconfig-r015-20230313   gcc  
ia64                 randconfig-r016-20230313   gcc  
ia64                 randconfig-r022-20230312   gcc  
ia64                 randconfig-r032-20230313   gcc  
ia64                 randconfig-r033-20230319   gcc  
ia64                 randconfig-r036-20230313   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230313   gcc  
loongarch    buildonly-randconfig-r005-20230312   gcc  
loongarch    buildonly-randconfig-r006-20230313   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230313   gcc  
loongarch            randconfig-r022-20230312   gcc  
loongarch            randconfig-r024-20230312   gcc  
loongarch            randconfig-r031-20230313   gcc  
loongarch            randconfig-r036-20230313   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230319   gcc  
m68k         buildonly-randconfig-r006-20230313   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230313   gcc  
m68k                 randconfig-r013-20230312   gcc  
m68k                 randconfig-r033-20230313   gcc  
m68k                 randconfig-r034-20230313   gcc  
microblaze   buildonly-randconfig-r002-20230312   gcc  
microblaze   buildonly-randconfig-r002-20230313   gcc  
microblaze           randconfig-r003-20230312   gcc  
microblaze           randconfig-r005-20230312   gcc  
microblaze           randconfig-r023-20230312   gcc  
microblaze           randconfig-r025-20230312   gcc  
microblaze           randconfig-r032-20230312   gcc  
microblaze           randconfig-r034-20230312   gcc  
microblaze           randconfig-r036-20230313   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230319   clang
mips         buildonly-randconfig-r003-20230312   gcc  
mips         buildonly-randconfig-r005-20230319   clang
mips                         db1xxx_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                 randconfig-r023-20230313   gcc  
mips                 randconfig-r026-20230319   gcc  
mips                 randconfig-r031-20230313   clang
nios2        buildonly-randconfig-r001-20230313   gcc  
nios2        buildonly-randconfig-r003-20230312   gcc  
nios2        buildonly-randconfig-r005-20230313   gcc  
nios2        buildonly-randconfig-r006-20230313   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230313   gcc  
nios2                randconfig-r005-20230312   gcc  
nios2                randconfig-r013-20230312   gcc  
nios2                randconfig-r032-20230312   gcc  
nios2                randconfig-r036-20230312   gcc  
nios2                randconfig-r036-20230319   gcc  
openrisc                         alldefconfig   gcc  
openrisc             randconfig-r015-20230312   gcc  
openrisc             randconfig-r021-20230319   gcc  
openrisc             randconfig-r024-20230319   gcc  
openrisc             randconfig-r025-20230319   gcc  
openrisc             randconfig-r031-20230312   gcc  
openrisc             randconfig-r032-20230312   gcc  
openrisc             randconfig-r034-20230313   gcc  
openrisc             randconfig-r035-20230313   gcc  
openrisc             randconfig-r035-20230319   gcc  
openrisc             randconfig-r036-20230312   gcc  
parisc       buildonly-randconfig-r004-20230319   gcc  
parisc       buildonly-randconfig-r006-20230313   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r002-20230312   gcc  
parisc               randconfig-r005-20230313   gcc  
parisc               randconfig-r021-20230312   gcc  
parisc               randconfig-r022-20230319   gcc  
parisc               randconfig-r026-20230313   gcc  
parisc               randconfig-r031-20230313   gcc  
parisc               randconfig-r033-20230312   gcc  
parisc               randconfig-r033-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230312   gcc  
powerpc      buildonly-randconfig-r002-20230319   clang
powerpc      buildonly-randconfig-r003-20230319   clang
powerpc      buildonly-randconfig-r005-20230312   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r002-20230319   gcc  
powerpc              randconfig-r011-20230312   gcc  
powerpc              randconfig-r012-20230312   gcc  
powerpc              randconfig-r032-20230319   gcc  
powerpc              randconfig-r033-20230313   gcc  
powerpc              randconfig-r034-20230319   gcc  
powerpc              randconfig-r035-20230313   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230319   clang
riscv        buildonly-randconfig-r004-20230312   gcc  
riscv        buildonly-randconfig-r004-20230319   clang
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r005-20230313   gcc  
riscv                randconfig-r005-20230318   clang
riscv                randconfig-r005-20230319   gcc  
riscv                randconfig-r006-20230312   clang
riscv                randconfig-r012-20230313   clang
riscv                randconfig-r016-20230319   clang
riscv                randconfig-r024-20230312   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                randconfig-r042-20230318   gcc  
riscv                randconfig-r042-20230319   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230312   gcc  
s390         buildonly-randconfig-r002-20230312   gcc  
s390         buildonly-randconfig-r003-20230312   gcc  
s390         buildonly-randconfig-r005-20230319   clang
s390         buildonly-randconfig-r006-20230312   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230313   gcc  
s390                 randconfig-r021-20230312   gcc  
s390                 randconfig-r024-20230313   clang
s390                 randconfig-r025-20230312   gcc  
s390                 randconfig-r032-20230313   gcc  
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
s390                 randconfig-r044-20230318   gcc  
s390                 randconfig-r044-20230319   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230313   gcc  
sh           buildonly-randconfig-r003-20230313   gcc  
sh           buildonly-randconfig-r003-20230319   gcc  
sh           buildonly-randconfig-r005-20230312   gcc  
sh           buildonly-randconfig-r005-20230313   gcc  
sh           buildonly-randconfig-r006-20230312   gcc  
sh                               j2_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r016-20230312   gcc  
sh                   randconfig-r022-20230313   gcc  
sh                   randconfig-r023-20230313   gcc  
sh                   randconfig-r031-20230319   gcc  
sh                   randconfig-r032-20230319   gcc  
sh                   randconfig-r035-20230312   gcc  
sh                           se7712_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230312   gcc  
sparc        buildonly-randconfig-r003-20230313   gcc  
sparc        buildonly-randconfig-r004-20230313   gcc  
sparc        buildonly-randconfig-r006-20230319   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230313   gcc  
sparc                randconfig-r011-20230313   gcc  
sparc                randconfig-r025-20230313   gcc  
sparc                randconfig-r031-20230319   gcc  
sparc64      buildonly-randconfig-r001-20230312   gcc  
sparc64      buildonly-randconfig-r002-20230313   gcc  
sparc64      buildonly-randconfig-r003-20230312   gcc  
sparc64      buildonly-randconfig-r003-20230313   gcc  
sparc64              randconfig-r004-20230312   gcc  
sparc64              randconfig-r013-20230313   gcc  
sparc64              randconfig-r014-20230312   gcc  
sparc64              randconfig-r014-20230313   gcc  
sparc64              randconfig-r015-20230312   gcc  
sparc64              randconfig-r021-20230313   gcc  
sparc64              randconfig-r025-20230313   gcc  
sparc64              randconfig-r034-20230312   gcc  
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
x86_64               randconfig-r022-20230313   clang
x86_64               randconfig-r026-20230313   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230312   gcc  
xtensa       buildonly-randconfig-r004-20230312   gcc  
xtensa               randconfig-r001-20230312   gcc  
xtensa               randconfig-r001-20230313   gcc  
xtensa               randconfig-r003-20230312   gcc  
xtensa               randconfig-r011-20230312   gcc  
xtensa               randconfig-r015-20230313   gcc  
xtensa               randconfig-r023-20230312   gcc  
xtensa               randconfig-r032-20230313   gcc  
xtensa               randconfig-r033-20230319   gcc  
xtensa               randconfig-r036-20230319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
