Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E71547269
	for <lists+linux-efi@lfdr.de>; Sat, 11 Jun 2022 08:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiFKGtO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Jun 2022 02:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiFKGtM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Jun 2022 02:49:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3D62DAA8
        for <linux-efi@vger.kernel.org>; Fri, 10 Jun 2022 23:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654930149; x=1686466149;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zFmdPxLMWYpZr9styXgMiIURGi3antOM0dZ3j7vBVao=;
  b=PnI/40UPaSxAKfjdTPPnMPDVn0GwGoQrH7BV5LPsM92RgdE8YvnuVTYc
   gLVUYi3h2RtZw2abI/m4FeOVOu5Lkm1VvsKPz+NjOhBQgVAWH0tFnnwMu
   yWZk6lLpQjPplIGHGQ+bITAD9br9hxMtBvksTyfqRmPCnHTtQBTtiuF5y
   naYLtzhBdSzjUsVSj/MErekqaQa3Wq8jxQeZ46UraUqormYv2+kCkxUwi
   jYzaaM87jZd9RBd79w7ND6SLuakm15QzMLxmyZH7Yp1IF2I5quj5KzucZ
   oEWax2gsg6g4PdhEYKbnsKsgGy+UDkfQDTQkO2sWlY4mOOYtXyV3YaAvE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="341888162"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="341888162"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 23:49:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="760850649"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Jun 2022 23:49:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzuvg-000Ict-GX;
        Sat, 11 Jun 2022 06:49:04 +0000
Date:   Sat, 11 Jun 2022 14:48:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 05c800c26b21e089e22e1738ea28568a2be5bd61
Message-ID: <62a43ad8.gzKQ87Hqlb4haHg3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 05c800c26b21e089e22e1738ea28568a2be5bd61  efi/x86: libstub: Fix typo in __efi64_argmap* name

elapsed time: 1250m

configs tested: 87
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arc                         haps_hs_defconfig
mips                          rb532_defconfig
ia64                         bigsur_defconfig
m68k                        m5272c3_defconfig
sh                            titan_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         tb0226_defconfig
sh                           se7750_defconfig
powerpc                 linkstation_defconfig
powerpc64                           defconfig
sh                          rsk7201_defconfig
powerpc                 canyonlands_defconfig
sh                          lboxre2_defconfig
arm                          pxa3xx_defconfig
sh                              ul2_defconfig
xtensa                  cadence_csp_defconfig
sh                               alldefconfig
powerpc                      ep88xc_defconfig
um                           x86_64_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                    socrates_defconfig
powerpc                     ppa8548_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                             mxs_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
