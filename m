Return-Path: <linux-efi+bounces-4084-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B51AF114D
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 12:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6B61C21DCE
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBF023D2B8;
	Wed,  2 Jul 2025 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZncBnMp/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8923817F;
	Wed,  2 Jul 2025 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451034; cv=none; b=LJ2OAv7GKN1YRNfi7kVjVJ3bp0cmkc9Vde01k9iOZq+3pgL3d3ka3FWhzvsXvnZ7Y7CE5+zfH49f1txlipYBwm8GUFOuGg51rDuYG9MMwjvYFAbUvYYVBhEGZXMwwosjSC83IZnKHUCh82cgLMyWKEoKDZNDhYNI0XQj41HJz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451034; c=relaxed/simple;
	bh=wrSfWUeY1vWA1wmBzqUEGdZJDwhOB8JDwHQ2AQuAgYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLhSFCUsALu17dgm9e7TzhX5suvE/fiGDwYW9bpxwAsHZKenxWG9jzedWY779KL/YyeYOaxezwk0hzsxxywK7IJnxL4VrYwfnrOuM3n9Y4CCXmBskedWa1J4CVkIOG+de/Ab6VwDKcK5uYmAVJiTUkbTa3NyEvbGCZTNv6bVahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZncBnMp/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751451033; x=1782987033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wrSfWUeY1vWA1wmBzqUEGdZJDwhOB8JDwHQ2AQuAgYI=;
  b=ZncBnMp/I8fmaaC92EXovYInfoF8DW5YFSSoHX7tzezflQu73+u6Oyrg
   jDGJ+15QYTu4tHXUCHAKpRHlKEEkG/MPIPAnfUIDuKl1hsrH/4JxP7prm
   +DHr6bf6Nsour/v+Z8mTl90EzhDnE1OduSjo0bCwPFikcAau89gYeOwxM
   IfHATKjeifnYf07qAigh0BApmf/ACJZxV8KE/GX9MINTYpwkPZBVUJIXX
   yPqT+REn9+D+catR4qaO6GhAQnhRcIpV49oJCtZn4i4bEt6S2CSIDMt8Y
   FAOnAxvJzBxo5hKHbtPVKpN9XVm0JSDpTgKKd0k/BeBSbVFZifAhfbVkw
   A==;
X-CSE-ConnectionGUID: QH6eobyyTnqa/eWvltTzhw==
X-CSE-MsgGUID: 33LQLR+/Tv6M2KYqh+5UGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="41368725"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="41368725"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 03:10:32 -0700
X-CSE-ConnectionGUID: EoGc5nQdTs+SBUaD4Dt9UQ==
X-CSE-MsgGUID: Jt303iQRT22d+XS99ocr+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153490384"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 02 Jul 2025 03:10:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BEA181E0; Wed, 02 Jul 2025 13:10:18 +0300 (EEST)
Date: Wed, 2 Jul 2025 13:10:18 +0300
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
Subject: Re: [PATCHv8 12/17] x86/traps: Communicate a LASS violation in #GP
 message
Message-ID: <wuo2m6qyhdub2bw4lovdzyxygu4rsbsvsoronmmm4vmn4vvyba@bletrxfbct4c>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-13-kirill.shutemov@linux.intel.com>
 <63a44def-fd5d-4f21-8d09-bb608cfab524@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a44def-fd5d-4f21-8d09-bb608cfab524@intel.com>

On Tue, Jul 01, 2025 at 05:36:06PM -0700, Sohil Mehta wrote:
> On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
> >  /*
> > @@ -672,6 +681,12 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
> >  	if (*addr < ~__VIRTUAL_MASK &&
> >  	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
> >  		return GP_NON_CANONICAL;
> > +	else if (*addr < ~__VIRTUAL_MASK &&
> > +		 cpu_feature_enabled(X86_FEATURE_LASS)) {
> > +		if (*addr < PAGE_SIZE)
> > +			return GP_NULL_POINTER;
> > +		return GP_LASS_VIOLATION;
> > +	}
> 
> The comments above this section of code say:
> 
> /*
>  * Check that:
>  *  - the operand is not in the kernel half
>  *  - the last byte of the operand is not in the user canonical half
>  */
> 
> They should be updated since we are updating the logic.

Okay.

> Also, below is easier to read than above:
> 
> 	if (*addr < ~__VIRTUAL_MASK) {
> 
> 		if (*addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
> 			return EXC_NON_CANONICAL;
> 
> 		if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> 			if (*addr < PAGE_SIZE)
> 				return EXC_NULL_POINTER;
> 			return EXC_LASS_VIOLATION;
> 		}
> 	}
> 
> I am wondering if the NULL pointer exception should be made
> unconditional, even if it is unlikely to reach here without LASS. So
> maybe something like this:
> 
> 	if (*addr < ~__VIRTUAL_MASK) {
> 
> 		if (*addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
> 			return EXC_NON_CANONICAL;
> 
> 		if (*addr < PAGE_SIZE)
> 			return EXC_NULL_POINTER;
> 
> 		if (cpu_feature_enabled(X86_FEATURE_LASS))
> 			return EXC_LASS_VIOLATION;
> 	}

That's cleaner.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

