Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C316916F9
	for <lists+linux-efi@lfdr.de>; Fri, 10 Feb 2023 03:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBJC7Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Feb 2023 21:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBJC7W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Feb 2023 21:59:22 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463F7765C9
        for <linux-efi@vger.kernel.org>; Thu,  9 Feb 2023 18:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675997935; x=1707533935;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DMCQ3Spi5xOu4Tk98ix0xyKAZaemEXQRPYn+ikm7XdE=;
  b=D/R3XukmQ6qncQkf3mDO1qODw6p5cjBLBP2gv6haVceEmnjEGHUwuzuA
   T8JwfCkfwl0pXUby9dXIMriETHHRZ3yQUmX1hFCDE1UsCX5W/LdvIKz57
   ssOvGMhp7RWHpMJS2oQfp7WTfnTlqwAafsG1Nyc7XL67OOClgo9YyAsUt
   qmGQ35PygE3LROFCW/TPyVlJaAskoj3ZevBNUnPODvgmInYZRD1tM9KWo
   1Uk81zcnyOLFtF1Fvvm68vXDSCnWy8jn4YKFDciIvLD/OqbFf+xhSngu7
   /CNsDYypjMdwf7Gde6NmJiEKpHhAlW2fT6viElOxymu4d0FXle9GuAOVb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310684565"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="310684565"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 18:58:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="736586552"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="736586552"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Feb 2023 18:58:16 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQJc7-0005Tj-1M;
        Fri, 10 Feb 2023 02:58:15 +0000
Date:   Fri, 10 Feb 2023 10:58:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 190233164cd77115f8dea718cbac561f557092c6
Message-ID: <63e5b2ba.IjaLbN/JQSNCGoid%lkp@intel.com>
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
branch HEAD: 190233164cd77115f8dea718cbac561f557092c6  arm64: efi: Force the use of SetVirtualAddressMap() on eMAG and Altra Max machines

elapsed time: 722m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
ia64                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
arc                  randconfig-r043-20230209
arm                  randconfig-r046-20230209
i386                          randconfig-a005
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a002
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
x86_64                           allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                          randconfig-a014
arc                              allyesconfig
i386                          randconfig-a012
i386                                defconfig
i386                          randconfig-a016
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230209
hexagon              randconfig-r045-20230209
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
s390                 randconfig-r044-20230209
i386                          randconfig-a006
x86_64                        randconfig-a005
riscv                randconfig-r042-20230209
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
