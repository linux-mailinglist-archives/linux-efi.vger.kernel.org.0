Return-Path: <linux-efi+bounces-3652-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A988AAB2384
	for <lists+linux-efi@lfdr.de>; Sat, 10 May 2025 13:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F183A321A
	for <lists+linux-efi@lfdr.de>; Sat, 10 May 2025 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C62550BC;
	Sat, 10 May 2025 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRSI6rMI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB4259C
	for <linux-efi@vger.kernel.org>; Sat, 10 May 2025 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746875171; cv=none; b=PkdCmHuNKYB7dkvcxvq70yP42Ltxj9MtLCzsJQxRyIdVLMW8BP4F7MLKM/7oIBAQ4WSh2XR6V6OjYr868Uh8yiBalNJbCl1BGTtZWfN8FmuSPHyhI1hwcGWvBp7pYPjMP0fQneLTaBRByg5YRZRXupczl4rnzwkkWi/OmY0moWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746875171; c=relaxed/simple;
	bh=SvwKlc3CeJgeuBkqU9pWSSidfRI4JBqMrPzMsdZEr1Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sNYB0wcPr3vnzcDZcHl0UaIsi1PO4FVWmhvhYoDCVCu7IpYXuxiOtF3tGgLFdJ8r7SXI/1qwI+r72+bwisGbzyz9KVeI0wmXg1HdZKNbZqlZnBbhX/v9OXLfgcsxau5uoDG9v5GGM3PiDZ4haxe+m+c05V68H/tgqwO366S+iO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRSI6rMI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746875168; x=1778411168;
  h=date:from:to:cc:subject:message-id;
  bh=SvwKlc3CeJgeuBkqU9pWSSidfRI4JBqMrPzMsdZEr1Y=;
  b=eRSI6rMIC48dCCktr1DEzR8WB0/kM9cvj1UH0lYLvgemNQCd3Xd0zsu8
   PE4P7cVIjByHeIE3CrKExoeHmt3K3sdzmZghqXso5HzmWlHXDVciCjID4
   r9BTgOoOXc9uZ4wsWDS8Om9jhU+QIeIklX1ZiZBEzMXpFY8Hpo8QZbEJA
   7Kr7CCJ4ednlyowyiC3msg56nUGtCOVHKrPpIg4UVubfdvpes0xpfUKzK
   8uBy9LZrfMCe8BxIhupO1vQ6lpwcDkfYJsb3p+LJBN/BsJKJ+ezO71twi
   33XZX49U9Ez5oM6HBH6QmBbIyO+8aCjm0I86jvuVQ507AGnPCiH5Q3YFK
   w==;
X-CSE-ConnectionGUID: u8ie5NHUR5GprC4mc+t9xA==
X-CSE-MsgGUID: TNLGOHm3Q4KCGlM8O3Hw4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48607632"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="48607632"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 04:06:07 -0700
X-CSE-ConnectionGUID: 6sF9FyAKRJax7rEK5eiQ2A==
X-CSE-MsgGUID: bIe6fPwvS5WwzDz7IHZQoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="141628676"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 May 2025 04:06:06 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDi1s-000D1R-0u;
	Sat, 10 May 2025 11:06:04 +0000
Date: Sat, 10 May 2025 19:05:34 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 c8e1927e7f7d63721e32ec41d27ccb0eb1a1b0fc
Message-ID: <202505101924.aRyz95Bj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: c8e1927e7f7d63721e32ec41d27ccb0eb1a1b0fc  efi/libstub: Describe missing 'out' parameter in efi_load_initrd

elapsed time: 1444m

configs tested: 264
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250509    gcc-13.3.0
arc                   randconfig-001-20250510    gcc-8.5.0
arc                   randconfig-002-20250509    gcc-13.3.0
arc                   randconfig-002-20250510    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                      footbridge_defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    gcc-14.2.0
arm                        keystone_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-21
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250509    gcc-7.5.0
arm                   randconfig-001-20250510    gcc-8.5.0
arm                   randconfig-002-20250509    gcc-6.5.0
arm                   randconfig-002-20250510    gcc-8.5.0
arm                   randconfig-003-20250509    gcc-10.5.0
arm                   randconfig-003-20250510    gcc-8.5.0
arm                   randconfig-004-20250509    clang-21
arm                   randconfig-004-20250510    gcc-8.5.0
arm                           sunxi_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250509    gcc-7.5.0
arm64                 randconfig-001-20250510    gcc-8.5.0
arm64                 randconfig-002-20250509    gcc-7.5.0
arm64                 randconfig-002-20250510    gcc-8.5.0
arm64                 randconfig-003-20250509    clang-21
arm64                 randconfig-003-20250510    gcc-8.5.0
arm64                 randconfig-004-20250509    gcc-5.5.0
arm64                 randconfig-004-20250510    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250509    gcc-14.2.0
csky                  randconfig-001-20250510    clang-18
csky                  randconfig-002-20250509    gcc-13.3.0
csky                  randconfig-002-20250510    clang-18
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250509    clang-20
hexagon               randconfig-001-20250510    clang-18
hexagon               randconfig-002-20250509    clang-21
hexagon               randconfig-002-20250510    clang-18
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250509    gcc-11
i386        buildonly-randconfig-001-20250510    gcc-12
i386        buildonly-randconfig-002-20250509    gcc-12
i386        buildonly-randconfig-002-20250510    gcc-12
i386        buildonly-randconfig-003-20250509    clang-20
i386        buildonly-randconfig-003-20250510    gcc-12
i386        buildonly-randconfig-004-20250509    clang-20
i386        buildonly-randconfig-004-20250510    gcc-12
i386        buildonly-randconfig-005-20250509    gcc-12
i386        buildonly-randconfig-005-20250510    gcc-12
i386        buildonly-randconfig-006-20250509    gcc-11
i386        buildonly-randconfig-006-20250510    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250510    gcc-12
i386                  randconfig-002-20250510    gcc-12
i386                  randconfig-003-20250510    gcc-12
i386                  randconfig-004-20250510    gcc-12
i386                  randconfig-005-20250510    gcc-12
i386                  randconfig-006-20250510    gcc-12
i386                  randconfig-007-20250510    gcc-12
i386                  randconfig-011-20250510    clang-20
i386                  randconfig-012-20250510    clang-20
i386                  randconfig-013-20250510    clang-20
i386                  randconfig-014-20250510    clang-20
i386                  randconfig-015-20250510    clang-20
i386                  randconfig-016-20250510    clang-20
i386                  randconfig-017-20250510    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250509    gcc-13.3.0
loongarch             randconfig-001-20250510    clang-18
loongarch             randconfig-002-20250509    gcc-14.2.0
loongarch             randconfig-002-20250510    clang-18
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           mtx1_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250509    gcc-13.3.0
nios2                 randconfig-001-20250510    clang-18
nios2                 randconfig-002-20250509    gcc-13.3.0
nios2                 randconfig-002-20250510    clang-18
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250509    gcc-6.5.0
parisc                randconfig-001-20250510    clang-18
parisc                randconfig-002-20250509    gcc-14.2.0
parisc                randconfig-002-20250510    clang-18
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-21
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    clang-21
powerpc               randconfig-001-20250509    clang-16
powerpc               randconfig-001-20250510    clang-18
powerpc               randconfig-002-20250509    gcc-5.5.0
powerpc               randconfig-002-20250510    clang-18
powerpc               randconfig-003-20250509    gcc-7.5.0
powerpc               randconfig-003-20250510    clang-18
powerpc                     taishan_defconfig    gcc-14.2.0
powerpc                     tqm8555_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250509    gcc-7.5.0
powerpc64             randconfig-001-20250510    clang-18
powerpc64             randconfig-002-20250509    clang-21
powerpc64             randconfig-002-20250510    clang-18
powerpc64             randconfig-003-20250509    gcc-10.5.0
powerpc64             randconfig-003-20250510    clang-18
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250509    clang-21
riscv                 randconfig-001-20250510    clang-21
riscv                 randconfig-002-20250509    clang-21
riscv                 randconfig-002-20250510    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250509    clang-21
s390                  randconfig-001-20250510    clang-21
s390                  randconfig-002-20250509    clang-17
s390                  randconfig-002-20250510    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    clang-21
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                             espt_defconfig    clang-21
sh                            hp6xx_defconfig    gcc-14.2.0
sh                            migor_defconfig    clang-21
sh                    randconfig-001-20250509    gcc-9.3.0
sh                    randconfig-001-20250510    clang-21
sh                    randconfig-002-20250509    gcc-5.5.0
sh                    randconfig-002-20250510    clang-21
sh                             shx3_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250509    gcc-6.5.0
sparc                 randconfig-001-20250510    clang-21
sparc                 randconfig-002-20250509    gcc-6.5.0
sparc                 randconfig-002-20250510    clang-21
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250509    gcc-10.5.0
sparc64               randconfig-001-20250510    clang-21
sparc64               randconfig-002-20250509    gcc-6.5.0
sparc64               randconfig-002-20250510    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250509    clang-21
um                    randconfig-001-20250510    clang-21
um                    randconfig-002-20250509    gcc-12
um                    randconfig-002-20250510    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250509    gcc-11
x86_64      buildonly-randconfig-001-20250510    clang-20
x86_64      buildonly-randconfig-002-20250509    gcc-11
x86_64      buildonly-randconfig-002-20250510    clang-20
x86_64      buildonly-randconfig-003-20250509    clang-20
x86_64      buildonly-randconfig-003-20250510    clang-20
x86_64      buildonly-randconfig-004-20250509    clang-20
x86_64      buildonly-randconfig-004-20250510    clang-20
x86_64      buildonly-randconfig-005-20250509    gcc-12
x86_64      buildonly-randconfig-005-20250510    clang-20
x86_64      buildonly-randconfig-006-20250509    gcc-12
x86_64      buildonly-randconfig-006-20250510    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250510    clang-20
x86_64                randconfig-002-20250510    clang-20
x86_64                randconfig-003-20250510    clang-20
x86_64                randconfig-004-20250510    clang-20
x86_64                randconfig-005-20250510    clang-20
x86_64                randconfig-006-20250510    clang-20
x86_64                randconfig-007-20250510    clang-20
x86_64                randconfig-008-20250510    clang-20
x86_64                randconfig-071-20250510    gcc-11
x86_64                randconfig-072-20250510    gcc-11
x86_64                randconfig-073-20250510    gcc-11
x86_64                randconfig-074-20250510    gcc-11
x86_64                randconfig-075-20250510    gcc-11
x86_64                randconfig-076-20250510    gcc-11
x86_64                randconfig-077-20250510    gcc-11
x86_64                randconfig-078-20250510    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250509    gcc-12.4.0
xtensa                randconfig-001-20250510    clang-21
xtensa                randconfig-002-20250509    gcc-14.2.0
xtensa                randconfig-002-20250510    clang-21
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

