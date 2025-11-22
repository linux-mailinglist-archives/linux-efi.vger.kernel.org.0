Return-Path: <linux-efi+bounces-5656-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C50C7D400
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 17:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D57C4E0397
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BDC17A2FB;
	Sat, 22 Nov 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GphWKXII"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4615E5BB
	for <linux-efi@vger.kernel.org>; Sat, 22 Nov 2025 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763829426; cv=none; b=AlxX188KJWO/nzwjMPf4PGZE5Wx63qKCvV4PsQd0qzjPfRU4h34hVZogLkTQfd2ZzIBebr7ZcObzyGjdGVlGmA9xfzz4GZrdN9AgsqzHFVsho1AdAr2ee+oc+3nAenPC14X0BQ+jlw+sczfVsenqqNn+UBKarNKQv52SrjgcLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763829426; c=relaxed/simple;
	bh=rqNR1OKFT+ryf1Mn90pOfVVgpOUdUDHcGlOZXahGfEw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=A+w/xdGp0Y209B/gPNvuvC8nm9YfiefgHyxPdqF+L6qLq03Ny5+Tt+1OjW3w5oavCwsg3xqI3cy8jLOIOiXV8UenD5XbvfFyJ3xPVrHp8ClLFk9ztRevG0g+kV7PNSyDmXO0WQukJxyiHscd5ZCNdxxI52LJeyZTjkLtIDSybig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GphWKXII; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763829424; x=1795365424;
  h=date:from:to:cc:subject:message-id;
  bh=rqNR1OKFT+ryf1Mn90pOfVVgpOUdUDHcGlOZXahGfEw=;
  b=GphWKXIInU7+sJB6zdLTAo046WzVzMZZdhau9xPjZLi4wEM+4/QDFORx
   6noDrOgYmE7/+WuLja+Jym0DdyolRpaclUmCBCvnvK2nSX7OLj6MKBvMp
   88CrG50eaOmYW0GzH8OJtyFqntoUY35C1rxPWcCJnuD12iO735VZ5fyUI
   kHR88tC0MXYsr4b4+GW9c2/HKQQ8EeW79pCSOort3FodvGXqJQ7oWAsaQ
   F1YLB51Eo9Jq9s5EQ3qwVYSLizZiIDj3gdwmwYrAJGb08zHU7a6d2DB+P
   OZJDkoQdp/Qokj5bKALimYJ3xEyvapnZzGl9v1QldjicTOiSjVINTUF6L
   Q==;
X-CSE-ConnectionGUID: HQgZwKMyRdGpqtIa1oUEwA==
X-CSE-MsgGUID: YSPVge9rSsmrrMoEttXBeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="65084370"
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="65084370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 08:37:03 -0800
X-CSE-ConnectionGUID: ipDpq3ICRK23bkNn3kjtmg==
X-CSE-MsgGUID: v+HOBHmPTQ+A5EOIM63DMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="215306794"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Nov 2025 08:37:03 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMqbc-0007gt-1e;
	Sat, 22 Nov 2025 16:37:00 +0000
Date: Sun, 23 Nov 2025 00:36:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 7a2ff00c3b5e3ca1bbeb13cda52efe870be8501b
Message-ID: <202511230030.uAdNMUn5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 7a2ff00c3b5e3ca1bbeb13cda52efe870be8501b  docs: efi: add CPER functions to driver-api

elapsed time: 1911m

configs tested: 104
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20251122    gcc-14.3.0
arc                   randconfig-002-20251122    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                          pxa910_defconfig    gcc-15.1.0
arm                   randconfig-002-20251122    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251122    gcc-8.5.0
arm64                 randconfig-002-20251122    gcc-9.5.0
arm64                 randconfig-003-20251122    gcc-10.5.0
arm64                 randconfig-004-20251122    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251122    gcc-15.1.0
csky                  randconfig-002-20251122    gcc-14.3.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251122    clang-22
hexagon               randconfig-002-20251122    clang-17
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251122    clang-20
i386        buildonly-randconfig-002-20251122    clang-20
i386        buildonly-randconfig-003-20251122    gcc-14
i386        buildonly-randconfig-004-20251122    clang-20
i386        buildonly-randconfig-005-20251122    clang-20
i386        buildonly-randconfig-006-20251122    clang-20
i386                  randconfig-001-20251122    clang-20
i386                  randconfig-002-20251122    gcc-13
i386                  randconfig-003-20251122    clang-20
i386                  randconfig-004-20251122    clang-20
i386                  randconfig-005-20251122    clang-20
i386                  randconfig-006-20251122    clang-20
i386                  randconfig-007-20251122    clang-20
i386                  randconfig-011-20251122    gcc-14
i386                  randconfig-012-20251122    clang-20
i386                  randconfig-013-20251122    clang-20
i386                  randconfig-014-20251122    gcc-14
i386                  randconfig-015-20251122    clang-20
i386                  randconfig-016-20251122    gcc-12
i386                  randconfig-017-20251122    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251122    gcc-12.5.0
loongarch             randconfig-002-20251122    gcc-14.3.0
m68k                              allnoconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251122    gcc-11.5.0
nios2                 randconfig-002-20251122    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251122    gcc-14.3.0
parisc                randconfig-002-20251122    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20251122    clang-16
powerpc               randconfig-002-20251122    gcc-11.5.0
powerpc64             randconfig-001-20251122    clang-17
powerpc64             randconfig-002-20251122    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251122    clang-22
riscv                 randconfig-002-20251122    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251122    clang-16
s390                  randconfig-002-20251122    gcc-13.4.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251122    gcc-15.1.0
sh                    randconfig-002-20251122    gcc-10.5.0
sh                           se7750_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251122    gcc-14
x86_64      buildonly-randconfig-002-20251122    gcc-14
x86_64      buildonly-randconfig-003-20251122    gcc-14
x86_64      buildonly-randconfig-004-20251122    clang-20
x86_64      buildonly-randconfig-005-20251122    gcc-14
x86_64      buildonly-randconfig-006-20251122    gcc-13
x86_64                              defconfig    gcc-14
x86_64                randconfig-071-20251122    gcc-14
x86_64                randconfig-072-20251122    gcc-14
x86_64                randconfig-073-20251122    clang-20
x86_64                randconfig-074-20251122    gcc-14
x86_64                randconfig-076-20251122    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

