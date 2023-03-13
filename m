Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883E06B82F9
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 21:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCMUlb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 16:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCMUla (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 16:41:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344E8E3BC
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678740057; x=1710276057;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xVk0t3Hk1ub+AuQP2Y4mgU8+eItcubdYlaknXxgaGEQ=;
  b=gbU3A//RS5+dRW3rLAGSIHIIxhs+5FX+bEd6fc4TTcPlUmVhH6NRK25f
   dg2zWK1MSHyBBcRnnfzjKxKXsLQl+NFOrt5uSLvmZdUg8MakVrNoNDxO+
   rfc4/xe1lRrXAPgN1VF6lXRJW2YRT4Bqu47zwfgbN7IWBuEF6YIxDNN9k
   gsqUFGC86Lo+vmK/I0O2yDu4K/dRNy7bW1OhCmvtnIjhSruSo6Onxbrvb
   DW3+s/sOFJ61cYbU1X3CPoPgIq7p8AsSDZlmuZTibfHFYB29XMjgUU70D
   32NMVOGwfPACbdxl2tS+3y7bcDo3PL+XIyGsCL1SRX8I2nXoKAuI9ThLE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="364913908"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="364913908"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 13:40:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="747733320"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="747733320"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2023 13:40:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pboyJ-00065t-0T;
        Mon, 13 Mar 2023 20:40:43 +0000
Date:   Tue, 14 Mar 2023 04:40:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD REGRESSION
 21f136ebfb9ef430ed614c3f10325876a12695d2
Message-ID: <640f8a2a.uh6/cixotWwq9sdG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 21f136ebfb9ef430ed614c3f10325876a12695d2  efi: libstub: Use relocated version of kernel's struct screen_info

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303132020.S9CriCjt-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

efi-init.c:(.init.text+0x320): undefined reference to `efi_earlycon_reprobe'
efi-init.c:(.init.text+0x410): undefined reference to `efi_earlycon_reprobe'
efi-init.c:(.init.text+0x4b0): undefined reference to `efi_earlycon_reprobe'
efi-init.c:(.init.text+0x9d8): undefined reference to `efi_earlycon_reprobe'
efi-init.c:(.init.text+0x9dc): undefined reference to `efi_earlycon_reprobe'
ld.lld: error: undefined hidden symbol: __efistub__edata
ld.lld: error: undefined hidden symbol: __efistub__end
ld.lld: error: undefined hidden symbol: __efistub__start
ld.lld: error: undefined hidden symbol: __efistub__start_kernel
ld.lld: error: undefined hidden symbol: __efistub_screen_info

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   `-- efi-init.c:(.init.text):undefined-reference-to-efi_earlycon_reprobe
|-- arm-allyesconfig
|   `-- efi-init.c:(.init.text):undefined-reference-to-efi_earlycon_reprobe
|-- arm-defconfig
|   `-- efi-init.c:(.init.text):undefined-reference-to-efi_earlycon_reprobe
|-- riscv-allnoconfig
|   `-- efi-init.c:(.init.text):undefined-reference-to-efi_earlycon_reprobe
`-- riscv-randconfig-r042-20230312
    `-- efi-init.c:(.init.text):undefined-reference-to-efi_earlycon_reprobe
clang_recent_errors
`-- riscv-randconfig-r042-20230313
    |-- ld.lld:error:undefined-hidden-symbol:__efistub__edata
    |-- ld.lld:error:undefined-hidden-symbol:__efistub__end
    |-- ld.lld:error:undefined-hidden-symbol:__efistub__start
    |-- ld.lld:error:undefined-hidden-symbol:__efistub__start_kernel
    `-- ld.lld:error:undefined-hidden-symbol:__efistub_screen_info

elapsed time: 725m

configs tested: 122
configs skipped: 14

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230313   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230313   gcc  
arc                  randconfig-r013-20230313   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230312   gcc  
arm                  randconfig-r006-20230313   clang
arm                  randconfig-r021-20230312   clang
arm                  randconfig-r025-20230312   clang
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230312   clang
arm64                randconfig-r006-20230312   clang
csky                                defconfig   gcc  
csky                 randconfig-r023-20230312   gcc  
hexagon              randconfig-r024-20230312   clang
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
i386                 randconfig-r004-20230313   gcc  
i386                 randconfig-r025-20230313   clang
i386                 randconfig-r032-20230313   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230312   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230312   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230313   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230312   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230313   gcc  
m68k                 randconfig-r005-20230312   gcc  
m68k                 randconfig-r014-20230313   gcc  
m68k                 randconfig-r031-20230313   gcc  
microblaze   buildonly-randconfig-r005-20230312   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230313   gcc  
mips                 randconfig-r024-20230313   gcc  
nios2        buildonly-randconfig-r006-20230312   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r003-20230312   gcc  
openrisc             randconfig-r014-20230312   gcc  
openrisc             randconfig-r021-20230313   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230313   gcc  
parisc               randconfig-r036-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r012-20230312   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230312   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230313   gcc  
s390                 randconfig-r013-20230312   gcc  
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230313   gcc  
sparc64      buildonly-randconfig-r002-20230313   gcc  
sparc64              randconfig-r012-20230313   gcc  
sparc64              randconfig-r022-20230312   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
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
x86_64               randconfig-r033-20230313   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230313   gcc  
xtensa               randconfig-r002-20230312   gcc  
xtensa               randconfig-r016-20230312   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
