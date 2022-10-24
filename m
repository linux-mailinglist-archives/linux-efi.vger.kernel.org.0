Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0D60BD50
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 00:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJXWXl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Oct 2022 18:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiJXWX2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Oct 2022 18:23:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CD9319CF4
        for <linux-efi@vger.kernel.org>; Mon, 24 Oct 2022 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666644216; x=1698180216;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=35PwJ1vmjcvONN5U0jnORqzbY5f46KBTTGQSuFXAckk=;
  b=ahQTynC1/MpRoAT9h0rlNCSc+rHlOZgCyl/s/49p+oqWYtyCdLGoDl3X
   ppb3/2p6iLv54LVAuZw5N1B1evfTCCYVB+D4qjDVVJg4MXIZvvBegXBDP
   ici6weK6ONAszvLS1RyprpBGGO82YvnOe8Dxmic4MDX0oxVfkYf1Y/yIr
   UOkf9bDwNvg9aoQjV0VpSWJzZeBGzHBndQqgPv8H49JEROmEKKjfDE7J0
   UjxkRq2DJJdHX0Gg904SJrXDB/Ky43PJCfgLo1jX3zZ5uoWn0yu13IEvO
   9Kr8l0Es8CjgaI5RP0rekJdBxDFeS7ocmlYf1j8BGOnAJHjJvg0kQZpLQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287236595"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="287236595"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 13:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609327408"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="609327408"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2022 13:40:49 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1on4Fc-0005dZ-3C;
        Mon, 24 Oct 2022 20:40:48 +0000
Date:   Tue, 25 Oct 2022 04:40:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 7d866e38c7e9ece8a096d0d098fa9d92b9d4f97e
Message-ID: <6356f83b.tKFCPH/yR6n+ycKy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 7d866e38c7e9ece8a096d0d098fa9d92b9d4f97e  efi: random: Use 'ACPI reclaim' memory for random seed

elapsed time: 728m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
s390                                defconfig
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
mips                             allyesconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm                                 defconfig
ia64                             allmodconfig
x86_64                        randconfig-a002
arc                  randconfig-r043-20221023
i386                             allyesconfig
x86_64                        randconfig-a006
arm64                            allyesconfig
x86_64                        randconfig-a004
arm                              allyesconfig
x86_64               randconfig-a015-20221024
x86_64               randconfig-a016-20221024
i386                 randconfig-a011-20221024
i386                 randconfig-a014-20221024
i386                 randconfig-a013-20221024
i386                 randconfig-a012-20221024
i386                 randconfig-a015-20221024
i386                 randconfig-a016-20221024
arc                  randconfig-r043-20221024
s390                 randconfig-r044-20221024
riscv                randconfig-r042-20221024
x86_64               randconfig-k001-20221024
i386                             alldefconfig
mips                           jazz_defconfig
sh                           se7206_defconfig
powerpc                   motionpro_defconfig
sh                        sh7757lcr_defconfig
mips                        bcm47xx_defconfig
powerpc                       eiger_defconfig
powerpc                        cell_defconfig
loongarch                        alldefconfig
sh                          polaris_defconfig
powerpc                 mpc8540_ads_defconfig
arc                      axs103_smp_defconfig
x86_64               randconfig-a014-20221024
x86_64               randconfig-a013-20221024
x86_64               randconfig-a012-20221024
x86_64               randconfig-a011-20221024
sparc64                             defconfig
sh                          sdk7786_defconfig
powerpc                      tqm8xx_defconfig
csky                             alldefconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                            defconfig
arm                        mini2440_defconfig
parisc                generic-64bit_defconfig
sh                           se7712_defconfig
powerpc                     tqm8555_defconfig
sh                          lboxre2_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-c001-20221024
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001

clang tested configs:
i386                 randconfig-a001-20221024
i386                 randconfig-a002-20221024
i386                 randconfig-a005-20221024
riscv                randconfig-r042-20221023
i386                 randconfig-a003-20221024
i386                 randconfig-a004-20221024
s390                 randconfig-r044-20221023
i386                 randconfig-a006-20221024
hexagon              randconfig-r041-20221023
hexagon              randconfig-r045-20221023
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64               randconfig-a005-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a006-20221024
x86_64               randconfig-a001-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a003-20221024
powerpc                  mpc885_ads_defconfig
mips                           rs90_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                        mvebu_v5_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        multi_v5_defconfig
arm                       spear13xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
