Return-Path: <linux-efi+bounces-1464-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE3934C65
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958A4282ADC
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 11:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9771680638;
	Thu, 18 Jul 2024 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWFHGAhh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7274429
	for <linux-efi@vger.kernel.org>; Thu, 18 Jul 2024 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301999; cv=none; b=cDZa9dwkIN4fjUh6sid0isndVx7ZDv6b+nQzD5sHIre+/DGeXyRjDBFc1IdevOGiI3cspgUII6Nd2WSbvBTYx4YAO9BW6vFJ1FnnLvLVpvtSCTFgSiCgAcLkHv9/Be0DfCRTwVM98MQ952javDTdjMksz1YnWbUFWW23PSCdsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301999; c=relaxed/simple;
	bh=nNw/XwlT37n2fyz7IqB/dFrU0HXZMRPiCvzS8HImf70=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aZSDvaJedtcS/ZQN+ZucoLHMgfclv28Qotn4PYRkKLTkRVmKaoks5OpkC15j6PRJYtbij8JLqz4EqmAv5vYsx9vwbYTDOLnHUfkKF7s+/4fOhxdJrSMC8afFesnTTeVT1E6Phpj9QVxpEmYt7mW7Or/etifin8Vh4iJoIjtFWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWFHGAhh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721301998; x=1752837998;
  h=date:from:to:cc:subject:message-id;
  bh=nNw/XwlT37n2fyz7IqB/dFrU0HXZMRPiCvzS8HImf70=;
  b=TWFHGAhhWUNcz/dRtIPEtYBeQUi83FF/1hRQNtDjQGR+Fn4JaiyvaHsG
   wLtRCown0YYP8NlFhcSSMUbtRwFj5oKAOyu2jP+dnRVPbR5mtjIURT0sl
   l+dBUWOpwrgRWeE1N+qQOBobio4qsLKg7zh/ncaqU4qZPlWbP6GpIr5Zk
   tz/xTWxgDcnwOAl6YZ6hzHPRGACO8cxTtgYF2UkyBNPjHlk1Q5iAZT4zk
   w3AeXhNaWM2Pr+lLVl5XSWDLklufy8JbPIyNQ5CeTXvRFKGemA2UdGfqT
   m0qkJvA3uJ9QKo17mWnvUFwgifgIjVWuP+gxrKSdMl+sUL1+ZiyqistUz
   g==;
X-CSE-ConnectionGUID: z68e7OlrSc2Nta/pSCVF2Q==
X-CSE-MsgGUID: 6YhuzIjBTeW4cZj0dRQu+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="30244721"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="30244721"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 04:26:37 -0700
X-CSE-ConnectionGUID: qqmRO9xHQqKZ435N+Usz1w==
X-CSE-MsgGUID: RaO2PojyRAmQNkMApnUDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="55882826"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Jul 2024 04:26:36 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUPHN-000hBg-2B;
	Thu, 18 Jul 2024 11:26:33 +0000
Date: Thu, 18 Jul 2024 19:25:37 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 ee8b8f5d83eb2c9caaebcf633310905ee76856e9
Message-ID: <202407181934.aDaTL6pa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: ee8b8f5d83eb2c9caaebcf633310905ee76856e9  efi/libstub: Zero initialize heap allocated struct screen_info

elapsed time: 820m

configs tested: 172
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.3.0
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.3.0
arm                          moxart_defconfig   gcc-14.1.0
arm                         nhk8815_defconfig   gcc-14.1.0
arm                           spitz_defconfig   gcc-13.3.0
arm                       versatile_defconfig   gcc-13.3.0
arm                        vexpress_defconfig   gcc-14.1.0
arm                         vf610m4_defconfig   gcc-13.3.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240718   gcc-11
i386         buildonly-randconfig-002-20240718   gcc-11
i386         buildonly-randconfig-002-20240718   gcc-7
i386         buildonly-randconfig-003-20240718   gcc-11
i386         buildonly-randconfig-003-20240718   gcc-13
i386         buildonly-randconfig-004-20240718   clang-18
i386         buildonly-randconfig-004-20240718   gcc-11
i386         buildonly-randconfig-005-20240718   gcc-11
i386         buildonly-randconfig-005-20240718   gcc-9
i386         buildonly-randconfig-006-20240718   gcc-11
i386         buildonly-randconfig-006-20240718   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240718   gcc-11
i386                  randconfig-001-20240718   gcc-13
i386                  randconfig-002-20240718   gcc-11
i386                  randconfig-002-20240718   gcc-13
i386                  randconfig-003-20240718   clang-18
i386                  randconfig-003-20240718   gcc-11
i386                  randconfig-004-20240718   clang-18
i386                  randconfig-004-20240718   gcc-11
i386                  randconfig-005-20240718   clang-18
i386                  randconfig-005-20240718   gcc-11
i386                  randconfig-006-20240718   clang-18
i386                  randconfig-006-20240718   gcc-11
i386                  randconfig-011-20240718   gcc-11
i386                  randconfig-011-20240718   gcc-13
i386                  randconfig-012-20240718   gcc-11
i386                  randconfig-012-20240718   gcc-13
i386                  randconfig-013-20240718   gcc-10
i386                  randconfig-013-20240718   gcc-11
i386                  randconfig-014-20240718   clang-18
i386                  randconfig-014-20240718   gcc-11
i386                  randconfig-015-20240718   clang-18
i386                  randconfig-015-20240718   gcc-11
i386                  randconfig-016-20240718   gcc-11
i386                  randconfig-016-20240718   gcc-13
loongarch                        alldefconfig   gcc-14.1.0
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-13.3.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme16x_defconfig   gcc-14.1.0
m68k                           virt_defconfig   gcc-13.3.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         cobalt_defconfig   gcc-13.3.0
mips                         db1xxx_defconfig   gcc-14.1.0
mips                  decstation_64_defconfig   gcc-14.1.0
mips                           ip27_defconfig   gcc-13.3.0
mips                        maltaup_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   gcc-13.3.0
powerpc                   microwatt_defconfig   gcc-13.3.0
powerpc                 mpc834x_itx_defconfig   gcc-13.3.0
powerpc                  mpc866_ads_defconfig   gcc-14.1.0
powerpc                      ppc64e_defconfig   gcc-14.1.0
powerpc                      ppc6xx_defconfig   gcc-13.3.0
powerpc                     tqm8548_defconfig   gcc-13.3.0
powerpc                 xes_mpc85xx_defconfig   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                         apsh4a3a_defconfig   gcc-13.3.0
sh                        apsh4ad0a_defconfig   gcc-13.3.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-14.1.0
sh                        sh7763rdp_defconfig   gcc-13.3.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240718   gcc-11
x86_64       buildonly-randconfig-002-20240718   gcc-11
x86_64       buildonly-randconfig-003-20240718   gcc-11
x86_64       buildonly-randconfig-004-20240718   gcc-11
x86_64       buildonly-randconfig-005-20240718   gcc-11
x86_64       buildonly-randconfig-006-20240718   gcc-11
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240718   gcc-11
x86_64                randconfig-002-20240718   gcc-11
x86_64                randconfig-003-20240718   gcc-11
x86_64                randconfig-004-20240718   gcc-11
x86_64                randconfig-005-20240718   gcc-11
x86_64                randconfig-006-20240718   gcc-11
x86_64                randconfig-011-20240718   gcc-11
x86_64                randconfig-012-20240718   gcc-11
x86_64                randconfig-013-20240718   gcc-11
x86_64                randconfig-014-20240718   gcc-11
x86_64                randconfig-015-20240718   gcc-11
x86_64                randconfig-016-20240718   gcc-11
x86_64                randconfig-071-20240718   gcc-11
x86_64                randconfig-072-20240718   gcc-11
x86_64                randconfig-073-20240718   gcc-11
x86_64                randconfig-074-20240718   gcc-11
x86_64                randconfig-075-20240718   gcc-11
x86_64                randconfig-076-20240718   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

