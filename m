Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20E8172598
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgB0RsJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 12:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgB0RsJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Feb 2020 12:48:09 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16732246A1
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 17:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582825688;
        bh=r57/uzxhx6F527Q1jCnLyD6LKdGxZuBOjgYgGuaL6es=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=orZ1B2H12EHESRAmQjCp9yQ7M32J865Sij+iYYMpaLnLj1DunIAiEtq2qQ5dGcmDC
         qSkVQUyH1XsWFMyMK80IDIwEr9Qf3DEhqPBMXuKKUOIaom72jbLIHbUPxrsya5uLwV
         VuAY6juO68gmeNQ9g+n8CzMqhS6hklsz/cpHMxkw=
Received: by mail-wr1-f52.google.com with SMTP id j7so4462791wrp.13
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 09:48:08 -0800 (PST)
X-Gm-Message-State: APjAAAU1PUAuIxZooK1XknkmjUXfp1uwczJ8D2SGbipgH+kDRDDEf0FC
        GA/6Iu56AyX+GGTRWgCqnrezk+GCM73KJe0lagfkMw==
X-Google-Smtp-Source: APXvYqxUQ5Rl6f223DeNBgRxfyxYGHebVUKmvMIGlaGi36/c7bkUmehmyeiJm2n2zGg60xE3x2W2FfcXveeFIvQ8mmc=
X-Received: by 2002:adf:f84a:: with SMTP id d10mr42297wrq.208.1582825686508;
 Thu, 27 Feb 2020 09:48:06 -0800 (PST)
MIME-Version: 1.0
References: <20200226204515.2752095-1-nivedita@alum.mit.edu>
 <20200226230031.3011645-2-nivedita@alum.mit.edu> <20200227081229.GA29411@gmail.com>
 <20200227151643.GA3498170@rani.riverdale.lan> <CAKv+Gu8BiW6P6Xv3EAPUEmbS3GQMJW=eRr-yygRbForaGDQyyw@mail.gmail.com>
 <20200227155421.GA3507597@rani.riverdale.lan>
In-Reply-To: <20200227155421.GA3507597@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Feb 2020 18:47:55 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-k0c8GzKysv4Z9tYzEvfhJUzuiKx5nfwD0JU8ys=LZdg@mail.gmail.com>
Message-ID: <CAKv+Gu-k0c8GzKysv4Z9tYzEvfhJUzuiKx5nfwD0JU8ys=LZdg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix reloading of GDTR post-relocation
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 27 Feb 2020 at 16:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Feb 27, 2020 at 04:21:32PM +0100, Ard Biesheuvel wrote:
> > On Thu, 27 Feb 2020 at 16:16, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Thu, Feb 27, 2020 at 09:12:29AM +0100, Ingo Molnar wrote:
> > > >
> > > > * Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > > Commit ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
> > > > > introduced GDT setup into the 32-bit kernel's startup_32, and reloads
> > > > > the GDTR after relocating the kernel for paranoia's sake.
> > > > >
> > > > > Commit 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of
> > > > > the buffer") introduced a similar GDTR reload in the 64-bit kernel.
> > > > >
> > > > > The GDTR is adjusted by init_size - _end, however this may not be the
> > > > > correct offset to apply if the kernel was loaded at a misaligned address
> > > > > or below LOAD_PHYSICAL_ADDR, as in that case the decompression buffer
> > > > > has an additional offset from the original load address.
> > > > >
> > > > > This should never happen for a conformant bootloader, but we're being
> > > > > paranoid anyway, so just store the new GDT address in there instead of
> > > > > adding any offsets, which is simpler as well.
> > > > >
> > > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > > Fixes: ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
> > > > > Fixes: 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of the buffer")
> > > >
> > > > Have you or anyone else observed this condition practice, or have a
> > > > suspicion that this could happen - or is this a mostly theoretical
> > > > concern?
> > > >
> > > > Thanks,
> > > >
> > > >       Ingo
> > >
> > > Right now it's a theoretical concern.
> > >
> > > I'm working on another patch, to tell the EFI firmware PE loader what
> > > the kernel's preferred address is, so that we can avoid having to
> > > relocate the kernel in the EFI stub in most cases (ie if the PE loader
> > > manages to load us at that address). With those changes, the required
> > > adjustment won't be init_size - _end any more, and while fixing it up
> > > there, I noticed that it could already be the case that the required
> > > adjustment is different.
> > >
> >
> > Do you mean setting the image address in the PE/COFF header to the
> > preferred address?
>
> Yep. I'm doing that and then making a few adjustments to the PE entry
> code and head_* so that it can decompress starting at image_base instead
> of startup_32.

Interesting. I am going to rip most of the EFI handover protocol stuff
out of OVMF, since it is mostly unnecessary, and having the PE/COFF
loader put the image in the correct place right away is a nice
complimentary improvement to that. (Note that the OVMF implementation
of the EFI handover protocol does not currently honor the preferred
address from the setup header anyway)
