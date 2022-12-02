Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDD363FF94
	for <lists+linux-efi@lfdr.de>; Fri,  2 Dec 2022 05:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiLBEyA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 23:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiLBEx7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 23:53:59 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C598ABBBEE
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 20:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669956838; x=1701492838;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8a+C+RElXCcbuGVhS6UHEYxlfaB8EY6bUd08xnD3dG8=;
  b=VPSWlrWGGPpb5Gby0tQ3ykJPJ4cjlb4H+9ahA0dHHiInHBT7cRuDMX9h
   9dsbjZ4iSl+h4Bvb/JFhClCLZwX+IuPaYf6NqminFUg1ghjD19fVlHnZQ
   JehEAIPOQbHeO7PnRdml+1OGMHsITK6T/K8zXTRyimPaO2FdkMDN8E+YW
   JbSyqTR7OlyfGgMQQsHZzvGiS2aW7tRPhaqCnzePBPu2pQg6YIsNQOZ/D
   W7S19+OwXdGzZmBHq48XYEpGC4zgiZY2bMvduBgZGouaiWy7h7/4MG0mr
   U4UEJoH42DrIC8PklyisKEuDQU9KcQt49EsJHcSroPVlTOGRM9gPDjBH5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="317019640"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="317019640"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 20:53:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="819312045"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="819312045"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Dec 2022 20:53:57 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0y3g-000DGe-2E;
        Fri, 02 Dec 2022 04:53:56 +0000
Date:   Fri, 02 Dec 2022 12:53:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 327b555ed078dde9e119fee497d7ae60b5b1dd62
Message-ID: <638984b1.5wgCiU/E//DzElsH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 327b555ed078dde9e119fee497d7ae60b5b1dd62  arm64: efi: Recover from synchronous exceptions occurring in firmware

elapsed time: 724m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
sh                               allmodconfig
s390                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
arc                  randconfig-r043-20221201
i386                          randconfig-a005
riscv                randconfig-r042-20221201
s390                 randconfig-r044-20221201
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
i386                                defconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
xtensa                           alldefconfig
microblaze                          defconfig
powerpc                      arches_defconfig
powerpc                      tqm8xx_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r041-20221201
x86_64                        randconfig-a014
hexagon              randconfig-r045-20221201
x86_64                        randconfig-a012
i386                          randconfig-a006
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
