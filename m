Return-Path: <linux-efi+bounces-2378-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DE39F1D31
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2024 08:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DE918861CE
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2024 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599B1CD2C;
	Sat, 14 Dec 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSzs0SEE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7F80038
	for <linux-efi@vger.kernel.org>; Sat, 14 Dec 2024 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734163127; cv=none; b=IExj7kF5LnDlupqwUTuckhEEhCDGc3iyMkhgZqkvKoNAj8nupVD48/xvmLTMdFS5XEPWfu87duUChlSQKsHRoMaOzjf/vGmVmAY2eriJuWETE5GEXBjb56hzYJ8fbWiplYB2f+5f4li/2lKe+GrzGT1MifXJ7OVY8R/QS83i3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734163127; c=relaxed/simple;
	bh=YVnaV5A1S0072ylyvxxNa8ZR+dRD1BRKZq5lHv7ejAo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=J5RABWdUhDoNEg5d0De34o1ax3SehwCDLQQDhWZxWFWcSudLksU8Fe2rlwOuyver83ZL5ZTJu0ldb7Y3KBtxbAzqeXPK4FhPUEWFu20cvSNdbf9mlQ+lNA12di4BlF7q41OhSlQdqe/U+sWzAyn8ED2ZWHs2dY8EtOhbGCH+uEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSzs0SEE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734163125; x=1765699125;
  h=date:from:to:cc:subject:message-id;
  bh=YVnaV5A1S0072ylyvxxNa8ZR+dRD1BRKZq5lHv7ejAo=;
  b=hSzs0SEEIwvBrpA6HheS+t1LbH8zQiKngEiD33QDlFEWYJkCxaCp5eSc
   aOh/i5MHP+2p/15tfr8LSqVQ36hjJZiKyS/VsZxBooYH7XQ0s7u6SDLWD
   7LgKvtD3NKTElN0CNmWxBuosPn0DrvDhJ0zENqowF9Wd2Y0EYQkQAHXtb
   wmzlu+a909nevbeRj6+czK+aAqHphLc/M8+NxUaMsxml2/CYonlk5BJiv
   xpEUDDeAVvlazs/cVmzVHFZZ7/VlKCVVMjE9EjFmyjc4dG366AbMGtWbB
   aCwj3kgicU2NDv9HM6nFUa4fHoi8E4RTNnAxa0/PBt1o48003RfhLn/EH
   A==;
X-CSE-ConnectionGUID: QuhC0cCFSf6yugM8BrD+NQ==
X-CSE-MsgGUID: KJcrA6tTSL2+XJr8QxTPfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45098618"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45098618"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 23:58:44 -0800
X-CSE-ConnectionGUID: e76+c0C6TfCu6d6F5i2PGg==
X-CSE-MsgGUID: h1LIO+slTYKT8d6cB5filw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101326887"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Dec 2024 23:58:43 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMN2v-000Cml-03;
	Sat, 14 Dec 2024 07:58:41 +0000
Date: Sat, 14 Dec 2024 15:57:45 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 145ac100b63732291c0612528444d7f5ab593fb2
Message-ID: <202412141537.XVyovBFl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 145ac100b63732291c0612528444d7f5ab593fb2  efi/esrt: remove esre_attribute::store()

elapsed time: 1450m

configs tested: 80
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                 nsimosci_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20241213    gcc-13.2.0
arc                   randconfig-002-20241213    gcc-13.2.0
arm                   randconfig-001-20241213    clang-16
arm                   randconfig-002-20241213    clang-18
arm                   randconfig-003-20241213    gcc-14.2.0
arm                   randconfig-004-20241213    clang-18
arm64                 randconfig-001-20241213    gcc-14.2.0
arm64                 randconfig-002-20241213    gcc-14.2.0
arm64                 randconfig-003-20241213    clang-18
arm64                 randconfig-004-20241213    gcc-14.2.0
csky                  randconfig-001-20241213    gcc-14.2.0
csky                  randconfig-002-20241213    gcc-14.2.0
hexagon               randconfig-001-20241213    clang-20
hexagon               randconfig-002-20241213    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20241213    clang-19
i386        buildonly-randconfig-002-20241213    gcc-12
i386        buildonly-randconfig-003-20241213    gcc-12
i386        buildonly-randconfig-004-20241213    clang-19
i386        buildonly-randconfig-005-20241213    gcc-12
i386        buildonly-randconfig-006-20241213    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20241213    gcc-14.2.0
loongarch             randconfig-002-20241213    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241213    gcc-14.2.0
nios2                 randconfig-002-20241213    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20241213    gcc-14.2.0
parisc                randconfig-002-20241213    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20241213    gcc-14.2.0
powerpc               randconfig-002-20241213    clang-20
powerpc               randconfig-003-20241213    gcc-14.2.0
powerpc64             randconfig-001-20241213    gcc-14.2.0
powerpc64             randconfig-002-20241213    gcc-14.2.0
powerpc64             randconfig-003-20241213    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20241213    gcc-14.2.0
riscv                 randconfig-002-20241213    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241213    gcc-14.2.0
s390                  randconfig-002-20241213    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241213    gcc-14.2.0
sh                    randconfig-002-20241213    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241213    gcc-14.2.0
sparc                 randconfig-002-20241213    gcc-14.2.0
sparc64               randconfig-001-20241213    gcc-14.2.0
sparc64               randconfig-002-20241213    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20241213    gcc-12
um                    randconfig-002-20241213    clang-16
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20241213    gcc-12
x86_64      buildonly-randconfig-002-20241213    gcc-12
x86_64      buildonly-randconfig-003-20241213    gcc-12
x86_64      buildonly-randconfig-004-20241213    gcc-12
x86_64      buildonly-randconfig-005-20241213    gcc-12
x86_64      buildonly-randconfig-006-20241213    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241213    gcc-14.2.0
xtensa                randconfig-002-20241213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

