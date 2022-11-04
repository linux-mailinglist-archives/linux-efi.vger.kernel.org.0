Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05CF618FFE
	for <lists+linux-efi@lfdr.de>; Fri,  4 Nov 2022 06:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKDF24 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Nov 2022 01:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKDF2y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Nov 2022 01:28:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7760205F9
        for <linux-efi@vger.kernel.org>; Thu,  3 Nov 2022 22:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667539733; x=1699075733;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=keU5eXqSltRfy0uD2flDp2lncnxzrdXcvS3az9s72W8=;
  b=b8uEOTuqFxrPUlT6GSa5723Kdu7jxWXJGjS53PwxMwjeeUHE0bVliPNz
   oPDuFfOaNkZdCl9qR6ibwW9Mva6PXGYXmtC9HCMGbTI5OLFfzhnIsgLMr
   Ehx0osZtek8Jzfu5RYyl56x9comryfaanzfy6Uqj4weO7/l0E0xNx7sWl
   iXaITe8iZv/P9xtZwqGbphKYstJD0bd6PEJaz3rLnbL3wjDk8sQZMCPAR
   FghNTUcmR8LyiZj/26+vCt4ejCw+3Sq/7y3njB+HTkCcaxwXO+muiIz1K
   8LHcBXkxrxpospI+iJmfuV229Hls7aifHBdSeSf4L6in0JBWwP8Wl3S62
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="289602141"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="289602141"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 22:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="777593622"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="777593622"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Nov 2022 22:28:52 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqpG8-000GeF-04;
        Fri, 04 Nov 2022 05:28:52 +0000
Date:   Fri, 04 Nov 2022 13:28:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 1abdc82f0c773bef2f58b9f00b03e75e9d4dd28b
Message-ID: <6364a307.zaPXEG6asXlYPfQi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 1abdc82f0c773bef2f58b9f00b03e75e9d4dd28b  efi: pstore: Add module parameter for setting the record size

elapsed time: 722m

configs tested: 80
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
ia64                             allmodconfig
s390                                defconfig
s390                             allmodconfig
i386                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a002
s390                             allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
arc                              allyesconfig
x86_64                        randconfig-a004
powerpc                           allnoconfig
powerpc                          allmodconfig
alpha                            allyesconfig
i386                          randconfig-a001
mips                             allyesconfig
i386                          randconfig-a003
x86_64                               rhel-8.3
arc                  randconfig-r043-20221102
m68k                             allyesconfig
s390                 randconfig-r044-20221102
i386                          randconfig-a005
x86_64                           allyesconfig
riscv                randconfig-r042-20221102
i386                             allyesconfig
sh                               allmodconfig
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
i386                          randconfig-c001
m68k                             allmodconfig
arm                       imx_v6_v7_defconfig
arm                        multi_v7_defconfig
sh                          r7785rp_defconfig
sh                        sh7763rdp_defconfig
arm                            lart_defconfig
nios2                               defconfig
powerpc                     asp8347_defconfig
mips                      fuloong2e_defconfig
mips                            gpr_defconfig
arm                           u8500_defconfig
nios2                         10m50_defconfig
powerpc                   currituck_defconfig
mips                         cobalt_defconfig
parisc                           allyesconfig
powerpc                     rainier_defconfig
x86_64                           alldefconfig
powerpc                 mpc837x_mds_defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221102
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r045-20221102
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
arm                   milbeaut_m10v_defconfig
riscv                          rv32_defconfig
arm                         bcm2835_defconfig
arm                         s3c2410_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
