Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78A75E989E
	for <lists+linux-efi@lfdr.de>; Mon, 26 Sep 2022 07:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIZFEi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Sep 2022 01:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIZFEh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Sep 2022 01:04:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2957109D
        for <linux-efi@vger.kernel.org>; Sun, 25 Sep 2022 22:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664168675; x=1695704675;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=w8cGMtBQZlpSQwMh8bMXupNvtf5mFYLknyOFW6drE+M=;
  b=I8lZuMY1ajXK2oLzUN8j/SKuexVM9j1bTFLtK9nLBG02KnfeT6Q/uEag
   La/L6IIJzac5xjvkunCFBf7wddl7YA/YQ2hTIwdML6MJO9o8zi8C7aKDX
   CRl1rAJp+WXzK1pr5Z5Q9CrUmwLjjuEeY2mBe60hIg9OX2aEYKOv3CbJ/
   1/YEWQ5MEBMUGvtzg8cUFy9pgnl9UPGRuIBxSaQTDoOt/xtwh9oVBbCOS
   Mte4Hpvht3qP3w9KBX7hOZExLVywF/FwF/SfTKalZeVjlI7PthD4hd4+g
   zA5E2jXTaPBQI6o/GIQeEETgb4qGH8OGJ9DdKLZ56kZrBpfQHu0P6Kf8h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="300920296"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="300920296"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 22:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="651689200"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="651689200"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Sep 2022 22:04:31 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocgIB-0008hW-0A;
        Mon, 26 Sep 2022 05:04:31 +0000
Date:   Mon, 26 Sep 2022 13:03:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 755765bcc22e79d76626382442530b2d2a98bdfb
Message-ID: <633132a8.lYM+swM+xe/iI8xv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 755765bcc22e79d76626382442530b2d2a98bdfb  arm64: efi/libstub: use EFI_LOADER_CODE region when moving the kernel in memory

elapsed time: 720m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
arc                  randconfig-r043-20220925
s390                                defconfig
s390                             allmodconfig
s390                 randconfig-r044-20220925
sh                               allmodconfig
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
riscv                randconfig-r042-20220925
x86_64                        randconfig-a013
i386                                defconfig
x86_64                        randconfig-a011
i386                          randconfig-a014
alpha                            allyesconfig
arm                                 defconfig
i386                          randconfig-a005
arc                              allyesconfig
i386                          randconfig-a012
x86_64                          rhel-8.3-func
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a016
s390                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a006
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a004
i386                             allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220925
hexagon              randconfig-r045-20220925
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                          randconfig-a006
x86_64                        randconfig-a016
i386                          randconfig-a015
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
