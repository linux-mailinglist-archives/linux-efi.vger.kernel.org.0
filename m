Return-Path: <linux-efi+bounces-5607-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 923C3C6B791
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 20:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D307F29EC9
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 19:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E724A2E1F05;
	Tue, 18 Nov 2025 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGLXHUUN"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19642D979B
	for <linux-efi@vger.kernel.org>; Tue, 18 Nov 2025 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494917; cv=none; b=iy4dy3GBkyY5xxju+TOKhjEeoW0+6XLiJ8wNhfB6fMq79cwTEXW9otvfDqNW6wKn+pEzCu03UDvtQykc2Wr8OU2hC3uatVbt7wZrfAn2yFkMaAnFYwp4/cwh4sR6hbAU7fP0ye3c89alZPuFXhTJBvn/XRhTVxhHco0CHg/XbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494917; c=relaxed/simple;
	bh=O4u0xKjB+4s0Wx1bDdt/I2ekbZcKY37riMw8RCIUqjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvi3/+T+xlU126lcLv3Ma9p3KI1AifiY2v/i2EkXWtqHbqTKxxOgY/nhVeFjxyH+ZgjgvCUeZg+d+vGqjxjWANEobAwXL6YGOsdV/NGj2SaENhz7nwiyNgjBvnKBXeSNRUDJia+6Tj0p1gcR3VXOSVxaZ347zroQa9B0jASjpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGLXHUUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B157C2BCB7
	for <linux-efi@vger.kernel.org>; Tue, 18 Nov 2025 19:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763494917;
	bh=O4u0xKjB+4s0Wx1bDdt/I2ekbZcKY37riMw8RCIUqjs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mGLXHUUNB20NDwtDtfCEGu1vDLcEscIi6eLocV6ANR3FJqyUYtDLntCmggrpPguh+
	 9O2K05zbkdAzYiQVABtAqtwTvqGfqp9YwQRKGaoZ/xXFp6R/EgvnaOYi9v/99u3FVB
	 JQA3EOKiiLhI6YqnYz1QpjKzDkIWIlGQQCAtXJXz1H1Yv+fQ+4Yy4+FUklp02QCeBc
	 T/QO90ta6R47zr//qZAimPtSPOW4fS/reY0sQrhW7yRUJMQDmjgXc9JEVdJ9C4ZbP+
	 SUqAYJEGJB1lu/9KjQznkDmsQC71hjS9Y/G2SBzynHT55v3+vBzoDYBrsgv+FA00gd
	 ZGAulyA4IuUOg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-591c9934e0cso8020897e87.0
        for <linux-efi@vger.kernel.org>; Tue, 18 Nov 2025 11:41:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOLi1UUWdCSSOEP9glyzHl+VYM1ezBPfAgB6Ze1sB70oAKOAAHnP2AVer/PE6nBUG1DCmQq3dWa94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoifRzBofSb/Xpl/ymCA8qdX2M8Z26+FH4N3w4m77ySuJxCCug
	ORvdO/t+Y7KuT+K3zNehmhCORFVKQ/pByqMqRMfSVKaCIrMAWaa+5E3+zFAH+iQFTsw3BKC5jR/
	r/G3UVL1WMXilrTUyds3rK9Kz5aQwEcI=
X-Google-Smtp-Source: AGHT+IGKcHBNVAZHh0LRgoDGqBr/E9/d22wv+apDO28LtFrblSsU53zE8MytU3Vozln6fueen3TLYkJ9hh0/q2pjjQg=
X-Received: by 2002:a05:6512:ba3:b0:592:fb0e:cf17 with SMTP id
 2adb3069b0e04-595841f0b66mr6050506e87.34.1763494914536; Tue, 18 Nov 2025
 11:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015160816.525825-1-tzimmermann@suse.de> <CAMj1kXF62pEMUJAM12HnF7qMt5xhZaZXpPoMdebMUKCfoAYisQ@mail.gmail.com>
 <b6801420-6ae4-44cb-9d86-e9353a2a59d8@suse.de> <CAMj1kXHKc4jJnQ9x+sUhAO54PeZ6QN6yzcHVTovGvunp2QYnDA@mail.gmail.com>
In-Reply-To: <CAMj1kXHKc4jJnQ9x+sUhAO54PeZ6QN6yzcHVTovGvunp2QYnDA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Nov 2025 20:41:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEg2PKHJSnko8eFz8fVRDZYTuUYfKCD+jYwuFr=oaUiOg@mail.gmail.com>
X-Gm-Features: AWmQ_bmcXzwvPbFyhYsZVuhr3-JvV70JUybAQ3Px2Zk2AbvQ9X1B63PzFXW3Uig
Message-ID: <CAMj1kXEg2PKHJSnko8eFz8fVRDZYTuUYfKCD+jYwuFr=oaUiOg@mail.gmail.com>
Subject: Re: [PATCH 0/5] efi: x86: Provide EDID from GOP device
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jonathan@marek.ca, javierm@redhat.com, linux-efi@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Nov 2025 at 17:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 17 Nov 2025 at 09:02, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Hi
> >
> > Am 14.11.25 um 09:31 schrieb Ard Biesheuvel:
> > > On Wed, 15 Oct 2025 at 18:08, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > >> Add support for EFI_EDID_ACTIVE_PROTOCOL and EFI_EDID_DISCOVERED_PROTOCOL
> > >> on x86. Refactor the GOP helpers for EDID support, then retrieve the EDID
> > >> into x86 boot_params.
> > >>
> > >> Later boot code copies the EDID from the boot parameters into the global
> > >> variable edid_info. Graphics drivers, such as efidrm, can pick up the
> > >> information from there. In the case of efidrm, it provides the EDID to
> > >> user-space compositors, which use it for improved QoS on the display
> > >> output. Similar functionality is already available on old VESA systems
> > >> with vesadrm.
> > >>
> > >> Tested on x86 EFI systems.
> > >>
> > >> Another patch is required to provide EDID on non-x86 systems via the
> > >> generic EFI stub. The implementation can directly build upon this
> > >> series.
> > >>
> > >> Thomas Zimmermann (5):
> > >>    efi: Fix trailing whitespace in header file
> > >>    efi/libstub: gop: Find GOP handle instead of GOP data
> > >>    efi/libstub: gop: Initialize screen_info in helper function
> > >>    efi/libstub: gop: Add support for reading EDID
> > >>    efi/libstub: x86: Store EDID in boot_params
> > >>
> > > Hi,
> > >
> > > Apologies for the delay. This series looks fine to me, although I
> > > would prefer it if we could make things a bit more generic?
> > >
> > > Everything you are adding here is arch-agnostic, except for the bit
> > > where we use x86-specific plumbing to pass the EDID info between the
> > > EFI stub and the core kernel.
> >
> > Attached is an RFC patch that I already have. This would be the next
> > step for EDID support. I've not yet sent the generic-EFI patch, as I did
> > not have opportunity to test it. The patch addresses most of what you
> > ask for, I think.
> >
> > >
> > > More specifically, could we do the following:
> > > - move struct edid_info edid_info into common code
> >
> > edid_info is related to screen_info, so it follows the same conventions.
> > Arnd Bergmann made x86-specific changes for screen_info in commit
> > b8466fe82b79 ("efi: move screen_info into efi init code"). x86 has it's
> > own thing, sort of. See the attached patch for my non-x86 solution.
> >
> > > - pass the detected EDID info block via a EFI config table instead of
> > > boot_params
> >
> > The x86 code uses boot params for screen_info already and also transfers
> > edid_info on VESA systems via boot params (or if grub set up boot_params
> > for us). [1] It's all there and working already. If we transfer
> > edid_info via config table, we'd need extra code on x86.
> >
>
> I understand the x86 already uses edid_info for non-EFI boot, but that
> doesn't mean we have to introduce new dependencies on legacy bits like
> boot_params to the EFI stub.
>
> For generic EFI, I don't think it is necessary to clone all the config
> table logic with GUIDs and stuff. Instead, given that the EFI stub is
> tightly coupled with the kernel anyway, we can just decide that the
> config table has both a screen_info and a edid_info struct, and the
> generic EFI code consuming the config table populates both.

I've queued this up for now so it can soak in -next for a bit, but
please let's not leave non-x86 behind here.

