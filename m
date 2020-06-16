Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ADD1FC10E
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 23:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFPVgt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Jun 2020 17:36:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:5034 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgFPVgt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Jun 2020 17:36:49 -0400
IronPort-SDR: A0bZfebIxY6oGNHILAj2I8YNvywRdpkW3VIlB8ExVpNmPWse0Ihl+msfXLw3/i+vCpRzE1lKFZ
 cLTadt3JtgqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 14:36:48 -0700
IronPort-SDR: Qcl61OlYR7SNAiSjDfUzak2HHuwkp8nEK77huuTV56YwhtuaS8euprmhHtWaGWSuSqts2XoiIH
 TLJGaWD9CyMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="476610053"
Received: from lkp-server01.sh.intel.com (HELO b4e26a9a4e5e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2020 14:36:46 -0700
Received: from kbuild by b4e26a9a4e5e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jlJG9-0000Fn-RB; Tue, 16 Jun 2020 21:36:45 +0000
Date:   Wed, 17 Jun 2020 05:36:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 188d43ccfa024e061aaef5e57046531344102683
Message-ID: <5ee93b45.cZG8buRS3NX/dXXi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: 188d43ccfa024e061aaef5e57046531344102683  efi/libstub: arm: Print CPU boot mode and MMU state at boot

elapsed time: 481m

configs tested: 101
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                         axm55xx_defconfig
mips                         bigsur_defconfig
mips                      bmips_stb_defconfig
c6x                              allyesconfig
sh                            migor_defconfig
arm                             pxa_defconfig
um                           x86_64_defconfig
mips                      pic32mzda_defconfig
arm                       versatile_defconfig
ia64                      gensparse_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200615
i386                 randconfig-a002-20200615
i386                 randconfig-a001-20200615
i386                 randconfig-a004-20200615
i386                 randconfig-a005-20200615
i386                 randconfig-a003-20200615
i386                 randconfig-a015-20200615
i386                 randconfig-a011-20200615
i386                 randconfig-a014-20200615
i386                 randconfig-a013-20200615
i386                 randconfig-a016-20200615
i386                 randconfig-a012-20200615
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
