Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E7641461
	for <lists+linux-efi@lfdr.de>; Sat,  3 Dec 2022 06:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiLCFzo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Dec 2022 00:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLCFzn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 3 Dec 2022 00:55:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867D65A7
        for <linux-efi@vger.kernel.org>; Fri,  2 Dec 2022 21:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670046942; x=1701582942;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JGWuiGy2nzdW5jZlhNvtGQ568x3Xvped/W5ZnXaSkSo=;
  b=LnakgCAcaUZtKrM3erq71UlikiYJI7FNc0t3ZxbBVHzSMtYRBZ8N+DGn
   x/b4YVB9PznxtXjhVz00MEpVmqi5729phWnaW991dKEPDDQrHuUnOclu5
   hwoMPByMaBzxF0Feu0EmslYH5zrRf1MSMR/o31AK/HLqRJf3KHp9rTO3y
   1ROcLLJBHoyZrFxbvPwRneNnb8QpoYTSm3YQAcFSPe357o0g3bSkwocnn
   33JJ8B8tS/5aeFFsMX28eOe55bATIPtuOdah/yMloGEQ3FyXL5yHZJ8zM
   Q4bz0APQe4FAbOZMYAV19OJkCVe/svJz5VTrDBuj2anaaf51SBp3J4KRC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="317956010"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="317956010"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 21:55:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="647408924"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="647408924"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Dec 2022 21:55:40 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1LUy-000EK3-0U;
        Sat, 03 Dec 2022 05:55:40 +0000
Date:   Sat, 03 Dec 2022 13:54:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 6736ebb6e18898978f8e49d6ee9662e34993e176
Message-ID: <638ae4b0.KSqfHBsRqnZTR2pO%lkp@intel.com>
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
branch HEAD: 6736ebb6e18898978f8e49d6ee9662e34993e176  arm64: efi: Recover from synchronous exceptions occurring in firmware

elapsed time: 725m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20221201
x86_64                              defconfig
s390                 randconfig-r044-20221201
riscv                randconfig-r042-20221201
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a004
x86_64                        randconfig-a015
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
m68k                             allmodconfig
x86_64                        randconfig-a006
i386                          randconfig-a005
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                            allnoconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001

clang tested configs:
hexagon              randconfig-r041-20221201
hexagon              randconfig-r045-20221201
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
