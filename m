Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABED5E745C
	for <lists+linux-efi@lfdr.de>; Fri, 23 Sep 2022 08:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiIWGtp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 02:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiIWGto (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 02:49:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5273F2B1AC
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 23:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663915781; x=1695451781;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rNkGvfvhTwxelVtUbf8PySKFPQC51T3muWUbKsO6Rck=;
  b=V6vcLqisVJJjjpfQgbRKCqmKbciE9OVzcjNWPBqeUfdC0rLwrM3L6Rnf
   XTaVuO+pd6+gvOdGiyXG3aY2wbUFVMNmyv20o4BtvJcyBEkjzyI1jEu38
   PXC4kjGqC5KDzrx9SJ7q2kBx//6vlvfDatqWOCWddYadU6hMw+bph1Den
   pIyzC2i1M7Csrv0TRZcMJeYAnE4uTJxiLm4mgtF4guZTfzq+UbGZvICao
   jgsYJsqMUG8ANIRNYY+qUQG8NYGn/5UFy4vV9XIumQJauFjEEIeyzEoqB
   1wjxL+iMGc3PErYtHOpZvz3Sebhvv75RBgExophDfzkyFxjYPg+Jes0MB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="299247418"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="299247418"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 23:49:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="597767117"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2022 23:49:37 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obcVE-0005PA-1J;
        Fri, 23 Sep 2022 06:49:36 +0000
Date:   Fri, 23 Sep 2022 14:49:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS d515ed00e9b6f4e41c27ec8a0ccd4e193661a09c
Message-ID: <632d56f0.z89WZ24sKU8JR/Ey%lkp@intel.com>
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
branch HEAD: d515ed00e9b6f4e41c27ec8a0ccd4e193661a09c  efi/arm64: libstub: avoid SetVirtualAddressMap() when possible

elapsed time: 722m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
m68k                             allmodconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                  randconfig-r043-20220922
arc                                 defconfig
s390                             allmodconfig
x86_64                        randconfig-a013
x86_64                              defconfig
x86_64                        randconfig-a011
alpha                               defconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
s390                                defconfig
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                                defconfig
arm                                 defconfig
x86_64                        randconfig-a002
s390                             allyesconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           allyesconfig
x86_64                        randconfig-a006
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a004
i386                          randconfig-a014
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016
ia64                             allmodconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests

clang tested configs:
hexagon              randconfig-r041-20220922
riscv                randconfig-r042-20220922
hexagon              randconfig-r045-20220922
s390                 randconfig-r044-20220922
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a002
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
