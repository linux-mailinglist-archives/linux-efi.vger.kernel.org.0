Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6C165B838
	for <lists+linux-efi@lfdr.de>; Tue,  3 Jan 2023 00:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjABXhL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Jan 2023 18:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjABXhJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Jan 2023 18:37:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709A010A3
        for <linux-efi@vger.kernel.org>; Mon,  2 Jan 2023 15:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672702627; x=1704238627;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1AE9G0/D9yDr4GBHXbD75Pvlwj/yCP9o9zJCVTGwbGA=;
  b=LpRGjC+vwU6ZYtg4a8EKAqPahsnhsaNDw+oPuRuKEmB4Ec2vyqAqLuMX
   /9I2kkyXDbbQquUsThNPaZdk+TaJ+xwrGyEnAp9brDun7EbV705xeIwjx
   0E7P+/7wPbMFChEIIilAZpOXc6FvQk/ryMI2pPg7nwRK/ojqA/MwmrWkR
   fWeDc/3Nn3OLTk4/RLwL1lP+860/eAoth0R6vK5s/vKsD7wblRv30DlBH
   nJ9EtORxmGOD0MlVIqsJdygPHp4Pti+dJc/y0vRfWfr01IIqQQeA9BCnQ
   WracAD14IJaO/tngeN7ZE09hXmgz8BDFQ3pPfcVJB8aOZHAbmfkb2236n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="348771862"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="348771862"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 15:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="899986178"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="899986178"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jan 2023 15:37:06 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pCUMb-000Rbf-16;
        Mon, 02 Jan 2023 23:37:05 +0000
Date:   Tue, 03 Jan 2023 07:36:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 8a38790a9df1b89c86182dd40410c9e2de8fd563
Message-ID: <63b36a8e.uSeFWxQpkRYoaSR3%lkp@intel.com>
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
branch HEAD: 8a38790a9df1b89c86182dd40410c9e2de8fd563  efi: fix userspace infinite retry read efivars after EFI runtime services page fault

elapsed time: 729m

configs tested: 69
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                             i386_defconfig
s390                             allmodconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                                defconfig
alpha                            allyesconfig
s390                             allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                                defconfig
powerpc                           allnoconfig
i386                             allyesconfig
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
ia64                             allmodconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20230102
x86_64                               rhel-8.3
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
i386                 randconfig-a002-20230102
arm                                 defconfig
i386                 randconfig-a005-20230102
i386                 randconfig-a006-20230102
x86_64                           allyesconfig
x86_64               randconfig-a003-20230102
x86_64               randconfig-a001-20230102
x86_64               randconfig-a004-20230102
riscv                randconfig-r042-20230101
x86_64               randconfig-a002-20230102
x86_64                            allnoconfig
s390                 randconfig-r044-20230101
x86_64               randconfig-a006-20230102
x86_64               randconfig-a005-20230102
arc                  randconfig-r043-20230102
arm                              allyesconfig
arm64                            allyesconfig
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a013-20230102
i386                 randconfig-a012-20230102
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a015-20230102
i386                 randconfig-a016-20230102
x86_64               randconfig-a011-20230102
x86_64               randconfig-a014-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a013-20230102
x86_64               randconfig-a015-20230102
x86_64               randconfig-a016-20230102
hexagon              randconfig-r041-20230102
s390                 randconfig-r044-20230102
hexagon              randconfig-r045-20230101
hexagon              randconfig-r045-20230102
arm                  randconfig-r046-20230101
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
