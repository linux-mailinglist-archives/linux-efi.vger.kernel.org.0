Return-Path: <linux-efi+bounces-883-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8188D2DA
	for <lists+linux-efi@lfdr.de>; Wed, 27 Mar 2024 00:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A350B1F3EEC0
	for <lists+linux-efi@lfdr.de>; Tue, 26 Mar 2024 23:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A06D13D8AA;
	Tue, 26 Mar 2024 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXPppQh7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2F13E036
	for <linux-efi@vger.kernel.org>; Tue, 26 Mar 2024 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711496109; cv=none; b=SxuoyjEryeaj9J6TXZILx0xn0sWAnDr9jwzS6Pw34vEvA1WIrZK3coV211t+ntNFYC3yXV5E5n66M7VVXpdz88yU8hlaOTUpdSQT4GmM9PnDjgqhIRXfkFtcRb36RFwjcVLmIgxtKIiqlpeKHegWGkVfZIfggwt7okNF4kC+M9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711496109; c=relaxed/simple;
	bh=bAbEk80XgzU438kORqOWLl4Z0ojkgf9YaTbo7MNQGqQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iDSmkGCSOp73HQAWVNU5G7AT862meTjfYZnBXdOLBX8FRbSv+Di64sNxjQmRrJK/iPSd+dtrt5lK+fm6paOkacwGAlCFXeXhiXy3pn1P/S93XObDaZJg16uR0BWENT8hF8SIqIyoVvHtLZpG4tgBkjuy+0F2/8ddVbABzmpBQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXPppQh7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711496107; x=1743032107;
  h=date:from:to:cc:subject:message-id;
  bh=bAbEk80XgzU438kORqOWLl4Z0ojkgf9YaTbo7MNQGqQ=;
  b=hXPppQh7Z9za/TLIunLrXXG5S/OQMjW2gMVjxMrAHZbhji3ChMwanOeP
   rYR0ZU2ADjTTqCE740UcAPuHoZDVouZezUK+RTESJMSMUOvj5tINZTGYd
   R0Oi0o7jhAqy/F9mF1AP/gDxk5Rxt1jQiDsgnveUg/wTv1GF09hlmJZGm
   NO5fqAak9JKfe/Zf3WuP4e4KxtdUNhY4WjlmrfbUW9rcXFGpVKOp4eFMb
   z03sPRSjAVY9F2jWgij2LcCiqLcHIA+mJ6UzuX/WFmtmrQWjMrmcjKuQO
   BNqlputIDPFSD7xkdsWEmAgOffnC6y1La4hNu3Q37cand/sbDw1q5RKn3
   g==;
X-CSE-ConnectionGUID: WwVKjWZrQluV+CAa6r3C/g==
X-CSE-MsgGUID: Z4503vO/TWiWBvuqZW+ULQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24067313"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="24067313"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 16:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16762405"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 26 Mar 2024 16:35:05 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpGJq-0000XQ-2J;
	Tue, 26 Mar 2024 23:35:02 +0000
Date: Wed, 27 Mar 2024 07:34:06 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 07263d8a5a2cea66a3f10d930fea60ce49c7dc3b
Message-ID: <202403270702.wd9Ix8rQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 07263d8a5a2cea66a3f10d930fea60ce49c7dc3b  efi/libstub: Cast away type warning in use of max()

elapsed time: 730m

configs tested: 164
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
arc                     nsimosci_hs_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
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
i386         buildonly-randconfig-001-20240326   gcc  
i386         buildonly-randconfig-002-20240326   clang
i386         buildonly-randconfig-003-20240326   clang
i386         buildonly-randconfig-003-20240327   clang
i386         buildonly-randconfig-004-20240326   gcc  
i386         buildonly-randconfig-004-20240327   clang
i386         buildonly-randconfig-005-20240326   gcc  
i386         buildonly-randconfig-005-20240327   clang
i386         buildonly-randconfig-006-20240326   gcc  
i386         buildonly-randconfig-006-20240327   clang
i386                                defconfig   clang
i386                  randconfig-001-20240326   gcc  
i386                  randconfig-002-20240326   gcc  
i386                  randconfig-003-20240326   gcc  
i386                  randconfig-003-20240327   clang
i386                  randconfig-004-20240326   clang
i386                  randconfig-005-20240326   gcc  
i386                  randconfig-005-20240327   clang
i386                  randconfig-006-20240326   clang
i386                  randconfig-011-20240326   clang
i386                  randconfig-012-20240326   gcc  
i386                  randconfig-012-20240327   clang
i386                  randconfig-013-20240326   clang
i386                  randconfig-014-20240326   clang
i386                  randconfig-014-20240327   clang
i386                  randconfig-015-20240326   clang
i386                  randconfig-016-20240326   clang
i386                  randconfig-016-20240327   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                           ip27_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   microwatt_defconfig   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
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
sh                           se7712_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20240326   clang
x86_64       buildonly-randconfig-002-20240326   gcc  
x86_64       buildonly-randconfig-003-20240326   clang
x86_64       buildonly-randconfig-004-20240326   gcc  
x86_64       buildonly-randconfig-004-20240327   clang
x86_64       buildonly-randconfig-005-20240326   gcc  
x86_64       buildonly-randconfig-006-20240326   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240326   gcc  
x86_64                randconfig-001-20240327   clang
x86_64                randconfig-002-20240326   gcc  
x86_64                randconfig-003-20240326   gcc  
x86_64                randconfig-004-20240326   clang
x86_64                randconfig-005-20240326   gcc  
x86_64                randconfig-005-20240327   clang
x86_64                randconfig-006-20240326   clang
x86_64                randconfig-006-20240327   clang
x86_64                randconfig-011-20240326   gcc  
x86_64                randconfig-012-20240326   clang
x86_64                randconfig-012-20240327   clang
x86_64                randconfig-013-20240326   gcc  
x86_64                randconfig-013-20240327   clang
x86_64                randconfig-014-20240326   gcc  
x86_64                randconfig-014-20240327   clang
x86_64                randconfig-015-20240326   clang
x86_64                randconfig-015-20240327   clang
x86_64                randconfig-016-20240326   clang
x86_64                randconfig-016-20240327   clang
x86_64                randconfig-071-20240326   clang
x86_64                randconfig-072-20240326   gcc  
x86_64                randconfig-072-20240327   clang
x86_64                randconfig-073-20240326   gcc  
x86_64                randconfig-073-20240327   clang
x86_64                randconfig-074-20240326   gcc  
x86_64                randconfig-074-20240327   clang
x86_64                randconfig-075-20240326   gcc  
x86_64                randconfig-075-20240327   clang
x86_64                randconfig-076-20240326   gcc  
x86_64                randconfig-076-20240327   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

