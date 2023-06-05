Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1497223B9
	for <lists+linux-efi@lfdr.de>; Mon,  5 Jun 2023 12:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjFEKoE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Jun 2023 06:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFEKoD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Jun 2023 06:44:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57396DB
        for <linux-efi@vger.kernel.org>; Mon,  5 Jun 2023 03:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685961842; x=1717497842;
  h=date:from:to:cc:subject:message-id;
  bh=SQj5k4ZA94W2/2FPdhEbqgo+pdfXizjcsj9o8Ok3zSA=;
  b=SagP8gd7lDEPSdR9EAfv6EDtpi0U5Bz/Bc5TV7zrSr32UJKyv6mWg35Y
   cDSwJwtnt/qnjsBdle14CsfMocy1Tkz9TWULbWQq9hP2YSTRXHj31PqFp
   oaE0LlglQCeierT4GOoMtlwZ6TaouBY0c7tNvQ5ZmIAKwVvTtr5BBrNL9
   +NPn87ZoEcZ+pUk1+SrogaWGT5kvHYGAiIh5gbaSA9diL7KOvMiCg1qlw
   AfHuRa/num0wd/zl5cnw1wCpIQeBYvKesOS9sqU60D43FCN2k4f/4VojH
   DpJwixVPODGgu6TABfRb+F3huoNBnp7mvLdJtaD7IdM6syfgBTvsiQ0cl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="358784496"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="358784496"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 03:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="955292592"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="955292592"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2023 03:44:00 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q67gt-00047G-1y;
        Mon, 05 Jun 2023 10:43:59 +0000
Date:   Mon, 05 Jun 2023 18:43:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 13c21ab8038d00b4bcc69a46c5f7f1c95e5decce
Message-ID: <20230605104337.aExbN%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 13c21ab8038d00b4bcc69a46c5f7f1c95e5decce  efi/esrt: Allow ESRT access without CAP_SYS_ADMIN

elapsed time: 721m

configs tested: 147
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r021-20230605   gcc  
arc                  randconfig-r043-20230605   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                          pxa168_defconfig   clang
arm                  randconfig-r026-20230605   clang
arm                  randconfig-r046-20230605   clang
arm                         s5pv210_defconfig   clang
arm                           sama7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230605   clang
csky         buildonly-randconfig-r005-20230605   gcc  
csky                                defconfig   gcc  
hexagon                          alldefconfig   clang
hexagon      buildonly-randconfig-r003-20230605   clang
hexagon              randconfig-r002-20230605   clang
hexagon              randconfig-r025-20230605   clang
hexagon              randconfig-r041-20230605   clang
hexagon              randconfig-r045-20230605   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230605   clang
i386                 randconfig-i002-20230605   clang
i386                 randconfig-i003-20230605   clang
i386                 randconfig-i004-20230605   clang
i386                 randconfig-i005-20230605   clang
i386                 randconfig-i006-20230605   clang
i386                 randconfig-i011-20230605   gcc  
i386                 randconfig-i012-20230605   gcc  
i386                 randconfig-i013-20230605   gcc  
i386                 randconfig-i014-20230605   gcc  
i386                 randconfig-i015-20230605   gcc  
i386                 randconfig-i016-20230605   gcc  
i386                 randconfig-i051-20230605   clang
i386                 randconfig-i052-20230605   clang
i386                 randconfig-i053-20230605   clang
i386                 randconfig-i054-20230605   clang
i386                 randconfig-i055-20230605   clang
i386                 randconfig-i056-20230605   clang
i386                 randconfig-i061-20230605   clang
i386                 randconfig-i062-20230605   clang
i386                 randconfig-i063-20230605   clang
i386                 randconfig-i064-20230605   clang
i386                 randconfig-i065-20230605   clang
i386                 randconfig-i066-20230605   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r032-20230605   gcc  
loongarch            randconfig-r033-20230605   gcc  
loongarch            randconfig-r034-20230605   gcc  
m68k                             allmodconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r001-20230605   gcc  
microblaze           randconfig-r005-20230605   gcc  
microblaze           randconfig-r014-20230605   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips         buildonly-randconfig-r004-20230605   gcc  
mips         buildonly-randconfig-r006-20230605   gcc  
mips                        omega2p_defconfig   clang
mips                 randconfig-r035-20230605   gcc  
nios2                         10m50_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230605   gcc  
openrisc             randconfig-r031-20230605   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc              randconfig-r015-20230605   gcc  
powerpc              randconfig-r022-20230605   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230605   gcc  
riscv                randconfig-r042-20230605   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230605   clang
s390                 randconfig-r004-20230605   clang
s390                 randconfig-r044-20230605   gcc  
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                   randconfig-r024-20230605   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230605   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r016-20230605   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230605   clang
x86_64               randconfig-a002-20230605   clang
x86_64               randconfig-a003-20230605   clang
x86_64               randconfig-a004-20230605   clang
x86_64               randconfig-a005-20230605   clang
x86_64               randconfig-a006-20230605   clang
x86_64               randconfig-a011-20230605   gcc  
x86_64               randconfig-a012-20230605   gcc  
x86_64               randconfig-a013-20230605   gcc  
x86_64               randconfig-a014-20230605   gcc  
x86_64               randconfig-a015-20230605   gcc  
x86_64               randconfig-a016-20230605   gcc  
x86_64               randconfig-k001-20230605   gcc  
x86_64               randconfig-r036-20230605   clang
x86_64               randconfig-x051-20230605   gcc  
x86_64               randconfig-x052-20230605   gcc  
x86_64               randconfig-x053-20230605   gcc  
x86_64               randconfig-x054-20230605   gcc  
x86_64               randconfig-x055-20230605   gcc  
x86_64               randconfig-x056-20230605   gcc  
x86_64               randconfig-x061-20230605   gcc  
x86_64               randconfig-x062-20230605   gcc  
x86_64               randconfig-x063-20230605   gcc  
x86_64               randconfig-x064-20230605   gcc  
x86_64               randconfig-x065-20230605   gcc  
x86_64               randconfig-x066-20230605   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r012-20230605   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
