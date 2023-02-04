Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B194F68ACF0
	for <lists+linux-efi@lfdr.de>; Sat,  4 Feb 2023 23:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBDWvG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 4 Feb 2023 17:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDWvF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 4 Feb 2023 17:51:05 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099972684A
        for <linux-efi@vger.kernel.org>; Sat,  4 Feb 2023 14:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675551061; x=1707087061;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jgmQe+XzYq0wYqASywGru5yk77SsS/zxzsoWtVOjddA=;
  b=htI6TlYa9xBJqu2EGTU+/MhR0Hz9RQfDOmXPCULNjgrXBWvGoKvQ2O6B
   QV0GWVmrjSx9/0tuanRRGH9Gp/+LVTUaQ9TwUW57LRf+RZdeXsdqA7rTc
   fk5EF+FTJ1nm1ivVwx0Hyfz1ompHewWiL8PO3JYPGe8iH7PG1a+korCzC
   M7y3KoJKM4Heqo0e8LUvVd0lxD9lTC6nwiWmSp1T09C4rxkPa2zrE4gLa
   DBqbKrEXT9XEFg8szCho7YeYW7OurvoCetismWuljzT3YbCPHVKa/z7Uo
   AoJNxEmJx0OjqOC0M3NLl5VzHw7bZkCmAYuAAQlooCjKd7h/3ep3IPMqS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="391395007"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="391395007"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 14:51:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="666104033"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="666104033"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Feb 2023 14:50:59 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pORN4-0001ZI-29;
        Sat, 04 Feb 2023 22:50:58 +0000
Date:   Sun, 05 Feb 2023 06:50:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS f4412001b6521003e4938d710cbfae5c50f508ad
Message-ID: <63dee11b.jsVnYuqDKKWjyKy4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: f4412001b6521003e4938d710cbfae5c50f508ad  efi: arm64: Wire up BTI annotation in memory attributes table

elapsed time: 830m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20230204
s390                 randconfig-r044-20230204
riscv                randconfig-r042-20230204
m68k                             allmodconfig
arc                                 defconfig
arc                              allyesconfig
s390                             allmodconfig
alpha                               defconfig
alpha                            allyesconfig
x86_64                              defconfig
m68k                             allyesconfig
ia64                             allmodconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
s390                                defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
s390                             allyesconfig
sh                               allmodconfig
x86_64                           allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a013
i386                          randconfig-a001
x86_64                        randconfig-a011
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
hexagon              randconfig-r045-20230204
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                randconfig-r042-20230205
s390                 randconfig-r044-20230205
hexagon              randconfig-r045-20230205
hexagon              randconfig-r041-20230205

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
