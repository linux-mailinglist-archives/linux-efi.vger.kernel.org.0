Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A4E607108
	for <lists+linux-efi@lfdr.de>; Fri, 21 Oct 2022 09:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiJUH3w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Oct 2022 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJUH3v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Oct 2022 03:29:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0790C356F3
        for <linux-efi@vger.kernel.org>; Fri, 21 Oct 2022 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666337390; x=1697873390;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7QLARYSVcwCYE4pdHO3JxR5OXdIkdoPprrMuVFshqIM=;
  b=ENtb3pp3vouJuvHh4DJvCpjZdvLAvDzXFE3KGZkKwVerbqofqrdiScky
   OHJBlOQxJdgQXPsKw80PIydBIw1P4iMeejVMmjndn1Y/SrFgLkStUOlF9
   NC25bhzD8fBVRriHr37MWHFzkW14TDSyMrJ0+wTa1BPrmdJKUrfUOL/iQ
   m8TM1uv1wpi/ZSLNogXlaeS4QBcYjZKsxHNOr7Z5MYvzdwTjZQ7y8NGDv
   TdlsUaeoLgZRN8Zbcl8qbzg3JGv2AcVo7UX+u4DSnCrdSD8TIQWYxX/vj
   /ag3BOwxI3Jw4fKELV5Z5EUilGomCBh++bJGVc1OxW45A0Rdt8uKs/PR4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="368986121"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="368986121"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 00:29:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="608220356"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="608220356"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2022 00:29:48 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olmTT-0002O0-2V;
        Fri, 21 Oct 2022 07:29:47 +0000
Date:   Fri, 21 Oct 2022 15:29:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 83f923d99cdf079f66fc5fac7d1634a03f229036
Message-ID: <63524a58.RFYC5sIpnXW9OTNu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 83f923d99cdf079f66fc5fac7d1634a03f229036  efi: runtime: Don't assume virtual mappings are missing if VA == PA == 0

elapsed time: 727m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
x86_64                          rhel-8.3-func
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
alpha                               defconfig
i386                          randconfig-a001
i386                                defconfig
i386                          randconfig-a003
x86_64                        randconfig-a013
i386                          randconfig-a005
x86_64                        randconfig-a002
m68k                             allmodconfig
x86_64                        randconfig-a011
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
alpha                            allyesconfig
x86_64                              defconfig
x86_64                        randconfig-a004
x86_64                         rhel-8.3-kunit
s390                                defconfig
m68k                             allyesconfig
s390                             allmodconfig
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a015
mips                             allyesconfig
s390                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
arc                  randconfig-r043-20221018
riscv                randconfig-r042-20221020
riscv                randconfig-r042-20221018
s390                 randconfig-r044-20221018
sh                               allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r041-20221020
x86_64                        randconfig-a014
hexagon              randconfig-r045-20221020
hexagon              randconfig-r041-20221018
hexagon              randconfig-r045-20221018
i386                 randconfig-a011-20221017
i386                 randconfig-a013-20221017
i386                 randconfig-a012-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a015-20221017

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
