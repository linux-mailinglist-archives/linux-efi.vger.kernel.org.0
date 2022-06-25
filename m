Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0755A7EB
	for <lists+linux-efi@lfdr.de>; Sat, 25 Jun 2022 09:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiFYH7A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Jun 2022 03:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiFYH7A (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 Jun 2022 03:59:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C49403D1
        for <linux-efi@vger.kernel.org>; Sat, 25 Jun 2022 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656143939; x=1687679939;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RCf7fwlgY7jejDDZFhN74TlolkCOgjwTvaT9xhTY7kM=;
  b=j1LZ6acDZ5p6OBUPOny0XvcolDlGo4Shr8HxlsHBpofyY6taJMzvGDNJ
   Ug6UtnNacxJyOkRgBUgoARm0urSS8RtH8yzrAuechHECVFIXBsA8OHebT
   wss3vx73q07sbwcE90ivgu1hWKbR7DhqklHuDWkxY8EAOhhpqYYpJxhT1
   IQkO9XjEyBYNnQf5avtZddLI6aF1rAWcIBI+wtrDJRqFIasAF7pH0uL9a
   UJbzfB++1lphQRtIKEM+Jpv5Nwu5w2EerYXHzaXO8sWhOMVAqE+cigmm8
   +mBdEQuCq/YQ/o0EE+yxMCy0xAufIL/dkRrXhg9RCgAAb2TcM4oIcEmCX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="342850500"
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="342850500"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 00:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="656960432"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jun 2022 00:58:58 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o50gz-0005WZ-Gy;
        Sat, 25 Jun 2022 07:58:57 +0000
Date:   Sat, 25 Jun 2022 15:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 2d82e6227ea189c0589e7383a36616ac2a2d248c
Message-ID: <62b6c01c.eKtZey2FW/J9vfC2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 2d82e6227ea189c0589e7383a36616ac2a2d248c  efi: vars: Move efivar caching layer into efivarfs

elapsed time: 739m

configs tested: 50
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
riscv                randconfig-r042-20220625
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                randconfig-r042-20220624
hexagon              randconfig-r041-20220624
hexagon              randconfig-r045-20220624
s390                 randconfig-r044-20220624
hexagon              randconfig-r041-20220625
hexagon              randconfig-r045-20220625

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
