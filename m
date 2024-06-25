Return-Path: <linux-efi+bounces-1292-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7619174A6
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jun 2024 01:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4793C1C20BA9
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jun 2024 23:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47AF17F37B;
	Tue, 25 Jun 2024 23:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUNvtPfP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C9217D88C;
	Tue, 25 Jun 2024 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357746; cv=none; b=D7TpfDcSwz1+wTtajXvhOEfTfGv72sPt62GClkhwsCzW9SfhSGco4+YFn9r3D1cV9dnm4qgN40WebhGfveNsbt6ScA0SvzG5Gijl6CUDR8DikbQou33lHwSNFxtxne7oDg0z1MOktdPfLUNr81BR7dp6RsKBSCxnY6Kgncvek/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357746; c=relaxed/simple;
	bh=MRb7OZFN9oJW3BW6eAiPKWLGZEUnI6dcSkkPxJNaOPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeInAlEusmJWCfc4j33KMQwK7z2J5B2QHdcC2ZMEyj441GmdBH+4tc0Ikli2aWUzUM21lUnG4q6lM428XRMJaVrdAAHScf28O3ySza8jo5/Fp0QhK6YTpL7SE+cieZVvCF1WJKHM3zHa9K3/WExnyq7AB3RoNJnqPojrJ8kxTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUNvtPfP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719357745; x=1750893745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MRb7OZFN9oJW3BW6eAiPKWLGZEUnI6dcSkkPxJNaOPM=;
  b=IUNvtPfP5HgiHJXzEBTVl2hxT0b/4tThLKa4yBNl6PFnazT3o4nBbyh2
   adr2CCb8sIyNqyYA1w6lTBVzESd0nqnrYR8vc7IOxBrFCEAN8y+L5y4fU
   neVXbcPuPs58SwkQKK0WQ7jZCl1PfF9onl43cMOwk3TSd/ME1nQh3SmVX
   gbx98FtPAE1KXsMCfFQDdDxlAQlBxtyhzwEpZxHSY+KaMQ1HC5ovKUeh4
   fHAQmsKWyxHsQQJqobURfmaH5za4vw0+SakOvld0IIkHo/XzsMy0s/R7K
   Iydb6wb2/VV0ip76bLMUxbpFrQEdhS/s6IjjqENGofk0F1peS0d9RB7PW
   Q==;
X-CSE-ConnectionGUID: uK/ZPlm8QROt/7tmkOcaBg==
X-CSE-MsgGUID: drb0QLgEQU+lF0Vw5NZ/kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20214828"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="20214828"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 16:22:23 -0700
X-CSE-ConnectionGUID: 5XpBwJOvRH+bgZftcdtTvA==
X-CSE-MsgGUID: 0Qd4cPB1RiWmt6IggA96bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="43876572"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 25 Jun 2024 16:22:19 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMFUO-000Enu-0L;
	Tue, 25 Jun 2024 23:22:16 +0000
Date: Wed, 26 Jun 2024 07:21:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] x86/64/mm: Make 5-level paging support unconditional
Message-ID: <202406260735.rkb4c8N7-lkp@intel.com>
References: <20240621164406.256314-4-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621164406.256314-4-kirill.shutemov@linux.intel.com>

Hi Kirill,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/master linus/master tip/x86/mm v6.10-rc5 next-20240625]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kirill-A-Shutemov/x86-64-mm-Always-use-dynamic-memory-layout/20240625-183159
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240621164406.256314-4-kirill.shutemov%40linux.intel.com
patch subject: [PATCH 3/3] x86/64/mm: Make 5-level paging support unconditional
config: i386-buildonly-randconfig-004-20240626 (https://download.01.org/0day-ci/archive/20240626/202406260735.rkb4c8N7-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406260735.rkb4c8N7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406260735.rkb4c8N7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/mm/pgtable.c:699:5: error: redefinition of 'p4d_set_huge'
     699 | int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
         |     ^~~~~~~~~~~~
   In file included from include/linux/mm.h:30,
                    from arch/x86/mm/pgtable.c:2:
   include/linux/pgtable.h:1665:19: note: previous definition of 'p4d_set_huge' with type 'int(p4d_t *, phys_addr_t,  pgprot_t)' {aka 'int(p4d_t *, long long unsigned int,  struct pgprot)'}
    1665 | static inline int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
         |                   ^~~~~~~~~~~~
>> arch/x86/mm/pgtable.c:709:6: error: redefinition of 'p4d_clear_huge'
     709 | void p4d_clear_huge(p4d_t *p4d)
         |      ^~~~~~~~~~~~~~
   include/linux/pgtable.h:1669:20: note: previous definition of 'p4d_clear_huge' with type 'void(p4d_t *)'
    1669 | static inline void p4d_clear_huge(p4d_t *p4d) { }
         |                    ^~~~~~~~~~~~~~


vim +/p4d_set_huge +699 arch/x86/mm/pgtable.c

6b6378355b9250 Toshi Kani         2015-04-14  692  
6b6378355b9250 Toshi Kani         2015-04-14  693  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  694  /**
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  695   * p4d_set_huge - setup kernel P4D mapping
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  696   *
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  697   * No 512GB pages yet -- always return 0
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  698   */
b8504058a06bd1 Kirill A. Shutemov 2017-03-30 @699  int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  700  {
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  701  	return 0;
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  702  }
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  703  
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  704  /**
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  705   * p4d_clear_huge - clear kernel P4D mapping when it is set
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  706   *
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  707   * No 512GB pages yet -- always return 0
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  708   */
c8db8c2628afc7 Li kunyu           2022-05-12 @709  void p4d_clear_huge(p4d_t *p4d)
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  710  {
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  711  }
b8504058a06bd1 Kirill A. Shutemov 2017-03-30  712  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

