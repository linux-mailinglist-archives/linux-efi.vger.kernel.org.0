Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629E74C7D9B
	for <lists+linux-efi@lfdr.de>; Mon, 28 Feb 2022 23:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiB1WlP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Feb 2022 17:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiB1WlN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Feb 2022 17:41:13 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866F512D0BB
        for <linux-efi@vger.kernel.org>; Mon, 28 Feb 2022 14:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646088032; x=1677624032;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rlSWPv+CLsHkOFLeZ+LyXT03go+vxZQETbmQ3sp32oI=;
  b=WQlZsF9+81BxC8wL+8GeSKUTAeeFDn8C1rz/qsRXv1JJFK6b/dABS1Es
   Le4Y2DEPXDGbkodSLsweZ3X7fNWB1j3bdG2FcDxRlgmyn0qD/Cj1YSAtz
   FLt550gIImQszTT2a7AfrbBctLKrSDhk3kc9P/wFeRuo2589WmzCgEqFo
   HmzftIl1TcDphmVUfEuhWn8axEhuOUSKJU0YBM+WSRiKBvnwJyqJ6THJu
   7HYQaDourXdJnRux1jnME3w/P3nzC7C4X1t7sSpoe0e1nfRUo2BCD4jtH
   Owywawu/MW75Bu7RTxUTKOYPuqUK7xLK1057fRBKERnlaxyxGbp6vms6D
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316219637"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="316219637"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 14:40:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="608609246"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Feb 2022 14:40:30 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOogv-0007qS-Qu; Mon, 28 Feb 2022 22:40:29 +0000
Date:   Tue, 01 Mar 2022 06:39:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 258dd902022cb10c83671176688074879517fd21
Message-ID: <621d4f38.NINVoYuUymEAY+ru%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 258dd902022cb10c83671176688074879517fd21  efivars: Respect "block" flag in efivar_entry_set_safe()

elapsed time: 721m

configs tested: 216
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220228
arm                            lart_defconfig
arm                         assabet_defconfig
arm                          simpad_defconfig
sh                           se7780_defconfig
powerpc                    sam440ep_defconfig
sparc                            allyesconfig
mips                           xway_defconfig
sh                        sh7785lcr_defconfig
mips                         db1xxx_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
m68k                            mac_defconfig
sh                     sh7710voipgw_defconfig
arm                        keystone_defconfig
sh                         ecovec24_defconfig
powerpc                      bamboo_defconfig
parisc                generic-32bit_defconfig
powerpc                      pcm030_defconfig
m68k                       m5208evb_defconfig
openrisc                    or1ksim_defconfig
arm                        trizeps4_defconfig
sh                               alldefconfig
mips                         tb0226_defconfig
powerpc                  iss476-smp_defconfig
arc                         haps_hs_defconfig
powerpc                      cm5200_defconfig
arc                        nsim_700_defconfig
xtensa                           alldefconfig
powerpc                    amigaone_defconfig
powerpc                     sequoia_defconfig
alpha                               defconfig
arm                         lpc18xx_defconfig
sh                           sh2007_defconfig
arc                     nsimosci_hs_defconfig
sparc                       sparc32_defconfig
sh                              ul2_defconfig
sh                          r7780mp_defconfig
sh                           se7724_defconfig
sh                          sdk7780_defconfig
arm                            pleb_defconfig
microblaze                      mmu_defconfig
arm                        clps711x_defconfig
sh                 kfr2r09-romimage_defconfig
um                                  defconfig
powerpc                       maple_defconfig
powerpc                   currituck_defconfig
m68k                             allyesconfig
arm                          gemini_defconfig
sh                          rsk7269_defconfig
powerpc                      makalu_defconfig
m68k                        mvme16x_defconfig
sh                           se7619_defconfig
powerpc                    adder875_defconfig
mips                      fuloong2e_defconfig
sh                         microdev_defconfig
mips                           ci20_defconfig
sh                          lboxre2_defconfig
nios2                               defconfig
sh                        sh7757lcr_defconfig
xtensa                          iss_defconfig
arm                      integrator_defconfig
m68k                                defconfig
powerpc                   motionpro_defconfig
um                           x86_64_defconfig
sh                          polaris_defconfig
sh                             sh03_defconfig
xtensa                    smp_lx200_defconfig
sh                      rts7751r2d1_defconfig
mips                            ar7_defconfig
sh                             espt_defconfig
xtensa                       common_defconfig
arm                        oxnas_v6_defconfig
sh                           se7206_defconfig
arc                        vdk_hs38_defconfig
nds32                               defconfig
arm                             ezx_defconfig
openrisc                         alldefconfig
sh                           se7751_defconfig
powerpc                 linkstation_defconfig
arm                          badge4_defconfig
s390                       zfcpdump_defconfig
powerpc                      mgcoge_defconfig
arm                        multi_v7_defconfig
powerpc                         ps3_defconfig
arm                        realview_defconfig
arm                          iop32x_defconfig
arc                          axs101_defconfig
powerpc                      chrp32_defconfig
m68k                         amcore_defconfig
powerpc                     taishan_defconfig
sh                          urquell_defconfig
powerpc                     rainier_defconfig
arm                          pxa910_defconfig
ia64                             allmodconfig
m68k                         apollo_defconfig
arm                        spear6xx_defconfig
m68k                          amiga_defconfig
arm                           viper_defconfig
arm                  randconfig-c002-20220228
arm                  randconfig-c002-20220227
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a011-20220228
x86_64               randconfig-a015-20220228
x86_64               randconfig-a014-20220228
x86_64               randconfig-a013-20220228
x86_64               randconfig-a016-20220228
x86_64               randconfig-a012-20220228
i386                 randconfig-a016-20220228
i386                 randconfig-a012-20220228
i386                 randconfig-a015-20220228
i386                 randconfig-a011-20220228
i386                 randconfig-a013-20220228
i386                 randconfig-a014-20220228
s390                 randconfig-r044-20220228
arc                  randconfig-r043-20220228
arc                  randconfig-r043-20220227
riscv                randconfig-r042-20220228
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220227
x86_64                        randconfig-c007
arm                  randconfig-c002-20220227
mips                 randconfig-c004-20220227
s390                 randconfig-c005-20220227
i386                          randconfig-c001
riscv                randconfig-c006-20220227
arm                          imote2_defconfig
hexagon                          alldefconfig
arm                          collie_defconfig
mips                          rm200_defconfig
mips                   sb1250_swarm_defconfig
mips                      bmips_stb_defconfig
arm                        magician_defconfig
powerpc                       ebony_defconfig
powerpc                      ppc44x_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8560_defconfig
riscv                    nommu_virt_defconfig
powerpc                     ksi8560_defconfig
powerpc                        icon_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      pmac32_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     mpc5200_defconfig
arm                           sama7_defconfig
x86_64               randconfig-a003-20220228
x86_64               randconfig-a005-20220228
x86_64               randconfig-a002-20220228
x86_64               randconfig-a006-20220228
x86_64               randconfig-a001-20220228
x86_64               randconfig-a004-20220228
i386                 randconfig-a002-20220228
i386                 randconfig-a001-20220228
i386                 randconfig-a005-20220228
i386                 randconfig-a003-20220228
i386                 randconfig-a006-20220228
i386                 randconfig-a004-20220228
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220227
hexagon              randconfig-r041-20220227
riscv                randconfig-r042-20220227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
