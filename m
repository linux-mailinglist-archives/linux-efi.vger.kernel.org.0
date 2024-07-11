Return-Path: <linux-efi+bounces-1422-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6111092E1BA
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 10:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5CBDB23330
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE832156C69;
	Thu, 11 Jul 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ESjpgPYL"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B4150994;
	Thu, 11 Jul 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685543; cv=none; b=F4AcqgCRp9SDkTqlvsjWfTquuAT+FXlIlfQYlLfKJBcq97f0A82FPb7/nj8Ar5VsMfHVV8FSY8d/vwQp+tcUK2YPAAwV3BGEQLf12/fC4QkVvhS7yIRcyMM9D7suDKFksjK0IhhnRoSgpuYzmYpsbvkRFKA6+S8o8hxaOrzoIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685543; c=relaxed/simple;
	bh=1nT1IezppDSi24B0NzwviS1DRq7kWiD9jugdZ6hlJdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1Dz4hbOqv7MjpjiHDpKQgU54PcXYrjxnupGu4qJ0552gfMLW0VLKTYBfK4wZTPFhOJV6x+HcEcQfJiWPcU5gFt5CCfuG1m/C8snAUfTakWBqukKFHt2DTChbj3yQDy6P3Np/Q0/n2UUeFqVzsKCkFCAWWBgLBEDh46zvFJvS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ESjpgPYL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QgbGXn9FcDdYcZ5NyHNWtaAcV8SlcNpiqGwWfmhxx6I=; b=ESjpgPYLgh8JR5ParmeJx2srzX
	QIsjgvC3x/eYTU0bf6aHYbM0kMMHxnZD0wnhfW+ZCkWsc3aMY912EXd4SkaJiAPgECLo5T81SEn/Y
	pJdhSHNRkBh6OZXsxpj4cqXneinqeB/EmdA6UHZqgMQ+ADDceMHINTaT5me4JjU1Q9UTfkBodQXU1
	XiRarY2vhYKVWCXdj+ck5vK9yg+qfcRHAyQw8dMO40h7EHzw6cSNhz/OhKt/SK453366ZLMfEr8G2
	zq6hu2l3NsLoluEwhc8+kzsjyWuaCRDKw63A+ArA+Tt//1iLo8y78KNpwV35gZWsIpATWEwZGK3Av
	1oxth9Qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRou9-0000000Ait2-3IvY;
	Thu, 11 Jul 2024 08:11:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6CB4930050D; Thu, 11 Jul 2024 10:11:53 +0200 (CEST)
Date: Thu, 11 Jul 2024 10:11:53 +0200
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
Subject: Re: [PATCH v4 07/16] x86/cpu: Defer CR pinning setup until after EFI
 initialization
Message-ID: <20240711081153.GC4587@noisy.programming.kicks-ass.net>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
 <20240710160655.3402786-8-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710160655.3402786-8-alexander.shishkin@linux.intel.com>

On Wed, Jul 10, 2024 at 07:06:43PM +0300, Alexander Shishkin wrote:
> In order to map the EFI runtime services, set_virtual_address_map
> needs to be called, which resides in the lower half of the address
> space. This means that LASS needs to be temporarily disabled around
> this call. This can only be done before the CR pinning is set up.
> 
> Move CR pinning setup behind the EFI initialization.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

So the previous patch makes us not boot, and this fixes it up? Perhaps
order things differently?

> ---
>  arch/x86/kernel/cpu/common.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 8aa621dc7d30..c93c59a27dfa 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1948,7 +1948,6 @@ static __init void identify_boot_cpu(void)
>  	enable_sep_cpu();
>  #endif
>  	cpu_detect_tlb(&boot_cpu_data);
> -	setup_cr_pinning();
>  
>  	tsx_init();
>  	tdx_init();
> @@ -2367,10 +2366,16 @@ void __init arch_cpu_finalize_init(void)
>  
>  	/*
>  	 * This needs to follow the FPU initializtion, since EFI depends on it.
> +	 * It also needs to precede the CR pinning setup, because we need to be
> +	 * able to temporarily clear the CR4.LASS bit in order to execute the
> +	 * set_virtual_address_map call, which resides in lower addresses and
> +	 * would trip LASS if enabled.
>  	 */
>  	if (efi_enabled(EFI_RUNTIME_SERVICES))
>  		efi_enter_virtual_mode();
>  
> +	setup_cr_pinning();
> +
>  	/*
>  	 * Ensure that access to the per CPU representation has the initial
>  	 * boot CPU configuration.
> -- 
> 2.43.0
> 

