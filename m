Return-Path: <linux-efi+bounces-4098-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EA8AF6D45
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 10:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5F23A3E79
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA5D2D23B0;
	Thu,  3 Jul 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSLHzwX0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2EF2DE6E8;
	Thu,  3 Jul 2025 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532277; cv=none; b=Hp/V2vlLF88zYaS81Ubamtlezoy0C5OjjqQnaKKMhw5+bDkywIJ05pEh/nK646UUWf4fRTPeOEoRzuSshNt5A4ArEu3U00nn/6ln21+/91bFi3mBHt7sRQNUgEgMOvdaLCFn/qSeE/GATd7wLRIoJXjVsLWB8GzGP/tZEoS3fFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532277; c=relaxed/simple;
	bh=t1v1BAiPC1HqbbaE77FhyukVMmCQJb9YdgC5sR0nzEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNyvm7K9MG4LyuuUUhFBMtCTZ/BYvqkkx1mDml3nbKaSSZ14qI7nLtksgZ2jcu6Wr8ITu35AofOOkVdd+fY1cAcsuSyD/GR7X6Z3cwQfR/chy4DslqbAFgBkg2xppGfXHkLdfdT0ik1lEcZ/anx9F1bd91AS4bMAjeWbS+eEJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSLHzwX0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so4813186f8f.2;
        Thu, 03 Jul 2025 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751532274; x=1752137074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFX/TAx6epCpcEo12wFWGJBoxHilKkIQzdhXF7nb3aU=;
        b=hSLHzwX0mwsU0IUdvvEZDFOAm2nMhzahgMagW2KjxRYU6W+YTraVHBxKGC6grelySF
         WRCAnJwG2N+k1KbfrXDt+8De/TEPTnPbE2laeFS7e5G3WHIDsTawRAYOaPTWQuTcM7BT
         RqNHReRW6lQWzSmVE9Bhcff14xjVUzrDCiTHzVT76eE8zUXZfPeGpIDhiw5x4KQXxPPc
         UQlFE2NxGN8guynuJYo0irraAoY62mlO+6EimJLPKvaDhbeZAMugw9T6Q4JzuDCTVE+5
         YO8DJEUdM+zBrTM2wM6Xv1/uBN+I03HmWAKMp1ROHt0+wxKaRfgJ5hdDfVHOtfrU8mpS
         Hfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751532274; x=1752137074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFX/TAx6epCpcEo12wFWGJBoxHilKkIQzdhXF7nb3aU=;
        b=QfbGctelrM5YFGvU/JF6bMvRm1uiaqrFi68E0aQ+bUhwNsfmpZNkuMMryI+HPesSpP
         vrn6eaoKM+OI3aKt70pmo4RrvRom2hQ1XJghlu0ghUd+Oo8SEbGRhIOq8xzA+8V3LCfx
         2USY0Dv7+nNEjDT4zKxEbaJLihAyNbnlKKWPj4ZmllAdQaiXJpRzpaWbTdV6YGB3bf57
         Tz/Fpk8+SGZNX3xk2kOSFYFd8/+VWEOuLtvpqHdDRNqUxerEesmZc8omFhGfN5AgrAVS
         hmQ2KdoVk9TcLS3XXyHwj/qT0XyUpZJOezkd3z1WhNlNIbMQEM2WYh+XDCD9klDr3x3Y
         211Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrMzZqgzkWGytgQUQ0LRf64rr1hsFR3I+OZag/IGc4/AWBCY+PGAHHNFx44CwjPxJaGN4pkc9whfOZF/hs@vger.kernel.org, AJvYcCWxxnX5cdES5UDTRo55I7r7NbR9IzDylWZQfzhHn6gNgFhGCNDwqXb1ayCjQR2YDQ2Xz1jw3gJHGAJ1@vger.kernel.org, AJvYcCXI94kZcU+SQPJRHDH/0ehjahwDQNxrDGdzNrYpKrK0C3UxmGtPvLDIy6ye/J9nPsw0AK1KvOzNlLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/uhj+xmA+WbNT7GUarrv+zXaMIZD6eAxRcenszJikEZ27pjV9
	xefm3IvyzbMpiRLLkkpS36NeXaPnaDS1P+HZpg/0ax93xgQC7ZRh+dUY
X-Gm-Gg: ASbGncv37NYQ5gCdjLP53eO9Nf4CL3VX9oNSFCCfyugc4cmskZk2jWF/UVfKf6bsaAw
	9UmH7eh7piFsg20MmWy6eW026tphPmL9FF8Sos5fzKcvG7shqSoNUlHnxtVwZyJl7SqLXp6nC1n
	IHCMbDB/+J8TR0EHkFPtlntoqiUXO8FSF9wf4Tn9SrvIVzKBow7ILVHtLbdi3PcMe/dYYCB2lG0
	97ZjR++HGpuBxrxChsmfHvCRrRdHbfYe7GUchYT7SHVoDS4LcPP83pLaesTdzB5lf2CR8wW25a7
	ObpZk6D0/T7xXMMymuTmuO/N7JdY0sl1WWXfNS0orDuh2pvMok5cZEXnBVG1BWR50spyS00lQiV
	OUbGkiBH0B+/yo6KM9Q==
X-Google-Smtp-Source: AGHT+IGpJYcIiVB0V7dfxLr4hl+2St0WzP4p5xUbwUL9Q9cruWACk5HaqKiw36ESWFjGbUj0Mh/Z+w==
X-Received: by 2002:a05:6000:26c4:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3b32fb30d66mr1813139f8f.49.1751532274119;
        Thu, 03 Jul 2025 01:44:34 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7386sm17869936f8f.20.2025.07.03.01.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 01:44:33 -0700 (PDT)
Date: Thu, 3 Jul 2025 09:44:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
 <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
 <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
 <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
 <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar
 <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Daniel
 Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross
 <jgross@suse.com>, Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook
 <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, Huang
 Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Namhyung Kim <namhyung@kernel.org>, Arnaldo
 Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv8 02/17] x86/asm: Introduce inline memcpy and memset
Message-ID: <20250703094417.165e5893@pumpkin>
In-Reply-To: <20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
	<20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Jul 2025 12:58:31 +0300
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> Extract memcpy and memset functions from copy_user_generic() and
> __clear_user().
> 
> They can be used as inline memcpy and memset instead of the GCC builtins
> whenever necessary. LASS requires them to handle text_poke.

Except they contain the fault handlers so aren't generic calls.

> 
> Originally-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/all/20241029184840.GJ14555@noisy.programming.kicks-ass.net/
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/string.h     | 46 +++++++++++++++++++++++++++++++
>  arch/x86/include/asm/uaccess_64.h | 38 +++++++------------------
>  arch/x86/lib/clear_page_64.S      | 13 +++++++--
>  3 files changed, 67 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
> index c3c2c1914d65..17f6b5bfa8c1 100644
> --- a/arch/x86/include/asm/string.h
> +++ b/arch/x86/include/asm/string.h
> @@ -1,6 +1,52 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_STRING_H
> +#define _ASM_X86_STRING_H
> +
> +#include <asm/asm.h>
> +#include <asm/alternative.h>
> +#include <asm/cpufeatures.h>
> +
>  #ifdef CONFIG_X86_32
>  # include <asm/string_32.h>
>  #else
>  # include <asm/string_64.h>
>  #endif
> +
> +#ifdef CONFIG_X86_64
> +#define ALT_64(orig, alt, feat) ALTERNATIVE(orig, alt, feat)
> +#else
> +#define ALT_64(orig, alt, feat) orig "\n"
> +#endif
> +
> +static __always_inline void *__inline_memcpy(void *to, const void *from, size_t len)
> +{
> +	void *ret = to;
> +
> +	asm volatile("1:\n\t"
> +		     ALT_64("rep movsb",
> +			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
> +		     "2:\n\t"
> +		     _ASM_EXTABLE_UA(1b, 2b)
> +		     : "+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
> +		     : : "memory", _ASM_AX);
> +
> +	return ret + len;
> +}
> +
> +static __always_inline void *__inline_memset(void *addr, int v, size_t len)
> +{
> +	void *ret = addr;
> +
> +	asm volatile("1:\n\t"
> +		     ALT_64("rep stosb",
> +			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRM))
> +		     "2:\n\t"
> +		     _ASM_EXTABLE_UA(1b, 2b)
> +		     : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
> +		     : "a" ((uint8_t)v)

You shouldn't need the (uint8_t) cast (should that be (u8) anyway).
At best it doesn't matter, at worst it will add code to mask with 0xff.

> +		     : "memory", _ASM_SI, _ASM_DX);
> +
> +	return ret + len;
> +}
> +
> +#endif /* _ASM_X86_STRING_H */
> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
> index c8a5ae35c871..eb531e13e659 100644
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -13,6 +13,7 @@
>  #include <asm/page.h>
>  #include <asm/percpu.h>
>  #include <asm/runtime-const.h>
> +#include <asm/string.h>
>  
>  /*
>   * Virtual variable: there's no actual backing store for this,
> @@ -118,21 +119,12 @@ rep_movs_alternative(void *to, const void *from, unsigned len);
>  static __always_inline __must_check unsigned long
>  copy_user_generic(void *to, const void *from, unsigned long len)
>  {
> +	void *ret;
> +
>  	stac();
> -	/*
> -	 * If CPU has FSRM feature, use 'rep movs'.
> -	 * Otherwise, use rep_movs_alternative.
> -	 */
> -	asm volatile(
> -		"1:\n\t"
> -		ALTERNATIVE("rep movsb",
> -			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
> -		"2:\n"
> -		_ASM_EXTABLE_UA(1b, 2b)
> -		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
> -		: : "memory", "rax");
> +	ret = __inline_memcpy(to, from, len);
>  	clac();
> -	return len;
> +	return ret - to;
>  }
>  
>  static __always_inline __must_check unsigned long
> @@ -178,25 +170,15 @@ rep_stos_alternative(void __user *addr, unsigned long len);
>  
>  static __always_inline __must_check unsigned long __clear_user(void __user *addr, unsigned long size)
>  {
> +	void *ptr = (__force void *)addr;
> +	void *ret;
> +
>  	might_fault();
>  	stac();
> -
> -	/*
> -	 * No memory constraint because it doesn't change any memory gcc
> -	 * knows about.
> -	 */
> -	asm volatile(
> -		"1:\n\t"
> -		ALTERNATIVE("rep stosb",
> -			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRS))
> -		"2:\n"
> -	       _ASM_EXTABLE_UA(1b, 2b)
> -	       : "+c" (size), "+D" (addr), ASM_CALL_CONSTRAINT
> -	       : "a" (0));
> -
> +	ret = __inline_memset(ptr, 0, size);
>  	clac();
>  
> -	return size;
> +	return ret - ptr;
>  }
>  
>  static __always_inline unsigned long clear_user(void __user *to, unsigned long n)
> diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> index a508e4a8c66a..47b613690f84 100644
> --- a/arch/x86/lib/clear_page_64.S
> +++ b/arch/x86/lib/clear_page_64.S
> @@ -55,17 +55,26 @@ SYM_FUNC_END(clear_page_erms)
>  EXPORT_SYMBOL_GPL(clear_page_erms)
>  
>  /*
> - * Default clear user-space.
> + * Default memset.
>   * Input:
>   * rdi destination
> + * rsi scratch
>   * rcx count
> - * rax is zero
> + * al is value
>   *
>   * Output:
>   * rcx: uncleared bytes or 0 if successful.
> + * rdx: clobbered
>   */
>  SYM_FUNC_START(rep_stos_alternative)
>  	ANNOTATE_NOENDBR
> +
> +	movzbq %al, %rsi
> +	movabs $0x0101010101010101, %rax
> +
> +	/* RDX:RAX = RAX * RSI */
> +	mulq %rsi

NAK - you can't do that here.
Neither %rsi nor %rdx can be trashed.
The function has a very explicit calling convention.

It is also almost certainly a waste of time.
Pretty much all the calls will be for a constant 0x00.
Rename it all memzero() ...

	David

> +
>  	cmpq $64,%rcx
>  	jae .Lunrolled
>  


