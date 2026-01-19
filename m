Return-Path: <linux-efi+bounces-6019-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DA8D3BAD5
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 23:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82E8C302D389
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 22:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CE82FC881;
	Mon, 19 Jan 2026 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FV0xFkB5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5BE3019B0
	for <linux-efi@vger.kernel.org>; Mon, 19 Jan 2026 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768861405; cv=none; b=sVdgRL/VUkpExKoMXfwIZYGZlMxm8kGXNANL4P2aY9IN7pwL19UuKEumLTgrdt1E/kQVaMZJAGETTXQVeldhBESf23c3VcIxyNG41felSAj5v5qEDWMOJ/FbslDTF9ajSbw3aAdB1dzf9I9041ShS+ejn6vQWT8KIW2attcTQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768861405; c=relaxed/simple;
	bh=Jd/X2KOfuauCw0M/4M3Lk0slodorU5F0eLATFVENjAI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U5WBtvZFuJ/V+me5twPc+Sjnh+csSTrPtE5/UIxJrZxijgs0MGy0DWow/ZOBKWtJyZOVMupxBCF3lvtWuYlorufvbjB7AJqk6BE42mnw4Lw3Gtu7sNskTPQoUFbCR7D6HmkfE8C/Y89QS9SrFJkDBCsFuKKtxggYeM/xnpqIQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FV0xFkB5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768861404; x=1800397404;
  h=date:from:to:cc:subject:message-id;
  bh=Jd/X2KOfuauCw0M/4M3Lk0slodorU5F0eLATFVENjAI=;
  b=FV0xFkB5a4MGSFLGlgrX+8Ynnm6Yol5av6XlEYgUNt9xPt9EmWwb3tfV
   Jqv6GfV6EhARseTI7GcA+aYZqPrD59oGAcToDrLLNeo5NxUwTmrGaYXRb
   +jlyUVryG3a3abCwbCl7F/qSDuIqlo54t7mZByGi4donvHNqP3cspvd+V
   EIul5TitqR13q4d/9eI+++Zx/DMflAsWI/cUljNK9eSJHfvtJQO4haX2x
   d1kuGT/RW5uk0jduKOx5jbP8/piQph0QOYZJ1kC3rB7CIp9uv/Bkz83ga
   xE+Cv1Dlt0bJqAaVnmUDCs1SaeKk2gyIZdfGpKgVDHOsbBLK9xyY0o3lA
   g==;
X-CSE-ConnectionGUID: CxCwbP30TGOoV7PEUS2k4A==
X-CSE-MsgGUID: CEXmHMb0RgyR/KYg9nKmPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="80703354"
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="80703354"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 14:23:21 -0800
X-CSE-ConnectionGUID: BkVrlSREREiNfWSVAzKpdg==
X-CSE-MsgGUID: YxGIFBIlQ02VMBf0KpzMaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="228891106"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Jan 2026 14:23:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhxeX-00000000OLj-1rbd;
	Mon, 19 Jan 2026 22:23:17 +0000
Date: Tue, 20 Jan 2026 06:22:34 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 4b22ec1685ce1fc0d862dcda3225d852fb107995
Message-ID: <202601200628.pYODIiTd-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 4b22ec1685ce1fc0d862dcda3225d852fb107995  efivarfs: fix error propagation in efivar_entry_get()

elapsed time: 876m

configs tested: 361
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                   randconfig-001-20260119    gcc-14.3.0
arc                   randconfig-001-20260120    clang-22
arc                   randconfig-002-20260119    gcc-14.3.0
arc                   randconfig-002-20260120    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                     am200epdkit_defconfig    gcc-14
arm                       aspeed_g5_defconfig    gcc-15.2.0
arm                         bcm2835_defconfig    clang-16
arm                         bcm2835_defconfig    gcc-15.2.0
arm                        clps711x_defconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    gcc-15.2.0
arm                          gemini_defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-22
arm                            mps2_defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    clang-22
arm                        multi_v5_defconfig    clang-22
arm                           omap1_defconfig    gcc-14
arm                   randconfig-001-20260119    gcc-14.3.0
arm                   randconfig-001-20260120    clang-22
arm                   randconfig-002-20260119    gcc-14.3.0
arm                   randconfig-002-20260120    clang-22
arm                   randconfig-003-20260119    gcc-14.3.0
arm                   randconfig-003-20260120    clang-22
arm                   randconfig-004-20260119    gcc-14.3.0
arm                   randconfig-004-20260120    clang-22
arm                           sama5_defconfig    gcc-15.2.0
arm                          sp7021_defconfig    clang-16
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           tegra_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260119    clang-19
arm64                 randconfig-001-20260119    gcc-15.2.0
arm64                 randconfig-001-20260120    gcc-15.2.0
arm64                 randconfig-002-20260119    clang-19
arm64                 randconfig-002-20260120    gcc-15.2.0
arm64                 randconfig-003-20260119    clang-16
arm64                 randconfig-003-20260119    clang-19
arm64                 randconfig-003-20260120    gcc-15.2.0
arm64                 randconfig-004-20260119    clang-19
arm64                 randconfig-004-20260119    clang-20
arm64                 randconfig-004-20260120    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260119    clang-19
csky                  randconfig-001-20260119    gcc-12.5.0
csky                  randconfig-001-20260120    gcc-15.2.0
csky                  randconfig-002-20260119    clang-19
csky                  randconfig-002-20260119    gcc-15.2.0
csky                  randconfig-002-20260120    gcc-15.2.0
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260119    clang-18
hexagon               randconfig-001-20260120    gcc-12.5.0
hexagon               randconfig-002-20260119    clang-18
hexagon               randconfig-002-20260119    clang-22
hexagon               randconfig-002-20260120    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260119    clang-20
i386        buildonly-randconfig-001-20260120    gcc-14
i386        buildonly-randconfig-002-20260119    clang-20
i386        buildonly-randconfig-002-20260120    gcc-14
i386        buildonly-randconfig-003-20260119    clang-20
i386        buildonly-randconfig-003-20260120    gcc-14
i386        buildonly-randconfig-004-20260119    clang-20
i386        buildonly-randconfig-004-20260120    gcc-14
i386        buildonly-randconfig-005-20260119    clang-20
i386        buildonly-randconfig-005-20260120    gcc-14
i386        buildonly-randconfig-006-20260119    clang-20
i386        buildonly-randconfig-006-20260120    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260119    gcc-13
i386                  randconfig-001-20260119    gcc-14
i386                  randconfig-001-20260120    clang-20
i386                  randconfig-002-20260119    gcc-13
i386                  randconfig-002-20260120    clang-20
i386                  randconfig-003-20260119    clang-20
i386                  randconfig-003-20260119    gcc-13
i386                  randconfig-003-20260120    clang-20
i386                  randconfig-004-20260119    gcc-13
i386                  randconfig-004-20260119    gcc-14
i386                  randconfig-004-20260120    clang-20
i386                  randconfig-005-20260119    clang-20
i386                  randconfig-005-20260119    gcc-13
i386                  randconfig-005-20260120    clang-20
i386                  randconfig-006-20260119    clang-20
i386                  randconfig-006-20260119    gcc-13
i386                  randconfig-006-20260120    clang-20
i386                  randconfig-007-20260119    clang-20
i386                  randconfig-007-20260119    gcc-13
i386                  randconfig-007-20260120    clang-20
i386                  randconfig-011-20260119    gcc-14
i386                  randconfig-011-20260120    clang-20
i386                  randconfig-012-20260119    gcc-14
i386                  randconfig-012-20260120    clang-20
i386                  randconfig-013-20260119    gcc-14
i386                  randconfig-013-20260120    clang-20
i386                  randconfig-014-20260119    gcc-14
i386                  randconfig-014-20260120    clang-20
i386                  randconfig-015-20260119    gcc-14
i386                  randconfig-015-20260120    clang-20
i386                  randconfig-016-20260119    gcc-14
i386                  randconfig-016-20260120    clang-20
i386                  randconfig-017-20260119    gcc-14
i386                  randconfig-017-20260120    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson64_defconfig    clang-16
loongarch             randconfig-001-20260119    clang-18
loongarch             randconfig-001-20260119    gcc-15.2.0
loongarch             randconfig-001-20260120    gcc-12.5.0
loongarch             randconfig-002-20260119    clang-18
loongarch             randconfig-002-20260119    gcc-15.2.0
loongarch             randconfig-002-20260120    gcc-12.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                           ip22_defconfig    clang-16
mips                       lemote2f_defconfig    clang-16
mips                  maltasmvp_eva_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                          rb532_defconfig    clang-22
mips                           xway_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260119    clang-18
nios2                 randconfig-001-20260119    gcc-10.5.0
nios2                 randconfig-001-20260120    gcc-12.5.0
nios2                 randconfig-002-20260119    clang-18
nios2                 randconfig-002-20260119    gcc-8.5.0
nios2                 randconfig-002-20260120    gcc-12.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260119    clang-22
parisc                randconfig-001-20260120    gcc-8.5.0
parisc                randconfig-002-20260119    clang-22
parisc                randconfig-002-20260120    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    clang-22
powerpc                     asp8347_defconfig    clang-22
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                       eiger_defconfig    clang-16
powerpc                      ep88xc_defconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    gcc-15.2.0
powerpc                  iss476-smp_defconfig    clang-22
powerpc                   microwatt_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    clang-22
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc                      ppc6xx_defconfig    gcc-14
powerpc                     rainier_defconfig    clang-22
powerpc               randconfig-001-20260119    clang-22
powerpc               randconfig-001-20260120    gcc-8.5.0
powerpc               randconfig-002-20260119    clang-22
powerpc               randconfig-002-20260120    gcc-8.5.0
powerpc                    sam440ep_defconfig    gcc-14
powerpc                  storcenter_defconfig    clang-16
powerpc                     tqm5200_defconfig    clang-22
powerpc64             randconfig-001-20260119    clang-22
powerpc64             randconfig-001-20260120    gcc-8.5.0
powerpc64             randconfig-002-20260119    clang-22
powerpc64             randconfig-002-20260120    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20260119    gcc-15.2.0
riscv                 randconfig-001-20260119    gcc-8.5.0
riscv                 randconfig-001-20260120    gcc-13.4.0
riscv                 randconfig-002-20260119    clang-22
riscv                 randconfig-002-20260119    gcc-15.2.0
riscv                 randconfig-002-20260120    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-14
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260119    gcc-15.2.0
s390                  randconfig-001-20260119    gcc-9.5.0
s390                  randconfig-001-20260120    gcc-13.4.0
s390                  randconfig-002-20260119    clang-22
s390                  randconfig-002-20260119    gcc-15.2.0
s390                  randconfig-002-20260120    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                            migor_defconfig    gcc-15.2.0
sh                    randconfig-001-20260119    gcc-15.2.0
sh                    randconfig-001-20260120    gcc-13.4.0
sh                    randconfig-002-20260119    gcc-12.5.0
sh                    randconfig-002-20260119    gcc-15.2.0
sh                    randconfig-002-20260120    gcc-13.4.0
sh                           se7712_defconfig    gcc-15.2.0
sh                           se7722_defconfig    gcc-15.2.0
sh                           se7724_defconfig    gcc-14
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sh                        sh7763rdp_defconfig    gcc-15.2.0
sh                   sh7770_generic_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260119    gcc-14.3.0
sparc                 randconfig-001-20260120    gcc-8.5.0
sparc                 randconfig-002-20260119    gcc-14.3.0
sparc                 randconfig-002-20260120    gcc-8.5.0
sparc64                          alldefconfig    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260119    gcc-14.3.0
sparc64               randconfig-001-20260120    gcc-8.5.0
sparc64               randconfig-002-20260119    gcc-14.3.0
sparc64               randconfig-002-20260120    gcc-8.5.0
um                               alldefconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260119    gcc-14.3.0
um                    randconfig-001-20260120    gcc-8.5.0
um                    randconfig-002-20260119    gcc-14.3.0
um                    randconfig-002-20260120    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260119    gcc-14
x86_64      buildonly-randconfig-001-20260120    gcc-14
x86_64      buildonly-randconfig-002-20260119    gcc-14
x86_64      buildonly-randconfig-002-20260120    gcc-14
x86_64      buildonly-randconfig-003-20260119    gcc-14
x86_64      buildonly-randconfig-003-20260120    gcc-14
x86_64      buildonly-randconfig-004-20260119    gcc-14
x86_64      buildonly-randconfig-004-20260120    gcc-14
x86_64      buildonly-randconfig-005-20260119    gcc-14
x86_64      buildonly-randconfig-005-20260120    gcc-14
x86_64      buildonly-randconfig-006-20260119    gcc-14
x86_64      buildonly-randconfig-006-20260120    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260119    gcc-14
x86_64                randconfig-001-20260120    gcc-14
x86_64                randconfig-002-20260119    gcc-14
x86_64                randconfig-002-20260120    gcc-14
x86_64                randconfig-003-20260119    gcc-14
x86_64                randconfig-003-20260120    gcc-14
x86_64                randconfig-004-20260119    gcc-14
x86_64                randconfig-004-20260120    gcc-14
x86_64                randconfig-005-20260119    gcc-14
x86_64                randconfig-005-20260120    gcc-14
x86_64                randconfig-006-20260119    gcc-14
x86_64                randconfig-006-20260120    gcc-14
x86_64                randconfig-011-20260119    clang-20
x86_64                randconfig-011-20260120    gcc-14
x86_64                randconfig-012-20260119    clang-20
x86_64                randconfig-012-20260120    gcc-14
x86_64                randconfig-013-20260119    clang-20
x86_64                randconfig-013-20260120    gcc-14
x86_64                randconfig-014-20260119    clang-20
x86_64                randconfig-014-20260120    gcc-14
x86_64                randconfig-015-20260119    clang-20
x86_64                randconfig-015-20260120    gcc-14
x86_64                randconfig-016-20260119    clang-20
x86_64                randconfig-016-20260120    gcc-14
x86_64                randconfig-071-20260119    clang-20
x86_64                randconfig-071-20260120    gcc-14
x86_64                randconfig-072-20260119    clang-20
x86_64                randconfig-072-20260119    gcc-14
x86_64                randconfig-072-20260120    gcc-14
x86_64                randconfig-073-20260119    clang-20
x86_64                randconfig-073-20260119    gcc-14
x86_64                randconfig-073-20260120    gcc-14
x86_64                randconfig-074-20260119    clang-20
x86_64                randconfig-074-20260120    gcc-14
x86_64                randconfig-075-20260119    clang-20
x86_64                randconfig-075-20260119    gcc-14
x86_64                randconfig-075-20260120    gcc-14
x86_64                randconfig-076-20260119    clang-20
x86_64                randconfig-076-20260119    gcc-14
x86_64                randconfig-076-20260120    gcc-14
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
xtensa                randconfig-001-20260119    gcc-14.3.0
xtensa                randconfig-001-20260120    gcc-8.5.0
xtensa                randconfig-002-20260119    gcc-14.3.0
xtensa                randconfig-002-20260120    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

