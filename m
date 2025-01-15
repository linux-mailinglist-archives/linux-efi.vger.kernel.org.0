Return-Path: <linux-efi+bounces-2632-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0371EA11BE1
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 09:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EE3188AAF2
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20DE28EC94;
	Wed, 15 Jan 2025 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaUf+e/p"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE828EC8C
	for <linux-efi@vger.kernel.org>; Wed, 15 Jan 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736929585; cv=none; b=qguCdSLtoLMTyhDiqNwcwNNR7y6E1EMBavxTnEtQBQduySKgue26yBJohYf/wkljC69yv3waVYdR14t7pEXXKMIGV2w2C6fAMV50ppjdKyVpX2zrmu3JHup8XDG/zTUVGHHQLrJ27Yfv/Z5PN7ITBZT+u4camB3/yJq4vrL2Sig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736929585; c=relaxed/simple;
	bh=8gedRoM7CCQ8mYkCQf3FLHqknKOEtEsfoJIyLmeYdA0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CDZaBPvraV1EBOum+vMnU/6FPVO2TZzDX+VSr/RVy8ahnCpR9L8+Z6/KRpFRd6+KHiZn2ttCf7mdX1xp5aCkVO+XmbJ4LhzEnPS6FVYbrX70LXXHl8VlrEFfsjdSAxgSg6Ogj9jbD5MChgbTnloq2TzhzhJX6ln9rOTZLTWVwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaUf+e/p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736929584; x=1768465584;
  h=date:from:to:cc:subject:message-id;
  bh=8gedRoM7CCQ8mYkCQf3FLHqknKOEtEsfoJIyLmeYdA0=;
  b=KaUf+e/phLfT4Xzio/iPCc+gaUxhdIJzdeoOA+bL17ZKOvzllz7biRpq
   EJRZVmWFfjMMPKl4fCvGCsD6LF8W42OPp1s0JWcT97JeOVtHh2so5qcQO
   mZ8dzGAf637B591bBEqtibNyu6hgShN5QCXfiXXUQ8elUqjLXMXsKc4S+
   vZCTY+PY4VBhBBshbzIf/IK2flfxoTGweOp7MfaBr8ps+ErU/P5mAKSfT
   jWG27UCtN0pDQfUJm5oFBuX5oIUbGBMmPdeeSgBk+vabryMcsRF9l+RI7
   d7JXt1yc9kCgqHEFP6uSTyQErCFPNVLsOQzaRPcH//YXOPn+VIcEpKqLB
   g==;
X-CSE-ConnectionGUID: LMn+bufsRIOZ+r1XEp9eqg==
X-CSE-MsgGUID: xuo57uV+RbWWld/zYeVoTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37167996"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="37167996"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 00:26:24 -0800
X-CSE-ConnectionGUID: 1+1SRWKOQOKAyvhk2xapgQ==
X-CSE-MsgGUID: GRvpR/f1RICwOus9pUgxBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="105594159"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 15 Jan 2025 00:26:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXyjE-000Pfp-2o;
	Wed, 15 Jan 2025 08:26:20 +0000
Date: Wed, 15 Jan 2025 16:25:32 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 dc7d002071328298a2f4b7a10da39bc8cbad2e09
Message-ID: <202501151626.gaB5EBRK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: dc7d002071328298a2f4b7a10da39bc8cbad2e09  Merge branch 'efivarfs' into next

elapsed time: 1463m

configs tested: 127
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250114    gcc-13.2.0
arc                   randconfig-002-20250114    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                            mmp2_defconfig    gcc-14.2.0
arm                   randconfig-001-20250114    clang-15
arm                   randconfig-002-20250114    clang-20
arm                   randconfig-003-20250114    gcc-14.2.0
arm                   randconfig-004-20250114    gcc-14.2.0
arm                             rpc_defconfig    clang-17
arm                           u8500_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250114    clang-17
arm64                 randconfig-002-20250114    clang-19
arm64                 randconfig-003-20250114    gcc-14.2.0
arm64                 randconfig-004-20250114    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250114    gcc-14.2.0
csky                  randconfig-002-20250114    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250114    clang-20
hexagon               randconfig-002-20250114    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250114    gcc-12
i386        buildonly-randconfig-002-20250114    clang-19
i386        buildonly-randconfig-003-20250114    clang-19
i386        buildonly-randconfig-004-20250114    gcc-12
i386        buildonly-randconfig-005-20250114    clang-19
i386        buildonly-randconfig-006-20250114    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250114    gcc-14.2.0
loongarch             randconfig-002-20250114    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-16
mips                           gcw0_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250114    gcc-14.2.0
nios2                 randconfig-002-20250114    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250114    gcc-14.2.0
parisc                randconfig-002-20250114    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                   currituck_defconfig    clang-17
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250114    gcc-14.2.0
powerpc               randconfig-002-20250114    clang-20
powerpc               randconfig-003-20250114    gcc-14.2.0
powerpc64             randconfig-001-20250114    clang-20
powerpc64             randconfig-002-20250114    clang-15
powerpc64             randconfig-003-20250114    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250115    gcc-14.2.0
riscv                 randconfig-002-20250115    clang-16
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250115    clang-20
s390                  randconfig-002-20250115    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250115    gcc-14.2.0
sh                    randconfig-002-20250115    gcc-14.2.0
sh                     sh7710voipgw_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250115    gcc-14.2.0
sparc                 randconfig-002-20250115    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250115    gcc-14.2.0
sparc64               randconfig-002-20250115    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250115    clang-18
um                    randconfig-002-20250115    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250114    clang-19
x86_64      buildonly-randconfig-002-20250114    clang-19
x86_64      buildonly-randconfig-003-20250114    clang-19
x86_64      buildonly-randconfig-004-20250114    clang-19
x86_64      buildonly-randconfig-005-20250114    clang-19
x86_64      buildonly-randconfig-006-20250114    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250115    gcc-14.2.0
xtensa                randconfig-002-20250115    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

