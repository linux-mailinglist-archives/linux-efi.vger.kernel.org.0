Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A385261D9A8
	for <lists+linux-efi@lfdr.de>; Sat,  5 Nov 2022 12:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKELYb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Nov 2022 07:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKELYa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Nov 2022 07:24:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640CB1C914
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 04:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667647469; x=1699183469;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X20jRquDiFxxO1pPX+7j51QPkpKCsd3gdjs9BUW8bR0=;
  b=mToEtkEpGsKTTVfhtn3YU6Kk+QD/FK45HusJkySewyRv/o/tyG3j6Iue
   QRHpd+HdfxQdwzdhclD/uMIl+O+MgAxCefS84OaSG4VbnQoKIYSm0s31I
   shk9/FMBcxwYKFjo8rLPBRjGd13e4v0WpU7UHezbLky81ypNDj2lqbwO3
   yaXioxOj+CTzz7Nnc4Xf53PZ+c9K4JmVZ6jXJO4EwQ4OQZNbPhaRF1SZb
   TRt5ZV+bz1zSQhCK2YXJ2j3X548zMnsnWwTicn8caNyVQ3XY7ipiyF5d1
   VXlWRnL6hzLHX3q5vFNvkbNqk587eNrRVSnoJZRTxMCjE14HZ6PIjfpFR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="396456738"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="396456738"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 04:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="613357518"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="613357518"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2022 04:24:27 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1orHHm-000Hw0-1B;
        Sat, 05 Nov 2022 11:24:26 +0000
Date:   Sat, 05 Nov 2022 19:24:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS c804d4906e8a3749aa2aa91219362862ad54c8c0
Message-ID: <636647dd.4IABslkFY9JD+gyT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: c804d4906e8a3749aa2aa91219362862ad54c8c0  efi: libstub: Merge zboot decompressor with the ordinary stub

elapsed time: 723m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                             allmodconfig
arc                  randconfig-r043-20221104
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a001
i386                          randconfig-a003
s390                 randconfig-r044-20221104
riscv                randconfig-r042-20221104
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                               rhel-8.3
i386                          randconfig-a005
x86_64                              defconfig
x86_64                        randconfig-a015
powerpc                           allnoconfig
powerpc                          allmodconfig
s390                             allyesconfig
ia64                             allmodconfig
mips                             allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
i386                                defconfig
i386                          randconfig-a014
i386                          randconfig-a012
sh                               allmodconfig
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
i386                             allyesconfig
m68k                       m5208evb_defconfig
sh                   sh7724_generic_defconfig
powerpc                   currituck_defconfig
m68k                           sun3_defconfig
csky                                defconfig
nios2                         10m50_defconfig
m68k                       m5249evb_defconfig
ia64                         bigsur_defconfig
arm                            qcom_defconfig
i386                          randconfig-c001
powerpc                      ppc40x_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 linkstation_defconfig
arm                         cm_x300_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20221104
hexagon              randconfig-r045-20221104
i386                          randconfig-a002
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
mips                        bcm63xx_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
