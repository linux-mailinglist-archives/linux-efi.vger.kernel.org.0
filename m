Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE6D5EBF09
	for <lists+linux-efi@lfdr.de>; Tue, 27 Sep 2022 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiI0Jxl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Sep 2022 05:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiI0Jxg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Sep 2022 05:53:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401195AE6
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664272416; x=1695808416;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=h5pnCEO8jlQPJ0VMsM+Ux7xyOhaGeJk0nZK+aXP/92M=;
  b=KNq1T7AdzZTsHYQWguJ2HumsSoWaykRS4jD2lcl1Vnq3jwrAVDAZX+9Q
   ff+amrpcjUKlOr4EhMrZ65eZnlDairMmrReufFsSGoehJR8yOcSAa6EgA
   Nb6GLpRhCcHHkhfz4ArRPdbcI4L8JpdEslQyElSXez1HncCi+pmMtnKMi
   vbLk4AAdFZqJk2sZJxEvKg2Nw06xbSvuDxvwOi2yODJJgcILshRwO8o1i
   wwhFQF5+LhViAOf3ePj9gG+/oTA1KUzaM1aDeJfgZhjdxGAcZ3Oj+Z7Qm
   CCa8/yaDDtN4QAWp/TM87WBc8n2sGcn9B2HsRP5RfyCk3J2O0SPqDZww/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302754591"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="302754591"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 02:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="621462022"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="621462022"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2022 02:53:33 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1od7HQ-0000su-1l;
        Tue, 27 Sep 2022 09:53:32 +0000
Date:   Tue, 27 Sep 2022 17:53:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS a9f6d5f1a4a88289535e0942b0e600c8e36278ff
Message-ID: <6332c80f.b+l3Lkb6Go/Y/x6J%lkp@intel.com>
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
branch HEAD: a9f6d5f1a4a88289535e0942b0e600c8e36278ff  arm64: efi/libstub: use EFI_LOADER_CODE region when moving the kernel in memory

elapsed time: 720m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
s390                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
s390                                defconfig
powerpc                          allmodconfig
i386                                defconfig
mips                             allyesconfig
arc                  randconfig-r043-20220925
powerpc                           allnoconfig
riscv                randconfig-r042-20220925
arc                  randconfig-r043-20220926
arm                                 defconfig
s390                 randconfig-r044-20220925
sh                               allmodconfig
i386                 randconfig-a001-20220926
x86_64               randconfig-a002-20220926
i386                 randconfig-a002-20220926
s390                             allyesconfig
x86_64               randconfig-a001-20220926
i386                 randconfig-a003-20220926
x86_64               randconfig-a003-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
i386                 randconfig-a004-20220926
x86_64               randconfig-a005-20220926
i386                 randconfig-a005-20220926
i386                             allyesconfig
i386                 randconfig-a006-20220926
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
i386                 randconfig-a011-20220926
s390                 randconfig-r044-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a015-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a015-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
