Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE85BF29F
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 03:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiIUBQ5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 21:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIUBQ4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 21:16:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555E561D4D
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 18:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663723015; x=1695259015;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OvDqsz79k2IKlbb/WknNndZDgC5vMZQ/HeMG7oZ3aAQ=;
  b=RLb4Qg4zTnglcbmVez0Jf8Q779WHtVRaySJ0aEOuDLAk+LlnqqaB/Enr
   VF58URtKsYispmG9HYDB11NB/VJIJ811ogyafDUbTwoKNgUka9DmfjGr/
   fEKYaBv6XFnEEXiYKjcMxQgZt8Dh4+Giqpc/lIoLp1Ooq56ypBecpMLIg
   ggIJBCUMvvmblKBJY/i06Swp85BGM76cDXlJmnVC9p6Rdq0d3c04ItGuJ
   19ff1rNSEQFBO4E9h553xkLZHsVd47kR2U8AHW2910uIRpSsIyUjdOhTR
   1Q1ihX4wZz1fQdg5p/FmHwbuo/ljg7i2fzyTKr48Ena22J0osRZo68zeF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="298585810"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="298585810"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 18:16:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="744756603"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2022 18:16:53 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaoM9-00035s-06;
        Wed, 21 Sep 2022 01:16:53 +0000
Date:   Wed, 21 Sep 2022 09:16:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS a241d94bb532dcfb7ef3f723e6a0a0e7cf8f10ea
Message-ID: <632a65eb.LhJNCIsAXDXGyZMM%lkp@intel.com>
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
branch HEAD: a241d94bb532dcfb7ef3f723e6a0a0e7cf8f10ea  efi: libstub: fix type confusion for load_options_size

elapsed time: 720m

configs tested: 51
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
arc                  randconfig-r043-20220919
arc                                 defconfig
s390                 randconfig-r044-20220919
s390                             allmodconfig
riscv                randconfig-r042-20220919
alpha                               defconfig
x86_64                              defconfig
i386                 randconfig-a012-20220919
i386                 randconfig-a011-20220919
s390                                defconfig
i386                                defconfig
i386                 randconfig-a014-20220919
s390                             allyesconfig
i386                 randconfig-a016-20220919
i386                          randconfig-a016
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a015
arc                              allyesconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
i386                             allyesconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220919
hexagon              randconfig-r045-20220919
i386                          randconfig-a015
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
