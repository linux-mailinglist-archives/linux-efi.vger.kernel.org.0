Return-Path: <linux-efi+bounces-3879-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F1FAE217F
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 19:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973F01687C0
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228D52253FF;
	Fri, 20 Jun 2025 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJAxo6ok"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4B1FAC34;
	Fri, 20 Jun 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441840; cv=none; b=m06KDhQrPS16FDOv4YftBCwt1LDiTa7/fDMsdayz0K9oaQD+c8oBbxZkZ9RZ8MiW5bEWPaWi3eKRW+nJR3CKFhDmec0xUCrcEbbauqoL5KO9zL8wCFmD3tJa9IdmWw3cIuCxKKarxgaF9m0prlyu1MYAVRYkkwIMRc3PFfNmBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441840; c=relaxed/simple;
	bh=GKe85BRj+aBlgJq8ZSqdTGlkuD86znOrDCE8X6u/nxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtTdN7C2etU+5S3D4FnRI13UFSA5s+waCqWMqX71DSNA8LZMpLOkiKHxXVoyLekXbtxlvu4OXIygM97RFWCttyb9WD8q0Xkayo/1jKPq6+dpWQN7nWeDAL3OJQdoYRp4QgASq8FKlTnoS/lWjaXPF3LCj7VbyfTlBN31/8nDCr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJAxo6ok; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750441838; x=1781977838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKe85BRj+aBlgJq8ZSqdTGlkuD86znOrDCE8X6u/nxw=;
  b=mJAxo6ok73j2R3Xgv5B5eSuOSsYLy8LhzoHaLmAjzSoEK09cFEPcjIDh
   2cErTsaAz2QLGga9nJPoOe/oeon8U+E1Hyyg6YFO9Uzmc2kmwuxtIhElP
   bIj5Vt9GXj0SHoDCSpff0V6KMxi3z35MR1ERNBxBi11yHokR6uHPA3pp4
   BaTSe65lH/AGhQyA/C6ExYUbCo2rCb2iOUT6BR2UYl3UAZcpUeZWb2nl/
   8A/ek30NC0o6cGLi9RNdwyOZp3BupidJPzc0jSYSelYj1Baqs6TRuC8Si
   QW1B59xn7BsKcn9tLT3VpD225BuH7oOEKOMGOgyp5sKbMeoXvJwh6cn/M
   Q==;
X-CSE-ConnectionGUID: oZ68axr0TMWzWhWDGIjKpQ==
X-CSE-MsgGUID: CGc0quVtSCuPUH/LZ/O/IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63762790"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="63762790"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 10:50:37 -0700
X-CSE-ConnectionGUID: XGr9QXHgQXqGBNEM48eESQ==
X-CSE-MsgGUID: RFygdJJKTECI+x0NaxvJzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="151187360"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 20 Jun 2025 10:50:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 17AAC109; Fri, 20 Jun 2025 20:50:21 +0300 (EEST)
Date: Fri, 20 Jun 2025 20:50:21 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCHv6 06/16] efi: Disable LASS around
 set_virtual_address_map() EFI call
Message-ID: <cwbzde3qvcvwfz2bgatxfkb2v6wbdvlvoulzvtlqe5mhxr5577@ghpqtyaupkeq>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-7-kirill.shutemov@linux.intel.com>
 <5bb6275b-5046-4bda-8c92-434e59cac08f@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bb6275b-5046-4bda-8c92-434e59cac08f@intel.com>

On Fri, Jun 20, 2025 at 08:55:29AM -0700, Dave Hansen wrote:
> On 6/20/25 06:53, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> > index 463b784499a8..94c335229697 100644
> > --- a/arch/x86/platform/efi/efi.c
> > +++ b/arch/x86/platform/efi/efi.c
> > @@ -825,11 +825,24 @@ static void __init __efi_enter_virtual_mode(void)
> >  
> >  	efi_sync_low_kernel_mappings();
> >  
> > +	/*
> > +	 * set_virtual_address_map is the only service located at lower
> > +	 * addresses, so we have to temporarily disable LASS around it.
> > +	 * Note that clearing EFLAGS.AC is not enough for this, the whole
> > +	 * LASS needs to be disabled.
> > +	 */
> > +	if (cpu_feature_enabled(X86_FEATURE_LASS))
> > +		cr4_clear_bits(X86_CR4_LASS);
> 
> Could we do it like this instead?
> 
> 	unsigned long lass = cr4_read_shadow() & X86_FEATURE_LASS;
> 	...
> 	cr4_clear_bits(lass);
> 
> >  	status = efi_set_virtual_address_map(efi.memmap.desc_size * count,
> >  					     efi.memmap.desc_size,
> >  					     efi.memmap.desc_version,
> >  					     (efi_memory_desc_t *)pa,
> >  					     efi_systab_phys);
> > +
> > +	if (cpu_feature_enabled(X86_FEATURE_LASS))
> > +		cr4_set_bits(X86_CR4_LASS);
> 
> and:
> 
> 	cr4_set_bits(lass);
> 
> >  	if (status != EFI_SUCCESS) {
> >  		pr_err("Unable to switch EFI into virtual mode (status=%lx)!\n",
> >  		       status);
> 
> That way, neither the presence of X86_FEATURE_LASS nor the ordering of
> setting up X86_CR4_LASS matters.
> 
> Let's say the CPU supports X86_FEATURE_LASS and this code gets called
> before the kernel is ready for LASS. It would break as written above.

Okay, will rework this.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

