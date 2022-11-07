Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A494361F3A6
	for <lists+linux-efi@lfdr.de>; Mon,  7 Nov 2022 13:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiKGMrv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Nov 2022 07:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKGMrv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Nov 2022 07:47:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B3E1BEAA
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 04:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667825267; x=1699361267;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5tZbfewVw7CMvcd/V8i6Uu1yp37uFAYKM1+zGSGcLhg=;
  b=NfcF13lc84xj3DrXdBIfukLP0fvxPce4eZJWFRdG6VJTpfoRZepDW7Dj
   BnCBd/uyvYe8AhVttwLXfkb03TQD6uQaISujBZSg+oBjdjXdyaCG+AZpT
   A1iB0Vb7z0rcth34Qo4kQaGTmU3tcNBAU3WuhlRiMFusT2G+3J7IG/+2H
   iVhgQff7cG7bXpNlSruQk9Wx8GxvXKWrdrZtPBoeH83ZQ9SQ+qSFDW61+
   FmNoIYQg8UujYufvIBtqVXqmSmUtPGpH15y2dgGFppOTAiARLy9yf0RPi
   BvfdlBUkil7aIvgvCq5CEhNiqG+YlQOF55jx64YbUxAAhe7VI3Rgz1Toq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="311534771"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="311534771"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 04:47:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="669124960"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="669124960"
Received: from lkp-server01.sh.intel.com (HELO 462403710aa9) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2022 04:47:45 -0800
Received: from kbuild by 462403710aa9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1os1XV-0000gi-0D;
        Mon, 07 Nov 2022 12:47:45 +0000
Date:   Mon, 07 Nov 2022 20:47:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 1bf039df2f63402adb365f59383fe9d34e2ef641
Message-ID: <6368fe63.HlBqltrEZ1JLfFla%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 1bf039df2f63402adb365f59383fe9d34e2ef641  arm64: efi: Fix handling of misaligned runtime regions and drop warning

elapsed time: 722m

configs tested: 64
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-a001-20221107
i386                 randconfig-a006-20221107
i386                 randconfig-a003-20221107
i386                 randconfig-a002-20221107
i386                 randconfig-a005-20221107
i386                 randconfig-a004-20221107
ia64                             allmodconfig
i386                 randconfig-c001-20221107
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
m68k                         apollo_defconfig
powerpc                     taishan_defconfig
arm                         lpc18xx_defconfig
mips                         rt305x_defconfig
sh                          sdk7786_defconfig
sh                         microdev_defconfig
microblaze                      mmu_defconfig
csky                             alldefconfig
ia64                      gensparse_defconfig
sh                     magicpanelr2_defconfig

clang tested configs:
i386                 randconfig-a013-20221107
i386                 randconfig-a015-20221107
i386                 randconfig-a016-20221107
i386                 randconfig-a011-20221107
i386                 randconfig-a014-20221107
i386                 randconfig-a012-20221107
x86_64               randconfig-a014-20221107
x86_64               randconfig-a011-20221107
x86_64               randconfig-a013-20221107
x86_64               randconfig-a012-20221107
x86_64               randconfig-a015-20221107
x86_64               randconfig-a016-20221107
mips                     cu1000-neo_defconfig
arm                         orion5x_defconfig
powerpc                    mvme5100_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
