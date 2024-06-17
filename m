Return-Path: <linux-efi+bounces-1223-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC7590A19A
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 03:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34E5B21011
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 01:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB02256A;
	Mon, 17 Jun 2024 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDC1BGa0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EDA23A9
	for <linux-efi@vger.kernel.org>; Mon, 17 Jun 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718586455; cv=none; b=npgCqzAbi638D1gDcg4Uneg/Z8hqtkfoJeTpOXWkz2TYFQIyHDKRuThcbt0DYQTNknQYjdeK6+4xZaiSptByhlQnzdnuotYJFsJfzMPev64FV1jx8tNqbojaRVhX5o6xESaun7wrUQs6CRav8Lpa94kRxvyMiJa9dyR0uRRzzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718586455; c=relaxed/simple;
	bh=UtDPqE6z2ml88wEJvWk44hk19Xag0jwDchzV5s5LPeg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=D26cQhBWAQD0+OrKSXJl1sm5EAaD8Rfqd8oZX93o62LLnctRqPt0Ue2Uhg0gvrcp6tsuwJd7+QTcebZ0CRTcCtA8EoRNbVos5kGlybwIBLkL85wHwyNCIMTFqB+kEgbZhmgRGNF1VPXpgEKvAS/5VL2Mt2sAmgH0zLJ6033a2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDC1BGa0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718586453; x=1750122453;
  h=date:from:to:cc:subject:message-id;
  bh=UtDPqE6z2ml88wEJvWk44hk19Xag0jwDchzV5s5LPeg=;
  b=HDC1BGa0M5HR0ML3zKSf1kiGllmshG3liZbNqSveo1UQXb94gGm0xe9L
   UHraQ0La39bKs6n/vXQXZYXmE9Q92KsV1G7ZH6st9r/tZGZlN7ag4OjVu
   HiUciP4im0FNYRxRW83JojuvuAQ0wquMJskFw/10TjdNd9Y6Hn2G2wt2u
   u+tjt3vmY3jytYNT8z16YSGl150qvIwVkupoFyB0AccSym0KaXL+lBnSx
   IR8ZtCQE1mCYYu8IeYRaCmgHcPPTKA40MiMouQBwY5hRrHaScBCObaGBe
   BnofadO+T54k+77esluGreqk9PajqDRzvDDTh0bWTWLLMOCc0bsHmyjyz
   Q==;
X-CSE-ConnectionGUID: CtkvBnqjQgmDRL8D9+rGdw==
X-CSE-MsgGUID: nEWaYr3aRrGupmMiykuRGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="32945178"
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; 
   d="scan'208";a="32945178"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 18:07:33 -0700
X-CSE-ConnectionGUID: 4T8iox1ARfGw/qFoRE5yDw==
X-CSE-MsgGUID: 5euC7x32TP2O0Ce8URMJ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; 
   d="scan'208";a="45489838"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Jun 2024 18:07:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJ0qH-0003Zd-24;
	Mon, 17 Jun 2024 01:07:29 +0000
Date: Mon, 17 Jun 2024 09:07:26 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 46e27b9961d8712bc89234444ede314cec0e8bae
Message-ID: <202406170923.DSHqTSwP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 46e27b9961d8712bc89234444ede314cec0e8bae  efi/arm64: Fix kmemleak false positive in arm64_efi_rt_init()

elapsed time: 2395m

configs tested: 117
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20240616   gcc-13.2.0
arc                   randconfig-002-20240616   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                   randconfig-001-20240616   gcc-13.2.0
arm                   randconfig-002-20240616   gcc-13.2.0
arm                   randconfig-003-20240616   clang-16
arm                   randconfig-004-20240616   clang-19
arm                             rpc_defconfig   clang-19
arm64                 randconfig-001-20240616   gcc-13.2.0
arm64                 randconfig-002-20240616   clang-19
arm64                 randconfig-003-20240616   clang-19
arm64                 randconfig-004-20240616   clang-19
csky                  randconfig-001-20240616   gcc-13.2.0
csky                  randconfig-002-20240616   gcc-13.2.0
hexagon               randconfig-001-20240616   clang-19
hexagon               randconfig-002-20240616   clang-19
i386         buildonly-randconfig-001-20240615   clang-18
i386         buildonly-randconfig-002-20240615   gcc-9
i386         buildonly-randconfig-003-20240615   gcc-7
i386         buildonly-randconfig-004-20240615   clang-18
i386         buildonly-randconfig-005-20240615   clang-18
i386         buildonly-randconfig-006-20240615   gcc-13
i386                  randconfig-001-20240615   clang-18
i386                  randconfig-002-20240615   gcc-13
i386                  randconfig-003-20240615   clang-18
i386                  randconfig-004-20240615   clang-18
i386                  randconfig-005-20240615   clang-18
i386                  randconfig-006-20240615   clang-18
i386                  randconfig-011-20240615   clang-18
i386                  randconfig-012-20240615   gcc-12
i386                  randconfig-013-20240615   gcc-13
i386                  randconfig-014-20240615   clang-18
i386                  randconfig-015-20240615   clang-18
i386                  randconfig-016-20240615   gcc-13
loongarch             randconfig-001-20240616   gcc-13.2.0
loongarch             randconfig-002-20240616   gcc-13.2.0
m68k                          amiga_defconfig   gcc-13.2.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                           ip32_defconfig   clang-19
mips                      loongson3_defconfig   gcc-13.2.0
mips                        omega2p_defconfig   clang-19
nios2                 randconfig-001-20240616   gcc-13.2.0
nios2                 randconfig-002-20240616   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240616   gcc-13.2.0
parisc                randconfig-002-20240616   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                       holly_defconfig   clang-19
powerpc                   lite5200b_defconfig   clang-14
powerpc                      makalu_defconfig   clang-19
powerpc                      mgcoge_defconfig   clang-19
powerpc                     mpc512x_defconfig   clang-19
powerpc                      ppc64e_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240616   gcc-13.2.0
powerpc               randconfig-002-20240616   clang-19
powerpc               randconfig-003-20240616   gcc-13.2.0
powerpc                  storcenter_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240616   gcc-13.2.0
powerpc64             randconfig-002-20240616   clang-19
powerpc64             randconfig-003-20240616   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240616   clang-14
riscv                 randconfig-002-20240616   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240616   clang-19
s390                  randconfig-002-20240616   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240616   gcc-13.2.0
sh                    randconfig-002-20240616   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240616   gcc-13.2.0
sparc64               randconfig-002-20240616   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240616   gcc-13
um                    randconfig-002-20240616   gcc-10
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240616   clang-18
x86_64       buildonly-randconfig-002-20240616   clang-18
x86_64       buildonly-randconfig-003-20240616   clang-18
x86_64       buildonly-randconfig-004-20240616   clang-18
x86_64       buildonly-randconfig-005-20240616   gcc-13
x86_64       buildonly-randconfig-006-20240616   clang-18
x86_64                randconfig-001-20240616   gcc-13
x86_64                randconfig-002-20240616   clang-18
x86_64                randconfig-003-20240616   clang-18
x86_64                randconfig-004-20240616   clang-18
x86_64                randconfig-005-20240616   clang-18
x86_64                randconfig-006-20240616   clang-18
x86_64                randconfig-011-20240616   gcc-13
x86_64                randconfig-012-20240616   gcc-13
x86_64                randconfig-013-20240616   clang-18
x86_64                randconfig-014-20240616   gcc-10
x86_64                randconfig-015-20240616   clang-18
x86_64                randconfig-016-20240616   gcc-13
x86_64                randconfig-071-20240616   clang-18
x86_64                randconfig-072-20240616   clang-18
x86_64                randconfig-073-20240616   gcc-13
x86_64                randconfig-074-20240616   clang-18
x86_64                randconfig-075-20240616   gcc-13
x86_64                randconfig-076-20240616   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                generic_kc705_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240616   gcc-13.2.0
xtensa                randconfig-002-20240616   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

