Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB32626F73
	for <lists+linux-efi@lfdr.de>; Sun, 13 Nov 2022 13:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiKMMXd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Nov 2022 07:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiKMMXc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 13 Nov 2022 07:23:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EEA62DD
        for <linux-efi@vger.kernel.org>; Sun, 13 Nov 2022 04:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668342212; x=1699878212;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=m1YhIzemR5hgoV4xZl7ijeTRiPVh0htmmQfKfKd5+8E=;
  b=lS3LHorQy9QzFXtpYSPxNusnob275Z7GJSF/Lr34vRTeDM+QQXiaEyZ+
   T7mQRGJOkA9C8BAu2776aiSuMUz9Mr9uF88iweg4GIkBixZH5FdZh7f/v
   AKKDK2NH4/Q4tMOmr69fJD4OlZbwPDWhZWCQq+r64k1YpWzKe+S7uVYBA
   dT/DnYmz0xF9pNfDqOilZnxD6RTTUOUAqXJCUQ04yVblx5o/NULj70XmJ
   WrfzGT699y2WKvc6sN9EplUAKJ2xCv80u36YyX7o3mjUDxUd89PPflz0c
   DmOvLDf68Wp6A8x/jedaSOmCVKm2gUxXDmuB/kiYqBsWXlc+Dh0DV1Sv2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="291525310"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="291525310"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 04:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="638110641"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="638110641"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2022 04:23:30 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ouC1J-0005ll-2y;
        Sun, 13 Nov 2022 12:23:29 +0000
Date:   Sun, 13 Nov 2022 20:22:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 2b3df554c475872aa1bf9125428a56aaeb7a0aac
Message-ID: <6370e18b.2qLNQSmeAcDNN+Os%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 2b3df554c475872aa1bf9125428a56aaeb7a0aac  efi: random: combine bootloader provided RNG seed with RNG protocol output

elapsed time: 723m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
i386                                defconfig
x86_64                          rhel-8.3-func
arc                                 defconfig
alpha                               defconfig
m68k                             allmodconfig
um                             i386_defconfig
arc                              allyesconfig
um                           x86_64_defconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221113
x86_64                              defconfig
arm                                 defconfig
m68k                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
s390                 randconfig-r044-20221113
s390                                defconfig
x86_64                        randconfig-a004
i386                          randconfig-a014
x86_64                        randconfig-a002
i386                          randconfig-a001
ia64                             allmodconfig
i386                          randconfig-a003
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20221113
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a013
x86_64                        randconfig-a006
x86_64                        randconfig-a011
i386                          randconfig-a005
s390                             allyesconfig
x86_64                        randconfig-a015
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                            allnoconfig
sh                           se7724_defconfig
m68k                           virt_defconfig
sh                         ecovec24_defconfig
openrisc                         alldefconfig
i386                          randconfig-c001
powerpc                      pcm030_defconfig
sh                   sh7770_generic_defconfig
arc                     nsimosci_hs_defconfig
m68k                          hp300_defconfig
ia64                             alldefconfig
m68k                         apollo_defconfig
m68k                        m5407c3_defconfig
mips                      loongson3_defconfig
arm                          iop32x_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                       ppc64_defconfig
um                               alldefconfig
mips                           ci20_defconfig
powerpc                      cm5200_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
hexagon              randconfig-r041-20221113
hexagon              randconfig-r045-20221113
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a002
x86_64                        randconfig-a016
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a004
powerpc                 mpc8560_ads_defconfig
x86_64                        randconfig-k001
powerpc                          allyesconfig
mips                        qi_lb60_defconfig
mips                        maltaup_defconfig
powerpc                          g5_defconfig
powerpc                      ppc44x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
