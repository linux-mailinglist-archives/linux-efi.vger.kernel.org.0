Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE261EA3E
	for <lists+linux-efi@lfdr.de>; Mon,  7 Nov 2022 05:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiKGEqZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Nov 2022 23:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiKGEqY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Nov 2022 23:46:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D24CE1D
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 20:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667796383; x=1699332383;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DOS2dfBfHR9B2PMJLBCa9M2cavoCEE+jZDNlNszyqFU=;
  b=QpwrStMev2aTz66WbRT1d3Gl7ps1CMhWvLFWcjSn0YYbrmFq2ZzqsTTo
   zgWwEdXfxTDiRE6HpT+rgd7wnZjnspaEbv9vAj/Ni/PYDLTPUYpCCwuYt
   jAvqkkgH0WWq1f6xBlAadWJG5/sIQw/AIwEV+aoA7MUa8r4w6gEopzUhO
   VCr6Y8CVMj/OducDHKwI2f9Vedton+cl2wZIt1kZpidksUO2cd7PtAM6i
   AEO34GUPLtRpFj7UqCWb8cDh/iSndsKdPPEJZ/1FoMXA1zqHCVjuJ1fj4
   h4iTEdP9qK83f/GJuwONwP+nI5Mmp+sU6KB37CZ7qrImaPUCFF45YQ+oy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="293669231"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="293669231"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 20:46:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="613732868"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="613732868"
Received: from lkp-server01.sh.intel.com (HELO 462403710aa9) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Nov 2022 20:46:21 -0800
Received: from kbuild by 462403710aa9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oru1c-0000Ki-20;
        Mon, 07 Nov 2022 04:46:20 +0000
Date:   Mon, 07 Nov 2022 12:45:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 27e80a1f89b1b7f6af2f6a46bcb4a3fd9c2b8a14
Message-ID: <63688d75.RtMpihoPw1luuQjH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 27e80a1f89b1b7f6af2f6a46bcb4a3fd9c2b8a14  efi: libstub: Merge zboot decompressor with the ordinary stub

elapsed time: 724m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
arc                  randconfig-r043-20221106
x86_64                           allyesconfig
x86_64                               rhel-8.3
um                             i386_defconfig
s390                 randconfig-r044-20221106
um                           x86_64_defconfig
riscv                randconfig-r042-20221106
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
sh                               allmodconfig
arc                                 defconfig
i386                          randconfig-a016
mips                             allyesconfig
alpha                               defconfig
s390                                defconfig
x86_64                        randconfig-a013
arm                                 defconfig
i386                                defconfig
s390                             allmodconfig
x86_64                        randconfig-a011
m68k                             allmodconfig
x86_64                        randconfig-a015
arc                              allyesconfig
arm                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
s390                             allyesconfig
m68k                             allyesconfig
ia64                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                             allyesconfig
i386                          randconfig-a005
arc                  randconfig-r043-20221107
arc                        nsim_700_defconfig
sh                           se7206_defconfig
sh                          r7780mp_defconfig
sh                           se7722_defconfig
sparc                            alldefconfig
powerpc                      pasemi_defconfig
x86_64               randconfig-a006-20221107
x86_64               randconfig-a001-20221107
x86_64               randconfig-a004-20221107
x86_64               randconfig-a003-20221107
x86_64               randconfig-a005-20221107
x86_64               randconfig-a002-20221107
powerpc                      bamboo_defconfig
sh                          rsk7269_defconfig
arm                           h3600_defconfig
m68k                          amiga_defconfig
arm                             ezx_defconfig
sh                           se7780_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                          iss_defconfig
sh                           se7619_defconfig
powerpc                       holly_defconfig
m68k                            mac_defconfig
m68k                          atari_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                         haps_hs_defconfig
xtensa                generic_kc705_defconfig
riscv                    nommu_k210_defconfig
nios2                            alldefconfig
arm                      jornada720_defconfig
s390                       zfcpdump_defconfig
arm                           imxrt_defconfig
mips                      loongson3_defconfig
nios2                         10m50_defconfig
i386                          randconfig-c001

clang tested configs:
hexagon              randconfig-r041-20221106
hexagon              randconfig-r045-20221106
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001
i386                 randconfig-a016-20221107
i386                 randconfig-a014-20221107
i386                 randconfig-a012-20221107

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
