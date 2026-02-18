Return-Path: <linux-efi+bounces-6182-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKv+AMFJlmngdQIAu9opvQ
	(envelope-from <linux-efi+bounces-6182-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 00:22:41 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F09B15AE7B
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 00:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354ED305D6D1
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 23:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B2338936;
	Wed, 18 Feb 2026 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzFLNk5V"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0333AD99
	for <linux-efi@vger.kernel.org>; Wed, 18 Feb 2026 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456879; cv=none; b=MY2CWX8N9nAdKWdtV6z5UIzCyNjUxJSJiVIXVc3HLZlqxBGaUbBXvMPHFDiAP5tAK6HllJIRDLzb80nIKZ52TD45WDe53ZfuAxnJJf39cJw3XMggDWu+WY+I2AsMzI5WipQhQywOhxvIy3qaal588//rGaUxyBDwQ+PvxaYqcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456879; c=relaxed/simple;
	bh=q8eDi0CJC+T10i/AkOGZxY+LKqIvhffCOn1nlEy0tog=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TAJasxKv8TJjuWTsZlxw/4yRG0FRAirBTONZuaj+r5sdATFSd6L18z6bdKGAurgHC6JPt/WG3/FYPHXOm58vJCnYVgYP0+fqF65zyp/AcsFCNzYqx0g8bEJ+cUiY8yd1Jetu0IpIaIu0cee9DHgK6PIAQOYDqGZN5NwCTfgvWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzFLNk5V; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771456876; x=1802992876;
  h=date:from:to:cc:subject:message-id;
  bh=q8eDi0CJC+T10i/AkOGZxY+LKqIvhffCOn1nlEy0tog=;
  b=jzFLNk5V1vA82wOhqh5soaUR4F2C9wQFXdzHipekCaxufwmg028Ljbre
   xYO2KJWAcWxQTjAIhk/HcRrr3bQBVK7aEa/kqK3AJwKyBUUtlupznA02o
   ucESGMCMD0RvywiM2s+SWlNyxD3znfxG6gnGl/byYx5n+TLBoQ4iilflo
   J9ThkMhL4lLiW0qDEDULF5fNQCi4OT96YY8HBqyrrvM4Y/9HTB6iqN/Qw
   +G/Hjq7ltq8UPPIspjRQ6kPsNrpYewlKgPf32Cxc+c/Os/ibqKB+AwKgH
   y/5VKdsCqX2oqsBMK1bj4BniEtoXAMx1GdE1JoESqZB7L9crGXidpq8Is
   w==;
X-CSE-ConnectionGUID: T5+Yi5PbTGKbd9tUkG9gKg==
X-CSE-MsgGUID: zpS8tsjsQK2Z0q3MyPXb2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83261516"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83261516"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:21:12 -0800
X-CSE-ConnectionGUID: AlhwT+aMTHK+L+604vQAfQ==
X-CSE-MsgGUID: SC2FudoQTQ2n56gJNRwHNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="212642925"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 18 Feb 2026 15:21:12 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsqr0-000000012oB-30fW;
	Wed, 18 Feb 2026 23:21:10 +0000
Date: Thu, 19 Feb 2026 07:21:00 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 948a013a54c47d5eba06e644b99d4927a8bc62f8
Message-ID: <202602190752.37NCO2iC-lkp@intel.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-6182-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9F09B15AE7B
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 948a013a54c47d5eba06e644b99d4927a8bc62f8  efi: Align unaccepted memory range to page boundary

elapsed time: 761m

configs tested: 358
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-23
arc                   randconfig-001-20260218    clang-23
arc                   randconfig-001-20260218    gcc-9.5.0
arc                   randconfig-001-20260219    clang-23
arc                   randconfig-002-20260218    clang-23
arc                   randconfig-002-20260218    gcc-8.5.0
arc                   randconfig-002-20260219    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-23
arm                            hisi_defconfig    gcc-15.2.0
arm                        multi_v5_defconfig    gcc-15.2.0
arm                         mv78xx0_defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    clang-23
arm                        neponset_defconfig    gcc-15.2.0
arm                         orion5x_defconfig    clang-23
arm                             pxa_defconfig    gcc-15.2.0
arm                            qcom_defconfig    gcc-15.2.0
arm                   randconfig-001-20260218    clang-23
arm                   randconfig-001-20260219    clang-23
arm                   randconfig-002-20260218    clang-23
arm                   randconfig-002-20260219    clang-23
arm                   randconfig-003-20260218    clang-23
arm                   randconfig-003-20260219    clang-23
arm                   randconfig-004-20260218    clang-23
arm                   randconfig-004-20260218    gcc-10.5.0
arm                   randconfig-004-20260219    clang-23
arm                         socfpga_defconfig    clang-23
arm                           spitz_defconfig    gcc-15.2.0
arm                       versatile_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260218    clang-23
arm64                 randconfig-001-20260219    gcc-8.5.0
arm64                 randconfig-002-20260218    clang-23
arm64                 randconfig-002-20260219    gcc-8.5.0
arm64                 randconfig-003-20260218    clang-23
arm64                 randconfig-003-20260219    gcc-8.5.0
arm64                 randconfig-004-20260218    clang-23
arm64                 randconfig-004-20260219    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260218    clang-23
csky                  randconfig-001-20260219    gcc-8.5.0
csky                  randconfig-002-20260218    clang-23
csky                  randconfig-002-20260219    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260218    clang-16
hexagon               randconfig-001-20260219    clang-17
hexagon               randconfig-002-20260218    clang-16
hexagon               randconfig-002-20260219    clang-17
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260218    clang-20
i386        buildonly-randconfig-001-20260219    gcc-14
i386        buildonly-randconfig-002-20260218    clang-20
i386        buildonly-randconfig-002-20260219    gcc-14
i386        buildonly-randconfig-003-20260218    clang-20
i386        buildonly-randconfig-003-20260219    gcc-14
i386        buildonly-randconfig-004-20260218    clang-20
i386        buildonly-randconfig-004-20260218    gcc-13
i386        buildonly-randconfig-004-20260219    gcc-14
i386        buildonly-randconfig-005-20260218    clang-20
i386        buildonly-randconfig-005-20260219    gcc-14
i386        buildonly-randconfig-006-20260218    clang-20
i386        buildonly-randconfig-006-20260219    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260218    clang-20
i386                  randconfig-001-20260219    gcc-14
i386                  randconfig-002-20260218    clang-20
i386                  randconfig-002-20260219    gcc-14
i386                  randconfig-003-20260218    clang-20
i386                  randconfig-003-20260219    gcc-14
i386                  randconfig-004-20260218    clang-20
i386                  randconfig-004-20260219    gcc-14
i386                  randconfig-005-20260218    clang-20
i386                  randconfig-005-20260219    gcc-14
i386                  randconfig-006-20260218    clang-20
i386                  randconfig-006-20260219    gcc-14
i386                  randconfig-007-20260218    clang-20
i386                  randconfig-007-20260219    gcc-14
i386                  randconfig-011-20260218    gcc-12
i386                  randconfig-011-20260218    gcc-14
i386                  randconfig-011-20260219    clang-20
i386                  randconfig-012-20260218    gcc-14
i386                  randconfig-012-20260219    clang-20
i386                  randconfig-013-20260218    clang-20
i386                  randconfig-013-20260218    gcc-14
i386                  randconfig-013-20260219    clang-20
i386                  randconfig-014-20260218    gcc-14
i386                  randconfig-014-20260219    clang-20
i386                  randconfig-015-20260218    gcc-14
i386                  randconfig-015-20260219    clang-20
i386                  randconfig-016-20260218    clang-20
i386                  randconfig-016-20260218    gcc-14
i386                  randconfig-016-20260219    clang-20
i386                  randconfig-017-20260218    gcc-14
i386                  randconfig-017-20260219    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260218    clang-16
loongarch             randconfig-001-20260219    clang-17
loongarch             randconfig-002-20260218    clang-16
loongarch             randconfig-002-20260219    clang-17
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                       m5249evb_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-23
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                      pic32mzda_defconfig    clang-23
mips                          rm200_defconfig    clang-23
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260218    clang-16
nios2                 randconfig-001-20260219    clang-17
nios2                 randconfig-002-20260218    clang-16
nios2                 randconfig-002-20260219    clang-17
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc         de0_nano_multicore_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                generic-32bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260218    gcc-8.5.0
parisc                randconfig-001-20260219    clang-23
parisc                randconfig-002-20260218    gcc-8.5.0
parisc                randconfig-002-20260219    clang-23
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    clang-23
powerpc                      chrp32_defconfig    clang-23
powerpc                      cm5200_defconfig    clang-23
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    clang-23
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    gcc-15.2.0
powerpc                      katmai_defconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    clang-23
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc                     ppa8548_defconfig    gcc-15.2.0
powerpc                      ppc44x_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260218    gcc-8.5.0
powerpc               randconfig-001-20260219    clang-23
powerpc               randconfig-002-20260218    gcc-8.5.0
powerpc               randconfig-002-20260219    clang-23
powerpc                     tqm8555_defconfig    clang-23
powerpc64             randconfig-001-20260218    gcc-8.5.0
powerpc64             randconfig-001-20260219    clang-23
powerpc64             randconfig-002-20260218    gcc-8.5.0
powerpc64             randconfig-002-20260219    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260218    clang-23
riscv                 randconfig-001-20260219    clang-17
riscv                 randconfig-002-20260218    clang-23
riscv                 randconfig-002-20260219    clang-17
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260218    clang-23
s390                  randconfig-001-20260219    clang-17
s390                  randconfig-002-20260218    clang-23
s390                  randconfig-002-20260219    clang-17
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               alldefconfig    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          landisk_defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260218    clang-23
sh                    randconfig-001-20260218    gcc-15.2.0
sh                    randconfig-001-20260219    clang-17
sh                    randconfig-002-20260218    clang-23
sh                    randconfig-002-20260218    gcc-13.4.0
sh                    randconfig-002-20260219    clang-17
sh                          rsk7269_defconfig    gcc-15.2.0
sh                           se7619_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260218    gcc-10.5.0
sparc                 randconfig-001-20260218    gcc-14.3.0
sparc                 randconfig-001-20260219    gcc-8.5.0
sparc                 randconfig-002-20260218    gcc-10.5.0
sparc                 randconfig-002-20260218    gcc-8.5.0
sparc                 randconfig-002-20260219    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260218    gcc-10.5.0
sparc64               randconfig-001-20260218    gcc-11.5.0
sparc64               randconfig-001-20260219    gcc-8.5.0
sparc64               randconfig-002-20260218    gcc-10.5.0
sparc64               randconfig-002-20260218    gcc-12.5.0
sparc64               randconfig-002-20260219    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260218    clang-23
um                    randconfig-001-20260218    gcc-10.5.0
um                    randconfig-001-20260219    gcc-8.5.0
um                    randconfig-002-20260218    gcc-10.5.0
um                    randconfig-002-20260218    gcc-14
um                    randconfig-002-20260219    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260218    gcc-14
x86_64      buildonly-randconfig-001-20260219    gcc-14
x86_64      buildonly-randconfig-002-20260218    clang-20
x86_64      buildonly-randconfig-002-20260218    gcc-14
x86_64      buildonly-randconfig-002-20260219    gcc-14
x86_64      buildonly-randconfig-003-20260218    clang-20
x86_64      buildonly-randconfig-003-20260218    gcc-14
x86_64      buildonly-randconfig-003-20260219    gcc-14
x86_64      buildonly-randconfig-004-20260218    gcc-14
x86_64      buildonly-randconfig-004-20260219    gcc-14
x86_64      buildonly-randconfig-005-20260218    gcc-14
x86_64      buildonly-randconfig-005-20260219    gcc-14
x86_64      buildonly-randconfig-006-20260218    clang-20
x86_64      buildonly-randconfig-006-20260218    gcc-14
x86_64      buildonly-randconfig-006-20260219    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260218    clang-20
x86_64                randconfig-001-20260218    gcc-14
x86_64                randconfig-001-20260219    clang-20
x86_64                randconfig-002-20260218    clang-20
x86_64                randconfig-002-20260218    gcc-14
x86_64                randconfig-002-20260219    clang-20
x86_64                randconfig-003-20260218    gcc-14
x86_64                randconfig-003-20260219    clang-20
x86_64                randconfig-004-20260218    clang-20
x86_64                randconfig-004-20260218    gcc-14
x86_64                randconfig-004-20260219    clang-20
x86_64                randconfig-005-20260218    gcc-14
x86_64                randconfig-005-20260219    clang-20
x86_64                randconfig-006-20260218    clang-20
x86_64                randconfig-006-20260218    gcc-14
x86_64                randconfig-006-20260219    clang-20
x86_64                randconfig-011-20260218    gcc-13
x86_64                randconfig-011-20260219    gcc-14
x86_64                randconfig-012-20260218    gcc-13
x86_64                randconfig-012-20260219    gcc-14
x86_64                randconfig-013-20260218    gcc-13
x86_64                randconfig-013-20260219    gcc-14
x86_64                randconfig-014-20260218    gcc-13
x86_64                randconfig-014-20260219    gcc-14
x86_64                randconfig-015-20260218    gcc-13
x86_64                randconfig-015-20260219    gcc-14
x86_64                randconfig-016-20260218    gcc-13
x86_64                randconfig-016-20260219    gcc-14
x86_64                randconfig-071-20260218    clang-20
x86_64                randconfig-071-20260219    gcc-14
x86_64                randconfig-072-20260218    clang-20
x86_64                randconfig-072-20260219    gcc-14
x86_64                randconfig-073-20260218    clang-20
x86_64                randconfig-073-20260219    gcc-14
x86_64                randconfig-074-20260218    clang-20
x86_64                randconfig-074-20260219    gcc-14
x86_64                randconfig-075-20260218    clang-20
x86_64                randconfig-075-20260219    gcc-14
x86_64                randconfig-076-20260218    clang-20
x86_64                randconfig-076-20260218    gcc-14
x86_64                randconfig-076-20260219    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                       common_defconfig    gcc-15.2.0
xtensa                generic_kc705_defconfig    clang-23
xtensa                randconfig-001-20260218    gcc-10.5.0
xtensa                randconfig-001-20260218    gcc-9.5.0
xtensa                randconfig-001-20260219    gcc-8.5.0
xtensa                randconfig-002-20260218    gcc-10.5.0
xtensa                randconfig-002-20260219    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

