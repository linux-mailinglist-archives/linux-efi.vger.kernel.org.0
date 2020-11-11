Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E57B2AEE3B
	for <lists+linux-efi@lfdr.de>; Wed, 11 Nov 2020 10:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgKKJz6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Nov 2020 04:55:58 -0500
Received: from mga02.intel.com ([134.134.136.20]:46705 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgKKJz5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 11 Nov 2020 04:55:57 -0500
IronPort-SDR: rLDqYG2YgJ1AaIb5w0fg+eiKPaRWLkh6/kaHQD2IRIt4xD95aYqmpcs6xfZDTo5S6M7K26LH8J
 1/M+bQZMW35g==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="157132642"
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="157132642"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 01:55:53 -0800
IronPort-SDR: kq4AE2qMPzDIloHgZUyUVsy103no07u1CGdyuPEEhgYSuAfS6wiv/T8BAw7CqadeJs2TAHXnjm
 XoVM1j9tMyvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="365881123"
Received: from lkp-server02.sh.intel.com (HELO 5b2c7e53fe46) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2020 01:55:52 -0800
Received: from kbuild by 5b2c7e53fe46 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcmr1-00004W-IP; Wed, 11 Nov 2020 09:55:51 +0000
Date:   Wed, 11 Nov 2020 17:55:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 c2fe61d8be491ff8188edaf22e838f819999146b
Message-ID: <5fabb4f7.4FPYJGA8CMaWxkOw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: c2fe61d8be491ff8188edaf22e838f819999146b  efi/x86: Free efi_pgd with free_pages()

elapsed time: 787m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
powerpc                    amigaone_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      ppc64e_defconfig
arm                      pxa255-idp_defconfig
sparc                               defconfig
arm                             mxs_defconfig
mips                           ip32_defconfig
openrisc                 simple_smp_defconfig
arm                           efm32_defconfig
arm                          iop32x_defconfig
arm                        cerfcube_defconfig
h8300                    h8300h-sim_defconfig
h8300                               defconfig
powerpc                     tqm8541_defconfig
arm                          pcm027_defconfig
riscv                    nommu_virt_defconfig
sh                        dreamcast_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     tqm5200_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                         microdev_defconfig
arm                           corgi_defconfig
sh                               j2_defconfig
powerpc                   currituck_defconfig
ia64                         bigsur_defconfig
sh                              ul2_defconfig
sh                         apsh4a3a_defconfig
arm                       netwinder_defconfig
arm                         mv78xx0_defconfig
sh                            migor_defconfig
powerpc                   bluestone_defconfig
sh                         ap325rxa_defconfig
powerpc                      bamboo_defconfig
sh                            shmin_defconfig
powerpc                     tqm8540_defconfig
s390                             allyesconfig
arc                          axs101_defconfig
nios2                         10m50_defconfig
mips                           jazz_defconfig
arm                            pleb_defconfig
mips                        maltaup_defconfig
arm                        magician_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc836x_mds_defconfig
mips                  cavium_octeon_defconfig
mips                     decstation_defconfig
powerpc                       ppc64_defconfig
powerpc                     skiroot_defconfig
arm                         ebsa110_defconfig
powerpc                     redwood_defconfig
openrisc                            defconfig
mips                     loongson1c_defconfig
arm                      footbridge_defconfig
nds32                             allnoconfig
sh                          r7780mp_defconfig
powerpc                       ebony_defconfig
alpha                               defconfig
arm                          lpd270_defconfig
powerpc                     ppa8548_defconfig
m68k                            q40_defconfig
arc                      axs103_smp_defconfig
x86_64                           alldefconfig
arm                   milbeaut_m10v_defconfig
arm                         nhk8815_defconfig
parisc                              defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
