Return-Path: <linux-efi+bounces-154-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B138D80AE1D
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 21:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEB71F212D3
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 20:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B041C9D;
	Fri,  8 Dec 2023 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPxuAx90"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F811995
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 12:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702068154; x=1733604154;
  h=date:from:to:cc:subject:message-id;
  bh=WwJ9BweqfazVbYP99Lv4hM+j/Zms4ZcAkCU8Hd4dB/Y=;
  b=OPxuAx9094/JRByNVa2RhuAXVLXFTP+H2FNJsKRgiGLfC1sbJPmHho2T
   I89x4AnGKSMawdCQ3gZqwswUE/ogbLsx9oNsKcwSsrKCp+uH2wWxKo65d
   rYpEkPIBdLkdZT+5aLnodJsmVJBF74N5zop5nHk4L0OX9QgpYRwV/Lw1G
   itbr3WVam4gntjX7WF8PSx19Yekjs9CROnVuFAHW4zJJAUTGIENl+wuWI
   PZq/9hBCD5gIqaZHOp9ZbHGWW8xQNRrx/q0sltU2zEA5J0vaMjePgF1sa
   vXt/erUnARfsMp0m+CrZ3euVFql+iJpahw19/ec+vhDTvILEtFcJkDns5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1584737"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1584737"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 12:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="842736826"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="842736826"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2023 12:42:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBhg7-000EM7-0s;
	Fri, 08 Dec 2023 20:42:31 +0000
Date: Sat, 09 Dec 2023 04:42:14 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 772043f7ae476df19a7b2bfa096c05af8feea97a
Message-ID: <202312090412.uAW8wj8O-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 772043f7ae476df19a7b2bfa096c05af8feea97a  efi/loongarch: Use load address to calculate kernel entry address

elapsed time: 1689m

configs tested: 97
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231209   gcc  
arc                   randconfig-002-20231209   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20231209   gcc  
arm                   randconfig-002-20231209   gcc  
arm                   randconfig-003-20231209   gcc  
arm                   randconfig-004-20231209   gcc  
arm                         s5pv210_defconfig   clang
arm                         socfpga_defconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231209   gcc  
arm64                 randconfig-002-20231209   gcc  
arm64                 randconfig-003-20231209   gcc  
arm64                 randconfig-004-20231209   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231209   gcc  
csky                  randconfig-002-20231209   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231209   clang
hexagon               randconfig-002-20231209   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231208   clang
i386         buildonly-randconfig-002-20231208   clang
i386         buildonly-randconfig-003-20231208   clang
i386         buildonly-randconfig-004-20231208   clang
i386         buildonly-randconfig-005-20231208   clang
i386         buildonly-randconfig-006-20231208   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231208   clang
i386                  randconfig-002-20231208   clang
i386                  randconfig-003-20231208   clang
i386                  randconfig-004-20231208   clang
i386                  randconfig-005-20231208   clang
i386                  randconfig-006-20231208   clang
i386                  randconfig-011-20231208   gcc  
i386                  randconfig-012-20231208   gcc  
i386                  randconfig-013-20231208   gcc  
i386                  randconfig-014-20231208   gcc  
i386                  randconfig-015-20231208   gcc  
i386                  randconfig-016-20231208   gcc  
loongarch                         allnoconfig   gcc  
loongarch             randconfig-001-20231209   gcc  
loongarch             randconfig-002-20231209   gcc  
m68k                       m5275evb_defconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                  cavium_octeon_defconfig   clang
mips                     decstation_defconfig   gcc  
mips                      malta_kvm_defconfig   clang
mips                        qi_lb60_defconfig   clang
nios2                 randconfig-001-20231209   gcc  
nios2                 randconfig-002-20231209   gcc  
openrisc                         allyesconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20231209   gcc  
parisc                randconfig-002-20231209   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc               randconfig-001-20231209   gcc  
powerpc               randconfig-002-20231209   gcc  
powerpc               randconfig-003-20231209   gcc  
powerpc64             randconfig-001-20231209   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

