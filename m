Return-Path: <linux-efi+bounces-1325-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEB391D16E
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 13:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FA4280D5F
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DEA13AA35;
	Sun, 30 Jun 2024 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAgDs0qv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7C28DC1;
	Sun, 30 Jun 2024 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719746969; cv=none; b=qjKfRuBBzfmvBzn9wBot11Lli03eZPX6sMyvwZ9QIsxGZIcEgUci71w44DMhTTYWbHndwg/TxYnp8PSbr//GIaieiB3NZaIRa/+dgZBSFQD5RFHw3nbfcqTEa3iOcLUoNnP46Y7XoziDV2K9mfPLxQuQgMgoVo9qgGf/VMYkdiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719746969; c=relaxed/simple;
	bh=q0ku1/YvLcqEoyOyN52CBTc6RKs1Dh3689XeNRqFatM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyoRQgVwJoOHP/YkwRGrEZ8A+DEFUn5YmSE/ZK0XjmUH4jlBhjOvmyI5AeFtVqe9Qlr1l2QT8gZSALrxzhVutCDo8rg8v++Cgis2WS0FORrnqV8xa7Tw5Ue+xma8JWcKYNgYLJCtqQfVk+o+TthKToAffd9+A26sP3CojDvPkUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAgDs0qv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F2EC4AF0B;
	Sun, 30 Jun 2024 11:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719746969;
	bh=q0ku1/YvLcqEoyOyN52CBTc6RKs1Dh3689XeNRqFatM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MAgDs0qvEQSBpMg0PpgycdR2t9tDt4UKK4BluvziXPr6Sy88XPipuDdtsQ5VhAxT8
	 A0hZ5oD5kPsgfT7/7+2fwR9l97PkY8KrlRpZFh1UWrgFb5Aip4h8xPI9xr5xSImuxb
	 RUJyZjdqscIVx6j2GbI39CCUH2/G76EbjgXonyWu296TtOyvLynLcXUxdEysEqEi2r
	 rTWZrJbKJ/whW72pQMjtx7C8uGoyEqeAaJYm2aUfkE/SqxCeOu4mJo8pW6hyso+Dgu
	 QQ674trSFFiymiQLMIzNlC6e4CVXftRkjysev/QcKrgT+iPUs5X/zbwWTyK4f+f27I
	 UgJz9lMnorAjA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so22085301fa.3;
        Sun, 30 Jun 2024 04:29:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVP1W6k9lCQXH6tDEGGRUfYc5rDoPEVNK0lltv98ea2BrDMx2nqn9m5Ls0DhwFjTyH2fo03OmdXS8ql0zmm1sj4qXongHm7KmYVOHS1eNHIjm7aTVPaLzeFm52Vr+WONaJOcIuwieZa
X-Gm-Message-State: AOJu0Yye04HXSLZSS6xipTq1XLFmRpcf4waUQ3YDKDtvlFOfDpPTJ07u
	5KvLTzNqAAfOStK9YRpKaBT/YIfqb+1HWqMVbAKXNTNrPw0bZ44yFydPr+p0sJUM8HI7Yg2F+99
	PKakkGKjsxBBXQXvC+0gKxM7B3To=
X-Google-Smtp-Source: AGHT+IHnGewgIDG494ajnWz0flNUEWHoYWvq2wMp4QSfE28hwcAUx/teeRHOTO5EaRcRMCiCP1N9aw89M2OJ3Bzem18=
X-Received: by 2002:a05:651c:1a09:b0:2ec:c8:2755 with SMTP id
 38308e7fff4ca-2ee5e3bf179mr25086791fa.24.1719746967478; Sun, 30 Jun 2024
 04:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com> <ZoERl1PWoc2xDGWz@wunner.de>
In-Reply-To: <ZoERl1PWoc2xDGWz@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 30 Jun 2024 13:29:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFEQDir_VffzHZ0uBMjRqEReNdBZcEQs7kFhi=ipM+y9Q@mail.gmail.com>
Message-ID: <CAMj1kXFEQDir_VffzHZ0uBMjRqEReNdBZcEQs7kFhi=ipM+y9Q@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: add support for the apple_set_os protocol
To: Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <gargaditya08@live.com>, Hans de Goede <hdegoede@redhat.com>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>, Kerem Karabay <kekrby@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello Aditya, Lukas,

On Sun, 30 Jun 2024 at 10:04, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sun, Jun 30, 2024 at 04:42:55AM +0000, Aditya Garg wrote:
> > Commit 0c18184de990 brought support for T2 Macs in apple-gmux. But in order to
>
> Please run patches through scripts/checkpatch.pl before submission.
> The subject of the commit is missing here and lines should be wrapped
> at 72 or at least 74 chars.
>
>
> > Based on this patch for GRUB by Andreas Heider <andreas@heider.io>:
> > https://lists.gnu.org/archive/html/grub-devel/2013-12/msg00442.html
>
> Please include his Signed-off-by and cc him.
>
>

No. You cannot simply add a signed-off-by on someone else's behalf,
even if you cc the person.

Andreas contributed code to GRUB (which is a GPLv3 project), and had
no involvement whatsoever in creating this patch.

A signed-off-by is a statement on the part of the contributor (which
may or may not be the author) that the contribution in question
complies with the requirements imposed by the project in terms of
copyright and licensing. Linux is GPLv2 not v3, so this code should at
least be dual licensed in order to be reused directly.

I did not look at the GRUB patch, and IANAL, but this code invokes an
Apple provided protocol (which is proprietary) in a hardcoded way for
interoperability purposes, and so there is not much to
copyright/license anyway. I would be fine with having just your
signoff on this patch, but you could ask Andreas for a GPLv2+3 version
of his GRUB patch if you are not sure.

> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -399,6 +399,8 @@
> >                             useful so that a dump capture kernel won't be
> >                             shot down by NMI
> >
> > +     apple_set_os    [KNL] Report that macOS is being booted to the firmware
> > +
>
> Why the kernel parameter?  Why not do this unconditionally?
>
>

Agree that this is suboptimal. If we need a command line param for
this, please make add it to the efi= list

> > +struct apple_set_os_protocol {

This should be a union not a struct

> > +     u64 version;

This should be unsigned long

> > +     efi_status_t (__efiapi *set_os_version) (const char *);
> > +     efi_status_t (__efiapi *set_os_vendor) (const char *);
> > +     struct {
> > +             u32 version;

... to match the mixed_mode overlay which is u32. Alternatively, they
could both be u64 but the current arrangement is definitely incorrect.

> > +             u32 set_os_version;
> > +             u32 set_os_vendor;
> > +     } mixed_mode;
> > +};
>
> How about declaring this __packed, just to be on the safe side?
>

I don't think that is necessary. If the mixed_mode overlay is never
used, it doesn't really matter and you can use unsigned long vs u32,
in which case all struct members are native word size so there is no
padding issue.

> Why "mixed_mode"?  Seems like an odd name given "mixed mode"
> in EFI context usually means 64-bit OS, but 32-bit EFI.
>

This is how the x86 plumbing works for mixed mode. Every EFI protocol
is a union, with a mixed_mode member describing the 32-bit view. The
accessor macros (efi_bs_call, efi_table_attr) automatically do the
right thing depending on the bitness of the firmware.

This means, though, that even protocols that are known not to exist on
32-bit firmware need to be implemented in the same way, or the code
will not build.

>
> > +static void apple_set_os(void)
> > +{
> > +     efi_guid_t guid = APPLE_SET_OS_PROTOCOL_GUID;
>
> My recollection is that if you don't declare this static const,
> gcc generates suboptimal code.  (It constructs the GUID on the
> stack at runtime instead of storing it in .rodata.)
> Maybe it's become smarter in the meantime, but I doubt it.
>

I don't remember the details but it looks like we stopped doing this a
while ago. I don't mind keeping it like this.

