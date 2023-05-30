Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F8715D7D
	for <lists+linux-efi@lfdr.de>; Tue, 30 May 2023 13:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjE3LlH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 May 2023 07:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjE3Lkz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 May 2023 07:40:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262DEF7
        for <linux-efi@vger.kernel.org>; Tue, 30 May 2023 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685446852; x=1716982852;
  h=date:from:to:cc:subject:message-id;
  bh=RAz3RN9K7C2yJNf+gNGq5pO9EtQ3MhNpYDLfbXKdM00=;
  b=IB8qhsnpSFOWs7klv+gwuW/MueHFKCckX14vCbACmjGN5vYxi9WJpbi9
   YYbM1X41Ms46zODddzIx5ffUA9a9iZo57bNed6DYek1BOYygv5/+W/8x2
   9zbBsKN7ZgAxceeNJNDAjd5MqGa/pslyThsLlCthFWRt1mjdhgQqskLTA
   6+6vSqzcWd959MV97zxt16AjQnjTp127nuf/ESHcYwhfSwKb0T8z5Ly+y
   a72d1SO0NgRIjOGaa+glXUcTm1wPu7msuuAM9362vH2SSK3Ik28k1a2bK
   QoC38W9kq3Rod2ia7/yU7iieAJdzTIkuHXqq5IiW/vYeqlr6zpKPMyI22
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="383144894"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383144894"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="953104167"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="953104167"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 May 2023 04:40:50 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3xib-00005t-2W;
        Tue, 30 May 2023 11:40:49 +0000
Date:   Tue, 30 May 2023 19:40:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 36e4fc57fc1619f462e669e939209c45763bc8f5
Message-ID: <20230530114034.CWFVN%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 36e4fc57fc1619f462e669e939209c45763bc8f5  efi: Bump stub image version for macOS HVF compatibility

elapsed time: 2220m

configs tested: 209
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230529   gcc  
alpha        buildonly-randconfig-r005-20230529   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230529   gcc  
arc          buildonly-randconfig-r004-20230529   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r003-20230529   gcc  
arc                  randconfig-r005-20230529   gcc  
arc                  randconfig-r024-20230529   gcc  
arc                  randconfig-r043-20230529   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                          moxart_defconfig   clang
arm                  randconfig-r046-20230529   clang
arm                           sama5_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230529   gcc  
arm64                randconfig-r024-20230529   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230529   gcc  
hexagon      buildonly-randconfig-r003-20230529   clang
hexagon              randconfig-r004-20230529   clang
hexagon              randconfig-r041-20230529   clang
hexagon              randconfig-r045-20230529   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230529   clang
i386                 randconfig-i002-20230529   clang
i386                 randconfig-i003-20230529   clang
i386                 randconfig-i004-20230529   clang
i386                 randconfig-i005-20230529   clang
i386                 randconfig-i006-20230529   clang
i386                 randconfig-i011-20230529   gcc  
i386                 randconfig-i012-20230529   gcc  
i386                 randconfig-i013-20230529   gcc  
i386                 randconfig-i014-20230529   gcc  
i386                 randconfig-i015-20230529   gcc  
i386                 randconfig-i016-20230529   gcc  
i386                 randconfig-i051-20230529   clang
i386                 randconfig-i052-20230529   clang
i386                 randconfig-i053-20230529   clang
i386                 randconfig-i054-20230529   clang
i386                 randconfig-i055-20230529   clang
i386                 randconfig-i056-20230529   clang
i386                 randconfig-i061-20230529   clang
i386                 randconfig-i062-20230529   clang
i386                 randconfig-i063-20230529   clang
i386                 randconfig-i064-20230529   clang
i386                 randconfig-i065-20230529   clang
i386                 randconfig-i066-20230529   clang
i386                 randconfig-i071-20230529   gcc  
i386                 randconfig-i072-20230529   gcc  
i386                 randconfig-i073-20230529   gcc  
i386                 randconfig-i074-20230529   gcc  
i386                 randconfig-i075-20230529   gcc  
i386                 randconfig-i076-20230529   gcc  
i386                 randconfig-i081-20230529   gcc  
i386                 randconfig-i082-20230529   gcc  
i386                 randconfig-i083-20230529   gcc  
i386                 randconfig-i084-20230529   gcc  
i386                 randconfig-i085-20230529   gcc  
i386                 randconfig-i086-20230529   gcc  
i386                 randconfig-i091-20230529   clang
i386                 randconfig-i092-20230529   clang
i386                 randconfig-i093-20230529   clang
i386                 randconfig-i094-20230529   clang
i386                 randconfig-i095-20230529   clang
i386                 randconfig-i096-20230529   clang
i386                 randconfig-r003-20230529   clang
i386                 randconfig-r011-20230529   gcc  
i386                 randconfig-r034-20230529   clang
ia64                      gensparse_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r026-20230529   gcc  
loongarch            randconfig-r033-20230529   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230529   gcc  
m68k                 randconfig-r013-20230529   gcc  
microblaze   buildonly-randconfig-r004-20230529   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                 randconfig-r001-20230529   gcc  
mips                 randconfig-r006-20230529   gcc  
mips                          rb532_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230529   gcc  
nios2                randconfig-r012-20230529   gcc  
nios2                randconfig-r016-20230529   gcc  
openrisc             randconfig-r021-20230529   gcc  
openrisc             randconfig-r032-20230529   gcc  
openrisc             randconfig-r035-20230529   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r004-20230529   gcc  
parisc               randconfig-r015-20230529   gcc  
parisc               randconfig-r022-20230529   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r006-20230529   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r022-20230529   gcc  
powerpc                    socrates_defconfig   clang
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230529   gcc  
riscv                randconfig-r042-20230529   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230529   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230529   gcc  
s390                 randconfig-r023-20230529   gcc  
s390                 randconfig-r044-20230529   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230529   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230529   gcc  
sparc                randconfig-r026-20230529   gcc  
sparc64      buildonly-randconfig-r002-20230529   gcc  
sparc64              randconfig-r006-20230529   gcc  
sparc64              randconfig-r014-20230529   gcc  
sparc64              randconfig-r036-20230529   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230529   clang
x86_64               randconfig-a002-20230529   clang
x86_64               randconfig-a003-20230529   clang
x86_64               randconfig-a004-20230529   clang
x86_64               randconfig-a005-20230529   clang
x86_64               randconfig-a006-20230529   clang
x86_64               randconfig-a011-20230529   gcc  
x86_64               randconfig-a012-20230529   gcc  
x86_64               randconfig-a013-20230529   gcc  
x86_64               randconfig-a014-20230529   gcc  
x86_64               randconfig-a015-20230529   gcc  
x86_64               randconfig-a016-20230529   gcc  
x86_64               randconfig-r013-20230529   gcc  
x86_64               randconfig-r023-20230529   gcc  
x86_64               randconfig-x051-20230529   gcc  
x86_64               randconfig-x052-20230529   gcc  
x86_64               randconfig-x053-20230529   gcc  
x86_64               randconfig-x054-20230529   gcc  
x86_64               randconfig-x055-20230529   gcc  
x86_64               randconfig-x056-20230529   gcc  
x86_64               randconfig-x061-20230529   gcc  
x86_64               randconfig-x062-20230529   gcc  
x86_64               randconfig-x063-20230529   gcc  
x86_64               randconfig-x064-20230529   gcc  
x86_64               randconfig-x065-20230529   gcc  
x86_64               randconfig-x066-20230529   gcc  
x86_64               randconfig-x071-20230529   clang
x86_64               randconfig-x072-20230529   clang
x86_64               randconfig-x073-20230529   clang
x86_64               randconfig-x074-20230529   clang
x86_64               randconfig-x075-20230529   clang
x86_64               randconfig-x076-20230529   clang
x86_64               randconfig-x081-20230529   clang
x86_64               randconfig-x082-20230529   clang
x86_64               randconfig-x083-20230529   clang
x86_64               randconfig-x084-20230529   clang
x86_64               randconfig-x085-20230529   clang
x86_64               randconfig-x086-20230529   clang
x86_64               randconfig-x091-20230529   gcc  
x86_64               randconfig-x092-20230529   gcc  
x86_64               randconfig-x093-20230529   gcc  
x86_64               randconfig-x094-20230529   gcc  
x86_64               randconfig-x095-20230529   gcc  
x86_64               randconfig-x096-20230529   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230529   gcc  
xtensa       buildonly-randconfig-r006-20230529   gcc  
xtensa               randconfig-r001-20230529   gcc  
xtensa               randconfig-r011-20230529   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
