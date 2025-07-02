Return-Path: <linux-efi+bounces-4082-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FE9AF1082
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 11:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E53188DDF4
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 09:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFEE1DC9BB;
	Wed,  2 Jul 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyhjKVqI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97823B63E;
	Wed,  2 Jul 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449661; cv=none; b=S70gQQbNRuroIa7qJwv6ixM/u5t7ZwF54zUdGD+jaT2XoRb/Xv3Dnq2/Ps/1IBYefOlLIZk+4bCCyFtfxHvHzkWZhatvwSOHIL3YDTvPTweO91Br38NxAuHV5bksZf+U9J4vu8emtMz/F8SJPCdPT13Geo/D8Qg59jyh95PTuJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449661; c=relaxed/simple;
	bh=QquxLZIFBNYCLtfN2WN90KA9i4NdGTFGsp2moSfYXE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPPNVc4hjkx4ZU9eL3RaehdIUsx+OeHEQxWcu+YOAhMSxlQy5+ijrZBGO5WC1qMxhTfE13mwlSU4UE0qohMrOVXqOei3IuC/Kb5T9Ds6zx2S42KPSH4WU4vJkasijH0ANC8Xa5SbRIMs4dFwM06j2kG3WxWxASxGN3bYZw0g0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyhjKVqI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751449660; x=1782985660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QquxLZIFBNYCLtfN2WN90KA9i4NdGTFGsp2moSfYXE4=;
  b=fyhjKVqIUkxJb1JKT2G3z8DrvoAhm64ajH18/4AL9eTwL4sKR3L+zEKd
   WoFJzqiZoqsYj38FYd6ATJhl9wx/7FLhganpuoIRJlY/WMG7w3PwszVJ+
   RiPR798CF8rF+OMhUYRiQxTxTaDxOdxiea7AXahS0cnzjM4XYTjPdA2YJ
   2IP7EnC/O8XcZ/C+Xvhq+j1/b88dxgCRLZU8RSQrJPSYr5UbEaQCeSuMq
   HvghIS88wu+qdatejZ4yU9L7LBkEMDVGccJssUVtKrvBpf41yjvxHCK4n
   RP9nrxGvm1gjtav27jhE7dioWsRgoFik+H+uU3nzCEilEWI2M9iu4K026
   Q==;
X-CSE-ConnectionGUID: n+fzfk3QQ1CDo6Vjuen9HQ==
X-CSE-MsgGUID: nlaHByvfR5W1VGMsWkXO0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="52968088"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="52968088"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:47:38 -0700
X-CSE-ConnectionGUID: LkxK1xTYTBadfjlqZ0+zdg==
X-CSE-MsgGUID: kgMQFbTfRx2+ltJURfIKBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154180676"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 02 Jul 2025 02:47:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 427B11E0; Wed, 02 Jul 2025 12:47:24 +0300 (EEST)
Date: Wed, 2 Jul 2025 12:47:24 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Breno Leitao <leitao@debian.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCHv8 04/17] x86/cpu: Defer CR pinning setup until after EFI
 initialization
Message-ID: <5s25fkpxv6p3ai2iagtgyqhpt3c4cv54q6lgeeebizsseediyy@wl4epcc7i35a>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-5-kirill.shutemov@linux.intel.com>
 <080df169-0f47-40ea-b7b3-4d1a35bee151@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <080df169-0f47-40ea-b7b3-4d1a35bee151@intel.com>

On Tue, Jul 01, 2025 at 12:03:01PM -0700, Sohil Mehta wrote:
> On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
> > From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > 
> > In order to map the EFI runtime services, set_virtual_address_map()
> > needs to be called, which resides in the lower half of the address
> > space. This means that LASS needs to be temporarily disabled around
> > this call. This can only be done before the CR pinning is set up.
> > 
> > Move CR pinning setup behind the EFI initialization.
> > 
> > Wrapping efi_enter_virtual_mode() into lass_disable/enable_enforcement()
> 
> I believe this should be lass_stac()/clac() since we reverted to the
> original naming.

Doh. Will fix.

> > is not enough because AC flag gates data accesses, but not instruction
> > fetch. Clearing the CR4 bit is required.
> > 
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/cpu/common.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index 4f430be285de..9918121e0adc 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -2081,7 +2081,6 @@ static __init void identify_boot_cpu(void)
> >  	enable_sep_cpu();
> >  #endif
> >  	cpu_detect_tlb(&boot_cpu_data);
> > -	setup_cr_pinning();
> >  
> >  	tsx_init();
> >  	tdx_init();
> > @@ -2532,10 +2531,14 @@ void __init arch_cpu_finalize_init(void)
> >  
> >  	/*
> >  	 * This needs to follow the FPU initializtion, since EFI depends on it.
> > +	 *
> > +	 * EFI twiddles CR4.LASS. Do it before CR pinning.
> >  	 */
> >  	if (efi_enabled(EFI_RUNTIME_SERVICES))
> >  		efi_enter_virtual_mode();
> >  
> > +	setup_cr_pinning();
> > +
> 
> Instead of EFI toggling CR4.LASS, why not defer the first LASS
> activation itself?
> 
> i.e.
> 
> 	if (efi_enabled(EFI_RUNTIME_SERVICES))
> 		efi_enter_virtual_mode();
> 
> 	setup_lass();
> 
> 	setup_cr_pinning();
> 
> 
> This way, we can avoid the following patch (#5) altogether.

That's definitely an option.

The benefit of current approach is that the enforcement is enabled
earlier and cover more boot code, providing marginal protection
improvement.

I also like that related security features (SMEP/SMAP/UMIP/LASS) are
enabled in the same place.

In the end it is a judgement call.

Maintainers, any preference?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

