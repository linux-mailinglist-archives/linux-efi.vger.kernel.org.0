Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3ED5BF61A
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 08:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIUGML (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 02:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIUGMK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 02:12:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA67F0B5
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 23:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663740729; x=1695276729;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D9Agit4tpiQLiO4MKnz34AcS2ytk8E4vI47N1G2ay8s=;
  b=KfXqxPaLvcYSFNmASSh5JuAT6ciVZsAwlDE6epjpTzS2etjnAMrxNGJo
   R9uA0x8VdsZr1u7UuDKpTN1nDiW44Oudu/B/27853pw1Xc4vke+1KX/8K
   0HpkSf4OVzW1DW6inF/jwLlS7PENyrHUaMB9f9/loWPWV8j+FEGnFRTnP
   RTtJ/fJ7lj2UAgr0bla1Z3487o2fmlX4bw40pg1VcS7QvGLNIzx5mgS4e
   NXRqXNiYgZeYcmU79oj65Me3BD7CbXPq+v7en7EU5IEgT6xDgjhLuG2XV
   /dpJVxUieVoKkAd3pH33yqKfiZ2jo6cUKuWXVTaBotesPzpLvF3GU/fSg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="282957565"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="282957565"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="864288762"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Sep 2022 23:12:06 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oasxq-0003JK-13;
        Wed, 21 Sep 2022 06:12:06 +0000
Date:   Wed, 21 Sep 2022 14:11:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 7da5b13dccd99cfdc42940fc7adcb88647023292
Message-ID: <632aab1a.Ml49EVixiwiw2hxq%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 7da5b13dccd99cfdc42940fc7adcb88647023292  efi: efibc: Guard against allocation failure

elapsed time: 723m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
i386                                defconfig
arc                              allyesconfig
arc                  randconfig-r043-20220921
alpha                            allyesconfig
riscv                randconfig-r042-20220921
m68k                             allmodconfig
m68k                             allyesconfig
s390                 randconfig-r044-20220921
i386                             allyesconfig
ia64                        generic_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7203_defconfig
nios2                         3c120_defconfig
ia64                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                          simpad_defconfig
powerpc                    sam440ep_defconfig
sh                             espt_defconfig
arm                            xcep_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                          tiger_defconfig
powerpc                  iss476-smp_defconfig
m68k                            q40_defconfig
sparc                       sparc64_defconfig
openrisc                         alldefconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                         amcore_defconfig
powerpc                         ps3_defconfig
s390                          debug_defconfig
sh                          sdk7780_defconfig
m68k                           virt_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sh                        sh7763rdp_defconfig
sparc64                             defconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
sh                           se7705_defconfig
m68k                            mac_defconfig
arm                        mini2440_defconfig
arc                        nsimosci_defconfig
powerpc                     tqm8541_defconfig
arm                             ezx_defconfig
mips                         cobalt_defconfig
sparc                             allnoconfig
microblaze                      mmu_defconfig
arc                      axs103_smp_defconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                 randconfig-c001-20220919
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
