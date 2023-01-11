Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3308E665216
	for <lists+linux-efi@lfdr.de>; Wed, 11 Jan 2023 04:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjAKDCo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Jan 2023 22:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjAKDCn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Jan 2023 22:02:43 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A417040
        for <linux-efi@vger.kernel.org>; Tue, 10 Jan 2023 19:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673406162; x=1704942162;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JokzQAqwDGRC6Lvls39NgqM2rJ6UW8fx+hcd7Bo99Dw=;
  b=AOplcarL5i2srSKGjvRxKG7F+G83yRHsTEHVnxW3iYVv8ZSk7qebLa7i
   MwR/corbDvyetJcY63cDWSMAbD0v6L0DBhzX8Xg0fuIJUk4tyDjw6Zg8z
   0FR8my3guarFi07J8wQ5h7rAsSZHAdfRkHc9YCWwZtdDjAINBInp1PaQs
   SbFUTu6CpT8Kb8vVuYAwuVk7PeMZXJhGbd4zy/zfegy/3/2CpRit8SEiZ
   HXr4mZUxaR0IDindjPChtXuED9iFVnoFwgBeZ+nN3eGc7o0RXam/fPCLV
   Uw6bPqStmkLeh81X9wOBzZ4uKYRZRRuoDrMITGcPKCQiIBA9QEfXcODF/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311127370"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="311127370"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 19:02:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="650584332"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="650584332"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2023 19:02:40 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFRNv-0008fK-2B;
        Wed, 11 Jan 2023 03:02:39 +0000
Date:   Wed, 11 Jan 2023 11:02:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 2a5b4ccf0de17e47e9ad13ee0fda9436d5de0a35
Message-ID: <63be26ac.FHE8qCfNM20YoJO/%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 2a5b4ccf0de17e47e9ad13ee0fda9436d5de0a35  efi/earlycon: Speed up scrolling by disregarding empty space

Unverified Warning (likely false positive, please contact us if interested):

drivers/firmware/efi/earlycon.c:178 efi_earlycon_write() error: potentially dereferencing uninitialized 's'.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-m001
    `-- drivers-firmware-efi-earlycon.c-efi_earlycon_write()-error:potentially-dereferencing-uninitialized-s-.

elapsed time: 723m

configs tested: 51
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
arc                                 defconfig
alpha                               defconfig
sh                               allmodconfig
s390                             allmodconfig
s390                                defconfig
ia64                             allmodconfig
i386                             allyesconfig
i386                                defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
riscv                randconfig-r042-20230110
s390                 randconfig-r044-20230110
arc                  randconfig-r043-20230110
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
m68k                          amiga_defconfig
riscv                            allmodconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust
mips                malta_qemu_32r6_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
