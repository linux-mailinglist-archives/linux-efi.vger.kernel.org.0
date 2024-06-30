Return-Path: <linux-efi+bounces-1319-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C738691D104
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 12:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56EA61F2151E
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F812C49B;
	Sun, 30 Jun 2024 10:02:16 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E72C6BD;
	Sun, 30 Jun 2024 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719741736; cv=none; b=fQV89nT5x7RrHq9rI/0GcUVUnf3hzt9TjKAe0r+Hp8F8587NTP9vBjHGTuqbP0hL7YiriaWgFn/AM5g/pBVn5Rh1j+vATEePlH6XlgWFJtEzJI5FAm33FmywolsL0jibDEjrot5rdlZ6ivMZ5T6hFT3syQQWi18TeUM4m4YmC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719741736; c=relaxed/simple;
	bh=RY2gjv1yXfwN5K8FDIl8+sx/uOjU3+I+cP7/CtnagEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ3cYDnvZRWEK37GG5y2i7qx1sYa+3B5qq3nnVkjPdz65JAwF2zegSSEgz+Oma97lfg1qZ6FmW18Eg5tbAv/xpV/6ZN0rSYB7NlwOKvI2+s7fcUS74D7WewOkilKAMiNrbJTnlp6Ud6NccYjgt4+HT4YM85wrm2hlY9wCSHXess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id EF8872800B1BB;
	Sun, 30 Jun 2024 12:02:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CDCF01EA3A5; Sun, 30 Jun 2024 12:02:03 +0200 (CEST)
Date: Sun, 30 Jun 2024 12:02:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <gargaditya08@live.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>,
	Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH] efi: libstub: add support for the apple_set_os protocol
Message-ID: <ZoEtG0DUJOS4ROQC@wunner.de>
References: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com>
 <ZoERl1PWoc2xDGWz@wunner.de>
 <MA0P287MB021730971A804FB760463A39B8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB021730971A804FB760463A39B8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>

On Sun, Jun 30, 2024 at 09:13:33AM +0000, Aditya Garg wrote:
> > On 30 Jun 2024, at 1:34 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Sun, Jun 30, 2024 at 04:42:55AM +0000, Aditya Garg wrote:
> > > Based on this patch for GRUB by Andreas Heider <andreas@heider.io>:
> > > https://lists.gnu.org/archive/html/grub-devel/2013-12/msg00442.html
> > 
> > Please include his Signed-off-by and cc him.
> 
> Not sure about this since the patch was send to grub and not lkml,
> and his work has been used without informing him for this patch solely
> on the basis of GPL.
> 
> I've always been confused in signed-off-by in case of authors whose work
> has been used without their explicit consent just because the license
> permits it.
> 
> Should I still add his signed-off-by?

I would.


> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -399,6 +399,8 @@
> > >                  useful so that a dump capture kernel won't be
> > >                  shot down by NMI
> > > 
> > > +    apple_set_os    [KNL] Report that macOS is being booted to the firmware
> > > +
> > 
> > Why the kernel parameter?  Why not do this unconditionally?
> 
> 1. Not all Macs have dual GPU. We don't want to unnecessarily "fool"
> the firmware in thinking macOS is being booted.
> 2. apple-gmux is a reverse engineered driver, although upstreamed,
> not very efficient in switching GPUs. So it's better to make unlocking
> the GPU optional. + not everyone wants the intel GPU, people are happy
> working with the dedicated AMD GPU (used by default if apple_set_os
> isn't enabled).

So my opinion is that these aren't good arguments.  We should be
identifying as Darwin by default in EFI, just as we've been doing
in ACPI since 7bc5a2bad0b8.  If there are any adverse effects,
we should look into them, but users shouldn't be forced to set
an obscure kernel parameter only to enable certain features of
their hardware.  It is for this reason that you'll usually get
Greg KH's trademark "this isn't the 90s anymore" comment when
adding new kernel parameters.  We need to handle the hardware
correctly *automatically*.

There is one known issue affecting the keyboard on certain
MacBook Air models:  Apple had been using dual SPI and USB
keyboards and trackpads since about 2013 but started to ship
SPI-only models in 2015 with the MacBook 12".

The models that shipped in the 2013/2014 time frame used USB
by default and were automatically switched to SPI if apple_set_os
is invoked.  Not a problem since drivers/input/keyboard/applespi.c
has been in mainline for a while now, but there are some very
specific models that lack certain data in the DSDT which the
applespi.c driver needs:

https://github.com/cb22/macbook12-spi-driver/issues/65

However at this point that shouldn't stop us from making
apple_set_os the default.  We should rather just try to amend
the applespi.c driver with a DMI quirk or something.
That requires someone to test patches, so we need to find
someone with an affected machine before we can fix it.

But potential issues with 10+ years old hardware shouldn't
stop us from enabling a feature by default that's useful on
more recent hardware.  So I'm strongly in favor of getting rid
of the kernel parameter and then let's work on addressing side
effects of apple_set_os one by one.


> > > +struct apple_set_os_protocol {
> > > +    u64 version;
> > > +    efi_status_t (__efiapi *set_os_version) (const char *);
> > > +    efi_status_t (__efiapi *set_os_vendor) (const char *);
> > > +    struct {
> > > +        u32 version;
> > > +        u32 set_os_version;
> > > +        u32 set_os_vendor;
> > > +    } mixed_mode;
> > > +};
> > 
> > How about declaring this __packed, just to be on the safe side?
> You mean "struct __attribute__((__packed__)) apple_set_os_protocol {" ?

Just add __packed at the end of the declaration.
See efi_manage_capsule_header in include/linux/efi.h for an example.

I think we haven't been very consistent with __packed declarations.
The rationale not to use them everywhere is probably that gcc generally
doesn't insert padding if only 32-bit and 64-bit types are used,
but that's not guaranteed to be true forever.


> > 
> > Why "mixed_mode"?  Seems like an odd name given "mixed mode"
> > in EFI context usually means 64-bit OS, but 32-bit EFI.
> 
> EFI firmware on T2 Macs doesn't seem to follow the standard EFI specs
> (expected from Apple). Earlier it claimed to follow EFI 2.0, but we
> had to force linux to use EFI 1.1 for it. So as far as Apple is
> concerned, you'll get to see such strange things.
> 
> I guess this strange behaviour is because the T2 security chip handles
> the EFI.

I don't quite follow.  Andreas' grub patch doesn't have this
"mixed_mode" struct, so where is it (and the name) coming from?

Thanks,

Lukas

