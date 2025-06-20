Return-Path: <linux-efi+bounces-3875-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6EEAE20A6
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 19:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F9C5A01C6
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093741E9915;
	Fri, 20 Jun 2025 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7ZLSe/Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509017BB21;
	Fri, 20 Jun 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750439951; cv=none; b=mM5kAG+hWZrhb/YvSXyuS9wfXPyHJKTOpsOnE0ncSYHhqQu5ycfnzWBzH1e1+rXyEoO4x+8PaRk1omXSBiIGDTsxjAMkflJHMfs+QVPMmQOxpZsGvilsqaEKvwk7tH1s59HAuX4NTtRtdXw8piI++LyWir6RE84/PzVdFiHdV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750439951; c=relaxed/simple;
	bh=dQDvIe8kEpS/KzWDhduzOi7rUZbsWr72XpJrQFUH1DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbGs+cSSOy6TU90uvjCN6EgWHUOhNKwNw3U3bKhVqFdJr8D0R2zAG+X7FponMViE4FPbtytM8GlMsNEeqgAcHAdGY18xBaKVRLPZV8uuicUXbZWaFKuNYCcbJlbmHyaCRj6jUuSshQn7Pl1EAi4IhTMcIKLyFrrL3IT7BhnqAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7ZLSe/Q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750439950; x=1781975950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQDvIe8kEpS/KzWDhduzOi7rUZbsWr72XpJrQFUH1DE=;
  b=O7ZLSe/QPtkgVEPG1YMJwOydAXB/ZmkO9VgyJCYqRFNGMAjrX99pdE+g
   a9hjWHj5T0usdc2SKf/zhbjZvH7fpEaFduNq06FJRtPFUZsDKm75R5djp
   MkwXCcPeZMHgoF9+o4JD7gxrx1eMz+ybKad1uW+lEXL+Km4k7U1WbSfmU
   9Vsw7LO1KljpPF8LugcKrEgZ4CTRaThdeWxiTE893L4PG+afEwEfWy97a
   cIyVH88YEIirsrEzGEdAqy5WgKnHZTmeKQhLJPhsRgWBhkOyvgx+BfuOP
   uW6N+y/YglmyhqcKb1jHXXygsnsjPk90Iz7NQURtiZRSuBcNKt1RQc3pm
   w==;
X-CSE-ConnectionGUID: d2nSgGS/T5aBGlCSgqVRXg==
X-CSE-MsgGUID: OAu7kV9sQYSb4+NLZO9DWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="64146989"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="64146989"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 10:19:09 -0700
X-CSE-ConnectionGUID: PEfm1VHzRRCCMeqjwOiyHg==
X-CSE-MsgGUID: bAJr5kusQtOHInOrgsg17A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="151179342"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 20 Jun 2025 10:18:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D0767109; Fri, 20 Jun 2025 20:18:56 +0300 (EEST)
Date: Fri, 20 Jun 2025 20:18:56 +0300
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
Subject: Re: [PATCHv6 03/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <kal5vsl6lpxo4ygli4yj2y5cqrosh2qxm5buxoh6d6ba4dloqe@nkxti3f7vrhj>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-4-kirill.shutemov@linux.intel.com>
 <15335559-bbb2-4da1-bbb9-878edf05437c@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15335559-bbb2-4da1-bbb9-878edf05437c@intel.com>

On Fri, Jun 20, 2025 at 08:33:57AM -0700, Dave Hansen wrote:
> On 6/20/25 06:53, Kirill A. Shutemov wrote:
> > +/*
> > + * poking_init() initializes the text poking address from the lower half of the
> > + * address space. Relax LASS enforcement when accessing the poking address.
> > + */
> 
> This does not read quite right. I think there's some unnecessary
> confusiuon about initializing the address versus the contents. But
> either way, how about:
> 
> /*
>  * Text poking creates and uses a mapping in the lower half of the
>  * address space. Relax LASS enforcement when accessing the poking
>  * address.
>  */

Looks good. Will update, thanks!
> 
> >  static void text_poke_memset(void *dst, const void *src, size_t len)
> >  {
> >  	int c = *(const int *)src;
> >  
> > -	memset(dst, c, len);
> > +	lass_stac();
> > +	__inline_memset(dst, c, len);
> > +	lass_clac();
> >  }
> 
> Yeah, this patch small enough that lass_{stac,clac}() are definitely
> misplaced in this series. Just move them into this patch.

Okay, makes sense.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

