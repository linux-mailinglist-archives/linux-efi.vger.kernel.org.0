Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F81F4CCAAB
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 01:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiCDAVZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 19:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbiCDAVZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 19:21:25 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EAE47386
        for <linux-efi@vger.kernel.org>; Thu,  3 Mar 2022 16:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646353238; x=1677889238;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WdS3fDGgO4KM+MY3qdoBamhHYf+wwwk/yy6OlM+b6Ko=;
  b=QAbVaLPQVJQn197im5VPUsF4qA4IwO6+s04ALXtcD6q3q+wCcNuaRKDx
   EAd1jUEA/2nrIJtSPfuT/3wVXE8tBNt//APUv9rO61PgBuB0yYJQ16/WW
   ZyjHlN6FGFuuCUl9kLFewC0CEqlq2VEJT9Ek9N3/+xjffzFX/06mrMVMA
   qvMZFQkkQXU81J2vUXkyl2VF3BNwbVVJ0i+hwJ7aCFEyaXDUOChOwk/5o
   2NmNfmC/kNngVcNLo50f4zfXEDiqq8N/YZf4lD9hDnmjvsjLV0obfCqiV
   zAxxx+pfsRjB5NCql8y9hRvB3qat/5O8PCb7tXbJuV9zWGaPdgTQXApo2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="241274394"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="241274394"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 16:20:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="686708955"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2022 16:20:34 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPvgP-00014t-Tv; Fri, 04 Mar 2022 00:20:33 +0000
Date:   Fri, 04 Mar 2022 08:19:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 2baa81c83f6f3a927cfbbbd707b669d039302625
Message-ID: <62215b2e.MglSU78i0K3Em3No%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 2baa81c83f6f3a927cfbbbd707b669d039302625  efifb: Remove redundant efifb_setup_from_dmi stub

elapsed time: 723m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220303
sh                            migor_defconfig
arm                           sunxi_defconfig
mips                         db1xxx_defconfig
sh                            shmin_defconfig
arm                          badge4_defconfig
m68k                             allyesconfig
arm                         axm55xx_defconfig
arm                        mvebu_v7_defconfig
arm                        cerfcube_defconfig
h8300                            alldefconfig
powerpc                  iss476-smp_defconfig
sh                          kfr2r09_defconfig
sh                          r7780mp_defconfig
arm                           sama5_defconfig
arm                         lubbock_defconfig
sparc                       sparc64_defconfig
riscv             nommu_k210_sdcard_defconfig
h8300                     edosk2674_defconfig
xtensa                generic_kc705_defconfig
mips                           jazz_defconfig
mips                            gpr_defconfig
sh                   sh7724_generic_defconfig
sparc                            allyesconfig
powerpc                     taishan_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
nds32                            alldefconfig
arm                            qcom_defconfig
um                             i386_defconfig
sh                        sh7757lcr_defconfig
powerpc                     sequoia_defconfig
parisc64                         alldefconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc837x_mds_defconfig
sh                          urquell_defconfig
arm                            lart_defconfig
arc                        nsimosci_defconfig
sh                           se7722_defconfig
um                           x86_64_defconfig
sparc64                          alldefconfig
arc                        nsim_700_defconfig
powerpc                        warp_defconfig
arm                       omap2plus_defconfig
s390                          debug_defconfig
arm                           h5000_defconfig
arm                            mps2_defconfig
arm                        clps711x_defconfig
m68k                        m5407c3_defconfig
sh                           se7712_defconfig
m68k                          multi_defconfig
powerpc                    sam440ep_defconfig
powerpc                      arches_defconfig
arm                        trizeps4_defconfig
arm                  randconfig-c002-20220303
arm                  randconfig-c002-20220302
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220303
riscv                randconfig-c006-20220303
i386                          randconfig-c001
arm                  randconfig-c002-20220303
mips                 randconfig-c004-20220303
powerpc              randconfig-c003-20220302
riscv                randconfig-c006-20220302
arm                  randconfig-c002-20220302
mips                 randconfig-c004-20220302
i386                             allyesconfig
powerpc                      ppc64e_defconfig
mips                        workpad_defconfig
mips                           mtx1_defconfig
arm                        vexpress_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220303
riscv                randconfig-r042-20220303
hexagon              randconfig-r041-20220303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
