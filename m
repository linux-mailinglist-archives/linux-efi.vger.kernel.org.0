Return-Path: <linux-efi+bounces-5923-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F59CDE047
	for <lists+linux-efi@lfdr.de>; Thu, 25 Dec 2025 19:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E0363004F1F
	for <lists+linux-efi@lfdr.de>; Thu, 25 Dec 2025 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272C5185E4A;
	Thu, 25 Dec 2025 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkLADLeb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1624B652
	for <linux-efi@vger.kernel.org>; Thu, 25 Dec 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766686211; cv=none; b=YNQYj2bQYfObsD8K/1L/fgRXXPkmxeF/eMcBaSccnZln4IWvPtGSjrTePrwB9dVzF6kolKfAM6LN5HDx6EfEmHqqCFBXeUX+7YWbVs25oaQHluXIQrzYUwP8a8FOZ2sE+r3VfYRNMVJCsNhpFO/59/lqjxOz7TjSuJfgGRfUKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766686211; c=relaxed/simple;
	bh=ao4ewOlssSnKFeu7pbpByoNvphk/LAyvjMACRKTEBuE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nCeFPSLYJUzhFXIQmaqNDDwR64qoBDjpyJyD1cpfPyiGGag5/Mt8i0ICcUw0O6Ida6HBGCIp8OIOrVYR8UDoFQXV6lBGrwHbLjHmMYsVIhtQxgMDmEFe+c+Kd4/Yb56+wMAkYGsUw+5EZ4EDEAZEAmPx4aggu5/FovZjYf5Bbqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkLADLeb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766686209; x=1798222209;
  h=date:from:to:cc:subject:message-id;
  bh=ao4ewOlssSnKFeu7pbpByoNvphk/LAyvjMACRKTEBuE=;
  b=MkLADLeb0ggb9o/zc7V1nREOGhG99XMQMyY5Mm+OPt9F1A4LYLv+co0o
   YmwyfJxHUo73CJz7eQc61McZ/Bk3bBmOoRybtu2HpT+k1uJAyb600BBBx
   S2VLMtu+PFNpXDkpPbNBbLyucQGsBnZQxsWI3CnlNJHqT0L7BK1eTD8RX
   jxy8ZmU9/S3fgz56TtinTv9ObC5lXNcmf9sVuKS6vt3U0rdch4Yo3+gLt
   1Y0Tq6lKEKQ3arnbZQAskQQLu6IDO+jq8AnQ7rwHSmSWuPIJRKEFhDbVI
   p4hJhWznb6TkTdHXU8dRvfN2S8OJ9mGJB0qs+a+rU13pl1tDN3MhSbBFK
   g==;
X-CSE-ConnectionGUID: NTHiwn7iToS6hlV89QcJZA==
X-CSE-MsgGUID: wNy7H3TQQ0OMEv2632JC0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="68551665"
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; 
   d="scan'208";a="68551665"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2025 10:10:08 -0800
X-CSE-ConnectionGUID: PnOI2eKcQr+fqjFPiWWW7Q==
X-CSE-MsgGUID: b97s8i2ORNmq4I2PWbOr9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; 
   d="scan'208";a="200737789"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 25 Dec 2025 10:10:07 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYpmY-000000004MJ-1GJF;
	Thu, 25 Dec 2025 18:10:02 +0000
Date: Fri, 26 Dec 2025 02:08:45 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 cfe54f4591e675cedf2c0d25287ff4c0a2e0cb9d
Message-ID: <202512260240.HuxYWZXb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: cfe54f4591e675cedf2c0d25287ff4c0a2e0cb9d  kthread: Warn if mm_struct lacks user_ns in kthread_use_mm()

elapsed time: 1285m

configs tested: 247
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251225    gcc-11.5.0
arc                   randconfig-002-20251225    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251225    clang-22
arm                   randconfig-001-20251225    gcc-11.5.0
arm                   randconfig-002-20251225    gcc-11.5.0
arm                   randconfig-002-20251225    gcc-12.5.0
arm                   randconfig-003-20251225    clang-22
arm                   randconfig-003-20251225    gcc-11.5.0
arm                   randconfig-004-20251225    clang-22
arm                   randconfig-004-20251225    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251225    clang-18
arm64                 randconfig-002-20251225    gcc-12.5.0
arm64                 randconfig-003-20251225    clang-22
arm64                 randconfig-004-20251225    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251225    gcc-15.1.0
csky                  randconfig-002-20251225    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251225    clang-22
hexagon               randconfig-002-20251225    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251225    clang-20
i386        buildonly-randconfig-002-20251225    clang-20
i386        buildonly-randconfig-003-20251225    clang-20
i386        buildonly-randconfig-003-20251225    gcc-14
i386        buildonly-randconfig-004-20251225    clang-20
i386        buildonly-randconfig-005-20251225    clang-20
i386        buildonly-randconfig-006-20251225    clang-20
i386        buildonly-randconfig-006-20251225    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251225    clang-20
i386                  randconfig-001-20251225    gcc-14
i386                  randconfig-002-20251225    clang-20
i386                  randconfig-003-20251225    clang-20
i386                  randconfig-004-20251225    clang-20
i386                  randconfig-005-20251225    clang-20
i386                  randconfig-006-20251225    clang-20
i386                  randconfig-007-20251225    clang-20
i386                  randconfig-011-20251225    clang-20
i386                  randconfig-011-20251225    gcc-14
i386                  randconfig-012-20251225    gcc-14
i386                  randconfig-013-20251225    gcc-14
i386                  randconfig-014-20251225    clang-20
i386                  randconfig-014-20251225    gcc-14
i386                  randconfig-015-20251225    gcc-14
i386                  randconfig-016-20251225    clang-20
i386                  randconfig-016-20251225    gcc-14
i386                  randconfig-017-20251225    clang-20
i386                  randconfig-017-20251225    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251225    clang-22
loongarch             randconfig-002-20251225    clang-22
loongarch             randconfig-002-20251225    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251225    clang-22
nios2                 randconfig-001-20251225    gcc-9.5.0
nios2                 randconfig-002-20251225    clang-22
nios2                 randconfig-002-20251225    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251225    clang-22
parisc                randconfig-001-20251225    gcc-12.5.0
parisc                randconfig-002-20251225    clang-22
parisc                randconfig-002-20251225    gcc-14.3.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20251225    clang-22
powerpc               randconfig-002-20251225    clang-22
powerpc                     redwood_defconfig    clang-22
powerpc64             randconfig-001-20251225    clang-22
powerpc64             randconfig-001-20251225    gcc-8.5.0
powerpc64             randconfig-002-20251225    clang-22
powerpc64             randconfig-002-20251225    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251225    clang-22
riscv                 randconfig-002-20251225    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251225    gcc-14.3.0
s390                  randconfig-002-20251225    clang-19
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                    randconfig-001-20251225    gcc-15.1.0
sh                    randconfig-002-20251225    gcc-9.5.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251225    gcc-13
sparc                 randconfig-001-20251225    gcc-8.5.0
sparc                 randconfig-002-20251225    gcc-13
sparc                 randconfig-002-20251225    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251225    gcc-13
sparc64               randconfig-001-20251225    gcc-9.5.0
sparc64               randconfig-002-20251225    clang-20
sparc64               randconfig-002-20251225    gcc-13
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251225    gcc-13
um                    randconfig-002-20251225    gcc-13
um                    randconfig-002-20251225    gcc-14
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251225    clang-20
x86_64      buildonly-randconfig-001-20251225    gcc-14
x86_64      buildonly-randconfig-002-20251225    clang-20
x86_64      buildonly-randconfig-002-20251225    gcc-14
x86_64      buildonly-randconfig-003-20251225    gcc-14
x86_64      buildonly-randconfig-004-20251225    clang-20
x86_64      buildonly-randconfig-004-20251225    gcc-14
x86_64      buildonly-randconfig-005-20251225    gcc-14
x86_64      buildonly-randconfig-006-20251225    clang-20
x86_64      buildonly-randconfig-006-20251225    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251225    clang-20
x86_64                randconfig-001-20251225    gcc-12
x86_64                randconfig-002-20251225    clang-20
x86_64                randconfig-003-20251225    clang-20
x86_64                randconfig-003-20251225    gcc-12
x86_64                randconfig-004-20251225    clang-20
x86_64                randconfig-005-20251225    clang-20
x86_64                randconfig-005-20251225    gcc-14
x86_64                randconfig-006-20251225    clang-20
x86_64                randconfig-006-20251225    gcc-14
x86_64                randconfig-011-20251225    gcc-13
x86_64                randconfig-012-20251225    gcc-14
x86_64                randconfig-013-20251225    clang-20
x86_64                randconfig-014-20251225    clang-20
x86_64                randconfig-015-20251225    gcc-14
x86_64                randconfig-016-20251225    clang-20
x86_64                randconfig-071-20251225    clang-20
x86_64                randconfig-072-20251225    clang-20
x86_64                randconfig-073-20251225    clang-20
x86_64                randconfig-073-20251225    gcc-14
x86_64                randconfig-074-20251225    clang-20
x86_64                randconfig-075-20251225    clang-20
x86_64                randconfig-075-20251225    gcc-14
x86_64                randconfig-076-20251225    clang-20
x86_64                randconfig-076-20251225    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251225    gcc-13
xtensa                randconfig-001-20251225    gcc-8.5.0
xtensa                randconfig-002-20251225    gcc-10.5.0
xtensa                randconfig-002-20251225    gcc-13

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

