Return-Path: <linux-efi+bounces-4104-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66007AF76C1
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DEF166B74
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21309139CE3;
	Thu,  3 Jul 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXnTn2Rp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB91A83F5;
	Thu,  3 Jul 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551851; cv=none; b=uB3q16pg8xyxwPHKtboXfvT1l3eXC1jK8nWyGOhkNnBWiL6opBRaQogZaZVW+kJVgQTNrgZHZL7rjcWbrLTMTVZ6hGTYc/NuCNNpUAIFL63e3tmNPE8LEU/o8+VWMRpcjwc8shDQ0RUPY1hAa0ClAAW3bTXqGNzHnor6jHkLOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551851; c=relaxed/simple;
	bh=UKZDj7Dr6U+nDPNDBDqz64P+s+8aLK1xb7gK+2NOHNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyma+jkbwlBgfgnFMmJQ2Jf9F+oOWb+dDvsyFYJYNu2VGFR4Mlcs8TSPBWqYotxaoJlb3xfDYFzt18GZKJ3k0jn3YJXpZBTd13xwCGwZer4CzVFm3PwHEhuG+6H5dmDxGpvzQJ8s5wRYIOj9g1KMrKKH6PS+1MN8n3w0Ysi2d9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXnTn2Rp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751551850; x=1783087850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UKZDj7Dr6U+nDPNDBDqz64P+s+8aLK1xb7gK+2NOHNc=;
  b=WXnTn2Rp1odHVNR1+bHMBR2HDYk36F5VDu8Lz8da1C8F72G2W0uUS1SI
   5WJYLEjDQ7UGWBSukX9ZjJXTsKFGhSowtj1RahNqI3A+epWnUMHWD8g6L
   08UsCAUXNxODJycr99c+IGfQr6kNGajqmmYbPH5/ZaywhaRts6qhM4l9L
   6qmmLunoqVsyfWLISgPlFo0seSZYmC+KDbxyvCH0wkY1Jbm6PVq2NQ+68
   hhjlbyHl1YyUb5dkwy+s+ts1PBDWlUbZWaaapJCqXSaMD/OuUg5d0mcZh
   dLx5fo+YemLctLWrJ8s/Q/Nj8BuJFaL3AvGMy7jgCR5n/9So3sda1EwfE
   A==;
X-CSE-ConnectionGUID: vQCElQioQTGBjshUdzuMvA==
X-CSE-MsgGUID: +8GcKvKaQnqz0VvcM4UmcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65333999"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="65333999"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:10:49 -0700
X-CSE-ConnectionGUID: n/f2VhrpRXW5ix8BRRZ06g==
X-CSE-MsgGUID: tjOT0cYYRgu2z73konZ4hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="153792238"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 03 Jul 2025 07:10:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E997D1E0; Thu, 03 Jul 2025 17:10:34 +0300 (EEST)
Date: Thu, 3 Jul 2025 17:10:34 +0300
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
Message-ID: <uoysignw2pmdls5v57z4cty76hhz7fv7ikcih2qgeltbgnem4f@jt2r24bqvzau>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
 <20250703094417.165e5893@pumpkin>
 <uvvh6qfpan6f56fdvuch67nss2h5nqxbmocztf6v2lfbvnihbg@vtzbr6anzqnl>
 <20250703131552.32adf6b8@pumpkin>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703131552.32adf6b8@pumpkin>

On Thu, Jul 03, 2025 at 01:15:52PM +0100, David Laight wrote:
> On Thu, 3 Jul 2025 13:39:57 +0300
> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > On Thu, Jul 03, 2025 at 09:44:17AM +0100, David Laight wrote:
> > > On Tue,  1 Jul 2025 12:58:31 +0300
> > > "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> > >   
> > > > Extract memcpy and memset functions from copy_user_generic() and
> > > > __clear_user().
> > > > 
> > > > They can be used as inline memcpy and memset instead of the GCC builtins
> > > > whenever necessary. LASS requires them to handle text_poke.  
> > > 
> > > Except they contain the fault handlers so aren't generic calls.  
> > 
> > That's true. I will add a comment to clarify it.
> 
> They need renaming.

__inline_memcpy/memset_safe()?

> ...
> > > > diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> > > > index a508e4a8c66a..47b613690f84 100644
> > > > --- a/arch/x86/lib/clear_page_64.S
> > > > +++ b/arch/x86/lib/clear_page_64.S
> > > > @@ -55,17 +55,26 @@ SYM_FUNC_END(clear_page_erms)
> > > >  EXPORT_SYMBOL_GPL(clear_page_erms)
> > > >  
> > > >  /*
> > > > - * Default clear user-space.
> > > > + * Default memset.
> > > >   * Input:
> > > >   * rdi destination
> > > > + * rsi scratch
> > > >   * rcx count
> > > > - * rax is zero
> > > > + * al is value
> > > >   *
> > > >   * Output:
> > > >   * rcx: uncleared bytes or 0 if successful.
> > > > + * rdx: clobbered
> > > >   */
> > > >  SYM_FUNC_START(rep_stos_alternative)
> > > >  	ANNOTATE_NOENDBR
> > > > +
> > > > +	movzbq %al, %rsi
> > > > +	movabs $0x0101010101010101, %rax
> > > > +
> > > > +	/* RDX:RAX = RAX * RSI */
> > > > +	mulq %rsi  
> > > 
> > > NAK - you can't do that here.
> > > Neither %rsi nor %rdx can be trashed.
> > > The function has a very explicit calling convention.  
> > 
> > What calling convention? We change the only caller to confirm to this.
> 
> The one that is implicit in:
> 
> > > > +	asm volatile("1:\n\t"
> > > > +		     ALT_64("rep stosb",
> > > > +			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRM))
> > > > +		     "2:\n\t"
> > > > +		     _ASM_EXTABLE_UA(1b, 2b)
> > > > +		     : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
> > > > +		     : "a" ((uint8_t)v)
> 
> The called function is only allowed to change the registers that
> 'rep stosb' uses - except it can access (but not change)
> all of %rax - not just %al.
> 
> See: https://godbolt.org/z/3fnrT3x9r
> In particular note that 'do_mset' must not change %rax.
> 
> This is very specific and is done so that the compiler can use
> all the registers.

Okay, I see what you are saying.

> > > It is also almost certainly a waste of time.
> > > Pretty much all the calls will be for a constant 0x00.
> > > Rename it all memzero() ...  
> > 
> > text_poke_memset() is not limited to zeroing.
> 
> But you don't want the overhead of extending the constant
> on all the calls - never mind reserving %rdx to do it.
> Maybe define a function that requires the caller to have
> done the 'dirty work' - so any code that wants memzero()
> just passes zero.
> Or do the multiply in the C code where it will get optimised
> away for constant zero.
> You do get the multiply for the 'rep stosb' case - but that
> is always going to be true unless you complicate things further.  

The patch below seems to do the trick: compiler optimizes out the
multiplication for v == 0.

It would be nice to avoid it for X86_FEATURE_FSRM, but we cannot use
cpu_feature_enabled() here as <asm/cpufeature.h> depends on
<asm/string.h>.

I cannot say I like the result.

Any suggestions?

diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
index becb9ee3bc8a..c7644a6f426b 100644
--- a/arch/x86/include/asm/string.h
+++ b/arch/x86/include/asm/string.h
@@ -35,16 +35,27 @@ static __always_inline void *__inline_memcpy(void *to, const void *from, size_t
 
 static __always_inline void *__inline_memset(void *addr, int v, size_t len)
 {
+	unsigned long val = v;
 	void *ret = addr;
 
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		/*
+		 * Fill all bytes by value in byte 0.
+		 *
+		 * To be used in rep_stos_alternative()i
+		 */
+		val &= 0xff;
+		val *= 0x0101010101010101;
+	}
+
 	asm volatile("1:\n\t"
 		     ALT_64("rep stosb",
 			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRM))
 		     "2:\n\t"
 		     _ASM_EXTABLE_UA(1b, 2b)
 		     : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
-		     : "a" (v)
-		     : "memory", _ASM_SI, _ASM_DX);
+		     : "a" (val)
+		     : "memory");
 
 	return ret + len;
 }
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 47b613690f84..3ef7d796deb3 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -58,23 +58,15 @@ EXPORT_SYMBOL_GPL(clear_page_erms)
  * Default memset.
  * Input:
  * rdi destination
- * rsi scratch
  * rcx count
  * al is value
  *
  * Output:
  * rcx: uncleared bytes or 0 if successful.
- * rdx: clobbered
  */
 SYM_FUNC_START(rep_stos_alternative)
 	ANNOTATE_NOENDBR
 
-	movzbq %al, %rsi
-	movabs $0x0101010101010101, %rax
-
-	/* RDX:RAX = RAX * RSI */
-	mulq %rsi
-
 	cmpq $64,%rcx
 	jae .Lunrolled
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

