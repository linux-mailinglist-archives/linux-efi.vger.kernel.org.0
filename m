Return-Path: <linux-efi+bounces-1084-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E604F8CE05D
	for <lists+linux-efi@lfdr.de>; Fri, 24 May 2024 06:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDB31C20C14
	for <lists+linux-efi@lfdr.de>; Fri, 24 May 2024 04:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C241DFC6;
	Fri, 24 May 2024 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOjEWnRN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874215A5
	for <linux-efi@vger.kernel.org>; Fri, 24 May 2024 04:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716525151; cv=none; b=ZmaNBPMHcJn7rPMePrEwArCP9TmKjl/vBkXzm3fJvyW0XJ7LKICWSS7cIyoRvFmMg5wjJy4VJxOLYx9undc4UCkhA8HAWZVtKorumQWVYDUY10dLwsN1KzYgzOtwqFVSLQp0pE+/wocO8ovAiZtyS7170WNMx3b5fA7UYmn8OiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716525151; c=relaxed/simple;
	bh=RrAlblPhSWmfuknmfsyR31YJjcX77jgjpq3weUKXiP8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XqUko2yRUm77AJbZrHPak16YaaPA3YF4iHPLoGI0ye8hBX+TmeZp2sS71DhnT46WVJ5sXb045jcwEpS5AAbdGu3vn9QnQZNPiWBOyuoMoYQuDChjd+N/QRQfvF99qep9s9O8J8rltOiDHaELUEFQYBaH1JGNQcCLK7wcbP3BLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOjEWnRN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716525149; x=1748061149;
  h=date:from:to:cc:subject:message-id;
  bh=RrAlblPhSWmfuknmfsyR31YJjcX77jgjpq3weUKXiP8=;
  b=DOjEWnRNmIqaALHomew6JbPuSUmBqLfi8Aw9eRKAifP4hHpIuC3+Xp8B
   vnWfhs2IfxjvKw2B9yypBrVhwRRNBhJVwUNpMJkS5x5fNjmplsgCzvhIB
   PYf3y1w9ECxgNEANKweiUW0LiLYz4KXsqC1kE53S+l84rbF08VTO8XEHs
   SJbjRzJk9ELeKa9Moeaz2ghbe5b5LSwkXYq+x4QeqNyKPfxSZsuAMeZip
   Te+h1Umy2CK8GXx3WzZeWEhR2Ai7mbOHm+f7/HmJzc87DJk44t0KBxpCu
   Gu8vCGCaj8O+zYvGPUPjcF7OXg3raiJrNTtqwvpcg+L6AvA9uWGz6UBpY
   A==;
X-CSE-ConnectionGUID: uFJk5zIoRFiNC+ezeXb9pA==
X-CSE-MsgGUID: fsBFhZndRlCztaNBKFRWdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="13073966"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="13073966"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 21:32:29 -0700
X-CSE-ConnectionGUID: LCV/O54qS9aHnhpBlrkI8Q==
X-CSE-MsgGUID: 7INljgLEQHizxrrUHZNbew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="34500260"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 May 2024 21:32:27 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAMbR-0003rB-0x;
	Fri, 24 May 2024 04:32:25 +0000
Date: Fri, 24 May 2024 12:32:11 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 7c23b186ab892088f76a3ad9dbff1685ffe2e832
Message-ID: <202405241209.PQbk8PiZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 7c23b186ab892088f76a3ad9dbff1685ffe2e832  efi: pstore: Return proper errors on UEFI failures

elapsed time: 1259m

configs tested: 152
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240524   gcc  
arc                   randconfig-002-20240524   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240524   clang
arm                   randconfig-002-20240524   gcc  
arm                   randconfig-003-20240524   gcc  
arm                   randconfig-004-20240524   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240524   clang
arm64                 randconfig-002-20240524   clang
arm64                 randconfig-003-20240524   gcc  
arm64                 randconfig-004-20240524   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240524   gcc  
csky                  randconfig-002-20240524   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240524   clang
hexagon               randconfig-002-20240524   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240523   clang
i386         buildonly-randconfig-002-20240523   gcc  
i386         buildonly-randconfig-003-20240523   clang
i386         buildonly-randconfig-004-20240523   clang
i386         buildonly-randconfig-005-20240523   clang
i386         buildonly-randconfig-006-20240523   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240523   gcc  
i386                  randconfig-002-20240523   clang
i386                  randconfig-003-20240523   clang
i386                  randconfig-004-20240523   clang
i386                  randconfig-005-20240523   gcc  
i386                  randconfig-006-20240523   clang
i386                  randconfig-011-20240523   gcc  
i386                  randconfig-012-20240523   clang
i386                  randconfig-013-20240523   clang
i386                  randconfig-014-20240523   gcc  
i386                  randconfig-015-20240523   gcc  
i386                  randconfig-016-20240523   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240524   gcc  
loongarch             randconfig-002-20240524   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240524   gcc  
nios2                 randconfig-002-20240524   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240524   gcc  
parisc                randconfig-002-20240524   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240524   gcc  
powerpc               randconfig-002-20240524   gcc  
powerpc               randconfig-003-20240524   clang
powerpc64             randconfig-001-20240524   gcc  
powerpc64             randconfig-002-20240524   gcc  
powerpc64             randconfig-003-20240524   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240524   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240524   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240524   gcc  
x86_64       buildonly-randconfig-002-20240524   gcc  
x86_64       buildonly-randconfig-003-20240524   clang
x86_64       buildonly-randconfig-004-20240524   gcc  
x86_64       buildonly-randconfig-005-20240524   gcc  
x86_64       buildonly-randconfig-006-20240524   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240524   gcc  
x86_64                randconfig-002-20240524   clang
x86_64                randconfig-003-20240524   clang
x86_64                randconfig-004-20240524   clang
x86_64                randconfig-005-20240524   clang
x86_64                randconfig-006-20240524   gcc  
x86_64                randconfig-011-20240524   gcc  
x86_64                randconfig-012-20240524   clang
x86_64                randconfig-013-20240524   clang
x86_64                randconfig-014-20240524   gcc  
x86_64                randconfig-015-20240524   gcc  
x86_64                randconfig-016-20240524   clang
x86_64                randconfig-071-20240524   gcc  
x86_64                randconfig-072-20240524   clang
x86_64                randconfig-073-20240524   gcc  
x86_64                randconfig-074-20240524   gcc  
x86_64                randconfig-075-20240524   clang
x86_64                randconfig-076-20240524   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

