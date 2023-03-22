Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260506C4A38
	for <lists+linux-efi@lfdr.de>; Wed, 22 Mar 2023 13:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCVMTq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Mar 2023 08:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCVMTp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Mar 2023 08:19:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C158F1981
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679487583; x=1711023583;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=P9JK4oAMJysfLQlE5bvkguWP8AyWHL5H+D2yLcJDWqI=;
  b=Cv10RLRyTZsEtPRuba68Ydiyu/IS9h+3iRfP855jxM7PjhWDE0BJxeYB
   0Re5stg0NpkMd7yrrqD2urCAOKWwM/adwaL2u2twggWrLlSwJCdSWxhbM
   ynXs27Q/XtRQ5yp26Hnu9uEH7p1uZegymMwBLeRDpo550poKrwrfyZSpA
   kqWoe0fQ1QXoJq26lSPY6AxRIkJSuJqo0Il2GVTYVLr/42kp205ZcFKlw
   VRsTL8DzVnjaUbI04Kzv1hKQPuoHCAmLVgqh2CyyDvjmPnxb4P2DqIHOA
   XQModxFaB5Lg7VMHc15Ys4YWj4IG/vYNG/SEfpp829cl2jxH4ieB7ihTF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="318841561"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="318841561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 05:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="746279005"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="746279005"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Mar 2023 05:19:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pexRI-000DIL-26;
        Wed, 22 Mar 2023 12:19:36 +0000
Date:   Wed, 22 Mar 2023 20:19:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 d06ecd29e69d087b3f2996dd411118a0376ffc3a
Message-ID: <641af24c.y/W4aucGf4UXV/NA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: d06ecd29e69d087b3f2996dd411118a0376ffc3a  efi: libstub: Use relocated version of kernel's struct screen_info

elapsed time: 722m

configs tested: 170
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r032-20230319   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r001-20230322   gcc  
arc                  randconfig-r036-20230322   gcc  
arc                  randconfig-r043-20230319   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r006-20230322   clang
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230319   clang
arm                  randconfig-r023-20230322   clang
arm                  randconfig-r025-20230322   clang
arm                  randconfig-r035-20230322   gcc  
arm                  randconfig-r046-20230319   gcc  
arm                           sama7_defconfig   clang
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230322   gcc  
arm64                randconfig-r036-20230319   gcc  
csky         buildonly-randconfig-r004-20230319   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230319   gcc  
csky                 randconfig-r034-20230319   gcc  
csky                 randconfig-r034-20230322   gcc  
hexagon              randconfig-r004-20230322   clang
hexagon              randconfig-r022-20230319   clang
hexagon              randconfig-r031-20230319   clang
hexagon              randconfig-r031-20230322   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r045-20230319   clang
i386                             allyesconfig   gcc  
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
i386                 randconfig-a012-20230320   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230320   gcc  
i386                 randconfig-a014-20230320   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230320   gcc  
i386                 randconfig-a016-20230320   gcc  
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r006-20230319   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r015-20230319   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230322   gcc  
loongarch            randconfig-r006-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230322   gcc  
m68k                 randconfig-r015-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips         buildonly-randconfig-r002-20230319   clang
mips                    maltaup_xpa_defconfig   gcc  
mips                 randconfig-r021-20230322   clang
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230319   gcc  
nios2                randconfig-r013-20230319   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r012-20230322   gcc  
openrisc             randconfig-r016-20230322   gcc  
openrisc             randconfig-r024-20230319   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230322   gcc  
parisc               randconfig-r012-20230322   gcc  
parisc               randconfig-r013-20230322   gcc  
parisc               randconfig-r035-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230322   gcc  
powerpc      buildonly-randconfig-r005-20230322   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc                       ppc64_defconfig   gcc  
powerpc                     pq2fads_defconfig   gcc  
powerpc              randconfig-r035-20230322   clang
powerpc                     taishan_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230319   clang
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230322   clang
s390                 randconfig-r003-20230322   clang
s390                 randconfig-r011-20230322   gcc  
s390                 randconfig-r012-20230319   clang
s390                 randconfig-r013-20230322   gcc  
s390                 randconfig-r021-20230319   clang
s390                 randconfig-r044-20230319   clang
s390                 randconfig-r044-20230322   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                   randconfig-r014-20230322   gcc  
sh                   randconfig-r016-20230322   gcc  
sh                   randconfig-r023-20230319   gcc  
sh                   randconfig-r033-20230319   gcc  
sh                           se7724_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230319   gcc  
sparc                randconfig-r014-20230322   gcc  
sparc64      buildonly-randconfig-r001-20230322   gcc  
sparc64      buildonly-randconfig-r006-20230322   gcc  
sparc64              randconfig-r025-20230319   gcc  
sparc64              randconfig-r032-20230322   gcc  
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
x86_64               randconfig-a011-20230320   gcc  
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230320   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230320   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230320   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230320   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230320   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r004-20230319   gcc  
xtensa               randconfig-r031-20230322   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
