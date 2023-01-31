Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E588682161
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 02:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjAaB2a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Jan 2023 20:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAaB23 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Jan 2023 20:28:29 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0682942E
        for <linux-efi@vger.kernel.org>; Mon, 30 Jan 2023 17:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675128508; x=1706664508;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3amhW1S+lh6sa7y6JWYjCR7FIgZnjlHAPUF8/AibQpk=;
  b=ip6IGlnLIBwUyVsPWBCwmRDtxoDyaOauGYsdhSdhC1OsxZO9MSi5CD0x
   b1NKN+P9x7PTfJB1guW5qeBjyj3NOSm6mfhJakbkd3EfyX+Ai4a+ujXEr
   2zAzzVJFNfnaFTyMToLLHolsY4DUsO73KtGCYC2rPxNMWzHUNEXHnOeZa
   p0SVecjwiVqrre1bZ3YIwiIfTv6rwtVPlUOyzgTjd2+L6UGVaj/LlC5F5
   9zNkQz1lwIeHcn0suDhbAxiP3c8l5oiOH4l6e27ApMcNXP4h4yTSHbm9G
   naUUKRO92ubqYwKujltW3AZ29fZCtSX1L09UUV2y7TevsLjbOeHVeZjUe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="413939944"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="413939944"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 17:28:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="806917144"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="806917144"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2023 17:28:27 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMfRi-00042a-2H;
        Tue, 31 Jan 2023 01:28:26 +0000
Date:   Tue, 31 Jan 2023 09:27:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 3b7221033c0ed624029157045956a472bb582a44
Message-ID: <63d86e94.KubJbEwO5Lvkf3qR%lkp@intel.com>
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
branch HEAD: 3b7221033c0ed624029157045956a472bb582a44  efi: zboot: Use EFI protocol to remap code/data with the right attributes

elapsed time: 726m

configs tested: 94
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
x86_64                            allnoconfig
i386                 randconfig-a001-20230130
powerpc                           allnoconfig
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a002-20230130
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
i386                 randconfig-a005-20230130
x86_64               randconfig-a004-20230130
i386                 randconfig-a006-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                          rhel-8.3-func
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                               rhel-8.3
arc                              allyesconfig
mips                             allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
i386                                defconfig
arm                                 defconfig
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20230129
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm                  randconfig-r046-20230129
x86_64                           rhel-8.3-bpf
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
sh                          sdk7786_defconfig
sh                          rsk7269_defconfig
powerpc                       holly_defconfig
arm                         nhk8815_defconfig
arm                         s3c6400_defconfig
csky                                defconfig
sh                          r7785rp_defconfig
m68k                        stmark2_defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                        nsim_700_defconfig
sh                          sdk7780_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64                          rhel-8.3-rust
x86_64               randconfig-a014-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a016-20230130
mips                       lemote2f_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    mvme5100_defconfig
powerpc                      pmac32_defconfig
arm                         s3c2410_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
