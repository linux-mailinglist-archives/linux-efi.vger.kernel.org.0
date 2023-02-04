Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697E868AA8B
	for <lists+linux-efi@lfdr.de>; Sat,  4 Feb 2023 15:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjBDOWu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 4 Feb 2023 09:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDOWt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 4 Feb 2023 09:22:49 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C421C338
        for <linux-efi@vger.kernel.org>; Sat,  4 Feb 2023 06:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675520567; x=1707056567;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FuZuThi/JUZkXtmomqfvYPB4fJXqawPXJQOiKocY76c=;
  b=JE39oYRIO3wpAAYkklNJgy2f7HoOokB2QFdSHdPLtlzxPwpodT3gbEe6
   FPJklFUx426qhkGOgvy5oy7lItOvzrBDXqocjAyGqDf6fGF254VTTCbNa
   gw2bSzn62UzqnsUwgjgQNufFsQRhHESlBSCN57FeUp5j6EXgWtsFnkuLO
   7vPzKimqXCMbzVnc/pR3M2K0v5jHmEfHMPqEkPMVKtkxwZz1VFJVwyNAK
   Tjqhy0xyMGSUiyeik5Sel+yi6TeLuo+rOsUbzMU0d7P66f1JOCqZqNx1Y
   zGbPqap66+3HHIMHz7yMkb6P/EJFD4b3+JngMVaNuMktuwHCkiAwEOtQI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="316949898"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="316949898"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 06:22:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="659406933"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="659406933"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 04 Feb 2023 06:22:46 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOJRF-0001Lg-16;
        Sat, 04 Feb 2023 14:22:45 +0000
Date:   Sat, 04 Feb 2023 22:21:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 966d47e1f27c45507c5df82b2a2157e5a4fd3909
Message-ID: <63de69fd.aNLC/AzPPv+mmx9T%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 966d47e1f27c45507c5df82b2a2157e5a4fd3909  efi: fix potential NULL deref in efi_mem_reserve_persistent

elapsed time: 1444m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
m68k                             allmodconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
m68k                             allyesconfig
mips                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allmodconfig
s390                                defconfig
sh                               allmodconfig
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20230204
arc                  randconfig-r043-20230204
s390                 randconfig-r044-20230204
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
s390                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
hexagon              randconfig-r045-20230204
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
