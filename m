Return-Path: <linux-efi+bounces-6174-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DMSBRsnlWnRMAIAu9opvQ
	(envelope-from <linux-efi+bounces-6174-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 03:42:35 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9224E152B73
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 03:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B91BA3012BF4
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 02:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07FB262FFC;
	Wed, 18 Feb 2026 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMqUPFVw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D091E1DE9
	for <linux-efi@vger.kernel.org>; Wed, 18 Feb 2026 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771382552; cv=none; b=WabMxwi4bDteDmT/dAacQlDd+39DqLs/RmVk2HscNTiQzYxzhJZogeCoSNwWpHFLV2z1W6XM3wayF2/72xUVvgPif+lpMmVos4QFH5SitA0nyvsYllaPDfy1m8263+0G0vVP/6eGouHjvh9LvGg7CFpbUFdKRYNg6IHAu2XF7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771382552; c=relaxed/simple;
	bh=JWBoOySHS3L3Ms7CJD7Rw3QsB142fiqlJanapnS0xuk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nM8QgzmxrUUuyVkk/yp2Vc+rXrlonzgo34fC3S5xsH+TL5lNCfp2gh8JsMdXju0np7S3uxV1AQE/AhUJIUP8NQEFF9+5dObQQMJi763F3kFoupf04Q4zOF/p0hbR/QD8guDGC/f9070zCNXtv1Kzut3sSlqyeu/xIuXidz0bTTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMqUPFVw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771382551; x=1802918551;
  h=date:from:to:cc:subject:message-id;
  bh=JWBoOySHS3L3Ms7CJD7Rw3QsB142fiqlJanapnS0xuk=;
  b=jMqUPFVwCUipDz2rdSzb7eMvaGsSBBO/EfDu/gms4pTMRBL8hsletvl+
   8kH3T7iusqsnu05N5WJQpdzdHSCZ6r5FPa0iBVfcbmV8CVZb00XaWi+WK
   75Tcon48a0EcYmS/S2q/QK0O7bdI+pJ4MVERFn0H6EfUsdfgghXU9Y1aw
   A+Gx375AdNuJ00LCbQbQBF3WcB6rBryNRFuJAyTMXZJR+g7o0u9ugvUil
   AHcyaYziRrNu7/BvFRmrvScY8ckUt5DbzroCqaBrDoOoDWYjQNXnaZwHa
   CrbmRSJpjK3xuasQsmFuTy2xEYyr1Phg206U6wJnxB7zLtClO0crlHsFa
   g==;
X-CSE-ConnectionGUID: d1nF0mWJTvyiFejRW+qbhg==
X-CSE-MsgGUID: bKLCI4/7RqWxjXZZaiv9Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72361203"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72361203"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 18:42:31 -0800
X-CSE-ConnectionGUID: OYGYwqQhTKCQhRLEwyq9mw==
X-CSE-MsgGUID: ih8WVZeqReOUcT1GRMswsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="213156035"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Feb 2026 18:42:30 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsXWF-000000011xE-15pT;
	Wed, 18 Feb 2026 02:42:27 +0000
Date: Wed, 18 Feb 2026 10:42:13 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 135d4a770cc1626ed96ba7ed6e0a6985392febc1
Message-ID: <202602181005.CFNC8Zzp-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-6174-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9224E152B73
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 135d4a770cc1626ed96ba7ed6e0a6985392febc1  efi: Align unaccepted memory range to page boundary

elapsed time: 730m

configs tested: 202
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-23
arc                   randconfig-001-20260218    clang-23
arc                   randconfig-002-20260218    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-23
arm                      footbridge_defconfig    clang-18
arm                            hisi_defconfig    gcc-15.2.0
arm                        keystone_defconfig    clang-18
arm                        multi_v5_defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    clang-23
arm                         orion5x_defconfig    clang-23
arm                             pxa_defconfig    gcc-15.2.0
arm                   randconfig-001-20260218    clang-23
arm                   randconfig-002-20260218    clang-23
arm                   randconfig-003-20260218    clang-23
arm                   randconfig-004-20260218    clang-23
arm                         socfpga_defconfig    clang-23
arm                           spitz_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260218    clang-23
arm64                 randconfig-002-20260218    clang-23
arm64                 randconfig-003-20260218    clang-23
arm64                 randconfig-004-20260218    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260218    clang-23
csky                  randconfig-002-20260218    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260218    clang-16
hexagon               randconfig-002-20260218    clang-16
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260218    clang-20
i386        buildonly-randconfig-002-20260218    clang-20
i386        buildonly-randconfig-003-20260218    clang-20
i386        buildonly-randconfig-004-20260218    clang-20
i386        buildonly-randconfig-005-20260218    clang-20
i386        buildonly-randconfig-006-20260218    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260218    clang-20
i386                  randconfig-002-20260218    clang-20
i386                  randconfig-003-20260218    clang-20
i386                  randconfig-004-20260218    clang-20
i386                  randconfig-005-20260218    clang-20
i386                  randconfig-006-20260218    clang-20
i386                  randconfig-007-20260218    clang-20
i386                  randconfig-011-20260218    gcc-14
i386                  randconfig-012-20260218    gcc-14
i386                  randconfig-013-20260218    gcc-14
i386                  randconfig-014-20260218    gcc-14
i386                  randconfig-015-20260218    gcc-14
i386                  randconfig-016-20260218    gcc-14
i386                  randconfig-017-20260218    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260218    clang-16
loongarch             randconfig-002-20260218    clang-16
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-18
mips                           ip22_defconfig    clang-18
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260218    clang-16
nios2                 randconfig-002-20260218    clang-16
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                generic-32bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260218    gcc-8.5.0
parisc                randconfig-002-20260218    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                    adder875_defconfig    clang-18
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      chrp32_defconfig    clang-18
powerpc                      ep88xc_defconfig    clang-23
powerpc                     kmeter1_defconfig    clang-23
powerpc                 mpc8313_rdb_defconfig    clang-18
powerpc                     ppa8548_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260218    gcc-8.5.0
powerpc               randconfig-002-20260218    gcc-8.5.0
powerpc64             randconfig-001-20260218    gcc-8.5.0
powerpc64             randconfig-002-20260218    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260218    clang-23
riscv                 randconfig-002-20260218    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260218    clang-23
s390                  randconfig-002-20260218    clang-23
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               alldefconfig    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          landisk_defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260218    clang-23
sh                    randconfig-002-20260218    clang-23
sh                          urquell_defconfig    clang-18
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260218    gcc-10.5.0
sparc                 randconfig-002-20260218    gcc-10.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260218    gcc-10.5.0
sparc64               randconfig-002-20260218    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260218    gcc-10.5.0
um                    randconfig-002-20260218    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260218    gcc-14
x86_64      buildonly-randconfig-002-20260218    gcc-14
x86_64      buildonly-randconfig-003-20260218    gcc-14
x86_64      buildonly-randconfig-004-20260218    gcc-14
x86_64      buildonly-randconfig-005-20260218    gcc-14
x86_64      buildonly-randconfig-006-20260218    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260218    gcc-14
x86_64                randconfig-002-20260218    gcc-14
x86_64                randconfig-003-20260218    gcc-14
x86_64                randconfig-004-20260218    gcc-14
x86_64                randconfig-005-20260218    gcc-14
x86_64                randconfig-006-20260218    gcc-14
x86_64                randconfig-011-20260218    gcc-13
x86_64                randconfig-012-20260218    gcc-13
x86_64                randconfig-013-20260218    gcc-13
x86_64                randconfig-014-20260218    gcc-13
x86_64                randconfig-015-20260218    gcc-13
x86_64                randconfig-016-20260218    gcc-13
x86_64                randconfig-071-20260218    clang-20
x86_64                randconfig-072-20260218    clang-20
x86_64                randconfig-073-20260218    clang-20
x86_64                randconfig-074-20260218    clang-20
x86_64                randconfig-075-20260218    clang-20
x86_64                randconfig-076-20260218    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260218    gcc-10.5.0
xtensa                randconfig-002-20260218    gcc-10.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

