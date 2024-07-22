Return-Path: <linux-efi+bounces-1475-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48D938F20
	for <lists+linux-efi@lfdr.de>; Mon, 22 Jul 2024 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36A41F21B8C
	for <lists+linux-efi@lfdr.de>; Mon, 22 Jul 2024 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAAA16C846;
	Mon, 22 Jul 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2CUzptM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0EF3A8D0
	for <linux-efi@vger.kernel.org>; Mon, 22 Jul 2024 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721651687; cv=none; b=C9Nkcb2yIphQsun5rIbL3rasCmY+Eja8RkLCEgBdvN+wZOn0bOPJ6HED+D6pKCt9TDfvMMMBJM30af0fYPVF+rdw56nwg6CpvozFu+RRWx3/39bcR3xHSJlgqSdhcQ4/T+tg9j9bstiePA5sdqJcoRqdolEkmZ3STwXJQ4rdVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721651687; c=relaxed/simple;
	bh=Ik762HhGn2ZeDlDKoRrH8hE0HLCrKfhIyjraaYjPH/A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PhwJUXhLb6vCXxzWCt9kCyyYs/NO+6QQdAlFrcYglQyPC+nhhY+eKD7DCvM4EvqRX4eFBRWtp6cNb8UNpyKVzFajFdMqn7UynE2IdQnRfW855O76LEon50cmb+pQdmMJqz5HmV/mCAS9dEdDmOda19+WDv9DMvpxJe9zhujYIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2CUzptM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721651685; x=1753187685;
  h=date:from:to:cc:subject:message-id;
  bh=Ik762HhGn2ZeDlDKoRrH8hE0HLCrKfhIyjraaYjPH/A=;
  b=H2CUzptMAWSgggYxD6sP9PuCfo8s4Pi1O34crkgKzUbDS+W1ZwQsla4W
   Q2zWPxvw+W04FseMeAM798yxVVqzCyjG3T61gHc8bLqA8QD8Pajt7FBBJ
   81CzXcj4EDvKeRc1q1WfgkFqtbp3ytK/2Z/che+F2jQYDi7T8rz75ZirX
   +8CWdA+rhDfc53fr3BpWPRGm3w0QRuliKEK5clVMwaTtPN+i4p4oUcbG7
   X6oQAlhOXGXYFEQ0qhzm1qdSuU1lNLgXR2O7crZX92p6sveevIjIhlSKD
   38fg49RZY/e3CYGi9N1K8/5hCH1p7gjzzew8Ylfgm9w1Mktw/uNhXKGF8
   Q==;
X-CSE-ConnectionGUID: QQtLbMFjQlCncOOOpPuvZQ==
X-CSE-MsgGUID: 9wsB5w3LTYGtrDCmE4Arvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="30643459"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="30643459"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 05:34:45 -0700
X-CSE-ConnectionGUID: Yn2UT3MORuW2LIDBmXyrxw==
X-CSE-MsgGUID: 9AygrS1eQsqrOuumCZCXOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="82510698"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Jul 2024 05:34:43 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVsFU-000l8y-0n;
	Mon, 22 Jul 2024 12:34:40 +0000
Date: Mon, 22 Jul 2024 20:34:30 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 ae835a96d72cd025421910edb0e8faf706998727
Message-ID: <202407222028.W8PVVdg4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: ae835a96d72cd025421910edb0e8faf706998727  x86/efistub: Revert to heap allocated boot_params for PE entrypoint

elapsed time: 1156m

configs tested: 173
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240722   gcc-13.2.0
arc                   randconfig-002-20240722   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                         assabet_defconfig   clang-15
arm                     davinci_all_defconfig   clang-19
arm                                 defconfig   clang-14
arm                                 defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   clang-16
arm                           imxrt_defconfig   clang-19
arm                            mps2_defconfig   clang-19
arm                   randconfig-001-20240722   gcc-14.1.0
arm                   randconfig-002-20240722   clang-19
arm                   randconfig-003-20240722   clang-19
arm                   randconfig-004-20240722   clang-19
arm                         socfpga_defconfig   clang-19
arm                       versatile_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240722   clang-19
arm64                 randconfig-002-20240722   clang-19
arm64                 randconfig-003-20240722   clang-15
arm64                 randconfig-004-20240722   gcc-14.1.0
csky                             alldefconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240722   gcc-14.1.0
csky                  randconfig-002-20240722   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240722   clang-17
hexagon               randconfig-002-20240722   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240722   gcc-13
i386         buildonly-randconfig-002-20240722   gcc-13
i386         buildonly-randconfig-003-20240722   clang-18
i386         buildonly-randconfig-004-20240722   clang-18
i386         buildonly-randconfig-005-20240722   gcc-9
i386         buildonly-randconfig-006-20240722   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240722   clang-18
i386                  randconfig-002-20240722   clang-18
i386                  randconfig-003-20240722   gcc-11
i386                  randconfig-004-20240722   clang-18
i386                  randconfig-005-20240722   clang-18
i386                  randconfig-006-20240722   gcc-13
i386                  randconfig-011-20240722   gcc-13
i386                  randconfig-012-20240722   clang-18
i386                  randconfig-013-20240722   clang-18
i386                  randconfig-014-20240722   clang-18
i386                  randconfig-015-20240722   clang-18
i386                  randconfig-016-20240722   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240722   gcc-14.1.0
loongarch             randconfig-002-20240722   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                                defconfig   gcc-14.1.0
m68k                          hp300_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                        bcm63xx_defconfig   clang-19
mips                         db1xxx_defconfig   clang-19
mips                      fuloong2e_defconfig   clang-19
mips                     loongson1c_defconfig   clang-19
mips                      malta_kvm_defconfig   clang-19
mips                  maltasmvp_eva_defconfig   clang-19
mips                        qi_lb60_defconfig   clang-19
mips                          rb532_defconfig   clang-19
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240722   gcc-14.1.0
nios2                 randconfig-002-20240722   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240722   gcc-14.1.0
parisc                randconfig-002-20240722   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                     asp8347_defconfig   clang-19
powerpc                      chrp32_defconfig   clang-19
powerpc                        fsp2_defconfig   gcc-14.1.0
powerpc                   lite5200b_defconfig   clang-19
powerpc                 mpc8313_rdb_defconfig   gcc-14.1.0
powerpc                  mpc885_ads_defconfig   clang-19
powerpc                         ps3_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240722   clang-19
powerpc               randconfig-002-20240722   clang-19
powerpc               randconfig-003-20240722   gcc-14.1.0
powerpc                     redwood_defconfig   clang-19
powerpc                     tqm8541_defconfig   clang-15
powerpc64                        alldefconfig   clang-19
powerpc64             randconfig-001-20240722   gcc-14.1.0
powerpc64             randconfig-002-20240722   gcc-14.1.0
powerpc64             randconfig-003-20240722   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240722   clang-19
riscv                 randconfig-002-20240722   clang-17
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240722   gcc-14.1.0
s390                  randconfig-002-20240722   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          lboxre2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240722   gcc-14.1.0
sh                    randconfig-002-20240722   gcc-14.1.0
sh                          rsk7201_defconfig   gcc-14.1.0
sh                   sh7724_generic_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240722   gcc-14.1.0
sparc64               randconfig-002-20240722   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240722   gcc-13
um                    randconfig-002-20240722   clang-19
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240722   gcc-14.1.0
xtensa                randconfig-002-20240722   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

