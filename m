Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F1663D77A
	for <lists+linux-efi@lfdr.de>; Wed, 30 Nov 2022 15:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiK3OEC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Nov 2022 09:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiK3ODc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Nov 2022 09:03:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5963748F7
        for <linux-efi@vger.kernel.org>; Wed, 30 Nov 2022 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669817001; x=1701353001;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tKpOFF3n+WGOz15t3IUx43Yw3sW/SIspXNKVRCVDgUQ=;
  b=RFa4hydb7oU4FEO2K+XEElqZXuoaWcOKwEU/cPT4QZ9EMbN6kUJNbsrF
   fqAtOoVto/yZOsf8ymcL4kVIqQRKEF/1NO2m3eTuKKfwEH8ksruxPGaOx
   mt+UZddpar1Xv6eMc8RJZh/fvJDmgiaUE1hGPuFdBmtM1GLhWjJ5qtoDq
   nHhKJm0QmxmAVX0jCoj+A/uuhErBlaiYhbaY5VbULfcpUTqPeczsIekLw
   t4LeaaYfh3Md3ZXmX+lsanQjU/Ij8kWeLzRGd9QL0aewzqD5SRupH155S
   f7S4sn8+p0HWU26FZ85poXHnoU9yiC6bseGWES7sa6dH4hWse99JU247M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="314093200"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="314093200"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 06:03:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="621890677"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="621890677"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2022 06:03:16 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0NgC-000BF5-0t;
        Wed, 30 Nov 2022 14:03:16 +0000
Date:   Wed, 30 Nov 2022 22:03:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 be2cf04496bb8a608e54d8259531ccdf72123dbc
Message-ID: <638762a0.dG6W7AIirc9Skyxh%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: be2cf04496bb8a608e54d8259531ccdf72123dbc  arm64: efi: Make runtime service wrapper more robust

elapsed time: 743m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
i386                             allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
ia64                             allmodconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a001-20221128
i386                 randconfig-a005-20221128
i386                 randconfig-a006-20221128
i386                 randconfig-a004-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a002-20221128
x86_64               randconfig-a002-20221128
x86_64               randconfig-a001-20221128
x86_64               randconfig-a004-20221128
x86_64               randconfig-a006-20221128
x86_64               randconfig-a005-20221128
x86_64               randconfig-a003-20221128
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
i386                 randconfig-a012-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a015-20221128
i386                 randconfig-a016-20221128
s390                 randconfig-r044-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
hexagon              randconfig-r045-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
