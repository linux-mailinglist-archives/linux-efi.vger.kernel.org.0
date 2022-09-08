Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCB5B1544
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 09:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiIHHCM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 03:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiIHHCD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 03:02:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4105A9C2D3
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662620518; x=1694156518;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0b/bowG5sJz5hySUzC6MlhjQi2Opi3R7c+mtdnyTyC0=;
  b=VK72Dzcs5Bxy/Q6PT1jGCgLPA48N8EFSCIXdjjUEnr5bGsOlbTX6n8sY
   HA4G8nH+obUp+ryoghAeYwpFV6F6qFRMW3wGGp22YWqmEtTSEPGPFNTSw
   XHxGRV8fAvTj5Zuof0vaEATrCC/aM/xtR0yyRPC81EYKPEE3MFOiE+z6n
   NR1FKmDhFfORnFo7s5kUUWOsMyRUS8ekIqaZePq+IiT3Rtv7wvMz/DAnZ
   uAZlE3MUR2iklYbSe3+ICTcynczJbbHrBd3N/bE/uJhOHvyytjg35B2R/
   NvT0IRiiQcUL1LGNRvu9UQ6gZW+UeDLyCg5Hmn9fHFWfU6sa/tUjwCQuX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297089066"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="297089066"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 00:01:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="614781494"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Sep 2022 00:01:55 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWBXu-0007TJ-1u;
        Thu, 08 Sep 2022 07:01:54 +0000
Date:   Thu, 08 Sep 2022 15:01:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 9cb636b5f6a8cc6d1b50809ec8f8d33ae0c84c95
Message-ID: <6319935c.0yisYcIl3oG/+R10%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 9cb636b5f6a8cc6d1b50809ec8f8d33ae0c84c95  efi: capsule-loader: Fix use-after-free in efi_capsule_write

elapsed time: 856m

configs tested: 124
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20220907
i386                          randconfig-a001
i386                          randconfig-a003
i386                                defconfig
sh                               allmodconfig
x86_64                        randconfig-a013
x86_64                              defconfig
x86_64                        randconfig-a011
i386                          randconfig-a005
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
arm                                 defconfig
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                                defconfig
sparc                            alldefconfig
i386                             allyesconfig
i386                          randconfig-a014
arm                              allyesconfig
i386                          randconfig-a012
arm64                            allyesconfig
i386                          randconfig-a016
sparc                               defconfig
um                                  defconfig
sh                            titan_defconfig
arm                            mps2_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
ia64                          tiger_defconfig
arc                              alldefconfig
i386                             alldefconfig
powerpc                     ep8248e_defconfig
m68k                          hp300_defconfig
m68k                        m5272c3_defconfig
arm                          exynos_defconfig
sparc                             allnoconfig
arm                        cerfcube_defconfig
powerpc                      arches_defconfig
openrisc                 simple_smp_defconfig
powerpc                     asp8347_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                          r7785rp_defconfig
arm                          iop32x_defconfig
powerpc                     mpc83xx_defconfig
xtensa                generic_kc705_defconfig
sh                     sh7710voipgw_defconfig
sh                             sh03_defconfig
sh                           se7750_defconfig
s390                             allmodconfig
xtensa                       common_defconfig
arm                        clps711x_defconfig
arc                           tb10x_defconfig
powerpc                       eiger_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          r7780mp_defconfig
arm                            qcom_defconfig
arm                          pxa3xx_defconfig
arm                         s3c6400_defconfig
powerpc                     stx_gp3_defconfig
arm64                            alldefconfig
sh                           se7722_defconfig
riscv                randconfig-r042-20220908
arc                  randconfig-r043-20220908
s390                 randconfig-r044-20220908
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                         wii_defconfig
xtensa                  cadence_csp_defconfig
m68k                       m5275evb_defconfig
sh                         ap325rxa_defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220907
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
riscv                randconfig-r042-20220907
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
powerpc                 mpc8315_rdb_defconfig
mips                           ip22_defconfig
powerpc                     tqm8540_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-k001
powerpc                     akebono_defconfig
mips                      malta_kvm_defconfig
arm                    vt8500_v6_v7_defconfig
arm                      pxa255-idp_defconfig
s390                             alldefconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
