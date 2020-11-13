Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4D2B180F
	for <lists+linux-efi@lfdr.de>; Fri, 13 Nov 2020 10:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgKMJTS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Nov 2020 04:19:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:29625 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgKMJTQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 13 Nov 2020 04:19:16 -0500
IronPort-SDR: xwgaRedxZRwoa569nX/F4DqKYw4VL4dU2kn24+c0ZdqUBqmRhMIDA0GFLO6tlqvCzYF3zc3Pqu
 ZvG3J8k6rGYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="255157138"
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="255157138"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 01:19:13 -0800
IronPort-SDR: 8n+GAYOobawYLL7sFrjX0xAvrJmESU8ukN0G6IRVRZ2nOSTXYbiebU6IjG9h2irM+Vraz1hCb9
 Hj7/5s4BRiIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="309545879"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 13 Nov 2020 01:19:12 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdVEd-0000Bd-NQ; Fri, 13 Nov 2020 09:19:11 +0000
Date:   Fri, 13 Nov 2020 17:18:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 6548316ad15bfbe63a66ec61bc4d1b98bf06bbaa
Message-ID: <5fae4f7f.BgT5vpYOmsnFCACZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: 6548316ad15bfbe63a66ec61bc4d1b98bf06bbaa  efi: efivars: remove deprecated sysfs interface

elapsed time: 725m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v4_v5_defconfig
sh                                  defconfig
powerpc                    adder875_defconfig
m68k                       m5208evb_defconfig
mips                            gpr_defconfig
arm                           efm32_defconfig
mips                         tb0287_defconfig
powerpc                      arches_defconfig
c6x                         dsk6455_defconfig
powerpc                     kmeter1_defconfig
mips                malta_kvm_guest_defconfig
i386                             alldefconfig
mips                        maltaup_defconfig
powerpc                        warp_defconfig
arm                         mv78xx0_defconfig
powerpc                      obs600_defconfig
arm64                            alldefconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     tqm8548_defconfig
sh                        sh7785lcr_defconfig
arm                         orion5x_defconfig
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
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a003-20201113
x86_64               randconfig-a005-20201113
x86_64               randconfig-a004-20201113
x86_64               randconfig-a002-20201113
x86_64               randconfig-a006-20201113
x86_64               randconfig-a001-20201113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
