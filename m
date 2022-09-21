Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C7E5BF616
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 08:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiIUGMK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 02:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIUGMJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 02:12:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6DB7F111
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 23:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663740728; x=1695276728;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D/04bHYJ9Jpe4M05VOyshL6faIfPJ2fd5F7Z5gnKCGY=;
  b=W7vxXhp5MeWUSn0LIpnnmac7yv8RoRnV5yDz8UeRHL4RZDuhtXM1xorm
   Lexb3EXCd/hm8+jVzmL5e4EqRPAHzZ9rFhSJRk/biSgIQUaVNJCTPgF85
   LxoW7Omv2keMfd6aS+RkJM1QXreZxONA+CW0sD00uvBDmeVh2WNtsDs9J
   xKdpoumOf3+gSsebFrDKHJayBmYCxZbAQzMj/jg0XnEYGRHyVODpP/jA0
   grUdILcbej6Bt44gwun3fSpsvpMBNM/G5qUA1FXB9aZuY1HCbOotx5owt
   HcfE4higJqGMRjzD2KiYctvUZPevvtLcWccGjNutJXak2w7TohE3YEvrt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="282957564"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="282957564"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="708307392"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Sep 2022 23:12:06 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oasxq-0003JE-0v;
        Wed, 21 Sep 2022 06:12:06 +0000
Date:   Wed, 21 Sep 2022 14:11:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:efistub-refactor-for-v6.1] BUILD SUCCESS
 2677c4ee2eaf5c84db9d85d93e400736cca20ce9
Message-ID: <632aab21.hJoW1Zk29nRZxeSW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efistub-refactor-for-v6.1
branch HEAD: 2677c4ee2eaf5c84db9d85d93e400736cca20ce9  efi/loongarch: libstub: remove dependency on flattened DT

elapsed time: 723m

configs tested: 54
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
s390                                defconfig
s390                             allmodconfig
i386                                defconfig
s390                 randconfig-r044-20220921
i386                             allyesconfig
s390                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
i386                          randconfig-a001
i386                          randconfig-a003
ia64                             allmodconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                           allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
arm                              allyesconfig
i386                          randconfig-a016
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
