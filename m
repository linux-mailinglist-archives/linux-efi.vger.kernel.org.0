Return-Path: <linux-efi+bounces-5524-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25948C61C31
	for <lists+linux-efi@lfdr.de>; Sun, 16 Nov 2025 21:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4421357ABB
	for <lists+linux-efi@lfdr.de>; Sun, 16 Nov 2025 20:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0BC22FE11;
	Sun, 16 Nov 2025 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3DvScey"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BC1991CB
	for <linux-efi@vger.kernel.org>; Sun, 16 Nov 2025 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763324028; cv=none; b=lFhVhuIL95YE8Wt0ewGJJcBrtjMY+LBcxWUcBiqVhlpBQsLea7cPPeKiA5P3autv2lpK1eIGw/41vg4HpNfJ2wCYm5gASKvBHWN2AZXfz8eHCJFdwtDb+r2+SwD9oGzKkPJqG9MclucWQr3PM8XR4YC9AZ+W1NphweiaiHdz3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763324028; c=relaxed/simple;
	bh=i8X/vViPXl5R7EXdy3ssvyLp7093lsavt57KzGCElqM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fejo+HNsP1X9RctvGlbarOMYBZQo6SUVDZOcLPIfCe4+Dg7+alvI+3tUIlTwhI1VQGDOCEOkpjRW6aQxCrpkTNWaN58Yk1hcVZc9wwrFAXwzTZwtUns78n8FVpGj1q+t+8c2hc7K3qlJffsZPn3UjTK/R/IYMFlN9GcC7iKGSz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3DvScey; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763324026; x=1794860026;
  h=date:from:to:cc:subject:message-id;
  bh=i8X/vViPXl5R7EXdy3ssvyLp7093lsavt57KzGCElqM=;
  b=C3DvSceyqFs/Q57clpzS2Ba51qAPxZ0rT4V+/9+B/y1tPf+zTTEFkNBd
   GMWGbeH7oUWdPTJDj/13QcIRIe4F0kbcTpHcVTqQjs6tTqCuPoiX0DRmt
   rO0kj10L508bIaCZgT8jwCa+vVCz+eNKmryHo8/4QmFd04HE+3GZI4kiR
   DljUzt8EJqYiX9iB04oPwwUqq2bk9JV2jBCxcQUIDdhvGfozaLK7zZWND
   TYGuAZFyn4rXPHRc/yxA0Q4ZsU242IABbcMF+TNaaUgfvf1aQj2qrqRhy
   CNCWKjXUKEy94lekhx42Xfu4VZZsQb+v+yAZzdGPd2xgxEnksJxZj3W8c
   A==;
X-CSE-ConnectionGUID: 7/Mmo/HAT4Gte1xH9u7ZJg==
X-CSE-MsgGUID: Zrq3iNbfQb6uaUY8HEfNmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="75933862"
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; 
   d="scan'208";a="75933862"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 12:13:45 -0800
X-CSE-ConnectionGUID: 746yvFAwSDaUmnHkjn3mMA==
X-CSE-MsgGUID: iulXpTUfTd2kfJNztGA+CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; 
   d="scan'208";a="227610976"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Nov 2025 12:13:44 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKj81-00092x-2a;
	Sun, 16 Nov 2025 20:13:41 +0000
Date: Mon, 17 Nov 2025 04:13:25 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 cb46a58d77e5b433e9f4538faaa2a73970157e8d
Message-ID: <202511170419.dDWRcPmf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: cb46a58d77e5b433e9f4538faaa2a73970157e8d  efi/memattr: Convert efi_memattr_init() return type to void

elapsed time: 7315m

configs tested: 66
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251112    gcc-8.5.0
arc         randconfig-002-20251112    gcc-9.5.0
arm                     allnoconfig    clang-22
arm         randconfig-001-20251112    gcc-8.5.0
arm         randconfig-002-20251112    clang-22
arm         randconfig-003-20251112    clang-22
arm         randconfig-004-20251112    gcc-14.3.0
arm64                   allnoconfig    gcc-15.1.0
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                   allyesconfig    gcc-15.1.0
hexagon                 allnoconfig    clang-22
hexagon     randconfig-001-20251112    clang-16
hexagon     randconfig-002-20251112    clang-22
i386                    allnoconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch   randconfig-001-20251112    gcc-15.1.0
loongarch   randconfig-002-20251112    gcc-13.4.0
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze             allmodconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2                  allyesconfig    gcc-11.5.0
nios2       randconfig-001-20251112    gcc-11.5.0
nios2       randconfig-002-20251112    gcc-11.5.0
openrisc               allmodconfig    gcc-15.1.0
openrisc                allnoconfig    gcc-15.1.0
openrisc               allyesconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc                allyesconfig    clang-22
riscv                  allmodconfig    clang-22
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sparc                  allmodconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc                  allyesconfig    gcc-15.1.0
sparc64                allyesconfig    gcc-15.1.0
um                      allnoconfig    clang-22
x86_64                  allnoconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
xtensa                  allnoconfig    gcc-15.1.0
xtensa                 allyesconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

