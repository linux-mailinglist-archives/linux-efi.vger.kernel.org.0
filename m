Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6499F29E421
	for <lists+linux-efi@lfdr.de>; Thu, 29 Oct 2020 08:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgJ2Heo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Oct 2020 03:34:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:25689 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbgJ2HeR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 29 Oct 2020 03:34:17 -0400
IronPort-SDR: 0Pby6qxFoTrs4ufeJHRfRw4hvWCzMYZeK+RnUD/leDSh5XF4hbtMJcoQXwN1xImEpjeyshlVkO
 42mNjGaFEzQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="253082124"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="253082124"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 22:29:51 -0700
IronPort-SDR: OjAVbjEkGoLagvREMsS3h9gy2EbxLnReyeXKRd1fZCZiHW3KDinxV8tTyG4QhtXi4MzZHFvwJC
 64o0A++V/0yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="351292237"
Received: from lkp-server02.sh.intel.com (HELO 72b1a4bebef6) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2020 22:29:50 -0700
Received: from kbuild by 72b1a4bebef6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kY0VR-00005U-K1; Thu, 29 Oct 2020 05:29:49 +0000
Date:   Thu, 29 Oct 2020 13:28:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:arm-adrl-replacement] BUILD SUCCESS
 aaac3733171fca948c4fb66b78257620e3885339
Message-ID: <5f9a5315.JC5gCYK7wh8nH37m%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  arm-adrl-replacement
branch HEAD: aaac3733171fca948c4fb66b78257620e3885339  ARM: kvm: replace open coded VA->PA calculations with adr_l call

elapsed time: 721m

configs tested: 161
configs skipped: 87

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        m5307c3_defconfig
c6x                                 defconfig
s390                             allyesconfig
arm                          prima2_defconfig
ia64                          tiger_defconfig
arm                          pxa3xx_defconfig
ia64                                defconfig
ia64                        generic_defconfig
mips                          malta_defconfig
sh                          lboxre2_defconfig
arm                        mvebu_v5_defconfig
m68k                         amcore_defconfig
arm                        mvebu_v7_defconfig
mips                       lemote2f_defconfig
arm                         nhk8815_defconfig
alpha                            alldefconfig
sh                          r7780mp_defconfig
arm                            lart_defconfig
mips                      bmips_stb_defconfig
arm                        magician_defconfig
m68k                        mvme147_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                              zx_defconfig
c6x                         dsk6455_defconfig
parisc                generic-32bit_defconfig
powerpc                    gamecube_defconfig
arm                      integrator_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5249evb_defconfig
arm                           tegra_defconfig
powerpc                 mpc834x_mds_defconfig
arm                     davinci_all_defconfig
mips                     loongson1b_defconfig
powerpc64                           defconfig
mips                             allyesconfig
sh                           se7343_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                      bamboo_defconfig
arm                      pxa255-idp_defconfig
xtensa                           alldefconfig
powerpc                     tqm8560_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                        edosk7760_defconfig
sh                ecovec24-romimage_defconfig
riscv                            alldefconfig
powerpc                     asp8347_defconfig
powerpc                     mpc512x_defconfig
mips                       capcella_defconfig
xtensa                  nommu_kc705_defconfig
mips                malta_qemu_32r6_defconfig
sh                             espt_defconfig
arm                          ixp4xx_defconfig
um                            kunit_defconfig
m68k                          multi_defconfig
nds32                            alldefconfig
um                           x86_64_defconfig
arm                      tct_hammer_defconfig
mips                       bmips_be_defconfig
arm                           viper_defconfig
powerpc                    sam440ep_defconfig
sh                          urquell_defconfig
powerpc                      walnut_defconfig
sh                          sdk7780_defconfig
powerpc                     pseries_defconfig
sh                              ul2_defconfig
arm                            zeus_defconfig
sh                          rsk7264_defconfig
powerpc                    klondike_defconfig
ia64                      gensparse_defconfig
arm                          pxa168_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201029
i386                 randconfig-a005-20201029
i386                 randconfig-a003-20201029
i386                 randconfig-a001-20201029
i386                 randconfig-a004-20201029
i386                 randconfig-a006-20201029
i386                 randconfig-a002-20201028
i386                 randconfig-a005-20201028
i386                 randconfig-a003-20201028
i386                 randconfig-a001-20201028
i386                 randconfig-a004-20201028
i386                 randconfig-a006-20201028
x86_64               randconfig-a011-20201028
x86_64               randconfig-a013-20201028
x86_64               randconfig-a016-20201028
x86_64               randconfig-a015-20201028
x86_64               randconfig-a012-20201028
x86_64               randconfig-a014-20201028
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201028
i386                 randconfig-a014-20201028
i386                 randconfig-a015-20201028
i386                 randconfig-a013-20201028
i386                 randconfig-a012-20201028
i386                 randconfig-a011-20201028
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201028
x86_64               randconfig-a002-20201028
x86_64               randconfig-a003-20201028
x86_64               randconfig-a006-20201028
x86_64               randconfig-a005-20201028
x86_64               randconfig-a004-20201028
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
