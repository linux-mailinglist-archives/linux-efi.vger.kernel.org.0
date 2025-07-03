Return-Path: <linux-efi+bounces-4099-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04379AF70B7
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 12:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED34526ACA
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D22E2EF7;
	Thu,  3 Jul 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVTiF0B0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38712E1744;
	Thu,  3 Jul 2025 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539215; cv=none; b=mRdj+YzPBUD5V7Ch+eRj2snZRT7XySkVfRqAdlFVifQPl7zeJ1IYEsdT4d81MTPKAo9beU73PiZss0yaTMtOIZozVvYKg+NiskvJMuubDYbxcNqzu3UILqldqN3wkMUJBPTbhibwtmU0JeP91qEO4jyBoYOzqfjgstp7HL3nW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539215; c=relaxed/simple;
	bh=/QFzSYlDk96wJWtvoJqxVFlqu43W4FEzZE0XzT6dz6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cO+RLyyxqLj4sCOpKxwe+iEQPdP2EtX0CYcDqNDSRm8Oe6uuuszd9UpkHGS4DhRf0A0PHcE/3+E2YhyMgzmGjgIGCjo06bkGbG5zaBB62Q4MXCuY0hWy/poTds0tqr8ObbH/BydqvYJUTBWxvVoksRFwBTs/3Gzgtq0tFGfRF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVTiF0B0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751539213; x=1783075213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/QFzSYlDk96wJWtvoJqxVFlqu43W4FEzZE0XzT6dz6U=;
  b=NVTiF0B0hub3F7sdYKImHEB621KKwD3vmIEBlBx2XzlfKqPlNzGa8T96
   lq6PDsDOF1j7FYfODEDpllHKtnrBFMhujWNbfI5F75FAqdcYFPxsTpcix
   OXO7UVpSX/wYFwh7pjQ88zX3K3eECWGPJXzOdHXDOVvR887bx2uq/uair
   hDfgv5KjB6ojVV37HQraCt+NxELic7q6MOuJhBGypEx9jsBxG5kSfBZd3
   gXDVh4a6AtDrD9ULIz1Uasfbfet6M0GFuZaZPPJwWTDlOgUbIT81os+r1
   uehla3edEFF107EEG9EMeD1BmQU7+ScGePj9oxtYw+DlRrj8Z4yOjiLr3
   Q==;
X-CSE-ConnectionGUID: 7nfcG5bIQ0qkcaNH3iuecA==
X-CSE-MsgGUID: MzHCH2PvRmq7YdQf6PKodQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="71296928"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="71296928"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 03:40:11 -0700
X-CSE-ConnectionGUID: JMsPgBN7SpybGEfPT/WDlA==
X-CSE-MsgGUID: SDEzVWdjTVKsq90XD7Ugbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="160030340"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 03 Jul 2025 03:39:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0D7D41FE; Thu, 03 Jul 2025 13:39:58 +0300 (EEST)
Date: Thu, 3 Jul 2025 13:39:57 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
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
Subject: Re: [PATCHv8 02/17] x86/asm: Introduce inline memcpy and memset
Message-ID: <uvvh6qfpan6f56fdvuch67nss2h5nqxbmocztf6v2lfbvnihbg@vtzbr6anzqnl>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
 <20250703094417.165e5893@pumpkin>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703094417.165e5893@pumpkin>

On Thu, Jul 03, 2025 at 09:44:17AM +0100, David Laight wrote:
> On Tue,  1 Jul 2025 12:58:31 +0300
> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > Extract memcpy and memset functions from copy_user_generic() and
> > __clear_user().
> > 
> > They can be used as inline memcpy and memset instead of the GCC builtins
> > whenever necessary. LASS requires them to handle text_poke.
> 
> Except they contain the fault handlers so aren't generic calls.

That's true. I will add a comment to clarify it.

> > Originally-by: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/all/20241029184840.GJ14555@noisy.programming.kicks-ass.net/
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/include/asm/string.h     | 46 +++++++++++++++++++++++++++++++
> >  arch/x86/include/asm/uaccess_64.h | 38 +++++++------------------
> >  arch/x86/lib/clear_page_64.S      | 13 +++++++--
> >  3 files changed, 67 insertions(+), 30 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
> > index c3c2c1914d65..17f6b5bfa8c1 100644
> > --- a/arch/x86/include/asm/string.h
> > +++ b/arch/x86/include/asm/string.h
> > @@ -1,6 +1,52 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_X86_STRING_H
> > +#define _ASM_X86_STRING_H
> > +
> > +#include <asm/asm.h>
> > +#include <asm/alternative.h>
> > +#include <asm/cpufeatures.h>
> > +
> >  #ifdef CONFIG_X86_32
> >  # include <asm/string_32.h>
> >  #else
> >  # include <asm/string_64.h>
> >  #endif
> > +
> > +#ifdef CONFIG_X86_64
> > +#define ALT_64(orig, alt, feat) ALTERNATIVE(orig, alt, feat)
> > +#else
> > +#define ALT_64(orig, alt, feat) orig "\n"
> > +#endif
> > +
> > +static __always_inline void *__inline_memcpy(void *to, const void *from, size_t len)
> > +{
> > +	void *ret = to;
> > +
> > +	asm volatile("1:\n\t"
> > +		     ALT_64("rep movsb",
> > +			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
> > +		     "2:\n\t"
> > +		     _ASM_EXTABLE_UA(1b, 2b)
> > +		     : "+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
> > +		     : : "memory", _ASM_AX);
> > +
> > +	return ret + len;
> > +}
> > +
> > +static __always_inline void *__inline_memset(void *addr, int v, size_t len)
> > +{
> > +	void *ret = addr;
> > +
> > +	asm volatile("1:\n\t"
> > +		     ALT_64("rep stosb",
> > +			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRM))
> > +		     "2:\n\t"
> > +		     _ASM_EXTABLE_UA(1b, 2b)
> > +		     : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
> > +		     : "a" ((uint8_t)v)
> 
> You shouldn't need the (uint8_t) cast (should that be (u8) anyway).
> At best it doesn't matter, at worst it will add code to mask with 0xff.

Right, will drop.

> > +		     : "memory", _ASM_SI, _ASM_DX);
> > +
> > +	return ret + len;
> > +}
> > +
> > +#endif /* _ASM_X86_STRING_H */
> > diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
> > index c8a5ae35c871..eb531e13e659 100644
> > --- a/arch/x86/include/asm/uaccess_64.h
> > +++ b/arch/x86/include/asm/uaccess_64.h
> > @@ -13,6 +13,7 @@
> >  #include <asm/page.h>
> >  #include <asm/percpu.h>
> >  #include <asm/runtime-const.h>
> > +#include <asm/string.h>
> >  
> >  /*
> >   * Virtual variable: there's no actual backing store for this,
> > @@ -118,21 +119,12 @@ rep_movs_alternative(void *to, const void *from, unsigned len);
> >  static __always_inline __must_check unsigned long
> >  copy_user_generic(void *to, const void *from, unsigned long len)
> >  {
> > +	void *ret;
> > +
> >  	stac();
> > -	/*
> > -	 * If CPU has FSRM feature, use 'rep movs'.
> > -	 * Otherwise, use rep_movs_alternative.
> > -	 */
> > -	asm volatile(
> > -		"1:\n\t"
> > -		ALTERNATIVE("rep movsb",
> > -			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
> > -		"2:\n"
> > -		_ASM_EXTABLE_UA(1b, 2b)
> > -		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
> > -		: : "memory", "rax");
> > +	ret = __inline_memcpy(to, from, len);
> >  	clac();
> > -	return len;
> > +	return ret - to;
> >  }
> >  
> >  static __always_inline __must_check unsigned long
> > @@ -178,25 +170,15 @@ rep_stos_alternative(void __user *addr, unsigned long len);
> >  
> >  static __always_inline __must_check unsigned long __clear_user(void __user *addr, unsigned long size)
> >  {
> > +	void *ptr = (__force void *)addr;
> > +	void *ret;
> > +
> >  	might_fault();
> >  	stac();
> > -
> > -	/*
> > -	 * No memory constraint because it doesn't change any memory gcc
> > -	 * knows about.
> > -	 */
> > -	asm volatile(
> > -		"1:\n\t"
> > -		ALTERNATIVE("rep stosb",
> > -			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRS))
> > -		"2:\n"
> > -	       _ASM_EXTABLE_UA(1b, 2b)
> > -	       : "+c" (size), "+D" (addr), ASM_CALL_CONSTRAINT
> > -	       : "a" (0));
> > -
> > +	ret = __inline_memset(ptr, 0, size);
> >  	clac();
> >  
> > -	return size;
> > +	return ret - ptr;
> >  }
> >  
> >  static __always_inline unsigned long clear_user(void __user *to, unsigned long n)
> > diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> > index a508e4a8c66a..47b613690f84 100644
> > --- a/arch/x86/lib/clear_page_64.S
> > +++ b/arch/x86/lib/clear_page_64.S
> > @@ -55,17 +55,26 @@ SYM_FUNC_END(clear_page_erms)
> >  EXPORT_SYMBOL_GPL(clear_page_erms)
> >  
> >  /*
> > - * Default clear user-space.
> > + * Default memset.
> >   * Input:
> >   * rdi destination
> > + * rsi scratch
> >   * rcx count
> > - * rax is zero
> > + * al is value
> >   *
> >   * Output:
> >   * rcx: uncleared bytes or 0 if successful.
> > + * rdx: clobbered
> >   */
> >  SYM_FUNC_START(rep_stos_alternative)
> >  	ANNOTATE_NOENDBR
> > +
> > +	movzbq %al, %rsi
> > +	movabs $0x0101010101010101, %rax
> > +
> > +	/* RDX:RAX = RAX * RSI */
> > +	mulq %rsi
> 
> NAK - you can't do that here.
> Neither %rsi nor %rdx can be trashed.
> The function has a very explicit calling convention.

What calling convention? We change the only caller to confirm to this.

> It is also almost certainly a waste of time.
> Pretty much all the calls will be for a constant 0x00.
> Rename it all memzero() ...

text_poke_memset() is not limited to zeroing.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

