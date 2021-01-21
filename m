Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E612FF8DD
	for <lists+linux-efi@lfdr.de>; Fri, 22 Jan 2021 00:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbhAUX2Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Jan 2021 18:28:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:49341 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbhAUX2V (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Jan 2021 18:28:21 -0500
IronPort-SDR: WVsxtPjydh03X4uLYV3W5Dh//k/jKQmFJ8eGx+w6yU/4UMQUILIIQNKcfBO8R6vrpDEENuP/PG
 ceYx9Zu2Gt+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="179512506"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="179512506"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 15:27:50 -0800
IronPort-SDR: dzfU3yu/1lMZbRToaXhivQ3jfNckKxgSOLZrNQNgE5AvYDAFpB36A5El736iBIhrYvAAdMF/8f
 03WrwWJQZv2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="400332232"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jan 2021 15:27:49 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2jMi-0006ls-89; Thu, 21 Jan 2021 23:27:48 +0000
Date:   Fri, 22 Jan 2021 07:27:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 1c761ee9da1ac6ba7e40d14457fac94c87eaff35
Message-ID: <600a0de4.tQQ7utrWZfWYWAbS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 1c761ee9da1ac6ba7e40d14457fac94c87eaff35  efi/arm64: Update debug prints to reflect other entropy sources

elapsed time: 734m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
openrisc                         alldefconfig
arm                            lart_defconfig
arm                            pleb_defconfig
arm                         assabet_defconfig
sh                           se7619_defconfig
arm                        trizeps4_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        keystone_defconfig
ia64                         bigsur_defconfig
powerpc                      chrp32_defconfig
sh                          rsk7203_defconfig
arm                           h3600_defconfig
m68k                        m5407c3_defconfig
sh                          sdk7786_defconfig
c6x                         dsk6455_defconfig
arc                          axs101_defconfig
x86_64                           alldefconfig
mips                          ath79_defconfig
sh                          lboxre2_defconfig
arm                        clps711x_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
mips                       lemote2f_defconfig
xtensa                generic_kc705_defconfig
powerpc                    socrates_defconfig
m68k                          atari_defconfig
arm                             mxs_defconfig
powerpc                   currituck_defconfig
arm                         cm_x300_defconfig
mips                           ip27_defconfig
m68k                         amcore_defconfig
powerpc                     sequoia_defconfig
mips                          ath25_defconfig
arm                         orion5x_defconfig
arm                         s3c6400_defconfig
arm                           u8500_defconfig
powerpc                  storcenter_defconfig
powerpc                         wii_defconfig
xtensa                              defconfig
sh                   rts7751r2dplus_defconfig
mips                  maltasmvp_eva_defconfig
sparc64                             defconfig
powerpc                     stx_gp3_defconfig
arm                           omap1_defconfig
arm                       spear13xx_defconfig
mips                      maltaaprp_defconfig
sh                             sh03_defconfig
sh                ecovec24-romimage_defconfig
sh                          r7785rp_defconfig
arm                        vexpress_defconfig
um                            kunit_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
