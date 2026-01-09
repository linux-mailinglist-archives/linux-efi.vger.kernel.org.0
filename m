Return-Path: <linux-efi+bounces-5983-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B67D5D0ADE1
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AA05305F521
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3E0305048;
	Fri,  9 Jan 2026 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoYgW6Hn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED535E551
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972206; cv=none; b=OR0vPmDvs3U4CwFpZ0R3QumIaq+lYdcB4c6m0uqUnEqOPpCnLZYIzQxkW/JGYhQ9dL93LT48e+lN7jzdnR4zhqqp2ToOz9OYspSGgaHpar09iH3tgeZV548h2p9pflHamAyFdWcDPp3Wgd0WiYvzXChJcG1DcL8l3tD5lL+pM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972206; c=relaxed/simple;
	bh=PII7m1s8iqah/h2ir4ketJP0H8wL2pEm0gwrGl8hVjM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XtUTBZ8ttYvUHqt+ERK1jNmJ32E++O3P/tMQPk5TJLTb9y62TCDWTN62wlsuAtw8BIr95/YTwncQTov/1GOkXLsjgJXNQeY/4fHKq+T+G3pvs2IvCwnKdcfCgcYKgUXOtcuDyie726lP5b/8xjtwJB2XWdvHPxFDJ8GCVLrrlRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoYgW6Hn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767972205; x=1799508205;
  h=date:from:to:cc:subject:message-id;
  bh=PII7m1s8iqah/h2ir4ketJP0H8wL2pEm0gwrGl8hVjM=;
  b=CoYgW6HngQj6KNtOmHbq5KbMrmiRaMYRXTiExr/0NtQ92kDQbQiLIsMA
   8aIkELbg72T9oeF2+HAgHeCBTwuNAhPvd2JUja8OohiT315AwrKIdOQTd
   XNcOcydaWD7/ExQLqHmyzMk3kilAt6Yh1gL4JlqT4SqmDqLj2U13BNX7M
   F3A1rTVTy95baplWl5YYIiHmwgyHAJ5crJGQ4M7CAL05RiJCvSDGEsqMi
   HERP+o7YwnbkFcJwwum66f/NLKanC7vAAs+H0Yg0gzak+t8N55xebiS53
   QBf65NllFUxejheKoE5u4C/n8qKwt8muTBpp3cJn8/a4jH8TkPL9MVlxX
   Q==;
X-CSE-ConnectionGUID: eX9Is+OcQGaKPgyWDHOuew==
X-CSE-MsgGUID: dhsTDYnrR+q2uTUZXRsOEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="73212006"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="73212006"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 07:23:24 -0800
X-CSE-ConnectionGUID: 2Xn0viNQQTm0UHrwSTp1kw==
X-CSE-MsgGUID: /Bdl155CTqSUJi0LZQ9BEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="241005745"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Jan 2026 07:23:23 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1veEKe-000000007RE-1lEd;
	Fri, 09 Jan 2026 15:23:20 +0000
Date: Fri, 09 Jan 2026 23:23:16 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 85829b80ca29d3ac6c1770dbe12306a1d960a8ac
Message-ID: <202601092310.YB7DETSl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 85829b80ca29d3ac6c1770dbe12306a1d960a8ac  MAINTAINERS: add cper to APEI files

elapsed time: 1582m

configs tested: 214
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260109    gcc-13.4.0
arc                   randconfig-002-20260109    gcc-13.4.0
arc                   randconfig-002-20260109    gcc-9.5.0
arm                               allnoconfig    gcc-15.2.0
arm                       aspeed_g4_defconfig    clang-22
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    clang-22
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20260109    gcc-10.5.0
arm                   randconfig-001-20260109    gcc-13.4.0
arm                   randconfig-002-20260109    gcc-13.4.0
arm                   randconfig-002-20260109    gcc-15.1.0
arm                   randconfig-003-20260109    gcc-13.4.0
arm                   randconfig-003-20260109    gcc-8.5.0
arm                   randconfig-004-20260109    gcc-11.5.0
arm                   randconfig-004-20260109    gcc-13.4.0
arm                           spitz_defconfig    clang-22
arm                        vexpress_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260109    clang-22
arm64                 randconfig-001-20260109    gcc-8.5.0
arm64                 randconfig-002-20260109    clang-22
arm64                 randconfig-002-20260109    gcc-8.5.0
arm64                 randconfig-003-20260109    gcc-11.5.0
arm64                 randconfig-003-20260109    gcc-8.5.0
arm64                 randconfig-004-20260109    gcc-8.5.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.1.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260109    gcc-8.5.0
csky                  randconfig-001-20260109    gcc-9.5.0
csky                  randconfig-002-20260109    gcc-15.1.0
csky                  randconfig-002-20260109    gcc-8.5.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260109    clang-22
hexagon               randconfig-001-20260109    gcc-8.5.0
hexagon               randconfig-002-20260109    clang-17
hexagon               randconfig-002-20260109    gcc-8.5.0
i386                              allnoconfig    gcc-15.2.0
i386        buildonly-randconfig-001-20260109    clang-20
i386        buildonly-randconfig-002-20260109    clang-20
i386        buildonly-randconfig-002-20260109    gcc-14
i386        buildonly-randconfig-003-20260109    clang-20
i386        buildonly-randconfig-003-20260109    gcc-14
i386        buildonly-randconfig-004-20260109    clang-20
i386        buildonly-randconfig-005-20260109    clang-20
i386        buildonly-randconfig-005-20260109    gcc-12
i386        buildonly-randconfig-006-20260109    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260109    gcc-14
i386                  randconfig-002-20260109    gcc-14
i386                  randconfig-003-20260109    gcc-12
i386                  randconfig-003-20260109    gcc-14
i386                  randconfig-004-20260109    gcc-14
i386                  randconfig-005-20260109    gcc-14
i386                  randconfig-006-20260109    clang-20
i386                  randconfig-006-20260109    gcc-14
i386                  randconfig-007-20260109    gcc-14
i386                  randconfig-011-20260109    clang-20
i386                  randconfig-012-20260109    clang-20
i386                  randconfig-012-20260109    gcc-14
i386                  randconfig-013-20260109    clang-20
i386                  randconfig-014-20260109    clang-20
i386                  randconfig-014-20260109    gcc-14
i386                  randconfig-015-20260109    clang-20
i386                  randconfig-016-20260109    clang-20
i386                  randconfig-017-20260109    clang-20
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260109    clang-22
loongarch             randconfig-001-20260109    gcc-8.5.0
loongarch             randconfig-002-20260109    gcc-15.1.0
loongarch             randconfig-002-20260109    gcc-8.5.0
m68k                              allnoconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                           sun3_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.2.0
mips                     decstation_defconfig    clang-22
mips                      malta_kvm_defconfig    gcc-15.1.0
mips                       rbtx49xx_defconfig    gcc-15.1.0
mips                        vocore2_defconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260109    gcc-8.5.0
nios2                 randconfig-002-20260109    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260109    gcc-12.5.0
parisc                randconfig-001-20260109    gcc-8.5.0
parisc                randconfig-002-20260109    gcc-15.1.0
parisc                randconfig-002-20260109    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                    adder875_defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20260109    clang-22
powerpc               randconfig-001-20260109    gcc-8.5.0
powerpc               randconfig-002-20260109    clang-22
powerpc               randconfig-002-20260109    gcc-8.5.0
powerpc                      tqm8xx_defconfig    clang-22
powerpc64             randconfig-001-20260109    gcc-15.1.0
powerpc64             randconfig-001-20260109    gcc-8.5.0
powerpc64             randconfig-002-20260109    gcc-8.5.0
riscv                             allnoconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260109    clang-22
riscv                 randconfig-001-20260109    gcc-14.3.0
riscv                 randconfig-002-20260109    clang-22
riscv                 randconfig-002-20260109    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260109    clang-22
s390                  randconfig-002-20260109    clang-22
s390                       zfcpdump_defconfig    clang-22
sh                                allnoconfig    clang-22
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                        dreamcast_defconfig    clang-22
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20260109    clang-22
sh                    randconfig-001-20260109    gcc-14.3.0
sh                    randconfig-002-20260109    clang-22
sh                    randconfig-002-20260109    gcc-13.4.0
sh                           se7712_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260109    gcc-14.3.0
sparc                 randconfig-001-20260109    gcc-8.5.0
sparc                 randconfig-002-20260109    gcc-13.4.0
sparc                 randconfig-002-20260109    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260109    gcc-14.3.0
sparc64               randconfig-001-20260109    gcc-8.5.0
sparc64               randconfig-002-20260109    clang-20
sparc64               randconfig-002-20260109    gcc-14.3.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260109    gcc-14
um                    randconfig-001-20260109    gcc-14.3.0
um                    randconfig-002-20260109    gcc-14
um                    randconfig-002-20260109    gcc-14.3.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20260109    clang-20
x86_64      buildonly-randconfig-001-20260109    gcc-14
x86_64      buildonly-randconfig-002-20260109    gcc-14
x86_64      buildonly-randconfig-003-20260109    gcc-14
x86_64      buildonly-randconfig-004-20260109    gcc-14
x86_64      buildonly-randconfig-005-20260109    gcc-14
x86_64      buildonly-randconfig-006-20260109    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260109    clang-20
x86_64                randconfig-001-20260109    gcc-14
x86_64                randconfig-002-20260109    clang-20
x86_64                randconfig-002-20260109    gcc-14
x86_64                randconfig-003-20260109    gcc-14
x86_64                randconfig-004-20260109    clang-20
x86_64                randconfig-004-20260109    gcc-14
x86_64                randconfig-005-20260109    clang-20
x86_64                randconfig-005-20260109    gcc-14
x86_64                randconfig-006-20260109    gcc-14
x86_64                randconfig-011-20260109    gcc-12
x86_64                randconfig-011-20260109    gcc-14
x86_64                randconfig-012-20260109    clang-20
x86_64                randconfig-012-20260109    gcc-14
x86_64                randconfig-013-20260109    gcc-14
x86_64                randconfig-014-20260109    gcc-14
x86_64                randconfig-015-20260109    gcc-12
x86_64                randconfig-015-20260109    gcc-14
x86_64                randconfig-016-20260109    gcc-14
x86_64                randconfig-071-20260109    clang-20
x86_64                randconfig-071-20260109    gcc-14
x86_64                randconfig-072-20260109    clang-20
x86_64                randconfig-073-20260109    clang-20
x86_64                randconfig-073-20260109    gcc-14
x86_64                randconfig-074-20260109    clang-20
x86_64                randconfig-074-20260109    gcc-14
x86_64                randconfig-075-20260109    clang-20
x86_64                randconfig-075-20260109    gcc-14
x86_64                randconfig-076-20260109    clang-20
x86_64                randconfig-076-20260109    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
xtensa                            allnoconfig    clang-22
xtensa                randconfig-001-20260109    gcc-12.5.0
xtensa                randconfig-001-20260109    gcc-14.3.0
xtensa                randconfig-002-20260109    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

