Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9A6648C99
	for <lists+linux-efi@lfdr.de>; Sat, 10 Dec 2022 04:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiLJDAo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Dec 2022 22:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJDAm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Dec 2022 22:00:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC32583247
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 19:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670641240; x=1702177240;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=u68UqOU7CCsvjTX3rr4kwKr15aNWAUGm44uOjMqYlDI=;
  b=SIaL/G9kP/TpWLcbHgVehpLNsClavDGMDW8RGF5xpyr26CVHsdRFz6hm
   RCE2n0oZiSFL9jrySDIEM3MVYV9PLt1WqBR+c4gxQax381wqBQcE2iDWe
   ajeaXBOVv98PZeLHM7AbH1tmOhGuazw6IddF8T0WUePEtmeEcIaR4Br/i
   XGvx9dunzA5rkx3j5h95VALINmL/eXFkC5iB1j1pU9lP5oX84fdwN06lj
   neJqrxTuI1sOQR7OnZDy+qHkzLtoVQcKjcBXj52h0ifIb4/2KlTH5E9nZ
   4cXv/GDhi5pQI83EFCPrSQSse9gCBRHYi1F5cZ2NmIBZtzifsz6w6lIqD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="403842372"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="403842372"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 19:00:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="647594180"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="647594180"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2022 19:00:39 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3q6Q-0002Eh-1O;
        Sat, 10 Dec 2022 03:00:38 +0000
Date:   Sat, 10 Dec 2022 10:59:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS c2530a04a73e6b75ed71ed14d09d7b42d6300013
Message-ID: <6393f62b.rLxeh0+4vulYg7tv%lkp@intel.com>
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
branch HEAD: c2530a04a73e6b75ed71ed14d09d7b42d6300013  arm64: efi: Account for the EFI runtime stack in stack unwinder

elapsed time: 720m

configs tested: 70
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
i386                                defconfig
x86_64                          rhel-8.3-rust
arm                                 defconfig
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20221209
s390                                defconfig
s390                 randconfig-r044-20221209
x86_64                        randconfig-a013
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20221209
x86_64                        randconfig-a004
powerpc                           allnoconfig
x86_64                        randconfig-a002
powerpc                          allmodconfig
x86_64                        randconfig-a011
s390                             allyesconfig
x86_64                        randconfig-a006
m68k                             allyesconfig
mips                             allyesconfig
m68k                             allmodconfig
ia64                             allmodconfig
x86_64                        randconfig-a015
i386                          randconfig-a014
x86_64                              defconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a012
sh                               allmodconfig
i386                          randconfig-a016
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           allyesconfig
x86_64                            allnoconfig
sparc                       sparc32_defconfig
riscv                    nommu_k210_defconfig
xtensa                       common_defconfig
m68k                            mac_defconfig

clang tested configs:
arm                  randconfig-r046-20221209
hexagon              randconfig-r041-20221209
hexagon              randconfig-r045-20221209
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001
arm                        magician_defconfig
powerpc                 mpc836x_mds_defconfig
arm                            dove_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
