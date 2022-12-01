Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7242163E9C9
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 07:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiLAGRJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 01:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLAGRJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 01:17:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD68A85CF
        for <linux-efi@vger.kernel.org>; Wed, 30 Nov 2022 22:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669875428; x=1701411428;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=E3SgrFjQATrA5qj2QZLfqlyRNfbZghmBDlzbp2pz06E=;
  b=RoXOkvoAXG8b+B+rARC02WZ2j/4tagZVD+QtAjt3oLo4ykSoXAv78Czk
   GQKsJnWBZZ8vfDd+4WN37ghENyuL2g4b2eT5Yt+vy2mKELjcG6FQH1EAY
   wiZdSaeBLoBCtZ359qEonV61dGjf0BLjx3qzOWA00FK22QGoRxpXY11jJ
   iezPzk+BWs7XbErAdbasWXNRQjamfPF8gJVUnU+fwMh58Z6wcHuXmu6zh
   qvk6+RXXHmjBvBMFSAxCRh5xhTsnXg3wn3IPLBVuoA7u3lIlV4YaBiOCl
   xwcS9/O4JmArDDPHHAj0nnR/u6yTHZI/+BEfJ27iKPPr41bT8NX4ofmwn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="342524817"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="342524817"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 22:17:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="644516922"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="644516922"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2022 22:17:06 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0csb-000CEF-30;
        Thu, 01 Dec 2022 06:17:05 +0000
Date:   Thu, 01 Dec 2022 14:16:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 1feda1dfb58149bd8a90b1c1fabb18e7c8af0c65
Message-ID: <638846d6.Ypx7GGfdx5M2IzRb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 1feda1dfb58149bd8a90b1c1fabb18e7c8af0c65  Merge tag 'efi-v6.1-arm64-sync-exception-recovery' into efi/urgent

elapsed time: 726m

configs tested: 70
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
i386                 randconfig-c001-20221128
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arc                  randconfig-r043-20221201
riscv                randconfig-r042-20221201
s390                 randconfig-r044-20221201
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
s390                 randconfig-r044-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
hexagon              randconfig-r045-20221128
x86_64               randconfig-k001-20221128
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64               randconfig-a011-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a015-20221128
powerpc                      ppc64e_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
