Return-Path: <linux-efi+bounces-4353-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51CDB06BB0
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 04:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EB587ACCC5
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 02:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63B270ECB;
	Wed, 16 Jul 2025 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYsPgiOS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470A5264A90
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632948; cv=none; b=hkYiwDymkHkpe7TYYx+vVGzJCSPjQNvHhyOVgeOa9Wrx7CiV0TfRdhHpE2xli8K9EdpLizPZg/uWZ0zAzPcKeytjaICxDr939KbRmG1ziWfgu6gL/lbFST5YceXKkvuPBOrnR+awQdbxBq7/kQER8Off/KuH5hpAL/7vo7iNoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632948; c=relaxed/simple;
	bh=/GMWXs/nZ9wII1OAbQa8+YVhh2/yRvDxGQZalbyrs6U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s35oqPoEIa4x779cZH8BlcspZvg+6yC2YnDSoKMEB3RjdecjapEO1N4x2er2UiMG287Rvz68P84osgh6nJIQD7HUk6tLp6w9e66cLYHPTp8TlVXF2pIhk6rLUGJk8q8LXIP7zXzq/0v0AF7rPzFkL0KiSuk8+JEIlJWkfzAWsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYsPgiOS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752632946; x=1784168946;
  h=date:from:to:cc:subject:message-id;
  bh=/GMWXs/nZ9wII1OAbQa8+YVhh2/yRvDxGQZalbyrs6U=;
  b=WYsPgiOSQIRPGc5zbkMitEqVNPqB0dSjXL2CKar4sr7ZEP1ImfFF7IaR
   v3RA0LeaiqGv3L4KVElTraykRwxezX8zHRwyQ+VtsN5fIX/AG6gBP/8m+
   0fcItk8ns+keQ/be1BRXKH1BoVoDBzWaVTfhjaa080KM7R4MEEuseBBeo
   XV4PjQZznVdGJ010zwK9fifmzt9tqznXndNX6y9R7VdsvmCrmOiSHCku1
   oJJEK3KPWE9lRV7WZTZjsZZOMuNtYbFJ4DYLVGRunP5ci6ehWVZkNF1Ea
   kCKHqVt+PZW57+bMHSrjvdUl+dabTQGLsHg+zCkC1iR+CgmIKSqU8MW/Q
   g==;
X-CSE-ConnectionGUID: 3BgM6kNiT7GJKfxJ7UVN/w==
X-CSE-MsgGUID: o88ItwFjReSNsDPWWmd8gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55018171"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="55018171"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:29:06 -0700
X-CSE-ConnectionGUID: daZrmvbZQpu1/+V0nxRx+A==
X-CSE-MsgGUID: jWyTJ5y/ST28+X/MbvQl9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157726516"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2025 19:29:04 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubrtG-000BnD-0u;
	Wed, 16 Jul 2025 02:29:02 +0000
Date: Wed, 16 Jul 2025 10:28:53 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 02eb7a8eee20b9ec6aafd5e17c5c41b53e8b13ef
Message-ID: <202507161041.sFRwgu0x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 02eb7a8eee20b9ec6aafd5e17c5c41b53e8b13ef  efi: add API doc entry for ovmf_debug_log

elapsed time: 1446m

configs tested: 128
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250715    gcc-8.5.0
arc                   randconfig-002-20250715    gcc-11.5.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-21
arm                   randconfig-001-20250715    clang-21
arm                   randconfig-002-20250715    gcc-10.5.0
arm                   randconfig-003-20250715    clang-21
arm                   randconfig-004-20250715    gcc-12.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250715    clang-16
arm64                 randconfig-002-20250715    gcc-12.3.0
arm64                 randconfig-003-20250715    gcc-8.5.0
arm64                 randconfig-004-20250715    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250715    gcc-9.3.0
csky                  randconfig-002-20250715    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250715    clang-18
hexagon               randconfig-002-20250715    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250715    gcc-12
i386        buildonly-randconfig-002-20250715    gcc-12
i386        buildonly-randconfig-003-20250715    gcc-12
i386        buildonly-randconfig-004-20250715    clang-20
i386        buildonly-randconfig-005-20250715    clang-20
i386        buildonly-randconfig-006-20250715    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250715    clang-21
loongarch             randconfig-002-20250715    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-21
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250715    gcc-11.5.0
nios2                 randconfig-002-20250715    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250715    gcc-10.5.0
parisc                randconfig-002-20250715    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-21
powerpc                 mpc8315_rdb_defconfig    clang-21
powerpc               randconfig-001-20250715    clang-21
powerpc               randconfig-002-20250715    clang-21
powerpc               randconfig-003-20250715    gcc-8.5.0
powerpc64             randconfig-001-20250715    clang-21
powerpc64             randconfig-003-20250715    clang-17
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250715    clang-21
riscv                 randconfig-002-20250715    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250715    gcc-8.5.0
s390                  randconfig-002-20250715    gcc-12.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250715    gcc-11.5.0
sh                    randconfig-002-20250715    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250715    gcc-8.5.0
sparc                 randconfig-002-20250715    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250715    clang-20
sparc64               randconfig-002-20250715    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250715    gcc-12
um                    randconfig-002-20250715    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250715    clang-20
x86_64      buildonly-randconfig-002-20250715    gcc-12
x86_64      buildonly-randconfig-003-20250715    gcc-12
x86_64      buildonly-randconfig-004-20250715    gcc-11
x86_64      buildonly-randconfig-005-20250715    gcc-12
x86_64      buildonly-randconfig-006-20250715    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250715    gcc-8.5.0
xtensa                randconfig-002-20250715    gcc-14.3.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

