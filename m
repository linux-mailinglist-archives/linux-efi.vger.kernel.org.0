Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979D0647D87
	for <lists+linux-efi@lfdr.de>; Fri,  9 Dec 2022 07:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiLIGAL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Dec 2022 01:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLIGAL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Dec 2022 01:00:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A17D087
        for <linux-efi@vger.kernel.org>; Thu,  8 Dec 2022 22:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670565608; x=1702101608;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=x1LNsgVqClZkTnFkRASsTJqN8KqbnM5qvdau+BbDiHI=;
  b=E/c7b8SIzc4pWnQaTmSfXM1LkaAsbJOF4rwijPsjYyZi9l0AuZrp8iUu
   vjYnN6e6W+EGDypI6gNQ1/WyzVPK8BpQnpg9D8Grs6NI96XZDv08tHzHN
   ViRmJrwifoezwtAnUlP/1dXaEf1Xp3kPTy3Gp9bWo2iQ4s83elswUrmnu
   C7jTzwrvCXEoLNrYY28i6elfxWbvAViZosBLUTwYLC1FmiXEE8wcxsSF9
   qxSpSTc9af+susExXfKxpN4YEHdXCo+CI/ovAClSdm/0CuhxTzP/eRZ7N
   569uh1x2/mnwnCNsp1Hus6FzZBmK4FLfC+0zFJVWGvUHExOG6M5ipWqAP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="344422925"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="344422925"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 22:00:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="625005018"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="625005018"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2022 22:00:06 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3WQX-0001fv-2c;
        Fri, 09 Dec 2022 06:00:05 +0000
Date:   Fri, 09 Dec 2022 13:59:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS e8dfdf3162eb549d064b8c10b1564f7e8ee82591
Message-ID: <6392ceae.kn4VsuWI49pxnMSM%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: e8dfdf3162eb549d064b8c10b1564f7e8ee82591  arm64: efi: Recover from synchronous exceptions occurring in firmware

elapsed time: 728m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20221207
x86_64                               rhel-8.3
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20221207
x86_64                          rhel-8.3-func
s390                 randconfig-r044-20221207
i386                                defconfig
x86_64                           allyesconfig
ia64                             allmodconfig
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                             allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
arm                              allyesconfig
i386                          randconfig-a005
arm64                            allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                            allnoconfig
arm                     eseries_pxa_defconfig
arc                        nsimosci_defconfig
arm                            qcom_defconfig
i386                          randconfig-c001

clang tested configs:
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
