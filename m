Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12944672A77
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jan 2023 22:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjARV14 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Jan 2023 16:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjARV1T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Jan 2023 16:27:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCD237B74
        for <linux-efi@vger.kernel.org>; Wed, 18 Jan 2023 13:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674077239; x=1705613239;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zJf2GGfYuXmNtdz9n0KgqFCzstFEjfRPZuZtxU2aJ6M=;
  b=eR9Be3zThEeP1RA6H/FSd1GuQFlmRwd6d/8opzdJdCke6f4cptCW1DRa
   uCNGmpf8qaNz5orod3e3LkBB0skKPxpt4irULDe0U3IVlvQMMMTc7hG1y
   cbYXnG+pH3Uh+EMuklPkWVKDxbCHHepcuTrq6Hf5FiAvg6GGdDZMAOsnk
   SNf05iK7iC4Z5mdGBD45mzKwL383bsU1O9K0emVJmtzIyTYVdJ8XjmTFU
   jg0y1NX4s3akf8RmGvvP3c24PY/UHzYC7EQJzSOoqRyuXiuLwgRu9epYI
   vIstxCyp0W/94fPD+XS5MERwJWpXib/E5HP0BMYwoo1DfVWeAmOl9YxYi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="326371298"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="326371298"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 13:27:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="653115951"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="653115951"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2023 13:27:14 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIFxi-0000jW-0f;
        Wed, 18 Jan 2023 21:27:14 +0000
Date:   Thu, 19 Jan 2023 05:26:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 e1fabbc83cb1dd4ba63932faa86c9cacb8bf791e
Message-ID: <63c8640a.bAJe7G3IotbWSc7h%lkp@intel.com>
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
branch HEAD: e1fabbc83cb1dd4ba63932faa86c9cacb8bf791e  efi: Remove Matthew Garrett as efivarfs maintainer

elapsed time: 726m

configs tested: 88
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                                defconfig
arc                  randconfig-r043-20230118
arm                                 defconfig
s390                 randconfig-r044-20230118
riscv                randconfig-r042-20230118
i386                          randconfig-a014
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm64                            allyesconfig
m68k                             allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
arm                              allyesconfig
alpha                            allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                       m5208evb_defconfig
arm                         s3c6400_defconfig
sh                        dreamcast_defconfig
xtensa                              defconfig
mips                       bmips_be_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            alldefconfig
sh                 kfr2r09-romimage_defconfig
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
powerpc                      ppc6xx_defconfig
m68k                        m5307c3_defconfig
powerpc                      cm5200_defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
i386                          randconfig-c001
nios2                            allyesconfig
nios2                               defconfig
parisc64                            defconfig
sh                                  defconfig
powerpc                mpc7448_hpc2_defconfig
parisc                           allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20230118
arm                  randconfig-r046-20230118
hexagon              randconfig-r045-20230118
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
mips                          ath25_defconfig
mips                     loongson2k_defconfig
powerpc                     ppa8548_defconfig
mips                          rm200_defconfig
powerpc                     skiroot_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                    socrates_defconfig
arm                          ep93xx_defconfig
arm                      tct_hammer_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                              alldefconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
