Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED6D6BF6BE
	for <lists+linux-efi@lfdr.de>; Sat, 18 Mar 2023 01:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCRAB2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Mar 2023 20:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCRAB2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Mar 2023 20:01:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0CD2BF0E
        for <linux-efi@vger.kernel.org>; Fri, 17 Mar 2023 17:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679097686; x=1710633686;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6+ywPRzfs6xSAgXMOXhvfd2xQC4tRohSr7UsX2JbYzE=;
  b=QbrrFVxl9m8J2rPyB4USPi2dpp+nzf3mgTo8kXlgWgtCvRTx1TzIl6ox
   P9liirJGnvlftLOj1q6Nsu4KKEafYjgSKCkmWeIEmcQbYrbKZ/DjGRId/
   2ll8nOkv0r5dXvk8eA5lfUJDtlNmJMsY4hSwoHDm2ZTYjSMKpG4PFrsQp
   0OranMml287PbsjMCLfQp+IiRVW1RVcN4qSlz3pM4pWhr2T7U2OoxV1zc
   82J+oPV0MzwVLbNzGQPlYJ4xDnild2sKf+bmgbdDwvxa7eyuU31AZnoMc
   7OAPtvYEvYUIoz0TyoPQ7knpkT1IHAfUA0rIf4FXKDPVwrm1jEmg6C1Om
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="326749167"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="326749167"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 17:01:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="790931002"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="790931002"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Mar 2023 17:01:24 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdK0h-0009fL-2L;
        Sat, 18 Mar 2023 00:01:23 +0000
Date:   Sat, 18 Mar 2023 08:00:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS WITH WARNING
 86237b46f2b202331c07e4c6c2633ce3d3ba7f13
Message-ID: <6414ff2e.HSDXug5IEAMljznE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 86237b46f2b202331c07e4c6c2633ce3d3ba7f13  efi: libstub: Look for initrd LoadFile2 protocol on image handle

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303180324.XvQkFoRV-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/firmware/efi/libstub/efi-stub-helper.c:513:6: warning: variable 'dp' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Unverified Warning (likely false positive, please contact us if interested):

drivers/firmware/efi/libstub/efi-stub-helper.c:528 efi_load_initrd_lf2() error: uninitialized symbol 'dp'.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-m001
    `-- drivers-firmware-efi-libstub-efi-stub-helper.c-efi_load_initrd_lf2()-error:uninitialized-symbol-dp-.
clang_recent_errors
`-- riscv-randconfig-r042-20230313
    `-- drivers-firmware-efi-libstub-efi-stub-helper.c:warning:variable-dp-is-used-uninitialized-whenever-if-condition-is-false

elapsed time: 724m

configs tested: 132
configs skipped: 13

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230313   gcc  
alpha                randconfig-r021-20230312   gcc  
alpha                randconfig-r034-20230313   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230312   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230313   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230313   gcc  
arm                  randconfig-r026-20230313   gcc  
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230312   clang
arm64                randconfig-r034-20230312   clang
csky                                defconfig   gcc  
csky                 randconfig-r004-20230313   gcc  
csky                 randconfig-r031-20230313   gcc  
hexagon      buildonly-randconfig-r004-20230312   clang
hexagon      buildonly-randconfig-r005-20230313   clang
hexagon              randconfig-r015-20230312   clang
hexagon              randconfig-r035-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
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
i386                 randconfig-r003-20230313   gcc  
i386                 randconfig-r032-20230313   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230312   gcc  
m68k                 randconfig-r006-20230312   gcc  
m68k                 randconfig-r031-20230313   gcc  
m68k                 randconfig-r032-20230313   gcc  
microblaze   buildonly-randconfig-r005-20230312   gcc  
microblaze           randconfig-r031-20230312   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r013-20230312   clang
mips                 randconfig-r021-20230318   clang
mips                 randconfig-r034-20230313   clang
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230312   gcc  
nios2                randconfig-r033-20230312   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230312   gcc  
parisc               randconfig-r036-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230313   clang
powerpc      buildonly-randconfig-r004-20230313   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230312   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r033-20230313   gcc  
riscv                randconfig-r036-20230313   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r036-20230312   clang
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230312   gcc  
sparc        buildonly-randconfig-r003-20230313   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230313   gcc  
sparc64      buildonly-randconfig-r002-20230313   gcc  
sparc64              randconfig-r001-20230312   gcc  
sparc64              randconfig-r024-20230312   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230313   gcc  
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
x86_64               randconfig-r016-20230313   clang
x86_64               randconfig-r033-20230313   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230312   gcc  
xtensa               randconfig-r005-20230313   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
