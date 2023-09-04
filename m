Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF38C791610
	for <lists+linux-efi@lfdr.de>; Mon,  4 Sep 2023 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjIDLJc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Sep 2023 07:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjIDLJc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Sep 2023 07:09:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322E2CC6
        for <linux-efi@vger.kernel.org>; Mon,  4 Sep 2023 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693825769; x=1725361769;
  h=date:from:to:cc:subject:message-id;
  bh=TgFAPh1g9AfYKH+gu3g4s0P9gFQRp9pdoECW6XxKDYM=;
  b=OJTadTH9Ijv3PqHozdk04iRdJicZnIFkyJbFYLAjguCyC/zBWpnpcn2q
   Rnxc2NTvypJ2LZ1YLjqOgoOaG6bD2G+3nlSlHqRIUuBctaT4KZ2qPfw7l
   e3ATCNWpQ+g+Pfz5+bcWz0iu7hZItA2D0JPki4XuHtsOz6NJiAQ3kVnup
   q5Ykytzc18wbQp3zzEuN7cdBfuRlxCimcMDQq1cNoMqWkzBky+o4igLJC
   4tJzeMVshsMid0ZA3xqpl78d/DQQ2bnEoleccdVgrSdC5VYyYYPEbaVRV
   ctK7u+uN7RkzMqHN9R6fGYV7S3THFdUycYx9ffm9teVS9KOnEze/HsxBI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="373964752"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="373964752"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 04:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="914475725"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914475725"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Sep 2023 04:09:27 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qd7SJ-0000QX-0U;
        Mon, 04 Sep 2023 11:09:22 +0000
Date:   Mon, 04 Sep 2023 19:08:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 fa0aa919ef448fe4995fe4144c59aee0dce3e9e4
Message-ID: <202309041952.YYU7fM7i-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: fa0aa919ef448fe4995fe4144c59aee0dce3e9e4  efi/x86: Move EFI runtime call setup/teardown helpers out of line

elapsed time: 728m

configs tested: 36
configs skipped: 141

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230904   gcc  
i386         buildonly-randconfig-002-20230904   gcc  
i386         buildonly-randconfig-003-20230904   gcc  
i386         buildonly-randconfig-004-20230904   gcc  
i386         buildonly-randconfig-005-20230904   gcc  
i386         buildonly-randconfig-006-20230904   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-011-20230904   clang
i386                  randconfig-012-20230904   clang
i386                  randconfig-013-20230904   clang
i386                  randconfig-014-20230904   clang
i386                  randconfig-015-20230904   clang
i386                  randconfig-016-20230904   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230904   gcc  
x86_64       buildonly-randconfig-002-20230904   gcc  
x86_64       buildonly-randconfig-003-20230904   gcc  
x86_64       buildonly-randconfig-004-20230904   gcc  
x86_64       buildonly-randconfig-005-20230904   gcc  
x86_64       buildonly-randconfig-006-20230904   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230904   clang
x86_64                randconfig-002-20230904   clang
x86_64                randconfig-003-20230904   clang
x86_64                randconfig-004-20230904   clang
x86_64                randconfig-005-20230904   clang
x86_64                randconfig-006-20230904   clang
x86_64               randconfig-r016-20230904   clang
x86_64               randconfig-r025-20230904   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
