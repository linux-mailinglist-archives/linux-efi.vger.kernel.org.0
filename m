Return-Path: <linux-efi+bounces-1312-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BCF91C48C
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68FCB20A6E
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AF41CB317;
	Fri, 28 Jun 2024 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmRdnXd1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE62263A
	for <linux-efi@vger.kernel.org>; Fri, 28 Jun 2024 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594901; cv=none; b=YeOXFVpMMs2QgIOYbFK1QPDIWlInbfhYpiKtOdK5jmuLAlDF/n5DbKTlxz4ZP6HxsEHAzO/uayBjs4R/X6ch3O6RDLVmldneoKFhToPsJ53JgjWxO+f0PapYDUn0BFl8tqzotGdwxyMo9e0F4urnsQL/U1eO6jgDrYshR068bpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594901; c=relaxed/simple;
	bh=7V4usvisBWjgJiUBxpVmP6/qp/NFq8IoHDK1E1hr0G4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sYYYLJYMmwaJfym5EU9uOqN1c8yxgPzfwwkbYHrws222PtSA0s9N5pLbQRM0+NbRSh3mEXSOY+ExLrx7RzBx++OB7Omb8TqmHy6S9tHkcGWuJeh06BTKks2Su7+frmT3cl63fV5i0RPznRZynuKKYIe4LeRNwIi24hLXAcq+psQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmRdnXd1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719594901; x=1751130901;
  h=date:from:to:cc:subject:message-id;
  bh=7V4usvisBWjgJiUBxpVmP6/qp/NFq8IoHDK1E1hr0G4=;
  b=NmRdnXd1dYa5EHKdIQ9EM0lwv0niTDt02kNzTywbbDw2RRg543c4YXxe
   Yn1zNdGyYqj/JOeEtyIU+MhRhiRdYme8xA/oyD5WxLMBH45ltmTRcb9Et
   kaKElx77nWo7XSoqvZ8Xx+4W+qL4azxHTbkBOU5J6Juw/FF4ENbLj5wyt
   gXs4p8+DKWzXWxMNB+GjOAs35oU9svQLUvjbAcommsuqhcaSJaZ09wxqw
   YdZmGMDZFHDL26JzBHNTbutM2nkli+OpMgQ6FLIijvcOLdRvPR9caNx3u
   YvzuuCkID2U6BpnG946OuNga71wqfdv6bQtZgHrFCYGdT0M25UROnlG2z
   g==;
X-CSE-ConnectionGUID: QCp5W8xHQw2snqzje22zIw==
X-CSE-MsgGUID: IiafY16XTpyijUjOhT+7Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16623925"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16623925"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 10:15:00 -0700
X-CSE-ConnectionGUID: /aTr5Ty8Qce+KkqNTyBB1g==
X-CSE-MsgGUID: hrEp4cSiRtmLyzE3XOvWUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="49414997"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jun 2024 10:14:59 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNFBY-000Hb2-0u;
	Fri, 28 Jun 2024 17:14:56 +0000
Date: Sat, 29 Jun 2024 01:13:56 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 2e15194fbc85dd07f117e51de2d6485ea069d950
Message-ID: <202406290154.nyr3E1sx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 2e15194fbc85dd07f117e51de2d6485ea069d950  x86/efi: Drop support for fake EFI memory maps

elapsed time: 10290m

configs tested: 143
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                         bcm2835_defconfig   gcc-13.2.0
arm                     davinci_all_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                           omap1_defconfig   gcc-13.2.0
arm                           tegra_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                            allyesconfig   clang-19
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240622   gcc-13
i386         buildonly-randconfig-001-20240628   gcc-10
i386         buildonly-randconfig-002-20240628   gcc-10
i386         buildonly-randconfig-003-20240628   gcc-10
i386         buildonly-randconfig-004-20240622   gcc-13
i386         buildonly-randconfig-004-20240628   gcc-10
i386         buildonly-randconfig-005-20240622   gcc-13
i386         buildonly-randconfig-005-20240628   gcc-10
i386         buildonly-randconfig-006-20240628   gcc-10
i386                                defconfig   clang-18
i386                  randconfig-001-20240622   gcc-10
i386                  randconfig-001-20240628   gcc-10
i386                  randconfig-002-20240628   gcc-10
i386                  randconfig-003-20240622   gcc-13
i386                  randconfig-003-20240628   gcc-10
i386                  randconfig-004-20240622   gcc-13
i386                  randconfig-004-20240628   gcc-10
i386                  randconfig-005-20240628   gcc-10
i386                  randconfig-006-20240622   gcc-13
i386                  randconfig-006-20240628   gcc-10
i386                  randconfig-011-20240622   gcc-9
i386                  randconfig-011-20240628   gcc-10
i386                  randconfig-012-20240622   gcc-7
i386                  randconfig-012-20240628   gcc-10
i386                  randconfig-013-20240628   gcc-10
i386                  randconfig-014-20240628   gcc-10
i386                  randconfig-015-20240628   gcc-10
i386                  randconfig-016-20240628   gcc-10
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                             allmodconfig   clang-19
mips                              allnoconfig   gcc-13.2.0
mips                             allyesconfig   clang-19
mips                          ath79_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                         allmodconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                    klondike_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sparc                            allyesconfig   gcc-13.2.0
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240628   gcc-13
x86_64       buildonly-randconfig-002-20240628   gcc-13
x86_64       buildonly-randconfig-003-20240628   gcc-13
x86_64       buildonly-randconfig-004-20240628   gcc-13
x86_64       buildonly-randconfig-005-20240628   gcc-13
x86_64       buildonly-randconfig-006-20240628   gcc-13
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240628   gcc-13
x86_64                randconfig-002-20240628   gcc-13
x86_64                randconfig-003-20240628   gcc-13
x86_64                randconfig-004-20240628   gcc-13
x86_64                randconfig-005-20240628   gcc-13
x86_64                randconfig-006-20240628   gcc-13
x86_64                randconfig-011-20240628   gcc-13
x86_64                randconfig-012-20240628   gcc-13
x86_64                randconfig-013-20240628   gcc-13
x86_64                randconfig-014-20240628   gcc-13
x86_64                randconfig-015-20240628   gcc-13
x86_64                randconfig-016-20240628   gcc-13
x86_64                randconfig-071-20240628   gcc-13
x86_64                randconfig-072-20240628   gcc-13
x86_64                randconfig-073-20240628   gcc-13
x86_64                randconfig-074-20240628   gcc-13
x86_64                randconfig-075-20240628   gcc-13
x86_64                randconfig-076-20240628   gcc-13
x86_64                          rhel-8.3-func   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                           allyesconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

