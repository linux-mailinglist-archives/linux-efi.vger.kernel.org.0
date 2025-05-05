Return-Path: <linux-efi+bounces-3609-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AD9AAA58E
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 01:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62A85A0CA7
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 23:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7343118C6;
	Mon,  5 May 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXUM1PS5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994A3118C0;
	Mon,  5 May 2025 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484216; cv=none; b=r5ERj4SXH0svutTItE665B3YM+8gmmjej4ISTurGG6tePyvbIFvT15CjUf0kxg+ibjgYUkG+v4LJy25Lr4H04Kv7f1DxqzvtfM3NeMYREXPr7DMmS4Mw2l3BOBVHpQ8HsPlzGTMUxH1SrdNU9NHhJPtVkk0Wihmlg43ifkVpFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484216; c=relaxed/simple;
	bh=9qXvlUsAJLM2JuLUNLn+K6XTiEko4XoIWC3CCLaHQR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMlcbzy3LDpx4toZxFul2Sy/wOCJJI2NyzE4+ARisQ11LQU6KpjSOgp6yz0ul56Bzk/vVHcnVZZgxXuot0oAFfgEXw+fgenPFcBir252LMMKCKOoaAgu6uCs53yCPgYyh0xdITnBwHXVvOMwDrhJZN3VUDF8OkdbcTRpd5BEVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXUM1PS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E0DC4AF09;
	Mon,  5 May 2025 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484215;
	bh=9qXvlUsAJLM2JuLUNLn+K6XTiEko4XoIWC3CCLaHQR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aXUM1PS5HF9bG+EaAn2zvWZVWUBV2lf34iAan7GYQuTBFiqWTuB3VO+FbKCMwAFE0
	 P6q5KdfwEWfe4LJ5e0xzmKW3JEFSQnv7dl6zyURuBMA+HE7fQ9TuO9irLnM9Za5aIo
	 /HXPKFfzU1IXFEokU8SdCTiLVzrIq9Huv7tNP50Oqtc9BBrwOVfNbJ4FLaUuM26suw
	 qile430YgK30Z7/hys0FHdq69cUlE6iDPmcRqn6CyiPrFZo2iDiqLfySQCe43e+AkC
	 4l3eqOF9TLkSufod1REeVVDC9DLH+unvXFCQhrwKQc1c3/hP774jmnVv7zALvuLDQJ
	 U6+y45joO9QIQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54ea69e9352so5907195e87.2;
        Mon, 05 May 2025 15:30:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBZO0M6Mhn7eq6gWEWJPo02jbzS7HJHOWIhT8AjUNAn9svWQ/4TUJExFtdsl82lqJQzfaG+5FQsYBo5SL7@vger.kernel.org, AJvYcCXFRMh+7rcYVx/PDuqG/07i2QUbZgt4/NezdRy8DazYmB0B9GpuUedH2EqwJ3JRvLs99VreU7VQuag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNE9zxGv0IF62yy5OuFSo8tQsmDC9xOf77GYwgYjXMwx/q4WPr
	EBVoB1Nh4v/41LKc3/HyLZWVYXy+ehXHWLbtkTmyi0OOAcr8dQ5p83ix87MWg0/D3wk6gq5tjQb
	4NuxilIK5vqKlcfx5Fh6rAKOiGpM=
X-Google-Smtp-Source: AGHT+IHmUbL2/ov6H1GmIFr2hOfzScbIZJsVItptWBu8Dn7Q7ZYyumZH90rkmXsU/NbpevsPt590MOW4vMNYn/3zbm8=
X-Received: by 2002:a05:6512:4024:b0:545:2b68:936e with SMTP id
 2adb3069b0e04-54fb4a13ee1mr199593e87.25.1746484214124; Mon, 05 May 2025
 15:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-28-ardb+git@google.com> <aBdwwR52hI37bW9a@gmail.com>
 <CAHk-=wiaEzS_7CBVTz3RYnDt5zJus_GsPtfSjojkqiiMU-vSHQ@mail.gmail.com>
 <aBkogDfWB14qkY4g@gmail.com> <aBksqEEAq5t9UEmf@gmail.com>
In-Reply-To: <aBksqEEAq5t9UEmf@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 6 May 2025 00:30:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG4s8szNfyxksvOkyyCgpqH6Bm_eZ+4jvvLgQ78199Zeg@mail.gmail.com>
X-Gm-Features: ATxdqUFUodl0U9Cixemlu_wxaalpIlA0ppHs15tfYEWj9VqVVaEEGnYo3HJaN9g
Message-ID: <CAMj1kXG4s8szNfyxksvOkyyCgpqH6Bm_eZ+4jvvLgQ78199Zeg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 03/23] x86/boot: Drop global variables keeping
 track of LA57 state
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 23:25, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > Anyway, with these limitations in mind, we can see that the top 5
> > usecases cover about 80% of all uses:
> >
> >  - MAX_PHYSMEM_BITS: (inlined 179 times)
> >
> >        arch/x86/include/asm/sparsemem.h:# define MAX_PHYSMEM_BITS     (pgtable_l5_enabled() ? 52 : 46)
> >
> >    This could be implemented via a precomputed, constant percpu value
> >    (per_cpu__x86_MAX_PHYSMEM_BITS) of 52 vs. 46, eliminating not just
> >    the CR4 access, but also a branch, at the cost of a percpu memory
> >    access. (Which should still be a win on all microarchitectures IMO.)
> >
> >    Alternatively, since this value is a semi-constant of 52 vs. 46, we
> >    could also, I suspect, ALTERNATIVES-patch MAX_PHYSMEM_BITS in as an
> >    immediate constant value? Any reason this shouldn't work:
> >
> >      static inline unsigned int __MAX_PHYSMEM_BITS(void)
> >      {
> >               unsigned int bits;
> >
> >               asm_inline (ALTERNATIVE("movl $46, %0", "movl $52, %0", X86_FEATURE_LA57) :"=g" (bits));
> >
> >               return bits;
> >      }
> >      #define MAX_PHYSMEM_BITS __MAX_PHYSMEM_BITS()
> >
> >    ... or something like that? This would result in the best code
> >    generation IMO, by far. (It would even make use of the
> >    zero-extension property of a 32-bit MOVL, further compressing the
> >    opcode to only 5 bytes or so.)
> >
> >    We'd even create a secondary helper macro for this, something like:
> >
> >       #define ALTERNATIVES_CONST_U32(__val1, __val2, __feature)       \
> >       ({                                                              \
> >               u32 __val;                                              \
> >                                                                       \
> >               asm_inline (ALTERNATIVE("movl $" #__val1 ", %0", "movl $" __val2 ", %0", __feature) :"=g" (__val)); \
> >                                                                       \
> >               __val;                                                  \
> >       })
> >
> >       ...
> >
> >       #define MAX_PHYSMEM_BITS ALTERNATIVE_CONST_U32(46, 52, X86_FEATURE_LA57)
> >
> >    (Or so. Totally untested.)
>
> BTW., I keep comparing it to the CR4 access, which is a bit unfair,
> since that's only one out of the 3 variants of ALTERNATIVE_TERNARY():
>
> static __always_inline __pure bool pgtable_l5_enabled(void)
> {
>         unsigned long r;
>         bool ret;
>
>         if (!IS_ENABLED(CONFIG_X86_5LEVEL))
>                 return false;
>
>         asm(ALTERNATIVE_TERNARY(
>                  "movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
>                  %P[feat], "stc", "clc")
>                  : [reg] "=&r" (r), CC_OUT(c) (ret)
>                  : [feat] "i"  (X86_FEATURE_LA57),
>                    [la57] "i"  (X86_CR4_LA57_BIT)
>                  : "cc");
>
>         return ret;
> }
>
> The STC and CLC variants will probably be the more common outcomes on
> modern CPUs.
>

The CR4 access is only used before alternatives patching; after that,
either the STC or the CLC is patched in.

> But I still think the ALTERNATIVE_CONST_U32() approach I outline above
> generates superior code for the binary-values cases, which covers 3 out
> of the top 5 uses of pgtable_l5_enabled().
>
> For non-constant branching uses of pgtable_l5_enabled() I suspect the
> STC/CLC approach above is pretty good, although the 'cc' constraint
> will clobber all flags I suspect, while ALTERNATIVE_CONST_U32()
> doesn't? Ie. with ALTERNATIVE_CONST_U32() we just load the resulting
> constant into a register, with no additional branches and with flags
> undisturbed.
>
> Also, is STC/CLC always just as fast as the testing of an immediate (or
> a static branch), on CPUs we care about?
>

The reasoning behind using the C flag rather than asm goto is
precisely the fact that in many cases, pgtable_l5_enabled() is not
used for control flow but for picking between constants, and this
approach permits the compiler [in theory] to resolve it without a
branch. But I didn't inspect the resulting codegen, and just patching
in a MOV immediate is obviously more efficient than that.

I could just use asm goto here, and implement something similar to
cpu_feature_enabled(), but in a way that removes the need for
USE_EARLY_PGTABLE_L5. Then, we could get rid of the
__pgtable_l5_enabled variable in a separate patch, and base it on a
test of CR4.LA57 in the early init path.

Then, any optimizations related to constants defined in terms of
(pgtable_l5_enabled() ? foo : bar) could be layered on top of that.
Having runtime constants is the obvious choice, although I'm skeptical
whether it's worth the hassle. I also haven't yet looked into what it
would entail to share these runtime constants with the startup code.

