Return-Path: <linux-efi+bounces-1612-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A80729625B1
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 13:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71111F2102A
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176616B722;
	Wed, 28 Aug 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SH6LciOR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE715D5BB
	for <linux-efi@vger.kernel.org>; Wed, 28 Aug 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843714; cv=none; b=PtCOUBdSrl/rtVaM48Q9yuxN3YjZBqeD0b+wb6zIoqVcj+B3VgAt6WoR6XHqnOD5z0qWrp2bYfMnAHqru9Uxll2z0lmCULVomOFC74E3Ecd6YfqX+vZSvleWzOrcZqR0cazjiCEgH0hywsRjvYY1eTNkHxeoZ5huOeFDRbzZ270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843714; c=relaxed/simple;
	bh=0h9T1xB75WcZoxgdl9HtgxOS0Fw12LguDLRBakwBFVc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MNlkinOhh19mU9SNWhxssKtxGKzPejchpT9VIgHRwgYF/wfzVw/6n9SnNmLfWcWzGuEx3IMYoCZJ+5hxMiIPiMlW2NEItEAHgR5l8B5s9+FwPtdsN9IASn6B+FAArR6K3OcKnWMmKADynhL8IFPnBUW7zwTKezOzgMHd/SO4c34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SH6LciOR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724843712; x=1756379712;
  h=date:from:to:cc:subject:message-id;
  bh=0h9T1xB75WcZoxgdl9HtgxOS0Fw12LguDLRBakwBFVc=;
  b=SH6LciORCXlOYYgPTP/ZPxMSBtV46aX7Cena+DUCqT2nQFdDYDbrtj2R
   12AF4NNkORZz+6Odd0aBcq6RB9NmSiUc28ZFryJEt8z4d1flUGhG6hiiR
   Zdbz0sGzEHqC/vN02GPi9BgEG0VktOBn+iyK9WmMQ8SQm4Wx98VSwcp3t
   KA5M51aK3TEIGZqYE/Lx82FCz5N4d/t6x8zRv4cnHxuLUloMR3Uxy94LV
   L7mAu+nT+ot61H7hiwtmXppzZAbxHUDYnq7sAPYSP0aKQd3SVexf3s7Vh
   qZPP3MbRLrKsMrdIyMF9RF885qlzyKLcDy4xQpgH29vlQK2xxWPe2DM60
   g==;
X-CSE-ConnectionGUID: Dh+PwciTSaOmgW0OXDDRPA==
X-CSE-MsgGUID: NPMGqKBTSnqlsZfDmfWO2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27163044"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="27163044"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 04:15:11 -0700
X-CSE-ConnectionGUID: VuPjuV6TQz2EjsxDsBR6RA==
X-CSE-MsgGUID: q4HKlUEBQHuvtXaRO10cUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="93981777"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Aug 2024 04:15:10 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjGdn-000KsI-2b;
	Wed, 28 Aug 2024 11:15:07 +0000
Date: Wed, 28 Aug 2024 19:14:46 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 d7171eb494353e03f3cde1a6f665e19c243c98e8
Message-ID: <202408281943.UsUK2W2n-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: d7171eb494353e03f3cde1a6f665e19c243c98e8  efi/cper: Print correctable AER information

elapsed time: 1460m

configs tested: 211
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240828   gcc-13.2.0
arc                   randconfig-002-20240828   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                            mmp2_defconfig   gcc-13.2.0
arm                   randconfig-001-20240828   gcc-14.1.0
arm                   randconfig-002-20240828   clang-20
arm                   randconfig-003-20240828   gcc-14.1.0
arm                   randconfig-004-20240828   clang-20
arm                         s5pv210_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240828   clang-17
arm64                 randconfig-002-20240828   clang-20
arm64                 randconfig-003-20240828   clang-15
arm64                 randconfig-004-20240828   clang-15
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240828   gcc-14.1.0
csky                  randconfig-002-20240828   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240828   clang-20
hexagon               randconfig-002-20240828   clang-16
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240828   gcc-12
i386         buildonly-randconfig-002-20240828   clang-18
i386         buildonly-randconfig-002-20240828   gcc-12
i386         buildonly-randconfig-003-20240828   clang-18
i386         buildonly-randconfig-003-20240828   gcc-12
i386         buildonly-randconfig-004-20240828   gcc-12
i386         buildonly-randconfig-005-20240828   gcc-12
i386         buildonly-randconfig-006-20240828   clang-18
i386         buildonly-randconfig-006-20240828   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240828   clang-18
i386                  randconfig-001-20240828   gcc-12
i386                  randconfig-002-20240828   gcc-12
i386                  randconfig-003-20240828   clang-18
i386                  randconfig-003-20240828   gcc-12
i386                  randconfig-004-20240828   clang-18
i386                  randconfig-004-20240828   gcc-12
i386                  randconfig-005-20240828   clang-18
i386                  randconfig-005-20240828   gcc-12
i386                  randconfig-006-20240828   gcc-12
i386                  randconfig-011-20240828   gcc-12
i386                  randconfig-012-20240828   gcc-12
i386                  randconfig-013-20240828   clang-18
i386                  randconfig-013-20240828   gcc-12
i386                  randconfig-014-20240828   gcc-11
i386                  randconfig-014-20240828   gcc-12
i386                  randconfig-015-20240828   gcc-12
i386                  randconfig-016-20240828   gcc-11
i386                  randconfig-016-20240828   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240828   gcc-14.1.0
loongarch             randconfig-002-20240828   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                      mmu_defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240828   gcc-14.1.0
nios2                 randconfig-002-20240828   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240828   gcc-14.1.0
parisc                randconfig-002-20240828   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc               randconfig-003-20240828   gcc-14.1.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240828   gcc-14.1.0
powerpc64             randconfig-002-20240828   gcc-14.1.0
powerpc64             randconfig-003-20240828   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240828   gcc-14.1.0
riscv                 randconfig-002-20240828   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240828   gcc-14.1.0
s390                  randconfig-002-20240828   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-13.2.0
sh                    randconfig-001-20240828   gcc-14.1.0
sh                    randconfig-002-20240828   gcc-14.1.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                           se7712_defconfig   gcc-13.2.0
sh                   secureedge5410_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240828   gcc-14.1.0
sparc64               randconfig-002-20240828   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240828   clang-15
um                    randconfig-002-20240828   clang-20
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240828   clang-18
x86_64       buildonly-randconfig-002-20240828   clang-18
x86_64       buildonly-randconfig-003-20240828   clang-18
x86_64       buildonly-randconfig-003-20240828   gcc-12
x86_64       buildonly-randconfig-004-20240828   clang-18
x86_64       buildonly-randconfig-005-20240828   clang-18
x86_64       buildonly-randconfig-005-20240828   gcc-11
x86_64       buildonly-randconfig-006-20240828   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240828   clang-18
x86_64                randconfig-001-20240828   gcc-12
x86_64                randconfig-002-20240828   clang-18
x86_64                randconfig-003-20240828   clang-18
x86_64                randconfig-003-20240828   gcc-12
x86_64                randconfig-004-20240828   clang-18
x86_64                randconfig-005-20240828   clang-18
x86_64                randconfig-006-20240828   clang-18
x86_64                randconfig-006-20240828   gcc-12
x86_64                randconfig-011-20240828   clang-18
x86_64                randconfig-012-20240828   clang-18
x86_64                randconfig-013-20240828   clang-18
x86_64                randconfig-014-20240828   clang-18
x86_64                randconfig-015-20240828   clang-18
x86_64                randconfig-015-20240828   gcc-12
x86_64                randconfig-016-20240828   clang-18
x86_64                randconfig-016-20240828   gcc-12
x86_64                randconfig-071-20240828   clang-18
x86_64                randconfig-071-20240828   gcc-12
x86_64                randconfig-072-20240828   clang-18
x86_64                randconfig-072-20240828   gcc-12
x86_64                randconfig-073-20240828   clang-18
x86_64                randconfig-073-20240828   gcc-12
x86_64                randconfig-074-20240828   clang-18
x86_64                randconfig-074-20240828   gcc-12
x86_64                randconfig-075-20240828   clang-18
x86_64                randconfig-075-20240828   gcc-12
x86_64                randconfig-076-20240828   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240828   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

