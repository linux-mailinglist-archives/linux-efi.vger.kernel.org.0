Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210CE5A3A37
	for <lists+linux-efi@lfdr.de>; Sun, 28 Aug 2022 00:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiH0WTW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 18:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiH0WTV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 18:19:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765E7356D5
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661638760; x=1693174760;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=q1QitCEntgyOKNlYLgUqFl0bXmbzv7Bhy8wTBSjR0lk=;
  b=IO9u3ICsFfiAGx+F1ncXZsIY/tEc5qWy3KrfpITW3RBmonz3/cXRr/KF
   2lnKqh62kGlTjV5dK1f4K2yE1S2bwsyWrnQbCLSFSkQ64lJ94FDQ+pHaa
   ANC8Nt3TGDsi8d7ZdyZLu5FniRfEBHtbD06zJL0nq4rFPBUbnT7RWImY6
   54cxig4NE+D8XS2SZga2pl88JpubVVJjdA9LVCDJFjokybrR5Xh1t2UXu
   q1JllKgRtI41WjTnAbziBy/H6V6hrC6YC2yr3zTNNItu2whcRL27VX/Pt
   PTQ/OV/uXKbtKEYSc2GRHdP085wLuiLtbjl9hJJ+HbOmeWDcY8r8KW/va
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="356408366"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="356408366"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 15:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="939134837"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2022 15:19:18 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oS497-0000X1-1k;
        Sat, 27 Aug 2022 22:19:17 +0000
Date:   Sun, 28 Aug 2022 06:18:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS bb45d2db8492036a6fc938ec0b228834ea6e1cf9
Message-ID: <630a9844.i1RH1uWwvjCcT2oi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: bb45d2db8492036a6fc938ec0b228834ea6e1cf9  Merge tag 'efi-loongarch-for-v6.1' into efi/next

elapsed time: 720m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a002
x86_64                        randconfig-a011
arc                                 defconfig
s390                             allmodconfig
x86_64                        randconfig-a004
riscv                             allnoconfig
arc                  randconfig-r043-20220827
powerpc                           allnoconfig
x86_64                        randconfig-a015
loongarch                         allnoconfig
alpha                               defconfig
x86_64                        randconfig-a006
i386                   debian-10.3-kselftests
i386                                defconfig
i386                          randconfig-a001
i386                              debian-10.3
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
x86_64                              defconfig
powerpc                          allmodconfig
riscv                          rv32_defconfig
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
loongarch                           defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
s390                             allyesconfig
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
s390                                defconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          debian-10.3-kvm
x86_64                           allyesconfig
arm                                 defconfig
parisc                           allyesconfig
parisc                              defconfig
m68k                             allyesconfig
nios2                               defconfig
m68k                             allmodconfig
nios2                            allyesconfig
arc                              allyesconfig
parisc64                            defconfig
alpha                            allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
powerpc                          allyesconfig
riscv                            allyesconfig
arm                              allyesconfig
riscv                            allmodconfig
riscv                               defconfig
arm64                            allyesconfig
arm                             pxa_defconfig
sh                             sh03_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                         ps3_defconfig
sh                           se7750_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                    maltaup_xpa_defconfig
sh                        edosk7705_defconfig
mips                         bigsur_defconfig
sh                            titan_defconfig
m68k                        m5272c3_defconfig
arm64                            alldefconfig
arm                          lpd270_defconfig
i386                          randconfig-c001
sparc                       sparc32_defconfig
sh                          sdk7786_defconfig
openrisc                            defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
hexagon              randconfig-r041-20220827
hexagon              randconfig-r045-20220827
x86_64                        randconfig-a014
x86_64                        randconfig-a005
s390                 randconfig-r044-20220827
x86_64                        randconfig-a016
i386                          randconfig-a002
riscv                randconfig-r042-20220827
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
arm                       netwinder_defconfig
mips                        qi_lb60_defconfig
powerpc                    ge_imp3a_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
