Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3C6C5FB6
	for <lists+linux-efi@lfdr.de>; Thu, 23 Mar 2023 07:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCWG2V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Mar 2023 02:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCWG2U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Mar 2023 02:28:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F5A1E2B3
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 23:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679552899; x=1711088899;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tXzEtiTdWetJN2G7ZqrgG5VrkL+T3kvUaNutwX8dv3c=;
  b=GFMbGJv6vhroCeSCwhdegHWDME6Jn/tWNWK2IV01xyo6iAsw2twBSwWg
   q5kNY7iyFEy6zyYz1JVMU9JJ0KOjHLJWZFv7fNiQ4x8mXMiXiYL4V/pWl
   NVc85v3niqU7Md6ITjl/4zTDuPYWaFff/6jE5iXqMcTVYT1ETcwsHLnfU
   EbA7nxAcJ9EeHMrYmzWucgD2OPq+qjAzILJW+pNSlcuuyH1uZFeij1s03
   Y8R38uLTMYCJyHn4fGWaphZZ9Uda38k4lcLlYxQTFdfcmnGZal4Wye1C9
   5OK5rhy4s00Ky9IV9Xr6LT+by8NutQ1b1WEl9AzcfdhCfrlZ0gaqU0aVK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341770952"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="341770952"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 23:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="825699454"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="825699454"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2023 23:28:18 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfEQm-000E36-1p;
        Thu, 23 Mar 2023 06:28:12 +0000
Date:   Thu, 23 Mar 2023 14:27:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 10e9aa1d82f64760fc41e4b994ca1689f4cee4ae
Message-ID: <641bf145.hYffh4dFn29ObrPW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 10e9aa1d82f64760fc41e4b994ca1689f4cee4ae  efi/libstub: Use relocated version of kernel's struct screen_info

elapsed time: 731m

configs tested: 104
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230322   clang
arm                  randconfig-r013-20230322   clang
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230322   gcc  
csky                 randconfig-r026-20230322   gcc  
hexagon              randconfig-r004-20230322   clang
hexagon              randconfig-r015-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230322   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r031-20230322   gcc  
ia64                 randconfig-r032-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230322   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230322   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230322   gcc  
mips                 randconfig-r034-20230322   gcc  
nios2        buildonly-randconfig-r002-20230322   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r014-20230322   gcc  
openrisc             randconfig-r023-20230322   gcc  
openrisc             randconfig-r033-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r013-20230322   gcc  
powerpc              randconfig-r015-20230322   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230322   gcc  
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230322   clang
s390                 randconfig-r003-20230322   clang
s390                 randconfig-r022-20230322   gcc  
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r016-20230322   gcc  
sh                   randconfig-r036-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230322   gcc  
sparc                randconfig-r016-20230322   gcc  
sparc                randconfig-r035-20230322   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
