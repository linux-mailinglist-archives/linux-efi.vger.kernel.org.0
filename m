Return-Path: <linux-efi+bounces-3713-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79EDAB894D
	for <lists+linux-efi@lfdr.de>; Thu, 15 May 2025 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5896A7B57F6
	for <lists+linux-efi@lfdr.de>; Thu, 15 May 2025 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307A419B5B1;
	Thu, 15 May 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2YAUcfb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F117B4EC;
	Thu, 15 May 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318950; cv=none; b=joM8RxkegyhMCueLHGyzHNzN0WtM/qPClssQjuR9VRawmvxkYH6BWajcq8fbudzuM9o0AS6PqvQ7S8friYjzQH8eLxOuuuqdNJffRycgPCZM4fLScTTA8kAHiTZHJz0UGfjJT6POZffoG5ZzVgHemAZZ8mGOkQALVxzgevIhw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318950; c=relaxed/simple;
	bh=1EvE9OCT8E5lKaCBelG2B3aHzesGzPxE0dyR0c+6G8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJ4LQPkx5nMWLsu5cJu4wn8oTPgRR2ictyoqoyd0CUIoiEVvBwDWmjFQlGgeGmBUp0heIGI2H2KlvTAUbl0GPYJSashgsygEX4UhciPgmR8sCx173DO6BGctjZGSS6apDn5rE27/v81w726d1Qu81qgP8iJvBaiIe2L/ywYg2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2YAUcfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8F9C4AF0B;
	Thu, 15 May 2025 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747318949;
	bh=1EvE9OCT8E5lKaCBelG2B3aHzesGzPxE0dyR0c+6G8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B2YAUcfbYZyp2Tjf0INenGzALuYbjnsSWkNybo1ET3lF5cfKU0sS3/fkC3ehneaeB
	 hBPBcNj+NUeFhmSuVYkQFbaZQI0Xo3UjB0N+Dgtb90ex2PqVZoPppyikcAz/eYtRAA
	 4SnEXpXssqOiLUniCGRdRD7/meDX2ABhsSmtC3MseoBemmldx0ry8Ws5EyJaOUvHZu
	 GX20j/Q42URBnJW+9LcxBANAnBDUtV9y6IjFDOIQ6QBJrq/orhh84DxLQKaPPW7jzj
	 dEANybJkQ/i9555roEVwyWDnPRkwUgGJSOqkfh/iElex4T7urHaDCNJTa/pwoGVL+s
	 j+bg9WdkOEU1A==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3104ddb8051so10866341fa.1;
        Thu, 15 May 2025 07:22:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU04sACW5kmgLs4NWQy01VOVvpvRIHW+ljLZXLgdxHGhbxNglpdTzz/hh1sReJfmmUQAE4izlhf4XnpsFt2@vger.kernel.org, AJvYcCVV2UdDKzBCSCpMJW5s2HASqU3qcu3qAx4fFrxEDFy1yiucTTXHyLyFfCr8xfTg8HJD0llw81CkRH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw47rIz4evG0VUFc/jGWKjuymxC4ruV1yzr0FsnmSDORdw0h8V/
	duFd0qSlH19CDasI7jGFXoP/gFE2eWk0FGYJjJhrqEzbW8ZDercONmEMMzUAdNBnTIQYmVsSMYJ
	3aRl/dM1c/H5+AmG12KTIHaxb1pI=
X-Google-Smtp-Source: AGHT+IEQUD4iN3LyOBcAAFU5TbPVzv65op3g5tPxcj0hmyEQvpFt0vwHfSf980AAeB81OQl80rUez6szs1q+xt2je2U=
X-Received: by 2002:a2e:a9a6:0:b0:30b:bba5:ac18 with SMTP id
 38308e7fff4ca-327ed088399mr32723931fa.3.1747318948180; Thu, 15 May 2025
 07:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com> <20250512190834.332684-24-ardb+git@google.com>
 <20250515111000.GBaCXLiEi0_bG1qVzx@fat_crate.local>
In-Reply-To: <20250515111000.GBaCXLiEi0_bG1qVzx@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 May 2025 15:22:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFadOW5pHLWBEdw=wt+5WHpcjY5RdWgyA7pOW149ByEDg@mail.gmail.com>
X-Gm-Features: AX0GCFvaQdItb8Yn0h0VLAkM9sCJ12in6suYlAfQoGDX5cgknSr4R7xsrmmgCP8
Message-ID: <CAMj1kXFadOW5pHLWBEdw=wt+5WHpcjY5RdWgyA7pOW149ByEDg@mail.gmail.com>
Subject: Re: [RFT PATCH v3 01/21] x86/sev: Separate MSR and GHCB based
 snp_cpuid() via a callback
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 12:10, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, May 12, 2025 at 09:08:36PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > There are two distinct callers of snp_cpuid(): one where the MSR
> > protocol is always used, and one where the GHCB page based interface is
> > always used.
>
> Yeah, let's stick to the nomenclature, pls: you have a GHCB protocol and a MSR
> protocol. We call both protocols. :)
>
> > The snp_cpuid() logic does not care about the distinction, which only
> > matters at a lower level. But the fact that it supports both interfaces
> > means that the GHCB page based logic is pulled into the early startup
> > code where PA to VA conversions are problematic, given that it runs from
> > the 1:1 mapping of memory.
> >
> > So keep snp_cpuid() itself in the startup code, but factor out the
> > hypervisor calls via a callback, so that the GHCB page handling can be
> > moved out.
> >
> > Code refactoring only - no functional change intended.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/startup/sev-shared.c | 58 ++++----------------
> >  arch/x86/coco/sev/vc-shared.c      | 49 ++++++++++++++++-
> >  arch/x86/include/asm/sev.h         |  3 +-
> >  3 files changed, 61 insertions(+), 49 deletions(-)
>
> ...
>
> > @@ -484,21 +447,21 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
> >       return false;
> >  }
> >
> > -static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> > +static void snp_cpuid_hv_no_ghcb(void *ctx, struct cpuid_leaf *leaf)
>
> Uff, those suffixes make my head hurt. So this is the MSR prot CPUID. Let's
> call it this way:
>
>         snp_cpuid_msr_prot()
>
> and the other one
>
>         snp_cpuid_ghcb_prot()
>
> All clear this way.
>
> >  {
> > -     if (sev_cpuid_hv(ghcb, ctxt, leaf))
> > +     if (__sev_cpuid_hv_msr(leaf))
>
> __sev_cpuid_msr_prot
>
> >               sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
> >  }
> >
> >  static int __heada
>
> Let's zap that ugly linebreak.
>
> > -snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> > -                   struct cpuid_leaf *leaf)
> > +snp_cpuid_postprocess(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
>
> Let's call that just "cpuid" now that it can be different things and it is
> a pointer.
>
> > +                   void *ctx, struct cpuid_leaf *leaf)
> >  {
> >       struct cpuid_leaf leaf_hv = *leaf;
> >
> >       switch (leaf->fn) {
> >       case 0x1:
> > -             snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> > +             cpuid_hv(ctx, &leaf_hv);
> >
> >               /* initial APIC ID */
> >               leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
> > @@ -517,7 +480,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> >               break;
> >       case 0xB:
> >               leaf_hv.subfn = 0;
> > -             snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> > +             cpuid_hv(ctx, &leaf_hv);
> >
> >               /* extended APIC ID */
> >               leaf->edx = leaf_hv.edx;
> > @@ -565,7 +528,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> >               }
> >               break;
> >       case 0x8000001E:
> > -             snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> > +             cpuid_hv(ctx, &leaf_hv);
> >
> >               /* extended APIC ID */
> >               leaf->eax = leaf_hv.eax;
> > @@ -587,7 +550,8 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> >   * should be treated as fatal by caller.
> >   */
> >  int __head
>
> And that ugly linebreak too pls.
>
> ...
>
> Here's a diff ontop with my changes. I think it looks a lot saner now and one
> can really differentiate which is which.
>

Thanks, I'll fold that in.

