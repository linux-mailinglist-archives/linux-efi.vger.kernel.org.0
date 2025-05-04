Return-Path: <linux-efi+bounces-3584-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE373AA86F1
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 16:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E451897210
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C6A1D63CF;
	Sun,  4 May 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1AVPPOf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123F156236;
	Sun,  4 May 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746369981; cv=none; b=uoj4wLaoQykRMOu4V15J4cSAQrcUTc+KuK/5obqaTD+indSqKQoeVx704T5LugvJ4TgzcfjytMqGk47+v8DH5m6XYd5ilTwgtmcv+WSyGWIYJ2JnaCxhafLoy53nc0HtEbdG4cYQdwFidPtluCso9r4hL/c4q2aD48yFRfVSWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746369981; c=relaxed/simple;
	bh=jZBlBNeG0/mHQ+QgGAH5vsgIrTir1T/Bnr1xuJJPAIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyDg+RiDnwP47P8u2elhdAYmfiHSpa+Vjndt7IwCOsSLyFxZNA7ah1K1CjSacza7Qxim4XDet/qjhwt0gtLXVeuIKoKp8huVL2YQx88v9yb1ya4tKEtikL1+5H/XLZwKeHRJsRNfXLWoJv9sb5PIJrBneBcwgSOe7iC44gBcjoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1AVPPOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2750C4AF09;
	Sun,  4 May 2025 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746369980;
	bh=jZBlBNeG0/mHQ+QgGAH5vsgIrTir1T/Bnr1xuJJPAIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G1AVPPOfUWeEgJ5G9RoIKMJoq6FbGTrMhZlqumhlPOsEZXEcQE5J6+tEXdWK6+HOR
	 Hth7N0hEth9qBuSIfp2Inw0KAgvtPUO8Racdh6GmGReMXtWoUy+gAjJQbN/AjywR38
	 Z+cc84vf6/T9u3ASfej5I9Zz/ZGA+MLgS6X/Wr9DfJcuwXDb8K7hFwShEhfZfdFozt
	 SuE4+z0K/DDUhycTi3tEZlDmw11HogQQhPTjBJSbfhUlUiouYFEr4Eb03aFLG4fgAv
	 eGGq/n5+7BzMtl8P8O+uyH0O9Qx/llf4W3ss9VwuTlPNyO7hE3IxiJ2HKBbz2hm+X7
	 XuySAxSCcRj9A==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-310447fe59aso37801871fa.0;
        Sun, 04 May 2025 07:46:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/+UXxeAr7ZNyM4oY6fKmoh/IG6cw6T9WRnp6UDWqITQwWJhipATgyphzsLklBxi9VS14FSCJBCck=@vger.kernel.org, AJvYcCXL6ud5d+94szIZuKpU3eGYC/jwGDRvT5g6GUfbU1nPZ7GBnSDva0N+f/31/JVsjK9n7jsckEMjTFux0wYI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu7fvPxI+Sg9BoBcCLeAUDFQ0UT7xuS540QG26lXG5C+JgX7Qx
	vaW//cSFfnTOuzuAPMwNSUZPmUNbKO65tMUtvqRvVkEZVOTKuKguyM6JpQgQ/3acTJcvhSrC5XD
	fdVCNB996o35pwj/7w/wu5X42N5M=
X-Google-Smtp-Source: AGHT+IFQ0GNGxYcTERl0iNqFl//nU6LLWvE0n+blf0OXml1HSUcgxBuJ1Mtk35jEnItW8z1qB6bvGZA/uQcmxvbtaUk=
X-Received: by 2002:a2e:a99d:0:b0:309:17:750d with SMTP id 38308e7fff4ca-32351f2329amr12382271fa.27.1746369978984;
 Sun, 04 May 2025 07:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-28-ardb+git@google.com> <aBdwwR52hI37bW9a@gmail.com>
In-Reply-To: <aBdwwR52hI37bW9a@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 4 May 2025 16:46:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFuJRsdWxL70S9Hisgye0dci7KOxrSzcLGnFFuUvjk2Mg@mail.gmail.com>
X-Gm-Features: ATxdqUGuABP17IzeYnONKtKuRFk9-f2xoFDLsWd2x74DapltIa_EZiNF28qLl38
Message-ID: <CAMj1kXFuJRsdWxL70S9Hisgye0dci7KOxrSzcLGnFFuUvjk2Mg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 03/23] x86/boot: Drop global variables keeping
 track of LA57 state
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 May 2025 at 15:51, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb+git@google.com> wrote:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > On x86_64, the core kernel is entered in long mode, which implies that
> > paging is enabled. This means that the CR4.LA57 control bit is
> > guaranteed to be in sync with the number of paging levels used by the
> > kernel, and there is no need to store this in a variable.
> >
> > There is also no need to use variables for storing the calculations of
> > pgdir_shift and ptrs_per_p4d, as they are easily determined on the fly.
> >
> > This removes the need for two different sources of truth (i.e., early
> > and late) for determining whether 5-level paging is in use: CR4.LA57
> > always reflects the actual state, and never changes from the point of
> > view of the 64-bit core kernel. It also removes the need for exposing
> > the associated variables to the startup code. The only potential concern
> > is the cost of CR4 accesses, which can be mitigated using alternatives
> > patching based on feature detection.
> >
> > Note that even the decompressor does not manipulate any page tables
> > before updating CR4.LA57, so it can also avoid the associated global
> > variables entirely. However, as it does not implement alternatives
> > patching, the associated ELF sections need to be discarded.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/misc.h         |  4 --
> >  arch/x86/boot/compressed/pgtable_64.c   | 12 ------
> >  arch/x86/boot/compressed/vmlinux.lds.S  |  1 +
> >  arch/x86/boot/startup/map_kernel.c      | 12 +-----
> >  arch/x86/boot/startup/sme.c             |  9 ----
> >  arch/x86/include/asm/pgtable_64_types.h | 43 ++++++++++----------
> >  arch/x86/kernel/cpu/common.c            |  2 -
> >  arch/x86/kernel/head64.c                | 11 -----
> >  arch/x86/mm/kasan_init_64.c             |  3 --
> >  9 files changed, 24 insertions(+), 73 deletions(-)
>
> So this patch breaks the build & creates header dependency hell on
> x86-64 allnoconfig:
>

Ugh

...
> Plus I'm not sure I'm happy about this kind of complexity getting
> embedded deep within low level MM primitives:
>
>   static __always_inline __pure bool pgtable_l5_enabled(void)
>   {
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
>   }
>
...
>
> Inlined approximately a gazillion times. (449 times on x86 defconfig.
> Yes, I just counted it.)
>
> And it's not even worth it, as it generates horrendous code:
>
>    154:   0f 20 e0                mov    %cr4,%rax
>    157:   0f ba e0 0c             bt     $0xc,%eax
>
> ... while CR4 access might be faster these days, it's certainly not as
> fast as simple percpu access. Plus it clobbers a register (RAX in the
> example above), which is unnecessary for a flag test.
>

It's an alternative, so this will be patched into stc or clc. But it
will still clobber a register.

> Cannot pgtable_l5_enabled() be a single, simple percpu flag or so?
>

We can just drop this patch, and I'll work around it by adding another
couple of SYM_PIC_ALIAS()es for these variables.

> And yes, this creates another layer for these values - but thus
> decouples low level MM from detection & implementation complexities,
> which is a plus ...
>

If you prefer to retain the early vs late distinction, where the late
one is more efficient, we could replace the early variant with the CR4
access. But frankly, if we go down that road, I'd prefer to just share
these early variables with the startup code.

