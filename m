Return-Path: <linux-efi+bounces-3900-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0746FAE2879
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 12:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323367A9C29
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1629A19C540;
	Sat, 21 Jun 2025 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQwE8NAT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C430E826
	for <linux-efi@vger.kernel.org>; Sat, 21 Jun 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750500342; cv=none; b=NvPVtEjlwA4AbIioO9o4iYWdF3EdXPyOUJ5MGRrFP9zCn1UaIql1sOhDusV8awseVJeRof5Ujh+fIrlp8cwgQE1uk3kT0D4xTGXdxjcHbVeqQcNFaLA0DtrPY5CFLXx4fftfGQ3HC8ssbVAOTmxBtheyNTZmlBAanOrtDiikBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750500342; c=relaxed/simple;
	bh=y8syjfNpsqOctDtzi1gXLdXXWt+EdaLl6ct0ywu26jI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tTgyt20IXP5reLXIypmI+1cwOTYoC+gQLi5/hqM/BniLz+g45lu0aUH0hf29DAb7tW7dRUEAsCjQypXsYZ4fDHUrI+y0AG4bl4CvVpjtnRgsbvtx9oRAiWtGo9PMiyerVEdfKgExYDxg2w7tBj76NvsL9LO/CUAW2sTbQSlIPFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQwE8NAT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750500340; x=1782036340;
  h=date:from:to:cc:subject:message-id;
  bh=y8syjfNpsqOctDtzi1gXLdXXWt+EdaLl6ct0ywu26jI=;
  b=fQwE8NATsYqRaku1zVfralowL+rEk/4Q4ahvPa2rcpnI+RfWsqOr2RLy
   ORNF6nZFCDFzDGv3s9IkMhQhc6aurLos0a9by4TPNel4+nmMwps9Uy0Ux
   rVcdUx/CkM2wOITJdfUdw0IG5nfErENfBORy6c8toRhAgRJO7yiLUsY4w
   vU4rRizo3I3fMENVBUvRMfmQgvtJLDyqgRPRnBl7l55pSe+P1TKkXM/ya
   IFm5H39Xmes9o37VcAOVQiZwALXRZy00TZclVR3j9foEQaRQHGfGYhkZj
   z7wJShwkvqF9nkbz/BFrykwlhNkagIn1h0rTkBqsdkhhhoqTjqBxcXje1
   Q==;
X-CSE-ConnectionGUID: ufiu4bxuQhKzW/mbPzMtXw==
X-CSE-MsgGUID: ouwVHhT7RTCO1nKV+uaNGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="70328242"
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="70328242"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 03:05:37 -0700
X-CSE-ConnectionGUID: mbH6r9PcSDaEULmZJHf2rA==
X-CSE-MsgGUID: trNqQ6cFS3qUjyivYUXcbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="150716781"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 21 Jun 2025 03:05:36 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSv6M-000MXe-19;
	Sat, 21 Jun 2025 10:05:34 +0000
Date: Sat, 21 Jun 2025 18:05:28 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 f8b53cc9174c5980549f60c972faad82b660b62d
Message-ID: <202506211818.ugbns7cf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: f8b53cc9174c5980549f60c972faad82b660b62d  efi: Fix .data section size calculations when .sbat is present

elapsed time: 1344m

configs tested: 166
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250620    gcc-8.5.0
arc                   randconfig-002-20250620    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                          pxa910_defconfig    gcc-15.1.0
arm                   randconfig-001-20250620    clang-21
arm                   randconfig-002-20250620    clang-21
arm                   randconfig-003-20250620    clang-21
arm                   randconfig-004-20250620    clang-21
arm                             rpc_defconfig    clang-18
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250620    gcc-9.5.0
arm64                 randconfig-002-20250620    gcc-8.5.0
arm64                 randconfig-003-20250620    gcc-11.5.0
arm64                 randconfig-004-20250620    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250620    gcc-13.3.0
csky                  randconfig-002-20250620    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250620    clang-21
hexagon               randconfig-002-20250620    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250620    clang-20
i386        buildonly-randconfig-002-20250620    clang-20
i386        buildonly-randconfig-003-20250620    clang-20
i386        buildonly-randconfig-004-20250620    clang-20
i386        buildonly-randconfig-005-20250620    clang-20
i386        buildonly-randconfig-006-20250620    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250620    gcc-14.3.0
loongarch             randconfig-002-20250620    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5275evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                  cavium_octeon_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                 randconfig-001-20250620    gcc-8.5.0
nios2                 randconfig-002-20250620    gcc-10.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20250620    gcc-10.5.0
parisc                randconfig-002-20250620    gcc-12.4.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250620    clang-21
powerpc               randconfig-002-20250620    gcc-11.5.0
powerpc               randconfig-003-20250620    clang-21
powerpc64             randconfig-001-20250620    gcc-14.3.0
powerpc64             randconfig-002-20250620    clang-21
powerpc64             randconfig-003-20250620    clang-19
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20250620    gcc-14.3.0
riscv                 randconfig-002-20250620    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250620    gcc-9.3.0
s390                  randconfig-002-20250620    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250620    gcc-15.1.0
sh                    randconfig-002-20250620    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250620    gcc-8.5.0
sparc                 randconfig-002-20250620    gcc-10.3.0
sparc64               randconfig-001-20250620    gcc-13.3.0
sparc64               randconfig-002-20250620    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250620    clang-21
um                    randconfig-002-20250620    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250620    gcc-12
x86_64      buildonly-randconfig-001-20250621    gcc-12
x86_64      buildonly-randconfig-002-20250620    gcc-12
x86_64      buildonly-randconfig-002-20250621    gcc-12
x86_64      buildonly-randconfig-003-20250620    clang-20
x86_64      buildonly-randconfig-003-20250621    gcc-12
x86_64      buildonly-randconfig-004-20250620    gcc-12
x86_64      buildonly-randconfig-004-20250621    gcc-12
x86_64      buildonly-randconfig-005-20250620    gcc-12
x86_64      buildonly-randconfig-005-20250621    gcc-12
x86_64      buildonly-randconfig-006-20250620    clang-20
x86_64      buildonly-randconfig-006-20250621    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250621    gcc-12
x86_64                randconfig-002-20250621    gcc-12
x86_64                randconfig-003-20250621    gcc-12
x86_64                randconfig-004-20250621    gcc-12
x86_64                randconfig-005-20250621    gcc-12
x86_64                randconfig-006-20250621    gcc-12
x86_64                randconfig-007-20250621    gcc-12
x86_64                randconfig-008-20250621    gcc-12
x86_64                randconfig-071-20250621    gcc-12
x86_64                randconfig-072-20250621    gcc-12
x86_64                randconfig-073-20250621    gcc-12
x86_64                randconfig-074-20250621    gcc-12
x86_64                randconfig-075-20250621    gcc-12
x86_64                randconfig-076-20250621    gcc-12
x86_64                randconfig-077-20250621    gcc-12
x86_64                randconfig-078-20250621    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250620    gcc-8.5.0
xtensa                randconfig-002-20250620    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

