Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1037B6896F1
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 11:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjBCKgE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 05:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjBCKgA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 05:36:00 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DCBA275
        for <linux-efi@vger.kernel.org>; Fri,  3 Feb 2023 02:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675420557; x=1706956557;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=P/C8iJxDdDaR1CFPqaS73N8Ais0pDbly/Qqx6C/VKdc=;
  b=AtHI6TY9Z9AMknXkjG3miGJ1qvpb+MPZid9qdI8DJY4RJ5CZlN3tJOq5
   lUBzWXoSXoVBSDwST9Z5eo5GDGLLnq72b7iFQarru+468nOKHsxlokMw5
   mNmT9obi9AFhuSw4ZExHU/iDYYDCDsjFZtKp+Dz5WDQ5q+Ew0rGyvsObL
   LguwsbdrmCImnUV0LQW/Qk9o9tiZ5YGEgYUi93rSaXp+ZhVR6JLJyZE5j
   AfUABOcoBT7CvlwFVO9a+0yD0LcT1Mql/leyovhkL+5V1Vow0XscyI78L
   1P2GX2yX5K90QmLFmDYtVtfZY8gDgMcf/i6ia8zBEXIQdY7n7bV5NvCv6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="391112078"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="391112078"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 02:35:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="734299550"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="734299550"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2023 02:35:55 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNtQA-0000Or-2P;
        Fri, 03 Feb 2023 10:35:54 +0000
Date:   Fri, 03 Feb 2023 18:35:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 636ab417a7aec4ee993916e688eb5c5977570836
Message-ID: <63dce384.tEoa14HJk+pMGYFN%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 636ab417a7aec4ee993916e688eb5c5977570836  efi: Accept version 2 of memory attributes table

elapsed time: 976m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a006
m68k                             allmodconfig
arc                              allyesconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
ia64                             allmodconfig
i386                          randconfig-a001
mips                             allyesconfig
i386                          randconfig-a003
powerpc                          allmodconfig
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                                defconfig
m68k                             alldefconfig
arm                          gemini_defconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                     stx_gp3_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      mgcoge_defconfig
sh                            migor_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust
powerpc                 mpc832x_mds_defconfig
mips                     cu1000-neo_defconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
