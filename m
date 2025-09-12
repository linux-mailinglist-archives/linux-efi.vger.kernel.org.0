Return-Path: <linux-efi+bounces-4742-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21809B543E2
	for <lists+linux-efi@lfdr.de>; Fri, 12 Sep 2025 09:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED383A0631
	for <lists+linux-efi@lfdr.de>; Fri, 12 Sep 2025 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD68A2D0C60;
	Fri, 12 Sep 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZOSMjLC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917C2D0635
	for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662191; cv=none; b=ngqUXp2DodhUHNQBdp29haj+NWfhDbUE0a6j39X/8AvIIrlhIL/Dvx5wlGENTYuFIht9G3swZ4iixNrde5BkktI9vH6ke6N8v7Mgph6Q/ilcPgYnlC56bVe1qTDOGl1lCD85s/P2geWujv8SAhfwxSGr3/VJL88rhVVq98y/n1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662191; c=relaxed/simple;
	bh=IVoYPSD55VQEgGObulLbSMhfUJE3wN6xaZ5g1RXjnj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FByTmcP87uDTzYLvZhcPeH55dxq+Sb1quczqMp5VsUqDcwbMvF5c3tfGIlgXGh2wFIpyEWNhmZMb4TV1D+5DwPqUz37GRnYHOtEcKSK2au6+WVrSCGvB/E8rpfd2/X47kvJFbaMPqUK319kcakR4rEIfOkKU4id6yQARI7wEt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZOSMjLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5971CC4CEF4
	for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 07:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757662191;
	bh=IVoYPSD55VQEgGObulLbSMhfUJE3wN6xaZ5g1RXjnj4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YZOSMjLCNUnDvao2BU2Ec/Y/TEAFDirIoT+BMHHauibuyRXbFxF7Sn0LbFksB5r0x
	 CP4rSxYLMRYPoKRId0qKCoR+M777pCIns+gTWooe/PldhqXQnJxQTSmyYCCMy2nH4T
	 n0tLxp10pOIcSUm4zGhlSR1F3cbY6wCZhlkOjcFP6uX0qc+udneQk0p5WXqXWVAaLA
	 ZwtJ9Z7wyhSkL+FfrOh9S5G5d5TMRRI2Hzk64J7UnqUFGjPyYTueJZd9Zc2aWf1TDV
	 yMuN1aV+oGje/KaNcIkwVvTlVxnOraH7LSYj09dmz79GQ8dmhMiJ9ixN93OBku8A6e
	 bAmLUSOo6SDOA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-351f5cec42dso2010671fa.2
        for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 00:29:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVanV1Oblm2T7fVDY846KDykYQzAa8G+sDdumlTl/z34RbwxpRzmhjhcb1lwe8OmIRBRNac8rHFN+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6CEE8USTFgzBG2WxSV+A4/Qz/B7Hae65Z1taWMJxlPvONUpX
	E4Kgt+rMAXmje3R8E1SJ+hROq5vKuyhgORJENTGPBLnAPO9xISqLIY/jPOeveYDQhQQqU1Y6mzg
	hbAq8l/kK2zZf6KbadsWpmRAdWG4rKfk=
X-Google-Smtp-Source: AGHT+IGfrBa6o27pmxxn1xnpGqIqwq4WH4IYZ2O54otiYdLsrXla2aYgkEblTj9kYXS/EXMufjkO2o+SksZs5QMczI4=
X-Received: by 2002:a05:6512:696:b0:55f:6649:45b8 with SMTP id
 2adb3069b0e04-5704ebf307dmr754106e87.45.1757662189686; Fri, 12 Sep 2025
 00:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909080631.2867579-5-ardb+git@google.com> <20250909080631.2867579-8-ardb+git@google.com>
 <802166ae-9420-41f6-95ed-6570ef660369@amd.com>
In-Reply-To: <802166ae-9420-41f6-95ed-6570ef660369@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 12 Sep 2025 09:29:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGmgXRA=hO5P1bcTU1ya-RypU_y3_kahO632U5iPT7vaQ@mail.gmail.com>
X-Gm-Features: Ac12FXy8u5owgmeKI9io1tN_COZ4GouXszZVG6QjR4ZqPDGN-Jk9dbmxMRUdGmk
Message-ID: <CAMj1kXGmgXRA=hO5P1bcTU1ya-RypU_y3_kahO632U5iPT7vaQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] x86/efistub: Don't bother enabling SEV in the EFI stub
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 23:53, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 9/9/25 03:06, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > One of the last things the EFI stub does before handing over to the core
> > kernel when booting as a SEV guest is enabling SEV, even though this is
> > mostly redundant: one of the first things the core kernel does is
> > calling sme_enable(), after setting up the early GDT and IDT but before
> > even setting up the kernel page tables. sme_enable() performs the same
> > SEV-SNP initialization that the decompressor performs in sev_enable().
> >
> > So let's just drop this call to sev_enable(), and rely on the core
> > kernel to initiaize SEV correctly.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/include/asm/sev.h              | 2 --
> >  drivers/firmware/efi/libstub/x86-stub.c | 6 ------
> >  2 files changed, 8 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > index d7be1ff3f7e0..b017e1dab705 100644
> > --- a/arch/x86/include/asm/sev.h
> > +++ b/arch/x86/include/asm/sev.h
> > @@ -462,7 +462,6 @@ static __always_inline void sev_es_nmi_complete(void)
> >               __sev_es_nmi_complete();
> >  }
> >  extern int __init sev_es_efi_map_ghcbs_cas(pgd_t *pgd);
> > -extern void sev_enable(struct boot_params *bp);
> >
> >  /*
> >   * RMPADJUST modifies the RMP permissions of a page of a lesser-
> > @@ -588,7 +587,6 @@ static inline void sev_es_ist_exit(void) { }
> >  static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
> >  static inline void sev_es_nmi_complete(void) { }
> >  static inline int sev_es_efi_map_ghcbs_cas(pgd_t *pgd) { return 0; }
> > -static inline void sev_enable(struct boot_params *bp) { }
> >  static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
> >  static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
> >  static inline void setup_ghcb(void) { }
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index c4ef645762ec..354bc3901193 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -938,12 +938,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
> >               goto fail;
> >       }
> >
> > -     /*
> > -      * Call the SEV init code while still running with the firmware's
> > -      * GDT/IDT, so #VC exceptions will be handled by EFI.
> > -      */
> > -     sev_enable(boot_params);
>
> I think we lose the check for GHCB_HV_FT_SNP_MULTI_VMPL by doing this. It
> might need move into svsm_setup_ca() now.
>

Currently, this check only occurs inside sev_enable(), and so it
happens too late to have an impact, given that the core kernel will
set up all of this state from scratch right away.

So if this check is needed in the EFI stub to begin with, it should be
moved into early_is_sevsnp_guest() so that the check occurs before
attempting to accept memory.

