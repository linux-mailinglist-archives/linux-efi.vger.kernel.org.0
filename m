Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3D71FEA83
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jun 2020 06:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgFRE7J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Jun 2020 00:59:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:62534 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgFRE7J (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Jun 2020 00:59:09 -0400
IronPort-SDR: D61boK8TUmp3DRUWU6GaCQXJrN4ua11S08HEIt0rSSfHCXn4a1E80S3e5aNz5N+EAeKWDatPvJ
 hf1Z2RlveB0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="143945317"
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="143945317"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 21:59:07 -0700
IronPort-SDR: WW1Il2VLt6dOrtyu/wl/UmbszEQ3cM1WZBJy0m0aLnsklETgBYB5gz2BegSTKIC/uUf0jGyz7H
 Sj7KP3BcNukw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="262798119"
Received: from lkp-server02.sh.intel.com (HELO 5ce11009e457) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Jun 2020 21:59:06 -0700
Received: from kbuild by 5ce11009e457 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jlmdl-00004o-Qy; Thu, 18 Jun 2020 04:59:05 +0000
Date:   Thu, 18 Jun 2020 12:58:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 2a55280a3675203496d302463b941834228b9875
Message-ID: <5eeaf48e.1cMPpkd63W/dO/Q4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  urgent
branch HEAD: 2a55280a3675203496d302463b941834228b9875  efi/libstub: arm: Print CPU boot mode and MMU state at boot

elapsed time: 720m

configs tested: 91
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
sh                          polaris_defconfig
arm                         bcm2835_defconfig
ia64                                defconfig
parisc                generic-64bit_defconfig
arm                       spear13xx_defconfig
arc                          axs103_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
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
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
