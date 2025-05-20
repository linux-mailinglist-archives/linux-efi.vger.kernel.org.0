Return-Path: <linux-efi+bounces-3757-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D408EABD75A
	for <lists+linux-efi@lfdr.de>; Tue, 20 May 2025 13:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898EF4A75F2
	for <lists+linux-efi@lfdr.de>; Tue, 20 May 2025 11:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68CE272E7C;
	Tue, 20 May 2025 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2TVqSAK"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE3921C9E4;
	Tue, 20 May 2025 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741788; cv=none; b=A1+mAAqqVU1YcgcGjuEIi4BJuaKX6i6ohtSekFduRynmw12Ge4nJm83scTTodA/pHXRLVN6pBCChDSGOhvmBSb77/BQd32jOm1tTlkMFFJaE6/o3ORtRyHKcRZNNLRzocjB04aAdRl4OPostkwVU6Im8n0hOpXwUR0gASJ4WUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741788; c=relaxed/simple;
	bh=ZgFU4Qt2UDoHBOGb5llT6tHaK06H5LnMXA3bUnhfAMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuQsCZILpqmnR82XJVCwBSS4yEbszAGNSV20L5KAwiEUSVig5Plv0h7CR7nXJr0uixazJCAgnrT0obSw1u/pUeFk2a6TNqRMSae3FySud34zbGWc/qF+CqXnP9dWRqziZSlQKndexEI9JVt7/LmLfF/Tmj8pMoF+ugGYcPvRHOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2TVqSAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE94C4CEF1;
	Tue, 20 May 2025 11:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747741788;
	bh=ZgFU4Qt2UDoHBOGb5llT6tHaK06H5LnMXA3bUnhfAMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y2TVqSAKWfYmyKTk91EgBWAMRarlTTBp3/Od54KL2D+DgO0ZOcs6FK4LF/pNSmbyk
	 3EyigzdEhz1T1qgBKquW26rt3TphLcqw8M2z9TlwAjr1RXvFPm4Qe8hLi5UevxAqSG
	 lBYcWadBZ9R76fKA1KRNHi4kD9i8rh3abYijvse8UbVncGJ+QfAFPJGclOzGg6cElF
	 yGOlsRI2fgmni65JhyDD7nG4PAqRA3YogX1OGsuve4U24dkc/NuLwmle1u1qSOPXYf
	 dzu8gkDl5uKyU9zJWjBG+QscisUGgUNNOAQ9WYMTORsNwsKWNTHAE8JCm667yDCDpY
	 i4PU9F50mSd6w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-550edba125bso3954446e87.3;
        Tue, 20 May 2025 04:49:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWESlic6HCm42CPxTeeymN1nkld4NoWPV9pVpMKsWi/feR3ZaEBJ3jKE/Uub2qu4M47Vc3aUnzgglo=@vger.kernel.org, AJvYcCWwdPxUa1fR7YT9AafOfqx1pG3Czjb939Qx914YobpT5s11mWo55i8dIuEnHCZ+VSf8bBXKgO49n/pus3bH@vger.kernel.org
X-Gm-Message-State: AOJu0YyYY5kJje0sVhWlfmaMVZnGu83EKeLMvNAuey5ZKfwCr87Sio2P
	CXhDn+0LrkM/GQo1aOAk3kxZ9mvE1+PeoPrsUJi8s/bB7tgqVBOVZgakgBMPBGz1sAg9/cPbKp9
	Egn1RwC1SijCx22TU+ESaTRhbg7+a+YU=
X-Google-Smtp-Source: AGHT+IFBawAVA3NVYikKol17lgUtc1H2DK1FfveJ74ZjBkgr6eVTbJd9Z/zsPNSSnbqpu63MnnnBzHkbeShgld3YmyE=
X-Received: by 2002:a05:651c:150e:b0:326:c36a:bd63 with SMTP id
 38308e7fff4ca-328077c4059mr70554841fa.29.1747741786458; Tue, 20 May 2025
 04:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com> <20250512190834.332684-28-ardb+git@google.com>
 <20250520113849.GKaCxpyVy-7N6bih-r@fat_crate.local>
In-Reply-To: <20250520113849.GKaCxpyVy-7N6bih-r@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 20 May 2025 13:49:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEikRCP4TyNWWQh7wKErr9YKAe3cCbPw8XMuXLVkr2S_g@mail.gmail.com>
X-Gm-Features: AX0GCFu0doI1mXu2WMuGlzjLSY2ZR1cGel9drSVWgh4p6J2HLP1_ocvagLXPPSw
Message-ID: <CAMj1kXEikRCP4TyNWWQh7wKErr9YKAe3cCbPw8XMuXLVkr2S_g@mail.gmail.com>
Subject: Re: [RFT PATCH v3 05/21] x86/sev: Move GHCB page based HV
 communication out of startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 13:39, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, May 12, 2025 at 09:08:40PM +0200, Ard Biesheuvel wrote:
> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > index f50a606be4f1..07081bb85331 100644
> > --- a/arch/x86/include/asm/sev.h
> > +++ b/arch/x86/include/asm/sev.h
> > @@ -485,6 +485,7 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
> >  struct snp_guest_request_ioctl;
> >
> >  void setup_ghcb(void);
> > +void snp_register_ghcb_early(unsigned long paddr);
> >  void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
> >                                 unsigned long npages);
> >  void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> > @@ -521,8 +522,6 @@ static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
> >       __builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
> >  }
> >
> > -void vc_forward_exception(struct es_em_ctxt *ctxt);
> > -
> >  /* I/O parameters for CPUID-related helpers */
> >  struct cpuid_leaf {
> >       u32 fn;
> > @@ -533,15 +532,71 @@ struct cpuid_leaf {
> >       u32 edx;
> >  };
> >
> > +int svsm_perform_msr_protocol(struct svsm_call *call);
> >  int snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
> >             void *ctx, struct cpuid_leaf *leaf);
> >
> > +/*
> > + * Issue a VMGEXIT to call the SVSM:
> > + *   - Load the SVSM register state (RAX, RCX, RDX, R8 and R9)
> > + *   - Set the CA call pending field to 1
> > + *   - Issue VMGEXIT
> > + *   - Save the SVSM return register state (RAX, RCX, RDX, R8 and R9)
> > + *   - Perform atomic exchange of the CA call pending field
> > + *
> > + *   - See the "Secure VM Service Module for SEV-SNP Guests" specification for
> > + *     details on the calling convention.
> > + *     - The calling convention loosely follows the Microsoft X64 calling
> > + *       convention by putting arguments in RCX, RDX, R8 and R9.
> > + *     - RAX specifies the SVSM protocol/callid as input and the return code
> > + *       as output.
> > + */
> > +static __always_inline void svsm_issue_call(struct svsm_call *call, u8 *pending)
>
> Why in a header?
>
> At least in sev-internal.h or so.
>
> I'd prefer for this to be in a .c file, though.
>

OK. In that case, it will be implemented in the startup code then, and
exported to the rest of the core kernel via a PIC alias.

