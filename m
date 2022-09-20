Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59725BDCF0
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 08:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiITGOL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 02:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiITGOJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 02:14:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55F65A141
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 23:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663654448; x=1695190448;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5gvZ033BHU1W4P+xOBi9o8Ol+CdwbaStTZtyyHjO9DM=;
  b=AKp8fQDOkR517ThgrOI5XgrBxbApAy/gymTHu0o7w27K5zVMxZuJaEAk
   inohqz33qdPaUEKSisjSjJjzZscIKPugZiXrCxx/SXuw/qux3QwpefR0c
   BJ1NMfoLsWoqVsTE93oEXbC4P/Si4jBqVo2kpTG8dmldsKSvCkxz65K6h
   5DzrSQKOx54TMTnu5HAepuq2cu9yA7LxDWaeIkTMvVYk+NTGeRnsTo532
   lVmsrK3J/V9JfQq3nCt/b81KQzHW4rzTL4GB201wTrnnAUvjC8p3e/FXx
   9tOBCLsoCsux1zizOdWXGIQCoiByMhr6yYP6lDyfY3hEYuvMc1jK/xkq3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279989653"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="279989653"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 23:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="687274470"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Sep 2022 23:14:05 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaWWC-0002XT-2Q;
        Tue, 20 Sep 2022 06:14:04 +0000
Date:   Tue, 20 Sep 2022 14:13:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 6a33d25cf1d1088ca96b9767010c100dcd2af974
Message-ID: <63295a25.QjPUrljk6EVTmQmW%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 6a33d25cf1d1088ca96b9767010c100dcd2af974  loongarch: efi: enable generic EFI compressed boot

elapsed time: 726m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                              defconfig
s390                             allyesconfig
arc                  randconfig-r043-20220919
i386                 randconfig-a013-20220919
i386                 randconfig-a012-20220919
s390                 randconfig-r044-20220919
i386                                defconfig
i386                 randconfig-a014-20220919
i386                 randconfig-a011-20220919
riscv                randconfig-r042-20220919
i386                 randconfig-a016-20220919
x86_64                               rhel-8.3
i386                 randconfig-a015-20220919
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
x86_64               randconfig-a012-20220919
x86_64               randconfig-a011-20220919
i386                             allyesconfig
x86_64               randconfig-a014-20220919
m68k                             allyesconfig
x86_64               randconfig-a015-20220919
m68k                             allmodconfig
x86_64               randconfig-a013-20220919
arc                              allyesconfig
x86_64               randconfig-a016-20220919
alpha                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220919
x86_64               randconfig-a003-20220919
hexagon              randconfig-r045-20220919
x86_64               randconfig-a006-20220919
x86_64               randconfig-a001-20220919
x86_64               randconfig-a005-20220919
x86_64               randconfig-a002-20220919
x86_64               randconfig-a004-20220919
i386                 randconfig-a001-20220919
i386                 randconfig-a002-20220919
i386                 randconfig-a003-20220919
i386                 randconfig-a004-20220919
i386                 randconfig-a005-20220919
i386                 randconfig-a006-20220919

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
