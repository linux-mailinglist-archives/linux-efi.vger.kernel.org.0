Return-Path: <linux-efi+bounces-5116-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12116C02C7B
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 19:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C60519A3BD6
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1811834A76E;
	Thu, 23 Oct 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A88bSslO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE25347BD7;
	Thu, 23 Oct 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241500; cv=none; b=DX3bPPanqNnbhNqQDTkJN9Gxu7JuuR7NttjFxv1prq3LDtUIYaURbBfLfMBc/lWgduwKq54R1IBsam7sYyfQYA6Hp7uBfiGShPZSPCrkrACJ+XEQu0yp4cr9/t1qOu+SytJi9l1pqNIuLC3SEHAAMHJ0Xr87xCGiqLK4wqsoO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241500; c=relaxed/simple;
	bh=ibZdP/tYK9tLt0c+JyUCR9jnwCzMbR/JfkEbi9WqQjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/KYQOWko8W3rMGHVLZqirmYan9tQeChsSJXVwYAG6LBZLDcRTxFFcIdC14f7ImlupX4zPXJigCSmy0D4/Qp42t+yQOQw6tbZ3TOlpopRbhCqYiRqlGhmtm09HFPOJa0iGh9Tx55P74w0jcTQJVUI/63VjGHgREK2bxr4GcosyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A88bSslO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761241497; x=1792777497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ibZdP/tYK9tLt0c+JyUCR9jnwCzMbR/JfkEbi9WqQjQ=;
  b=A88bSslOSQBP2kKdHsJ0zbKUQUZ1I5qB2t9NMzx6hwz+YH65twwFgMXZ
   n/h+Jq7U/yumN7x8YnDvq3QZLkAvedVQamcbavcQgW49RJ1b0UZD4ifpd
   G4Z03rhvRbH6Vno+jM5HK47/au1X8ekcDutLf/ExLtHP97z1PA7k8o/mN
   GsPrCissLM7X6N36PU1Whmbo9052tafwW9oFUrDKPRBBYqXogGb3XxIug
   CtlSeOYf/9qC1yV7RUsMWY9sXHnwyIvJYI89+4VGX+e2mG5IuniFjtUPq
   LBxeGLXr6fmn6uOC2rjMLKa725l1hejraP4jvwDam9dx6mXc+PEmq1b2P
   Q==;
X-CSE-ConnectionGUID: uq4wO+rFS8aoxdQclTxm1A==
X-CSE-MsgGUID: WvAIlfNnShKcb9NxLXGwwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66035693"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="66035693"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:44:56 -0700
X-CSE-ConnectionGUID: fAhfSvYOSUS1G2javmI1yA==
X-CSE-MsgGUID: tRnT6RATRYaYQwaZtS60iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="184605067"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 23 Oct 2025 10:44:52 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBzMo-000DkX-1N;
	Thu, 23 Oct 2025 17:44:50 +0000
Date: Fri, 24 Oct 2025 01:43:48 +0800
From: kernel test robot <lkp@intel.com>
To: Usama Arif <usamaarif642@gmail.com>, dwmw@amazon.co.uk,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	apopple@nvidia.com, thuth@redhat.com, nik.borisov@suse.com,
	kas@kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH 1/3] x86/boot: Fix page table access in 5-level to
 4-level paging transition
Message-ID: <202510240106.1aff6SIM-lkp@intel.com>
References: <20251022220755.1026144-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022220755.1026144-2-usamaarif642@gmail.com>

Hi Usama,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/master efi/next linus/master v6.18-rc2 next-20251023]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Usama-Arif/x86-boot-Fix-page-table-access-in-5-level-to-4-level-paging-transition/20251023-061048
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20251022220755.1026144-2-usamaarif642%40gmail.com
patch subject: [PATCH 1/3] x86/boot: Fix page table access in 5-level to 4-level paging transition
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20251024/202510240106.1aff6SIM-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510240106.1aff6SIM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510240106.1aff6SIM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/boot/compressed/pgtable_64.c:185:21: error: call to undeclared function 'pgd_val'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     185 |                 new_cr3 = (u64 *)(pgd_val(pgdp[0]) & PTE_PFN_MASK);
         |                                   ^
   1 error generated.


vim +/pgd_val +185 arch/x86/boot/compressed/pgtable_64.c

   101	
   102	asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
   103	{
   104		void (*toggle_la57)(void *cr3);
   105		bool l5_required = false;
   106	
   107		/* Initialize boot_params. Required for cmdline_find_option_bool(). */
   108		sanitize_boot_params(bp);
   109		boot_params_ptr = bp;
   110	
   111		/*
   112		 * Check if LA57 is desired and supported.
   113		 *
   114		 * There are several parts to the check:
   115		 *   - if user asked to disable 5-level paging: no5lvl in cmdline
   116		 *   - if the machine supports 5-level paging:
   117		 *     + CPUID leaf 7 is supported
   118		 *     + the leaf has the feature bit set
   119		 */
   120		if (!cmdline_find_option_bool("no5lvl") &&
   121		    native_cpuid_eax(0) >= 7 && (native_cpuid_ecx(7) & BIT(16))) {
   122			l5_required = true;
   123	
   124			/* Initialize variables for 5-level paging */
   125			__pgtable_l5_enabled = 1;
   126			pgdir_shift = 48;
   127			ptrs_per_p4d = 512;
   128		}
   129	
   130		/*
   131		 * The trampoline will not be used if the paging mode is already set to
   132		 * the desired one.
   133		 */
   134		if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
   135			return;
   136	
   137		trampoline_32bit = (unsigned long *)find_trampoline_placement();
   138	
   139		/* Preserve trampoline memory */
   140		memcpy(trampoline_save, trampoline_32bit, TRAMPOLINE_32BIT_SIZE);
   141	
   142		/* Clear trampoline memory first */
   143		memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
   144	
   145		/* Copy trampoline code in place */
   146		toggle_la57 = memcpy(trampoline_32bit +
   147				TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
   148				&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
   149	
   150		/*
   151		 * Avoid the need for a stack in the 32-bit trampoline code, by using
   152		 * LJMP rather than LRET to return back to long mode. LJMP takes an
   153		 * immediate absolute address, which needs to be adjusted based on the
   154		 * placement of the trampoline.
   155		 */
   156		*(u32 *)((u8 *)toggle_la57 + trampoline_ljmp_imm_offset) +=
   157							(unsigned long)toggle_la57;
   158	
   159		/*
   160		 * The code below prepares page table in trampoline memory.
   161		 *
   162		 * The new page table will be used by trampoline code for switching
   163		 * from 4- to 5-level paging or vice versa.
   164		 */
   165	
   166		if (l5_required) {
   167			/*
   168			 * For 4- to 5-level paging transition, set up current CR3 as
   169			 * the first and the only entry in a new top-level page table.
   170			 */
   171			*trampoline_32bit = __native_read_cr3() | _PAGE_TABLE_NOENC;
   172		} else {
   173			u64 *new_cr3;
   174			pgd_t *pgdp;
   175	
   176			/*
   177			 * For 5- to 4-level paging transition, copy page table pointed
   178			 * by first entry in the current top-level page table as our
   179			 * new top-level page table.
   180			 *
   181			 * We cannot just point to the page table from trampoline as it
   182			 * may be above 4G.
   183			 */
   184			pgdp = (pgd_t *)read_cr3_pa();
 > 185			new_cr3 = (u64 *)(pgd_val(pgdp[0]) & PTE_PFN_MASK);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

