Return-Path: <linux-efi+bounces-4871-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B027B88DBD
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 12:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E137A7C4D5E
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE75D2FB991;
	Fri, 19 Sep 2025 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnnXnIMR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B02FB969
	for <linux-efi@vger.kernel.org>; Fri, 19 Sep 2025 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277282; cv=none; b=bIHDPDSimpFBoSME6YnCjKSgrVqHCOf6QI5QycKffmR1qwXZooFYX6/V3K2EdesAff7ucb+itKOc5XpgPjm3+M0lYka/eoqF5/KAiM/P44qE4LDWcjs7hlkDNirO5sbKzItChyjMH93n+68f3lsj7THW9VBODDHq9e+0uX3MKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277282; c=relaxed/simple;
	bh=dmI07DP4EbS1uTnOp9CBFKoivuK//oSQOss2tXghRzc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Iw+mYLyJYzN/wGgD3j+YMtoNm3e1J9cpldRxtawZXCqYwz3ok9ggUKk+/3A6a7z+U+eVaU+dacgS6tQEop8JkHRIR6U1V/GkHapiPL8nx2n+fW6H8wjnX0XjAweGjToxoma320TevEG2xzJiUK7byno1MIIEfc+gloOT7aWn5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnnXnIMR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758277281; x=1789813281;
  h=date:from:to:cc:subject:message-id;
  bh=dmI07DP4EbS1uTnOp9CBFKoivuK//oSQOss2tXghRzc=;
  b=RnnXnIMREUIN6tZ6jHN3FckGuqaue2XP3hTLHYBaDmp/pFmbXwmsN2gU
   tNmPXJZyozrb9ZGFHzmWoZWSvsXbNOWLcsTbTTrjJ9vdUdbNK6ltMfD4u
   vNBa77/4f49bM5IvPHlLtwr2giO/tQL4eOnG49ZCyExkERyo6iegYx/rG
   h6udonAV8rjXHZHAnyIr2DgOmpARkcX53e+oKyTC8k2OlFIm/jYOTCGft
   58tYOfH3elwES4d4VqJngsIM+6q/oQTHtXxn5ZrWfHA6ysha7VsQIGJWp
   RRcPEW5yXISM5SG9sY7GzpjxYMv8S3mB1o291xFRezJAVRC3eCBYi4A2d
   g==;
X-CSE-ConnectionGUID: zAkfRNq6SH260SwqihdhRw==
X-CSE-MsgGUID: QPy/3/WLR9K/nYkqYyWWfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64425844"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64425844"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 03:21:20 -0700
X-CSE-ConnectionGUID: XFtEyp8QRR66MdK4Vu0ILA==
X-CSE-MsgGUID: tW/yA1ZMQPqCmKC5kjnIFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="176244625"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 19 Sep 2025 03:21:18 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzYEu-0004Cl-1B;
	Fri, 19 Sep 2025 10:21:16 +0000
Date: Fri, 19 Sep 2025 18:20:53 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 ea62db903f0ba80832e2fc7834e5febfc3e305c1
Message-ID: <202509191848.MNH8xpN0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: ea62db903f0ba80832e2fc7834e5febfc3e305c1  efi/runtime: Deal with arch_efi_call_virt_setup() returning failure

elapsed time: 1353m

configs tested: 252
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-11.5.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250918    gcc-8.5.0
arc                   randconfig-001-20250919    gcc-11.5.0
arc                   randconfig-002-20250918    gcc-8.5.0
arc                   randconfig-002-20250919    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                          ep93xx_defconfig    gcc-11.5.0
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-001-20250919    gcc-11.5.0
arm                   randconfig-002-20250918    gcc-8.5.0
arm                   randconfig-002-20250919    gcc-11.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-003-20250919    gcc-11.5.0
arm                   randconfig-004-20250918    gcc-11.5.0
arm                   randconfig-004-20250919    gcc-11.5.0
arm                        vexpress_defconfig    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-001-20250919    gcc-11.5.0
arm64                 randconfig-002-20250918    gcc-11.5.0
arm64                 randconfig-002-20250919    gcc-11.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-003-20250919    gcc-11.5.0
arm64                 randconfig-004-20250918    clang-22
arm64                 randconfig-004-20250919    gcc-11.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250918    gcc-15.1.0
csky                  randconfig-001-20250919    clang-22
csky                  randconfig-002-20250918    gcc-15.1.0
csky                  randconfig-002-20250919    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-001-20250919    clang-22
hexagon               randconfig-002-20250918    clang-22
hexagon               randconfig-002-20250919    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250918    clang-20
i386        buildonly-randconfig-001-20250919    gcc-14
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-002-20250919    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-003-20250919    gcc-14
i386        buildonly-randconfig-004-20250918    clang-20
i386        buildonly-randconfig-004-20250919    gcc-14
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-005-20250919    gcc-14
i386        buildonly-randconfig-006-20250918    clang-20
i386        buildonly-randconfig-006-20250919    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250919    gcc-14
i386                  randconfig-002-20250919    gcc-14
i386                  randconfig-003-20250919    gcc-14
i386                  randconfig-004-20250919    gcc-14
i386                  randconfig-005-20250919    gcc-14
i386                  randconfig-006-20250919    gcc-14
i386                  randconfig-007-20250919    gcc-14
i386                  randconfig-011-20250919    clang-20
i386                  randconfig-012-20250919    clang-20
i386                  randconfig-013-20250919    clang-20
i386                  randconfig-014-20250919    clang-20
i386                  randconfig-015-20250919    clang-20
i386                  randconfig-016-20250919    clang-20
i386                  randconfig-017-20250919    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250918    clang-18
loongarch             randconfig-001-20250919    clang-22
loongarch             randconfig-002-20250918    clang-18
loongarch             randconfig-002-20250919    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         db1xxx_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250918    gcc-10.5.0
nios2                 randconfig-001-20250919    clang-22
nios2                 randconfig-002-20250918    gcc-8.5.0
nios2                 randconfig-002-20250919    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-11.5.0
parisc                randconfig-001-20250918    gcc-12.5.0
parisc                randconfig-001-20250919    clang-22
parisc                randconfig-002-20250918    gcc-8.5.0
parisc                randconfig-002-20250919    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-11.5.0
powerpc               randconfig-001-20250918    gcc-9.5.0
powerpc               randconfig-001-20250919    clang-22
powerpc               randconfig-002-20250918    clang-17
powerpc               randconfig-002-20250919    clang-22
powerpc               randconfig-003-20250918    clang-19
powerpc               randconfig-003-20250919    clang-22
powerpc                     tqm8560_defconfig    gcc-11.5.0
powerpc64             randconfig-001-20250918    gcc-8.5.0
powerpc64             randconfig-001-20250919    clang-22
powerpc64             randconfig-002-20250918    gcc-14.3.0
powerpc64             randconfig-002-20250919    clang-22
powerpc64             randconfig-003-20250918    clang-22
powerpc64             randconfig-003-20250919    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250918    clang-22
riscv                 randconfig-001-20250919    gcc-10.5.0
riscv                 randconfig-002-20250918    gcc-9.5.0
riscv                 randconfig-002-20250919    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250918    gcc-11.5.0
s390                  randconfig-001-20250919    gcc-10.5.0
s390                  randconfig-002-20250918    gcc-8.5.0
s390                  randconfig-002-20250919    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250918    gcc-15.1.0
sh                    randconfig-001-20250919    gcc-10.5.0
sh                    randconfig-002-20250918    gcc-10.5.0
sh                    randconfig-002-20250919    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250918    gcc-11.5.0
sparc                 randconfig-001-20250919    gcc-10.5.0
sparc                 randconfig-002-20250918    gcc-15.1.0
sparc                 randconfig-002-20250919    gcc-10.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250918    clang-20
sparc64               randconfig-001-20250919    gcc-10.5.0
sparc64               randconfig-002-20250918    gcc-8.5.0
sparc64               randconfig-002-20250919    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250918    clang-22
um                    randconfig-001-20250919    gcc-10.5.0
um                    randconfig-002-20250918    clang-18
um                    randconfig-002-20250919    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-001-20250919    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-002-20250919    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-003-20250919    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-004-20250919    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-005-20250919    clang-20
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64      buildonly-randconfig-006-20250919    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250919    clang-20
x86_64                randconfig-002-20250919    clang-20
x86_64                randconfig-003-20250919    clang-20
x86_64                randconfig-004-20250919    clang-20
x86_64                randconfig-005-20250919    clang-20
x86_64                randconfig-006-20250919    clang-20
x86_64                randconfig-007-20250919    clang-20
x86_64                randconfig-008-20250919    clang-20
x86_64                randconfig-071-20250919    gcc-14
x86_64                randconfig-072-20250919    gcc-14
x86_64                randconfig-073-20250919    gcc-14
x86_64                randconfig-074-20250919    gcc-14
x86_64                randconfig-075-20250919    gcc-14
x86_64                randconfig-076-20250919    gcc-14
x86_64                randconfig-077-20250919    gcc-14
x86_64                randconfig-078-20250919    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250918    gcc-8.5.0
xtensa                randconfig-001-20250919    gcc-10.5.0
xtensa                randconfig-002-20250918    gcc-8.5.0
xtensa                randconfig-002-20250919    gcc-10.5.0
xtensa                    xip_kc705_defconfig    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

