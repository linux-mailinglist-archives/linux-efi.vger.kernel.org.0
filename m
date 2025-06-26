Return-Path: <linux-efi+bounces-4017-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A5FAE9F64
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 15:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251201897BB3
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 13:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4122E7189;
	Thu, 26 Jun 2025 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mwSmQ5JJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB02E1C7E;
	Thu, 26 Jun 2025 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945791; cv=none; b=LOODkFZk6Xd/4XyFtKZdXaZKHQ3pjINr8txGlTtMiSs0W0Qf920PSfdt9LWAhh8WPXKFxoJ/nbYJkms5G6H4TjnBRFQ5lkeUfpiugSWjFw/958tYdcotmLu5fnzyGV16VPx6cS9AY8HX8DCQmbdWbzudyBG8oBeKYFJXRI5hwvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945791; c=relaxed/simple;
	bh=kozox/jbM9GWIB06RT5vuS5Ewwi9VvJVmt22hiXXCr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpPG70LHRfGHy0IQi1scgZ4V+zDlE9mJgwA4u7cF3sENR0Wwz2oKrSwPsDUk7ssskyUErFAaFKa+jn6+F9OUwjjhqhoXozExiKWggouIB6Kf0zwPoy9gpxViS3kqa9eop+thTFxZ0XMWeDIixfZlThWfBbVH0F7/wXgr8StO9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mwSmQ5JJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DDjOhg3TDA3lAk/n8wJigYThpB4BiPBNqT914UwqWr4=; b=mwSmQ5JJj9GCM6h53p6V6Ly1Ur
	bR/FprIAMYt9ES7WjIwtXs4Fg2epbCSYV5xdWtLV2wmXsyyQGDS4gFn+lqX+bEw+lrzmuLBmv8hPv
	Phtec8rRMc2b31BMwiypEcQtCXFaB5SmQbpKIaZ7alD2OxxZXneU6FZOPY3ZVqc91pXRdtRm9NxZ3
	O2EDB3QNDHO7/8V/JTj2tgMuE7qLsLMd7+kdbu8ZFmRdXOM+WEYSm+0obArX6wiTtkcJr3CgXil9p
	oyLDhT3tYFfNOghkv3+1UD3dWyLAwUPBK4CNWgO9yggHIIjKofh6og8+FMbA0dd+SscVt8hGtWM1C
	kufkI7kQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmyf-0000000BkWF-368u;
	Thu, 26 Jun 2025 13:49:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4678430BDA9; Thu, 26 Jun 2025 15:49:21 +0200 (CEST)
Date: Thu, 26 Jun 2025 15:49:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv7 03/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20250626134921.GK1613200@noisy.programming.kicks-ass.net>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
 <20250625125112.3943745-5-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625125112.3943745-5-kirill.shutemov@linux.intel.com>

On Wed, Jun 25, 2025 at 03:50:56PM +0300, Kirill A. Shutemov wrote:

> +/*
> + * The CLAC/STAC instructions toggle the enforcement of X86_FEATURE_SMAP and
> + * X86_FEATURE_LASS.
> + *
> + * SMAP enforcement is based on the _PAGE_BIT_USER bit in the page tables: the
> + * kernel is not allowed to touch pages with the bit set unless the AC bit is
> + * set.
> + *
> + * LASS enforcement is based on bit 63 of the virtual address. The kernel is
> + * not allowed to touch memory in the lower half of the virtual address space
> + * unless the AC bit is set.
> + *
> + * Note: a barrier is implicit in alternative().
> + */
> +
>  static __always_inline void clac(void)
>  {
> -	/* Note: a barrier is implicit in alternative() */
>  	alternative("", "clac", X86_FEATURE_SMAP);
>  }
>  
>  static __always_inline void stac(void)
>  {
> -	/* Note: a barrier is implicit in alternative() */
>  	alternative("", "stac", X86_FEATURE_SMAP);
>  }
>  
> +static __always_inline void lass_enable_enforcement(void)
> +{
> +	alternative("", "clac", X86_FEATURE_LASS);
> +}
> +
> +static __always_inline void lass_disable_enforcement(void)
> +{
> +	alternative("", "stac", X86_FEATURE_LASS);
> +}

Much hate for this naming. WTH was wrong with lass_{clac,stac}()?

We're not calling those other functions smap_{en,dis}able_enforcement()
either (and please don't take that as a suggestion, its terrible
naming).

