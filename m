Return-Path: <linux-efi+bounces-467-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C98F848FDD
	for <lists+linux-efi@lfdr.de>; Sun,  4 Feb 2024 19:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2261F21166
	for <lists+linux-efi@lfdr.de>; Sun,  4 Feb 2024 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA34824A03;
	Sun,  4 Feb 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdSh17AK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1124A08
	for <linux-efi@vger.kernel.org>; Sun,  4 Feb 2024 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707070479; cv=none; b=KX/gafduvGzZzLz8xCw5UBRZXqlK9lEkP1H9/EzSqraBb7iT+h2+iyxkPpcrtRTNq5FvDd4ZitXgC0k9CVuhTXqk4xDzEpQ9nF04ur+pMUtllGoEpPvib4KO4AfD2vO+WAktmVNO0RA1VaExakyfor9eRRPI8jB9MeoWokOt3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707070479; c=relaxed/simple;
	bh=N2sW8SLrslPgHpoCG6v88nOoldAfD6gw+OYbWsPdpOs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Vc2P/Hgk+3d9m3n5GF86DNOTebEhEDEPM+y8W3uhae01kHNGMCw9rh/DUfH1vyBnCIg0iavXtsBb9DFlSirIL27wQAbAVFv8cldNKUXY4kCCs9NS/3Lsex/ZkBZPmCelrIDJS8GwN7VTB7aiL/GrZmV43RItDgelERe85kCbNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdSh17AK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707070478; x=1738606478;
  h=date:from:to:cc:subject:message-id;
  bh=N2sW8SLrslPgHpoCG6v88nOoldAfD6gw+OYbWsPdpOs=;
  b=hdSh17AKDaZLBKO2Oz3q2S3pQ3rsXMjZrkIAN8cZqYtAZK/5PaF/3G5E
   27PP3z9SJh+lyMwymwRGhaAvyDVqdk6tp5ChjAP7pmO2QbiNj5ct573HE
   MFL32Hg/2K6sSQ28DQ87Hg+cQuPL54QIbGkry0Z/oltgmPIX3NM7wQyvk
   KoSSo8bWJtf9kLFopTlMCg8no7wThtJUOB1nvUIGFx+YsBet/ZeXgq/9f
   6cGEEO7WQXQSDnkfG4/HRcpSwzexsBhgUjpw5/wbj5dx3DIUKus0vRkvO
   kjVK7rIxzEsd+g9Ggn6QRnYzk/+OS4U2t1MbcwXBfTG0wm6ZG80b+6S9P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="11502964"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="11502964"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 10:14:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="743170"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2024 10:14:35 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWh0j-0006bW-1N;
	Sun, 04 Feb 2024 18:14:33 +0000
Date: Mon, 05 Feb 2024 02:13:41 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 dbea519d6878c298dd0f48e6ec2dbacebe4bbb2a
Message-ID: <202402050238.xv4sSC3Q-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: dbea519d6878c298dd0f48e6ec2dbacebe4bbb2a  cxl/trace: Remove unnecessary memcpy's

elapsed time: 1444m

configs tested: 218
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240204   gcc  
arc                   randconfig-002-20240204   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                            mmp2_defconfig   gcc  
arm                          moxart_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240204   gcc  
arm                   randconfig-002-20240204   clang
arm                   randconfig-003-20240204   clang
arm                   randconfig-004-20240204   gcc  
arm                         s3c6400_defconfig   gcc  
arm                         s5pv210_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240204   gcc  
arm64                 randconfig-002-20240204   clang
arm64                 randconfig-003-20240204   gcc  
arm64                 randconfig-004-20240204   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240204   gcc  
csky                  randconfig-002-20240204   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240204   clang
hexagon               randconfig-002-20240204   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240204   gcc  
i386         buildonly-randconfig-002-20240204   gcc  
i386         buildonly-randconfig-003-20240204   gcc  
i386         buildonly-randconfig-004-20240204   gcc  
i386         buildonly-randconfig-005-20240204   gcc  
i386         buildonly-randconfig-006-20240204   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240204   clang
i386                  randconfig-002-20240204   clang
i386                  randconfig-003-20240204   clang
i386                  randconfig-004-20240204   gcc  
i386                  randconfig-005-20240204   clang
i386                  randconfig-006-20240204   gcc  
i386                  randconfig-011-20240204   clang
i386                  randconfig-012-20240204   gcc  
i386                  randconfig-013-20240204   clang
i386                  randconfig-014-20240204   clang
i386                  randconfig-015-20240204   clang
i386                  randconfig-016-20240204   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240204   gcc  
loongarch             randconfig-002-20240204   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240204   gcc  
nios2                 randconfig-002-20240204   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240204   gcc  
parisc                randconfig-002-20240204   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc                     ppa8548_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240204   gcc  
powerpc               randconfig-002-20240204   gcc  
powerpc               randconfig-003-20240204   gcc  
powerpc64             randconfig-001-20240204   gcc  
powerpc64             randconfig-002-20240204   clang
powerpc64             randconfig-003-20240204   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240204   clang
riscv                 randconfig-002-20240204   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240204   clang
s390                  randconfig-002-20240204   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240204   gcc  
sh                    randconfig-002-20240204   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240204   gcc  
sparc64               randconfig-002-20240204   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240204   gcc  
um                    randconfig-002-20240204   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240204   clang
x86_64       buildonly-randconfig-002-20240204   clang
x86_64       buildonly-randconfig-003-20240204   gcc  
x86_64       buildonly-randconfig-004-20240204   gcc  
x86_64       buildonly-randconfig-005-20240204   clang
x86_64       buildonly-randconfig-006-20240204   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240204   gcc  
x86_64                randconfig-002-20240204   gcc  
x86_64                randconfig-003-20240204   clang
x86_64                randconfig-004-20240204   clang
x86_64                randconfig-005-20240204   gcc  
x86_64                randconfig-006-20240204   gcc  
x86_64                randconfig-011-20240204   gcc  
x86_64                randconfig-012-20240204   gcc  
x86_64                randconfig-013-20240204   gcc  
x86_64                randconfig-014-20240204   gcc  
x86_64                randconfig-015-20240204   clang
x86_64                randconfig-016-20240204   clang
x86_64                randconfig-071-20240204   gcc  
x86_64                randconfig-072-20240204   gcc  
x86_64                randconfig-073-20240204   gcc  
x86_64                randconfig-074-20240204   clang
x86_64                randconfig-075-20240204   clang
x86_64                randconfig-076-20240204   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240204   gcc  
xtensa                randconfig-002-20240204   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

