Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2940D7D538F
	for <lists+linux-efi@lfdr.de>; Tue, 24 Oct 2023 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjJXOBN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Oct 2023 10:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjJXOBN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Oct 2023 10:01:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D9E10F
        for <linux-efi@vger.kernel.org>; Tue, 24 Oct 2023 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698156068; x=1729692068;
  h=date:from:to:cc:subject:message-id;
  bh=iDWvH4eskzPcRuoaTTJMqSZ+8WJ1aZXIHJU8fWWJEzs=;
  b=kfErt4jAZVI+fvwQVxU87cI/LqTr4Whv/962bshuAzpa59JG1i3v3sJR
   qv9L3tqt3HkRYffhoufZpbA5KINFXhJPjQxJKG60+T6akWGLzy7Xmc0i2
   /Zxq9oK7BEDTkVBHk+WdTFoTvw4qgZ4PKo/Jzpr3TMXcNqmZuTvxJh5ib
   3iLI95tUdCoOAMHgZVou5EU2jWRTIrNSTP+1yxXsbZ/kpAwXNIUxibekr
   AHuPhlUFT+4dSoIEBTc3YQZqz9vaV/X4qClVypFIB/d8RkR0pR+fLb5rp
   Ll0sC8v0fJjwJKOjdnQJZPkSfRhGCqKdYRzkiiPjdRPfAsYlfhaAQFO8x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="453528328"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="453528328"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 07:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902190509"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="902190509"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2023 06:58:41 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvHxr-0007vH-23;
        Tue, 24 Oct 2023 14:00:59 +0000
Date:   Tue, 24 Oct 2023 22:00:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 5329aa5101f73c451bcd48deaf3f296685849d9c
Message-ID: <202310242224.aL0s3Za3-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 5329aa5101f73c451bcd48deaf3f296685849d9c  efivarfs: Add uid/gid mount options

elapsed time: 6644m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231021   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231022   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231022   gcc  
i386         buildonly-randconfig-002-20231022   gcc  
i386         buildonly-randconfig-003-20231022   gcc  
i386         buildonly-randconfig-004-20231022   gcc  
i386         buildonly-randconfig-005-20231022   gcc  
i386         buildonly-randconfig-006-20231022   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231022   gcc  
i386                  randconfig-002-20231022   gcc  
i386                  randconfig-003-20231022   gcc  
i386                  randconfig-004-20231022   gcc  
i386                  randconfig-005-20231022   gcc  
i386                  randconfig-006-20231022   gcc  
i386                  randconfig-011-20231022   gcc  
i386                  randconfig-012-20231022   gcc  
i386                  randconfig-013-20231022   gcc  
i386                  randconfig-014-20231022   gcc  
i386                  randconfig-015-20231022   gcc  
i386                  randconfig-016-20231022   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231021   gcc  
loongarch             randconfig-001-20231024   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
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
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231021   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231021   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231022   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231021   gcc  
x86_64       buildonly-randconfig-002-20231021   gcc  
x86_64       buildonly-randconfig-003-20231021   gcc  
x86_64       buildonly-randconfig-004-20231021   gcc  
x86_64       buildonly-randconfig-005-20231021   gcc  
x86_64       buildonly-randconfig-006-20231021   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231021   gcc  
x86_64                randconfig-002-20231021   gcc  
x86_64                randconfig-003-20231021   gcc  
x86_64                randconfig-004-20231021   gcc  
x86_64                randconfig-005-20231021   gcc  
x86_64                randconfig-006-20231021   gcc  
x86_64                randconfig-011-20231022   gcc  
x86_64                randconfig-012-20231022   gcc  
x86_64                randconfig-013-20231022   gcc  
x86_64                randconfig-014-20231022   gcc  
x86_64                randconfig-015-20231022   gcc  
x86_64                randconfig-016-20231022   gcc  
x86_64                randconfig-071-20231022   gcc  
x86_64                randconfig-072-20231022   gcc  
x86_64                randconfig-073-20231022   gcc  
x86_64                randconfig-074-20231022   gcc  
x86_64                randconfig-075-20231022   gcc  
x86_64                randconfig-076-20231022   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
