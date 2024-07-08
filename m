Return-Path: <linux-efi+bounces-1386-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BC392ACAB
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jul 2024 01:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A760B217F0
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 23:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A778C92;
	Mon,  8 Jul 2024 23:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDmxtsJM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07707D07F
	for <linux-efi@vger.kernel.org>; Mon,  8 Jul 2024 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720482583; cv=none; b=Oby21iPb+29vMiDPeT4yRlWS/eLxN0js0G7XCZyiNl3LVQc9Fn1fJ15xizF+y+DldmqTPz7A5gX9WazGm7nXsDpMTUrOH6zEQsrtjuivuwL7j8krnTEWILgaNH/afBdimicGs5uvl3ehn7os5Z+LN6JugQ2pHZZ1wyiaePIvXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720482583; c=relaxed/simple;
	bh=Tt9Ibn5h0tJB+CpGGw4bpTkXIDGS957+XK7VK2DDWYQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ADtdDLXMro/Sd8HWBi/2dN1WdCOc7cuJ3wX1BbNPT3M0nyE9r2s4okcG3kM3ac4A0E2WfZMoHJDJQtFl+q2X7Br+WOQIZZkxvNUFT+6ahNEG/4Yq9j7HNTL1UTswayvMmtF6gcrjIao3Aaji13An5RTqZQuDuSneBoHo/EB9EuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDmxtsJM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720482581; x=1752018581;
  h=date:from:to:cc:subject:message-id;
  bh=Tt9Ibn5h0tJB+CpGGw4bpTkXIDGS957+XK7VK2DDWYQ=;
  b=dDmxtsJM2RRqj8M95MPovPuNPOPktYgczCbk5GS63yjt83jrIECnaLKq
   deh8BzdXnK0byCcD8va1fozcXEljl5qstHhI/YJPM4TKoMxw/LMAXKop3
   cSfeAlyu5C7jNNmHou7i1fI+8z6JSaWtJ22Vg0oUOTBLpDqoh/+pY6Gx/
   qOFhgFv2q9kxHWI73H/Q15Lcmoj3qCEL/XgjZixMOxlzIFJ8k9Huxqp8N
   qPtALji+tKHLgwQ2uE2RE9+TrW7ndBtLwNkjZqJdNL7QCtBbRHt+QQgeP
   eRbmq9JVFtvn04gWvYt3ebWUgnlkcfBNZRIGuBotHFEiOLaGRrGb67xzN
   Q==;
X-CSE-ConnectionGUID: KVHboeFgSzaYhAzlSr37xA==
X-CSE-MsgGUID: C4M/E8OpRb2Li09DE2PyAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="21476395"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="21476395"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 16:49:41 -0700
X-CSE-ConnectionGUID: U7G5Egf0Te+Kzj9SnKsd2A==
X-CSE-MsgGUID: 5/C5K7pcS6GgmfaqR/RDLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="51990080"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jul 2024 16:49:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQy6y-000W96-2O;
	Mon, 08 Jul 2024 23:49:36 +0000
Date: Tue, 09 Jul 2024 07:49:17 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 ebf5a79acf9a2970e93d30a9e97b08913ef15711
Message-ID: <202407090715.qnfUtJEf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: ebf5a79acf9a2970e93d30a9e97b08913ef15711  x86/efistub: Drop redundant clearing of BSS

elapsed time: 876m

configs tested: 256
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240708   gcc-13.2.0
arc                   randconfig-001-20240709   gcc-13.2.0
arc                   randconfig-002-20240708   gcc-13.2.0
arc                   randconfig-002-20240709   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                              alldefconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         bcm2835_defconfig   clang-19
arm                                 defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                          moxart_defconfig   clang-19
arm                        mvebu_v5_defconfig   clang-19
arm                         nhk8815_defconfig   gcc-13.2.0
arm                             pxa_defconfig   clang-19
arm                   randconfig-001-20240708   gcc-13.2.0
arm                   randconfig-001-20240709   gcc-13.2.0
arm                   randconfig-002-20240708   gcc-13.2.0
arm                   randconfig-002-20240709   gcc-13.2.0
arm                   randconfig-003-20240708   gcc-13.2.0
arm                   randconfig-003-20240709   gcc-13.2.0
arm                   randconfig-004-20240708   gcc-13.2.0
arm                   randconfig-004-20240709   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240708   gcc-13.2.0
arm64                 randconfig-001-20240709   gcc-13.2.0
arm64                 randconfig-002-20240708   gcc-13.2.0
arm64                 randconfig-002-20240709   gcc-13.2.0
arm64                 randconfig-003-20240708   gcc-13.2.0
arm64                 randconfig-003-20240709   gcc-13.2.0
arm64                 randconfig-004-20240708   gcc-13.2.0
arm64                 randconfig-004-20240709   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240708   gcc-13.2.0
csky                  randconfig-001-20240709   gcc-13.2.0
csky                  randconfig-002-20240708   gcc-13.2.0
csky                  randconfig-002-20240709   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240708   clang-18
i386         buildonly-randconfig-001-20240709   gcc-11
i386         buildonly-randconfig-002-20240708   clang-18
i386         buildonly-randconfig-002-20240709   gcc-11
i386         buildonly-randconfig-003-20240708   clang-18
i386         buildonly-randconfig-003-20240709   gcc-11
i386         buildonly-randconfig-004-20240708   clang-18
i386         buildonly-randconfig-004-20240709   gcc-11
i386         buildonly-randconfig-005-20240708   clang-18
i386         buildonly-randconfig-005-20240709   gcc-11
i386         buildonly-randconfig-006-20240708   clang-18
i386         buildonly-randconfig-006-20240709   gcc-11
i386                                defconfig   clang-18
i386                  randconfig-001-20240708   clang-18
i386                  randconfig-001-20240709   gcc-11
i386                  randconfig-002-20240708   clang-18
i386                  randconfig-002-20240709   gcc-11
i386                  randconfig-003-20240708   clang-18
i386                  randconfig-003-20240709   gcc-11
i386                  randconfig-004-20240708   clang-18
i386                  randconfig-004-20240709   gcc-11
i386                  randconfig-005-20240708   clang-18
i386                  randconfig-005-20240709   gcc-11
i386                  randconfig-006-20240708   clang-18
i386                  randconfig-006-20240709   gcc-11
i386                  randconfig-011-20240708   clang-18
i386                  randconfig-011-20240709   gcc-11
i386                  randconfig-012-20240708   clang-18
i386                  randconfig-012-20240709   gcc-11
i386                  randconfig-013-20240708   clang-18
i386                  randconfig-013-20240709   gcc-11
i386                  randconfig-014-20240708   clang-18
i386                  randconfig-014-20240709   gcc-11
i386                  randconfig-015-20240708   clang-18
i386                  randconfig-015-20240709   gcc-11
i386                  randconfig-016-20240708   clang-18
i386                  randconfig-016-20240709   gcc-11
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240708   gcc-13.2.0
loongarch             randconfig-001-20240709   gcc-13.2.0
loongarch             randconfig-002-20240708   gcc-13.2.0
loongarch             randconfig-002-20240709   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                            q40_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           ci20_defconfig   gcc-13.2.0
mips                     decstation_defconfig   gcc-13.2.0
mips                 decstation_r4k_defconfig   clang-19
mips                      fuloong2e_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                    maltaup_xpa_defconfig   gcc-13.2.0
nios2                         3c120_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240708   gcc-13.2.0
nios2                 randconfig-001-20240709   gcc-13.2.0
nios2                 randconfig-002-20240708   gcc-13.2.0
nios2                 randconfig-002-20240709   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240708   gcc-13.2.0
parisc                randconfig-001-20240709   gcc-13.2.0
parisc                randconfig-002-20240708   gcc-13.2.0
parisc                randconfig-002-20240709   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.2.0
powerpc                       holly_defconfig   gcc-13.2.0
powerpc                 linkstation_defconfig   gcc-13.2.0
powerpc                   lite5200b_defconfig   gcc-13.2.0
powerpc               mpc834x_itxgp_defconfig   clang-19
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   clang-19
powerpc                     powernv_defconfig   gcc-13.2.0
powerpc                      ppc6xx_defconfig   clang-19
powerpc                         ps3_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240708   gcc-13.2.0
powerpc               randconfig-001-20240709   gcc-13.2.0
powerpc               randconfig-002-20240708   gcc-13.2.0
powerpc               randconfig-002-20240709   gcc-13.2.0
powerpc               randconfig-003-20240708   gcc-13.2.0
powerpc               randconfig-003-20240709   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                     stx_gp3_defconfig   clang-19
powerpc                     tqm5200_defconfig   clang-19
powerpc                     tqm5200_defconfig   gcc-13.2.0
powerpc                     tqm8555_defconfig   clang-19
powerpc                      tqm8xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240708   gcc-13.2.0
powerpc64             randconfig-001-20240709   gcc-13.2.0
powerpc64             randconfig-002-20240708   gcc-13.2.0
powerpc64             randconfig-002-20240709   gcc-13.2.0
powerpc64             randconfig-003-20240708   gcc-13.2.0
powerpc64             randconfig-003-20240709   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240708   gcc-13.2.0
riscv                 randconfig-001-20240709   gcc-13.2.0
riscv                 randconfig-002-20240708   gcc-13.2.0
riscv                 randconfig-002-20240709   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240708   gcc-13.2.0
s390                  randconfig-001-20240709   gcc-13.2.0
s390                  randconfig-002-20240708   gcc-13.2.0
s390                  randconfig-002-20240709   gcc-13.2.0
s390                       zfcpdump_defconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                ecovec24-romimage_defconfig   gcc-13.2.0
sh                    randconfig-001-20240708   gcc-13.2.0
sh                    randconfig-001-20240709   gcc-13.2.0
sh                    randconfig-002-20240708   gcc-13.2.0
sh                    randconfig-002-20240709   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                             sh03_defconfig   gcc-13.2.0
sh                   sh7724_generic_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                          alldefconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240708   gcc-13.2.0
sparc64               randconfig-001-20240709   gcc-13.2.0
sparc64               randconfig-002-20240708   gcc-13.2.0
sparc64               randconfig-002-20240709   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240708   gcc-13.2.0
um                    randconfig-001-20240709   gcc-13.2.0
um                    randconfig-002-20240708   gcc-13.2.0
um                    randconfig-002-20240709   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240708   gcc-13
x86_64       buildonly-randconfig-002-20240708   gcc-13
x86_64       buildonly-randconfig-003-20240708   gcc-13
x86_64       buildonly-randconfig-004-20240708   gcc-13
x86_64       buildonly-randconfig-005-20240708   gcc-13
x86_64       buildonly-randconfig-006-20240708   gcc-13
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240708   gcc-13
x86_64                randconfig-002-20240708   gcc-13
x86_64                randconfig-003-20240708   gcc-13
x86_64                randconfig-004-20240708   gcc-13
x86_64                randconfig-005-20240708   gcc-13
x86_64                randconfig-006-20240708   gcc-13
x86_64                randconfig-011-20240708   gcc-13
x86_64                randconfig-012-20240708   gcc-13
x86_64                randconfig-013-20240708   gcc-13
x86_64                randconfig-014-20240708   gcc-13
x86_64                randconfig-015-20240708   gcc-13
x86_64                randconfig-016-20240708   gcc-13
x86_64                randconfig-071-20240708   gcc-13
x86_64                randconfig-072-20240708   gcc-13
x86_64                randconfig-073-20240708   gcc-13
x86_64                randconfig-074-20240708   gcc-13
x86_64                randconfig-075-20240708   gcc-13
x86_64                randconfig-076-20240708   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240708   gcc-13.2.0
xtensa                randconfig-001-20240709   gcc-13.2.0
xtensa                randconfig-002-20240708   gcc-13.2.0
xtensa                randconfig-002-20240709   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

