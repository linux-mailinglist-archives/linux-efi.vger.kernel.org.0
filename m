Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82BE6261DD
	for <lists+linux-efi@lfdr.de>; Fri, 11 Nov 2022 20:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiKKT2W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Nov 2022 14:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKKT2V (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Nov 2022 14:28:21 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FF667F4F
        for <linux-efi@vger.kernel.org>; Fri, 11 Nov 2022 11:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668194901; x=1699730901;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HOeg0aET4Nk7/Uip/zBM65nweNWnryBWRsk2a+Dk9rw=;
  b=AIeaUHQsvhelRCMZkeGLJqV8kt0zUjqZXDUH6I0My6DlQHTRQSJvSOCn
   /KUh2/vx6deBp9YOXrVWWNYpXG7oOF+O2k/5hffMJKLv2tYWZ0Yo8nMmw
   MlRsNUkCDFohBi3xbkRvO7pGOUxP29NtNl1imhpm9vVWve6vpFarFolA+
   e0d/v6PRr1ImFYHvs9aKhwgZP/fdUjcIUvrtABtHHVVrYYAmiI3hR9o84
   lfSMl/41MR+EGOaVl6Jq6yQQ84A9d0ETGGbYiJ/o3oXAuYWeQQZmnabDm
   nC86D8OYyGeZde+B4h1JXJA+PQz86IRA8j5UWDzcjHO25W1c57lEdA7Ud
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="373784832"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="373784832"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 11:28:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="668893496"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="668893496"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2022 11:28:19 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otZhK-0004ET-2q;
        Fri, 11 Nov 2022 19:28:18 +0000
Date:   Sat, 12 Nov 2022 03:27:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 82da66a9913ef37c300d2e44ebc3b4814120d24b
Message-ID: <636ea228.RrT90V3vrl8RcDgr%lkp@intel.com>
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
branch HEAD: 82da66a9913ef37c300d2e44ebc3b4814120d24b  Merge branch 'efi/urgent' into efi/next

elapsed time: 721m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
x86_64                               rhel-8.3
um                             i386_defconfig
x86_64                              defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                           allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
s390                                defconfig
x86_64                          rhel-8.3-func
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
arc                  randconfig-r043-20221111
riscv                randconfig-r042-20221111
s390                 randconfig-r044-20221111
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a004
m68k                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a014
i386                          randconfig-a003
i386                          randconfig-a012
ia64                             allmodconfig
i386                          randconfig-a005
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                            allnoconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                             allyesconfig
i386                                defconfig
powerpc                         ps3_defconfig
xtensa                  cadence_csp_defconfig
sh                         apsh4a3a_defconfig
loongarch                        alldefconfig
nios2                               defconfig
arm                            pleb_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arc                          axs103_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                         alldefconfig
arm                      integrator_defconfig
sh                           se7724_defconfig
arc                          axs101_defconfig
loongarch                 loongson3_defconfig
x86_64                        randconfig-a002
arm                       imx_v6_v7_defconfig
mips                 decstation_r4k_defconfig
arm                        oxnas_v6_defconfig
mips                 randconfig-c004-20221111
m68k                          hp300_defconfig
arm                         at91_dt_defconfig

clang tested configs:
hexagon              randconfig-r045-20221111
hexagon              randconfig-r041-20221111
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-k001
arm                           sama7_defconfig
arm                          pcm027_defconfig
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                           omap1_defconfig
arm                       netwinder_defconfig
mips                        qi_lb60_defconfig
mips                  cavium_octeon_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     ppa8548_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
