Return-Path: <linux-efi+bounces-2814-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2833A40A86
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2025 18:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA423B8339
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2025 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79458EEDE;
	Sat, 22 Feb 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZK646RFn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824613BAF1
	for <linux-efi@vger.kernel.org>; Sat, 22 Feb 2025 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740244128; cv=none; b=GJtYHLPh2AOrSbrS3+bTToWHRHG1HV6yXyUdtYI5n2gmRSW8jxpq30hkVphj/thebjWwqJDK8YYDnhjpABuvAlTwT5XulyJPwszqQdmQ/wFnX8rrGE5b/Z5MwdrmuE8qJDOOz7T2yURCNB0mDaayCUk5rYv+QRLUgXCM3piHbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740244128; c=relaxed/simple;
	bh=muAgS6R6AChxh6JvV1L0IcO9wcatnlD6ID4DutnCALs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mv1DHYV46vjqkc9QzOfL7HJ4ic9YDID+8KkA+atVTfai/rC5NBIkoFKfxeMrs34KvBnJJPyk6oOv7fYpzUE1jK0nPkjvH1ulw/t9wKM9ggRJurmsIUNUiBTaL9TbiX9CLiPh5CaHRXwVMHaB4JuE88dTHHqnlpXu+9MoedQIgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZK646RFn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740244125; x=1771780125;
  h=date:from:to:cc:subject:message-id;
  bh=muAgS6R6AChxh6JvV1L0IcO9wcatnlD6ID4DutnCALs=;
  b=ZK646RFnt0cQ3uvcl32ZGNG3NhBjdrzlOlvdr+DZNeRzU1nWFWJIy38s
   QftLIrrBySeJ5BCGpK5Kvo7kLS09ERSZW/9OGwFeLP2K2vK1Jndz3TSXg
   7TiDPlrlyiEWP+asUI3NsoNiAp0UgyENdLQn7eS7FwmipgRAWrxns/hAM
   qhBJpATcP7LysEPkfq9Onef8On/DQvJ3iTpjSNsbaTFStrS1GaK09Hs5B
   F6P/XuovsHbr9kLZIwAzCM4AejBLt/vpIEjUcK2F9SfBWVXSEStY+E7Hs
   ZOJ2GCDunEN9u4wVf+GeT+MS/0c0zi+6yUt9DOwzUOJ4NaFS9YHg9Vf1Y
   w==;
X-CSE-ConnectionGUID: M9T9noqLTXq0EAI5w6BHJg==
X-CSE-MsgGUID: y6boosU7RaWfiil3gZa8cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="44700199"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="44700199"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 09:08:44 -0800
X-CSE-ConnectionGUID: gLz4U1Q+Rrm+z4nqSCQhJA==
X-CSE-MsgGUID: +xLDHqfnTu6HFmob+EzFwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="120748295"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 22 Feb 2025 09:08:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlszZ-0006kh-1z;
	Sat, 22 Feb 2025 17:08:41 +0000
Date: Sun, 23 Feb 2025 01:08:15 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 fb84cefd4ce77c3d63cd3d23adaa7faaef3737cc
Message-ID: <202502230109.Ihk7A5vT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: fb84cefd4ce77c3d63cd3d23adaa7faaef3737cc  x86/efi/mixed: Move mixed mode startup code into libstub

elapsed time: 1448m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250222    gcc-13.2.0
arc                  randconfig-002-20250222    gcc-13.2.0
arm                  randconfig-001-20250222    gcc-14.2.0
arm                  randconfig-002-20250222    gcc-14.2.0
arm                  randconfig-003-20250222    clang-16
arm                  randconfig-004-20250222    gcc-14.2.0
arm64                randconfig-001-20250222    gcc-14.2.0
arm64                randconfig-002-20250222    clang-21
arm64                randconfig-003-20250222    clang-18
arm64                randconfig-004-20250222    clang-21
csky                 randconfig-001-20250222    gcc-14.2.0
csky                 randconfig-002-20250222    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250222    clang-17
hexagon              randconfig-002-20250222    clang-19
i386       buildonly-randconfig-001-20250222    clang-19
i386       buildonly-randconfig-002-20250222    gcc-12
i386       buildonly-randconfig-003-20250222    gcc-12
i386       buildonly-randconfig-004-20250222    clang-19
i386       buildonly-randconfig-005-20250222    gcc-12
i386       buildonly-randconfig-006-20250222    clang-19
loongarch            randconfig-001-20250222    gcc-14.2.0
loongarch            randconfig-002-20250222    gcc-14.2.0
nios2                randconfig-001-20250222    gcc-14.2.0
nios2                randconfig-002-20250222    gcc-14.2.0
parisc               randconfig-001-20250222    gcc-14.2.0
parisc               randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-001-20250222    gcc-14.2.0
powerpc              randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-003-20250222    gcc-14.2.0
powerpc64            randconfig-001-20250222    gcc-14.2.0
powerpc64            randconfig-002-20250222    clang-16
powerpc64            randconfig-003-20250222    clang-18
riscv                randconfig-001-20250222    clang-21
riscv                randconfig-002-20250222    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250222    gcc-14.2.0
s390                 randconfig-002-20250222    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250222    gcc-14.2.0
sh                   randconfig-002-20250222    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250222    gcc-14.2.0
sparc                randconfig-002-20250222    gcc-14.2.0
sparc64              randconfig-001-20250222    gcc-14.2.0
sparc64              randconfig-002-20250222    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250222    gcc-12
um                   randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-001-20250222    clang-19
x86_64     buildonly-randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-003-20250222    gcc-12
x86_64     buildonly-randconfig-004-20250222    clang-19
x86_64     buildonly-randconfig-005-20250222    clang-19
x86_64     buildonly-randconfig-006-20250222    gcc-12
xtensa               randconfig-001-20250222    gcc-14.2.0
xtensa               randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

