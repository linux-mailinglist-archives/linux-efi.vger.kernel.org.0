Return-Path: <linux-efi+bounces-436-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C583F590
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jan 2024 14:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23ABA1C20F4D
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jan 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1223757;
	Sun, 28 Jan 2024 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UILB4vqq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62FF23745
	for <linux-efi@vger.kernel.org>; Sun, 28 Jan 2024 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706447790; cv=none; b=rW93MqE8ZqiRCMwmqbdvP2nEJz9Mafku6TEmJcgl3X/yGUUkD7j/o6oLUYvk/PNJ5vFzswcZlT5EIBPmKJSk16UXpHIidR2mZpmne6lhU44uWjOMbE3s+L4RppvYh0zLdytxztJgS6eVVEuD4GfTuKV6ueJTDxzkyGXMFxHAgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706447790; c=relaxed/simple;
	bh=EPoksa4LIDF6eAvTqqO+W5OhQ8HKnJG17VQTKrzLr7Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cXvmgH2P4YDpWEg8TAjmKupVdmQF/ibR+M4nM6E30EmNYkzLpWfythMgkdiT+h2WEQLs1PAYLdts0So4f2LofONR5ac0u3f6GDT3SZLR/lvsBaBIfvWh8tlNgPO45tccY5+cGjxw562qNlf9ReS3oQccf1upqWkxaJagnB2UhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UILB4vqq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706447790; x=1737983790;
  h=date:from:to:cc:subject:message-id;
  bh=EPoksa4LIDF6eAvTqqO+W5OhQ8HKnJG17VQTKrzLr7Q=;
  b=UILB4vqq9OqOTpYwcTL+4TkpeBXKnoVTXb26hRaz0wOWswGLKvmuQmlf
   LptN/5PRWpV7Nuu/Uc+OF5FdHlyA1YjJ8AJkCrcxpd6r3qBfBFQqfi1Qh
   53GNDD7zZX32lKlHnD6s88e2i53BbvAIoZpGBOjKJn543ZAkLT85YPcfI
   YCingBpWCsnS4zOmHWBpnX6xFqZjg/C0ZnslsRZZPT+gvj0WMIHZSsFtv
   MR/RFrDxGJH36qVJZS6QAhqXpEFXzPnHq6LVv9ykUs2Fc9UkoYmb1oWtx
   9+/jl0FOwQfW4+1jzhPTzqGKr4FKtrUL3qIW0WPFGjdFttEBeqWb4+1Mz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="16131403"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="16131403"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 05:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35885197"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Jan 2024 05:16:28 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU51N-0003PO-19;
	Sun, 28 Jan 2024 13:16:25 +0000
Date: Sun, 28 Jan 2024 21:16:20 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 9ec96d83b3d3c0759c9a7e59c6aa1510b49cb049
Message-ID: <202401282118.JcjWVj1k-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 9ec96d83b3d3c0759c9a7e59c6aa1510b49cb049  efi/libstub: Add one kernel-doc comment

elapsed time: 2596m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240128   gcc  
arc                   randconfig-002-20240128   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240128   clang
arm                   randconfig-002-20240128   clang
arm                   randconfig-003-20240128   clang
arm                   randconfig-004-20240128   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240128   clang
arm64                 randconfig-002-20240128   clang
arm64                 randconfig-003-20240128   clang
arm64                 randconfig-004-20240128   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240128   gcc  
csky                  randconfig-002-20240128   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240127   gcc  
i386         buildonly-randconfig-002-20240127   gcc  
i386         buildonly-randconfig-003-20240127   gcc  
i386         buildonly-randconfig-004-20240127   gcc  
i386         buildonly-randconfig-005-20240127   gcc  
i386         buildonly-randconfig-006-20240127   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240127   gcc  
i386                  randconfig-002-20240127   gcc  
i386                  randconfig-003-20240127   gcc  
i386                  randconfig-004-20240127   gcc  
i386                  randconfig-005-20240127   gcc  
i386                  randconfig-006-20240127   gcc  
i386                  randconfig-011-20240127   clang
i386                  randconfig-012-20240127   clang
i386                  randconfig-013-20240127   clang
i386                  randconfig-014-20240127   clang
i386                  randconfig-015-20240127   clang
i386                  randconfig-016-20240127   clang
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240128   clang
x86_64       buildonly-randconfig-002-20240128   clang
x86_64       buildonly-randconfig-003-20240128   clang
x86_64       buildonly-randconfig-004-20240128   clang
x86_64       buildonly-randconfig-005-20240128   clang
x86_64       buildonly-randconfig-006-20240128   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240128   gcc  
x86_64                randconfig-002-20240128   gcc  
x86_64                randconfig-003-20240128   gcc  
x86_64                randconfig-006-20240128   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

