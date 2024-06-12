Return-Path: <linux-efi+bounces-1204-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD32905272
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 14:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC63C281A0F
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8260616F901;
	Wed, 12 Jun 2024 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tim77IQF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6116F8F6;
	Wed, 12 Jun 2024 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195388; cv=none; b=UzXEjMWIU/bMAyfTtHb2BKK3csPtB9FQ14R4TftFBz41cq2egnF/kghehKbge+Ql1jD0APtNB11EG+iDTI8mkr3bwN1kh1oUAGjNbVzvWrO05wsJDjgcjgfyiToA0XRFVJiJoxLhQ3N8fNmRJrf3zmNDGvP5UFBDcWPqgBWcGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195388; c=relaxed/simple;
	bh=DVXSUJOaMF5A5vgI0u1mTlSeNnf28DMvlwMQBXdQQ4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lx1NBpGOxVqunghaZFyvKP9jtbLhRo3n5uyYC4GJrNDi+YE3lrDs7e92tWkut48hy8g9E5uIomomsWKQQUu8gwkAhO6prcf1qWVhx2LOk133D97Ddp8pBnsQIoJgil7EWeA6WsWLHWvCFc5dVISwYKXWKEatNNoSXEn21wPePR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tim77IQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD2DC4AF50;
	Wed, 12 Jun 2024 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718195387;
	bh=DVXSUJOaMF5A5vgI0u1mTlSeNnf28DMvlwMQBXdQQ4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tim77IQF7Ywd3tAiYO9QS12w1d8sYyt1Nxh8aNBQJ8d8pxT6mrwTRo04sa6YR5ZnU
	 Y9gkOKGnd0uFQY2pTYKLVETkrwe+A7Gm9gFaYHH1Y69Q3kbynsUJnw9tcQ9jz4B93R
	 GG9/iQgXMwZCrR8QjV3D5T3gmMggEPoKT5wpe5/WNO+HPZ0HJ1hc2BTC8xLLrmjNvy
	 fhWDA6y1g9Bz1qigUHZElCF1uP0bvgQ3So/RMbu+8jap6zxO7qMtl6N6SEQuENnHWs
	 t6LwwzBzk5SnRrYsM1pmmnokjslbrfgofhzhyT+QKH4ZqtpioVIJ+m89ao8oVoSIWN
	 4bebiQBkanSKA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eadaac1d28so60854571fa.3;
        Wed, 12 Jun 2024 05:29:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwLoFF8LH9yYsb6cw9jgrU0im/7huQ8/5czkYU226CcH//Nesy3uttfQ/uW9j51UaoPkha4p73ae7MznEPvIhwW6K+jd+yq1R062+xlLspIwidF7wPSCSKvHYx7Qe9Y+rPrFaODrpp
X-Gm-Message-State: AOJu0YzgjIJK/Z+D4j3XWT+V9nFy/UcyF7eg6xqr4JKJEdhkvJh+np7E
	dvJm/TDxc0aLY6rSztVcy0eng6DPJGYeYfSS2cad5NQFcL6e9iyCbc3PTAd+9t/87mHeGshNHwv
	7kN1O+Rtd0cNi7wp+1iASlyDrTQg=
X-Google-Smtp-Source: AGHT+IFArMXnRwoF8dtHUt96Zs78sLN9Kol1ue+QkkbZ4HKFDi5TTYrgCCsxPCVIlsJejAhdJlhKLrQXQIAVc/9MBNY=
X-Received: by 2002:a2e:3201:0:b0:2eb:e3a7:8b with SMTP id 38308e7fff4ca-2ebfc9f727bmr11339351fa.26.1718195386258;
 Wed, 12 Jun 2024 05:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610140932.2489527-2-ardb+git@google.com> <CALu+AoREA7f=UBrmbvH92nDp66LyB99QEu84e_8HSurnjLqdUw@mail.gmail.com>
In-Reply-To: <CALu+AoREA7f=UBrmbvH92nDp66LyB99QEu84e_8HSurnjLqdUw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 12 Jun 2024 14:29:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFxEwoSjHHt+1CFqMHwQyC6UVbt=5AqFvE1S5B46AbnOA@mail.gmail.com>
Message-ID: <CAMj1kXFxEwoSjHHt+1CFqMHwQyC6UVbt=5AqFvE1S5B46AbnOA@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Free EFI memory map only when installing a new one.
To: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ashish Kalra <Ashish.Kalra@amd.com>, Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 12:36, Dave Young <dyoung@redhat.com> wrote:
>
> On Mon, 10 Jun 2024 at 22:09, Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The logic in __efi_memmap_init() is shared between two different
> > execution flows:
> > - mapping the EFI memory map early or late into the kernel VA space, so
> >   that its entries can be accessed;
> > - cloning the EFI memory map in order to insert new entries that are
> >   created as a result of creating a memory reservation
> >   (efi_arch_mem_reserve())
> >
> > In the former case, the underlying memory containing the kernel's view
> > of the EFI memory map (which may be heavily modified by the kernel
> > itself on x86) is not modified at all, and the only thing that changes
> > is the virtual mapping of this memory, which is different between early
> > and late boot.
> >
> > In the latter case, an entirely new allocation is created that carries a
> > new, updated version of the kernel's view of the EFI memory map. When
> > installing this new version, the old version will no longer be
> > referenced, and if the memory was allocated by the kernel, it will leak
> > unless it gets freed.
> >
> > The logic that implements this freeing currently lives on the code path
> > that is shared between these two use cases, but it should only apply to
> > the latter. So move it to the correct spot.
> >
> > Cc: Ashish Kalra <Ashish.Kalra@amd.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Link: https://lore.kernel.org/all/36ad5079-4326-45ed-85f6-928ff76483d3@amd.com
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/platform/efi/memmap.c | 5 +++++
> >  drivers/firmware/efi/memmap.c  | 5 -----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
> > index 4ef20b49eb5e..4990244e5168 100644
> > --- a/arch/x86/platform/efi/memmap.c
> > +++ b/arch/x86/platform/efi/memmap.c
> > @@ -97,6 +97,11 @@ int __init efi_memmap_install(struct efi_memory_map_data *data)
> >         if (efi_enabled(EFI_PARAVIRT))
> >                 return 0;
> >
> > +       if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
> > +               __efi_memmap_free(efi.memmap.phys_map,
> > +                                 efi.memmap.desc_size * efi.memmap.nr_map,
> > +                                 efi.memmap.flags);
> > +
> >         return __efi_memmap_init(data);
>
> Nice fix!  but would it be better to save the old addr/size/flag and
> free them only when __efi_memmap_init succeed?
>

Yeah. I guess the same applies to the original code, but now is as
good a time as ever to fix that as well.

