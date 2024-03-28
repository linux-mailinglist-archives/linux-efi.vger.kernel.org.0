Return-Path: <linux-efi+bounces-891-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 717298900F3
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 14:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1295FB238FC
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9307E576;
	Thu, 28 Mar 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6569FUq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805D83A00
	for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634259; cv=none; b=TakKijawFdn8K/e3p8aig8MTjy7r6bijEPVR1HLZ8N444J2+sXhcxpV+XvuggWkxWNBorHPcysv9bpef9xN8/VsNbvhI/m3wHBBTujBAlLNULJyQRBeIZJAo0dyDnJdUEnxy62hloKlJv95MD94lkUFcnzYo2LiKSyInQlrHAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634259; c=relaxed/simple;
	bh=EtTrYIO7+7QWtvik21QF1Vp+5yLnKk99bezvHuZdaRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRwHKBe0BiDN5ae/XHSbdfZYOyP9QRVoKuQ9yQXnQSSj9sceDnaQ/kmPDYr1Hgk2RMBWaelrGsTWHqDMfAwKCY9FcAm+iFfcWF0Pzty4o9cu95lhUBRenjdAxOV9tyw9Y7IWg291iQ8MWr9HqAhR4+R8vaWbof7w7NO0WKySuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6569FUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11742C43399
	for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634259;
	bh=EtTrYIO7+7QWtvik21QF1Vp+5yLnKk99bezvHuZdaRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m6569FUqBZP8aPQx6SGHVLzx1UzwuBTThyX3LwMDROAtb1G51laqsyQGgg4C6m7yu
	 rDvbGXOM55EjAzYJ24FojamGcESKfelIG9sUanru/RZpskAi2B7UAae/pcd51xtWgq
	 t2d/MMQGbjDvQX+mWe26qI6KPX0qnnFS8cp2dlvIIkmp/7veAD6hShhvSN8Ne3iPEw
	 9i/ydLhvPsnl/EAZKLK2G4X+ZdsI/oEIAMofm4S0qkbe4P3zAZ0GkJq0SlqHm34E5p
	 D9Cp5QWMmpi5Jxv0lKqZV/ScosnPadWQfDQxmJIUeEL1mYzSIhZB9LEaLn8flit+hT
	 VtgoF5nBp6WHg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d700beb60bso19890051fa.1
        for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 06:57:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGlviGLnKEAl6pa8kN10aViXjDpbvgjRixXd+EIr1rARpgkdn+Rfunl0loE6CpQbkrpd+yJVUWvl3dCauWL+1HJD9LbO0JwJ9L
X-Gm-Message-State: AOJu0YxwR+SLHv6NutUReeZCIjRkysITakkUo5VuGh0SP+NejpG72sfw
	AY79/el0ZJSxD4TjIQz9DocLxeuJN6vUArtJdayX406PJKjWBdLej96MHRJLqGbsRcFFndtrVYX
	EvJbjjqFc5TryDU1c/WgcaFw91Uk=
X-Google-Smtp-Source: AGHT+IGS7MVdRukx0rtqYZO4mg2JY5td0klQry0Vd8PWUKRk+3N5Q1DK9O1V4+8Yrm3phx0/IA4tv4WaRyZI/hNaGjw=
X-Received: by 2002:a2e:91d0:0:b0:2d6:edd8:f488 with SMTP id
 u16-20020a2e91d0000000b002d6edd8f488mr2830687ljg.37.1711634257420; Thu, 28
 Mar 2024 06:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326101850.914032-2-ardb+git@google.com> <ZgUollgbjAkTR0CD@wunner.de>
 <CAMj1kXE8pFxr3Ym5K7pHEJEti=+BahyaZKuACiEz57wyQ4C0Sg@mail.gmail.com> <ZgVy4BP1dpho5PZ8@wunner.de>
In-Reply-To: <ZgVy4BP1dpho5PZ8@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Mar 2024 15:57:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFFkVn1Y_m2LcB7dK+ACNmtL-gnpsmT-_ucn3zrO4RdcA@mail.gmail.com>
Message-ID: <CAMj1kXFFkVn1Y_m2LcB7dK+ACNmtL-gnpsmT-_ucn3zrO4RdcA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Cast away type warning in use of max()
To: Lukas Wunner <lukas@wunner.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, kazuma-kondo@nec.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 15:38, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Thu, Mar 28, 2024 at 11:13:07AM +0200, Ard Biesheuvel wrote:
> > On Thu, 28 Mar 2024 at 10:21, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Tue, Mar 26, 2024 at 11:18:51AM +0100, Ard Biesheuvel wrote:
> > > > Add a missing (u64) cast to alloc_min, which is passed into
> > > > efi_random_alloc() as unsigned long, while efi_physical_addr_t is u64.
> > > [...]
> > > > --- a/drivers/firmware/efi/libstub/randomalloc.c
> > > > +++ b/drivers/firmware/efi/libstub/randomalloc.c
> > > > @@ -120,7 +120,7 @@ efi_status_t efi_random_alloc(unsigned long size,
> > > >                       continue;
> > > >               }
> > > >
> > > > -             target = round_up(max(md->phys_addr, alloc_min), align) + target_slot * align;
> > > > +             target = round_up(max(md->phys_addr, (u64)alloc_min), align) + target_slot * align;
> > >
> > > Why not
> > >
> > >     max_t(u64, md->phys_addr, alloc_min)
> >
> > Why is that better?
>
> It just seems to be the idiomatic way to handle these casts in the kernel.
>

In this particular case, I prefer max() with the cast, because it
matches the other occurrence, where alloc_min is also used but there
it is u64 not unsigned long.

> It's also what checkpatch suggests, so by not using it you risk getting
> "helpful" fixup patches from the usual suspects.
>

Ugh yeah good point.

> It's your call buddy. :)

Thanks for the head's up

