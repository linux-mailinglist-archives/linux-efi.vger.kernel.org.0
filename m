Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1D5627B1D
	for <lists+linux-efi@lfdr.de>; Mon, 14 Nov 2022 11:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiKNKzb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Nov 2022 05:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKNKza (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Nov 2022 05:55:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4511A3B1
        for <linux-efi@vger.kernel.org>; Mon, 14 Nov 2022 02:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668423329; x=1699959329;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7W8YIzdBtsrg31uE7vwK+bdH1vJTxnMNL3EKCLOcEFg=;
  b=Pca5BOE9tB5rpF2Y66YXdNa09MAafwZf9zbUmYWqnxkWFxoU91XXewsN
   FMX3Cpw2/CCBN6reU4FeU0E50dbT3pdwK4opdjZUisahDYBFoMjsEdfgf
   32EFEWIno0DOnYM+OwWzzbhyW2fy7DwUA+dEG0sd6NAc1JDn7dVZZP8Ay
   gdrBtLWv4y4vN7aARw31tLCErGTjxBOmhcUtaJ7wb5dOFvJ8EeNDEZr/Z
   qljAgE7l0SJOa9gvM+8AbjdXpY3mlhzCoGyhpbutYA2v9RAcdpQUdRhb/
   tC1TTtUDzS7Tkqwrn0hKShV4cBHP4j7aqPcInUwMUw//glbiow1QALop7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="398230949"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="398230949"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 02:55:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="669603509"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="669603509"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Nov 2022 02:55:28 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ouX7f-0000Gv-1I;
        Mon, 14 Nov 2022 10:55:27 +0000
Date:   Mon, 14 Nov 2022 18:54:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS c5fa6df0a498e363200988cb4d2146ac168fcc0e
Message-ID: <63721e7e.NXMdT7+TmjIiF+GK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: c5fa6df0a498e363200988cb4d2146ac168fcc0e  efi: random: combine bootloader provided RNG seed with RNG protocol output

elapsed time: 725m

configs tested: 87
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
x86_64                              defconfig
ia64                             allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20221114
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a004-20221114
x86_64               randconfig-a002-20221114
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
x86_64               randconfig-a001-20221114
x86_64                          rhel-8.3-func
i386                 randconfig-a002-20221114
i386                             allyesconfig
i386                 randconfig-a005-20221114
x86_64               randconfig-a004-20221114
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a005-20221114
m68k                             allmodconfig
i386                 randconfig-a003-20221114
arc                              allyesconfig
x86_64                           allyesconfig
i386                 randconfig-a006-20221114
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
x86_64               randconfig-a003-20221114
x86_64               randconfig-a006-20221114
m68k                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
riscv                randconfig-r042-20221113
arc                  randconfig-r043-20221113
arc                  randconfig-r043-20221114
s390                 randconfig-r044-20221113
x86_64                            allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm                        mini2440_defconfig
m68k                        mvme147_defconfig
sh                            migor_defconfig
sh                         microdev_defconfig
sh                         ecovec24_defconfig
sh                        edosk7760_defconfig
mips                           ip32_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                           sun3_defconfig
arm                           tegra_defconfig
nios2                            allyesconfig
powerpc                     pq2fads_defconfig
arm                           viper_defconfig
arc                                 defconfig
s390                             allmodconfig
powerpc                     ep8248e_defconfig
sh                          r7785rp_defconfig
sparc64                          alldefconfig
alpha                               defconfig
s390                                defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
i386                 randconfig-c001-20221114
s390                             allyesconfig

clang tested configs:
i386                 randconfig-a011-20221114
i386                 randconfig-a013-20221114
i386                 randconfig-a012-20221114
i386                 randconfig-a015-20221114
x86_64               randconfig-a012-20221114
i386                 randconfig-a014-20221114
i386                 randconfig-a016-20221114
x86_64               randconfig-a013-20221114
x86_64               randconfig-a011-20221114
x86_64               randconfig-a014-20221114
x86_64               randconfig-a016-20221114
x86_64               randconfig-a015-20221114
hexagon              randconfig-r041-20221113
hexagon              randconfig-r045-20221114
hexagon              randconfig-r045-20221113
hexagon              randconfig-r041-20221114
riscv                randconfig-r042-20221114
s390                 randconfig-r044-20221114
x86_64                        randconfig-k001
mips                       lemote2f_defconfig
powerpc                     kilauea_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
