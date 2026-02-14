Return-Path: <linux-efi+bounces-6141-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OaCAXcekGlwWQEAu9opvQ
	(envelope-from <linux-efi+bounces-6141-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sat, 14 Feb 2026 08:04:23 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B6713B483
	for <lists+linux-efi@lfdr.de>; Sat, 14 Feb 2026 08:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA59302529E
	for <lists+linux-efi@lfdr.de>; Sat, 14 Feb 2026 07:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD8923183F;
	Sat, 14 Feb 2026 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DU0rmcJo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D81DF75D
	for <linux-efi@vger.kernel.org>; Sat, 14 Feb 2026 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771052660; cv=none; b=HHXzWG0k/QkzOZVUstcHZHMa+MizLAxG8VpdCD1NPNwg3y/sV8cqx6L6IY53Hacg0b+jm8L3bkmzBL1HXpd1hvhwk7xzAMdKvCIWBhyb/TsFSplAVgUVqSe9G9UDdnaA1VWQtdF5sMQNhnQupLcWGWTPtiarKK2oZ+/AtTVLM4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771052660; c=relaxed/simple;
	bh=ydWoy9NhnvaviY4eKJRnTAoqPwgzHQvy7DzUv329pS0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=H1yiDpzea0Qk5UcBib9CBT9asduQtY39LUZ8NaJD9iprQAgND6zoZI5QBOSKRwgHVr40l21mv8JMAYOw5KbyZWecahc1nhCgLtj10D0W9j1aLNFstIIfiHRWWPaEMoc7rk8xN8F2ErJQekxEXdcmhStRIHXtuKDyNU/5rjrt69w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DU0rmcJo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771052658; x=1802588658;
  h=date:from:to:cc:subject:message-id;
  bh=ydWoy9NhnvaviY4eKJRnTAoqPwgzHQvy7DzUv329pS0=;
  b=DU0rmcJo1QL3yInJLJmaJiUEkvavkU+jMrZiE2tjkIjx5d7PlpYjFYnq
   F7ZV/ewskFsKukvCZ32Pfq+nD6Lc2Sk8CBaor2MYkqR4fSGQfJhFYifCv
   TRsoMPTorz5lsmpPgNP9rxs80QfpAxlaRurc1n07o2bm156lHyUHlSZVl
   ufmkOjRYUUxOJQXRYP582GKnGcg94jePsxyG7qwhX84FlR8vtr2Q36Lz6
   PUbHyZ/UPlPMuukz/EMvUKYsmHGLfHdA88VVifg0sz9y3Ri//IM47unzg
   jpBuQ9Oh2N0+M1hkZ2EzIrvYXV70aJyPR8Vy/ALXch6SP6cwIGmSPmCON
   g==;
X-CSE-ConnectionGUID: WQzC2yoTR+aPDfxkmvWHdg==
X-CSE-MsgGUID: hN3Vlj7cQIqtGdE5BafQfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="76082151"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="76082151"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 23:04:17 -0800
X-CSE-ConnectionGUID: b7lBP6M4R7m5Q303B6vNrw==
X-CSE-MsgGUID: vPMv3uWTTOya2JZhsJXOBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="250786207"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Feb 2026 23:04:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vr9hN-00000000wKW-3uA1;
	Sat, 14 Feb 2026 07:04:13 +0000
Date: Sat, 14 Feb 2026 15:03:58 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 64166dc2f4f47ce2a77837de95026d36c77dd73d
Message-ID: <202602141550.b34OTWyl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-6141-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54B6713B483
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 64166dc2f4f47ce2a77837de95026d36c77dd73d  efi: export sysfb_primary_display for EDID

elapsed time: 733m

configs tested: 216
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260214    clang-22
arc                   randconfig-002-20260214    clang-22
arc                        vdk_hs38_defconfig    gcc-15.2.0
arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                         at91_dt_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                         lpc32xx_defconfig    clang-22
arm                          moxart_defconfig    gcc-15.2.0
arm                            mps2_defconfig    clang-22
arm                         mv78xx0_defconfig    gcc-15.2.0
arm                        neponset_defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                       omap2plus_defconfig    gcc-15.2.0
arm                   randconfig-001-20260214    clang-22
arm                   randconfig-002-20260214    clang-22
arm                   randconfig-003-20260214    clang-22
arm                   randconfig-004-20260214    clang-22
arm                           sama7_defconfig    clang-22
arm                           spitz_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260214    gcc-8.5.0
arm64                 randconfig-002-20260214    gcc-8.5.0
arm64                 randconfig-003-20260214    gcc-8.5.0
arm64                 randconfig-004-20260214    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260214    gcc-8.5.0
csky                  randconfig-002-20260214    gcc-8.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260214    clang-22
hexagon               randconfig-002-20260214    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260214    clang-20
i386        buildonly-randconfig-002-20260214    clang-20
i386        buildonly-randconfig-003-20260214    clang-20
i386        buildonly-randconfig-004-20260214    clang-20
i386        buildonly-randconfig-005-20260214    clang-20
i386        buildonly-randconfig-006-20260214    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260214    clang-20
i386                  randconfig-002-20260214    clang-20
i386                  randconfig-003-20260214    clang-20
i386                  randconfig-004-20260214    clang-20
i386                  randconfig-005-20260214    clang-20
i386                  randconfig-006-20260214    clang-20
i386                  randconfig-007-20260214    clang-20
i386                  randconfig-011-20260214    gcc-14
i386                  randconfig-012-20260214    gcc-14
i386                  randconfig-013-20260214    gcc-14
i386                  randconfig-014-20260214    gcc-14
i386                  randconfig-015-20260214    gcc-14
i386                  randconfig-016-20260214    gcc-14
i386                  randconfig-017-20260214    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260214    clang-22
loongarch             randconfig-002-20260214    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                            q40_defconfig    clang-22
m68k                          sun3x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm63xx_defconfig    gcc-15.2.0
mips                         cobalt_defconfig    clang-22
mips                      fuloong2e_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-22
mips                       lemote2f_defconfig    clang-22
mips                      malta_kvm_defconfig    clang-22
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                          rm200_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260214    clang-22
nios2                 randconfig-002-20260214    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260214    clang-22
parisc                randconfig-002-20260214    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      bamboo_defconfig    clang-22
powerpc                        cell_defconfig    gcc-15.2.0
powerpc                          g5_defconfig    gcc-15.2.0
powerpc                    ge_imp3a_defconfig    gcc-15.2.0
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260214    clang-22
powerpc               randconfig-002-20260214    clang-22
powerpc                         wii_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260214    clang-22
powerpc64             randconfig-002-20260214    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260214    clang-20
riscv                 randconfig-002-20260214    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260214    clang-20
s390                  randconfig-002-20260214    clang-20
sh                               alldefconfig    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                         ecovec24_defconfig    clang-22
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260214    clang-20
sh                    randconfig-002-20260214    clang-20
sh                          rsk7203_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260214    gcc-14.3.0
sparc                 randconfig-002-20260214    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260214    gcc-14.3.0
sparc64               randconfig-002-20260214    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260214    gcc-14.3.0
um                    randconfig-002-20260214    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260214    clang-20
x86_64      buildonly-randconfig-002-20260214    clang-20
x86_64      buildonly-randconfig-003-20260214    clang-20
x86_64      buildonly-randconfig-004-20260214    clang-20
x86_64      buildonly-randconfig-005-20260214    clang-20
x86_64      buildonly-randconfig-006-20260214    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260214    clang-20
x86_64                randconfig-002-20260214    clang-20
x86_64                randconfig-003-20260214    clang-20
x86_64                randconfig-004-20260214    clang-20
x86_64                randconfig-005-20260214    clang-20
x86_64                randconfig-006-20260214    clang-20
x86_64                randconfig-011-20260214    gcc-14
x86_64                randconfig-012-20260214    gcc-14
x86_64                randconfig-013-20260214    gcc-14
x86_64                randconfig-014-20260214    gcc-14
x86_64                randconfig-015-20260214    gcc-14
x86_64                randconfig-016-20260214    gcc-14
x86_64                randconfig-071-20260214    clang-20
x86_64                randconfig-072-20260214    clang-20
x86_64                randconfig-073-20260214    clang-20
x86_64                randconfig-074-20260214    clang-20
x86_64                randconfig-075-20260214    clang-20
x86_64                randconfig-076-20260214    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                       common_defconfig    gcc-15.2.0
xtensa                          iss_defconfig    clang-22
xtensa                randconfig-001-20260214    gcc-14.3.0
xtensa                randconfig-002-20260214    gcc-14.3.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0
xtensa                    xip_kc705_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

