Return-Path: <linux-efi+bounces-2988-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC44A62C00
	for <lists+linux-efi@lfdr.de>; Sat, 15 Mar 2025 12:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A1C3BE407
	for <lists+linux-efi@lfdr.de>; Sat, 15 Mar 2025 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC931F8726;
	Sat, 15 Mar 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsy3osmO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED08818B494
	for <linux-efi@vger.kernel.org>; Sat, 15 Mar 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742039017; cv=none; b=omzBudXXIwnZk/0qD+dOIFP1OVDcQ2ozPfc//kfH6965q4Cd2hYPjwUZ0SQ6KC76KeeymV3pdgGE9rM0qiFXrKdL1wndcydEqDSboXO4pqsvQ2MvEASzzRB3gmXsd9FX29eoF9hdomyodb8XXdyRET08qdMyTPCwQ64SIQ36ZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742039017; c=relaxed/simple;
	bh=/I/Jisz0oHr1xMJg66FjYLk7X14eL8/SaX7AnvzUwDQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sWkQneTIwsI93ivTc4lYwH25HJ6nK9xshfl0VpOLA810c9mO7p2guIZwi3nV7YDBmSMhy/l8EIkYm1hO/wmI8omIB9pt5z44Z3xjGVSq7uEiyTqmbkKUqOy+ZuHoy8xS/KrUlLVAEu7fWSsmyD/6zVSkx2zAmCYHTvG/S2UPMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsy3osmO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742039016; x=1773575016;
  h=date:from:to:cc:subject:message-id;
  bh=/I/Jisz0oHr1xMJg66FjYLk7X14eL8/SaX7AnvzUwDQ=;
  b=gsy3osmOJvNvgy+ZzTRbYJEqQDaBAJo0K5sW3ziNnMIjr76qQjzxN1nv
   wsXbEtxmz8I4oBgutuXWUbUIl7ejZCLJppwNrPFAqKS8oWGB/p8Gy2iL+
   EaD56k48TLNQBgazOJvPAuUhCUDnaS0CdiubmNagvbzhUC/Vcku3u7K8c
   qr/j4w4JRgUaEBWZrj31FPJmtk+yKA3NnOuBT0dVZak575fTj/hbCQ/va
   j7A2ly3JupBn+y6Tk5dajYC/qCAGeyk2LiboeTHg2d7X3UCW199zf9QXe
   dpw3DC7FidA6qjnWT+otS5yuYdD95+MPVg0T5MffluTV/LsU1eTbtNknz
   A==;
X-CSE-ConnectionGUID: PGyu27ItRSSTu9Ge4lItjA==
X-CSE-MsgGUID: l99fiVy5SvOSqHkQ73eM/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="53822260"
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="53822260"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 04:43:35 -0700
X-CSE-ConnectionGUID: upsa7rdlQZ20hkQIV1ZANg==
X-CSE-MsgGUID: oa5neH06SQSGCAS1O4TzYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="122006794"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 15 Mar 2025 04:43:34 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttPvP-000BJX-1Q;
	Sat, 15 Mar 2025 11:43:31 +0000
Date: Sat, 15 Mar 2025 19:43:26 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 cb16dfed0093217a68c0faa9394fa5823927e04c
Message-ID: <202503151920.U1E9prQu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: cb16dfed0093217a68c0faa9394fa5823927e04c  efi/libstub: Avoid physical address 0x0 when doing random allocation

elapsed time: 1446m

configs tested: 227
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250314    gcc-13.2.0
arc                   randconfig-001-20250315    gcc-14.2.0
arc                   randconfig-002-20250314    gcc-13.2.0
arc                   randconfig-002-20250315    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          exynos_defconfig    clang-21
arm                            hisi_defconfig    gcc-14.2.0
arm                   randconfig-001-20250314    clang-21
arm                   randconfig-001-20250315    gcc-14.2.0
arm                   randconfig-002-20250314    gcc-14.2.0
arm                   randconfig-002-20250315    gcc-14.2.0
arm                   randconfig-003-20250314    gcc-14.2.0
arm                   randconfig-003-20250315    gcc-14.2.0
arm                   randconfig-004-20250314    gcc-14.2.0
arm                   randconfig-004-20250315    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250314    gcc-14.2.0
arm64                 randconfig-001-20250315    gcc-14.2.0
arm64                 randconfig-002-20250314    clang-21
arm64                 randconfig-002-20250315    gcc-14.2.0
arm64                 randconfig-003-20250314    clang-15
arm64                 randconfig-003-20250315    gcc-14.2.0
arm64                 randconfig-004-20250314    clang-21
arm64                 randconfig-004-20250315    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250314    gcc-14.2.0
csky                  randconfig-001-20250315    gcc-14.2.0
csky                  randconfig-002-20250314    gcc-14.2.0
csky                  randconfig-002-20250315    gcc-14.2.0
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250314    clang-21
hexagon               randconfig-001-20250315    gcc-14.2.0
hexagon               randconfig-002-20250314    clang-21
hexagon               randconfig-002-20250315    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250314    clang-19
i386        buildonly-randconfig-001-20250315    clang-19
i386        buildonly-randconfig-002-20250314    clang-19
i386        buildonly-randconfig-002-20250315    clang-19
i386        buildonly-randconfig-003-20250314    gcc-12
i386        buildonly-randconfig-003-20250315    clang-19
i386        buildonly-randconfig-004-20250314    gcc-12
i386        buildonly-randconfig-004-20250315    clang-19
i386        buildonly-randconfig-005-20250314    gcc-12
i386        buildonly-randconfig-005-20250315    clang-19
i386        buildonly-randconfig-006-20250314    gcc-12
i386        buildonly-randconfig-006-20250315    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250315    clang-19
i386                  randconfig-002-20250315    clang-19
i386                  randconfig-003-20250315    clang-19
i386                  randconfig-004-20250315    clang-19
i386                  randconfig-005-20250315    clang-19
i386                  randconfig-006-20250315    clang-19
i386                  randconfig-007-20250315    clang-19
i386                  randconfig-011-20250315    gcc-12
i386                  randconfig-012-20250315    gcc-12
i386                  randconfig-013-20250315    gcc-12
i386                  randconfig-014-20250315    gcc-12
i386                  randconfig-015-20250315    gcc-12
i386                  randconfig-016-20250315    gcc-12
i386                  randconfig-017-20250315    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250314    gcc-14.2.0
loongarch             randconfig-001-20250315    gcc-14.2.0
loongarch             randconfig-002-20250314    gcc-14.2.0
loongarch             randconfig-002-20250315    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    clang-21
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-21
mips                        qi_lb60_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250314    gcc-14.2.0
nios2                 randconfig-001-20250315    gcc-14.2.0
nios2                 randconfig-002-20250314    gcc-14.2.0
nios2                 randconfig-002-20250315    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-15
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250314    gcc-14.2.0
parisc                randconfig-001-20250315    gcc-14.2.0
parisc                randconfig-002-20250314    gcc-14.2.0
parisc                randconfig-002-20250315    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                       holly_defconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250314    clang-21
powerpc               randconfig-001-20250315    gcc-14.2.0
powerpc               randconfig-002-20250314    gcc-14.2.0
powerpc               randconfig-002-20250315    gcc-14.2.0
powerpc               randconfig-003-20250314    gcc-14.2.0
powerpc               randconfig-003-20250315    gcc-14.2.0
powerpc64             randconfig-001-20250314    gcc-14.2.0
powerpc64             randconfig-001-20250315    gcc-14.2.0
powerpc64             randconfig-002-20250314    clang-17
powerpc64             randconfig-002-20250315    gcc-14.2.0
powerpc64             randconfig-003-20250314    clang-21
powerpc64             randconfig-003-20250315    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250314    clang-19
riscv                 randconfig-001-20250315    gcc-14.2.0
riscv                 randconfig-002-20250314    gcc-14.2.0
riscv                 randconfig-002-20250315    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250314    gcc-14.2.0
s390                  randconfig-001-20250315    gcc-14.2.0
s390                  randconfig-002-20250314    gcc-14.2.0
s390                  randconfig-002-20250315    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250314    gcc-14.2.0
sh                    randconfig-001-20250315    gcc-14.2.0
sh                    randconfig-002-20250314    gcc-14.2.0
sh                    randconfig-002-20250315    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7724_defconfig    clang-21
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    clang-21
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                            shmin_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250314    gcc-14.2.0
sparc                 randconfig-001-20250315    gcc-14.2.0
sparc                 randconfig-002-20250314    gcc-14.2.0
sparc                 randconfig-002-20250315    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250314    gcc-14.2.0
sparc64               randconfig-001-20250315    gcc-14.2.0
sparc64               randconfig-002-20250314    gcc-14.2.0
sparc64               randconfig-002-20250315    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250314    gcc-12
um                    randconfig-001-20250315    gcc-14.2.0
um                    randconfig-002-20250314    gcc-12
um                    randconfig-002-20250315    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250314    clang-19
x86_64      buildonly-randconfig-001-20250315    clang-19
x86_64      buildonly-randconfig-002-20250314    clang-19
x86_64      buildonly-randconfig-002-20250315    clang-19
x86_64      buildonly-randconfig-003-20250314    gcc-12
x86_64      buildonly-randconfig-003-20250315    clang-19
x86_64      buildonly-randconfig-004-20250314    clang-19
x86_64      buildonly-randconfig-004-20250315    clang-19
x86_64      buildonly-randconfig-005-20250314    gcc-12
x86_64      buildonly-randconfig-005-20250315    clang-19
x86_64      buildonly-randconfig-006-20250314    gcc-12
x86_64      buildonly-randconfig-006-20250315    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250315    clang-19
x86_64                randconfig-002-20250315    clang-19
x86_64                randconfig-003-20250315    clang-19
x86_64                randconfig-004-20250315    clang-19
x86_64                randconfig-005-20250315    clang-19
x86_64                randconfig-006-20250315    clang-19
x86_64                randconfig-007-20250315    clang-19
x86_64                randconfig-008-20250315    clang-19
x86_64                randconfig-071-20250315    clang-19
x86_64                randconfig-072-20250315    clang-19
x86_64                randconfig-073-20250315    clang-19
x86_64                randconfig-074-20250315    clang-19
x86_64                randconfig-075-20250315    clang-19
x86_64                randconfig-076-20250315    clang-19
x86_64                randconfig-077-20250315    clang-19
x86_64                randconfig-078-20250315    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250314    gcc-14.2.0
xtensa                randconfig-001-20250315    gcc-14.2.0
xtensa                randconfig-002-20250314    gcc-14.2.0
xtensa                randconfig-002-20250315    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

