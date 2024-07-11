Return-Path: <linux-efi+bounces-1423-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F14D92E1BE
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 10:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D890D1F24689
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 08:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712B71514D1;
	Thu, 11 Jul 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e32/Jtfc"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975614A601;
	Thu, 11 Jul 2024 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685617; cv=none; b=GsYgCJtBtuTAlwUr/C8gCQ/Z5oXuj6Q+t3JdB/oeqvoOg4s57KGhqxjFwIQY24nbLnZU40sJ+5/fKId7MZMg+LXFckGtaSoV8mlp1Bg9gIN1GHVwpJegcCqf4y6MhSqWI6N6QdJ/QYJlKv0xECXpQExkNp8nweElzn3m9rT1ID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685617; c=relaxed/simple;
	bh=xsG4j8CUM95pevTZX83N2m0JtsePZz3hLlfpPlr4wKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efdy6vDwX88G5L2iQ2jxeAg9bDO7dpDRQt8aBPhcZPQXB52Od6ZnG4qaJFWQuVQr1Tgb/rIKfZ4nNTspXXLoS+k4s5MKBQ+pNsO8Vw0uH59CqP2/ELtNmT7rWtknZnO8BENv3bqrLrTChrFvGvvKD4aXrrYG5SskNl6LvymPWaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e32/Jtfc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=60rL9HOaet6vlUzwQrfSKu77VABHNI32SxBnaB3w5cU=; b=e32/JtfceHqCWcvBeGyYpWTATg
	D3/hTYRoWVcR1zO5HI67cewxepVSWuwZZ0k9hIXtNI4rSFVTN1WSZ+/wcuOx26UPaYRUo0F75uf0R
	D5A7ZoZGkbM9t+Qw06DJQiRBJuNntVye7JqYZl+GOQOsYz1dLKszDJGoAQweVHgv4X7Ag2xx0PXm/
	RBd9N7T174wp/Dfewj9LTvJntoj8f3TLfs6dsUXp1/+Qw5FngxuOFtugs24UxuucOEG8ucdoAYwll
	atQjPQivw1uy46YLS7b7yi75lU1zbymPYcMB1XoVT4qy6UitgV3wEwqtUZzXSVKJjyk5PmT2Dq2VW
	65RHdjcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRovW-0000000Ak7d-17YF;
	Thu, 11 Jul 2024 08:13:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DFA3830050D; Thu, 11 Jul 2024 10:13:17 +0200 (CEST)
Date: Thu, 11 Jul 2024 10:13:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
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
	Yian Chen <yian.chen@intel.com>,
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
Subject: Re: [PATCH v4 02/16] x86/asm: Introduce inline memcpy and memset
Message-ID: <20240711081317.GD4587@noisy.programming.kicks-ass.net>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
 <20240710160655.3402786-3-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710160655.3402786-3-alexander.shishkin@linux.intel.com>

On Wed, Jul 10, 2024 at 07:06:38PM +0300, Alexander Shishkin wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Provide inline memcpy and memset functions that can be used instead of
> the GCC builtins whenever necessary.
> 
> Code posted by Peter Zijlstra <peterz@infradead.org>.

We haz a tag for that:

Originally-by: Peter Zijlstra <peterz@infradead.org>

> Link: https://lore.kernel.org/lkml/Y759AJ%2F0N9fqwDED@hirez.programming.kicks-ass.net/
> [Missing Signed-off-by from PeterZ]

There, lemme fix that for you:

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  arch/x86/include/asm/string.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
> index c3c2c1914d65..9cb5aae7fba9 100644
> --- a/arch/x86/include/asm/string.h
> +++ b/arch/x86/include/asm/string.h
> @@ -1,6 +1,32 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_STRING_H
> +#define _ASM_X86_STRING_H
> +
>  #ifdef CONFIG_X86_32
>  # include <asm/string_32.h>
>  #else
>  # include <asm/string_64.h>
>  #endif
> +
> +static __always_inline void *__inline_memcpy(void *to, const void *from, size_t len)
> +{
> +	void *ret = to;
> +
> +	asm volatile("rep movsb"
> +		     : "+D" (to), "+S" (from), "+c" (len)
> +		     : : "memory");
> +	return ret;
> +}
> +
> +static __always_inline void *__inline_memset(void *s, int v, size_t n)
> +{
> +	void *ret = s;
> +
> +	asm volatile("rep stosb"
> +		     : "+D" (s), "+c" (n)
> +		     : "a" ((uint8_t)v)
> +		     : "memory");
> +	return ret;
> +}
> +
> +#endif /* _ASM_X86_STRING_H */
> -- 
> 2.43.0
> 

