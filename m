Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD25BBB68
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 05:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiIRD7V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 17 Sep 2022 23:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRD7U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 17 Sep 2022 23:59:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC15D26543
        for <linux-efi@vger.kernel.org>; Sat, 17 Sep 2022 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663473558; x=1695009558;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=p83ZY5OLSRthVez9k8Qt9vDMkjIPULOe+ciZITcWRHc=;
  b=JhRpnorkhKkYEENiNOcgM0M2r3XIAHjtqywrfM0UpEWOQAlBokB95w3g
   9j9fiNgxkTIs2RuIYg3w7yFJg0YAGe7lmkYJJvrdMUFZlmYiUEE4rdDb1
   OOXc7TNiCtx4ND8PEVXwCf59qIv4JBZa+3PxzQxTtZodTEJtG1HLIx18L
   Jmmg1IfeTl1B1gxp6pJlTUbUFsXV1zUCl2/Wqxv/IlYd82G28qgNon3hj
   Kdi3SJsWnA/9LI39Z1yTa3rYwLmKgqFZBVwOJc4FuCnCl8/nYMOfevcEk
   37W5XOYXWbKN1nqtU3bgpYIi+9IlqRvpxvyPs+kulxkfAFGXCCMjTc1XI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="282226449"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="282226449"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 20:59:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="946801177"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Sep 2022 20:59:16 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZlSe-0000rd-0n;
        Sun, 18 Sep 2022 03:59:16 +0000
Date:   Sun, 18 Sep 2022 11:58:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 18f1da83d2ac38d3c52d5051de0207040da82311
Message-ID: <6326975b.xxHntN7TW0tAvx3K%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 18f1da83d2ac38d3c52d5051de0207040da82311  loongarch: efi: enable generic EFI compressed boot

elapsed time: 725m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
arc                                 defconfig
s390                             allmodconfig
arc                  randconfig-r043-20220918
alpha                               defconfig
arm                                 defconfig
i386                          randconfig-a001
powerpc                          allmodconfig
s390                                defconfig
mips                             allyesconfig
i386                          randconfig-a003
x86_64                        randconfig-a002
powerpc                           allnoconfig
arm                              allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                           allyesconfig
x86_64                        randconfig-a013
sh                               allmodconfig
m68k                             allmodconfig
s390                             allyesconfig
ia64                             allmodconfig
i386                             allyesconfig
arc                              allyesconfig
x86_64                        randconfig-a006
arm64                            allyesconfig
x86_64                        randconfig-a011
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
x86_64                        randconfig-c001
i386                          randconfig-c001
arm                  randconfig-c002-20220918
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig

clang tested configs:
riscv                randconfig-r042-20220918
hexagon              randconfig-r041-20220918
hexagon              randconfig-r045-20220918
s390                 randconfig-r044-20220918
x86_64                        randconfig-a014
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
