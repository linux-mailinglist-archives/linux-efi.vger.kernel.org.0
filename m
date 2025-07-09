Return-Path: <linux-efi+bounces-4263-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C9AFF550
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 01:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B32A4A7D51
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 23:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EDC26B2A9;
	Wed,  9 Jul 2025 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmfiutwL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2726B096;
	Wed,  9 Jul 2025 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752103295; cv=none; b=qqIWOc97cjKCc28N9a5CQsyy+b2xw0iAe4ns6wWuNlv7nmRtmHIISHLYm9kPuPbxLfsoy7yOtd+/11f0z6Y3hcdG3jWlxL6/qHjQRct+d5orYUSjvsoqukCWBsD61VnneSsQEVLtw9O31+fEUF1aUaYBoKXHPbY2Mvvn4LjcqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752103295; c=relaxed/simple;
	bh=7El6AbaWSf3lWIgK94CBspEKFvT/XKceyHt1K4VH6lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhbn4doaMfm/GIESgKGouRYa4MyB0AS0lPYqz+fOn8PJIx4XJLVd40Gmxq1+JyaGQtjcWK07DCE3EFgmyrUwXR3F5gZV9OpgtKneXEjUp8dAdEh6OvlGivTlVrXoh3whN19gzMcQySNluKr+5Hk1g1BQ5VA2Xx3UJWwIAUdzd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmfiutwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B018C4CEF5;
	Wed,  9 Jul 2025 23:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752103295;
	bh=7El6AbaWSf3lWIgK94CBspEKFvT/XKceyHt1K4VH6lA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FmfiutwLCMTmgSaN+6q0GgjsBjXQRbHq5HleIH6Q/G7ZpuWEvsIXGnWhhtz+eTCDA
	 kXWYtnzbTDZH7yXc6bpR4UThCfW+Nmjt2LK0VMxLlTNc5f+fNwzFt74CsJ7DAndKPg
	 +cfD+OxEXLoJ9K35i08ht2GXFPc49N/ue/Ki51fdgStDiRScigrMbgguE7PXdNfqIN
	 +EujunyaK6nS8t3Y3k02ghVKsv2UbtcTz+NZA0/LlsFR1JYzTGT0UOQn8jbZ+Ap9iV
	 BaBcF2vkJ7aaNTnK4FER7spbcCEF+vySmaNnpR7PkKfERS4d3JV0FqiGLDzJASsjFy
	 ck3tAJzuSJDOw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55511c3e203so321684e87.3;
        Wed, 09 Jul 2025 16:21:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUq41e9Nx6wSyzq1dmjROiv+TCohdrJJMj1ocUTqFyTTQ1M1GjWE7826xyfh5XJduP6xT1P6VtDqwg=@vger.kernel.org, AJvYcCWZyJ3IVESXtaMnysQ6aUSTjhLfNzQMxgDGkrNUxueM49iyy/OoleMBEI3xF+tHlINnLae1c9h170s4E0ON@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKJLo+tF1WYoG8YW93eCPd8F7a9WdTRdVZdlblnh+qkdYp+o/
	E2rJ1f2WIQTEfZ+LeP2o2U/VF9CXu5oSButOekM3iBeEhhuLY+5tHd7U6fpbke5vyQ3nKJCpFil
	Kwc4j3mph0RisXQGoeRMl4BF9TzwcAmA=
X-Google-Smtp-Source: AGHT+IGorBubXSMAvtt0qBevxyHV9E2jDM8arG49vRSWjvpJ7PBry2pp56BMY+AsCCAZ7njkiAgOiUyw/z0CYl77hhk=
X-Received: by 2002:a05:6512:10ca:b0:553:2480:2309 with SMTP id
 2adb3069b0e04-5592e2ecd5dmr191732e87.3.1752103293549; Wed, 09 Jul 2025
 16:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-27-ardb+git@google.com> <74889161-adfa-3547-d8a9-3ff154098c7a@amd.com>
In-Reply-To: <74889161-adfa-3547-d8a9-3ff154098c7a@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 10 Jul 2025 09:21:19 +1000
X-Gmail-Original-Message-ID: <CAMj1kXF-ufGkWRkEOwOLntPOuVS1skLJ8HA0FpfJCQbvoDeTJA@mail.gmail.com>
X-Gm-Features: Ac12FXyAmKZpOquoXydURIE0y4KKJUBqL8540sEaEeMUcSbjhUvgHIP3LlMA4J8
Message-ID: <CAMj1kXF-ufGkWRkEOwOLntPOuVS1skLJ8HA0FpfJCQbvoDeTJA@mail.gmail.com>
Subject: Re: [PATCH v4 01/24] x86/sev: Separate MSR and GHCB based snp_cpuid()
 via a callback
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 01:12, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 7/9/25 03:08, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > There are two distinct callers of snp_cpuid(): one where the MSR
> > protocol is always used, and one where the GHCB page based interface is
> > always used.
> >
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
> >  arch/x86/boot/startup/sev-shared.c | 64 ++++----------------
> >  arch/x86/coco/sev/vc-shared.c      | 49 ++++++++++++++-
> >  arch/x86/include/asm/sev.h         |  3 +-
> >  3 files changed, 63 insertions(+), 53 deletions(-)
> >
> > diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> > index 7a706db87b93..992abfa50508 100644
> > --- a/arch/x86/boot/startup/sev-shared.c
> > +++ b/arch/x86/boot/startup/sev-shared.c
> > @@ -319,7 +319,7 @@ static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
> >       return 0;
> >  }
> >
> > -static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
> > +static int __sev_cpuid_msr_prot(struct cpuid_leaf *leaf)
>
> Not sure the renaming makes it read any easier or say anything more. It
> does add extra changes to the diff that have to be read through, though,
> so I don't think it is beneficial.
>

These additional changes were provided by Boris as a delta patch on
top of my v3, so I will leave to him to respond to this.

https://lore.kernel.org/all/20250512190834.332684-24-ardb+git@google.com/T/#u



> >  {
> >       int ret;
> >
> > @@ -342,44 +342,7 @@ static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
> >       return ret;
> >  }
> >
> > -static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> > -{
> > -     u32 cr4 = native_read_cr4();
> > -     int ret;
> > -
> > -     ghcb_set_rax(ghcb, leaf->fn);
> > -     ghcb_set_rcx(ghcb, leaf->subfn);
> > -
> > -     if (cr4 & X86_CR4_OSXSAVE)
> > -             /* Safe to read xcr0 */
> > -             ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
> > -     else
> > -             /* xgetbv will cause #UD - use reset value for xcr0 */
> > -             ghcb_set_xcr0(ghcb, 1);
> > -
> > -     ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
> > -     if (ret != ES_OK)
> > -             return ret;
> > -
> > -     if (!(ghcb_rax_is_valid(ghcb) &&
> > -           ghcb_rbx_is_valid(ghcb) &&
> > -           ghcb_rcx_is_valid(ghcb) &&
> > -           ghcb_rdx_is_valid(ghcb)))
> > -             return ES_VMM_ERROR;
> >
> > -     leaf->eax = ghcb->save.rax;
> > -     leaf->ebx = ghcb->save.rbx;
> > -     leaf->ecx = ghcb->save.rcx;
> > -     leaf->edx = ghcb->save.rdx;
> > -
> > -     return ES_OK;
> > -}
> > -
> > -static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> > -{
> > -     return ghcb ? __sev_cpuid_hv_ghcb(ghcb, ctxt, leaf)
> > -                 : __sev_cpuid_hv_msr(leaf);
> > -}
> >
> >  /*
> >   * This may be called early while still running on the initial identity
> > @@ -484,21 +447,20 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
> >       return false;
> >  }
> >
> > -static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> > +static void snp_cpuid_msr_prot(void *ctx, struct cpuid_leaf *leaf)
> >  {
> > -     if (sev_cpuid_hv(ghcb, ctxt, leaf))
> > +     if (__sev_cpuid_msr_prot(leaf))
> >               sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
> >  }
> >
> > -static int __head
> > -snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> > -                   struct cpuid_leaf *leaf)
> > +static int __head snp_cpuid_postprocess(void (*cpuid)(void *ctx, struct cpuid_leaf *),
> > +                                     void *ctx, struct cpuid_leaf *leaf)
> >  {
> >       struct cpuid_leaf leaf_hv = *leaf;
> >
> >       switch (leaf->fn) {
> >       case 0x1:
> > -             snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> > +             cpuid(ctx, &leaf_hv);
>
> Maybe rename this parameter to snp_cpuid or snp_cpuid_fn or similar,
> because it can be very confusing to see "cpuid" on its own like this.
>
> >
> >               /* initial APIC ID */
> >               leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
> > @@ -517,7 +479,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> >               break;
> >       case 0xB:
> >               leaf_hv.subfn = 0;
> > -             snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> > +             cpuid(ctx, &leaf_hv);
> >
> >               /* extended APIC ID */
> >               leaf->edx = leaf_hv.edx;
> > @@ -565,7 +527,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> >               }
> >               break;
> >       case 0x8000001E:
> > -             snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> > +             cpuid(ctx, &leaf_hv);
> >
> >               /* extended APIC ID */
> >               leaf->eax = leaf_hv.eax;
> > @@ -586,8 +548,8 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> >   * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
> >   * should be treated as fatal by caller.
> >   */
> > -int __head
> > -snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> > +int __head snp_cpuid(void (*cpuid)(void *ctx, struct cpuid_leaf *), void *ctx,
> > +                  struct cpuid_leaf *leaf)
> >  {
> >       const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> >
> > @@ -621,7 +583,7 @@ snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> >                       return 0;
> >       }
> >
> > -     return snp_cpuid_postprocess(ghcb, ctxt, leaf);
> > +     return snp_cpuid_postprocess(cpuid, ctx, leaf);
> >  }
> >
> >  /*
> > @@ -648,14 +610,14 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
> >       leaf.fn = fn;
> >       leaf.subfn = subfn;
> >
> > -     ret = snp_cpuid(NULL, NULL, &leaf);
> > +     ret = snp_cpuid(snp_cpuid_msr_prot, NULL, &leaf);
> >       if (!ret)
> >               goto cpuid_done;
> >
> >       if (ret != -EOPNOTSUPP)
> >               goto fail;
> >
> > -     if (__sev_cpuid_hv_msr(&leaf))
> > +     if (__sev_cpuid_msr_prot(&leaf))
> >               goto fail;
> >
> >  cpuid_done:
> > diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
> > index 2c0ab0fdc060..776cb90be530 100644
> > --- a/arch/x86/coco/sev/vc-shared.c
> > +++ b/arch/x86/coco/sev/vc-shared.c
> > @@ -409,15 +409,62 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
> >       return ret;
> >  }
> >
> > +static int __sev_cpuid_ghcb_prot(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
>
> Ditto here and below, keeping the __sev_cpuid_hv_ghcb() /
> sev_cpuid_hv_ghcb() name would be best.
>
> Thanks,
> Tom
>
> > +{
> > +     u32 cr4 = native_read_cr4();
> > +     int ret;
> > +
> > +     ghcb_set_rax(ghcb, leaf->fn);
> > +     ghcb_set_rcx(ghcb, leaf->subfn);
> > +
> > +     if (cr4 & X86_CR4_OSXSAVE)
> > +             /* Safe to read xcr0 */
> > +             ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
> > +     else
> > +             /* xgetbv will cause #UD - use reset value for xcr0 */
> > +             ghcb_set_xcr0(ghcb, 1);
> > +
> > +     ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
> > +     if (ret != ES_OK)
> > +             return ret;
> > +
> > +     if (!(ghcb_rax_is_valid(ghcb) &&
> > +           ghcb_rbx_is_valid(ghcb) &&
> > +           ghcb_rcx_is_valid(ghcb) &&
> > +           ghcb_rdx_is_valid(ghcb)))
> > +             return ES_VMM_ERROR;
> > +
> > +     leaf->eax = ghcb->save.rax;
> > +     leaf->ebx = ghcb->save.rbx;
> > +     leaf->ecx = ghcb->save.rcx;
> > +     leaf->edx = ghcb->save.rdx;
> > +
> > +     return ES_OK;
> > +}
> > +
> > +struct cpuid_ctx {
> > +     struct ghcb *ghcb;
> > +     struct es_em_ctxt *ctxt;
> > +};
> > +
> > +static void snp_cpuid_ghcb_prot(void *p, struct cpuid_leaf *leaf)
> > +{
> > +     struct cpuid_ctx *ctx = p;
> > +
> > +     if (__sev_cpuid_ghcb_prot(ctx->ghcb, ctx->ctxt, leaf))
> > +             sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
> > +}
> > +
> >  static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
> >  {
> > +     struct cpuid_ctx ctx = { ghcb, ctxt };
> >       struct pt_regs *regs = ctxt->regs;
> >       struct cpuid_leaf leaf;
> >       int ret;
> >
> >       leaf.fn = regs->ax;
> >       leaf.subfn = regs->cx;
> > -     ret = snp_cpuid(ghcb, ctxt, &leaf);
> > +     ret = snp_cpuid(snp_cpuid_ghcb_prot, &ctx, &leaf);
> >       if (!ret) {
> >               regs->ax = leaf.eax;
> >               regs->bx = leaf.ebx;
> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > index 89075ff19afa..2cabf617de3c 100644
> > --- a/arch/x86/include/asm/sev.h
> > +++ b/arch/x86/include/asm/sev.h
> > @@ -552,7 +552,8 @@ struct cpuid_leaf {
> >       u32 edx;
> >  };
> >
> > -int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf);
> > +int snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
> > +           void *ctx, struct cpuid_leaf *leaf);
> >
> >  void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
> >  enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,

