Return-Path: <linux-efi+bounces-5399-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D48EC436DA
	for <lists+linux-efi@lfdr.de>; Sun, 09 Nov 2025 01:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E423A75AF
	for <lists+linux-efi@lfdr.de>; Sun,  9 Nov 2025 00:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674E413DBA0;
	Sun,  9 Nov 2025 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NobQE5IK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2937B63CB
	for <linux-efi@vger.kernel.org>; Sun,  9 Nov 2025 00:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762648333; cv=none; b=AmoHg1qEt7ItFDx36UFuYMGUlVa7Zz7M74wC/01tWwIX5B9tXntH/9xpKYM1MMs997sXVsc1vCx0Q1sMu7tLOl1B9qBBK1d5O+IBPsarspovscSKSlCBNhdIVz3G9IdAMH/urmNmla/FVrtbKXNLaKyLnXAmE2q51Ukjhhycw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762648333; c=relaxed/simple;
	bh=S4dLz/QHBHBZp9+wqsdX5NHV8vCDEIcz+b8UEZjbWkc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SfiFtkCBASJA/AiL/KMSc6k0R+reaibONktNZRcbXDuX4Ycy+NYOmsvdONRORlwpekBcTDGfErYUcMBOZ/+SAvHL05QvPTjTXMwrjjStMXT1Uao0NfAq++iO5iOcH8hgAcYHzDhLZUVr0BRt9CawINQBOiJ9UNdqQm0MN08JJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NobQE5IK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762648332; x=1794184332;
  h=date:from:to:cc:subject:message-id;
  bh=S4dLz/QHBHBZp9+wqsdX5NHV8vCDEIcz+b8UEZjbWkc=;
  b=NobQE5IKpstYs+QLLfS4vaWZNhExhQBZY0qbE11zjkWCUPBb6gSnc7jN
   THCRypP8CAXjRQOuEz/a93xgAyVjg9nFDA+bWefFNUaKJCcxePB4nCZIm
   v2iR9npJ9R6QLlBFUP1NejdKVdw+BIM7g2AzS8DVieVVNGeV9nG6zX0GX
   EKRvyqf0iUDjI8+3/ZS2NnZvKtSH8t2ngzr9ZMOJkws+0pyEbYUoTJUIE
   TdSfj+KCCAt6aNHXnrtUgKEefSFCc39+sW7zxsiuMdSpZTIL9xyW6YDFX
   VhhDRJ+P68kXt6REddC1JYHETDaag+grSEnmzM7OX1UE5b7xoPq0XG7CU
   A==;
X-CSE-ConnectionGUID: j2Yd4C22Taq4VQAUdq2K3g==
X-CSE-MsgGUID: 0uH1h0lcS/uj8a1kavCgHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64678932"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64678932"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 16:32:09 -0800
X-CSE-ConnectionGUID: 5H0wzx7ITfSE3cU56Njn0g==
X-CSE-MsgGUID: XLRePwyBSGm1U+/RQZqFCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="219090993"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Nov 2025 16:32:07 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHtLh-0001cZ-0z;
	Sun, 09 Nov 2025 00:32:05 +0000
Date: Sun, 09 Nov 2025 08:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS
 4f90742d4a09a8253861b0d5fd0984e3cd399c9b
Message-ID: <202511090809.DUEb1h8t-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 4f90742d4a09a8253861b0d5fd0984e3cd399c9b  efistub/x86: Add fallback for SMBIOS record lookup

elapsed time: 2928m

configs tested: 72
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
arc                    allmodconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc                    allyesconfig    gcc-15.1.0
arm                    allmodconfig    gcc-15.1.0
arm                     allnoconfig    clang-22
arm                    allyesconfig    gcc-15.1.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.1.0
arm64                  allyesconfig    clang-22
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                   allyesconfig    gcc-15.1.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-22
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch              allyesconfig    clang-22
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze             allmodconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
openrisc                allnoconfig    gcc-15.1.0
openrisc               allyesconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
parisc      randconfig-001-20251107    gcc-8.5.0
parisc      randconfig-002-20251107    gcc-12.5.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc                allyesconfig    clang-22
powerpc     randconfig-001-20251107    clang-22
powerpc     randconfig-002-20251107    clang-22
powerpc64   randconfig-001-20251107    gcc-14.3.0
powerpc64   randconfig-002-20251107    clang-22
riscv                  allmodconfig    clang-22
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    clang-16
riscv       randconfig-001-20251107    clang-22
riscv       randconfig-002-20251107    gcc-13.4.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390        randconfig-001-20251107    gcc-8.5.0
s390        randconfig-002-20251107    gcc-15.1.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh          randconfig-001-20251107    gcc-13.4.0
sh          randconfig-002-20251107    gcc-11.5.0
sparc                  allmodconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

