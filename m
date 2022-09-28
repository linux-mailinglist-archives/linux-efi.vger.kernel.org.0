Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80CE5ED2CE
	for <lists+linux-efi@lfdr.de>; Wed, 28 Sep 2022 03:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiI1BxE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Sep 2022 21:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiI1BxD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Sep 2022 21:53:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA01F01B6
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664329982; x=1695865982;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OaCJPP5MBmgZiiNP5JxiRpG8/wRj03vy2LE2xs8InIM=;
  b=SEgouRlZ6THAIZ4EPgFrGIhq7i9iJWQhoROZLaloVrnO49kvv5MhEE9H
   aR2Bya3oIWYKu75tDM/aEKb7YuWscsG0ICeY4V6Z2Ptr/zWU2YR0qg5EH
   jFiqoYva1KBxCCKGaNPywnr0UWU3xpuCFvAk/2riCTorh2hK6wSh/TO3B
   k67jhSjI4PpB72Vs53Yh/TH9rs8JGXAZ43AUyEVdPWvf82aiUA9oIu/cY
   wmAONphPl1vbHPTrTPK7O3kvncpd++PR/lBhp0HcyXXbbWjNX+JHJZrVX
   tD6HY4bK4pId0tsdw8WEYuZKwqMuhq6BrwvoOSVxQzzdcAEknPmYS9keM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="387762602"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="387762602"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 18:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="764094836"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="764094836"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 27 Sep 2022 18:53:01 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odMFw-0001om-3C;
        Wed, 28 Sep 2022 01:53:00 +0000
Date:   Wed, 28 Sep 2022 09:52:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS d3549a938b73f203ef522562ae9f2d38aa43d234
Message-ID: <6333a8ef.t9xAybPlzs8fSNOS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: d3549a938b73f203ef522562ae9f2d38aa43d234  efi/arm64: libstub: avoid SetVirtualAddressMap() when possible

elapsed time: 862m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
s390                             allyesconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64               randconfig-a002-20220926
x86_64               randconfig-a004-20220926
m68k                             allyesconfig
x86_64               randconfig-a001-20220926
arc                  randconfig-r043-20220925
alpha                            allyesconfig
x86_64               randconfig-a003-20220926
arc                              allyesconfig
x86_64               randconfig-a005-20220926
riscv                randconfig-r042-20220925
x86_64               randconfig-a006-20220926
x86_64                           allyesconfig
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a006-20220926
powerpc                           allnoconfig
i386                                defconfig
arm                                 defconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a012-20220926
i386                 randconfig-a011-20220926
x86_64               randconfig-a016-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a015-20220926
x86_64               randconfig-a015-20220926
i386                 randconfig-a016-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
