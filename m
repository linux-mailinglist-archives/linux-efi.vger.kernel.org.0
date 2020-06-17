Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1234D1FCAA5
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jun 2020 12:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgFQKTc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Jun 2020 06:19:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:28942 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFQKTb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Jun 2020 06:19:31 -0400
IronPort-SDR: C+iYU9fOxfXYRFCQuJ4nvlEKUd/gvSqmUVizZq9Lpei3k1lbOPYs6vHyBVdanBuwoRrO73WEMI
 qSx1PFjhwb+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 03:19:30 -0700
IronPort-SDR: JdUI2psWOjSJWj9gjH37QWoR7cBUPLKcesMCGRO8wcAPBEm3RHeDeAqgQyptpJVMT6GYNEF275
 SXPEyGek9YGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="352032605"
Received: from lkp-server02.sh.intel.com (HELO acd172f646ee) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2020 03:19:29 -0700
Received: from kbuild by acd172f646ee with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jlVAF-00000z-7l; Wed, 17 Jun 2020 10:19:27 +0000
Date:   Wed, 17 Jun 2020 18:19:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 8133582a167a7bb811e7ff723ae5b76657989468
Message-ID: <5ee9ee23.opKYHrwzEVMkxhWg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: 8133582a167a7bb811e7ff723ae5b76657989468  efi/x86: Setup stack correctly for efi_pe_entry

elapsed time: 726m

configs tested: 118
configs skipped: 5

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
sh                                  defconfig
xtensa                    xip_kc705_defconfig
powerpc                      mgcoge_defconfig
c6x                        evmc6678_defconfig
arc                           tb10x_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
arm                       cns3420vb_defconfig
xtensa                              defconfig
sh                          urquell_defconfig
mips                           mtx1_defconfig
mips                       capcella_defconfig
mips                  mips_paravirt_defconfig
mips                      pistachio_defconfig
mips                   sb1250_swarm_defconfig
mips                           ip28_defconfig
mips                           ip27_defconfig
arm                       netwinder_defconfig
sh                           se7721_defconfig
m68k                          hp300_defconfig
powerpc                    mvme5100_defconfig
sh                          r7785rp_defconfig
arm                        magician_defconfig
arm                         ebsa110_defconfig
powerpc                     mpc512x_defconfig
sh                        sh7757lcr_defconfig
arm                           sunxi_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
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
c6x                              allyesconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a006-20200615
i386                 randconfig-a002-20200615
i386                 randconfig-a001-20200615
i386                 randconfig-a004-20200615
i386                 randconfig-a005-20200615
i386                 randconfig-a003-20200615
i386                 randconfig-a015-20200617
i386                 randconfig-a011-20200617
i386                 randconfig-a014-20200617
i386                 randconfig-a016-20200617
i386                 randconfig-a013-20200617
i386                 randconfig-a012-20200617
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
