Return-Path: <linux-efi+bounces-3768-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69669AC1064
	for <lists+linux-efi@lfdr.de>; Thu, 22 May 2025 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEE23B0141
	for <lists+linux-efi@lfdr.de>; Thu, 22 May 2025 15:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E521029A324;
	Thu, 22 May 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFqVWQKU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C61299942
	for <linux-efi@vger.kernel.org>; Thu, 22 May 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929243; cv=none; b=A6KMZn+7fGiKeWKNVvwSd2Uc2RcSxbDn4Je2Mf1ecoU4TjF7FvZ7nlrLHvj9Z3E1HUl9Nc6BTVLxRdpOonScqOBLE9j0MPlCRS+y9QdwylUI32T12CdoKE+Yz/gYOSnBDw+SGfiXZyMUxjP8pTk6ePOV9B/yd7PLyWzt1MFPBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929243; c=relaxed/simple;
	bh=qniysPKGO7O/bAYXFjaOOwqsCTxU6JTAFdF1NDGI6HI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GIPlsYuVgl+hQ537QqpheWyLHDSmNEoGVn10ApdBcqaR77YbXVqVoSdL2Qu/BVK0V0xsKP9L7s1eohhOU49vp1ly85myraG7R0WNtCqG5fCl8S0zTXBURJFdZVWDQJi929n/O0QUIxPAstvBPLBH9puP2soWtgF0oGWTOl8rpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFqVWQKU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747929241; x=1779465241;
  h=date:from:to:cc:subject:message-id;
  bh=qniysPKGO7O/bAYXFjaOOwqsCTxU6JTAFdF1NDGI6HI=;
  b=UFqVWQKUjgzQi9d39IxPiyfWXNi2ji0z4KtNesdPc/RsdlIiAA1kCIoz
   0e8B1dZo9Gb8jjFtAsFu6jjAqNubPga/h5y/lhS03Xwov6II8T2gM0K0c
   2YNPImY/wETGW7EQteII7FWH42099Hq4dqwghRvcz9yRIlrqCpr/4qBtk
   XXfCtKcolwmVhRmivv3b/F73Px/haZRf17oFYc5O2cXeWXqXtxTn9I35q
   E1v+kqwu71IGLdp7bwYl/7c0hG3IwmYBhnQbOWGPXaVKwgnBDz6oZeUQw
   fYTqq3+ZvE8p1Wcjk03fcJhRSHdan/0WfpvFfxGs8uf7nkfUkAYRgvgCE
   w==;
X-CSE-ConnectionGUID: vuCTXezeQWuHyzEqdfWYfw==
X-CSE-MsgGUID: IhSZtG2TROibA+oj/mlMIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49862487"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="49862487"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 08:54:01 -0700
X-CSE-ConnectionGUID: niglKeNXR1S4Wq1dNFpOEA==
X-CSE-MsgGUID: V4BmykprSWKBkuLczsZftA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="141596205"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 22 May 2025 08:54:00 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI8F4-000PTc-0X;
	Thu, 22 May 2025 15:53:58 +0000
Date: Thu, 22 May 2025 23:53:30 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 46550e2b878d60923c72f0526a7aac02e8eda3d5
Message-ID: <202505222320.AW4lPVYs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 46550e2b878d60923c72f0526a7aac02e8eda3d5  include: pe.h: Fix PE definitions

elapsed time: 1455m

configs tested: 97
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250522    gcc-15.1.0
arc                   randconfig-002-20250522    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                   randconfig-001-20250522    clang-21
arm                   randconfig-002-20250522    clang-21
arm                   randconfig-003-20250522    clang-18
arm                   randconfig-004-20250522    gcc-7.5.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250522    clang-21
arm64                 randconfig-002-20250522    gcc-7.5.0
arm64                 randconfig-003-20250522    clang-21
arm64                 randconfig-004-20250522    gcc-5.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250522    gcc-15.1.0
csky                  randconfig-002-20250522    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250522    clang-17
hexagon               randconfig-002-20250522    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250522    clang-20
i386        buildonly-randconfig-002-20250522    gcc-12
i386        buildonly-randconfig-003-20250522    gcc-12
i386        buildonly-randconfig-004-20250522    gcc-12
i386        buildonly-randconfig-005-20250522    gcc-12
i386        buildonly-randconfig-006-20250522    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250522    gcc-15.1.0
loongarch             randconfig-002-20250522    gcc-15.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250522    gcc-9.3.0
nios2                 randconfig-002-20250522    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250522    gcc-6.5.0
parisc                randconfig-002-20250522    gcc-12.4.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250522    gcc-9.3.0
powerpc               randconfig-002-20250522    clang-21
powerpc               randconfig-003-20250522    gcc-7.5.0
powerpc64             randconfig-001-20250522    clang-21
powerpc64             randconfig-002-20250522    gcc-10.5.0
powerpc64             randconfig-003-20250522    gcc-7.5.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250522    gcc-9.3.0
riscv                 randconfig-002-20250522    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250522    clang-19
s390                  randconfig-002-20250522    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250522    gcc-13.3.0
sh                    randconfig-002-20250522    gcc-13.3.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250522    gcc-14.2.0
sparc                 randconfig-002-20250522    gcc-6.5.0
sparc64               randconfig-001-20250522    gcc-14.2.0
sparc64               randconfig-002-20250522    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250522    gcc-12
um                    randconfig-002-20250522    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250522    clang-20
x86_64      buildonly-randconfig-002-20250522    gcc-12
x86_64      buildonly-randconfig-003-20250522    gcc-12
x86_64      buildonly-randconfig-004-20250522    gcc-12
x86_64      buildonly-randconfig-005-20250522    gcc-12
x86_64      buildonly-randconfig-006-20250522    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250522    gcc-14.2.0
xtensa                randconfig-002-20250522    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

