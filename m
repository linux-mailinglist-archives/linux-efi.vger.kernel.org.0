Return-Path: <linux-efi+bounces-2043-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FE29B486B
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 12:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5020B21AD7
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 11:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45C204F82;
	Tue, 29 Oct 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dr2Wko62"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1002F20492E;
	Tue, 29 Oct 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201813; cv=none; b=Xd6axhvahhrC7wTXILeh+IDwqTc7cbd2KYrpDAQaRhIP+OI0bkyl8Bx7wpkgAxmZAQbvDYUxJeILt56QCTzInvhcoS0J3H3FWDptlI7oQAlt7W284mGu06L5m5YaohHpB0I8ghVKUepSMMGlsIBps1a4IsOQ4ShnixBfeAUT/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201813; c=relaxed/simple;
	bh=e5S/YKnH9NHvSS0aTqimfEThPXu31EgHVlB//jnSb+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAEechlrZZ1Wde5vL2l4O7QH/HTps2sbD8XEtdJmFxi/XnTAo8sRstOv2eCq0NVUr/T6Iw25KLe7nhNtGaA2eQqMjJMBBVLaSD0iZb9zAEA2hSQ7eGbHpZR1XawO7uek4zDRRHDwr0K5rQUx6rrAEUd97an1Gx2wRzUwhT73Jvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dr2Wko62; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mRSboDDzGxAiy3/RWSIRW202wiGtlrHhBve+K+RhU38=; b=dr2Wko62gJxMTrK00ekmXTouum
	fRryKzE23eZi7WLE5eGQk6PCAaQrrcRHJX9k1jouVRU0cHMV1MvhLFb98RCc9g9TNqUmYNKecxYBQ
	uFIXCzATCX7D6+8YtDPtNJn8dHac5jrImCWIHVY3ECwJbPSx3CgB6kX3QNRc3nmHn+0l9xdb7Np8/
	So0Nd2tjsSxVGVngTeSH1eZDkTiJVB5mgaQyoPUgWotA/0/MicKUle+uM5uxXXbyhguTWVxoB8jnq
	aJNWDyAKr70EhEqdHM8BKT+/w+EoP0XF8/mH1cbPn5HFNO3OZclS8Y3guTbtx53/BanZR4/gGhGgO
	FfRhsjhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5kWC-00000009t4y-0VcF;
	Tue, 29 Oct 2024 11:36:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BD8B630073F; Tue, 29 Oct 2024 12:36:11 +0100 (CET)
Date: Tue, 29 Oct 2024 12:36:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 03/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20241029113611.GS14555@noisy.programming.kicks-ass.net>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-4-alexander.shishkin@linux.intel.com>
 <7897bc3e-2d68-4aef-8668-f6eb9f8efd7f@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7897bc3e-2d68-4aef-8668-f6eb9f8efd7f@intel.com>

On Mon, Oct 28, 2024 at 10:49:07AM -0700, Dave Hansen wrote:
> On 10/28/24 09:07, Alexander Shishkin wrote:
> >  static void text_poke_memcpy(void *dst, const void *src, size_t len)
> >  {
> > -	memcpy(dst, src, len);
> > +	lass_stac();
> > +	__inline_memcpy(dst, src, len);
> > +	lass_clac();
> >  }
> >  
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
> These are the _only_ users of lass_stac/clac() or the new inlines.

For now; I have vague memories of running into trouble with compilers
doing random things with memcpy before, and having these inline versions
gives us more control.

One of the cases I remember running into was KASAN, where a compiler is
SUPPOSED to issue __asan_memcpy calls instead of the regular memcpy
calls, except they weren't all doing that, with the end result that our
regular memcpy implementation grew instrumentation to deal with that.

That got sorted -- by deprecating / breaking all those non-conformant
compilers. But still, I think it would be good to have the option to
force a simple inline memcpy when needed.

> First of all, I totally agree that the _existing_ strict objtool
> behavior around STAC/CLAC is a good idea.
> 
> But text poking really is special and the context is highly unlikely to
> result in bugs or exploits.  My first instinct here would have been to
> tell objtool that the text poking code is OK and to relax objtool's
> STAC/CLAC paranoia here.
> 
> Looking at objtool, I can see how important it is to keep the STAC/CLAC
> code as dirt simple and foolproof as possible.  I don't see an obvious
> way to except the text poking code without adding at least some complexity.
> 
> Basically what I'm asking for is if the goal is to keep objtool simple,
> please *SAY* that.  Because on the surface this doesn't look like a good
> idea.

There is, you can add it to uaccess_safe_builtin[], but I'm not sure we
want to blanked accept memcpy() -- or perhaps that is what you're
saying.

Anyway, looking at this, I see we grew rep_{movs,stos}_alternative, as
used in copy_user_generic() and __clear_user(). Which are all somewhat
similar.

