Return-Path: <linux-efi+bounces-5894-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4A1CC946A
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 19:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45B633069411
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B434C154;
	Wed, 17 Dec 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/kGN1/3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD783624C8
	for <linux-efi@vger.kernel.org>; Wed, 17 Dec 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977763; cv=none; b=S/zo+FQ/P/XqhB42TMXEz/QPYv9KbRNEVSfiEcE3fABFI2RQke01vMUvdI8TglHFfVLymI8xxg0FH5CEkaMejj4gEQLQjNK1Tiwk1ZCuKlDMLPXKqPdyVvN3La2D2+7qYMQBVTgYuXuGJ/1oflds4hMQ0wKe4nAu/580o/Z6vdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977763; c=relaxed/simple;
	bh=NZZC3ShwPTCGs8rnlM9BwIxT0IhjRPkoKxW9MoY2MxQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=V+yYQOhQLTOQsWa2uv3YNYjct0Kw1rRNko4nlJuNZ7GK3VZRzDhCtvzmObhQVmxpBYPV43qs9Q7vuqiAoraakDi8XEzDxeWZ1ILuj3IpT9xaQYWV6872dj23HHLo+wTQxR4sOwwgoP9t6JXp7TjGh63o/xHF3FHQODak7SsGPzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/kGN1/3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765977762; x=1797513762;
  h=date:from:to:cc:subject:message-id;
  bh=NZZC3ShwPTCGs8rnlM9BwIxT0IhjRPkoKxW9MoY2MxQ=;
  b=K/kGN1/3d7Fmob0dk0gHhjjKxsrFQibrMPmuOS47aG1WKj1ApYVBaUkk
   xeq2h56iITWyzKpgXDYNDnynLPHMHcuPFOoCf1bxwWLKgUh9vchG0pUIs
   QbTTPJ1SMj9mEVoTWEmgP7LhzR8F8S+pPAQ68gyzN5kSWmJEFHZ20m9Z7
   qRANYbAlF6n5YTtqgWLkUhUDvsBI3ZUxF57x5xtBJJBGoBPZaiLe113Id
   apdzhNdY8UyiiZRFScEtemcUPpuBYNfJNfBcvPADK/xnSvzIOfdFZyUxE
   F3EmIzALkoWpWQ/8WQDRew3poeRMFtTnaNYJCZ4jr+jg3sK/ZLBfKI/CO
   Q==;
X-CSE-ConnectionGUID: 3hIx+8oNQYS4DKTaCbypbg==
X-CSE-MsgGUID: VrmAByh1RumYDaGgv4+EMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="55485624"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="55485624"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:22:41 -0800
X-CSE-ConnectionGUID: fbippgh7RL+Nhd891p3JdA==
X-CSE-MsgGUID: FCkWiFbVTvu6rXaRpfwzzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="197568948"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Dec 2025 05:22:39 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVrUD-000000000bC-2w3l;
	Wed, 17 Dec 2025 13:22:37 +0000
Date: Wed, 17 Dec 2025 21:21:52 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 c5a8f13f1e476c90f4bc184a58751d3e7ff88f2b
Message-ID: <202512172145.xxXXdwrl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: c5a8f13f1e476c90f4bc184a58751d3e7ff88f2b  efi: Support EDID information

elapsed time: 1397m

configs tested: 221
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251217    clang-22
arc                   randconfig-002-20251217    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                     am200epdkit_defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                          ixp4xx_defconfig    clang-22
arm                             pxa_defconfig    gcc-15.1.0
arm                   randconfig-001-20251217    clang-22
arm                   randconfig-002-20251217    clang-22
arm                   randconfig-003-20251217    clang-22
arm                   randconfig-004-20251217    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251217    clang-22
arm64                 randconfig-002-20251217    clang-22
arm64                 randconfig-003-20251217    clang-22
arm64                 randconfig-004-20251217    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251217    clang-22
csky                  randconfig-002-20251217    clang-22
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251217    clang-22
hexagon               randconfig-001-20251217    gcc-11.5.0
hexagon               randconfig-002-20251217    clang-22
hexagon               randconfig-002-20251217    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251217    clang-20
i386        buildonly-randconfig-002-20251217    clang-20
i386        buildonly-randconfig-002-20251217    gcc-14
i386        buildonly-randconfig-003-20251217    clang-20
i386        buildonly-randconfig-003-20251217    gcc-13
i386        buildonly-randconfig-004-20251217    clang-20
i386        buildonly-randconfig-005-20251217    clang-20
i386        buildonly-randconfig-005-20251217    gcc-14
i386        buildonly-randconfig-006-20251217    clang-20
i386        buildonly-randconfig-006-20251217    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251217    clang-20
i386                  randconfig-001-20251217    gcc-14
i386                  randconfig-002-20251217    clang-20
i386                  randconfig-002-20251217    gcc-14
i386                  randconfig-003-20251217    clang-20
i386                  randconfig-003-20251217    gcc-14
i386                  randconfig-004-20251217    gcc-14
i386                  randconfig-005-20251217    gcc-13
i386                  randconfig-005-20251217    gcc-14
i386                  randconfig-006-20251217    clang-20
i386                  randconfig-006-20251217    gcc-14
i386                  randconfig-007-20251217    clang-20
i386                  randconfig-007-20251217    gcc-14
i386                  randconfig-011-20251217    clang-20
i386                  randconfig-011-20251217    gcc-14
i386                  randconfig-012-20251217    clang-20
i386                  randconfig-013-20251217    clang-20
i386                  randconfig-014-20251217    clang-20
i386                  randconfig-015-20251217    clang-20
i386                  randconfig-015-20251217    gcc-14
i386                  randconfig-016-20251217    clang-20
i386                  randconfig-016-20251217    gcc-14
i386                  randconfig-017-20251217    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251217    clang-22
loongarch             randconfig-001-20251217    gcc-11.5.0
loongarch             randconfig-002-20251217    clang-22
loongarch             randconfig-002-20251217    gcc-11.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                            mac_defconfig    clang-22
m68k                           virt_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                         3c120_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251217    gcc-11.5.0
nios2                 randconfig-002-20251217    gcc-11.5.0
nios2                 randconfig-002-20251217    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251217    gcc-15.1.0
parisc                randconfig-001-20251217    gcc-8.5.0
parisc                randconfig-002-20251217    gcc-14.3.0
parisc                randconfig-002-20251217    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                       ebony_defconfig    gcc-15.1.0
powerpc                         ps3_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251217    gcc-8.5.0
powerpc               randconfig-002-20251217    clang-22
powerpc               randconfig-002-20251217    gcc-8.5.0
powerpc                     tqm8560_defconfig    clang-22
powerpc64             randconfig-001-20251217    gcc-14.3.0
powerpc64             randconfig-001-20251217    gcc-8.5.0
powerpc64             randconfig-002-20251217    clang-18
powerpc64             randconfig-002-20251217    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                    nommu_k210_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251217    clang-18
riscv                 randconfig-002-20251217    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251217    clang-18
s390                  randconfig-002-20251217    clang-18
sh                               alldefconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.1.0
sh                          lboxre2_defconfig    gcc-15.1.0
sh                    randconfig-001-20251217    clang-18
sh                    randconfig-002-20251217    clang-18
sh                           se7705_defconfig    gcc-15.1.0
sh                           se7750_defconfig    clang-22
sh                   secureedge5410_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251217    gcc-15.1.0
sparc                 randconfig-002-20251217    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251217    gcc-15.1.0
sparc64               randconfig-002-20251217    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251217    gcc-15.1.0
um                    randconfig-002-20251217    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251217    gcc-14
x86_64      buildonly-randconfig-002-20251217    gcc-14
x86_64      buildonly-randconfig-003-20251217    gcc-14
x86_64      buildonly-randconfig-004-20251217    gcc-14
x86_64      buildonly-randconfig-005-20251217    gcc-14
x86_64      buildonly-randconfig-006-20251217    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251217    clang-20
x86_64                randconfig-002-20251217    clang-20
x86_64                randconfig-003-20251217    clang-20
x86_64                randconfig-004-20251217    clang-20
x86_64                randconfig-005-20251217    clang-20
x86_64                randconfig-006-20251217    clang-20
x86_64                randconfig-011-20251217    gcc-14
x86_64                randconfig-012-20251217    gcc-14
x86_64                randconfig-013-20251217    gcc-14
x86_64                randconfig-014-20251217    gcc-14
x86_64                randconfig-015-20251217    gcc-14
x86_64                randconfig-016-20251217    gcc-14
x86_64                randconfig-071-20251217    clang-20
x86_64                randconfig-071-20251217    gcc-14
x86_64                randconfig-072-20251217    gcc-13
x86_64                randconfig-072-20251217    gcc-14
x86_64                randconfig-073-20251217    gcc-14
x86_64                randconfig-074-20251217    clang-20
x86_64                randconfig-074-20251217    gcc-14
x86_64                randconfig-075-20251217    clang-20
x86_64                randconfig-075-20251217    gcc-14
x86_64                randconfig-076-20251217    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251217    gcc-15.1.0
xtensa                randconfig-002-20251217    gcc-15.1.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

