Return-Path: <linux-efi+bounces-2971-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445E6A5CD75
	for <lists+linux-efi@lfdr.de>; Tue, 11 Mar 2025 19:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65A0163706
	for <lists+linux-efi@lfdr.de>; Tue, 11 Mar 2025 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90AB262D0D;
	Tue, 11 Mar 2025 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNBVNpeg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4B2638AA
	for <linux-efi@vger.kernel.org>; Tue, 11 Mar 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716792; cv=none; b=sy4LI3i/4mDZwaICIgWOqtwv+8iGH1Kjwz2d3G23Pj4W3+otLjjxWTkSKxV67C0R22BQtelA0w351xJ+MyHWg07J7SSqanqu+bCukGQIk/evfmWfbkfptUbSlkQjUoCWAJuJ+tMV6n3YuGq5X35WLbdB5ZRBjjk/AoqFS3B2KZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716792; c=relaxed/simple;
	bh=hey4qH1IwYDzJGcaVu2V39k9HslcWAmVUpt64Zagl5I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ku8B929puPrbuYg6uX6nNksMmiWLyywkOYmuHvAOGQ/7+gWpi0L0eWh92MLC+uD01BrWSvLK83oBAd6dbSjQ5BDm3Nm8Qik/KkzwYGhPNyrk5hDzBW01vcCytCYuPo8vBNdw/kC1kewOP5HhxSmV6RQdq7LxfrS3v6wgq6apjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNBVNpeg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741716790; x=1773252790;
  h=date:from:to:cc:subject:message-id;
  bh=hey4qH1IwYDzJGcaVu2V39k9HslcWAmVUpt64Zagl5I=;
  b=BNBVNpeg0yYwn97l7Mh2deuMRT7KyTfUpqNdjigOuLrss3jKr8o/4prS
   nzFbVWMUS4akLHZk7cEvMrERbx7rEUQUcsDK1DemnJYgPJSbHyRCel0tn
   ocap+burPJrOxFOmpN9a2JtzQLr6PgnjkMhCIMv54YvZt8S7JyXG2YAnY
   nF6CV7DgqRQ4VVPs+N24wSPBv6MAFcX98uNt9IsEy9buO0aNEGc2x5LKq
   k5KjlLZscIQuHFW63lCHiRw6tf2bypwcc/9cLCJi9wGvLG7oz0EcTf7W+
   6rRz0Nxa7/i5ebAX9HsWJ7M6kDOgPak7pSKm2Ks/Z0f+GlQb3yxQLmQXM
   A==;
X-CSE-ConnectionGUID: iK7VgmRtTtygjzfnD58frw==
X-CSE-MsgGUID: xB6+MPrWQki118tzHyjzjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46419187"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="46419187"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 11:13:09 -0700
X-CSE-ConnectionGUID: JQwlSVFfRtipv6rCuWASAQ==
X-CSE-MsgGUID: B8YPTEi8Rby0c8af0cpmAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="121292916"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 11 Mar 2025 11:13:09 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts463-0007ia-2e;
	Tue, 11 Mar 2025 18:12:59 +0000
Date: Wed, 12 Mar 2025 02:12:40 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 ac2efaa8455021ce1e6216457684d60a9e2c77fd
Message-ID: <202503120234.Nifa8zW6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: ac2efaa8455021ce1e6216457684d60a9e2c77fd  efi: efibc: change kmalloc(size * count, ...) to kmalloc_array()

elapsed time: 1462m

configs tested: 96
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250311    gcc-13.2.0
arc                   randconfig-002-20250311    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250311    gcc-14.2.0
arm                   randconfig-002-20250311    clang-16
arm                   randconfig-003-20250311    gcc-14.2.0
arm                   randconfig-004-20250311    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250311    gcc-14.2.0
arm64                 randconfig-002-20250311    gcc-14.2.0
arm64                 randconfig-003-20250311    gcc-14.2.0
arm64                 randconfig-004-20250311    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250311    gcc-14.2.0
csky                  randconfig-002-20250311    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250311    clang-21
hexagon               randconfig-002-20250311    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250311    gcc-12
i386        buildonly-randconfig-002-20250311    clang-19
i386        buildonly-randconfig-003-20250311    clang-19
i386        buildonly-randconfig-004-20250311    clang-19
i386        buildonly-randconfig-005-20250311    clang-19
i386        buildonly-randconfig-006-20250311    gcc-11
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250311    gcc-14.2.0
loongarch             randconfig-002-20250311    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250311    gcc-14.2.0
nios2                 randconfig-002-20250311    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250311    gcc-14.2.0
parisc                randconfig-002-20250311    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc64             randconfig-001-20250311    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250311    gcc-14.2.0
riscv                 randconfig-002-20250311    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250311    clang-15
s390                  randconfig-002-20250311    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250311    gcc-14.2.0
sh                    randconfig-002-20250311    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250311    gcc-14.2.0
sparc                 randconfig-002-20250311    gcc-14.2.0
sparc64               randconfig-001-20250311    gcc-14.2.0
sparc64               randconfig-002-20250311    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250311    gcc-12
um                    randconfig-002-20250311    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250311    gcc-12
x86_64      buildonly-randconfig-002-20250311    gcc-12
x86_64      buildonly-randconfig-003-20250311    clang-19
x86_64      buildonly-randconfig-004-20250311    clang-19
x86_64      buildonly-randconfig-005-20250311    gcc-12
x86_64      buildonly-randconfig-006-20250311    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250311    gcc-14.2.0
xtensa                randconfig-002-20250311    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

