Return-Path: <linux-efi+bounces-1222-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7519D9094E5
	for <lists+linux-efi@lfdr.de>; Sat, 15 Jun 2024 02:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC6628532B
	for <lists+linux-efi@lfdr.de>; Sat, 15 Jun 2024 00:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766ED645;
	Sat, 15 Jun 2024 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Df+97jVu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187A8F48
	for <linux-efi@vger.kernel.org>; Sat, 15 Jun 2024 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718409692; cv=none; b=dbc1SBh+2RmL7JM8K6DXR59JcWLUVxTmOJSlrs3ZT1MlaUMWo3/mkqyV93wX84eeT254ctLYJaqHv4kgZXHgu3MMcN+3wB/PcVyxagKPtJ4Xa8hYW0qvYW3R93s2J4NKrmaGNemsbARth/iQmBc8fCgTXkGs4VO4MuaNE32g9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718409692; c=relaxed/simple;
	bh=NlnI2yW7qgpquB3K1LPyiRsitFy5kxSVtQjMpbAF8Co=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hsird37viw3C5q85+CntpKN8VxUFTRsWsRq4MouZjJWAJFfws6yj1W5IsUb8TacBCiUS81J1aDrPNduJI5tByut0n5RCOnCMoa8PhMZkWwP49PILlICggK2q5fVtX+Vp65TKOujZMBiB1iSdPc4ZN51FpkdbQagm0LTbEsvR31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Df+97jVu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718409690; x=1749945690;
  h=date:from:to:cc:subject:message-id;
  bh=NlnI2yW7qgpquB3K1LPyiRsitFy5kxSVtQjMpbAF8Co=;
  b=Df+97jVuQODmWZpueHL6ew+cblCJGIVrS5NBCI7P1bngklDJTH4f7EKm
   QT3oVJIhHIZTMACE9l3xl/m/W7JfuQ0IaoBpYaOoJ3Sr98EnMVx716ogh
   4KSVf/3A8zx9cq2kuSAnnnVPEJOIKuICpoft/zLDJEBfhkYXiCkFNYl2Y
   xyH8wHzvQxuQg44iFZ+8ZHRMeayAqgWSJprWtxstB4SCi8XJDdkgJJIRV
   CcSbtv08br9Nh3Xj1rryKU9N1ERwHPwnQeLWbeE9tz0JdPdtyzt3gF/1U
   AzvQ6JFF/tXsUTzldUIeIPrdkEB7pQCapAnAiV3Gi5FOwpsQA8kWPuXcz
   Q==;
X-CSE-ConnectionGUID: Dngp7S4dR5qoB6lejd/C/w==
X-CSE-MsgGUID: GioeLE/aTKWqVcSY9MEUNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="26716086"
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="26716086"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 17:01:30 -0700
X-CSE-ConnectionGUID: QkY9M1wQSMS8oOa7MHLGaA==
X-CSE-MsgGUID: GXT0DC8ETceenCWDVjl1wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="40503244"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Jun 2024 17:01:30 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIGrH-0001vh-0E;
	Sat, 15 Jun 2024 00:01:27 +0000
Date: Sat, 15 Jun 2024 08:01:15 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 f1d4f28feb2cc93528083d94503742289ea3ecc6
Message-ID: <202406150813.xmQLUdVM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: f1d4f28feb2cc93528083d94503742289ea3ecc6  efi/arm64: Fix kmemleak false positive in arm64_efi_rt_init()

elapsed time: 1556m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240614   gcc-13.2.0
arc                   randconfig-002-20240614   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240614   gcc-13.2.0
arm                   randconfig-002-20240614   gcc-13.2.0
arm                   randconfig-003-20240614   gcc-13.2.0
arm                   randconfig-004-20240614   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240614   gcc-13.2.0
arm64                 randconfig-002-20240614   clang-19
arm64                 randconfig-003-20240614   gcc-13.2.0
arm64                 randconfig-004-20240614   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240614   gcc-13.2.0
csky                  randconfig-002-20240614   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240614   clang-19
hexagon               randconfig-002-20240614   clang-19
i386         buildonly-randconfig-001-20240614   clang-18
i386         buildonly-randconfig-002-20240614   clang-18
i386         buildonly-randconfig-003-20240614   gcc-12
i386         buildonly-randconfig-004-20240614   gcc-8
i386         buildonly-randconfig-005-20240614   gcc-13
i386         buildonly-randconfig-006-20240614   gcc-10
i386                  randconfig-001-20240614   gcc-13
i386                  randconfig-002-20240614   gcc-8
i386                  randconfig-003-20240614   gcc-13
i386                  randconfig-004-20240614   clang-18
i386                  randconfig-005-20240614   gcc-13
i386                  randconfig-006-20240614   gcc-10
i386                  randconfig-011-20240614   gcc-13
i386                  randconfig-012-20240614   clang-18
i386                  randconfig-013-20240614   gcc-13
i386                  randconfig-014-20240614   gcc-13
i386                  randconfig-015-20240614   clang-18
i386                  randconfig-016-20240614   clang-18
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240614   gcc-13.2.0
loongarch             randconfig-002-20240614   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240614   gcc-13.2.0
nios2                 randconfig-002-20240614   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240614   gcc-13.2.0
parisc                randconfig-002-20240614   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240614   gcc-13.2.0
powerpc               randconfig-002-20240614   clang-19
powerpc               randconfig-003-20240614   gcc-13.2.0
powerpc64             randconfig-001-20240614   clang-19
powerpc64             randconfig-002-20240614   gcc-13.2.0
powerpc64             randconfig-003-20240614   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240614   gcc-13.2.0
riscv                 randconfig-002-20240614   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240614   gcc-13.2.0
s390                  randconfig-002-20240614   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240614   gcc-13.2.0
sh                    randconfig-002-20240614   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240614   gcc-13.2.0
sparc64               randconfig-002-20240614   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240614   gcc-13
um                    randconfig-002-20240614   gcc-13
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240615   gcc-9
x86_64       buildonly-randconfig-002-20240615   clang-18
x86_64       buildonly-randconfig-003-20240615   clang-18
x86_64       buildonly-randconfig-004-20240615   clang-18
x86_64       buildonly-randconfig-005-20240615   gcc-9
x86_64       buildonly-randconfig-006-20240615   clang-18
x86_64                randconfig-001-20240615   gcc-13
x86_64                randconfig-002-20240615   gcc-8
x86_64                randconfig-003-20240615   gcc-13
x86_64                randconfig-004-20240615   gcc-13
x86_64                randconfig-005-20240615   gcc-13
x86_64                randconfig-006-20240615   gcc-8
x86_64                randconfig-011-20240615   clang-18
x86_64                randconfig-012-20240615   gcc-13
x86_64                randconfig-013-20240615   clang-18
x86_64                randconfig-014-20240615   clang-18
x86_64                randconfig-015-20240615   clang-18
x86_64                randconfig-016-20240615   clang-18
x86_64                randconfig-071-20240615   clang-18
x86_64                randconfig-072-20240615   clang-18
x86_64                randconfig-073-20240615   gcc-7
x86_64                randconfig-074-20240615   gcc-13
x86_64                randconfig-075-20240615   clang-18
x86_64                randconfig-076-20240615   gcc-13
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240614   gcc-13.2.0
xtensa                randconfig-002-20240614   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

