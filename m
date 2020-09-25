Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067FC277E43
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 04:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIYC5m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 22:57:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:57124 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgIYC5l (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Sep 2020 22:57:41 -0400
IronPort-SDR: EOZNVtmYcSTxtSha8DNXGdFotDFi8Au+bGTTfsmTtg9Sg2xwz4TQ4MRHpwEoWrJj1LU3E01d8l
 Jt8nXZOV/HbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="225561000"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="225561000"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 19:57:40 -0700
IronPort-SDR: rI5RcLtiQX6Nx9ntj94Tk0FCcbyv8dOo5j8/rVbuDxs8ksjByWD65zJEihyWNxtUiwY62aePw/
 B3bxoMCtKBYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="343227992"
Received: from lkp-server01.sh.intel.com (HELO 8db25767daa8) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2020 19:57:39 -0700
Received: from kbuild by 8db25767daa8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kLdvX-00000Y-10; Fri, 25 Sep 2020 02:57:39 +0000
Date:   Fri, 25 Sep 2020 10:56:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 3c77989f2e7b8869b475031d99b892e0baf42739
Message-ID: <5f6d5c6e.jwC0D8vVl5ugduRy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: 3c77989f2e7b8869b475031d99b892e0baf42739  efi: Delete deprecated parameter comments

elapsed time: 722m

configs tested: 141
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7780mp_defconfig
sh                          r7785rp_defconfig
arm                            xcep_defconfig
arm                          badge4_defconfig
mips                  maltasmvp_eva_defconfig
m68k                         apollo_defconfig
mips                      bmips_stb_defconfig
arc                     nsimosci_hs_defconfig
sh                ecovec24-romimage_defconfig
arm                           u8500_defconfig
powerpc                        warp_defconfig
arm                         assabet_defconfig
sh                          rsk7201_defconfig
i386                             allyesconfig
sh                          rsk7269_defconfig
ia64                                defconfig
microblaze                    nommu_defconfig
arm                     davinci_all_defconfig
m68k                       m5275evb_defconfig
powerpc                     tqm8548_defconfig
arm                         nhk8815_defconfig
mips                         rt305x_defconfig
arm                       mainstone_defconfig
powerpc64                           defconfig
xtensa                              defconfig
m68k                        stmark2_defconfig
arm                            qcom_defconfig
powerpc                       ebony_defconfig
xtensa                    smp_lx200_defconfig
m68k                        m5272c3_defconfig
openrisc                         alldefconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     pseries_defconfig
m68k                          hp300_defconfig
sparc                            allyesconfig
sparc                       sparc32_defconfig
powerpc                 mpc837x_mds_defconfig
arc                      axs103_smp_defconfig
powerpc                 linkstation_defconfig
arm                     am200epdkit_defconfig
ia64                      gensparse_defconfig
powerpc                     tqm8541_defconfig
powerpc                    socrates_defconfig
arm                         s3c6400_defconfig
mips                        omega2p_defconfig
h8300                               defconfig
sh                           se7705_defconfig
powerpc                    amigaone_defconfig
arc                        nsim_700_defconfig
arm                         axm55xx_defconfig
sh                          polaris_defconfig
sh                          lboxre2_defconfig
nds32                             allnoconfig
csky                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200924
i386                 randconfig-a006-20200924
i386                 randconfig-a003-20200924
i386                 randconfig-a004-20200924
i386                 randconfig-a005-20200924
i386                 randconfig-a001-20200924
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
x86_64               randconfig-a011-20200923
x86_64               randconfig-a013-20200923
x86_64               randconfig-a014-20200923
x86_64               randconfig-a015-20200923
x86_64               randconfig-a012-20200923
x86_64               randconfig-a016-20200923
i386                 randconfig-a012-20200923
i386                 randconfig-a014-20200923
i386                 randconfig-a016-20200923
i386                 randconfig-a013-20200923
i386                 randconfig-a011-20200923
i386                 randconfig-a015-20200923
i386                 randconfig-a012-20200924
i386                 randconfig-a014-20200924
i386                 randconfig-a016-20200924
i386                 randconfig-a013-20200924
i386                 randconfig-a011-20200924
i386                 randconfig-a015-20200924
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
x86_64               randconfig-a005-20200923
x86_64               randconfig-a003-20200923
x86_64               randconfig-a004-20200923
x86_64               randconfig-a002-20200923
x86_64               randconfig-a006-20200923
x86_64               randconfig-a001-20200923
x86_64               randconfig-a005-20200925
x86_64               randconfig-a003-20200925
x86_64               randconfig-a004-20200925
x86_64               randconfig-a002-20200925
x86_64               randconfig-a006-20200925
x86_64               randconfig-a001-20200925

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
