Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1AC66A964
	for <lists+linux-efi@lfdr.de>; Sat, 14 Jan 2023 06:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjANF1a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Jan 2023 00:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjANF1Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Jan 2023 00:27:24 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394A935BA
        for <linux-efi@vger.kernel.org>; Fri, 13 Jan 2023 21:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673674044; x=1705210044;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SzVvoly27lYViLFlEZs+lEdf98HYxOzvMjtavER5+qg=;
  b=dQfyKcA1dOVjhuaKHRmlgkyNCHrE8koaISq8bTN55RSb0h/cLI4z2kcJ
   NKjHJUDpl4mlAm+cwvZkdHN+OLR5qqcvEweIReX3fQp5oIaEjQ04iYo82
   PhIC1NkMDp2akrAQWMuXNb6yIvw0pxiAbuunTe85rwOh1aaJmsHOnXZaw
   Ou0jvWQ9YCZm3iJEql5DpoHESYzVw/j31duaUpF710kiox+E9UazM73fV
   yuXwjF8ChRZdup603soA2AAdQTaF0uV1MYnmVsKjP6HgGEGnkcBCTL2Pk
   c9xdL4BM+T29dbKQd+iCOPTRcEX3tFDiD3fTJcriO5gU+iJQm4V8twPcX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="312015478"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="312015478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 21:27:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608379271"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="608379271"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2023 21:27:22 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGZ4b-000BnY-13;
        Sat, 14 Jan 2023 05:27:21 +0000
Date:   Sat, 14 Jan 2023 13:26:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 8118d6171a5f68caa56b3f4af6f49cf7ad481f41
Message-ID: <63c23d15.X0GN/oP5Z6e2smH/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 8118d6171a5f68caa56b3f4af6f49cf7ad481f41  arm64: efi: Account for the EFI runtime stack in stack unwinder

elapsed time: 726m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20230112
s390                 randconfig-r044-20230112
riscv                randconfig-r042-20230112
ia64                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
i386                          randconfig-a003
i386                                defconfig
x86_64                               rhel-8.3
i386                          randconfig-a005
x86_64                           allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                           imxrt_defconfig
sh                          rsk7269_defconfig
sh                        sh7785lcr_defconfig
sparc                             allnoconfig
powerpc                    amigaone_defconfig
mips                           xway_defconfig
arm                         vf610m4_defconfig
arm                         axm55xx_defconfig
riscv             nommu_k210_sdcard_defconfig
sparc64                          alldefconfig
sh                         ecovec24_defconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                           corgi_defconfig
mips                        vocore2_defconfig
m68k                       m5249evb_defconfig
mips                  decstation_64_defconfig
arc                      axs103_smp_defconfig
mips                       bmips_be_defconfig

clang tested configs:
arm                  randconfig-r046-20230112
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230112
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                randconfig-r042-20230113
s390                 randconfig-r044-20230113
hexagon              randconfig-r041-20230113
hexagon              randconfig-r045-20230113
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
