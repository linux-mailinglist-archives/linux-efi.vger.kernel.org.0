Return-Path: <linux-efi+bounces-2607-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED5A09EDF
	for <lists+linux-efi@lfdr.de>; Sat, 11 Jan 2025 00:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C711889B69
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4762139AC;
	Fri, 10 Jan 2025 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klXMnQID"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF3821D5A6
	for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2025 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736553175; cv=none; b=K0H7Xf0BoosfpyLy0UQEIEOaEU79eggkj8wKxyWM83eoRSz3XZQicWpAApH3NEeO04th14tBy2DJeW5v6l06Pb7/EipEBufvvxrurLm/UtP+5/STn6JpaCUSwhJC+aqsx+nPz21DVXggXZL5ZuVTkHmdanT7fr1kzY5hMsGFe0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736553175; c=relaxed/simple;
	bh=09u1qNMkJ4Zd1ZyLEptI8VXkqJRNf2F+CJ0hMTMvwSo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KSZtdiyJFUZxbvqKMD8CnIkkmd+pGyMEIYgmJ3Tho2ykFJz+o8zIByEEYZ7Z00mH8P067NPvPv7Oq2OyAr3fIUoYwjprY2M36xlglzjCcI1ryxByqJX6lkeuB3QY1868q8rK3fcW62bVxmeBAv6Hy9mIdzOxsFL1CgGJ/TKBk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klXMnQID; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736553174; x=1768089174;
  h=date:from:to:cc:subject:message-id;
  bh=09u1qNMkJ4Zd1ZyLEptI8VXkqJRNf2F+CJ0hMTMvwSo=;
  b=klXMnQIDq6UvSd6g87A03enBSWhlWWo5bp/UimUccbyqtH4ARQOqoWuJ
   nzLsJrpTk3ekY+/kYjuo0tSwT97uRZd/+Mp4Jhd0raYw6whjVvPdpKEi4
   xIVF9G2dJbsG65CA2ZdAZxaZw27gDPdAPl5NrHGzp29M9kC5yE5ghqjVU
   rCCuLtH6wj0dDOnZBJu9EdSqUOPno3XJPNJHg8HEF3Cd/YE9h6VGNAgaS
   JDdWQZOGxxDtLiifCbuzNGeLagrEXhXGQY+Ecb4HOHZxWTs3yym59C76T
   hH9yfFcWvPpZecro3BY9pmP/UihBRVgPmR3WZwYDci7N8nsGYp3wGsMVW
   w==;
X-CSE-ConnectionGUID: 8g/iruKyR02DwR3Ze7KXMw==
X-CSE-MsgGUID: mXgpHG48QOKjIDeaSZOn0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36547452"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="36547452"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 15:52:53 -0800
X-CSE-ConnectionGUID: 2kwp0m1DQqGqi9OJTRrz4w==
X-CSE-MsgGUID: Ya2yDUlmTtORZuw+gzEMSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="104050571"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jan 2025 15:52:51 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWOo5-000Jue-1D;
	Fri, 10 Jan 2025 23:52:49 +0000
Date: Sat, 11 Jan 2025 07:52:13 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 ac38e9c70c5932b3cec02eb203d0e3b92dd67e7c
Message-ID: <202501110759.Y6n1fWD3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: ac38e9c70c5932b3cec02eb203d0e3b92dd67e7c  Merge branch 'efivarfs' into next

elapsed time: 1463m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250110    gcc-13.2.0
arc                   randconfig-002-20250110    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-20
arm                      integrator_defconfig    clang-15
arm                            qcom_defconfig    clang-17
arm                   randconfig-001-20250110    clang-20
arm                   randconfig-002-20250110    gcc-14.2.0
arm                   randconfig-003-20250110    clang-19
arm                   randconfig-004-20250110    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250110    gcc-14.2.0
arm64                 randconfig-002-20250110    gcc-14.2.0
arm64                 randconfig-003-20250110    clang-17
arm64                 randconfig-004-20250110    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250110    gcc-14.2.0
csky                  randconfig-002-20250110    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250110    clang-20
hexagon               randconfig-002-20250110    clang-20
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250110    clang-19
i386        buildonly-randconfig-002-20250110    clang-19
i386        buildonly-randconfig-003-20250110    clang-19
i386        buildonly-randconfig-004-20250110    gcc-12
i386        buildonly-randconfig-005-20250110    gcc-12
i386        buildonly-randconfig-006-20250110    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250110    gcc-14.2.0
loongarch             randconfig-002-20250110    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250110    gcc-14.2.0
nios2                 randconfig-002-20250110    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250110    gcc-14.2.0
parisc                randconfig-002-20250110    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      bamboo_defconfig    clang-20
powerpc                    gamecube_defconfig    clang-16
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250110    clang-20
powerpc               randconfig-002-20250110    clang-20
powerpc               randconfig-003-20250110    clang-20
powerpc                     skiroot_defconfig    clang-20
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250110    clang-17
powerpc64             randconfig-002-20250110    clang-19
powerpc64             randconfig-003-20250110    clang-17
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250110    clang-17
riscv                 randconfig-002-20250110    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250110    gcc-14.2.0
s390                  randconfig-002-20250110    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250110    gcc-14.2.0
sh                    randconfig-002-20250110    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250110    gcc-14.2.0
sparc                 randconfig-002-20250110    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250110    gcc-14.2.0
sparc64               randconfig-002-20250110    gcc-14.2.0
um                                allnoconfig    clang-18
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250110    clang-20
um                    randconfig-002-20250110    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250110    gcc-12
x86_64      buildonly-randconfig-002-20250110    clang-19
x86_64      buildonly-randconfig-003-20250110    clang-19
x86_64      buildonly-randconfig-004-20250110    gcc-12
x86_64      buildonly-randconfig-005-20250110    clang-19
x86_64      buildonly-randconfig-006-20250110    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250110    gcc-14.2.0
xtensa                randconfig-002-20250110    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

