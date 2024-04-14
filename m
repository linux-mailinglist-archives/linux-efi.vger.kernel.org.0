Return-Path: <linux-efi+bounces-943-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F08A406B
	for <lists+linux-efi@lfdr.de>; Sun, 14 Apr 2024 07:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896A428247A
	for <lists+linux-efi@lfdr.de>; Sun, 14 Apr 2024 05:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3674A1947D;
	Sun, 14 Apr 2024 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYbS8Vli"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3428EC
	for <linux-efi@vger.kernel.org>; Sun, 14 Apr 2024 05:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713073118; cv=none; b=rZ4B8kPCLH1gQLzdfD+NPD9GULFqCRsSYeS+aHU3+hKKPFr1Khu1gTM02bS5Ew45ySjdeE+KbcwB322j7gRLPG7EwN5aDWj1qFwOpafwyXDjx6pGgFvcj3nV6pYu93bbfFw+RyLCOhmx73WbLgNOPiJByZohbYBkNJ9CFNAcdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713073118; c=relaxed/simple;
	bh=HGTv7PGSeeNIR1XyB1WYXVlJ44XYpswf4z9tvXjjwvY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U8rWVy0RR1GX8yCXOOKhyOENei5CfJoowQgviP5hfcIiup2BYTxF8BifWq5JAswSRa9zrrFy8QPZHmZ4M8M8B62fy96EFCy2Vl7nRUT/A3o+oacG3WTV1Iv+p3XpJ0Vhc0NaukOgQGZ+JNfftxGMMp6kVsJr4R8hP1yPiDlW4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYbS8Vli; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713073116; x=1744609116;
  h=date:from:to:cc:subject:message-id;
  bh=HGTv7PGSeeNIR1XyB1WYXVlJ44XYpswf4z9tvXjjwvY=;
  b=HYbS8Vli/LFMqgy9ZIddOlJRw6KKytfwjSNY4jfflLuPEvl1K4ATEQk3
   ySnq9qFirQszdmzXu0RTvWcDt241FvVOlWOTia8KX/vx9cjS1qkCm1qte
   sdJBkkPx1CrKeYCItVZY1bkjzb/Ow4Za+INwUmkMJ1F/dHQo/M0knjBli
   5QZIHp/DVpU+MuFcT4FkP+BBzyr3ooNG9YgdKf5oPZ2GdDc+l9UpkMebd
   /Gqz3iK+p/Y9c4oE4B7FBaHcVlAwJ/bS2JSZ6SkSWIkAlMZR9Lx+LRxDY
   j5QCf8c/9gJdU5XxQxKmMxB3rPTioTQd6+AInwi+2bq1H9sbBGXLUex4J
   Q==;
X-CSE-ConnectionGUID: WAEl3isBTTy2zmQhTsDfiA==
X-CSE-MsgGUID: D8B2xa+4ThmgM/TcUXuqdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11043"; a="33873705"
X-IronPort-AV: E=Sophos;i="6.07,200,1708416000"; 
   d="scan'208";a="33873705"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 22:38:36 -0700
X-CSE-ConnectionGUID: PQlpEd7BQ9i4Tjoo0kEt9A==
X-CSE-MsgGUID: kj0hhQQST52sKAdc9Vtamg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,200,1708416000"; 
   d="scan'208";a="26150196"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 13 Apr 2024 22:38:34 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvsZU-0003Oi-1F;
	Sun, 14 Apr 2024 05:38:32 +0000
Date: Sun, 14 Apr 2024 13:38:20 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 cda30c6542c8bb445bc84f6616cac8d012547f0a
Message-ID: <202404141317.9V8MeUt6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: cda30c6542c8bb445bc84f6616cac8d012547f0a  efi: Clear up misconceptions about a maximum variable name size

elapsed time: 1236m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240413   gcc  
i386         buildonly-randconfig-001-20240414   gcc  
i386         buildonly-randconfig-002-20240413   gcc  
i386         buildonly-randconfig-003-20240413   clang
i386         buildonly-randconfig-003-20240414   gcc  
i386         buildonly-randconfig-004-20240413   clang
i386         buildonly-randconfig-004-20240414   gcc  
i386         buildonly-randconfig-005-20240413   clang
i386         buildonly-randconfig-005-20240414   gcc  
i386         buildonly-randconfig-006-20240413   clang
i386         buildonly-randconfig-006-20240414   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240413   clang
i386                  randconfig-002-20240413   gcc  
i386                  randconfig-002-20240414   gcc  
i386                  randconfig-003-20240413   clang
i386                  randconfig-003-20240414   gcc  
i386                  randconfig-004-20240413   gcc  
i386                  randconfig-004-20240414   gcc  
i386                  randconfig-005-20240413   clang
i386                  randconfig-005-20240414   gcc  
i386                  randconfig-006-20240413   clang
i386                  randconfig-011-20240413   gcc  
i386                  randconfig-012-20240413   clang
i386                  randconfig-013-20240413   gcc  
i386                  randconfig-013-20240414   gcc  
i386                  randconfig-014-20240413   gcc  
i386                  randconfig-014-20240414   gcc  
i386                  randconfig-015-20240413   clang
i386                  randconfig-016-20240413   gcc  
i386                  randconfig-016-20240414   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240414   clang
x86_64       buildonly-randconfig-002-20240414   clang
x86_64       buildonly-randconfig-003-20240414   clang
x86_64       buildonly-randconfig-004-20240414   clang
x86_64       buildonly-randconfig-005-20240414   gcc  
x86_64       buildonly-randconfig-006-20240414   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240414   gcc  
x86_64                randconfig-002-20240414   clang
x86_64                randconfig-003-20240414   gcc  
x86_64                randconfig-004-20240414   gcc  
x86_64                randconfig-005-20240414   clang
x86_64                randconfig-006-20240414   clang
x86_64                randconfig-011-20240414   clang
x86_64                randconfig-012-20240414   gcc  
x86_64                randconfig-013-20240414   gcc  
x86_64                randconfig-014-20240414   gcc  
x86_64                randconfig-015-20240414   gcc  
x86_64                randconfig-016-20240414   gcc  
x86_64                randconfig-071-20240414   gcc  
x86_64                randconfig-072-20240414   clang
x86_64                randconfig-073-20240414   clang
x86_64                randconfig-074-20240414   gcc  
x86_64                randconfig-075-20240414   clang
x86_64                randconfig-076-20240414   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

