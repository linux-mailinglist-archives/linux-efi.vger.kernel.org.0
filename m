Return-Path: <linux-efi+bounces-2044-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 483F39B4CAF
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 15:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08E01F244CF
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF061922F3;
	Tue, 29 Oct 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7B2vbVR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D10191F7C;
	Tue, 29 Oct 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213747; cv=none; b=IHcSWePKlWbFe/aEpxglTzplwu+UJcCqdR5uABZz6PsEN270vPG1XGvYebKiAHcZTUt8WHUuJo26B3KiTh+vO5DQFQjjMh9dlxWdwInFk+nrTwww0IVf+WVgOe92PtJ5AQya2TnkNRW29QMSmthKZ2wGojkJoBIJlmZICOOdNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213747; c=relaxed/simple;
	bh=WdYvE1SqTtHrxtZHlSGT1iWNLof5Om05bQ/10838U9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4VbhFvbEqo7RyiI2IgrA9hgd9JXyn91GdhzlkYlaASk0dPoQA1KotrJYzGqJ4+2zAVGRwgi+wTFZV3E+Tv50k9CmVol99f3sgm6x5rDTQubvOyOKwd+iaJCNMRwImEkI6EWg1zAG7nUzKEecbswiIcoW8ivmr2xJPnsvA3L3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7B2vbVR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730213745; x=1761749745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WdYvE1SqTtHrxtZHlSGT1iWNLof5Om05bQ/10838U9c=;
  b=J7B2vbVReMO1UnGDQWFdQL/E/4T7bx+EWnNbR39kzKxQgtxbJBne36Mt
   e5s6IU8Qdk52iml/sKae7VBTDjMyknSPh4Wvsbrsq2fx4V1Qxz9LkqMmb
   8GwGVwCPcjs2uA9vGTQ2nTV75x53o7T0YhuVrkHmTuJdOeHXkAiNct1MY
   aPsH0DfcF3sjP6wkqqzPT4UsFXsGUSU/g/h7xbwmO5ORzdxG43TFgCRl0
   rv6OKbF+yDaVY2VkdPLWMn2zxtriHOaqwr0TLO9fWOfMtzoryPFGPNorh
   yvT0FzRC4T1HlnxV9ROE5YehFzn+5JwhIqEo6E1U3TMeFBCuwc8LPUbjU
   A==;
X-CSE-ConnectionGUID: fjSiYo/CTUqiz8G4rIZ6uQ==
X-CSE-MsgGUID: bDF9gJO3Ss+dUYmWDMph+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29965934"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29965934"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:55:44 -0700
X-CSE-ConnectionGUID: /nzs7BMmTUm2zrheH/1phA==
X-CSE-MsgGUID: dLLYp1uvQv2vU9vhlH87LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82313138"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Oct 2024 07:55:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 599D326B; Tue, 29 Oct 2024 16:55:32 +0200 (EET)
Date: Tue, 29 Oct 2024 16:55:32 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
	Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>, 
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
	Yian Chen <yian.chen@intel.com>
Subject: Re: [PATCH v5 01/16] x86/cpu: Enumerate the LASS feature bits
Message-ID: <r2lprcqo2c7cpbgvnioi7kul3fwvskwjviupsugkdmiays7qwc@bnqamuzz3rjq>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-2-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028160917.1380714-2-alexander.shishkin@linux.intel.com>

On Mon, Oct 28, 2024 at 06:07:49PM +0200, Alexander Shishkin wrote:
> From: Sohil Mehta <sohil.mehta@intel.com>
> 
> Linear Address Space Separation (LASS) is a security feature that
> intends to prevent malicious virtual address space accesses across
> user/kernel mode.
> 
> Such mode based access protection already exists today with paging and
> features such as SMEP and SMAP. However, to enforce these protections,
> the processor must traverse the paging structures in memory.  Malicious
> software can use timing information resulting from this traversal to
> determine details about the paging structures, and these details may
> also be used to determine the layout of the kernel memory.
> 
> The LASS mechanism provides the same mode-based protections as paging
> but without traversing the paging structures. Because the protections
> enforced by LASS are applied before paging, software will not be able to
> derive paging-based timing information from the various caching
> structures such as the TLBs, mid-level caches, page walker, data caches,
> etc.
> 
> LASS enforcement relies on the typical kernel implementation to divide
> the 64-bit virtual address space into two halves:
>   Addr[63]=0 -> User address space
>   Addr[63]=1 -> Kernel address space
> 
> Any data access or code execution across address spaces typically
> results in a #GP fault.

SDM mentions #SS for LASS violations on stack instructions. Do we care to
provide a sensible error message on #SS as we do for #GP?

> The LASS enforcement for kernel data access is dependent on CR4.SMAP
> being set. The enforcement can be disabled by toggling the RFLAGS.AC bit
> similar to SMAP.
> 
> Define the CPU feature bits to enumerate this feature and include
> feature dependencies to reflect the same.
> 
> Co-developed-by: Yian Chen <yian.chen@intel.com>
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  arch/x86/include/asm/cpufeatures.h          |  1 +
>  arch/x86/include/asm/disabled-features.h    |  4 +++-
>  arch/x86/include/asm/smap.h                 | 18 ++++++++++++++++++
>  arch/x86/include/uapi/asm/processor-flags.h |  2 ++
>  arch/x86/kernel/cpu/cpuid-deps.c            |  1 +
>  tools/arch/x86/include/asm/cpufeatures.h    |  1 +
>  6 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index ea33439a5d00..acb3ccea2bd7 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -319,6 +319,7 @@
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions */
>  #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16 instructions */
> +#define X86_FEATURE_LASS		(12*32+ 6) /* "lass" Linear Address Space Separation */
>  #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* CMPccXADD instructions */
>  #define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* Intel Architectural PerfMon Extension */
>  #define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */
> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
> index c492bdc97b05..76c7d362af94 100644
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -22,12 +22,14 @@
>  # define DISABLE_CYRIX_ARR	(1<<(X86_FEATURE_CYRIX_ARR & 31))
>  # define DISABLE_CENTAUR_MCR	(1<<(X86_FEATURE_CENTAUR_MCR & 31))
>  # define DISABLE_PCID		0
> +# define DISABLE_LASS		0
>  #else
>  # define DISABLE_VME		0
>  # define DISABLE_K6_MTRR	0
>  # define DISABLE_CYRIX_ARR	0
>  # define DISABLE_CENTAUR_MCR	0
>  # define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
> +# define DISABLE_LASS		(1<<(X86_FEATURE_LASS & 31))
>  #endif /* CONFIG_X86_64 */
>  
>  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> @@ -146,7 +148,7 @@
>  #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
>  			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
>  #define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
> -#define DISABLED_MASK13	0
> +#define DISABLED_MASK13	(DISABLE_LASS)
>  #define DISABLED_MASK14	0
>  #define DISABLED_MASK15	0
>  #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
> diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
> index bab490379c65..8cb6f004800b 100644
> --- a/arch/x86/include/asm/smap.h
> +++ b/arch/x86/include/asm/smap.h
> @@ -27,6 +27,12 @@
>  
>  #else /* __ASSEMBLY__ */
>  
> +/*
> + * The CLAC/STAC instructions toggle enforcement of X86_FEATURE_SMAP.
> + * Add dedicated lass_*() variants for cases that are necessitated by
> + * LASS (X86_FEATURE_LASS) enforcement, which helps readability and
> + * avoids AC flag flipping on CPUs that don't support LASS.
> + */

Maybe add a new line here? The comment is for the group of helpers, not
for clac() specifically.

>  static __always_inline void clac(void)
>  {
>  	/* Note: a barrier is implicit in alternative() */
> @@ -39,6 +45,18 @@ static __always_inline void stac(void)
>  	alternative("", __ASM_STAC, X86_FEATURE_SMAP);
>  }
>  
> +static __always_inline void lass_clac(void)
> +{
> +	/* Note: a barrier is implicit in alternative() */
> +	alternative("", __ASM_CLAC, X86_FEATURE_LASS);
> +}
> +
> +static __always_inline void lass_stac(void)
> +{
> +	/* Note: a barrier is implicit in alternative() */
> +	alternative("", __ASM_STAC, X86_FEATURE_LASS);
> +}
> +
>  static __always_inline unsigned long smap_save(void)
>  {
>  	unsigned long flags;
> diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
> index f1a4adc78272..81d0c8bf1137 100644
> --- a/arch/x86/include/uapi/asm/processor-flags.h
> +++ b/arch/x86/include/uapi/asm/processor-flags.h
> @@ -136,6 +136,8 @@
>  #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
>  #define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technology */
>  #define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
> +#define X86_CR4_LASS_BIT	27 /* enable Linear Address Space Separation support */
> +#define X86_CR4_LASS		_BITUL(X86_CR4_LASS_BIT)
>  #define X86_CR4_LAM_SUP_BIT	28 /* LAM for supervisor pointers */
>  #define X86_CR4_LAM_SUP		_BITUL(X86_CR4_LAM_SUP_BIT)
>  
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index 8bd84114c2d9..3f73c4b03348 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -83,6 +83,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>  	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
>  	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
>  	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
> +	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
>  	{}
>  };
>  
> diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
> index 23698d0f4bb4..538930159f9f 100644
> --- a/tools/arch/x86/include/asm/cpufeatures.h
> +++ b/tools/arch/x86/include/asm/cpufeatures.h
> @@ -319,6 +319,7 @@
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions */
>  #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16 instructions */
> +#define X86_FEATURE_LASS		(12*32+ 6) /* "lass" Linear Address Space Separation */
>  #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* CMPccXADD instructions */
>  #define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* Intel Architectural PerfMon Extension */
>  #define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */
> -- 
> 2.45.2
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

