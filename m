Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1746C618FFF
	for <lists+linux-efi@lfdr.de>; Fri,  4 Nov 2022 06:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiKDF25 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Nov 2022 01:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKDF2y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Nov 2022 01:28:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA1D1CB32
        for <linux-efi@vger.kernel.org>; Thu,  3 Nov 2022 22:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667539733; x=1699075733;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=x3hjLkd0Hu7LY0zWjSvqExwY4zFQCS2VEwS1N3dV9QA=;
  b=MVAPx1CbUOlLhLBnbiMiz0wH56KihyMaeQqqp/a1ZkNayj3AJsq2UVmp
   aUltzT8FTD1beYPw6baypVgo40deQOHwtzBpeFlKeN7o0O3TMCLef0OQ4
   nvTt3bvTEUnU1ZzoNJwNKOEw9MPEUpi4asnhB1X3x0OzLK2+gfrQgeaD5
   h4zCsweL0P9pAHKVnJsZzSu81asozud1ix9L0LY+rTgssmIPW2jMy6kjB
   IkQQQVXhOtephJoi5zOfnO5B5D58ZzpqJ6X3v6LQ1RmKRjcYSpLYSuWZI
   v2NpUKtZ9p4iPtpFP82QsyoN5CnXgP7TSseKJMZ9tzbnMqQEZroS46YER
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308597804"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="308597804"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 22:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="964219315"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="964219315"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 03 Nov 2022 22:28:52 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqpG7-000Ge9-35;
        Fri, 04 Nov 2022 05:28:51 +0000
Date:   Fri, 04 Nov 2022 13:28:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 23715a26c8d812912a70c6ac1ce67af649b95914
Message-ID: <6364a306.u6Xj2gDwFI8jSTJn%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 23715a26c8d812912a70c6ac1ce67af649b95914  arm64: efi: Recover from synchronous exceptions occurring in firmware

elapsed time: 721m

configs tested: 82
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
ia64                             allmodconfig
m68k                             allmodconfig
i386                                defconfig
arc                              allyesconfig
x86_64                        randconfig-a002
alpha                            allyesconfig
s390                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                              defconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
arm                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
arc                  randconfig-r043-20221103
i386                          randconfig-a005
arm                              allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
arm64                            allyesconfig
x86_64                        randconfig-a011
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
i386                          randconfig-c001
arm                       imx_v6_v7_defconfig
arm                        multi_v7_defconfig
sh                          r7785rp_defconfig
sh                        sh7763rdp_defconfig
arm                            lart_defconfig
nios2                               defconfig
powerpc                     asp8347_defconfig
mips                      fuloong2e_defconfig
mips                            gpr_defconfig
riscv                randconfig-r042-20221102
arc                  randconfig-r043-20221102
s390                 randconfig-r044-20221102
arm                           u8500_defconfig
nios2                         10m50_defconfig
powerpc                   currituck_defconfig
mips                         cobalt_defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20221103
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r041-20221103
riscv                randconfig-r042-20221103
s390                 randconfig-r044-20221103
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a016
i386                          randconfig-a013
arm                   milbeaut_m10v_defconfig
i386                          randconfig-a011
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
i386                          randconfig-a015
riscv                          rv32_defconfig
arm                         bcm2835_defconfig
arm                         s3c2410_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
