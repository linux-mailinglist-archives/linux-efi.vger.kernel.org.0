Return-Path: <linux-efi+bounces-881-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3682D88ADA9
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 19:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8C2B2EDDD
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB0F12CDAA;
	Mon, 25 Mar 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSeRjP13"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95366B56;
	Mon, 25 Mar 2024 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388521; cv=none; b=YO31o/Hpr/UDHM4AtYNVV+64Aodx8vMqdoF6MpD2kfNZ7R024VrqHIKQJ/odK18S+A0dpq2HI+QAw6ssjUMahTxMyMCJo571+2bMlH1QY7MAW4W/3UwhOh5LjsCVwGHf7fEvfzPt8tHueOz8f5DEUWCc2Tc5zoEjo8hqUxVeW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388521; c=relaxed/simple;
	bh=GkqZQTc6xFfq4AFBhSlQmqbD3gwDhQPGpPNr+/ScS3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+loJOktbGkCMdyPOZfjz30g0QKVyyouHGl1NlJwk97/WsUOlCPxwtPL1xQhcq21vARyGXGVksM3Z3nzKYvnJ5LBqTZUh+XbriJclSBzoc17/b1l45p+citiJ7doR3IqkgTWUXgnfBpj8kRRhEbPPNkvTe4rY6fW2FLzNjpQpLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSeRjP13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E6FC43390;
	Mon, 25 Mar 2024 17:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388520;
	bh=GkqZQTc6xFfq4AFBhSlQmqbD3gwDhQPGpPNr+/ScS3c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HSeRjP13D8igM+K0ns0ZSPPQJmz1R1xIkZ3P6MdrVlc5rO/ZAJ1Uq20y/giNfjuNw
	 4I6ie7v3BzqjFxgYHcZuJ5GrzboQH/gZwTbGurzC2CgMACx/3v5yIsMPnJ0SXdFyXd
	 HHMsr8SgV9FrPOQNd7KZFDG8uE9Af9/y3SfKcUoIXoZhltlEA8aCLTl1Wo4QS0EJY8
	 pN8iCFZ0vFZd0liP/qz9S9aPDLS61WqkhDNIaufQaXzmExtS1oGDcy4JNgH0zpdEMD
	 AFNzsHYv3w3cu8IkBPTjWEBzGxVCa8UOe2fXwMWU1RA01AdpwfD6twFI0aqiA6N3vj
	 L9I6PKrkFeK5Q==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d48ba4d5ecso51267231fa.1;
        Mon, 25 Mar 2024 10:42:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVT6SkbwRbZmDMy9p7LBqofibtXrh4BSuYyJ3OPW7DIYTR5vT6BQSxwK+TxhGUwjy1UjqH7pwANTZ6+1NOMtvO9A9iLRhXtQ+kVriB3qWF0CA2JuT7nmPmMrvYm3lBb8mNbr7GF7fFu
X-Gm-Message-State: AOJu0YxodQiMz/v8WenUWXGrXwIjPQuUuangjhpY0Rs01+n2Qao6RrKJ
	PEr/uRyFIhloW8ZZX+W9Ghn1fWXXjrTquip+quWUdksFGx3ONPWTNxpgiT18S5QHjiYurJSn1+o
	hgMFeIm2uGWz+fZCS2vfzNNCloc8=
X-Google-Smtp-Source: AGHT+IGV+kKuo+pA0XGm/aFf/KK2YAwYBlFP6cUVMlkA7svZ+a9Wq/iBXoxmfIi3k0dbFoN31aGa+FSSFU2X4fLWmTA=
X-Received: by 2002:a2e:b0ef:0:b0:2d4:535a:e7a with SMTP id
 h15-20020a2eb0ef000000b002d4535a0e7amr2344870ljl.24.1711388519157; Mon, 25
 Mar 2024 10:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325083905.13163-2-ardb+git@google.com> <5b32b8c8-0a1b-44cf-aedf-cca1d6c83bd8@redhat.com>
 <20240325103912.GB6076@craftyguy.net>
In-Reply-To: <20240325103912.GB6076@craftyguy.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 25 Mar 2024 19:41:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE5aunV5RkoDtpSxdmEi+EVB-7_SsdT7+naBwbYb2BxSA@mail.gmail.com>
Message-ID: <CAMj1kXE5aunV5RkoDtpSxdmEi+EVB-7_SsdT7+naBwbYb2BxSA@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: Add missing boot_params for mixed mode
 compat entry
To: Clayton Craft <clayton@craftyguy.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 19:39, Clayton Craft <clayton@craftyguy.net> wrote:
>
> On Mon, 25 Mar 2024 14:18:01 +0100 Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi,
> >
> > On 3/25/24 9:39 AM, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > The native EFI stub entry point does not take a struct boot_params from
> > > the boot loader, but creates it from scratch, and populates only the
> > > fields that still have meaning in this context (command line, initrd
> > > base and size, etc)
> > >
> > > The original mixed mode implementation used the EFI handover protocol,
> > > where the boot loader (i.e., GRUB) populates a struct boot_params and
> > > passes it to a special EFI entry point that takes the struct boot_params
> > > pointer as the third argument.
> > >
> > > When the new mixed mode implementation was introduced, using a special
> > > 32-bit PE entrypoint in the 64-bit kernel, it adopted the usual
> > > prototype, and relied on the EFI stub to create the struct boot_params
> > > as usual. This is preferred because it makes the bootloader side much
> > > easier to implement, as it does not need any x86-specific knowledge on
> > > how struct boot_params and struct setup_header are put together.
> > >
> > > However, one thing was missed: EFI mixed mode goes through startup_32()
> > > *before* entering the 64-bit EFI stub, which is difficult to avoid given
> > > that 64-bit execution requires page tables, which can only be populated
> > > using 32-bit code, and this piece is what the mixed mode EFI stub relies
> > > on. startup_32() accesses a couple of struct boot_params fields to
> > > decide where to place the page tables.
> > >
> > > startup_32() turns out to be quite tolerant to bogus struct boot_params,
> > > given that ESI used to contain junk when entering via the new mixed mode
> > > protocol. Only when commit
> > >
> > >   e2ab9eab324c ("x86/boot/compressed: Move 32-bit entrypoint code into .text section")
> > >
> > > started to zero ESI explicitly when entering via this boot path, boot
> > > failures started to appear on some systems, presumably ones that unmap
> > > page 0x0 or map it read-only.
> > >
> > > The solution is to pass a special, temporary struct boot_params to
> > > startup_32() via ESI, one that is sufficient for getting it to create
> > > the page tables correctly and is discarded right after. This means
> > > setting a minimal alignment of 4k, only to get the statically allocated
> > > page tables line up correctly, and setting init_size to the executable
> > > image size (_end - startup_32). This ensures that the page tables are
> > > covered by the static footprint of the PE image.
> > >
> > > Given that EFI boot no longer calls the decompressor and no longer pads
> > > the image to permit the decompressor to execute in place, the same
> > > temporary struct boot_params should be used in the EFI handover protocol
> > > based mixed mode implementation as well, to prevent the page tables from
> > > being placed outside of allocated memory.
> > >
> > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > Fixes: e2ab9eab324c ("x86/boot/compressed: Move 32-bit entrypoint code into .text section")
> > > Closes: https://lore.kernel.org/all/20240321150510.GI8211@craftyguy.net/
> > > Reported-by: Clayton Craft <clayton@craftyguy.net>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > I have given this a test run (on top of 6.9-rc1) on one of my
> > Bay Trail mixed mode tablets and the tablet still boots fine:
>
> I did the same test (with 6.9-rc1) on my Bay Trail tablet & NUC that failed
> previously, and this fixes booting with EFI mixed mode on them.
>
> Tested-by: Clayton Craft <clayton@craftyguy.net>
>

Thanks for testing again.

I'll get this to Linus in the next week or so, and the fix should make
its way back through the stable trees in the following weeks.

