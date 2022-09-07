Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE2E5AFA54
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 04:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiIGC6D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 22:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIGC6C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 22:58:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E0A7FF81
        for <linux-efi@vger.kernel.org>; Tue,  6 Sep 2022 19:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662519481; x=1694055481;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1F0tmg4/yRc7Zlswqo1drBRe8xGMtA8SJvrS+e/Avc4=;
  b=eWlmweVTvAbeoM92dZpmHnEymjVFBoIF/csjhC5zScu95O0eJXAUr80V
   QIM2JTt4MT0ly7vssjCUlvdkfWsR/mQYmznOfNwvTPyR9WC79O8tH7ck1
   WJNfbTFTj9dRXD8UiWrTY+9m6UTTqgFpT905Y1Y2GvCHnXEO1/rxA7a8l
   rqflDCTKRC7UH8ihDVrOUOHdiELjW9EZ0qv/9pE8us49ZYTcvF/Ttw0qX
   UVEPB4EIodcSUyKOGV3CA5VD71yOXGlBNEBksRH9aystXFh9iUnSFYsh+
   8mt6lGCO4S2CupQD8AEwKYL4b6DjJ8mq0pjHN7LITWGgCmmpSX8deMFqO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283761449"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="283761449"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 19:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="942714058"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2022 19:57:59 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVlGI-00060L-1i;
        Wed, 07 Sep 2022 02:57:58 +0000
Date:   Wed, 07 Sep 2022 10:57:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 4bf23298820093992beac22cc1532414ae189acd
Message-ID: <63180898.32+QANi9lL1HCOpr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
branch HEAD: 4bf23298820093992beac22cc1532414ae189acd  Merge tag 'efi-loongarch-for-v6.1' into efi/next

elapsed time: 972m

configs tested: 156
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                           se7780_defconfig
mips                           xway_defconfig
powerpc                       holly_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220906
arc                  randconfig-r043-20220906
s390                 randconfig-r044-20220906
sh                               j2_defconfig
arm                       aspeed_g5_defconfig
m68k                          multi_defconfig
sparc64                             defconfig
parisc                generic-32bit_defconfig
arc                         haps_hs_defconfig
arc                        nsim_700_defconfig
powerpc                        warp_defconfig
arm                      footbridge_defconfig
mips                     loongson1b_defconfig
arm                           tegra_defconfig
arm                          gemini_defconfig
sh                         ecovec24_defconfig
xtensa                generic_kc705_defconfig
i386                          randconfig-c001
sh                          polaris_defconfig
sh                   sh7770_generic_defconfig
ia64                                defconfig
powerpc                    klondike_defconfig
ia64                            zx1_defconfig
sh                          r7780mp_defconfig
sparc                       sparc64_defconfig
parisc64                            defconfig
powerpc                 canyonlands_defconfig
arm                           viper_defconfig
powerpc                    adder875_defconfig
sh                        dreamcast_defconfig
sh                          lboxre2_defconfig
powerpc                      bamboo_defconfig
powerpc                      makalu_defconfig
csky                             alldefconfig
m68k                                defconfig
powerpc                     pq2fads_defconfig
xtensa                          iss_defconfig
powerpc                    amigaone_defconfig
arm                        cerfcube_defconfig
sparc                            allyesconfig
sh                           se7705_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
sh                           se7750_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220906
arm                          iop32x_defconfig
mips                           ip32_defconfig
nios2                         10m50_defconfig
arc                          axs103_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
x86_64                                  kexec
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                mpc7448_hpc2_defconfig
alpha                               defconfig
arm                           sama5_defconfig
powerpc                     tqm8548_defconfig
sh                            titan_defconfig
sh                     sh7710voipgw_defconfig
ia64                          tiger_defconfig
sh                         ap325rxa_defconfig
m68k                        mvme16x_defconfig
powerpc                 mpc837x_mds_defconfig
sh                          rsk7264_defconfig
sh                 kfr2r09-romimage_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                         lubbock_defconfig
m68k                       m5475evb_defconfig
sh                        edosk7705_defconfig
s390                             allmodconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                              defconfig
xtensa                  nommu_kc705_defconfig
ia64                             allmodconfig
loongarch                           defconfig
loongarch                         allnoconfig

clang tested configs:
hexagon              randconfig-r041-20220906
hexagon              randconfig-r045-20220906
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                    mvme5100_defconfig
arm                             mxs_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                            mmp2_defconfig
powerpc                      acadia_defconfig
powerpc                     pseries_defconfig
arm                        neponset_defconfig
powerpc                     kilauea_defconfig
powerpc                     akebono_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm5200_defconfig
powerpc                     mpc512x_defconfig
arm                           spitz_defconfig
arm                       spear13xx_defconfig
mips                      malta_kvm_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     davinci_all_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
