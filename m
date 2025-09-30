Return-Path: <linux-efi+bounces-4957-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C62BAE0AB
	for <lists+linux-efi@lfdr.de>; Tue, 30 Sep 2025 18:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 611CA4E0F1E
	for <lists+linux-efi@lfdr.de>; Tue, 30 Sep 2025 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F641BF58;
	Tue, 30 Sep 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVs+ahag"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862B1A262D
	for <linux-efi@vger.kernel.org>; Tue, 30 Sep 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249819; cv=none; b=LCLqzyEbdk4LZyOz4KCEg+FmdvU/7Yj7SpTK5GJyTVFp6UiYHYqovtMaXU99lCMF7yxpa05e6y95gQLkFl7VPAreW04bjDRY0ay+hHxLASWwx8WFepy9c2r5GD7tpfAaTYwv3Nkc32RxS0KL5ylKc1Mzez4kXaVcVLCchpMNWNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249819; c=relaxed/simple;
	bh=NeP0qGBvbAfC50cJ/evLvG22IXhJtukPU4pTE5g+2xI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JkLBUYspltKcV5vWHxAz6WGSsrlxDhWKGpqa6spGeYYDx/fqdKTjYnPLecILMz/fOTxf/3+AnuY6A7iVsobA9i0ymPkxBlVYHdvvrPylghqeqInVCOMJRqZboo4nMn4ILlm3flbWOOz/g5kMpn5Uw9nrWsddKh2QhaHsByL4sK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVs+ahag; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759249817; x=1790785817;
  h=date:from:to:cc:subject:message-id;
  bh=NeP0qGBvbAfC50cJ/evLvG22IXhJtukPU4pTE5g+2xI=;
  b=lVs+ahagK5+4johRkPLEHvPEo/IF/nkHw95OFrya7d3GUcbXjIzChTEY
   Crga4M6v5UjLKQv8ZGp6LGxgX8rKtdjxDfIUaKZFtHaChsq5RuIZwI8yr
   s79rvuDONDpf+cE88BuYCMkkcthap4fbMbxwfzSHLlQgtCF7kIsUCQUMm
   5Nr5QqS8y6WwjYmlK678KhFDx3gsXrEpSJPPQMKvegpqFlQkS68ChkzoF
   mUXDzeynvianWUnnxCjfz2GnwH/txAeO6LNeeSIMeh26rnHsc754wZoSy
   cFh9UQ1NRfmOH7ZMsvJBBmPJYFsHqj9mgtzc7qahiyupvqbQ5kePCBjbB
   w==;
X-CSE-ConnectionGUID: SmLma+UZSWurYSJvu031rg==
X-CSE-MsgGUID: f3VoM4wUSs2opMAcWAFyKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="65151335"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="65151335"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:30:17 -0700
X-CSE-ConnectionGUID: W5Rm+jlFRqOnhwcPfaFOVA==
X-CSE-MsgGUID: WecrYeGHQ8+DODpqYMWauA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="177682034"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Sep 2025 09:30:15 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3dEz-0002IG-0K;
	Tue, 30 Sep 2025 16:30:13 +0000
Date: Wed, 01 Oct 2025 00:29:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 99da5bf3dd6a8cb951adcace6153c34c86547811
Message-ID: <202510010027.cYvyRLQF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 99da5bf3dd6a8cb951adcace6153c34c86547811  efi/x86: Memory protection on EfiGcdMemoryTypeMoreReliable

elapsed time: 1456m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250930    gcc-9.5.0
arc                   randconfig-002-20250930    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250930    gcc-13.4.0
arm                   randconfig-002-20250930    gcc-8.5.0
arm                   randconfig-003-20250930    gcc-8.5.0
arm                   randconfig-004-20250930    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250930    clang-18
arm64                 randconfig-002-20250930    clang-22
arm64                 randconfig-003-20250930    clang-18
arm64                 randconfig-004-20250930    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250930    gcc-13.4.0
csky                  randconfig-002-20250930    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250930    clang-22
hexagon               randconfig-002-20250930    clang-22
i386        buildonly-randconfig-001-20250930    gcc-12
i386        buildonly-randconfig-002-20250930    gcc-14
i386        buildonly-randconfig-003-20250930    clang-20
i386        buildonly-randconfig-004-20250930    gcc-14
i386        buildonly-randconfig-005-20250930    clang-20
i386        buildonly-randconfig-006-20250930    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250930    clang-22
loongarch             randconfig-002-20250930    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250930    gcc-8.5.0
nios2                 randconfig-002-20250930    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250930    gcc-12.5.0
parisc                randconfig-002-20250930    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250930    gcc-8.5.0
powerpc               randconfig-002-20250930    gcc-14.3.0
powerpc               randconfig-003-20250930    gcc-15.1.0
powerpc64             randconfig-001-20250930    gcc-14.3.0
powerpc64             randconfig-002-20250930    gcc-12.5.0
powerpc64             randconfig-003-20250930    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250930    gcc-10.5.0
riscv                 randconfig-002-20250930    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250930    gcc-12.5.0
s390                  randconfig-002-20250930    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250930    gcc-15.1.0
sh                    randconfig-002-20250930    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250930    gcc-11.5.0
sparc                 randconfig-002-20250930    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250930    clang-22
sparc64               randconfig-002-20250930    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250930    gcc-14
um                    randconfig-002-20250930    gcc-12
um                           x86_64_defconfig    clang-22
x86_64      buildonly-randconfig-001-20250930    clang-20
x86_64      buildonly-randconfig-002-20250930    gcc-14
x86_64      buildonly-randconfig-003-20250930    gcc-14
x86_64      buildonly-randconfig-004-20250930    clang-20
x86_64      buildonly-randconfig-005-20250930    gcc-14
x86_64      buildonly-randconfig-006-20250930    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250930    gcc-12.5.0
xtensa                randconfig-002-20250930    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

