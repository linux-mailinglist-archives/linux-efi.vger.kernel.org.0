Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 435D3172225
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgB0PVs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 10:21:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbgB0PVs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Feb 2020 10:21:48 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC542469F
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582816907;
        bh=T9dOLKG0py6qkERLpwlSZyviHQ5P0/AANhjFWasQW80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DNFTwP3XbjZEMxBVDzd/quWeQ2/givNf4BqjbJUoBPmedhklbXBelhZr8GpvLHpCE
         SDoAFGlNWK/md5syoNfAGLlhELV6qjO70qCIiIDrLn0GuT8lh91ANWgt+HCVgwq4Fw
         T4DZ6SqgsMZW6AdxaIywRMs8s2xuTpeuZboaNmT0=
Received: by mail-wr1-f50.google.com with SMTP id x7so1364061wrr.0
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 07:21:46 -0800 (PST)
X-Gm-Message-State: APjAAAUqmLrT9lQb280XpIztwTTK+sbzo/pleeRRF0BcL/t3CL7Vk2Nu
        umr/q2ivCny4MMXgswMV47orolNHDsG1Z7bStC2Dcg==
X-Google-Smtp-Source: APXvYqxanNBk76hCAYyAT9ZByxKRvOJ/0QhmbBw3XoLcW0zeZ9Vcwb64GM5wP5AGcQ76Ff4K58RhcGEecK09PohqN3A=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr5530464wrw.252.1582816905187;
 Thu, 27 Feb 2020 07:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20200226204515.2752095-1-nivedita@alum.mit.edu>
 <20200226230031.3011645-2-nivedita@alum.mit.edu> <20200227081229.GA29411@gmail.com>
 <20200227151643.GA3498170@rani.riverdale.lan>
In-Reply-To: <20200227151643.GA3498170@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Feb 2020 16:21:32 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8BiW6P6Xv3EAPUEmbS3GQMJW=eRr-yygRbForaGDQyyw@mail.gmail.com>
Message-ID: <CAKv+Gu8BiW6P6Xv3EAPUEmbS3GQMJW=eRr-yygRbForaGDQyyw@mail.gmail.com>
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

On Thu, 27 Feb 2020 at 16:16, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Feb 27, 2020 at 09:12:29AM +0100, Ingo Molnar wrote:
> >
> > * Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > > Commit ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
> > > introduced GDT setup into the 32-bit kernel's startup_32, and reloads
> > > the GDTR after relocating the kernel for paranoia's sake.
> > >
> > > Commit 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of
> > > the buffer") introduced a similar GDTR reload in the 64-bit kernel.
> > >
> > > The GDTR is adjusted by init_size - _end, however this may not be the
> > > correct offset to apply if the kernel was loaded at a misaligned address
> > > or below LOAD_PHYSICAL_ADDR, as in that case the decompression buffer
> > > has an additional offset from the original load address.
> > >
> > > This should never happen for a conformant bootloader, but we're being
> > > paranoid anyway, so just store the new GDT address in there instead of
> > > adding any offsets, which is simpler as well.
> > >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > Fixes: ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
> > > Fixes: 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of the buffer")
> >
> > Have you or anyone else observed this condition practice, or have a
> > suspicion that this could happen - or is this a mostly theoretical
> > concern?
> >
> > Thanks,
> >
> >       Ingo
>
> Right now it's a theoretical concern.
>
> I'm working on another patch, to tell the EFI firmware PE loader what
> the kernel's preferred address is, so that we can avoid having to
> relocate the kernel in the EFI stub in most cases (ie if the PE loader
> manages to load us at that address). With those changes, the required
> adjustment won't be init_size - _end any more, and while fixing it up
> there, I noticed that it could already be the case that the required
> adjustment is different.
>

Do you mean setting the image address in the PE/COFF header to the
preferred address?
