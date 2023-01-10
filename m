Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674F366395B
	for <lists+linux-efi@lfdr.de>; Tue, 10 Jan 2023 07:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAJGaD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Jan 2023 01:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjAJGaC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Jan 2023 01:30:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F313D48804
        for <linux-efi@vger.kernel.org>; Mon,  9 Jan 2023 22:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673332201; x=1704868201;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UYra2RhFl7IbHnv0hhFsB5iElFdGLhn8It5k0RCafZU=;
  b=UaPwmTTTAgux4C1YFb8K2fksl2x9SMPdw6M5+DwhCSqXowssAi4fX1Dr
   CrNBXYPEcBmIpP7tFlMcfLJga5BAO9CnBRrccAzkLv0eby0mX9cjWdLKZ
   eW6MHFrsMBwZTqhMQvhSa29YQl2hH5JnnYcKevlMIxDQxA+jc93Qe2nSp
   GFhqsOxb7UA6r2usQiautAoUTRglQbOTkGOkXdurYwa0l01zzUk5jYYIo
   8ZR7T1T1YEx4ysacUH3/UIdlwsLNM9dVrktjaREZg2NfLgosUF1Lf75fJ
   hI9wDm+zZlqeA0JaR7LrFs3WBjroz7WcW85tn55v/hxJ2hgegE8HI8eD0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="321773741"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="321773741"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 22:30:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="689314440"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="689314440"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2023 22:29:59 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pF890-0007gE-1r;
        Tue, 10 Jan 2023 06:29:58 +0000
Date:   Tue, 10 Jan 2023 14:29:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 7b817a99509125ee1337888ec453a76ce5937ae8
Message-ID: <63bd05c0.ymoe+bPsuRL1XH4+%lkp@intel.com>
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
branch HEAD: 7b817a99509125ee1337888ec453a76ce5937ae8  efi: tpm: Avoid READ_ONCE() for accessing the event log

elapsed time: 727m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
sh                               allmodconfig
mips                             allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm                                 defconfig
arm64                            allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arm                              allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                 randconfig-a014-20230109
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
i386                 randconfig-a012-20230109
x86_64               randconfig-a011-20230109
x86_64               randconfig-a013-20230109
x86_64               randconfig-a012-20230109
i386                 randconfig-a016-20230109
x86_64               randconfig-a014-20230109
x86_64               randconfig-a015-20230109
i386                 randconfig-a015-20230109
x86_64               randconfig-a016-20230109
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                                defconfig
ia64                             allmodconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006

clang tested configs:
i386                 randconfig-a004-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a001-20230109
i386                 randconfig-a006-20230109
i386                 randconfig-a005-20230109
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
arm                          pcm027_defconfig
powerpc                       ebony_defconfig
mips                     loongson1c_defconfig
mips                      maltaaprp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
