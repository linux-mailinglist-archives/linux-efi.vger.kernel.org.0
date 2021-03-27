Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6607034B3DC
	for <lists+linux-efi@lfdr.de>; Sat, 27 Mar 2021 03:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhC0CuW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Mar 2021 22:50:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:24458 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhC0Ctj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 26 Mar 2021 22:49:39 -0400
IronPort-SDR: 5YWH/j2gi++g86gZ5p8fcar3EAxK72acFjwTGtZgTwlIFsX33h7NJ7N97yeZrAqstudNjLa9Sq
 /8TzSa0Pulrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="255250403"
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="255250403"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 19:49:38 -0700
IronPort-SDR: mQuiW7bOMMaKVYyI5vW1DnQ/Efdzv1JZpWgP78JfHr9raq+rxf51xsMdgMPSG6a8kzxX84uAyX
 7fW6x0o6H5rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="594373772"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Mar 2021 19:49:37 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPz16-0003At-PJ; Sat, 27 Mar 2021 02:49:36 +0000
Date:   Sat, 27 Mar 2021 10:48:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD REGRESSION
 66d988c324a018de02a0924232c68618b6433e80
Message-ID: <605e9d0f.0ErTp6v2EzLOvzfD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 66d988c324a018de02a0924232c68618b6433e80  efi: use explicit const efi_guid_t type for EFI_GUID literals

Error/Warning reports:

https://lore.kernel.org/linux-efi/202103201510.e9ucTTsf-lkp@intel.com

Error/Warning in current branch:

drivers/firmware/google/gsmi.c:477:18: error: initialization of 'efi_status_t (*)(const efi_char16_t *, const efi_guid_t *, u32 *, long unsigned int *, void *)' {aka 'long unsigned int (*)(const short unsigned int *, const struct <anonymous> *, unsigned int *, long unsigned int *, void *)'} from incompatible pointer type 'efi_status_t (*)(efi_char16_t *, efi_guid_t *, u32 *, long unsigned int *, void *)' {aka 'long unsigned int (*)(short unsigned int *, struct <anonymous> *, unsigned int *, long unsigned int *, void *)'} [-Werror=incompatible-pointer-types]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   `-- drivers-firmware-google-gsmi.c:error:initialization-of-efi_status_t-(-)(const-efi_char16_t-const-efi_guid_t-u32-long-unsigned-int-void-)-aka-long-unsigned-int-(-)(const-short-unsigned-int-const-struct
|-- i386-randconfig-a012-20210326
|   `-- drivers-firmware-google-gsmi.c:error:initialization-of-efi_status_t-(-)(const-efi_char16_t-const-efi_guid_t-u32-long-unsigned-int-void-)-aka-long-unsigned-int-(-)(const-short-unsigned-int-const-struct
|-- x86_64-allmodconfig
|   `-- drivers-firmware-google-gsmi.c:error:initialization-of-efi_status_t-(-)(const-efi_char16_t-const-efi_guid_t-u32-long-unsigned-int-void-)-aka-long-unsigned-int-(-)(const-short-unsigned-int-const-struct
`-- x86_64-allyesconfig
    `-- drivers-firmware-google-gsmi.c:error:initialization-of-efi_status_t-(-)(const-efi_char16_t-const-efi_guid_t-u32-long-unsigned-int-void-)-aka-long-unsigned-int-(-)(const-short-unsigned-int-const-struct

elapsed time: 730m

configs tested: 136
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
m68k                         amcore_defconfig
m68k                           sun3_defconfig
powerpc                      pmac32_defconfig
arm                         hackkit_defconfig
arm                         lpc18xx_defconfig
sh                          kfr2r09_defconfig
sh                ecovec24-romimage_defconfig
sh                           se7780_defconfig
arm                          moxart_defconfig
powerpc                     ep8248e_defconfig
openrisc                            defconfig
sh                         microdev_defconfig
powerpc                          allmodconfig
arm                          ixp4xx_defconfig
nios2                         10m50_defconfig
powerpc                       holly_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                         orion5x_defconfig
powerpc                      pasemi_defconfig
ia64                          tiger_defconfig
powerpc                         wii_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       ebony_defconfig
arm                            pleb_defconfig
m68k                        mvme147_defconfig
microblaze                          defconfig
mips                            ar7_defconfig
powerpc                          g5_defconfig
ia64                            zx1_defconfig
arm                       spear13xx_defconfig
arm                          pxa3xx_defconfig
arm                       aspeed_g5_defconfig
mips                     loongson1c_defconfig
sparc                            alldefconfig
mips                           rs90_defconfig
sh                             sh03_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v7_defconfig
xtensa                generic_kc705_defconfig
powerpc                      arches_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                       eiger_defconfig
arm                     eseries_pxa_defconfig
sh                            titan_defconfig
arm                       cns3420vb_defconfig
arm                          imote2_defconfig
mips                          rb532_defconfig
arm                         palmz72_defconfig
arm                         mv78xx0_defconfig
alpha                            allyesconfig
mips                            gpr_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210327
x86_64               randconfig-a003-20210327
x86_64               randconfig-a006-20210327
x86_64               randconfig-a001-20210327
x86_64               randconfig-a004-20210327
x86_64               randconfig-a005-20210327
i386                 randconfig-a004-20210326
i386                 randconfig-a003-20210326
i386                 randconfig-a001-20210326
i386                 randconfig-a002-20210326
i386                 randconfig-a006-20210326
i386                 randconfig-a005-20210326
x86_64               randconfig-a012-20210326
x86_64               randconfig-a015-20210326
x86_64               randconfig-a014-20210326
x86_64               randconfig-a013-20210326
x86_64               randconfig-a016-20210326
x86_64               randconfig-a011-20210326
i386                 randconfig-a014-20210326
i386                 randconfig-a011-20210326
i386                 randconfig-a015-20210326
i386                 randconfig-a016-20210326
i386                 randconfig-a012-20210326
i386                 randconfig-a013-20210326
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210326
x86_64               randconfig-a003-20210326
x86_64               randconfig-a001-20210326
x86_64               randconfig-a006-20210326
x86_64               randconfig-a004-20210326
x86_64               randconfig-a005-20210326

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
