Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393CB17D1EF
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 06:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgCHFry (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 00:47:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:8417 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgCHFry (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 00:47:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 21:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,528,1574150400"; 
   d="scan'208";a="276093722"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Mar 2020 21:47:51 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jAon1-0005W8-9j; Sun, 08 Mar 2020 13:47:51 +0800
Date:   Sun, 08 Mar 2020 13:47:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD REGRESSION
 dfb2a1c61fcdc8be5dd74608c411c78008a0f078
Message-ID: <5e6486dd.mJYU1oLaZtl8LrQi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
branch HEAD: dfb2a1c61fcdc8be5dd74608c411c78008a0f078  partitions/efi: Fix partition name parsing in GUID partition entry

Regressions in current branch:

drivers/firmware/efi/libstub/file.c:81 efi_open_volume() error: potentially dereferencing uninitialized 'io'.
drivers/firmware/efi/libstub/x86-stub.c:187 retrieve_apple_device_properties() error: potentially dereferencing uninitialized 'p'.
drivers/firmware/efi/libstub/x86-stub.c:392 efi_pe_entry() error: potentially dereferencing uninitialized 'image'.

Error ids grouped by kconfigs:

recent_errors
`-- x86_64-defconfig
    |-- drivers-firmware-efi-libstub-file.c-efi_open_volume()-error:potentially-dereferencing-uninitialized-io-.
    |-- drivers-firmware-efi-libstub-x86-stub.c-efi_pe_entry()-error:potentially-dereferencing-uninitialized-image-.
    `-- drivers-firmware-efi-libstub-x86-stub.c-retrieve_apple_device_properties()-error:potentially-dereferencing-uninitialized-p-.

elapsed time: 484m

configs tested: 92
configs skipped: 84

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
sparc                            allyesconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
i386                 randconfig-a003-20200308
i386                 randconfig-a001-20200308
x86_64               randconfig-a001-20200308
x86_64               randconfig-a003-20200308
i386                 randconfig-a002-20200308
x86_64               randconfig-a002-20200308
riscv                randconfig-a001-20200308
m68k                 randconfig-a001-20200308
alpha                randconfig-a001-20200308
mips                 randconfig-a001-20200308
nds32                randconfig-a001-20200308
parisc               randconfig-a001-20200308
sparc64              randconfig-a001-20200308
microblaze           randconfig-a001-20200308
c6x                  randconfig-a001-20200308
nios2                randconfig-a001-20200308
h8300                randconfig-a001-20200308
openrisc             randconfig-a001-20200308
sh                   randconfig-a001-20200308
csky                 randconfig-a001-20200308
s390                 randconfig-a001-20200308
xtensa               randconfig-a001-20200308
x86_64               randconfig-b001-20200308
x86_64               randconfig-b002-20200308
i386                 randconfig-b001-20200308
i386                 randconfig-b003-20200308
x86_64               randconfig-b003-20200308
i386                 randconfig-b002-20200308
i386                 randconfig-c001-20200308
x86_64               randconfig-c003-20200308
i386                 randconfig-c002-20200308
x86_64               randconfig-c002-20200308
i386                 randconfig-c003-20200308
x86_64               randconfig-c001-20200308
i386                 randconfig-d001-20200308
x86_64               randconfig-d003-20200308
x86_64               randconfig-d001-20200308
i386                 randconfig-d003-20200308
x86_64               randconfig-d002-20200308
i386                 randconfig-d002-20200308
i386                 randconfig-e001-20200308
i386                 randconfig-e003-20200308
x86_64               randconfig-e002-20200308
x86_64               randconfig-e001-20200308
i386                 randconfig-e002-20200308
x86_64               randconfig-e003-20200308
i386                 randconfig-f003-20200308
x86_64               randconfig-f001-20200308
i386                 randconfig-f002-20200308
i386                 randconfig-f001-20200308
x86_64               randconfig-f002-20200308
x86_64               randconfig-f003-20200308
i386                 randconfig-g001-20200308
x86_64               randconfig-g003-20200308
i386                 randconfig-g003-20200308
x86_64               randconfig-g001-20200308
x86_64               randconfig-g002-20200308
i386                 randconfig-g002-20200308
i386                 randconfig-h001-20200308
x86_64               randconfig-h001-20200308
x86_64               randconfig-h002-20200308
x86_64               randconfig-h003-20200308
i386                 randconfig-h003-20200308
i386                 randconfig-h002-20200308
arc                  randconfig-a001-20200308
sparc                randconfig-a001-20200308
ia64                 randconfig-a001-20200308
arm                  randconfig-a001-20200308
arm64                randconfig-a001-20200308
powerpc              randconfig-a001-20200308
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
