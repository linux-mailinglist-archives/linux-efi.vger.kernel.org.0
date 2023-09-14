Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5377A01D2
	for <lists+linux-efi@lfdr.de>; Thu, 14 Sep 2023 12:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbjINKiv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Sep 2023 06:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjINKiv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Sep 2023 06:38:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A5E1BEB
        for <linux-efi@vger.kernel.org>; Thu, 14 Sep 2023 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694687927; x=1726223927;
  h=date:from:to:cc:subject:message-id;
  bh=M97yXWPMBHhh7VtrecRMBjO5m3kBtK+c1Eyrmt3mb+I=;
  b=B5BZboyiCpkNIe+L0HaeYuAFY3JOaHa7cRVJsn65r91pCEQoU4bOpHE5
   ZwP+VgeOOLt5oLIGrV/vbt0X0lHwQ8JzdnGmxVU9NWkcLgQrEECMXHAZ6
   /Czm/shlyHiAHzRZAa3wJEkIKubVQFER+JwaAd4Suwb869/06QRKp+I52
   SwqKZqVL6W+Yf8Zz3uS36nYt1G84bwIDpthp7TWcGl+KVgGSHJ6ZFbasZ
   S9kk4QSWPZ7qa+4+JyVS2ghh7llEoOAQoukkxIVA11gUSuvDceKLRFn6L
   DUtUYtAPJnToqzZtK+pIBFI/sqX0gbzQ30BEzMmJvWEnKM5vtegaR1TuN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378833666"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="378833666"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 03:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779576570"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="779576570"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2023 03:38:45 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgjkB-0001VA-1C;
        Thu, 14 Sep 2023 10:38:43 +0000
Date:   Thu, 14 Sep 2023 18:38:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 560f54eaa44ce3059defe2b613f04cfe4f8de6b3
Message-ID: <202309141812.qiJRvxAF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 560f54eaa44ce3059defe2b613f04cfe4f8de6b3  efi/x86: Disable buggy QueryVariableInfo() on HP ProBook x360

elapsed time: 1495m

configs tested: 200
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230913   gcc  
alpha                randconfig-r005-20230913   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230913   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230913   gcc  
arm                   randconfig-001-20230914   gcc  
arm                  randconfig-r016-20230913   gcc  
arm                  randconfig-r032-20230913   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230913   clang
arm64                randconfig-r025-20230913   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r026-20230913   gcc  
hexagon               randconfig-001-20230913   clang
hexagon               randconfig-002-20230913   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230913   gcc  
i386         buildonly-randconfig-001-20230914   gcc  
i386         buildonly-randconfig-002-20230913   gcc  
i386         buildonly-randconfig-002-20230914   gcc  
i386         buildonly-randconfig-003-20230913   gcc  
i386         buildonly-randconfig-003-20230914   gcc  
i386         buildonly-randconfig-004-20230913   gcc  
i386         buildonly-randconfig-004-20230914   gcc  
i386         buildonly-randconfig-005-20230913   gcc  
i386         buildonly-randconfig-005-20230914   gcc  
i386         buildonly-randconfig-006-20230913   gcc  
i386         buildonly-randconfig-006-20230914   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230913   gcc  
i386                  randconfig-001-20230914   gcc  
i386                  randconfig-002-20230913   gcc  
i386                  randconfig-002-20230914   gcc  
i386                  randconfig-003-20230913   gcc  
i386                  randconfig-003-20230914   gcc  
i386                  randconfig-004-20230913   gcc  
i386                  randconfig-004-20230914   gcc  
i386                  randconfig-005-20230913   gcc  
i386                  randconfig-005-20230914   gcc  
i386                  randconfig-006-20230913   gcc  
i386                  randconfig-006-20230914   gcc  
i386                  randconfig-011-20230913   gcc  
i386                  randconfig-011-20230914   gcc  
i386                  randconfig-012-20230913   gcc  
i386                  randconfig-012-20230914   gcc  
i386                  randconfig-013-20230913   gcc  
i386                  randconfig-013-20230914   gcc  
i386                  randconfig-014-20230913   gcc  
i386                  randconfig-014-20230914   gcc  
i386                  randconfig-015-20230913   gcc  
i386                  randconfig-015-20230914   gcc  
i386                  randconfig-016-20230913   gcc  
i386                  randconfig-016-20230914   gcc  
i386                 randconfig-r003-20230913   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230913   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230913   gcc  
m68k                 randconfig-r021-20230913   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230913   gcc  
nios2                randconfig-r033-20230913   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r013-20230913   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230913   gcc  
parisc               randconfig-r035-20230913   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r001-20230913   gcc  
powerpc              randconfig-r022-20230913   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230913   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230913   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r015-20230913   gcc  
sh                   randconfig-r024-20230913   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230914   gcc  
sparc                randconfig-r031-20230913   gcc  
sparc                randconfig-r036-20230913   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r004-20230913   clang
um                   randconfig-r023-20230913   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230913   gcc  
x86_64       buildonly-randconfig-001-20230914   gcc  
x86_64       buildonly-randconfig-002-20230913   gcc  
x86_64       buildonly-randconfig-002-20230914   gcc  
x86_64       buildonly-randconfig-003-20230913   gcc  
x86_64       buildonly-randconfig-003-20230914   gcc  
x86_64       buildonly-randconfig-004-20230913   gcc  
x86_64       buildonly-randconfig-004-20230914   gcc  
x86_64       buildonly-randconfig-005-20230913   gcc  
x86_64       buildonly-randconfig-005-20230914   gcc  
x86_64       buildonly-randconfig-006-20230913   gcc  
x86_64       buildonly-randconfig-006-20230914   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230913   gcc  
x86_64                randconfig-001-20230914   gcc  
x86_64                randconfig-002-20230913   gcc  
x86_64                randconfig-002-20230914   gcc  
x86_64                randconfig-003-20230913   gcc  
x86_64                randconfig-003-20230914   gcc  
x86_64                randconfig-004-20230913   gcc  
x86_64                randconfig-004-20230914   gcc  
x86_64                randconfig-005-20230913   gcc  
x86_64                randconfig-005-20230914   gcc  
x86_64                randconfig-006-20230913   gcc  
x86_64                randconfig-006-20230914   gcc  
x86_64                randconfig-011-20230914   gcc  
x86_64                randconfig-012-20230914   gcc  
x86_64                randconfig-013-20230913   gcc  
x86_64                randconfig-013-20230914   gcc  
x86_64                randconfig-014-20230914   gcc  
x86_64                randconfig-015-20230914   gcc  
x86_64                randconfig-016-20230914   gcc  
x86_64                randconfig-071-20230913   gcc  
x86_64                randconfig-071-20230914   gcc  
x86_64                randconfig-072-20230913   gcc  
x86_64                randconfig-072-20230914   gcc  
x86_64                randconfig-073-20230913   gcc  
x86_64                randconfig-073-20230914   gcc  
x86_64                randconfig-074-20230913   gcc  
x86_64                randconfig-074-20230914   gcc  
x86_64                randconfig-075-20230913   gcc  
x86_64                randconfig-075-20230914   gcc  
x86_64                randconfig-076-20230913   gcc  
x86_64                randconfig-076-20230914   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r034-20230913   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
