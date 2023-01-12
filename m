Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779BB66717E
	for <lists+linux-efi@lfdr.de>; Thu, 12 Jan 2023 13:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjALMBF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Jan 2023 07:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjALMAg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Jan 2023 07:00:36 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D872A3752F
        for <linux-efi@vger.kernel.org>; Thu, 12 Jan 2023 03:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673524507; x=1705060507;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tmm2w+2ybfaS6b1MHGVZJfKlIEzl6YHqPmGYMMyAa/o=;
  b=jGjON1DBpXltOt/0T+3XKtdp3BiCSY4qklo6dKqxAAn8Ok0kU7F/4Aqc
   st9TC+RZUZIoinLhq/2FJXJ3r0dxvGkMCiQZ+DwFSYPvjWoWx+pV7pWzl
   6EDo0WMx4HEowW5vjxA0awv3PPr7oTnP0MbQl9fJa6DiRgbxZavLeMlxT
   1i2TyYBX3+i0xJhn258pkmkCVIwSLfZPer8j1uYO7xiZi5munjvOWL95/
   JDtOir0Zh0d0evAnj4w/BQyabLy6kGFPtSvlS5JkFED9CiQFjLZ+VqbTr
   hPZvAErD6wKV0NuUsmeIwCZN/F9lPctwSERfkduPXRsMIlV0NqX4hzMUu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385999963"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="385999963"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 03:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="800176036"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="800176036"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2023 03:55:05 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFwAi-000A60-1a;
        Thu, 12 Jan 2023 11:55:04 +0000
Date:   Thu, 12 Jan 2023 19:54:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 608509b15a311df6a5b9cf1dbe034a4f52784315
Message-ID: <63bff4e1.0pZ5BYth11IXATnd%lkp@intel.com>
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
branch HEAD: 608509b15a311df6a5b9cf1dbe034a4f52784315  efi: tpm: Avoid READ_ONCE() for accessing the event log

elapsed time: 742m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                            allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
ia64                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
arm                                 defconfig
x86_64                        randconfig-a011
arm64                            allyesconfig
i386                          randconfig-a014
x86_64                              defconfig
mips                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a015
arm                              allyesconfig
sh                               allmodconfig
x86_64                               rhel-8.3
i386                          randconfig-a001
arc                  randconfig-r043-20230110
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                          randconfig-a005
s390                 randconfig-r044-20230110
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20230110
x86_64                           allyesconfig
m68k                         amcore_defconfig
arm                        multi_v7_defconfig
sh                              ul2_defconfig
m68k                             alldefconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    klondike_defconfig
arm                          gemini_defconfig
powerpc                     tqm8548_defconfig
sh                ecovec24-romimage_defconfig
sparc                       sparc64_defconfig
powerpc                      mgcoge_defconfig
openrisc                 simple_smp_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                           tegra_defconfig
arm                          exynos_defconfig
arm                       multi_v4t_defconfig
x86_64                           alldefconfig
m68k                        stmark2_defconfig
sh                        edosk7705_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a015
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230110
i386                          randconfig-a002
arm                  randconfig-r046-20230110
hexagon              randconfig-r045-20230110
i386                          randconfig-a004
i386                          randconfig-a006
arm                      tct_hammer_defconfig
powerpc                        icon_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
