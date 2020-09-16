Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFFF26C380
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 16:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgIPOCv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Sep 2020 10:02:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:3607 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgIPNlG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Sep 2020 09:41:06 -0400
IronPort-SDR: rwPye9pzhZlrKohITfNLA2LEsJqm9jHEiC1obmAlwEzhr8sbJrhJOzUfFgXbRXmvxPPdA+0uhs
 biI7yH3C/wjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="147206936"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="147206936"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 06:00:43 -0700
IronPort-SDR: XtzfzvwfpolcJ06eAIIeU/73WLPT+3dgaYLa5qFh5Qj8/xe9sQ2kLQbDtzyMqLYPW7nHuPRQe5
 E32ov6CQvxNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="302549343"
Received: from lkp-server02.sh.intel.com (HELO bdcb92cf8b4e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Sep 2020 06:00:42 -0700
Received: from kbuild by bdcb92cf8b4e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kIX3B-00006Y-IV; Wed, 16 Sep 2020 13:00:41 +0000
Date:   Wed, 16 Sep 2020 21:00:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 973c2d60254e9548b4f8568e1a349f3852315dd5
Message-ID: <5f620c57.h6B8EU8kGIngETtB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 973c2d60254e9548b4f8568e1a349f3852315dd5  efi/x86: Add a quirk to support command line arguments on Dell EFI firmware

elapsed time: 1230m

configs tested: 126
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         socfpga_defconfig
sh                          r7785rp_defconfig
s390                             alldefconfig
mips                        nlm_xlp_defconfig
microblaze                    nommu_defconfig
sh                           se7780_defconfig
i386                             alldefconfig
powerpc                     tqm5200_defconfig
m68k                        m5407c3_defconfig
mips                     loongson1c_defconfig
powerpc                       holly_defconfig
mips                      maltaaprp_defconfig
powerpc                      ep88xc_defconfig
arm                              zx_defconfig
h8300                            alldefconfig
microblaze                          defconfig
sh                   rts7751r2dplus_defconfig
mips                      maltasmvp_defconfig
arm                         shannon_defconfig
arm                         ebsa110_defconfig
arm                          gemini_defconfig
arc                           tb10x_defconfig
powerpc                     tqm8560_defconfig
xtensa                    xip_kc705_defconfig
arm                        spear6xx_defconfig
mips                           jazz_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc64e_defconfig
powerpc                     pq2fads_defconfig
sh                          rsk7269_defconfig
mips                         db1xxx_defconfig
powerpc                       ppc64_defconfig
mips                          rb532_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
powerpc                       eiger_defconfig
arm                      integrator_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      katmai_defconfig
sh                        apsh4ad0a_defconfig
powerpc                         wii_defconfig
arm                          exynos_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc8313_rdb_defconfig
um                             i386_defconfig
arm                         assabet_defconfig
mips                      pistachio_defconfig
m68k                          multi_defconfig
powerpc                      chrp32_defconfig
sh                          landisk_defconfig
mips                            ar7_defconfig
mips                        jmr3927_defconfig
mips                       lemote2f_defconfig
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
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200916
x86_64               randconfig-a004-20200916
x86_64               randconfig-a003-20200916
x86_64               randconfig-a002-20200916
x86_64               randconfig-a001-20200916
x86_64               randconfig-a005-20200916
i386                 randconfig-a004-20200916
i386                 randconfig-a006-20200916
i386                 randconfig-a003-20200916
i386                 randconfig-a001-20200916
i386                 randconfig-a002-20200916
i386                 randconfig-a005-20200916
i386                 randconfig-a015-20200916
i386                 randconfig-a014-20200916
i386                 randconfig-a011-20200916
i386                 randconfig-a013-20200916
i386                 randconfig-a016-20200916
i386                 randconfig-a012-20200916
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20200916
x86_64               randconfig-a011-20200916
x86_64               randconfig-a016-20200916
x86_64               randconfig-a012-20200916
x86_64               randconfig-a015-20200916
x86_64               randconfig-a013-20200916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
