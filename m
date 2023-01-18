Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F47671339
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jan 2023 06:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjARF2l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Jan 2023 00:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjARF2X (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Jan 2023 00:28:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DACC53B0B
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 21:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674019699; x=1705555699;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7y2RdqnEPA3GmPnyri494rKGtNzGINVSSdKCgDbmkso=;
  b=Pwb9v9EoPqzwvUV/p4p2A/pPdgwzlrCk8QD8vB0X48KtMBYRDhBYlayy
   Gc/4Yw0kdo6deJGjODtIYkCeF14KUQV0GWN5QbeYipODM7D98irOcUwb7
   7VerKHD3w0Nwvbg2a9EEBtD+ElFwqbIL93PFjV9maLHNedRdtwfOLjIed
   05vO/afpug3v1GoITLqEIJMsDKI1bVnoBqX9Rd6lRQAdsds4hkmf6qieX
   b/nVQ5C9grOWCbJDgVcgpi6E5T/ubwR+x5CZqukGIBIRV2EKsFEULzCXl
   +4u04sBMu0CMe+68sxOwyk9YYEvYzBMSsKbdCKutrQHqLXSz4FHFpnk9a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="326977659"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326977659"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 21:28:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="652788206"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="652788206"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2023 21:28:17 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pI0zg-0001f6-2F;
        Wed, 18 Jan 2023 05:28:16 +0000
Date:   Wed, 18 Jan 2023 13:27:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 2cf9e278efeff8f8bbb9580e2d6760e19795e310
Message-ID: <63c78345.h+26Bq3pmpA0vCdx%lkp@intel.com>
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
branch HEAD: 2cf9e278efeff8f8bbb9580e2d6760e19795e310  efi: efivars: make efivar_supports_writes() return bool

elapsed time: 725m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                            allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a013-20230116
i386                 randconfig-a012-20230116
i386                 randconfig-a016-20230116
i386                 randconfig-a014-20230116
i386                 randconfig-a011-20230116
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
riscv                randconfig-r042-20230116
arm                  randconfig-r046-20230117
s390                 randconfig-r044-20230116
arc                  randconfig-r043-20230117
arc                  randconfig-r043-20230116
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
riscv                randconfig-r042-20230118
s390                 randconfig-r044-20230118
arc                  randconfig-r043-20230118
i386                 randconfig-c001-20230116
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a011-20230116
x86_64               randconfig-a016-20230116
x86_64               randconfig-a014-20230116
x86_64               randconfig-a013-20230116
x86_64               randconfig-a015-20230116
x86_64               randconfig-a012-20230116
i386                 randconfig-a015-20230116
m68k                            q40_defconfig
ia64                      gensparse_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                  decstation_64_defconfig
m68k                          multi_defconfig
powerpc                    sam440ep_defconfig
sh                         ap325rxa_defconfig
riscv                            allyesconfig
i386                          randconfig-c001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                  randconfig-r046-20230115
arc                  randconfig-r043-20230115
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
m68k                          hp300_defconfig
arm                            lart_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20230117
powerpc                      bamboo_defconfig
arm                           imxrt_defconfig
powerpc                      makalu_defconfig
arm                        cerfcube_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                        generic_defconfig
sh                 kfr2r09-romimage_defconfig
openrisc                         alldefconfig
arm                     eseries_pxa_defconfig
powerpc                 linkstation_defconfig
mips                  maltasmvp_eva_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a001-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a006-20230116
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                      acadia_defconfig
arm                        magician_defconfig
riscv                             allnoconfig
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a006-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a001-20230116
x86_64               randconfig-a002-20230116
powerpc                     tqm8560_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     kmeter1_defconfig
arm                         hackkit_defconfig
mips                          malta_defconfig
mips                        qi_lb60_defconfig
arm                          sp7021_defconfig
powerpc                     ppa8548_defconfig
x86_64                          rhel-8.3-rust
arm                           sama7_defconfig
riscv                          rv32_defconfig
powerpc                    mvme5100_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
