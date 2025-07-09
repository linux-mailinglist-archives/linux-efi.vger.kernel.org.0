Return-Path: <linux-efi+bounces-4257-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F02DAFEF3D
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 18:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB76188DDA8
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E261221FAE;
	Wed,  9 Jul 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYODEiH6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF86214813;
	Wed,  9 Jul 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080090; cv=none; b=tq3VKjJKHJGbNXRHqRs3YBMpv+CsFlMjtaJL5UX1W5evOHGvVeX6yqOFuOe9BCF1iWfHI5JR77uQHEpn79V2S/2z/h6LwML/hlplKbZPoEPB3Mk9LSrQEvVA9rZZFQZGeszfzsQcc0DyUogrqeJ48zAA+Ymf5PnyBLkox+v5zQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080090; c=relaxed/simple;
	bh=97R8r9026OTpHmRMs3mcRD8TZjTzsY16HJQDyChnBsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cijIX54RCDhwVRfy5ahTCdL0rD+Rhcf0Xlz+NZqyaFuDOo95UTGUhMekrAEHdRsmSplGb2fLkIT0M0YG9+WxFqrc8FzM0SQNWcvJ8+Bmr+cviYWzrUSBwzLz60BBDHdj34EzmO7LIJb6BjkNIdmpK8SF9U74C73HHle49iA7/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYODEiH6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752080088; x=1783616088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=97R8r9026OTpHmRMs3mcRD8TZjTzsY16HJQDyChnBsQ=;
  b=gYODEiH6+L74BX8qBkP8xKKou6gZziplEStzjchaIa+xxieyxGhL5IVH
   qEIBM4C/NIaC8P8aSmI+BxXUh5KEVk6KtrcGd6EE8YOS8tgZ5XxGSWcKf
   sSFqvE5KH6jKhKHzvlWDsy4odcaQTqUwmVO1ZWSu1lcgCZSECamKzqHuw
   VF7Rb+d05V4qBxIRpBPvHSdD/3nuQovhcqEBYBjC/QbbgJaYMKMnOi6+6
   VPSAb6qsE4fxoC7aKDYkLECepr0g7RxdBCcU2rgv6ZHr5Ngama2aEB5pI
   mmw5ffuhAC035KrBM451SDR3hBXsVs+lpcDWGzy9mfGwKywO8B8OeACG6
   A==;
X-CSE-ConnectionGUID: IIVV2AnHSV69xSQCCMAgRg==
X-CSE-MsgGUID: slXhI8hPQS+kdtzj3G6tug==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54480910"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54480910"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 09:54:46 -0700
X-CSE-ConnectionGUID: n2x1HyD+RR+vnGa7MyMZIg==
X-CSE-MsgGUID: MMUNuuqvSzSWvs6zURxmiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161485165"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.190]) ([10.125.110.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 09:54:45 -0700
Message-ID: <7d93b343-b275-4edb-ae26-4578ae53652f@intel.com>
Date: Wed, 9 Jul 2025 09:58:23 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 02/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
 Breno Leitao <leitao@debian.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>,
 Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>,
 Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>,
 Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
 Changbin Du <changbin.du@huawei.com>,
 Huang Shijie <shijie@os.amperecomputing.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-3-kirill.shutemov@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250707080317.3791624-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 01:03, Kirill A. Shutemov wrote:
> From: Sohil Mehta <sohil.mehta@intel.com>
> 
> For patching, the kernel initializes a temporary mm area in the lower
> half of the address range. See commit 4fc19708b165 ("x86/alternatives:
> Initialize temporary mm for patching").
> 
> Disable LASS enforcement during patching to avoid triggering a #GP
> fault.
> 
> The objtool warns due to a call to a non-allowed function that exists
> outside of the stac/clac guard, or references to any function with a
> dynamic function pointer inside the guard. See the Objtool warnings
> section #9 in the document tools/objtool/Documentation/objtool.txt.
> 
> Considering that patching is usually small, replace the memcpy() and
> memset() functions in the text poking functions with their open coded
> versions.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/smap.h   | 33 +++++++++++++++++++++++++++++++--
>  arch/x86/kernel/alternative.c | 28 ++++++++++++++++++++++++++--
>  2 files changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
> index 4f84d421d1cf..d0cc24348641 100644
> --- a/arch/x86/include/asm/smap.h
> +++ b/arch/x86/include/asm/smap.h
> @@ -23,18 +23,47 @@
>  
>  #else /* __ASSEMBLER__ */
>  
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
> + * Use stac()/clac() when accessing userspace (_PAGE_USER) mappings,
> + * regardless of location.
> + *
> + * Use lass_stac()/lass_clac() when accessing kernel mappings (!_PAGE_USER)
> + * in the lower half of the address space.
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
> +static __always_inline void lass_clac(void)
> +{
> +	alternative("", "clac", X86_FEATURE_LASS);
> +}
> +
> +static __always_inline void lass_stac(void)
> +{
> +	alternative("", "stac", X86_FEATURE_LASS);
> +}

Could we please move the comments about lass_*() closer to the LASS
functions?

>  static __always_inline unsigned long smap_save(void)
>  {
>  	unsigned long flags;
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index ea1d984166cd..992ece0e879a 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -2447,16 +2447,40 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
>  __ro_after_init struct mm_struct *text_poke_mm;
>  __ro_after_init unsigned long text_poke_mm_addr;
>  
> +/*
> + * Text poking creates and uses a mapping in the lower half of the
> + * address space. Relax LASS enforcement when accessing the poking
> + * address.
> + */
> +
>  static void text_poke_memcpy(void *dst, const void *src, size_t len)
>  {
> -	memcpy(dst, src, len);
> +	lass_stac();
> +
> +	/*
> +	 * Objtool is picky about what occurs within the STAC/CLAC region
> +	 * because this code runs with protection disabled. Objtool typically
> +	 * does not permit function calls in this area.
> +	 *
> +	 * Avoid using memcpy() here. Instead, open code it.
> +	 */
> +	asm volatile("rep movsb"
> +		     : "+D" (dst), "+S" (src), "+c" (len) : : "memory");
> +
> +	lass_clac();
>  }

This didn't turn out great. At the _very_ least, we could have a:

	inline_memcpy_i_really_mean_it()

with the rep mov. Or even a #define if we were super paranoid the
compiler is out to get us.

But _actually_ open-coding inline assembly is far too ugly to live.

We can also be a bit more compact about the comments:

	/*
	 * objtool enforces a strict policy of "no function calls within
	 * AC=1 regions". Adhere to the policy by doing a memcpy() that
	 * will never result in a function call.
	 */


