Return-Path: <linux-efi+bounces-1744-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB4597854B
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 17:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F452814DC
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C55A61FEA;
	Fri, 13 Sep 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsI4/Nww"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3999C55898;
	Fri, 13 Sep 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243170; cv=none; b=SREZPNDao3m1vhM8asOaklndV7ijDEyp1zfRuAeE0MN42vQ7Wuig2jObdFGeh+iMogyqpQ7ZqLSJvLnZdtuFS8uehVvvV2fEqQZBmJwUFEBW06RojB/Ylqp3bri3wTq5jvAVzwf9oRM3KpZuczf4JvdYWOmeB9MIHixcgVN5MoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243170; c=relaxed/simple;
	bh=Qyky0zXuUqwYjIw0vi5NvkWsVijW6mKMmsqvzr0+JH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgqQcVD4IAq4t9XWiM6CXDLMfTnERIPSIaHHVCbUfUB6LpE4oOur4pFGjIhjSU4ZObeONmVRBEEebgfegkXrgPMYIULvp7bcHrMSslEM7MCTLemsJr38j+tksdwo6lJLliUp+DX+B1g0rsNAjPROJ4qrq675QYIw4c2p2mJYIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsI4/Nww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1405C4CECC;
	Fri, 13 Sep 2024 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726243169;
	bh=Qyky0zXuUqwYjIw0vi5NvkWsVijW6mKMmsqvzr0+JH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FsI4/Nwwyd8rGCbUqhS+ip1DgegqvMxLve9nyg3MmaaDylkFKUNTocCLeeYJsc9ts
	 VXKNm54h88/RsCdAvYGnXDumkxcsH9ELEr75BQQ3YsxUd98yvAkgwHlX83/zaOU9uY
	 6WO0TiTW184GE8nRNCTE0ez6XXRpthwedlL2oZ07frbGfVXrIHI6awSpBWyEjHF4Yp
	 MUOgQ4/grwOx+qv5beECHlF/b9KGc3YYcu6vtVOcKAgfC/qGPmp+3ppMQIeVeT5f7n
	 mqEpBEfoW3qkiAXNZJMeP3NLbYxNrx2UeIA6UkL5wXtuW825PXDPSvIurJRQkvV3sf
	 PMWg3T4omAESw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so14460721fa.0;
        Fri, 13 Sep 2024 08:59:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlip/33N2qWyXQxmBHKPWSKN72D995ZamHz+2zM9FX1zykxR4Vn+PZ+6H6917CZ4xGodsHIJ4P9jNMr4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvK49YCddRf0S9X789ch5BCMMla/726MzeI+PyHwcNomvSUfGP
	qg24FDUCatTg+V1PlWmKcZtjwt3dtvR1LiL22XlIYQYshizgPDb7WllAj9/AbfLkrOWwK//axHo
	wX80OtKu8OUCsh9G7iVDAB7dWGao=
X-Google-Smtp-Source: AGHT+IEaINq+GsL2rbNA8J5TttkBIflZt4HAuWjKqYhaK3xcu5NkRyMA4t9IdI18gmHYJA2iOu2957Fd16QUc1SPQZs=
X-Received: by 2002:a2e:a544:0:b0:2f6:5df8:bfcb with SMTP id
 38308e7fff4ca-2f791b5a8c8mr20810791fa.38.1726243168189; Fri, 13 Sep 2024
 08:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-7-gourry@gourry.net>
 <CAMj1kXHRkDCnUCjBR17jSCwceGT8fyE_WdERmVpYY7c6eBsgFA@mail.gmail.com> <ZuRaT75h0wcopILx@PC2K9PVX.TheFacebook.com>
In-Reply-To: <ZuRaT75h0wcopILx@PC2K9PVX.TheFacebook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Sep 2024 17:59:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHEH5PE=7swKMJUP-gTAuyoJH5E8NL+RuFnMceF=MpoWQ@mail.gmail.com>
Message-ID: <CAMj1kXHEH5PE=7swKMJUP-gTAuyoJH5E8NL+RuFnMceF=MpoWQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] libstub,tpm: do not ignore failure case when reading
 final event log
To: Gregory Price <gourry@gourry.net>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org, 
	usamaarif642@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 17:30, Gregory Price <gourry@gourry.net> wrote:
>
> On Fri, Sep 13, 2024 at 05:25:27PM +0200, Ard Biesheuvel wrote:
> > On Fri, 6 Sept 2024 at 22:28, Gregory Price <gourry@gourry.net> wrote:
> > >
> > > Current code fails to check for an error case when reading events from
> > > final event log to calculate offsets.  Check the error case, report the
> > > error, and break early because all subsequent calls will also fail.
> > >
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > ---
> > >  drivers/firmware/efi/libstub/tpm.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> > > index 4f9f0e049a7a..c71b0d3e66d2 100644
> > > --- a/drivers/firmware/efi/libstub/tpm.c
> > > +++ b/drivers/firmware/efi/libstub/tpm.c
> > > @@ -124,6 +124,10 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
> > >                         event_size = __calc_tpm2_event_size(header,
> > >                                                    (void *)(long)log_location,
> > >                                                    false);
> > > +                       if (!event_size) {
> > > +                               efi_err("Invalid TPM Final Event Log Entry\n");
> > > +                               break;
> > > +                       }
> >
> > I don't object to this in principle, the only problem is that these
> > log prints are not recorded anywhere: they are printed to the EFI boot
> > console by the EFI stub, which may not even be visible, and is
> > definitely not captured by the kernel logging routines.
>
> Could simply drop the err and break if you think it's just going to get
> lost anyway.  Not sure there's a good way to generate a signal at this point.
>

Yeah. For the record, I absolutely detest the kludgy code there, how
we parse the map, parse and unmap the event header for every entry in
the log.

So while I highly appreciate the effort you are putting in to polish
this code, I wonder if it wouldn't be better to code this up properly
instead.

