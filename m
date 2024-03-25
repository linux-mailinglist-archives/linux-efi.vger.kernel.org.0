Return-Path: <linux-efi+bounces-876-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8FF88A280
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 14:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9DE1C38CDA
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E83A56770;
	Mon, 25 Mar 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6RUoIUL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B11586F2
	for <linux-efi@vger.kernel.org>; Mon, 25 Mar 2024 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353646; cv=none; b=DJOvpebQuf7blRVPcPQwXGIIwUdOyFf0YClO84wLKO0zkzAjBHgq2M8SllVPV19vkaK1vrbP48ujK6a9yoyQVEAN6AN6Nq9gQ/MYkOLvWCbn31GWkXYPC3zwetZlX2F9LVViksR0AbPdAC34GciPYGDJ4WYlLwZ70MjsxCnKVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353646; c=relaxed/simple;
	bh=mjC0pOy/p/eAr7IFvcgnMCg4W+yFXb5Nj9PuRBLd0U4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oyD7Ip3So6zmZX1HHN9cp7625uIbAAe8tDx+tjs74u+YOS+bYtv9J3GK0iO2K8zSUg+kkO53q9J5/USPYR3pPHRJ9Jt6iGRUzrIq8IOa8xy+Bh1eqAxeCKS+VoJcMPDjbd0VZa6rQLXT2DLloRdLpHg8CrZb5ho1b0HWvifzKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6RUoIUL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711353644; x=1742889644;
  h=date:from:to:cc:subject:message-id;
  bh=mjC0pOy/p/eAr7IFvcgnMCg4W+yFXb5Nj9PuRBLd0U4=;
  b=Z6RUoIULMQVizZ4Ovu/i0p3HsCC//DuXCjNMzW0M2cRPDdykOA8/QND3
   gwHPSxV5VzVj4BCXeVBYo7/JF2wUnjYLbzOOvtU7DkFuFCcR6eHx9nyJc
   rSz74p5A5NeKlRtsIe8Alv5IX0WQxtVCqOaZTeccqh7wkLDadabKWtbD7
   4te6LmW1cOy2l7E/sKm1DWG3RaPX7DN77Zr5fXKQkCFltCu1iBOHiNdw3
   Befu8HFhc+IFo6i+lmYQZWsn8az8Ah/ODZUkNUF+WpNWqdRzdffylOkWm
   ZWZiTFDWjSUAZ06zqRCPNukkY961ClcW5tFlYYq9TVVWrGu8UX70p5Kn4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6236028"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6236028"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 01:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="20079916"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Mar 2024 01:00:42 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rofG4-000MMU-2j;
	Mon, 25 Mar 2024 08:00:40 +0000
Date: Mon, 25 Mar 2024 16:00:18 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 bada36a9fa965a2d15ad28b95da926a98fcc6ade
Message-ID: <202403251614.WhjleUPZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: bada36a9fa965a2d15ad28b95da926a98fcc6ade  x86/efistub: Add missing boot_params for mixed mode compat entry

elapsed time: 729m

configs tested: 178
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
arc                   randconfig-001-20240325   gcc  
arc                   randconfig-002-20240325   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                           imxrt_defconfig   clang
arm                          pxa3xx_defconfig   clang
arm                   randconfig-001-20240325   clang
arm                   randconfig-002-20240325   gcc  
arm                   randconfig-003-20240325   clang
arm                   randconfig-004-20240325   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240325   clang
arm64                 randconfig-002-20240325   clang
arm64                 randconfig-003-20240325   clang
arm64                 randconfig-004-20240325   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240325   gcc  
csky                  randconfig-002-20240325   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240325   clang
hexagon               randconfig-002-20240325   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240325   clang
i386         buildonly-randconfig-002-20240325   gcc  
i386         buildonly-randconfig-003-20240325   gcc  
i386         buildonly-randconfig-004-20240325   gcc  
i386         buildonly-randconfig-005-20240325   clang
i386         buildonly-randconfig-006-20240325   clang
i386                                defconfig   clang
i386                  randconfig-001-20240325   gcc  
i386                  randconfig-002-20240325   gcc  
i386                  randconfig-003-20240325   clang
i386                  randconfig-004-20240325   gcc  
i386                  randconfig-005-20240325   gcc  
i386                  randconfig-006-20240325   clang
i386                  randconfig-011-20240325   gcc  
i386                  randconfig-012-20240325   clang
i386                  randconfig-013-20240325   clang
i386                  randconfig-014-20240325   clang
i386                  randconfig-015-20240325   gcc  
i386                  randconfig-016-20240325   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240325   gcc  
loongarch             randconfig-002-20240325   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240325   gcc  
nios2                 randconfig-002-20240325   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240325   gcc  
parisc                randconfig-002-20240325   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240325   clang
powerpc               randconfig-002-20240325   clang
powerpc               randconfig-003-20240325   clang
powerpc                     tqm8560_defconfig   gcc  
powerpc                      tqm8xx_defconfig   clang
powerpc64             randconfig-001-20240325   clang
powerpc64             randconfig-002-20240325   clang
powerpc64             randconfig-003-20240325   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240325   clang
riscv                 randconfig-002-20240325   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240325   gcc  
s390                  randconfig-002-20240325   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240325   gcc  
sh                    randconfig-002-20240325   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240325   gcc  
sparc64               randconfig-002-20240325   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240325   gcc  
um                    randconfig-002-20240325   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240325   clang
x86_64       buildonly-randconfig-002-20240325   clang
x86_64       buildonly-randconfig-003-20240325   clang
x86_64       buildonly-randconfig-004-20240325   gcc  
x86_64       buildonly-randconfig-005-20240325   clang
x86_64       buildonly-randconfig-006-20240325   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240325   clang
x86_64                randconfig-002-20240325   gcc  
x86_64                randconfig-003-20240325   gcc  
x86_64                randconfig-004-20240325   gcc  
x86_64                randconfig-005-20240325   gcc  
x86_64                randconfig-006-20240325   clang
x86_64                randconfig-011-20240325   clang
x86_64                randconfig-012-20240325   clang
x86_64                randconfig-013-20240325   gcc  
x86_64                randconfig-014-20240325   gcc  
x86_64                randconfig-015-20240325   clang
x86_64                randconfig-016-20240325   gcc  
x86_64                randconfig-071-20240325   clang
x86_64                randconfig-072-20240325   clang
x86_64                randconfig-073-20240325   gcc  
x86_64                randconfig-074-20240325   clang
x86_64                randconfig-075-20240325   clang
x86_64                randconfig-076-20240325   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240325   gcc  
xtensa                randconfig-002-20240325   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

