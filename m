Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86DE691894
	for <lists+linux-efi@lfdr.de>; Fri, 10 Feb 2023 07:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjBJGkc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Feb 2023 01:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBJGkb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Feb 2023 01:40:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6905CBC2
        for <linux-efi@vger.kernel.org>; Thu,  9 Feb 2023 22:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676011229; x=1707547229;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tgXnwnsmlPMb+B4Wph8klc2icD/9S1odPyCxKOmfIXk=;
  b=LrW299D/hAUbz9xdNAzHA9Y/0VR3TyCTFLCKe10zHImGj8AmWici6Oa7
   4Kh89loPiKQ9sifmETpMNCEqWx4PWpBRJq2PTSPvcdwEw96RAE5rfxpE4
   5hOAXeNfcbm+brAsMrlJZ+WTd5JY5x6HZc7PkTttzxEKjPrYLPLl6RstB
   +woBF70pAds6y2cvUyiUt06GYMvjx68wDeoUgRpJuHUC/Ac5yH/14IY10
   qveDeZuq1YO1KFTKtTChRxYzMYi0fNR7bWBuxEl3U1X89qNdhCucH9F6i
   s25/gyE5e/weGIiXdQbVb2zjKGOTIo+v8Z8j5v01v5t7iwR9S8FqYZbJ4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328980255"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="328980255"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 22:40:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="667947348"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="667947348"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2023 22:40:27 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQN58-0005d4-39;
        Fri, 10 Feb 2023 06:40:26 +0000
Date:   Fri, 10 Feb 2023 14:39:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 93be2859e26c3be847780c65313da1b261833451
Message-ID: <63e5e6a7.1hQVpdvK9uwpzZ+9%lkp@intel.com>
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
branch HEAD: 93be2859e26c3be847780c65313da1b261833451  efi: x86: Wire up IBT annotation in memory attributes table

elapsed time: 720m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                              defconfig
powerpc                          allmodconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20230209
x86_64                           rhel-8.3-bpf
arm                  randconfig-r046-20230209
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a014
m68k                             allyesconfig
m68k                             allmodconfig
i386                          randconfig-a012
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                                defconfig
i386                             allyesconfig
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20230209
hexagon              randconfig-r045-20230209
s390                 randconfig-r044-20230209
i386                          randconfig-a013
riscv                randconfig-r042-20230209
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a012
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
