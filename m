Return-Path: <linux-efi+bounces-457-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47FB847667
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 18:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBE91F21C54
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1161D14AD13;
	Fri,  2 Feb 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0BmDXPVC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309F7E5
	for <linux-efi@vger.kernel.org>; Fri,  2 Feb 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895680; cv=none; b=vAGKZiX5xqNYVZrV1fYh48+GsxPtSyfr/ff1HYFsdCF/G3xkShSTczaHSXAVGcED+KVB1/w3PJ3U8rRbGEP2zSFW43hFnbs7Fp35B+CfNDylpBVH85uZF1dgnOGEkXeB5yCOtEOdUTt5sZfV07rfJXKW3YCVNP3M9rgb3nw3Ueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895680; c=relaxed/simple;
	bh=bZlfqok9qew6k9fz+Z27UK6LPlwWG6tsG4PeKP4rbXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfA660yFdO3pD7Q//P9rs9Ov8Z+yqECRZ+/EHyCkSAHKPE+A/8LN0d+5bsaaH//yuYWTRAhFOPZGW8SV7D7pij5f4+p8E110MksHOFhMUK3JTMY/vS6b7KZPf416narFYBULZZDT8EsbxsI7QlqsXhhdFIsqm+YLPLwr6DBCXEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0BmDXPVC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a30e445602cso734260366b.0
        for <linux-efi@vger.kernel.org>; Fri, 02 Feb 2024 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706895676; x=1707500476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWtC7jO98lUeRBHL4RQhZAFvZjsqfE/uVt4nvdNHZP4=;
        b=0BmDXPVCkF4bYZYVpY2IE1feYwif9ZVfDxf4Ai5kQ2+xDCQfVyIqRnNpIiqtzx7Wop
         0/U+LW+t26DHFW/DdtukGLDFEuOQe3VEVp7AcJgo7w/vWqiok1OzprsQLDHBvXMl6P6j
         Y9xN2wj/q8cqsaotpugzLZ4NO9t77zu9lB9QXPQuUfw3fImZKPXzKO7jPOMyzPBr+imv
         F7Ymf956Ev3UfbjFNbCZWj1fvmwUiwDKPGlcwtNwJAo6q2XE2PAV+5koXBcTx+0fhdTZ
         NUzoW42EtSGesG9Kelhb0NZmuDibQODc/sqbaQOE6U7xtVmpsCcxvjsbI6NuW10Qm8/d
         Jopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895676; x=1707500476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWtC7jO98lUeRBHL4RQhZAFvZjsqfE/uVt4nvdNHZP4=;
        b=vVg2c3q5+84Bb150JA/2O8vm2LxFfcvcX9cCC8jP0o0LssGr55Wy0yhEabpgMLnQFh
         9ZIqDn/ZZaHzowbpKRzjKYyw8uVhlzdW1c1fvgsYCfFHUUBBwfwCkIFT0GaWPyZumQgf
         gWIGy2SVQcZXCt+X8X4D98GLunsKSbMcBB8QJYriOHeCx8YGaUX8issmlVh9bkyvjNhe
         irjYyBQAiA9cIlYFmk25/lafXtkJKF5neIoeDNrFXVUMUfrlEvz7yrw3EbTESRl7qmQp
         hvzdi7JwEjAPqU+CzAofDkThaFS4mh3xdbIw1dKhxRqeOM3bTta3ee6DipJNy2JzGg+b
         0x0A==
X-Gm-Message-State: AOJu0Ywhwohkvc2PyOZa6bKpocnX6nZQfONijx3wg+cCeZFPxz0A8k8t
	efpzcP7MU3P9Ua33qN5Kxe0IWJyDI4xb7WWctOkDqxfVJXNSbetTXr2LyT0lAk8x92lgcWTkgYK
	OfpjBoaS0xcE6dIbIhaVw4c8T3kQXIjXTtx7F5g==
X-Google-Smtp-Source: AGHT+IHHACEG53UViD2eXG7vvDC/BBy9cKKGK86pK1KqKt9yPaQGwmh1+pUQisp4lH6+ccNGliBBByhYVThQhkwmoN4=
X-Received: by 2002:a17:907:971a:b0:a37:1778:7d7f with SMTP id
 jg26-20020a170907971a00b00a3717787d7fmr1914343ejc.29.1706895675962; Fri, 02
 Feb 2024 09:41:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202163433.786581-1-abrestic@rivosinc.com>
 <20240202163433.786581-3-abrestic@rivosinc.com> <CAMj1kXH7=9-Ww_z6a4Z5K8MrbH8x17Y3EzYk9Qf-3PL-JgMcww@mail.gmail.com>
In-Reply-To: <CAMj1kXH7=9-Ww_z6a4Z5K8MrbH8x17Y3EzYk9Qf-3PL-JgMcww@mail.gmail.com>
From: Andrew Bresticker <abrestic@rivosinc.com>
Date: Fri, 2 Feb 2024 12:41:04 -0500
Message-ID: <CALE4mHq4KhfBd+n2waUpHt48fTRXdBWZyiEJf5a3=hfUA_ue3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: Don't add memblocks for unusable memory
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:45=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 2 Feb 2024 at 17:34, Andrew Bresticker <abrestic@rivosinc.com> wr=
ote:
> >
> > Adding memblocks (even if nomap) for such regions unnecessarily consume=
s
> > resources by creating struct pages for memory that may never be used or=
,
> > in the case of soft-reserved regions, prevents the memory from later
> > being hotplugged in by dax_kmem. This is also consistent with how x86
> > handles unusable memory found in the EFI memory map.
> >
>
> x86 doesn't care as much about memory vs device semantics as ARM does.
>
> This affects the output of memblock_is_[region_]memory(), so we'd have
> to double check that none of those uses get broken by this.
>
> If the soft reserved regions need to be omitted from memblock, we can
> deal with that separately perhaps, but changing it at this level seems
> inappropriate to me.

Sure, I can constrain this to just the soft-reserved regions.

-Andrew

>
>
> > Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> > ---
> >  drivers/firmware/efi/efi-init.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi=
-init.c
> > index d4987d013080..f05bacac89b7 100644
> > --- a/drivers/firmware/efi/efi-init.c
> > +++ b/drivers/firmware/efi/efi-init.c
> > @@ -24,13 +24,6 @@
> >
> >  unsigned long __initdata screen_info_table =3D EFI_INVALID_TABLE_ADDR;
> >
> > -static int __init is_memory(efi_memory_desc_t *md)
> > -{
> > -       if (md->attribute & (EFI_MEMORY_WB|EFI_MEMORY_WT|EFI_MEMORY_WC)=
)
> > -               return 1;
> > -       return 0;
> > -}
> > -
> >  /*
> >   * Translate a EFI virtual address into a physical address: this is ne=
cessary,
> >   * as some data members of the EFI system table are virtually remapped=
 after
> > @@ -195,12 +188,9 @@ static __init void reserve_regions(void)
> >                 memrange_efi_to_native(&paddr, &npages);
> >                 size =3D npages << PAGE_SHIFT;
> >
> > -               if (is_memory(md)) {
> > +               if (is_usable_memory(md)) {
> >                         early_init_dt_add_memory_arch(paddr, size);
> >
> > -                       if (!is_usable_memory(md))
> > -                               memblock_mark_nomap(paddr, size);
> > -
> >                         /* keep ACPI reclaim memory intact for kexec et=
c. */
> >                         if (md->type =3D=3D EFI_ACPI_RECLAIM_MEMORY)
> >                                 memblock_reserve(paddr, size);
> > --
> > 2.34.1
> >

