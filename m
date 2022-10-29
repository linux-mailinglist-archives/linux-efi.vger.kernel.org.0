Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC3612095
	for <lists+linux-efi@lfdr.de>; Sat, 29 Oct 2022 07:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJ2FlH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Oct 2022 01:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2FlH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Oct 2022 01:41:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFC087FB4
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 22:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667022066; x=1698558066;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XOt3E5PDMiXFU6cOliOIxYgkEZfpFcoS4UOmeCzALwc=;
  b=Hkjqqe/lOnof+0n6674EtFS40PNN3LYAyiH4t9Qes6VJHylhdUySh0bI
   zZpGfMV4fFyv8sQ4PQ+u3OdQHz3M+Foqlic78MncwYTYR/rPiPZRwC7ST
   knTnXnuzcp+d0S88lnfupnVTage7rmrIcE6NhUbY7hDnTF+8d3ZMWKPgu
   J4Aa7Xy5+gJ2dwY6Ua6VWa73fbrrr3xkf81otJlcseapC7s46ZOPRpRv7
   H2RVySFf31orQyxBjjAffbRrOg30tz8afGre0PwNiilPd9bl4JG1T1aOQ
   sZ4ijuzodo8kT0QbZjVEp6041FjqlFD9jcvOv61lEuO33XfJ0DZCgk+M4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="370713655"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="370713655"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 22:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="664252616"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="664252616"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 28 Oct 2022 22:41:05 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooeae-000Af1-1I;
        Sat, 29 Oct 2022 05:41:04 +0000
Date:   Sat, 29 Oct 2022 13:40:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 4e1c390e882d6f1d8c25221d041dfb832e460787
Message-ID: <635cbcbb.SLE/7Wx6U7m1KqMH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 4e1c390e882d6f1d8c25221d041dfb832e460787  arm64: efi: Recover from synchronous exceptions occurring in firmware

elapsed time: 722m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
ia64                             allmodconfig
alpha                            allyesconfig
powerpc                           allnoconfig
arc                              allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221028
mips                             allyesconfig
sh                               allmodconfig
i386                                defconfig
riscv                randconfig-r042-20221028
s390                 randconfig-r044-20221028
x86_64                              defconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a014
i386                          randconfig-a012
arc                                 defconfig
i386                          randconfig-a016
s390                             allmodconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
arm                                 defconfig
i386                          randconfig-a001
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
i386                          randconfig-a003
x86_64                        randconfig-a013
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a011
x86_64                        randconfig-a004
i386                             allyesconfig
s390                                defconfig
i386                          randconfig-a005
x86_64                        randconfig-a015
arm                              allyesconfig
s390                             allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20221028
hexagon              randconfig-r045-20221028
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a002
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a016
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
