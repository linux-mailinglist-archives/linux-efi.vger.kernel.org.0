Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E743765CA1A
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 00:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjACXB6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Jan 2023 18:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjACXBv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Jan 2023 18:01:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311E812604
        for <linux-efi@vger.kernel.org>; Tue,  3 Jan 2023 15:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672786910; x=1704322910;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zZyYY30cTJKUomO8RM+ZbatPQ2x2yRVYFQ75ESPrfAI=;
  b=XMvBkDW14xd8UJfcU5S5MfGqzlT6vHlJsXdlj43jc3+YzvRjcF+PHEfl
   dE4F3kDohl4jyDsKpnmRWRTW09rqIqjupOUkW5lefOFB5fDP7CGYiwJON
   MIdy/S5dUs0JmtGL/FZpELv8wpsS1QM2clhfBZaHjMCFaBkhI7kYrGypx
   SvRjdMB+2iMWPleeGdepiF6bt03yHYI8eG4JE1Ft/7fdHTV3fIVnPJ0Kn
   jKXDvmuMNoU+Fz6GVkaIEfM8m/Ca8xDhfBZbdUQhRqKC/cC4h0xe47ZoD
   u7hR/0dINj8SCaazw+HoXxje5Lc2Uo9q3CKuA+axzhQgmDhOv9O+cHzTX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="323009614"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="323009614"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 15:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="656923653"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="656923653"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jan 2023 15:01:48 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pCqHu-000Ss9-1G;
        Tue, 03 Jan 2023 23:01:42 +0000
Date:   Wed, 04 Jan 2023 07:01:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 e006ac3003080177cf0b673441a4241f77aaecce
Message-ID: <63b4b3c4.CFJgXIKSlhvS2ANI%lkp@intel.com>
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
branch HEAD: e006ac3003080177cf0b673441a4241f77aaecce  efi: fix userspace infinite retry read efivars after EFI runtime services page fault

elapsed time: 721m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
sh                               allmodconfig
arm                                 defconfig
powerpc                          allmodconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                           rhel-8.3-bpf
alpha                               defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
i386                                defconfig
s390                                defconfig
i386                 randconfig-a004-20230102
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
i386                 randconfig-a002-20230102
s390                             allyesconfig
i386                 randconfig-a005-20230102
i386                 randconfig-a006-20230102
x86_64               randconfig-a003-20230102
x86_64               randconfig-a001-20230102
x86_64               randconfig-a004-20230102
x86_64               randconfig-a002-20230102
x86_64               randconfig-a005-20230102
arm64                            allyesconfig
x86_64               randconfig-a006-20230102
i386                             allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20230101
arc                  randconfig-r043-20230102
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101
s390                 randconfig-r044-20230101

clang tested configs:
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a013-20230102
i386                 randconfig-a012-20230102
i386                 randconfig-a016-20230102
i386                 randconfig-a015-20230102
x86_64               randconfig-a011-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a013-20230102
x86_64               randconfig-a015-20230102
x86_64               randconfig-a016-20230102
x86_64               randconfig-a014-20230102
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230102
s390                 randconfig-r044-20230102
hexagon              randconfig-r045-20230101
hexagon              randconfig-r045-20230102
arm                  randconfig-r046-20230101
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
