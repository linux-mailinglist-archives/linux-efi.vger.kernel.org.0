Return-Path: <linux-efi+bounces-792-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25316877484
	for <lists+linux-efi@lfdr.de>; Sun, 10 Mar 2024 00:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E89B281700
	for <lists+linux-efi@lfdr.de>; Sat,  9 Mar 2024 23:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BC452F82;
	Sat,  9 Mar 2024 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekt+qU08"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31874EB4C
	for <linux-efi@vger.kernel.org>; Sat,  9 Mar 2024 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710027106; cv=none; b=HDy1o+bcIfrxrQCbMOUsxx2Dupl2WfBb+K22z8jy4iqO01Yv4mLoCOkfzDlw+obs7p52FHB9rh5R2+ynE7eWnkhJb36pQESaB3UNnpuI2BgaiDKJ8Z1nY3L6aB3eD1Ctiqf2odogYBTQVgR8LaFmnxth8R5wrbFQHVDtuznAWBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710027106; c=relaxed/simple;
	bh=8mFQpTDvxa/8k59gg4Oo7OkMkTxj+q25rAtGf9Sgm/c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tW2TXbkrw+0Z6mYtIFBr4+Y/Rd1AXHflqUgr6kX/mEqpQ6IdQdCj22XKTBkLX0uY+2xlhWXGm2ZvV141EUbhZ07vVabEiklbw4YCKjgZgSkHiNnjN/zMko7O3gQR00zEaxqIZJpXhQb2FzRNbead5GIyHHB8vBxga/mDQzjuqKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekt+qU08; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710027105; x=1741563105;
  h=date:from:to:cc:subject:message-id;
  bh=8mFQpTDvxa/8k59gg4Oo7OkMkTxj+q25rAtGf9Sgm/c=;
  b=ekt+qU089JSHOvhb2H7ncziDNkCamyPE9Zbhl8UJP9yyeBxQSwJr19Y+
   apRT+66bwW/Jf5W/btBSYBBUSuFky/G3YkfKIHBv03DE0ztZhEBGcBwpq
   b1YydQb2katMWEWBE1auRtfTlJqiEeRrwIr27eq2KLL9nGY47GEB3fWHe
   FAwRQr6JYAO1AupYoHvtVkhskcz5hkvsBB6dG0ZhxF+HJXwGFUhYevhIW
   q7VMj+pMmjP52JvQe8+5RiOgbywo3rLs0jW4ktwoiSI2ozZQXNS8kCN8P
   5mjKsZhAA0ly+hOIjgs7wtu8LHTEETHEHQA+xRwwUoomoLRfr6q4mjYvX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="5319445"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="5319445"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 15:31:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="10890256"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Mar 2024 15:31:43 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rj6AG-0007jj-2H;
	Sat, 09 Mar 2024 23:31:40 +0000
Date: Sun, 10 Mar 2024 07:30:52 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 021bc4b9d7ed8dcc90dc288e59f120fa6e3087dc
Message-ID: <202403100748.I6HQz9YY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 021bc4b9d7ed8dcc90dc288e59f120fa6e3087dc  virt: efi_secret: Convert to platform remove callback returning void

elapsed time: 732m

configs tested: 220
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
arc                   randconfig-001-20240309   gcc  
arc                   randconfig-001-20240310   gcc  
arc                   randconfig-002-20240309   gcc  
arc                   randconfig-002-20240310   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                   randconfig-001-20240309   clang
arm                   randconfig-001-20240310   gcc  
arm                   randconfig-002-20240309   gcc  
arm                   randconfig-002-20240310   gcc  
arm                   randconfig-003-20240309   clang
arm                   randconfig-003-20240310   gcc  
arm                   randconfig-004-20240309   gcc  
arm                   randconfig-004-20240310   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240309   gcc  
arm64                 randconfig-002-20240309   clang
arm64                 randconfig-002-20240310   gcc  
arm64                 randconfig-003-20240309   clang
arm64                 randconfig-004-20240309   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240309   gcc  
csky                  randconfig-001-20240310   gcc  
csky                  randconfig-002-20240309   gcc  
csky                  randconfig-002-20240310   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240309   clang
hexagon               randconfig-002-20240309   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240309   clang
i386         buildonly-randconfig-002-20240309   clang
i386         buildonly-randconfig-003-20240309   gcc  
i386         buildonly-randconfig-004-20240309   gcc  
i386         buildonly-randconfig-005-20240309   gcc  
i386         buildonly-randconfig-006-20240309   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240309   gcc  
i386                  randconfig-002-20240309   gcc  
i386                  randconfig-003-20240309   clang
i386                  randconfig-004-20240309   clang
i386                  randconfig-005-20240309   clang
i386                  randconfig-006-20240309   gcc  
i386                  randconfig-011-20240309   gcc  
i386                  randconfig-012-20240309   gcc  
i386                  randconfig-013-20240309   clang
i386                  randconfig-014-20240309   clang
i386                  randconfig-015-20240309   clang
i386                  randconfig-016-20240309   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240309   gcc  
loongarch             randconfig-001-20240310   gcc  
loongarch             randconfig-002-20240309   gcc  
loongarch             randconfig-002-20240310   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           ip22_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240309   gcc  
nios2                 randconfig-001-20240310   gcc  
nios2                 randconfig-002-20240309   gcc  
nios2                 randconfig-002-20240310   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240309   gcc  
parisc                randconfig-001-20240310   gcc  
parisc                randconfig-002-20240309   gcc  
parisc                randconfig-002-20240310   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                    mvme5100_defconfig   gcc  
powerpc               randconfig-001-20240309   gcc  
powerpc               randconfig-001-20240310   gcc  
powerpc               randconfig-002-20240309   clang
powerpc               randconfig-003-20240309   clang
powerpc64             randconfig-001-20240309   gcc  
powerpc64             randconfig-001-20240310   gcc  
powerpc64             randconfig-002-20240309   gcc  
powerpc64             randconfig-002-20240310   gcc  
powerpc64             randconfig-003-20240309   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240309   gcc  
riscv                 randconfig-001-20240310   gcc  
riscv                 randconfig-002-20240309   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240309   clang
s390                  randconfig-002-20240309   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240309   gcc  
sh                    randconfig-001-20240310   gcc  
sh                    randconfig-002-20240309   gcc  
sh                    randconfig-002-20240310   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240309   gcc  
sparc64               randconfig-001-20240310   gcc  
sparc64               randconfig-002-20240309   gcc  
sparc64               randconfig-002-20240310   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240309   clang
um                    randconfig-001-20240310   gcc  
um                    randconfig-002-20240309   clang
um                    randconfig-002-20240310   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240309   clang
x86_64       buildonly-randconfig-002-20240309   gcc  
x86_64       buildonly-randconfig-003-20240309   clang
x86_64       buildonly-randconfig-004-20240309   gcc  
x86_64       buildonly-randconfig-005-20240309   gcc  
x86_64       buildonly-randconfig-006-20240309   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240309   gcc  
x86_64                randconfig-002-20240309   clang
x86_64                randconfig-003-20240309   clang
x86_64                randconfig-004-20240309   gcc  
x86_64                randconfig-005-20240309   clang
x86_64                randconfig-006-20240309   gcc  
x86_64                randconfig-011-20240309   clang
x86_64                randconfig-012-20240309   clang
x86_64                randconfig-013-20240309   clang
x86_64                randconfig-014-20240309   gcc  
x86_64                randconfig-015-20240309   gcc  
x86_64                randconfig-016-20240309   gcc  
x86_64                randconfig-071-20240309   gcc  
x86_64                randconfig-072-20240309   gcc  
x86_64                randconfig-073-20240309   gcc  
x86_64                randconfig-074-20240309   gcc  
x86_64                randconfig-075-20240309   gcc  
x86_64                randconfig-076-20240309   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240309   gcc  
xtensa                randconfig-001-20240310   gcc  
xtensa                randconfig-002-20240309   gcc  
xtensa                randconfig-002-20240310   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

