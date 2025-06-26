Return-Path: <linux-efi+bounces-4024-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2300EAEA4D7
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 20:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59523173B3E
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA7B1F2BB8;
	Thu, 26 Jun 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XiizrTWD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32C13AA2F;
	Thu, 26 Jun 2025 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750960900; cv=none; b=R9htN7AC9kgcJVVLG/shbpuv77/kxiJyqpmyTmcQfTUPwHHmT8E2udqVJgv7DYhuB+viPF3eQa+gtxaoeEQn3xRXsJUE+xQ28+QMVVfNjq6OOCYG6JDg73mwaSLyTBDWnBMx4IPNmeFqDvvFdDrfAoV3UqINERoB/A4kkHdyCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750960900; c=relaxed/simple;
	bh=Q0SPWURKXx7gOP1rrTmcfjwMLHQDVLmTDZ6OttgXmcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhW2YTxiwPe6LAKkpuXX7BZUg4dzdNiq9slSrGMWiD3B3m0ZZynx63RAarL0/DRez89NVGw1K/IANWjAHDHStin+Mobdb0XxEhe3OUNRBEEOv3wKKQHXK4ug1TMfr0WdSUK2oJMxA8HDAG5VkeHQJZUDVdXNfKgOPH+acGBKG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=XiizrTWD; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55QI0OAg2308531
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 26 Jun 2025 11:00:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55QI0OAg2308531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750960828;
	bh=xIN9TxfX2EeOHS5mr8WN+HlwktJEOt8XnXSFhuBm71s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XiizrTWDBdMse7CSwHFWmuB1C6NNxvXY0PZR7r6jhkHu8JXgygNJBigUDDxTYWBKP
	 MRRs4iHKgZRYmDLYf06KaJOoPXdRrKM8EFzKQjdDX8FVkyhvmnZPub/uLQDVOHLGwC
	 fusmjTHIpxPgul2+mBnJ2wCmNlNiXlBmd6TnxA6s499MuboVgOeaJgL+x6jrC0uoaO
	 Q+nnjd/7q0WJi4iXbH7kbI1pHhLiuANkDsLJfUzxeT3oeaPYPQoE5Zp6JgpCEQrDj5
	 SbhiIX7brAelU8bIlZA7XvyOIg4NhUSOotYVCZjWjRyQSxWi17B5X6PfHk7ZTrq102
	 /mImN9XFucKzA==
Message-ID: <af700e33-5c73-40aa-96a3-91cd8bf64871@zytor.com>
Date: Thu, 26 Jun 2025 11:00:24 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 01/16] x86/cpu: Enumerate the LASS feature bits
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
        Breno Leitao <leitao@debian.org>,
        Rick Edgecombe
 <rick.p.edgecombe@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
        Juergen Gross <jgross@suse.com>,
        Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>,
        Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
 <20250625125112.3943745-2-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250625125112.3943745-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/2025 5:50 AM, Kirill A. Shutemov wrote:
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
>    Addr[63]=0 -> User address space
>    Addr[63]=1 -> Kernel address space
> 
> Any data access or code execution across address spaces typically
> results in a #GP fault.
> 
> The LASS enforcement for kernel data access is dependent on CR4.SMAP
> being set. The enforcement can be disabled by toggling the RFLAGS.AC bit
> similar to SMAP.
> 
> Define the CPU feature bits to enumerate this feature and include
> feature dependencies to reflect the same.
> 
> LASS provides protection against a class of speculative attacks, such as
> SLAM[1]. Add the "lass" flag to /proc/cpuinfo to indicate that the feature
> is supported by hardware and enabled by the kernel. This allows userspace
> to determine if the setup is secure against such attacks.
> 
> [1] https://download.vusec.net/papers/slam_sp24.pdf
> 
> Co-developed-by: Yian Chen <yian.chen@intel.com>
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/Kconfig.cpufeatures                | 4 ++++
>   arch/x86/include/asm/cpufeatures.h          | 1 +
>   arch/x86/include/uapi/asm/processor-flags.h | 2 ++
>   arch/x86/kernel/cpu/cpuid-deps.c            | 1 +
>   tools/arch/x86/include/asm/cpufeatures.h    | 1 +
>   5 files changed, 9 insertions(+)
> 
> diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
> index 250c10627ab3..733d5aff2456 100644
> --- a/arch/x86/Kconfig.cpufeatures
> +++ b/arch/x86/Kconfig.cpufeatures
> @@ -124,6 +124,10 @@ config X86_DISABLED_FEATURE_PCID
>   	def_bool y
>   	depends on !X86_64
>   
> +config X86_DISABLED_FEATURE_LASS
> +	def_bool y
> +	depends on X86_32
> +
>   config X86_DISABLED_FEATURE_PKU
>   	def_bool y
>   	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index b78af55aa22e..8eef1ad7aca2 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -313,6 +313,7 @@
>   #define X86_FEATURE_SM4			(12*32+ 2) /* SM4 instructions */
>   #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions */
>   #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16 instructions */
> +#define X86_FEATURE_LASS		(12*32+ 6) /* "lass" Linear Address Space Separation */
>   #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* CMPccXADD instructions */
>   #define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* Intel Architectural PerfMon Extension */
>   #define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */
> diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
> index f1a4adc78272..81d0c8bf1137 100644
> --- a/arch/x86/include/uapi/asm/processor-flags.h
> +++ b/arch/x86/include/uapi/asm/processor-flags.h
> @@ -136,6 +136,8 @@
>   #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
>   #define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technology */
>   #define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
> +#define X86_CR4_LASS_BIT	27 /* enable Linear Address Space Separation support */
> +#define X86_CR4_LASS		_BITUL(X86_CR4_LASS_BIT)
>   #define X86_CR4_LAM_SUP_BIT	28 /* LAM for supervisor pointers */
>   #define X86_CR4_LAM_SUP		_BITUL(X86_CR4_LAM_SUP_BIT)
>   
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index 46efcbd6afa4..98d0cdd82574 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -89,6 +89,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>   	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
>   	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
>   	{ X86_FEATURE_SPEC_CTRL_SSBD,		X86_FEATURE_SPEC_CTRL },
> +	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
>   	{}
>   };
>   
> diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
> index ee176236c2be..4473a6f7800b 100644
> --- a/tools/arch/x86/include/asm/cpufeatures.h
> +++ b/tools/arch/x86/include/asm/cpufeatures.h
> @@ -313,6 +313,7 @@
>   #define X86_FEATURE_SM4			(12*32+ 2) /* SM4 instructions */
>   #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions */
>   #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16 instructions */
> +#define X86_FEATURE_LASS		(12*32+ 6) /* "lass" Linear Address Space Separation */
>   #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* CMPccXADD instructions */
>   #define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* Intel Architectural PerfMon Extension */
>   #define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */

Reviewed-by: Xin Li (Intel) <xin@zytor.com>

