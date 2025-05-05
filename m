Return-Path: <linux-efi+bounces-3606-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694CAA9E19
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 23:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A597A3972
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 21:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9ED278E53;
	Mon,  5 May 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1hLaSqx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3B27817C;
	Mon,  5 May 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480302; cv=none; b=PernyxZitD9YmLdAHfOim05mPfklhjcvQHp11UAeUpRP87dS5QRYO9YorN6fQk+ISYzqLGfU+HgD4Xb4Fo7rUoU8nYFb7bTexaAjvKfAzh+Jmzw+LQs4LZAm/hdFO7RMqslqq1uyguDGB/iKWkJgnqZCI2KBh02bUyIcqS1KM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480302; c=relaxed/simple;
	bh=CPQHE12mgPtO62oLo32KO4asPur4JqmQCbNn/Z+Hd3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xve1mptzLXP4pza5+YYktNBPQqt3JoQkVa74C7oEOZDfNSb/hTeJE05symVT5xKsdzmjFKZLSWthVacdE+He+L4ttamKUOlH6Eh+LIQzlP1Ii7ZzWHNQNcuRR3RWDhPsqZQWj+PEukq9flh6xCWDURtss+lYYHpiKMeCFB+NH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1hLaSqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDB6C4CEE4;
	Mon,  5 May 2025 21:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746480301;
	bh=CPQHE12mgPtO62oLo32KO4asPur4JqmQCbNn/Z+Hd3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1hLaSqx8gq/26/IPhYeRtHUseRrDmJPdrpZQW1CgFo9Glwg8QaYOTxtl/AE7uhbZ
	 KiBRH8wB1XBspG5yd7CTkHHbiorcStnLPucV1+HxWgNZdWY5tOMdniuLg+20Fl8Nlz
	 feaeW1X8sbvFv2HCWjqJUjQQru/dPF5qpvYq0WaUwxtqEQg9uHV/PStMDqdT+CfIt/
	 Kr3JBHCrpoWURrZrMykJYMgSme5xGTw8nLh2ekySPV+nz55NCkv7wS1w3lovW3jdYm
	 oSW17XjB2IMWVKj1USwECt+0j843rpPzfVzpJyLHdIbYqnBS1g6oB0VpdxXcyEa/LE
	 EpiGpP334i3xA==
Date: Mon, 5 May 2025 23:24:56 +0200
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
Message-ID: <aBksqEEAq5t9UEmf@gmail.com>
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-28-ardb+git@google.com>
 <aBdwwR52hI37bW9a@gmail.com>
 <CAHk-=wiaEzS_7CBVTz3RYnDt5zJus_GsPtfSjojkqiiMU-vSHQ@mail.gmail.com>
 <aBkogDfWB14qkY4g@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBkogDfWB14qkY4g@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> Anyway, with these limitations in mind, we can see that the top 5 
> usecases cover about 80% of all uses:
> 
>  - MAX_PHYSMEM_BITS: (inlined 179 times)
> 
>        arch/x86/include/asm/sparsemem.h:# define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)
> 
>    This could be implemented via a precomputed, constant percpu value 
>    (per_cpu__x86_MAX_PHYSMEM_BITS) of 52 vs. 46, eliminating not just 
>    the CR4 access, but also a branch, at the cost of a percpu memory 
>    access. (Which should still be a win on all microarchitectures IMO.)
> 
>    Alternatively, since this value is a semi-constant of 52 vs. 46, we 
>    could also, I suspect, ALTERNATIVES-patch MAX_PHYSMEM_BITS in as an 
>    immediate constant value? Any reason this shouldn't work:
> 
>      static inline unsigned int __MAX_PHYSMEM_BITS(void)
>      {
> 		unsigned int bits;
> 
> 		asm_inline (ALTERNATIVE("movl $46, %0", "movl $52, %0", X86_FEATURE_LA57) :"=g" (bits));
> 
> 		return bits;
>      }
>      #define MAX_PHYSMEM_BITS __MAX_PHYSMEM_BITS()
> 
>    ... or something like that? This would result in the best code 
>    generation IMO, by far. (It would even make use of the 
>    zero-extension property of a 32-bit MOVL, further compressing the 
>    opcode to only 5 bytes or so.)
> 
>    We'd even create a secondary helper macro for this, something like:
> 
> 	#define ALTERNATIVES_CONST_U32(__val1, __val2, __feature)	\
> 	({								\
> 		u32 __val;						\
> 									\
> 		asm_inline (ALTERNATIVE("movl $" #__val1 ", %0", "movl $" __val2 ", %0", __feature) :"=g" (__val)); \
> 									\
> 		__val;							\
> 	})
> 
> 	...
> 
> 	#define MAX_PHYSMEM_BITS ALTERNATIVE_CONST_U32(46, 52, X86_FEATURE_LA57)
> 
>    (Or so. Totally untested.)

BTW., I keep comparing it to the CR4 access, which is a bit unfair, 
since that's only one out of the 3 variants of ALTERNATIVE_TERNARY():

static __always_inline __pure bool pgtable_l5_enabled(void)
{
        unsigned long r;
        bool ret;

        if (!IS_ENABLED(CONFIG_X86_5LEVEL))
                return false;

        asm(ALTERNATIVE_TERNARY(
                 "movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
                 %P[feat], "stc", "clc")
                 : [reg] "=&r" (r), CC_OUT(c) (ret)
                 : [feat] "i"  (X86_FEATURE_LA57),
                   [la57] "i"  (X86_CR4_LA57_BIT)
                 : "cc");

        return ret;
}

The STC and CLC variants will probably be the more common outcomes on 
modern CPUs.

But I still think the ALTERNATIVE_CONST_U32() approach I outline above 
generates superior code for the binary-values cases, which covers 3 out 
of the top 5 uses of pgtable_l5_enabled().

For non-constant branching uses of pgtable_l5_enabled() I suspect the 
STC/CLC approach above is pretty good, although the 'cc' constraint 
will clobber all flags I suspect, while ALTERNATIVE_CONST_U32() 
doesn't? Ie. with ALTERNATIVE_CONST_U32() we just load the resulting 
constant into a register, with no additional branches and with flags 
undisturbed.

Also, is STC/CLC always just as fast as the testing of an immediate (or 
a static branch), on CPUs we care about?

Thanks,

	Ingo

