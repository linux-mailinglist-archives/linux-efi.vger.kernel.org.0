Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D084502FD9
	for <lists+linux-efi@lfdr.de>; Fri, 15 Apr 2022 22:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbiDOUqF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Apr 2022 16:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiDOUqF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Apr 2022 16:46:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E3C8AE48
        for <linux-efi@vger.kernel.org>; Fri, 15 Apr 2022 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650055415; x=1681591415;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=m7SAsbUq7eo9h3rSwGzKEdzKPe2huC3BOYaVhztFMX0=;
  b=Y9JvtvETH0cS0TXksF4X2/sdeiPaYbWRpjGPM7xw2a3Ji+KBUV69pxis
   2oRruAnTauUrJ5MZQLjx8egNPOMOV8UavMo5cdDMPuRm9o2uNLljReUbN
   Ona6ia7LoDTEurHjDSfecDgX1TCMmlspBY4hkRSoJMXH2/i4RCAE5tP70
   cVP12SCYfjcJQa8y+/oI6psOkDzJWYLeD/d0XCbprFISBBZPXE6/4QVCc
   hF0Lq2H8E9SQ29XuwF118ug1u0iI6wC9YWBdMIteeIjvKJclf4NReDsa/
   YYw8epZ7UGpPfYQgL/AMqdGk53OJqzDRVehoEWJOGNzdiVyHAmzBMWxMC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="326130198"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="326130198"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="725910218"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2022 13:43:33 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfSmy-0002On-IE;
        Fri, 15 Apr 2022 20:43:32 +0000
Date:   Sat, 16 Apr 2022 04:42:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 21b68da7bf4a0f27837a652565a76b9c95e54793
Message-ID: <6259d8bd.Dh7z4oVvW5C+KWMD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 21b68da7bf4a0f27837a652565a76b9c95e54793  efi: x86: Set the NX-compatibility flag in the PE header

elapsed time: 2912m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arc                        vdk_hs38_defconfig
mips                  decstation_64_defconfig
openrisc                  or1klitex_defconfig
mips                      maltasmvp_defconfig
arm                         lubbock_defconfig
arm                           tegra_defconfig
arc                     haps_hs_smp_defconfig
ia64                                defconfig
arm                        keystone_defconfig
arm                             rpc_defconfig
mips                         mpc30x_defconfig
powerpc                     pq2fads_defconfig
ia64                          tiger_defconfig
parisc64                            defconfig
powerpc                        warp_defconfig
sparc                       sparc64_defconfig
i386                                defconfig
powerpc                       eiger_defconfig
arm                       multi_v4t_defconfig
powerpc                     mpc83xx_defconfig
sh                        sh7757lcr_defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         assabet_defconfig
parisc                generic-64bit_defconfig
x86_64                           alldefconfig
sh                           se7724_defconfig
sh                                  defconfig
alpha                            allyesconfig
mips                            gpr_defconfig
sh                             sh03_defconfig
arm                           sunxi_defconfig
xtensa                           alldefconfig
x86_64                              defconfig
powerpc                     ep8248e_defconfig
arc                        nsim_700_defconfig
xtensa                  cadence_csp_defconfig
xtensa                  nommu_kc705_defconfig
sh                         microdev_defconfig
mips                         bigsur_defconfig
m68k                          atari_defconfig
sh                           se7712_defconfig
arm                           u8500_defconfig
arm                        spear6xx_defconfig
arm                            mps2_defconfig
arm                        oxnas_v6_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220413
arm                  randconfig-c002-20220414
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220413
riscv                randconfig-r042-20220413
s390                 randconfig-r044-20220413
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220414
arm                  randconfig-c002-20220414
i386                          randconfig-c001
arm                       mainstone_defconfig
arm                       netwinder_defconfig
mips                        workpad_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220413
hexagon              randconfig-r041-20220413
riscv                randconfig-r042-20220414
hexagon              randconfig-r041-20220414
hexagon              randconfig-r045-20220414

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
