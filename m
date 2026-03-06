Return-Path: <linux-efi+bounces-6249-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA9+FZwZqmkqLQEAu9opvQ
	(envelope-from <linux-efi+bounces-6249-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 01:02:36 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C893F219A5E
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 01:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 484DF303FADC
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 00:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C8194C96;
	Fri,  6 Mar 2026 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LF17ZTYI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99C13E02A
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755289; cv=none; b=KrE0SkvNp8O7l0nEsrcTXYlDy+mePTZNgdRH+sJk29zbf1jRF2GSl/c2rSh+eYjnrb9drVhav+rk/dzM/m8ML/7i8fv+1pes/EQm9ATqTSKbT+xHlyy3uA2rw5rdT4UXYVUkXK4watLD3MzCGBelIZqnif3xdwNwNqxBJinilII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755289; c=relaxed/simple;
	bh=Ntc1kaCPByaC284jNMQjJNLjKa6VvAV25iRMxaPf9OM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=A/4/5ucQtf9dZA+PRJsk7eoe8aKLgisdXvWrjPeiFIG6pIxDzBanT37dgBxzXUTJ1zJA+UffXpxUjBAzTfHqVHTHY6YOiAk5mPa/hXYQ1cAtMOIuAZpHJdeXfaBJl2qoROo0+w6jeRNRSJPmCR5aio2X7FKabQv5BldKcNn0geE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LF17ZTYI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772755286; x=1804291286;
  h=date:from:to:cc:subject:message-id;
  bh=Ntc1kaCPByaC284jNMQjJNLjKa6VvAV25iRMxaPf9OM=;
  b=LF17ZTYIHkk6h7eEbisJI3p3YEfshTjUL1/CgmzzT44TeHJeTIpkUSxX
   qpLpBY8gS1whsS6UoHZaiFgnuWU7s7RtzQUZFxuUUg07jHDbPyO8S2REk
   Ya/Ayn3GYTxJjvx018T6X6wL6aULNrRNd9kIBNITaV5fnHsAOL24qAFyL
   +p8fqto49YFxUPILo7ZWKbWIUc0VGKyF9utJGRIZ3TWdoLqXDvyYtz9wA
   KU/P7T/im7Enmz6dCKyzBwk3SyO6rWzPVcqgcql/Rz0EkjKFhUwkBic3W
   h+EL8cfJoIrNCykX9aPIfPsn4B5wtPWLeJFGJ7GTHDjifVQjPoPvUTd49
   w==;
X-CSE-ConnectionGUID: OmTPZ/GDTtmY9sk2nFAd3g==
X-CSE-MsgGUID: QT+LjxEUQXa2VCqFoJkiTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="96476724"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="96476724"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 16:01:26 -0800
X-CSE-ConnectionGUID: sQ7O0+QNSm6/CTrMnfoc7g==
X-CSE-MsgGUID: qIp6wfzlTcK6eeaJBDUrtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="249314777"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Mar 2026 16:01:25 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyId8-0000000005V-08PE;
	Fri, 06 Mar 2026 00:01:22 +0000
Date: Fri, 06 Mar 2026 08:00:22 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 a4b0bf6a40f3c107c67a24fbc614510ef5719980
Message-ID: <202603060815.vfWSxg0q-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: C893F219A5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6249-lists,linux-efi=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: a4b0bf6a40f3c107c67a24fbc614510ef5719980  x86/efi: defer freeing of boot services memory

elapsed time: 934m

configs tested: 227
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
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260305    clang-19
arc                   randconfig-001-20260306    gcc-14.3.0
arc                   randconfig-002-20260305    clang-19
arc                   randconfig-002-20260306    gcc-14.3.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260305    clang-19
arm                   randconfig-001-20260306    gcc-14.3.0
arm                   randconfig-002-20260305    clang-19
arm                   randconfig-002-20260306    gcc-14.3.0
arm                   randconfig-003-20260305    clang-19
arm                   randconfig-003-20260306    gcc-14.3.0
arm                   randconfig-004-20260305    clang-19
arm                   randconfig-004-20260306    gcc-14.3.0
arm                        spear3xx_defconfig    clang-17
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260305    gcc-8.5.0
arm64                 randconfig-002-20260305    gcc-8.5.0
arm64                 randconfig-003-20260305    gcc-8.5.0
arm64                 randconfig-004-20260305    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260305    gcc-8.5.0
csky                  randconfig-002-20260305    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260305    gcc-15.2.0
hexagon               randconfig-001-20260306    clang-23
hexagon               randconfig-002-20260305    gcc-15.2.0
hexagon               randconfig-002-20260306    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260306    gcc-14
i386        buildonly-randconfig-002-20260306    gcc-14
i386        buildonly-randconfig-003-20260306    gcc-14
i386        buildonly-randconfig-004-20260306    gcc-14
i386        buildonly-randconfig-005-20260306    gcc-14
i386        buildonly-randconfig-006-20260306    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260305    gcc-14
i386                  randconfig-001-20260306    clang-20
i386                  randconfig-002-20260305    gcc-14
i386                  randconfig-002-20260306    clang-20
i386                  randconfig-003-20260305    gcc-14
i386                  randconfig-003-20260306    clang-20
i386                  randconfig-004-20260305    gcc-14
i386                  randconfig-004-20260306    clang-20
i386                  randconfig-005-20260305    gcc-14
i386                  randconfig-005-20260306    clang-20
i386                  randconfig-006-20260305    gcc-14
i386                  randconfig-006-20260306    clang-20
i386                  randconfig-007-20260305    gcc-14
i386                  randconfig-007-20260306    clang-20
i386                  randconfig-011-20260306    gcc-14
i386                  randconfig-012-20260306    gcc-14
i386                  randconfig-013-20260306    gcc-14
i386                  randconfig-014-20260306    gcc-14
i386                  randconfig-015-20260306    gcc-14
i386                  randconfig-016-20260306    gcc-14
i386                  randconfig-017-20260306    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260305    gcc-15.2.0
loongarch             randconfig-001-20260306    clang-23
loongarch             randconfig-002-20260305    gcc-15.2.0
loongarch             randconfig-002-20260306    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260305    gcc-15.2.0
nios2                 randconfig-001-20260306    clang-23
nios2                 randconfig-002-20260305    gcc-15.2.0
nios2                 randconfig-002-20260306    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260305    gcc-9.5.0
parisc                randconfig-001-20260306    gcc-14.3.0
parisc                randconfig-002-20260305    gcc-9.5.0
parisc                randconfig-002-20260306    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260305    gcc-9.5.0
powerpc               randconfig-001-20260306    gcc-14.3.0
powerpc               randconfig-002-20260305    gcc-9.5.0
powerpc               randconfig-002-20260306    gcc-14.3.0
powerpc64             randconfig-001-20260305    gcc-9.5.0
powerpc64             randconfig-001-20260306    gcc-14.3.0
powerpc64             randconfig-002-20260305    gcc-9.5.0
powerpc64             randconfig-002-20260306    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260305    clang-23
riscv                 randconfig-001-20260306    clang-19
riscv                 randconfig-002-20260305    clang-23
riscv                 randconfig-002-20260306    clang-19
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260305    clang-23
s390                  randconfig-001-20260306    clang-19
s390                  randconfig-002-20260305    clang-23
s390                  randconfig-002-20260306    clang-19
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260305    clang-23
sh                    randconfig-001-20260306    clang-19
sh                    randconfig-002-20260305    clang-23
sh                    randconfig-002-20260306    clang-19
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260305    gcc-14.3.0
sparc                 randconfig-001-20260306    gcc-9.5.0
sparc                 randconfig-002-20260305    gcc-14.3.0
sparc                 randconfig-002-20260306    gcc-9.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260305    gcc-14.3.0
sparc64               randconfig-001-20260306    gcc-9.5.0
sparc64               randconfig-002-20260305    gcc-14.3.0
sparc64               randconfig-002-20260306    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260305    gcc-14.3.0
um                    randconfig-001-20260306    gcc-9.5.0
um                    randconfig-002-20260305    gcc-14.3.0
um                    randconfig-002-20260306    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260305    clang-20
x86_64      buildonly-randconfig-001-20260306    clang-20
x86_64      buildonly-randconfig-002-20260305    clang-20
x86_64      buildonly-randconfig-002-20260306    clang-20
x86_64      buildonly-randconfig-003-20260305    clang-20
x86_64      buildonly-randconfig-003-20260306    clang-20
x86_64      buildonly-randconfig-004-20260305    clang-20
x86_64      buildonly-randconfig-004-20260306    clang-20
x86_64      buildonly-randconfig-005-20260305    clang-20
x86_64      buildonly-randconfig-005-20260306    clang-20
x86_64      buildonly-randconfig-006-20260305    clang-20
x86_64      buildonly-randconfig-006-20260306    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260305    clang-20
x86_64                randconfig-001-20260306    gcc-14
x86_64                randconfig-002-20260305    clang-20
x86_64                randconfig-002-20260306    gcc-14
x86_64                randconfig-003-20260305    clang-20
x86_64                randconfig-003-20260306    gcc-14
x86_64                randconfig-004-20260305    clang-20
x86_64                randconfig-004-20260306    gcc-14
x86_64                randconfig-005-20260305    clang-20
x86_64                randconfig-005-20260306    gcc-14
x86_64                randconfig-006-20260305    clang-20
x86_64                randconfig-006-20260306    gcc-14
x86_64                randconfig-011-20260305    clang-20
x86_64                randconfig-012-20260305    clang-20
x86_64                randconfig-013-20260305    clang-20
x86_64                randconfig-014-20260305    clang-20
x86_64                randconfig-015-20260305    clang-20
x86_64                randconfig-016-20260305    clang-20
x86_64                randconfig-071-20260305    gcc-14
x86_64                randconfig-071-20260306    gcc-14
x86_64                randconfig-072-20260305    gcc-14
x86_64                randconfig-072-20260306    gcc-14
x86_64                randconfig-073-20260305    gcc-14
x86_64                randconfig-073-20260306    gcc-14
x86_64                randconfig-074-20260305    gcc-14
x86_64                randconfig-074-20260306    gcc-14
x86_64                randconfig-075-20260305    gcc-14
x86_64                randconfig-075-20260306    gcc-14
x86_64                randconfig-076-20260305    gcc-14
x86_64                randconfig-076-20260306    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260305    gcc-14.3.0
xtensa                randconfig-001-20260306    gcc-9.5.0
xtensa                randconfig-002-20260305    gcc-14.3.0
xtensa                randconfig-002-20260306    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

