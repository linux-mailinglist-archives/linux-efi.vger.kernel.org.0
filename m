Return-Path: <linux-efi+bounces-485-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02184B457
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 13:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FEE28316A
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 12:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCA512F398;
	Tue,  6 Feb 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCgI202i"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537512F389
	for <linux-efi@vger.kernel.org>; Tue,  6 Feb 2024 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220684; cv=none; b=R64TYkiaTvMcqfhdbpxwdss3QthoIepm+gFAMgysYtSL1it7rJ9eO9L02VJJn0xupeDK7ByQfVeepbT0uLll6RZSxthuosc21fB7RCXIXcqFkIPmyxYp9m/QL9st+JYTOtMcTqLX+zQaIc+3Up6DtFT3ZdcEq1a8KkwOEFCg7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220684; c=relaxed/simple;
	bh=KZBxr7RG7SQ4S9zgkol9gNt+Btsgwfb7bZLjHcFRIcM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=olgnkHccr2D4cQXkCaozzBOTA69mwwLcRycBaXvkc6hh7G7Ijv76UJ3gHexizciO8T1wjk5UzuJgBB7ne19gudYZa6J3g6E7USnXxtqGPVPupLT/FR0Nb3gyPRd+wM+dDqIXoGZdAqpDfuTWAhGmVpT5Q98L4geRysE7J4PHoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCgI202i; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707220683; x=1738756683;
  h=date:from:to:cc:subject:message-id;
  bh=KZBxr7RG7SQ4S9zgkol9gNt+Btsgwfb7bZLjHcFRIcM=;
  b=kCgI202iyy4PVShg3SEm4zcMygocgaGVDlMvL7jh6BVAuNAQ3atG50Wv
   lf8taaNo367zj3t6jMBRf/yDE8ugChI26/2kGMoQaKMBZJOQz8QIi0RKA
   gMt5BNaFAqipMOqwpwpfEmuTm189oXoCljgRVNBA0HDMeSXirG2LzcRT8
   6rv3IE5vNz26rXvWZnXjBf57KPBw7MrdviMsigaBPxMZ/O09gWvI/rGjY
   zjP+Z+8iCYq4wmfnVLyWPPJGRmgqa4njUcgnk3RKB6jWAA8mUbf5BweH6
   rbAsITwGOHye6Y/NHTYJg/PQcPz8PmIy++NrzQgztHW7ZsbnHcGI/CLMj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11376195"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="11376195"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1233684"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 Feb 2024 03:58:01 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXK5P-0001Kq-0i;
	Tue, 06 Feb 2024 11:57:59 +0000
Date: Tue, 06 Feb 2024 19:57:22 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 1ad55cecf22f05f1c884adf63cc09d3c3e609ebf
Message-ID: <202402061919.mBgX0mqI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 1ad55cecf22f05f1c884adf63cc09d3c3e609ebf  x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section

elapsed time: 1490m

configs tested: 272
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
arc                     haps_hs_smp_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240205   gcc  
arc                   randconfig-001-20240206   gcc  
arc                   randconfig-002-20240205   gcc  
arc                   randconfig-002-20240206   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                          exynos_defconfig   clang
arm                      footbridge_defconfig   clang
arm                       imx_v4_v5_defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                            mmp2_defconfig   gcc  
arm                        mvebu_v5_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240205   clang
arm                   randconfig-002-20240205   gcc  
arm                   randconfig-002-20240206   gcc  
arm                   randconfig-003-20240205   clang
arm                   randconfig-003-20240206   gcc  
arm                   randconfig-004-20240205   clang
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240205   gcc  
arm64                 randconfig-001-20240206   gcc  
arm64                 randconfig-002-20240205   gcc  
arm64                 randconfig-003-20240205   gcc  
arm64                 randconfig-003-20240206   gcc  
arm64                 randconfig-004-20240205   gcc  
arm64                 randconfig-004-20240206   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240205   gcc  
csky                  randconfig-001-20240206   gcc  
csky                  randconfig-002-20240205   gcc  
csky                  randconfig-002-20240206   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240205   clang
hexagon               randconfig-002-20240205   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240205   clang
i386         buildonly-randconfig-002-20240205   clang
i386         buildonly-randconfig-003-20240205   clang
i386         buildonly-randconfig-003-20240206   gcc  
i386         buildonly-randconfig-004-20240205   clang
i386         buildonly-randconfig-005-20240205   clang
i386         buildonly-randconfig-005-20240206   gcc  
i386         buildonly-randconfig-006-20240205   clang
i386         buildonly-randconfig-006-20240206   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240205   clang
i386                  randconfig-002-20240205   clang
i386                  randconfig-003-20240205   clang
i386                  randconfig-004-20240205   gcc  
i386                  randconfig-005-20240205   clang
i386                  randconfig-006-20240205   gcc  
i386                  randconfig-011-20240205   gcc  
i386                  randconfig-012-20240205   clang
i386                  randconfig-012-20240206   gcc  
i386                  randconfig-013-20240205   gcc  
i386                  randconfig-014-20240205   gcc  
i386                  randconfig-014-20240206   gcc  
i386                  randconfig-015-20240205   clang
i386                  randconfig-015-20240206   gcc  
i386                  randconfig-016-20240205   gcc  
i386                  randconfig-016-20240206   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240205   gcc  
loongarch             randconfig-001-20240206   gcc  
loongarch             randconfig-002-20240205   gcc  
loongarch             randconfig-002-20240206   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          malta_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                          rm200_defconfig   gcc  
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240205   gcc  
nios2                 randconfig-001-20240206   gcc  
nios2                 randconfig-002-20240205   gcc  
nios2                 randconfig-002-20240206   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240205   gcc  
parisc                randconfig-001-20240206   gcc  
parisc                randconfig-002-20240205   gcc  
parisc                randconfig-002-20240206   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240205   clang
powerpc               randconfig-002-20240205   clang
powerpc               randconfig-002-20240206   gcc  
powerpc               randconfig-003-20240205   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     taishan_defconfig   clang
powerpc                     tqm8541_defconfig   clang
powerpc                      walnut_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240205   clang
powerpc64             randconfig-001-20240206   gcc  
powerpc64             randconfig-002-20240205   clang
powerpc64             randconfig-003-20240205   clang
powerpc64             randconfig-003-20240206   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240205   clang
riscv                 randconfig-001-20240206   gcc  
riscv                 randconfig-002-20240205   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240205   clang
s390                  randconfig-002-20240205   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240205   gcc  
sh                    randconfig-001-20240206   gcc  
sh                    randconfig-002-20240205   gcc  
sh                    randconfig-002-20240206   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240205   gcc  
sparc64               randconfig-001-20240206   gcc  
sparc64               randconfig-002-20240205   gcc  
sparc64               randconfig-002-20240206   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240205   clang
um                    randconfig-002-20240205   gcc  
um                    randconfig-002-20240206   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240205   clang
x86_64       buildonly-randconfig-001-20240206   gcc  
x86_64       buildonly-randconfig-002-20240205   clang
x86_64       buildonly-randconfig-002-20240206   clang
x86_64       buildonly-randconfig-003-20240205   gcc  
x86_64       buildonly-randconfig-003-20240206   gcc  
x86_64       buildonly-randconfig-004-20240205   gcc  
x86_64       buildonly-randconfig-004-20240206   gcc  
x86_64       buildonly-randconfig-005-20240205   gcc  
x86_64       buildonly-randconfig-005-20240206   gcc  
x86_64       buildonly-randconfig-006-20240205   gcc  
x86_64       buildonly-randconfig-006-20240206   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240205   gcc  
x86_64                randconfig-001-20240206   clang
x86_64                randconfig-002-20240205   gcc  
x86_64                randconfig-002-20240206   clang
x86_64                randconfig-003-20240205   clang
x86_64                randconfig-003-20240206   gcc  
x86_64                randconfig-004-20240205   gcc  
x86_64                randconfig-004-20240206   gcc  
x86_64                randconfig-005-20240205   gcc  
x86_64                randconfig-005-20240206   gcc  
x86_64                randconfig-006-20240205   gcc  
x86_64                randconfig-006-20240206   clang
x86_64                randconfig-011-20240205   gcc  
x86_64                randconfig-011-20240206   gcc  
x86_64                randconfig-012-20240205   gcc  
x86_64                randconfig-012-20240206   clang
x86_64                randconfig-013-20240205   clang
x86_64                randconfig-013-20240206   gcc  
x86_64                randconfig-014-20240205   clang
x86_64                randconfig-014-20240206   clang
x86_64                randconfig-015-20240205   gcc  
x86_64                randconfig-015-20240206   gcc  
x86_64                randconfig-016-20240205   clang
x86_64                randconfig-016-20240206   clang
x86_64                randconfig-071-20240205   clang
x86_64                randconfig-071-20240206   gcc  
x86_64                randconfig-072-20240205   gcc  
x86_64                randconfig-072-20240206   gcc  
x86_64                randconfig-073-20240205   clang
x86_64                randconfig-073-20240206   gcc  
x86_64                randconfig-074-20240205   clang
x86_64                randconfig-074-20240206   gcc  
x86_64                randconfig-075-20240205   gcc  
x86_64                randconfig-075-20240206   clang
x86_64                randconfig-076-20240205   clang
x86_64                randconfig-076-20240206   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240205   gcc  
xtensa                randconfig-001-20240206   gcc  
xtensa                randconfig-002-20240205   gcc  
xtensa                randconfig-002-20240206   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

