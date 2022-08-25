Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE05A1BF0
	for <lists+linux-efi@lfdr.de>; Fri, 26 Aug 2022 00:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiHYWKz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Aug 2022 18:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiHYWKx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Aug 2022 18:10:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F55422CA
        for <linux-efi@vger.kernel.org>; Thu, 25 Aug 2022 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661465451; x=1693001451;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DcMww9DsPUBiYJ0+yF4S5RjFBV/SFmwC2Q36RrcggJQ=;
  b=Z3xAqaQ+shm/sF0fhLOkcbQ/NYX5SIqmKfvy20fshwt3hXQhaJ7r0Iy6
   KtAJb1lTqtMwsNx6POpF0rwupH4pZxbkYWiRf2TqaqdZ1hG4YfzL10nIq
   JsYTqRgyhzTWqUNfzYc8CI+EQTeSOLXOmR+Re2HbxYJGJatT4B6p5ZpM+
   caGQMdRtT9rYHV2EE6W7H9bVdNGiG5ce3Jm0qf2tq3nVaAJ7a4i53u8t0
   W0KLdDKhmaY4jJJV7MpgwFhCZJb0EyRS7Ngr/kPL4Npb5B7rMZdu1EAvL
   guBx1dxBGPJLMcweTEk149H4D5PF/tyxvgZElbOTZztZC8H15HetQcVCI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320457478"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="320457478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 15:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="561208381"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Aug 2022 15:10:50 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRL3p-0002yE-1J;
        Thu, 25 Aug 2022 22:10:49 +0000
Date:   Fri, 26 Aug 2022 06:10:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 1a3887924a7e6edd331be76da7bf4c1e8eab4b1e
Message-ID: <6307f346.dXgIL1OM7WX/N0zO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 1a3887924a7e6edd331be76da7bf4c1e8eab4b1e  efi: libstub: Disable struct randomization

elapsed time: 725m

configs tested: 135
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
loongarch                         allnoconfig
powerpc                           allnoconfig
arc                              allyesconfig
alpha                            allyesconfig
loongarch                           defconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
s390                                defconfig
sh                               allmodconfig
s390                             allmodconfig
i386                                defconfig
powerpc                          allmodconfig
mips                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
s390                             allyesconfig
i386                          randconfig-a001
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a003
arc                  randconfig-r043-20220824
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824
i386                          randconfig-a005
arc                  randconfig-r043-20220825
arc                  randconfig-r043-20220823
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
sh                          rsk7269_defconfig
m68k                                defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-c001
i386                          randconfig-a016
m68k                        m5272c3_defconfig
arm                          iop32x_defconfig
arm                          gemini_defconfig
powerpc                     tqm8548_defconfig
um                                  defconfig
m68k                       m5249evb_defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
sh                           se7751_defconfig
powerpc                      arches_defconfig
m68k                        stmark2_defconfig
xtensa                         virt_defconfig
arm                       imx_v6_v7_defconfig
ia64                        generic_defconfig
arm                        spear6xx_defconfig
mips                            gpr_defconfig
ia64                             alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                           gcw0_defconfig
m68k                       bvme6000_defconfig
sh                            hp6xx_defconfig
m68k                           virt_defconfig
arm                            qcom_defconfig
sparc                       sparc32_defconfig
sh                           se7750_defconfig
sh                         microdev_defconfig
arc                     nsimosci_hs_defconfig
arm64                               defconfig
arm                              allmodconfig
ia64                                defconfig
mips                             allmodconfig
ia64                             allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220825
i386                          randconfig-a002
hexagon              randconfig-r041-20220824
hexagon              randconfig-r045-20220824
i386                          randconfig-a004
riscv                randconfig-r042-20220825
hexagon              randconfig-r041-20220823
s390                 randconfig-r044-20220825
hexagon              randconfig-r045-20220825
riscv                randconfig-r042-20220823
i386                          randconfig-a006
hexagon              randconfig-r045-20220823
s390                 randconfig-r044-20220823
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
mips                       lemote2f_defconfig
arm                         socfpga_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
