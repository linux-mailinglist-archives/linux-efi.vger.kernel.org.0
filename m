Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E495E6D60
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 22:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiIVUuo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 16:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIVUun (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 16:50:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D4B5E7D
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663879842; x=1695415842;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2+fxonca4A2jTs4NXZDcsDQuJOYr5jEn4QMIHMZqfO8=;
  b=JKM1TxCd7giwpemKGv7kZIvH6FGJHEJ+F+QdOEQXestKnQfURTcs9kXV
   xmspPyPD00B6QnC16HmJWBmlN2L43QxsExLcUsnhd0rAPCmBieSzw8Wa/
   EErRZaEKlOna/gvzWAO/CKWEvupye7VQm7FRpMVMNzAc+h9/DOkGSK/HF
   qjump0q8jRFirQzT8aGyAaa2r5p9KPx5Ux5MN/Dc3LOkY5k118Ox4RitG
   JSoWhBRzDx1lfSmoLkY9FUKCjSrKL+vXkfLwnMqBoAlXlPPOGeENQvsmv
   7vCQOqf8foU8cCySjP2O7QTxtNjCkZLwoBjmYTtiK8meCmrGujAew9n7D
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="326753058"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="326753058"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="948767075"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Sep 2022 13:50:41 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obT9c-0004xA-2S;
        Thu, 22 Sep 2022 20:50:40 +0000
Date:   Fri, 23 Sep 2022 04:50:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 5f56a74cc0a6d9b9f8ba89cea29cd7c4774cb2b1
Message-ID: <632cca9b.UKb+WGHl+Ppei7kS%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 5f56a74cc0a6d9b9f8ba89cea29cd7c4774cb2b1  efi: libstub: check Shim mode using MokSBStateRT

elapsed time: 721m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
x86_64                              defconfig
s390                 randconfig-r044-20220921
arm                                 defconfig
i386                          randconfig-a001
i386                                defconfig
i386                          randconfig-a003
x86_64                               rhel-8.3
i386                          randconfig-a005
powerpc                           allnoconfig
x86_64                           allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a002
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                          randconfig-a012
x86_64                        randconfig-a004
x86_64                        randconfig-a013
i386                          randconfig-a016
m68k                             allmodconfig
x86_64                        randconfig-a011
arc                              allyesconfig
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                 mpc837x_mds_defconfig
xtensa                          iss_defconfig
nios2                            alldefconfig
m68k                            mac_defconfig
sh                        edosk7705_defconfig
xtensa                    smp_lx200_defconfig
csky                             alldefconfig
sh                           se7705_defconfig
powerpc                      tqm8xx_defconfig

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a012
i386                          randconfig-a015
hexagon              randconfig-r041-20220922
hexagon              randconfig-r045-20220922
riscv                randconfig-r042-20220922
s390                 randconfig-r044-20220922
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
