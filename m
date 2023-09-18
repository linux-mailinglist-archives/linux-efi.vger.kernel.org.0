Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE647A542F
	for <lists+linux-efi@lfdr.de>; Mon, 18 Sep 2023 22:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjIRUct (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Sep 2023 16:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjIRUco (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Sep 2023 16:32:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC47115
        for <linux-efi@vger.kernel.org>; Mon, 18 Sep 2023 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695069158; x=1726605158;
  h=date:from:to:cc:subject:message-id;
  bh=ksNFk6IaNWWyFIlZ4PHGz/yMn7CuX3YfQAhAx8Eps8Y=;
  b=Qn18JV2cXV4Br7ZAHvU6fFzHl1EOIVIBL5YXCC+JxHqOjaFPT9/P5cNe
   mUgGpFgQ3Z0NfI5LEIUJW1rC9ofnHbGLun8iagR2AwpYlVB99WpiT8p9T
   DGdCWU7gWx0OIwXujwGoHdpGSl7xolVaxUTOVnu/q7G7coh0Hcv7ugHUq
   Xw7yhr3HabmcPc0EnPu60annUQCw4VzhRcoYEDaBH6cntxK5A82jsVE7S
   FCI9vps+WB1i6yX3u/ymC1IA7WxNiUeQj7R0UUTf40M20CdrWIAryW/QA
   qyFgLR1lSzU+2IopiBBlB3fXKwBi+qF8DGWCG6qVcaKdf3J4pLf7B+vaz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="377080610"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="377080610"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 13:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="775265460"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="775265460"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Sep 2023 13:32:36 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiKv4-0006Ra-0v;
        Mon, 18 Sep 2023 20:32:34 +0000
Date:   Tue, 19 Sep 2023 04:32:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 52c34f16245f6e12c6880e7aeaf14e410f7047b6
Message-ID: <202309190429.vVxDpaMp-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 52c34f16245f6e12c6880e7aeaf14e410f7047b6  efi/unaccepted: Make sure unaccepted table is mapped in crashkernel case

elapsed time: 733m

configs tested: 130
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
arc                   randconfig-001-20230918   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230918   gcc  
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
i386         buildonly-randconfig-001-20230918   gcc  
i386         buildonly-randconfig-002-20230918   gcc  
i386         buildonly-randconfig-003-20230918   gcc  
i386         buildonly-randconfig-004-20230918   gcc  
i386         buildonly-randconfig-005-20230918   gcc  
i386         buildonly-randconfig-006-20230918   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-011-20230918   gcc  
i386                  randconfig-012-20230918   gcc  
i386                  randconfig-013-20230918   gcc  
i386                  randconfig-014-20230918   gcc  
i386                  randconfig-015-20230918   gcc  
i386                  randconfig-016-20230918   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230918   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
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
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     mpc5200_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20230918   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230918   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230918   gcc  
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
x86_64       buildonly-randconfig-001-20230918   gcc  
x86_64       buildonly-randconfig-002-20230918   gcc  
x86_64       buildonly-randconfig-003-20230918   gcc  
x86_64       buildonly-randconfig-004-20230918   gcc  
x86_64       buildonly-randconfig-005-20230918   gcc  
x86_64       buildonly-randconfig-006-20230918   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-011-20230918   gcc  
x86_64                randconfig-012-20230918   gcc  
x86_64                randconfig-013-20230918   gcc  
x86_64                randconfig-014-20230918   gcc  
x86_64                randconfig-015-20230918   gcc  
x86_64                randconfig-016-20230918   gcc  
x86_64                randconfig-071-20230918   gcc  
x86_64                randconfig-072-20230918   gcc  
x86_64                randconfig-073-20230918   gcc  
x86_64                randconfig-074-20230918   gcc  
x86_64                randconfig-075-20230918   gcc  
x86_64                randconfig-076-20230918   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
