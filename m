Return-Path: <linux-efi+bounces-2867-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4F8A4A0D0
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 18:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904F61899E52
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5D51624C3;
	Fri, 28 Feb 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIIaOfgn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2115ECDF
	for <linux-efi@vger.kernel.org>; Fri, 28 Feb 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765015; cv=none; b=deHhcWtANkn4Q7feYukjG33OXQ+jQeQkD7uR20muKyHGtecI7/W4o+V+sE3mJX4Rxt1O3NfX4If0es5ObYJ7pmH0MgH8Go9IvETQJ96U5RbDWLIkW/I84MtSrg3VWlhCU5QXiY5EAAfxesH9T030RQl0MwT6a84qN3EkswF60XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765015; c=relaxed/simple;
	bh=v9OfeOEBnHuvFLyItd3rUTugB3AAEDfziqAp6MlPxaY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Hz7gVsd3pJwIvaokHG6h1OkEfoe+s5MJ//FiIHFOXoINGj+XaudNOajN+CHIJOOYeLvfSxUVsTCg7+H4kCOXnFkGau0Xi1ZNkSZ+5Eh1W693Zb42U1nA5puygVZr1HiUsm0iDcAfE9EFA/u60YtpkPdpWrWmCDHemgZvhtPzW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIIaOfgn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740765014; x=1772301014;
  h=date:from:to:cc:subject:message-id;
  bh=v9OfeOEBnHuvFLyItd3rUTugB3AAEDfziqAp6MlPxaY=;
  b=DIIaOfgnnWLGDpecWdM3TvrKMBHazG/8ggsX0fEGCFdmqFpPLUlK3gIm
   y7Kxcn3JVnPIZjWVzhCz8eE2l6DPS+25slh/vpM6PzThh1E78fAhwDLvx
   63Njfm3aMaEz9kHzXq+msLgH3bFjqaMyOkMF063n/12rfXO6iGeLgzUMf
   LTGKOb9/4jTNJQEnoIezUtv+a0sUBcDYFGFSrU/fPth2b0zVH3AMmXCIM
   ffhemIyOsz+m/dj+3ePfZJaFsumX85piwNyELoFpeEdxup2WLfYPwwBsJ
   GpjzwDVYXB1gqaWp3RRIW7KF4OSwA+VWwXQtuwbR0i/H2gH5XUuq3LYaK
   w==;
X-CSE-ConnectionGUID: Stzp67tOQ1638i/AZRGFqA==
X-CSE-MsgGUID: AxkQc2wJSKaJByTLG4lN7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="40942161"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="40942161"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 09:50:13 -0800
X-CSE-ConnectionGUID: UCxN1FjFRzepaoL6rhZ8cw==
X-CSE-MsgGUID: ZUvfcbJwQv2+k8kT9VC+Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118307533"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 28 Feb 2025 09:50:12 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to4Ut-000FJa-0u;
	Fri, 28 Feb 2025 17:50:07 +0000
Date: Sat, 01 Mar 2025 01:49:28 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 e3cf2d91d0583cae70aeb512da87e3ade25ea912
Message-ID: <202503010122.DO1w2MxG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: e3cf2d91d0583cae70aeb512da87e3ade25ea912  efi/mokvar-table: Avoid repeated map/unmap of the same page

elapsed time: 1458m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250228    gcc-13.2.0
arc                  randconfig-002-20250228    gcc-13.2.0
arm                  randconfig-001-20250228    clang-21
arm                  randconfig-002-20250228    gcc-14.2.0
arm                  randconfig-003-20250228    gcc-14.2.0
arm                  randconfig-004-20250228    gcc-14.2.0
arm64                randconfig-001-20250228    gcc-14.2.0
arm64                randconfig-002-20250228    clang-21
arm64                randconfig-003-20250228    clang-16
arm64                randconfig-004-20250228    gcc-14.2.0
csky                 randconfig-001-20250228    gcc-14.2.0
csky                 randconfig-002-20250228    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250228    clang-19
hexagon              randconfig-002-20250228    clang-21
i386       buildonly-randconfig-001-20250228    clang-19
i386       buildonly-randconfig-002-20250228    clang-19
i386       buildonly-randconfig-003-20250228    gcc-12
i386       buildonly-randconfig-004-20250228    clang-19
i386       buildonly-randconfig-005-20250228    clang-19
i386       buildonly-randconfig-006-20250228    clang-19
loongarch            randconfig-001-20250228    gcc-14.2.0
loongarch            randconfig-002-20250228    gcc-14.2.0
nios2                randconfig-001-20250228    gcc-14.2.0
nios2                randconfig-002-20250228    gcc-14.2.0
parisc               randconfig-001-20250228    gcc-14.2.0
parisc               randconfig-002-20250228    gcc-14.2.0
powerpc              randconfig-001-20250228    gcc-14.2.0
powerpc              randconfig-002-20250228    clang-16
powerpc              randconfig-003-20250228    clang-18
powerpc64            randconfig-001-20250228    clang-16
powerpc64            randconfig-002-20250228    clang-18
powerpc64            randconfig-003-20250228    gcc-14.2.0
riscv                randconfig-001-20250228    gcc-14.2.0
riscv                randconfig-002-20250228    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250228    gcc-14.2.0
s390                 randconfig-002-20250228    clang-17
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250228    gcc-14.2.0
sh                   randconfig-002-20250228    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250228    gcc-14.2.0
sparc                randconfig-002-20250228    gcc-14.2.0
sparc64              randconfig-001-20250228    gcc-14.2.0
sparc64              randconfig-002-20250228    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250228    clang-21
um                   randconfig-002-20250228    clang-21
x86_64     buildonly-randconfig-001-20250228    clang-19
x86_64     buildonly-randconfig-002-20250228    clang-19
x86_64     buildonly-randconfig-003-20250228    gcc-12
x86_64     buildonly-randconfig-004-20250228    clang-19
x86_64     buildonly-randconfig-005-20250228    gcc-12
x86_64     buildonly-randconfig-006-20250228    gcc-12
xtensa               randconfig-001-20250228    gcc-14.2.0
xtensa               randconfig-002-20250228    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

