Return-Path: <linux-efi+bounces-1865-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527898B560
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 09:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B763C1C22E63
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 07:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B281BD03F;
	Tue,  1 Oct 2024 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sT53d+2b"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3631BC9F3
	for <linux-efi@vger.kernel.org>; Tue,  1 Oct 2024 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767237; cv=none; b=pZWwGPVFdHXm9gj8xb7q1Kx6iLN4CmDVPHycb7f6BqmHae24jX/frCo4qGudXJjvN5ppOe4yjluW9J7kyBXLMMuFG4D5XO76ekcIDnbxkisuCFy4m/MORX7bqbnhHKJulhqt5gMnZxXJ9Rn6yaZDuS0KHyjJkByU/sbd9gl7mSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767237; c=relaxed/simple;
	bh=5h8Z9+BACu6Y3g4BqrqeNxuHtGeeYVN06us7lRCHW7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWGPe6kqRPnYlz6EUzLY7h4mT7uCjj+i7amVY0oMl7dwNmOsiBqrHPFgiiGJzCKYoVKCmSFDYIo3rZGmEKLvDG1ut4Wg4HDRq5kJN7wggVAy5vwcyNcZhhBW3etu3NLJR/yo2yvf/nLxztg3GFGiAKQYafwmtHkQgTEuzZNsXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sT53d+2b; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db233cef22so4326704a12.0
        for <linux-efi@vger.kernel.org>; Tue, 01 Oct 2024 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727767235; x=1728372035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UrfZZcBE4IBwNjE75QjsQfrwHNd7APgRNgH7YZ+uNQ0=;
        b=sT53d+2b4wl66gVVGo1dztMu2nXjNp696yj8APAPs5pJ36PggldLgoxXmCF6K05yMi
         sq1pReyhGKgWg/4U81uPIA88HLBvYc2M+9vMsFukzcOtsLS9gdFU03e7wW6p+r/UUxpK
         pdrC2/63rTItz6pKT0NP8kaOFAEe0nGYra8lrrKgNc53eKQ1WiCn7EO1EVwtUOYm/gex
         uK60qqfrbGe7flCIq5dkgbH662O/xUxnKPC0QkMjUXRvdY+b/8BgPHn3wVDSGzps6+cS
         iKrXr6/AN/h9Ri/sg1DOjgoUUV0KaMbyBhh4Ol0dT90BwAE7y0UqPx1o3y8JQ7za6yya
         SKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727767235; x=1728372035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrfZZcBE4IBwNjE75QjsQfrwHNd7APgRNgH7YZ+uNQ0=;
        b=lPqDfx48gVsromSMV1gsqgmeskSifV0DdtONT1zHpHilgV2OVBBNQLYguYDXQ5bDNz
         RjnsON/vNgw5QIa/xowU24WQEz8zFubSKdCRM7h4jMhl3sUoH9MoE7GF5NdRWuwNVXIQ
         2n46BLgcD2OLijmekoqSfl4CM9AhBPs23Z36psZjg3+45uvHfnz3WtELbdD4FaoTkKsk
         9+LKuimFQ5AsHWfkgYbhb0qShu7ttFR7Ld25vuwxsYLITvhMYIW0p7jd2TePoNyYD6Zm
         YXR36LQnZluzycyYLBWr1Qs72GwzMeT/jzjyZz2gbKwFGrBl0+yFfCBhbxoj8adnAHnQ
         JjkQ==
X-Gm-Message-State: AOJu0YyKD97xEfrvuheaU0k2o3lPdM5td9i4Umzm28OFjU4lruFI0pNK
	Q8deHPrbZmP1XZMn8C7BAxjK5kXXFq6mt620ju76fMHwYRoGC3420sBgIZc9VZ6PZ3u8YFsDKeD
	Dtc8lXKEdag7qP5QB/GaEIW6PqRiCWWHChjuWhQ==
X-Google-Smtp-Source: AGHT+IGn8cW3SYdd4w+T6U3zSQ2meHeHsO/ArsiB4LHjAKN+D9s9kXmEsbXtdSFt9b/qhWf0WXYGZa6s56q0/kV5jmo=
X-Received: by 2002:a05:6a21:3389:b0:1d4:fc75:8d48 with SMTP id
 adf61e73a8af0-1d4fc758d9fmr23325457637.3.1727767235462; Tue, 01 Oct 2024
 00:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001032028.483199-1-jeremy.linton@arm.com> <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Oct 2024 10:19:59 +0300
Message-ID: <CAC_iWjJH8JwdPbL9Et6xNLf4vV1AQDm8ZZh8zYVkb+VFLXedTg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: measure initrd to PCR9 independent of source
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, bp@alien8.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org, 
	Jeremy Linton <jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"

Thanks, Ard

On Tue, 1 Oct 2024 at 08:59, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Ilias)
>
> On Tue, 1 Oct 2024 at 05:20, Jeremy Linton <jeremy.linton@arm.com> wrote:
> >
> > Currently the initrd is only measured if it can be loaded using the
> > INITRD_MEDIA_GUID, if we are loading it from a path provided via the
> > command line it is never measured. Lets move the check down a couple
> > lines so the measurement happens independent of the source.
> >
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  drivers/firmware/efi/libstub/efi-stub-helper.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index de659f6a815f..555f84287f0b 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -621,10 +621,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> >         status = efi_load_initrd_dev_path(&initrd, hard_limit);
> >         if (status == EFI_SUCCESS) {
> >                 efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> > -               if (initrd.size > 0 &&
> > -                   efi_measure_tagged_event(initrd.base, initrd.size,
> > -                                            EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> > -                       efi_info("Measured initrd data into PCR 9\n");
> >         } else if (status == EFI_NOT_FOUND) {
> >                 status = efi_load_initrd_cmdline(image, &initrd, soft_limit,
> >                                                  hard_limit);
> > @@ -637,6 +633,11 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> >         if (status != EFI_SUCCESS)
> >                 goto failed;
> >
> > +       if (initrd.size > 0 &&
> > +           efi_measure_tagged_event(initrd.base, initrd.size,
> > +                                    EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> > +               efi_info("Measured initrd data into PCR 9\n");

Back when we added this we intentionally left loading an initramfs
loaded via the command line out.
We wanted people to start using the LoadFile2 protocol instead of the
command line option, which suffered from various issues  -- e.g could
only be loaded if it resided in the same filesystem as the kernel and
the bootloader had to reason about the kernel memory layout.
I don't think measuring the command line option as well is going to
cause any problems, but isn't it a step backward?

Thanks
/Ilias
> > +
> >         status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(initrd),
> >                              (void **)&tbl);
> >         if (status != EFI_SUCCESS)
> > --
> > 2.46.1
> >

