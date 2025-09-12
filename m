Return-Path: <linux-efi+bounces-4744-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E17B54544
	for <lists+linux-efi@lfdr.de>; Fri, 12 Sep 2025 10:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682E03B9DAC
	for <lists+linux-efi@lfdr.de>; Fri, 12 Sep 2025 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9872D63E2;
	Fri, 12 Sep 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH1KklRb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3362D5950
	for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665628; cv=none; b=epZZNYep0jOz7mfPtuoneeERn22X2b5Z8gLL1UvnPrR+cz5u3D7YD/frmAH4xNC8oGVnwSA1iAv+BDPKAjiVzAVb4QLQx8AFkyqDiRpwSpre+6IHw16uKEQODFbqzpyOjdD9tPU2vj2t3EjhaV0C0D5uOQP5giFyP22/Drz8gCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665628; c=relaxed/simple;
	bh=vmYhHr3q3KlDaf1jjw8O49vpD71igLrPL/Z/RvcOSik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQSZIEs/V0wpuMz4+Ioz7uIbBQE/NlF8OKfKWJnboGO8KManwxpBbo1k9ppCsOZaFIFZrL/RjcWRYogopqHGckcGTT907pyGvMA4mGNKqcmzaYe8KWB6F9/QF/wEw1j+2ZmTpQOKDh9vZUomi+bDPPQn3Hy52oHReIEZz1C5w8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH1KklRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB6CC4CEF4
	for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757665628;
	bh=vmYhHr3q3KlDaf1jjw8O49vpD71igLrPL/Z/RvcOSik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FH1KklRbeumazHItY5LFdZRFTQ8Ko9kGvo309YpkNsa30JCAQirTDOMdNvjsKH69U
	 H9lxHp0mk8C4RBwmq+TKjySQJ6A7GriNVWu3YOuvlemD3ohL5AxaQfXtU5wgf1iP9p
	 MeAR3nnraRoz+PWMNq8Cw1PCkJ2CiZ6uUwpUezs7vi5HXEj6wHMSDZ6RFc/9U2kHLz
	 LjeQVhnaIG/glHFHec1ty5JE2CGL/zO+RcWBoW13tgcA+Uu34YmHMpm7cOJNy2W2DM
	 ml/+ADxLAcHYVwGV8hKzHPaM9wWl1Kx2GM5T3yHYdhbfT5c9NBLnsGScMUt/hv5i89
	 0bSSZFvAeRYIA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3517d7954deso3638691fa.0
        for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 01:27:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7cASnsZDMoJ+ooIcGcRGFU5GTPZayPw6UbNMoPIRIFM/5+6K3pado/NQadfJdpMetDctVEPxH0AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJj4L+ifapOBvXTxYC360S4Gm+MVurTRUSWvyRdS2XSx8wU9m
	ZGLNzF9YE0/pCO0DTUvruyVwoIEjiVt0xwP/l/H5mk5WpjoH1ii2CqZwPLstDFuDu8U/flSGLe2
	G6w0kRSgMGQNCp+xXmPPZKpMdbWGrPdg=
X-Google-Smtp-Source: AGHT+IFRWugTNgVxU/a0iPWbG7b8RZqvGzW6FpuqsYV/Y5JfUfyL6ISaYO96aaWDvLCXdsIFfDRBp3BoWVt6ldgQT6E=
X-Received: by 2002:a05:651c:25d4:10b0:30b:d156:9e7e with SMTP id
 38308e7fff4ca-3513882aed6mr4137051fa.2.1757665626633; Fri, 12 Sep 2025
 01:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909080631.2867579-5-ardb+git@google.com> <20250909080631.2867579-8-ardb+git@google.com>
 <802166ae-9420-41f6-95ed-6570ef660369@amd.com> <CAMj1kXGmgXRA=hO5P1bcTU1ya-RypU_y3_kahO632U5iPT7vaQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGmgXRA=hO5P1bcTU1ya-RypU_y3_kahO632U5iPT7vaQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 12 Sep 2025 10:26:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHqhWpb2OZy+1N8-oPa2Kk0d56NS6tYH46Z92ui3h5wMQ@mail.gmail.com>
X-Gm-Features: Ac12FXwAiWHkpOi6w-Ey855BsBfn61EtF93631McYXTqt0F-a6Avc93MjIpSCx8
Message-ID: <CAMj1kXHqhWpb2OZy+1N8-oPa2Kk0d56NS6tYH46Z92ui3h5wMQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] x86/efistub: Don't bother enabling SEV in the EFI stub
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 09:29, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 11 Sept 2025 at 23:53, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >
> > On 9/9/25 03:06, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > One of the last things the EFI stub does before handing over to the core
> > > kernel when booting as a SEV guest is enabling SEV, even though this is
> > > mostly redundant: one of the first things the core kernel does is
> > > calling sme_enable(), after setting up the early GDT and IDT but before
> > > even setting up the kernel page tables. sme_enable() performs the same
> > > SEV-SNP initialization that the decompressor performs in sev_enable().
> > >
> > > So let's just drop this call to sev_enable(), and rely on the core
> > > kernel to initiaize SEV correctly.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/include/asm/sev.h              | 2 --
> > >  drivers/firmware/efi/libstub/x86-stub.c | 6 ------
> > >  2 files changed, 8 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > > index d7be1ff3f7e0..b017e1dab705 100644
> > > --- a/arch/x86/include/asm/sev.h
> > > +++ b/arch/x86/include/asm/sev.h
> > > @@ -462,7 +462,6 @@ static __always_inline void sev_es_nmi_complete(void)
> > >               __sev_es_nmi_complete();
> > >  }
> > >  extern int __init sev_es_efi_map_ghcbs_cas(pgd_t *pgd);
> > > -extern void sev_enable(struct boot_params *bp);
> > >
> > >  /*
> > >   * RMPADJUST modifies the RMP permissions of a page of a lesser-
> > > @@ -588,7 +587,6 @@ static inline void sev_es_ist_exit(void) { }
> > >  static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
> > >  static inline void sev_es_nmi_complete(void) { }
> > >  static inline int sev_es_efi_map_ghcbs_cas(pgd_t *pgd) { return 0; }
> > > -static inline void sev_enable(struct boot_params *bp) { }
> > >  static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
> > >  static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
> > >  static inline void setup_ghcb(void) { }
> > > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > > index c4ef645762ec..354bc3901193 100644
> > > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > > @@ -938,12 +938,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
> > >               goto fail;
> > >       }
> > >
> > > -     /*
> > > -      * Call the SEV init code while still running with the firmware's
> > > -      * GDT/IDT, so #VC exceptions will be handled by EFI.
> > > -      */
> > > -     sev_enable(boot_params);
> >
> > I think we lose the check for GHCB_HV_FT_SNP_MULTI_VMPL by doing this. It
> > might need move into svsm_setup_ca() now.
> >
>
> Currently, this check only occurs inside sev_enable(), and so it
> happens too late to have an impact, given that the core kernel will
> set up all of this state from scratch right away.
>

Hmm, I only just spotted that this check only happens in the legacy
decompressor.

I think it makes sense for this check to live in svsm_setup_ca(), but
what is your take on the need to perform this check when accepting
memory from the stub using the CA address obtained from the firmware?
(i.e., way before sev_enable() is called)

