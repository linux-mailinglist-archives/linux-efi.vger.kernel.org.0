Return-Path: <linux-efi+bounces-3825-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24119AD1273
	for <lists+linux-efi@lfdr.de>; Sun,  8 Jun 2025 15:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EC43AB1AB
	for <lists+linux-efi@lfdr.de>; Sun,  8 Jun 2025 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867B24DCE1;
	Sun,  8 Jun 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTlKkLNR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663D19EEC2;
	Sun,  8 Jun 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749388987; cv=none; b=J3a+QA20TLykYhAiAKQa4pdOqjvAweXH4AxOx+gFi05xteCXzbEofXJKtlnRCBP8HU5CmKxLcRuwQNLZgAkbI8KJqAu/89JXv/P26UWs2Lr7Pi4oi1DatjBMCUyz+ANZ6kizOai4PUHEMJwPgqvwPGUKRriqUQ2zxbYzyVazhLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749388987; c=relaxed/simple;
	bh=yNmg/p1a9vGB0yjIGAZ5E0fL6+L4OsSlb2ysVJ580V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3j/0YR/9GwC54vdDdOU2Lql2TlePWSsD1qYhGdvoHh7TU08y0nPNPATuuyzL7EtuR7xbeCFSgCyoa7NxhsYvfyrWC1Zd2Spho/CoOdl3isFtnQY3HuYoNGZsAaRDHOcc+rOEaoFykwon1Xxs2yQCrtLPInaJToAsqZcEq2X5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTlKkLNR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749388985; x=1780924985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yNmg/p1a9vGB0yjIGAZ5E0fL6+L4OsSlb2ysVJ580V0=;
  b=GTlKkLNRJotBRL9IH0PINon5y0FYgXFXWHnZ+32enXsYWlqiUCiW5OwP
   GVmRiSnHzU6WZNPO6J2VzJ88m3ErbA73BgzGASBgdzckwN8Zv0+FKLU90
   sVNCfFeFaFEGyNKZdCk0KqqnutyDSvPGu58n25tiSBKhsd+YEwDGzl3TH
   S4NfvIrby3a6pU/MnEKDJ8xquhzTdkp6+JwzREbwmToedW5JgjWUQROYM
   Us4u0Eq16VaKahtxhWnm11TRzbwzomPTBR7TmvePaSVhoPzVTMEOjqLmM
   dk4gv/WcL/Lm2RvtTSq5YhDQbfXmEUIxGhu3zuXLE7mTVCuxtPhZsay36
   g==;
X-CSE-ConnectionGUID: uNqTGL8kSbC53mVCb7x46Q==
X-CSE-MsgGUID: bxtY3AgmRLuKxT+dhHCoSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="69041834"
X-IronPort-AV: E=Sophos;i="6.16,220,1744095600"; 
   d="scan'208";a="69041834"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 06:23:05 -0700
X-CSE-ConnectionGUID: pyrJDecKQPShiUXUsnlqIw==
X-CSE-MsgGUID: +KD7iydZSniklF+dBkBPVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,220,1744095600"; 
   d="scan'208";a="151270999"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Jun 2025 06:23:01 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOFzH-0006MP-0u;
	Sun, 08 Jun 2025 13:22:59 +0000
Date: Sun, 8 Jun 2025 21:22:01 +0800
From: kernel test robot <lkp@intel.com>
To: Khalid Ali <khaliidcaliy@gmail.com>, ardb@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, hpa@zytor.com,
	x86@kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Khalid Ali <khaliidcaliy@gmail.com>
Subject: Re: [PATCH] x86/efi: error handling on efi memory map
Message-ID: <202506082104.4eSjYWTe-lkp@intel.com>
References: <20250608090356.1115-1-khaliidcaliy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608090356.1115-1-khaliidcaliy@gmail.com>

Hi Khalid,

kernel test robot noticed the following build errors:

[auto build test ERROR on efi/next]
[also build test ERROR on tip/master tip/auto-latest linus/master v6.15 next-20250606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Khalid-Ali/x86-efi-error-handling-on-efi-memory-map/20250608-170711
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20250608090356.1115-1-khaliidcaliy%40gmail.com
patch subject: [PATCH] x86/efi: error handling on efi memory map
config: i386-buildonly-randconfig-002-20250608 (https://download.01.org/0day-ci/archive/20250608/202506082104.4eSjYWTe-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250608/202506082104.4eSjYWTe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506082104.4eSjYWTe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/platform/efi/efi_32.c:90:13: error: conflicting types for 'efi_map_region_fixed'
      90 | void __init efi_map_region_fixed(efi_memory_desc_t *md) {}
         |             ^
   arch/x86/include/asm/efi.h:131:19: note: previous declaration is here
     131 | extern int __init efi_map_region_fixed(efi_memory_desc_t *md);
         |                   ^
   1 error generated.


vim +/efi_map_region_fixed +90 arch/x86/platform/efi/efi_32.c

d2f7cbe7b26a74 Borislav Petkov 2013-10-31  89  
3b2664964bc886 Dave Young      2013-12-20 @90  void __init efi_map_region_fixed(efi_memory_desc_t *md) {}
1fec0533693cd7 Dave Young      2013-12-20  91  void __init parse_efi_setup(u64 phys_addr, u32 data_len) {}
3b2664964bc886 Dave Young      2013-12-20  92  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

