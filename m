Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D232860816F
	for <lists+linux-efi@lfdr.de>; Sat, 22 Oct 2022 00:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJUWVd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Oct 2022 18:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUWVb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Oct 2022 18:21:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A12AAC3C
        for <linux-efi@vger.kernel.org>; Fri, 21 Oct 2022 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666390879; x=1697926879;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D/CX+XIbQ3Iz9E28vYqLmHb3mNnv+LIUmOXBody9jQk=;
  b=Rb7XoP5W3PUT9Rzs4tvqyUlUV4kVzg+p1EPIwom83bXPE5lgy0aSBSqn
   9ULeGmc5aGSGLA00GLLCyzo52PN8qpgkz1BEbnZe1h/AjSORdPIN0d+cq
   C+ySCE6/T2+mpmf+xWx/6jpKG04131Yvr13bSopyGq1iRMlKU90PjmG98
   b5lF9zwFw6G5eowxEYMpBquIhYMDMfUGzhOt6xKFOq4bvd0gok9BRwZGp
   VbzneYs2sxTxmIdWT1EYSBviEisAHZ28Zjw2SL7cmFr/iC+MWm6waGG8r
   wo9MdDXAClK8LWZPbeAxbGM8WwR4w6s2QOfbtzH12r318Eb+O7e8t/omo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="305848163"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="305848163"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="699521747"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="699521747"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2022 15:21:15 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1om0OA-000306-1k;
        Fri, 21 Oct 2022 22:21:14 +0000
Date:   Sat, 22 Oct 2022 06:20:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 37926f96302d8b6c2bc97990d33e316a3ed6d67f
Message-ID: <63531b3f.34t8urihrk3d7cga%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 37926f96302d8b6c2bc97990d33e316a3ed6d67f  efi: runtime: Don't assume virtual mappings are missing if VA == PA == 0

elapsed time: 722m

configs tested: 146
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-syz
arc                                 defconfig
s390                             allmodconfig
x86_64                         rhel-8.3-kunit
alpha                               defconfig
s390                                defconfig
x86_64                           rhel-8.3-kvm
um                             i386_defconfig
s390                             allyesconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
i386                                defconfig
powerpc                          allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a002
x86_64                               rhel-8.3
i386                          randconfig-a003
arc                  randconfig-r043-20221019
arm                                 defconfig
i386                             allyesconfig
i386                          randconfig-a005
x86_64                           allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a011
sh                           se7750_defconfig
sh                           se7343_defconfig
nios2                         10m50_defconfig
arm64                            allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
m68k                         apollo_defconfig
arc                        vdk_hs38_defconfig
sh                           se7712_defconfig
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
arm                        oxnas_v6_defconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                        multi_v7_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
m68k                           virt_defconfig
powerpc                      ppc40x_defconfig
loongarch                           defconfig
sparc                       sparc32_defconfig
sh                          sdk7786_defconfig
parisc                           alldefconfig
mips                      fuloong2e_defconfig
ia64                          tiger_defconfig
arm                        mvebu_v7_defconfig
mips                    maltaup_xpa_defconfig
arm                       omap2plus_defconfig
arm                        clps711x_defconfig
powerpc                 linkstation_defconfig
arc                            hsdk_defconfig
openrisc                 simple_smp_defconfig
arc                           tb10x_defconfig
sh                            titan_defconfig
powerpc                     pq2fads_defconfig
arm                         nhk8815_defconfig
arc                              alldefconfig
m68k                          atari_defconfig
powerpc                     tqm8548_defconfig
arm                          lpd270_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
arm                          exynos_defconfig
alpha                             allnoconfig
arc                               allnoconfig
arm                           u8500_defconfig
csky                                defconfig
parisc                generic-64bit_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                           se7722_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221019

clang tested configs:
x86_64                        randconfig-a001
riscv                randconfig-r042-20221019
i386                          randconfig-a002
hexagon              randconfig-r045-20221019
x86_64                        randconfig-a014
hexagon              randconfig-r041-20221019
x86_64                        randconfig-a003
i386                          randconfig-a004
s390                 randconfig-r044-20221019
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a016
i386                          randconfig-a015
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
arm                       mainstone_defconfig
powerpc                          allmodconfig
arm                         s3c2410_defconfig
mips                           ip28_defconfig
powerpc                    gamecube_defconfig
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
x86_64                        randconfig-k001
arm                        magician_defconfig
arm                       netwinder_defconfig
mips                        maltaup_defconfig
powerpc                 mpc8560_ads_defconfig
arm                      pxa255-idp_defconfig
mips                          ath79_defconfig
powerpc                      acadia_defconfig
arm                             mxs_defconfig
arm                        vexpress_defconfig
mips                       rbtx49xx_defconfig
arm                           spitz_defconfig
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
powerpc                   microwatt_defconfig
arm                         orion5x_defconfig
powerpc                      obs600_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
