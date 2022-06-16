Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C66754D9FF
	for <lists+linux-efi@lfdr.de>; Thu, 16 Jun 2022 07:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357128AbiFPFtv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Jun 2022 01:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiFPFtu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Jun 2022 01:49:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CBB5B8A2
        for <linux-efi@vger.kernel.org>; Wed, 15 Jun 2022 22:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655358590; x=1686894590;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jLBhXUJCmfw3KgYOdMex2wccYRDDj7Fey4+OudzzgQM=;
  b=LLCpDrlOQYFndzVMCL1FXVDeT9Yscw3kosUOm4HiGKsdaJNWZYQNYHks
   E8px4ar81NQEnj9w2I2J1yADgT+Me1dDfnbmw7dx3YfszE0h+VjGmERv5
   hj0RoM2KOTv7PTkdzi0OhM/jhf5Zgiu2kcXrCRzgcp5yQgNjm6/pz9jNZ
   20QQ9YyPzvqk3/O9mzb3r6QCUTuN8+hzcf7CaFuEShjkAbJd8GsH8m7oq
   cMb+Ki6BBWEL6R8hCDzPBiIYxSnbr3w8TnWCeA2UlJxtKE1ekfPhqJlN9
   vVv2lCs+aqGK170efnTgjnYISYl4jjrfE5Va8Hf4FN/WJ3P+dUUsxJhJQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="277968994"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="277968994"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="912020395"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2022 22:49:49 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1iO4-000O7P-MK;
        Thu, 16 Jun 2022 05:49:48 +0000
Date:   Thu, 16 Jun 2022 13:49:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 902c2d91582c7ff0cb5f57ffb3766656f9b910c6
Message-ID: <62aac44c.AcgeTOmrlT+hVkRy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 902c2d91582c7ff0cb5f57ffb3766656f9b910c6  memblock: Disable mirror feature if kernelcore is not specified

elapsed time: 1117m

configs tested: 52
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
