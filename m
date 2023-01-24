Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69045678D76
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jan 2023 02:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjAXBdf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 20:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjAXBde (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 20:33:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD21258F
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 17:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674524014; x=1706060014;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SAzM7sCMww0xD2R0vRJltWUvlo20eDz2lSO8dIVp5FU=;
  b=BJT60Wf82eNl8GZeSIzVATa9T8b9Kqu89yTHMFiczZz9xHOglFCVjTaE
   pEV3uEOSsPzOxzSdQJ5Q66i21xPz1v7RLS8RzpeMI0tTitnc8xQOkV/6Z
   Ru8r5pVOJqLZ/y9I0oC5s3vPkbNRmG0JttNMx4A/BNwO+E8BGUtC6t003
   xEimIQeMyWlS0v5pqMLJfBX4HMnElqsjb+dFij1PIOuy51TMnSdaucoN4
   pi5cWvNGgNg2KISKyZNMtdwXKpJvLno7Ww/Bm/fqVt/+8mkUJzP0HpzB5
   imE3INY1vuUsTyrb2IIpadzS/YHHK4eWuVRAkEs18HAkEl8o5YFxo25ZY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="412439774"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="412439774"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 17:33:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="655253097"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="655253097"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2023 17:33:31 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pK8Bm-00061I-29;
        Tue, 24 Jan 2023 01:33:30 +0000
Date:   Tue, 24 Jan 2023 09:33:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 8b30ec8d5eb17bf60bbd0fa8c45d03ad0b9d8a15
Message-ID: <63cf3550.L48m3O2pjIT+KqyV%lkp@intel.com>
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
branch HEAD: 8b30ec8d5eb17bf60bbd0fa8c45d03ad0b9d8a15  efi: efivars: prevent double registration

elapsed time: 726m

configs tested: 66
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                            allnoconfig
powerpc                           allnoconfig
sh                               allmodconfig
alpha                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
um                             i386_defconfig
m68k                             allmodconfig
um                           x86_64_defconfig
arc                              allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
i386                                defconfig
i386                             allyesconfig
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
x86_64                           allyesconfig
x86_64               randconfig-a002-20230123
i386                 randconfig-a001-20230123
x86_64               randconfig-a001-20230123
x86_64               randconfig-a004-20230123
x86_64               randconfig-a003-20230123
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64               randconfig-a006-20230123
x86_64               randconfig-a005-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
i386                 randconfig-a004-20230123
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit

clang tested configs:
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
x86_64                          rhel-8.3-rust
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a014-20230123
i386                 randconfig-a012-20230123
x86_64               randconfig-a015-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
x86_64               randconfig-a016-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a015-20230123
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
