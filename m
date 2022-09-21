Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0055A5E547E
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 22:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIUU3v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 16:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiIUU3o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 16:29:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4104F64D7
        for <linux-efi@vger.kernel.org>; Wed, 21 Sep 2022 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663792183; x=1695328183;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nZGOXG2o515bBVXM1KJLA9CvgmPfz2ctiOkqsDCf89I=;
  b=GvLlCxK5kgFoiUYc86FqMTFgQvNZMaPVDOrpVvrf8CGbviXL6pnyjOsc
   QDstKaT+JtpHxtCFvsYlpqGmsNk9c5q7BAdwZ/Dwp3qzV6QQm9il5yxzA
   8yC7x8HUzGWR084gEIy8Vunc9xehXUH0YytJQl9vpzA+0zyQO3h3o/t8A
   E+Fd2OuHrsrRZwP8ktdhsxylvFIvkgAnPIwb/AlFjIATHOs03aTHZajTn
   o0O17bfY0FfPiVBARuR3Jrew65gZVd4XKHIOnUHA9wWnr0vVlX5aFBGgN
   O/PIuEXzA23qCCD6X3EnY+Uik587lBSiGezwGRRmpiPNVWA0O26ncaxxO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="364096402"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="364096402"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 13:29:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="948312185"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2022 13:29:40 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob6Lk-0003vo-0K;
        Wed, 21 Sep 2022 20:29:40 +0000
Date:   Thu, 22 Sep 2022 04:28:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 25a47cb1f2ce2d3ffd6b24af6ce3576370fc13a3
Message-ID: <632b73fa.t7PFwDA5WIOtQrQ/%lkp@intel.com>
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
branch HEAD: 25a47cb1f2ce2d3ffd6b24af6ce3576370fc13a3  Merge tag 'efi-loongarch-for-v6.1-2' into HEAD

elapsed time: 720m

configs tested: 53
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
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
s390                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
x86_64                              defconfig
s390                 randconfig-r044-20220921
arm                                 defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                           allyesconfig
i386                          randconfig-a014
arm                              allyesconfig
i386                          randconfig-a012
arm64                            allyesconfig
i386                          randconfig-a016
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
m68k                             allmodconfig

clang tested configs:
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
