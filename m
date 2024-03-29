Return-Path: <linux-efi+bounces-897-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92EE89134E
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 06:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0FE287E79
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 05:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF43C068;
	Fri, 29 Mar 2024 05:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfP+MRwg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328833BBE0
	for <linux-efi@vger.kernel.org>; Fri, 29 Mar 2024 05:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690899; cv=none; b=bqKqzWP3ESgVs9qYOSdLWkjgwi8538BamVgLv/lP5drcROygQtDmNPx18f19b/PwBRpKrcJm3x9SanSCSQgi7YIgca/Src4cvjhcetUHL7eYVmfnFPjNSz5fUui17RXj6uSO+/ajrJIrQNvweejjJiLbR79fA/ETM8YHnoNchDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690899; c=relaxed/simple;
	bh=WtSAuLcos0NlfsW0WGl4M6QSUAwXoBGO6u2k9jRJ4v8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CKxBH16ocG0AuE6soJL5fxk6cgqnOZiVsgPIkohUrCuEJ1kgCOriwdyR6W5PJ7uc17IYiq2e3jr1vW94Rm1wZXxVkKc0Ws3cO97qEZ3AWxtRRJzelMNN2fZeym6FSYlTewnouiHJXhqVy47O7BR6wderLdrtKF49NGzlgNav5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfP+MRwg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711690898; x=1743226898;
  h=date:from:to:cc:subject:message-id;
  bh=WtSAuLcos0NlfsW0WGl4M6QSUAwXoBGO6u2k9jRJ4v8=;
  b=NfP+MRwgUfm8hh8ONFfYEvP+85vzTbkuTvqVd5+9h47+H/NGOVOR6HQm
   1BywTP4vn3w44zGx91zLE5PjXfV80o9M0cDoyG/ZeqZF9aIs24Huz4YnC
   9rv25gfL48N3pGO5TuiPoHNbLJH50WiRiPi3YwMQB9rbRKeK+mjHqPhjl
   6OdmU5X75ZTOGhPhk/ONN68Bb2LbPiLM1N0MD6VFEFK0r9RbwEzCFOany
   g6YO9jV9H94Og7djXmLCxo8RNCwrNELb+HHmXFXD1XfbKFluEYsGXszZW
   7ojOWKKnnF5xljjzTikyJbIEGRUXTtsy63YUM9DuQyrkWmiDnnY2IGpok
   w==;
X-CSE-ConnectionGUID: RT8e4xcLRTqfH8JM7jVSLQ==
X-CSE-MsgGUID: 2f+C+8qlQ0eUItcpLdA+7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="10679654"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="10679654"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 22:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16759325"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 Mar 2024 22:41:35 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rq4zd-0002sw-1b;
	Fri, 29 Mar 2024 05:41:33 +0000
Date: Fri, 29 Mar 2024 13:41:30 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 decd347c2a75d32984beb8807d470b763a53b542
Message-ID: <202403291328.ngRPTnQj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: decd347c2a75d32984beb8807d470b763a53b542  x86/efistub: Reinstate soft limit for initrd loading

elapsed time: 841m

configs tested: 151
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20240329   gcc  
arc                   randconfig-002-20240329   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240329   gcc  
arm                   randconfig-002-20240329   clang
arm                   randconfig-003-20240329   clang
arm                   randconfig-004-20240329   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240329   gcc  
arm64                 randconfig-002-20240329   clang
arm64                 randconfig-003-20240329   clang
arm64                 randconfig-004-20240329   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240329   gcc  
csky                  randconfig-002-20240329   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240329   clang
hexagon               randconfig-002-20240329   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240329   gcc  
i386         buildonly-randconfig-002-20240329   clang
i386         buildonly-randconfig-003-20240329   clang
i386         buildonly-randconfig-004-20240329   clang
i386         buildonly-randconfig-005-20240329   clang
i386         buildonly-randconfig-006-20240329   clang
i386                                defconfig   clang
i386                  randconfig-001-20240329   clang
i386                  randconfig-002-20240329   clang
i386                  randconfig-003-20240329   clang
i386                  randconfig-004-20240329   clang
i386                  randconfig-005-20240329   clang
i386                  randconfig-006-20240329   clang
i386                  randconfig-011-20240329   clang
i386                  randconfig-012-20240329   clang
i386                  randconfig-013-20240329   gcc  
i386                  randconfig-014-20240329   gcc  
i386                  randconfig-015-20240329   gcc  
i386                  randconfig-016-20240329   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240329   gcc  
loongarch             randconfig-002-20240329   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240329   gcc  
nios2                 randconfig-002-20240329   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240329   gcc  
parisc                randconfig-002-20240329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240329   clang
powerpc               randconfig-002-20240329   gcc  
powerpc               randconfig-003-20240329   clang
powerpc64             randconfig-001-20240329   gcc  
powerpc64             randconfig-002-20240329   clang
powerpc64             randconfig-003-20240329   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240329   gcc  
riscv                 randconfig-002-20240329   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240329   clang
s390                  randconfig-002-20240329   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240329   gcc  
sh                    randconfig-002-20240329   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240329   gcc  
sparc64               randconfig-002-20240329   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240329   clang
um                    randconfig-002-20240329   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240329   clang
x86_64       buildonly-randconfig-002-20240329   gcc  
x86_64       buildonly-randconfig-003-20240329   gcc  
x86_64       buildonly-randconfig-004-20240329   clang
x86_64       buildonly-randconfig-005-20240329   gcc  
x86_64       buildonly-randconfig-006-20240329   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240329   gcc  
x86_64                randconfig-002-20240329   gcc  
x86_64                randconfig-003-20240329   clang
x86_64                randconfig-004-20240329   gcc  
x86_64                randconfig-005-20240329   clang
x86_64                randconfig-006-20240329   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240329   gcc  
xtensa                randconfig-002-20240329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

