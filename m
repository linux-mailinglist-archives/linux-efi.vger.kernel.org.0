Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1DF62587E
	for <lists+linux-efi@lfdr.de>; Fri, 11 Nov 2022 11:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiKKKjH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Nov 2022 05:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiKKKjG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Nov 2022 05:39:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D13F53
        for <linux-efi@vger.kernel.org>; Fri, 11 Nov 2022 02:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668163145; x=1699699145;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DfcEemnvcobm2Q6gOZe/WTuRHJ2bvfYCrqGu6ZTrLfU=;
  b=YLY6ZNOiIw03M/uVsy7McBFMbf6xed0Bb9mju6VgOlsEoRQoLTo9+qli
   naW85v+fp5WspXOc5682BZpTYm2fRMHGkKBYhtggLSBvljA8oGbTsO78D
   g0u2zG4fXZfFAK17XV6zQWYQQAOxBzs2JOwCAFyxmjp6N0ZL4wPh5i9E3
   PJzGs628c6PZOvRO2xIJKXTmg/pFeEq6G+CIfY/Ly6+l2z1koKgRnDPTh
   SFS9skQG4UdBLAb657c+k8iDnG2kaAboCMDnJURBjtMbIZC+mk4Supz00
   8yEbAuZ0MzpFa7Q1PABucv4iw998GN78/FsIoMg2ugHGFxBsK9vWLdk6O
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="313362640"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="313362640"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 02:39:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="615450312"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="615450312"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2022 02:39:04 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otRR9-0003rF-1h;
        Fri, 11 Nov 2022 10:39:03 +0000
Date:   Fri, 11 Nov 2022 18:38:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 9b9eaee9828fe98b030cf43ac50065a54a2f5d52
Message-ID: <636e2627.IhnLJx6M1y2x12iv%lkp@intel.com>
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
branch HEAD: 9b9eaee9828fe98b030cf43ac50065a54a2f5d52  arm64: efi: Fix handling of misaligned runtime regions and drop warning

elapsed time: 731m

configs tested: 54
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
alpha                            allyesconfig
arc                              allyesconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           allyesconfig
i386                          randconfig-a005
arc                  randconfig-r043-20221110
x86_64                               rhel-8.3
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a016
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
riscv                randconfig-r042-20221110
hexagon              randconfig-r041-20221110
s390                 randconfig-r044-20221110
hexagon              randconfig-r045-20221110
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
