Return-Path: <linux-efi+bounces-4204-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22155AFDFD7
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227BE3B155F
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 06:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7A78C91;
	Wed,  9 Jul 2025 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOOHuVrO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6878F36
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752041753; cv=none; b=rMooijp9zEnezJNvtRIzh3qRMGr3JUEznfcEY83hhw3aY81zOK63aAgfDs+wZhAWwiv4JA5S1NG0D5sUry7JFcdUdK8CUWUOvl3xIK+LBD+JamWxTi1aonwDsqdL5IdnqCqQvDBO/FLBVBMiBmiwbLXcdhGUbmBb/hHNTbiFUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752041753; c=relaxed/simple;
	bh=gElSSpkZezROn73pOZez7VPFzMUXu4vAmf4sRezcsEM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rEg3JLch+H+D/vVWikrAR+L2jALHFFC3MUIis+yK7cyIyXViS+FI0c8yLiYag7CASB5kgwv2CRihpQ5osE2mAzEMcYYxNXVIyutnNuM7DpHs3Z0Otnx0iKWq990nHfKYkrCqnrJBne/vzY/7g7wCJnhkFnbM92I5F3iAXiACwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOOHuVrO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752041752; x=1783577752;
  h=date:from:to:cc:subject:message-id;
  bh=gElSSpkZezROn73pOZez7VPFzMUXu4vAmf4sRezcsEM=;
  b=GOOHuVrOCVdB6oimNuzIWHQapXhlOupKjVwtkkUjv3zb2I2CTSWsfi+S
   j5jOBPlDcg4z9Ah2beXuBi5nQEJirmDVOXFgK9BypBO/d/sanSPBVd6fx
   vDVBIUA32Y1SWFYyo589leIjBkD5x0W35crpu9xcdAeiz+THG/QbN0byq
   QLB7pyVd9iLymoB0n28hvb9sTpofnoEq4K05Sq0nDMjZg7L57gXI+4oGu
   b1sz1sNgadnucVEpFOd+I2FMnjGwbOOPHRHH9H/7sz/ALk0HTMa40xPgB
   njnamazLrY6uj3l9LqAncUcX1G8TpBe+Yti2Yg8PePZwnhZVPYFIrnu6/
   Q==;
X-CSE-ConnectionGUID: RJIBkd/5QhGGV9s5M6OTfg==
X-CSE-MsgGUID: BgIuHw8qTqm7Z519i1jqsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58094807"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58094807"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 23:15:51 -0700
X-CSE-ConnectionGUID: QmszSFNnS5aNq8pa4kMX0w==
X-CSE-MsgGUID: qQuoLX0gQH2LiTNleUokNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155097532"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Jul 2025 23:15:49 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZO5r-0003Ax-0i;
	Wed, 09 Jul 2025 06:15:47 +0000
Date: Wed, 09 Jul 2025 14:14:47 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD REGRESSION
 42c68c6e354f71498f9e3e31aa5b0f9243bc1618
Message-ID: <202507091433.0etlSgRy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 42c68c6e354f71498f9e3e31aa5b0f9243bc1618  efi: add ovmf debug log driver

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202507091432.rbbrjGoU-lkp@intel.com

    ERROR: modpost: "efi_kobj" [drivers/firmware/efi/ovmf-debug-log.ko] undefined!

Error/Warning ids grouped by kconfigs:

recent_errors
`-- loongarch-allmodconfig
    `-- ERROR:efi_kobj-drivers-firmware-efi-ovmf-debug-log.ko-undefined

elapsed time: 1027m

configs tested: 228
configs skipped: 4

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250708    gcc-13.4.0
arc                   randconfig-001-20250709    gcc-10.5.0
arc                   randconfig-002-20250708    gcc-8.5.0
arc                   randconfig-002-20250709    gcc-10.5.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                           imxrt_defconfig    gcc-15.1.0
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250708    clang-21
arm                   randconfig-001-20250709    gcc-10.5.0
arm                   randconfig-002-20250708    clang-17
arm                   randconfig-002-20250709    gcc-10.5.0
arm                   randconfig-003-20250708    gcc-10.5.0
arm                   randconfig-003-20250709    gcc-10.5.0
arm                   randconfig-004-20250708    clang-21
arm                   randconfig-004-20250709    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                 randconfig-001-20250708    gcc-9.5.0
arm64                 randconfig-001-20250709    gcc-10.5.0
arm64                 randconfig-002-20250708    clang-19
arm64                 randconfig-002-20250709    gcc-10.5.0
arm64                 randconfig-003-20250708    clang-21
arm64                 randconfig-003-20250709    gcc-10.5.0
arm64                 randconfig-004-20250708    gcc-8.5.0
arm64                 randconfig-004-20250709    gcc-10.5.0
csky                              allnoconfig    clang-21
csky                  randconfig-001-20250708    gcc-13.4.0
csky                  randconfig-001-20250709    gcc-14.2.0
csky                  randconfig-002-20250708    gcc-15.1.0
csky                  randconfig-002-20250709    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250708    clang-21
hexagon               randconfig-001-20250709    gcc-14.2.0
hexagon               randconfig-002-20250708    clang-21
hexagon               randconfig-002-20250709    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250708    clang-20
i386        buildonly-randconfig-001-20250709    clang-20
i386        buildonly-randconfig-002-20250708    clang-20
i386        buildonly-randconfig-002-20250709    clang-20
i386        buildonly-randconfig-003-20250708    clang-20
i386        buildonly-randconfig-003-20250709    clang-20
i386        buildonly-randconfig-004-20250708    gcc-12
i386        buildonly-randconfig-004-20250709    clang-20
i386        buildonly-randconfig-005-20250708    clang-20
i386        buildonly-randconfig-005-20250709    clang-20
i386        buildonly-randconfig-006-20250708    clang-20
i386        buildonly-randconfig-006-20250709    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250709    clang-20
i386                  randconfig-002-20250709    clang-20
i386                  randconfig-003-20250709    clang-20
i386                  randconfig-004-20250709    clang-20
i386                  randconfig-005-20250709    clang-20
i386                  randconfig-006-20250709    clang-20
i386                  randconfig-007-20250709    clang-20
i386                  randconfig-011-20250709    clang-20
i386                  randconfig-012-20250709    clang-20
i386                  randconfig-013-20250709    clang-20
i386                  randconfig-014-20250709    clang-20
i386                  randconfig-015-20250709    clang-20
i386                  randconfig-016-20250709    clang-20
i386                  randconfig-017-20250709    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250708    clang-21
loongarch             randconfig-001-20250709    gcc-14.2.0
loongarch             randconfig-002-20250708    clang-21
loongarch             randconfig-002-20250709    gcc-14.2.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         10m50_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250708    gcc-8.5.0
nios2                 randconfig-001-20250709    gcc-14.2.0
nios2                 randconfig-002-20250708    gcc-8.5.0
nios2                 randconfig-002-20250709    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250708    gcc-9.3.0
parisc                randconfig-001-20250709    gcc-14.2.0
parisc                randconfig-002-20250708    gcc-14.3.0
parisc                randconfig-002-20250709    gcc-14.2.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250708    gcc-8.5.0
powerpc               randconfig-001-20250709    gcc-14.2.0
powerpc               randconfig-002-20250708    clang-19
powerpc               randconfig-002-20250709    gcc-14.2.0
powerpc               randconfig-003-20250708    clang-21
powerpc               randconfig-003-20250709    gcc-14.2.0
powerpc64             randconfig-001-20250708    clang-21
powerpc64             randconfig-001-20250709    gcc-14.2.0
powerpc64             randconfig-002-20250708    clang-21
powerpc64             randconfig-002-20250709    gcc-14.2.0
powerpc64             randconfig-003-20250708    clang-21
powerpc64             randconfig-003-20250709    gcc-14.2.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250708    clang-16
riscv                 randconfig-001-20250709    gcc-12
riscv                 randconfig-002-20250708    gcc-11.5.0
riscv                 randconfig-002-20250709    gcc-12
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250708    gcc-14.3.0
s390                  randconfig-001-20250709    gcc-12
s390                  randconfig-002-20250708    gcc-9.3.0
s390                  randconfig-002-20250709    gcc-12
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250708    gcc-11.5.0
sh                    randconfig-001-20250709    gcc-12
sh                    randconfig-002-20250708    gcc-15.1.0
sh                    randconfig-002-20250709    gcc-12
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250708    gcc-13.4.0
sparc                 randconfig-001-20250709    gcc-12
sparc                 randconfig-002-20250708    gcc-13.4.0
sparc                 randconfig-002-20250709    gcc-12
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250708    clang-21
sparc64               randconfig-001-20250709    gcc-12
sparc64               randconfig-002-20250708    gcc-15.1.0
sparc64               randconfig-002-20250709    gcc-12
um                               alldefconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250708    clang-21
um                    randconfig-001-20250709    gcc-12
um                    randconfig-002-20250708    clang-17
um                    randconfig-002-20250709    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250708    gcc-12
x86_64      buildonly-randconfig-001-20250709    clang-20
x86_64      buildonly-randconfig-002-20250708    gcc-12
x86_64      buildonly-randconfig-002-20250709    clang-20
x86_64      buildonly-randconfig-003-20250708    clang-20
x86_64      buildonly-randconfig-003-20250709    clang-20
x86_64      buildonly-randconfig-004-20250708    gcc-12
x86_64      buildonly-randconfig-004-20250709    clang-20
x86_64      buildonly-randconfig-005-20250708    clang-20
x86_64      buildonly-randconfig-005-20250709    clang-20
x86_64      buildonly-randconfig-006-20250708    clang-20
x86_64      buildonly-randconfig-006-20250709    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250709    clang-20
x86_64                randconfig-002-20250709    clang-20
x86_64                randconfig-003-20250709    clang-20
x86_64                randconfig-004-20250709    clang-20
x86_64                randconfig-005-20250709    clang-20
x86_64                randconfig-006-20250709    clang-20
x86_64                randconfig-007-20250709    clang-20
x86_64                randconfig-008-20250709    clang-20
x86_64                randconfig-071-20250709    gcc-12
x86_64                randconfig-072-20250709    gcc-12
x86_64                randconfig-073-20250709    gcc-12
x86_64                randconfig-074-20250709    gcc-12
x86_64                randconfig-075-20250709    gcc-12
x86_64                randconfig-076-20250709    gcc-12
x86_64                randconfig-077-20250709    gcc-12
x86_64                randconfig-078-20250709    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250708    gcc-8.5.0
xtensa                randconfig-001-20250709    gcc-12
xtensa                randconfig-002-20250708    gcc-9.3.0
xtensa                randconfig-002-20250709    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

