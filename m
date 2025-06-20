Return-Path: <linux-efi+bounces-3870-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED22AE1F90
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 17:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D4B3B017A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C80A2D3A6A;
	Fri, 20 Jun 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzbxPyiy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2628C037;
	Fri, 20 Jun 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434937; cv=none; b=RXCewXwuVyMTdL+dXIc2bgtD0nqIIxySElQnZRXUqm9nDShhK2ipwi4gg5AwpZLCGFbPoFEId5ecYVKL7Pnp+3duTYDqYXpU2Qs20L0CD4fvpgdZ3t8PyJWpF6uCIuyeSk3qxICdTAGgZdME58/kcIgyaSzTLGU1MAkdZKGq0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434937; c=relaxed/simple;
	bh=redXOYeCpKZBh+pLo/Ehn44+G435+Q4Pmuu1SB+tN54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqtBuSctOpbzy5RNFr1cYthGHUwTgRWKERqFqoytDNxG1kda5qQJbjBCIV0GQnQPNAHuIU0k+/i4t7iQdHV5SphKthgarcY5AFo01XgU0aA+gy5ZnQM/jwSz8KCc34fn70w28yz/G7or9pEmKG74eUVeTVo+FUGBdsi/vHitYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzbxPyiy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750434935; x=1781970935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=redXOYeCpKZBh+pLo/Ehn44+G435+Q4Pmuu1SB+tN54=;
  b=mzbxPyiydAjFQtdOi2KdxDOx1ROKcI4aRO1deZxpTfR2ZdSXnA5PP5Cq
   jbZ9F9b24WukPfdAGoA3eBA4aIAgm/8ejJ8dNNTzwgzRhTJ4kJ2Ub7pRu
   lVOCoJ6ABmdMEOAdnzAVPVazxZcklFBk0qcrPiy+cM/2eLZ+pfXJYXv4n
   aHa19ro4HZ627OoORiTtbX9ZPqSTLCnes+ViRzHgCF9GLFs+nBiksTgh9
   Or/+UIrJcmo/7+bO3rgvk1UuSR1OBBOW4JT6MLGtwGJsPKjfBfrChHvKf
   UQuG7mfZJerxWJF7sN21v7XCfYHXkY5mJkiCVDgvdkyZqrx+fFUW2dw9M
   w==;
X-CSE-ConnectionGUID: 5RvDvJIORvyjE8SrPjv3kw==
X-CSE-MsgGUID: kTSlmxwVQnymvTEz27vpkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51815957"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="51815957"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 08:55:33 -0700
X-CSE-ConnectionGUID: VwZYmYr9TmCFNCQaR48eTw==
X-CSE-MsgGUID: 4Os9WouSRgap++Yc2gOF7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151085092"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.108.136]) ([10.125.108.136])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 08:55:30 -0700
Message-ID: <5bb6275b-5046-4bda-8c92-434e59cac08f@intel.com>
Date: Fri, 20 Jun 2025 08:55:29 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 06/16] efi: Disable LASS around
 set_virtual_address_map() EFI call
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
 Breno Leitao <leitao@debian.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>,
 Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>,
 Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>,
 Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
 Changbin Du <changbin.du@huawei.com>,
 Huang Shijie <shijie@os.amperecomputing.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-7-kirill.shutemov@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250620135325.3300848-7-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 06:53, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 463b784499a8..94c335229697 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -825,11 +825,24 @@ static void __init __efi_enter_virtual_mode(void)
>  
>  	efi_sync_low_kernel_mappings();
>  
> +	/*
> +	 * set_virtual_address_map is the only service located at lower
> +	 * addresses, so we have to temporarily disable LASS around it.
> +	 * Note that clearing EFLAGS.AC is not enough for this, the whole
> +	 * LASS needs to be disabled.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_LASS))
> +		cr4_clear_bits(X86_CR4_LASS);

Could we do it like this instead?

	unsigned long lass = cr4_read_shadow() & X86_FEATURE_LASS;
	...
	cr4_clear_bits(lass);

>  	status = efi_set_virtual_address_map(efi.memmap.desc_size * count,
>  					     efi.memmap.desc_size,
>  					     efi.memmap.desc_version,
>  					     (efi_memory_desc_t *)pa,
>  					     efi_systab_phys);
> +
> +	if (cpu_feature_enabled(X86_FEATURE_LASS))
> +		cr4_set_bits(X86_CR4_LASS);

and:

	cr4_set_bits(lass);

>  	if (status != EFI_SUCCESS) {
>  		pr_err("Unable to switch EFI into virtual mode (status=%lx)!\n",
>  		       status);

That way, neither the presence of X86_FEATURE_LASS nor the ordering of
setting up X86_CR4_LASS matters.

Let's say the CPU supports X86_FEATURE_LASS and this code gets called
before the kernel is ready for LASS. It would break as written above.


