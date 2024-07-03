Return-Path: <linux-efi+bounces-1367-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FED925379
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jul 2024 08:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878CB1F298C7
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jul 2024 06:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8BBBA3F;
	Wed,  3 Jul 2024 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5m+6xeC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB2F1DA316
	for <linux-efi@vger.kernel.org>; Wed,  3 Jul 2024 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986556; cv=none; b=VQ6RRZuqRDXy2UwBjfzk4Ujg/kGNvmRDBDZOQQiCSLvC+QmlmbAkbyU3CUBDOmoy/gGH84LsXKIpq75Eo5x9gmsVsU3oibx0Rh7aE8VY7gSt1FN/4Z+e3Wng6sdhv/B9/qbsWgcqEcUNK2Il5RPW75KTwFn+9OCM4JHu6UYCZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986556; c=relaxed/simple;
	bh=W0h7zqn+fBFSTxkxeZWa+pI4nOyj0T4frxV2MAqUFew=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GQj+kYnbKxM5Gs/Nqe/DNqmQ9kTIGWu9mm4Tj/wjVLRNUfQXBX/gI41XsCHvhm3CZIpmiXAPhmxqLQCXNdjaXBxIab5lsk5I0If8JrdUlHvukk5lrpN0T4Ac7u+7U77+Erl+Vw0ZBpVzGb5u5n6B79SahncAlGU9tQlnclrkr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5m+6xeC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719986554; x=1751522554;
  h=date:from:to:cc:subject:message-id;
  bh=W0h7zqn+fBFSTxkxeZWa+pI4nOyj0T4frxV2MAqUFew=;
  b=Z5m+6xeCZ+LjG3/sQY0/FsXGR8afeoUevGQOBJopKUv3C5wyIQCrom3R
   z5ipPwC+jn2lcGRVVOzZKYZA3B7lkaENAGDk+fav/HTpSNqpYdEXATAdR
   aO52erKz+JUqCeROtM5qxkE0r3qYfzxnx7CSzfDCaaCdq0zk7BUY2zdP8
   slTP8mRPvvpO1q+MaMCwyXleAT3PWbBcpqGoBhYG6+w3b83g5ykYF64h8
   jOl5UL8OUpOzExj5myMN8qI5VXnDZbCjLJJdT95MGctewF/5FNQkPR/Hw
   rDp7RkeeKrnyjsooHaU8p4HfUhk08qSG0RiTA1Vq+DNZQSUSQAqX8I65z
   g==;
X-CSE-ConnectionGUID: EOH6QRvdT5GuzEgFhW6IEg==
X-CSE-MsgGUID: K2DSjmHRS2isHalCwlQQ0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27872006"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27872006"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 23:02:33 -0700
X-CSE-ConnectionGUID: Y7903zPISaiF5RvMr5t6NQ==
X-CSE-MsgGUID: XYX88xWuS0ijG8aKKOfFog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="83693345"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Jul 2024 23:02:33 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOt4Y-000PMO-0d;
	Wed, 03 Jul 2024 06:02:30 +0000
Date: Wed, 03 Jul 2024 14:01:47 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 d68cc8abc357c05ca1567458965f009add8bab69
Message-ID: <202407031446.v1IK7QIM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: d68cc8abc357c05ca1567458965f009add8bab69  x86/efistub: Call Apple set_os protocol on dual GPU Intel Macs

elapsed time: 1802m

configs tested: 108
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240703   gcc-13.2.0
arc                   randconfig-002-20240703   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                          collie_defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                           imxrt_defconfig   gcc-13.2.0
arm                       netwinder_defconfig   gcc-13.2.0
arm                   randconfig-001-20240703   gcc-13.2.0
arm                   randconfig-002-20240703   gcc-13.2.0
arm                   randconfig-003-20240703   gcc-13.2.0
arm                   randconfig-004-20240703   gcc-13.2.0
arm                        spear3xx_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240703   gcc-13.2.0
arm64                 randconfig-002-20240703   gcc-13.2.0
arm64                 randconfig-003-20240703   gcc-13.2.0
arm64                 randconfig-004-20240703   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240703   gcc-13.2.0
csky                  randconfig-002-20240703   gcc-13.2.0
hexagon                           allnoconfig   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240702   gcc-13
i386         buildonly-randconfig-002-20240702   gcc-13
i386         buildonly-randconfig-003-20240702   gcc-13
i386         buildonly-randconfig-004-20240702   gcc-13
i386         buildonly-randconfig-005-20240702   gcc-13
i386         buildonly-randconfig-006-20240702   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240702   gcc-13
i386                  randconfig-002-20240702   gcc-13
i386                  randconfig-003-20240702   gcc-13
i386                  randconfig-004-20240702   gcc-13
i386                  randconfig-005-20240702   gcc-13
i386                  randconfig-006-20240702   gcc-13
i386                  randconfig-011-20240702   gcc-13
i386                  randconfig-012-20240702   gcc-13
i386                  randconfig-013-20240702   gcc-13
i386                  randconfig-014-20240702   gcc-13
i386                  randconfig-015-20240702   gcc-13
i386                  randconfig-016-20240702   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240703   gcc-13.2.0
loongarch             randconfig-002-20240703   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240703   gcc-13.2.0
nios2                 randconfig-002-20240703   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                randconfig-001-20240703   gcc-13.2.0
parisc                randconfig-002-20240703   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                   motionpro_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240703   gcc-13.2.0
powerpc               randconfig-002-20240703   gcc-13.2.0
powerpc               randconfig-003-20240703   gcc-13.2.0
powerpc64             randconfig-001-20240703   gcc-13.2.0
powerpc64             randconfig-002-20240703   gcc-13.2.0
powerpc64             randconfig-003-20240703   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                 randconfig-001-20240703   gcc-13.2.0
riscv                 randconfig-002-20240703   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
s390                  randconfig-001-20240703   gcc-13.2.0
s390                  randconfig-002-20240703   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                    randconfig-001-20240703   gcc-13.2.0
sh                    randconfig-002-20240703   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64               randconfig-001-20240703   gcc-13.2.0
sparc64               randconfig-002-20240703   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                    randconfig-001-20240703   gcc-13.2.0
um                    randconfig-002-20240703   gcc-13.2.0
x86_64                           alldefconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240703   gcc-13.2.0
xtensa                randconfig-002-20240703   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

