Return-Path: <linux-efi+bounces-3605-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CF2AA9DD3
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 23:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAC517F763
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 21:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B9D270555;
	Mon,  5 May 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qb5+5oud"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1AE26E17A;
	Mon,  5 May 2025 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479238; cv=none; b=mIG9JfDWtDP8lKVjXT/JMeZjHmE+s3BuqzB4OAc6JsGcR1PYNJ7q4Y9FkyLkcmIPka62Hon2CzNiiGvW2L2hU0UBjDSdil3oD2bGCJMLsVFWZoqzcmIAvM9zHQGU/7lNPv2QyF5Uxj0S2mDrtV5EI4ep5os7/lwMhiTsqO4ImOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479238; c=relaxed/simple;
	bh=paZUH1RkAxo3mlKh1dT1EtleiAPkXZmYSJrq3gYlDwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTu7Xszxq0N1diiESGU281IGFJ7hPKPUu2+aNYbu+8rZFOcGmJbBTS2t8RjElcU6gQ2gsy2ii6tq9MsY6fvtmCZnd/OlaAehYSHSw2ovLiSQ4wjbf9j0WZp6+fLTMcTLo5ZGFk3m3aNKo41QRbGRzXPBqo6wEv+ftmN/5e0GHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qb5+5oud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B66C4CEE4;
	Mon,  5 May 2025 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746479237;
	bh=paZUH1RkAxo3mlKh1dT1EtleiAPkXZmYSJrq3gYlDwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qb5+5oudt4jmC5hUqZlj7ldv6fr5ekxmU3utpInWb2+qIB32eLv+1xFCREZsp8xN2
	 l2DR/B5vXtgYZQm2R2MMchtNVsAfBjPYZ0q2ZZvzy5sXfAiZ/XAJgIsFDTr2GAP9MI
	 BMfy2m4rh15vXNYkJ20oa2a5+3yFBvfngLyZk/fi8Z+ec3t8O9YziGjJy6o1yRZMh1
	 RouMpXUfEO+7/iw+xQ5eKP/3Lixj2mxb3z0XLC41h5oayYWZSQpi3qK6d0QW3T4VYg
	 wcDl6MWiMb1iC3XI8+MiFe8HlX/ilSA/4uq8TRqfji9zGWkrkBVWfvNsSjHEpKa+4E
	 ReAKVk3ajTbRQ==
Date: Mon, 5 May 2025 23:07:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v2 03/23] x86/boot: Drop global variables keeping
 track of LA57 state
Message-ID: <aBkogDfWB14qkY4g@gmail.com>
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-28-ardb+git@google.com>
 <aBdwwR52hI37bW9a@gmail.com>
 <CAHk-=wiaEzS_7CBVTz3RYnDt5zJus_GsPtfSjojkqiiMU-vSHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiaEzS_7CBVTz3RYnDt5zJus_GsPtfSjojkqiiMU-vSHQ@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Honestly, looking at this, I think we should fix the *users* of 
> pgtable_l5_enabled().

Agreed.

> Because I think there are two distinct classes:
> 
>  - the stuff in <asm/pgtable.h> is exposed as the generic page table
> accessor macros to "real" code, and should probably use a static key
> (ie things like pgd_clear() / pgd_none() and friends)
> 
>  - but in code like __kernel_physical_mapping_init() feels to me like
> using the value in %cr4 actually makes sense

So out of curiosity I measured where exactly pgtable_l5_enabled() is 
used - at least in terms of inlining frequency.

Here's the histogram of first-level pgtable_l5_enabled() inlining uses 
on x86-64-defconfig (there's over 600 of them):

      1  ffffffff844cde60  stat__pgtable_l5_enabled____p4d_free_tlb()
      1  ffffffff844cde64  stat__pgtable_l5_enabled__pgd_populate_safe()
      1  ffffffff844cde80  stat__pgtable_l5_enabled__native_set_p4d()
      1  ffffffff844cde84  stat__pgtable_l5_enabled__mm_p4d_folded()
      2  ffffffff844cde8c  stat__pgtable_l5_enabled__paravirt_pgd_clear()
      5  ffffffff844cde68  stat__pgtable_l5_enabled__pgd_populate()
     13  ffffffff844cde98  stat__pgtable_l5_enabled____VIRTUAL_MASK_SHIFT
     14  ffffffff844cde78  stat__pgtable_l5_enabled__pgd_present()
     16  ffffffff844cde70  stat__pgtable_l5_enabled__pgd_bad()
     16  ffffffff844cdea0  stat__pgtable_l5_enabled__other()
     20  ffffffff844cde88  stat__pgtable_l5_enabled__paravirt_set_pgd()
     29  ffffffff844cde5c  stat__pgtable_l5_enabled__VMALLOC_SIZE_TB
     46  ffffffff844cde7c  stat__pgtable_l5_enabled__PTRS_PER_P4D
     49  ffffffff844cde6c  stat__pgtable_l5_enabled__pgd_none()
     60  ffffffff844cde74  stat__pgtable_l5_enabled__p4d_offset()
    156  ffffffff844cde9c  stat__pgtable_l5_enabled__PGDIR_SHIFT
    179  ffffffff844cde94  stat__pgtable_l5_enabled__MAX_PHYSMEM_BITS
    ---
    609  TOTAL

Limitations:

  - 'Inlining frequency' is admittedly only an imperfect, statistical 
    proxy for 'importance'.

  - This metric doesn't properly discount boot-time-only use either, 
    although by a quick guesstimate it's less than 10% of all use: the 
    startup code uses pgtable_l5_enabled() only 13 times. (But there's 
    more boot-time use.)

Anyway, with these limitations in mind, we can see that the top 5 
usecases cover about 80% of all uses:

 - MAX_PHYSMEM_BITS: (inlined 179 times)

       arch/x86/include/asm/sparsemem.h:# define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)

   This could be implemented via a precomputed, constant percpu value 
   (per_cpu__x86_MAX_PHYSMEM_BITS) of 52 vs. 46, eliminating not just 
   the CR4 access, but also a branch, at the cost of a percpu memory 
   access. (Which should still be a win on all microarchitectures IMO.)

   Alternatively, since this value is a semi-constant of 52 vs. 46, we 
   could also, I suspect, ALTERNATIVES-patch MAX_PHYSMEM_BITS in as an 
   immediate constant value? Any reason this shouldn't work:

     static inline unsigned int __MAX_PHYSMEM_BITS(void)
     {
		unsigned int bits;

		asm_inline (ALTERNATIVE("movl $46, %0", "movl $52, %0", X86_FEATURE_LA57) :"=g" (bits));

		return bits;
     }
     #define MAX_PHYSMEM_BITS __MAX_PHYSMEM_BITS()

   ... or something like that? This would result in the best code 
   generation IMO, by far. (It would even make use of the 
   zero-extension property of a 32-bit MOVL, further compressing the 
   opcode to only 5 bytes or so.)

   We'd even create a secondary helper macro for this, something like:

	#define ALTERNATIVES_CONST_U32(__val1, __val2, __feature)	\
	({								\
		u32 __val;						\
									\
		asm_inline (ALTERNATIVE("movl $" #__val1 ", %0", "movl $" __val2 ", %0", __feature) :"=g" (__val)); \
									\
		__val;							\
	})

	...

	#define MAX_PHYSMEM_BITS ALTERNATIVE_CONST_U32(46, 52, X86_FEATURE_LA57)

   (Or so. Totally untested.)

 - PGDIR_SHIFT: (inlined 156 times)

	arch/x86/include/asm/pgtable_64_types.h:#define PGDIR_SHIFT	(pgtable_l5_enabled() ? 48 : 39)

   This too could be implemented via a precomputed constant percpu 
   value (per_cpu__x86_PGDIR_SHIFT), eliminating a branch as well, or 
   via an ALTERNATIVE() immediate operand constants.

 - p4d_offset(): (inlined 60 times)

	static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
	{
		if (!pgtable_l5_enabled())
			return (p4d_t *)pgd;
		return (p4d_t *)pgd_page_vaddr(*pgd) + p4d_index(address);
	}

   Here pgtable_l5_enabled() is used as a binary flag.

 - pgd_none(): (inlined 49 times)

	static inline int pgd_none(pgd_t pgd)
	{
		if (!pgtable_l5_enabled())
			return 0;
		return !native_pgd_val(pgd);
	}

   Binary flag use as well, although the compiler might eliminate the 
   branch here and replace it with 'AND !native_pgd_val(pgd)', because 
   native_pgd_val() is really simple. Or if the compiler doesn't do it, 
   we could code it up as a (hopefully) branch-less return of:

	static inline int pgd_none(pgd_t pgd)
	{
		return pgtable_l5_enabled() & !native_pgd_val(pgd);
	}

   (If I got the conversion right.)

 - PTRS_PER_P4D: (inlined 46 times)

	arch/x86/include/asm/pgtable_64_types.h:#define PTRS_PER_P4D		(pgtable_l5_enabled() ? 512 : 1)

   This too could be implemented via a precomputed constant percpu 
   value (per_cpu__x86_PTRS_PER_P4D), eliminating a branch,
   or via an ALTERNATIVE() immediate constant.

> but that looks like a much bigger and fundamental patch than Ard's.

Definitely. Using various derived percpu values will also complicate 
bootstrapping, with the usual complications of whether these values are 
entirely in sync with the chosen paging mode the kernel uses.

Anyway, I'm not against Ard's simplification patch as a first step, and 
any optimizations can be layered on top of that.

Thanks,

	Ingo

