Return-Path: <linux-efi+bounces-2429-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCE09FA082
	for <lists+linux-efi@lfdr.de>; Sat, 21 Dec 2024 13:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A37A2449
	for <lists+linux-efi@lfdr.de>; Sat, 21 Dec 2024 12:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B0F7DA73;
	Sat, 21 Dec 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/fJE9A+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6642594B0
	for <linux-efi@vger.kernel.org>; Sat, 21 Dec 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734783635; cv=none; b=RzjMBrAgBWMpff6qQpWKGbnFhUR7d4ZGpUvwRFcqWwnCd5+ieaJ4QdShSkeCp6ImIjqc98WYJcWDr4C/8HvLcO+vTIomU01GP9I5TeL4Uqi03RflRvMLwzT7jnlP53AkRQE0P7+A45+jpOt/0c/DmxhnEx2GBrxX/l0PrL3fVEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734783635; c=relaxed/simple;
	bh=EMBOy91L9Zh9AmTgL9aNqGi02JLJ31FMTEYzuFnGpR8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VDWzKuWNoTS0kfCaOs1350uqnm1ERURp9kuxYexazY5wRW4q5sIKCC4ZkRWV4KrD41TalQLAz93YAZY0urj12lE8C75ej+7QMcaEvgXJ/E2tPkRZA3SFnOBWb5TJPyzYVq2o8C9xFDFCdrvepCWZ4+Eg9KHdy7Vvdl450Og6kyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/fJE9A+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734783633; x=1766319633;
  h=date:from:to:cc:subject:message-id;
  bh=EMBOy91L9Zh9AmTgL9aNqGi02JLJ31FMTEYzuFnGpR8=;
  b=M/fJE9A+YVYQoov9owFTO6vaG+2uD4XL5eshbgTl66NBq4zJ0ce0glRp
   hTlCVayVZ6Cf80KzBEOEgn08Me1fPG/8wvSenSTcZ5kyyBIIJcAooLzeU
   MKdyaC5GkX+dshN/xMjrwNb0fAXfygT5KSdMiChRM3QkhwUJ/1b8sye3R
   xmo4DMcFiVmb/A2RFZ+kqNhAohg3pcV27eNfzYju0sloMr8HCr3SfJ/v0
   og9IYobg50wRtTpqvOFfcnj67GIva+MVAjtT4eNI7gv0u9g0U1K0qyJ2g
   XyickFaU3ZgLtbNJB2neNQjWIHk9FEROwdRi9QPRRYwr0UBE8Ul5bDj84
   Q==;
X-CSE-ConnectionGUID: q8I4qdGzRsy5kBRV2WHoCg==
X-CSE-MsgGUID: wCL9H2DfRxKh0JbeAozfDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11293"; a="35210281"
X-IronPort-AV: E=Sophos;i="6.12,253,1728975600"; 
   d="scan'208";a="35210281"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 04:20:32 -0800
X-CSE-ConnectionGUID: crSnJIMdQDe7td7OFVWpkw==
X-CSE-MsgGUID: 8bRRZJCvRxO9vhIb2iwd9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="103830207"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Dec 2024 04:20:31 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOyT7-0002AJ-0b;
	Sat, 21 Dec 2024 12:20:29 +0000
Date: Sat, 21 Dec 2024 20:20:08 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 7f0158f3ee12403c26e815c9df4f00d41ee3bb41
Message-ID: <202412212002.CypNWHeT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 7f0158f3ee12403c26e815c9df4f00d41ee3bb41  efi/libstub: Avoid legacy decompressor zlib/zstd wrappers

elapsed time: 1449m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                            hsdk_defconfig    gcc-13.2.0
arc                        nsim_700_defconfig    gcc-13.2.0
arc                   randconfig-001-20241220    gcc-13.2.0
arc                   randconfig-002-20241220    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         orion5x_defconfig    clang-20
arm                   randconfig-001-20241220    clang-19
arm                   randconfig-002-20241220    gcc-14.2.0
arm                   randconfig-003-20241220    gcc-14.2.0
arm                   randconfig-004-20241220    clang-20
arm                           sunxi_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241220    clang-17
arm64                 randconfig-002-20241220    clang-19
arm64                 randconfig-003-20241220    clang-20
arm64                 randconfig-004-20241220    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241220    gcc-14.2.0
csky                  randconfig-002-20241220    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241220    clang-20
hexagon               randconfig-002-20241220    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241220    gcc-12
i386        buildonly-randconfig-002-20241220    gcc-12
i386        buildonly-randconfig-003-20241220    gcc-12
i386        buildonly-randconfig-004-20241220    clang-19
i386        buildonly-randconfig-005-20241220    gcc-12
i386        buildonly-randconfig-006-20241220    gcc-12
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241220    gcc-14.2.0
loongarch             randconfig-002-20241220    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241220    gcc-14.2.0
nios2                 randconfig-002-20241220    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241220    gcc-14.2.0
parisc                randconfig-002-20241220    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 canyonlands_defconfig    clang-19
powerpc                      cm5200_defconfig    clang-20
powerpc                    gamecube_defconfig    clang-16
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                  mpc866_ads_defconfig    clang-20
powerpc               randconfig-001-20241220    clang-15
powerpc               randconfig-002-20241220    gcc-14.2.0
powerpc               randconfig-003-20241220    gcc-14.2.0
powerpc64             randconfig-001-20241220    gcc-14.2.0
powerpc64             randconfig-002-20241220    clang-19
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241220    gcc-14.2.0
riscv                 randconfig-002-20241220    clang-19
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241220    gcc-14.2.0
s390                  randconfig-002-20241220    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20241220    gcc-14.2.0
sh                    randconfig-002-20241220    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241220    gcc-14.2.0
sparc                 randconfig-002-20241220    gcc-14.2.0
sparc64               randconfig-001-20241220    gcc-14.2.0
sparc64               randconfig-002-20241220    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                    randconfig-001-20241220    clang-20
um                    randconfig-002-20241220    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241220    gcc-12
x86_64      buildonly-randconfig-002-20241220    clang-19
x86_64      buildonly-randconfig-003-20241220    gcc-12
x86_64      buildonly-randconfig-004-20241220    gcc-12
x86_64      buildonly-randconfig-005-20241220    clang-19
x86_64      buildonly-randconfig-006-20241220    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241220    gcc-14.2.0
xtensa                randconfig-002-20241220    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

