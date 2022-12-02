Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791BD640024
	for <lists+linux-efi@lfdr.de>; Fri,  2 Dec 2022 07:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiLBGMD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Dec 2022 01:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiLBGMC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Dec 2022 01:12:02 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246AFDC84D
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 22:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669961521; x=1701497521;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DCTuaGhYhWmUFyZZTsbh8iXhGzixW5qSSCgwXITAav8=;
  b=mnM4DoItYgh4Qfs+m0UIEeoJUxXypsZKCCugVcgmrrFVqt4/Ck/aAAdI
   NpiWAhRToahvunFIvF7+D+47QLS6v/bjg4UEw96BdHAHY9F28IAFrM4wO
   hmntvF7m2j4CFaN/DSRZCmwKaDJX9ODWGn+UxIosEgPqDhbgqUmLWyPzE
   JrIU+lTjHqggMqJF+/yALDqRI3O9x/hEZb0J4Yrc6AutLW3q5PwHSS+4i
   T7VgEFmd8fBnKqA/GY0Na4cbA6ukUDcCwPubu/x0B6meZ/ltt5jpozHq5
   nZdmySMOpp6RC2+980K0oU997ZYd1NUccfGIPjHtFN02LYQIaFnZH/EYv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="296235188"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="296235188"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 22:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="647045692"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="647045692"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Dec 2022 22:11:59 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0zHD-000DKo-1A;
        Fri, 02 Dec 2022 06:11:59 +0000
Date:   Fri, 02 Dec 2022 14:11:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 7572ac3c979d4d0fb42d73a72d2608656516ff4f
Message-ID: <638996f5./ClK2XOBzO3GZ594%lkp@intel.com>
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
branch HEAD: 7572ac3c979d4d0fb42d73a72d2608656516ff4f  arm64: efi: Revert "Recover from synchronous exceptions ..."

elapsed time: 909m

configs tested: 59
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
s390                             allyesconfig
ia64                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
x86_64                              defconfig
arc                  randconfig-r043-20221201
x86_64                               rhel-8.3
riscv                randconfig-r042-20221201
s390                 randconfig-r044-20221201
i386                          randconfig-a001
x86_64                           allyesconfig
i386                          randconfig-a003
x86_64                        randconfig-a013
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                            allnoconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221201
hexagon              randconfig-r045-20221201
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
