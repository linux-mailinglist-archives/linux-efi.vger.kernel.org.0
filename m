Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9052A3EBF
	for <lists+linux-efi@lfdr.de>; Tue,  3 Nov 2020 09:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgKCISp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Nov 2020 03:18:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgKCISp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Nov 2020 03:18:45 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD622223BF
        for <linux-efi@vger.kernel.org>; Tue,  3 Nov 2020 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604391524;
        bh=Q+mb4OWDMTPQ3zYbQfdot0yCc5XkRiEuoK5to/8jCgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kdPC/R0loNDWrD/ISUAOh55N3SRVswcI8Z2b1doOsTAI2KnOeC5gGL67E6OTMfaqo
         aMKbavnVxCajiHvj5wcAh9v+mhusSEoO2bnY8/fb4NLqxK2J8Yn1SYIlwWNJgyvLM5
         pRG8MVQxmGDbIclPaOnbku5KWRjkIFvymh6xkdtA=
Received: by mail-oi1-f175.google.com with SMTP id t143so6003102oif.10
        for <linux-efi@vger.kernel.org>; Tue, 03 Nov 2020 00:18:43 -0800 (PST)
X-Gm-Message-State: AOAM531h5SF5sDnSegqeqItQ0SbZ6AyeZtVI8k39C8/ynUSpG/sfGDkt
        /cG2UJbgP9ttGIlvcE4NHVPWUk5W/VQEwgWGnBY=
X-Google-Smtp-Source: ABdhPJxtG/d9Kboi02QaMJWJiDTkClJe7UP1ZnEWBzm+HvMd6JpS7wKHsnHmMnFZ+6LekCaYOTLCX2ERm6ZAA1M96dY=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr1337224oif.174.1604391523208;
 Tue, 03 Nov 2020 00:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20201102170634.20575-1-ardb@kernel.org> <20201103055156.GA355267@apalos.home>
In-Reply-To: <20201103055156.GA355267@apalos.home>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Nov 2020 09:18:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGueA4UVYjXHCkWFctTCweXqau6jOV1R-O+zu+eDTmr8Q@mail.gmail.com>
Message-ID: <CAMj1kXGueA4UVYjXHCkWFctTCweXqau6jOV1R-O+zu+eDTmr8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] efi/libstub: measurement initrd data loaded by
 the EFI stub
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 3 Nov 2020 at 06:52, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Ard,
>
> On Mon, Nov 02, 2020 at 06:06:27PM +0100, Ard Biesheuvel wrote:
> > This series enables measurement of the initrd data loaded directly by the
> > EFI stub into the TPM, using the TCG2 protocol exposed by the firmware (if
> > available). This ensures that the initrd observed and used by the OS is the
> > same one that got measured into the TPM, which is more difficult to guarantee
> > in the current situation.
> >
>
> I like this. The OS gets the ability to 'self-measure' one critical component.
> This can of course be done in the bootloader or GRUB, but having the functionality
> in the stub will allow you to boot with a verified initrd, if even GRUB isn't
> there or the bootloader doesn't measure the initrd.
>

Well, that is one aspect of it. But the most important issue is that
the LoadFile2 protocol or the initrd= method are ambiguous: any initrd
loaded by the bootloader and passed via bootparams or DT might be
superseded by the EFI stub's initrd loader, and even if the command
line is measured as well, 'initrd=foo.bin' does not give any
guarantees about the contents of that file.

So measuring what actually gets loaded by the stub and passed to the
kernel is the most robust way to deal with this, and measuring 'no
stub-loaded initrd' if none is provided is important there.

But that does raise a question regarding double measurement:
unconditionally taking measurements might break existing boot flows
when upgrading the kernel. The alternative is to measure only if an
initrd was provided, but that is fragile as well.

So as Matthew suggested, it would be good to have a more high level
talk about the policies here, and about what kind of complications we
are prepared to put up with to make changes like this one possible.


> > This is posted as an RFC since it is mostly an invitation to discuss how
> > we can fit this into a longer term strategy for arch-agnostic secure and
> > measured boot that does not hinge on the Shim+GRUB tandem, or on deep
> > knowledge on the part of the bootloader regarding device trees, bootparams
> > structs, allocation and placement policies of various artifacts etc etc
> >
> > Open questions:
> > - Should we do this?
>
> I think so. I can't find any arguments why we shouldn't.
>
> > - Are Linux systems in the field using PCR value prediction when updating the
> >   initrd? Does this approach interfere with that?
> > - Which PCR and event type to use
>
> No idea. I think distros will have an opinion on that
>

PCR #9 with EV_IPL seems like the de facto standard, so I will stick with that.


> > - Is a separator event needed here, given that the initrd measurement is
> >   recorded even if no initrd was loaded by the stub?
>
> I think having the event make sense, but if we going to make a standard
> measurement for the initrd, we need to discuss this a bit more.
>

The question is about separator events: in the above case, for
instance, not extending the PCR if no initrd measurement is taken
could open the door to hacks where a rogue initrd is passed via
bootparams while the system is configured to use LoadFile2, and in
some way (EBS hook?), the firmware manages to extend the 'desired'
value into the PCR instead of the hash of the actual initrd that is
loaded. If we measure a separator event unconditionally after
measuring the initrd (or not), this cannot happen.

This might sound a bit convoluted, but real-world hacks typically are.

> >
> > Note that the EFI stub ignores the initrd provided directly via bootparams or
> > the device tree, and it would be nice if we could keep doing that.
> >
> > Build tested only.
>
>
> Cheers
> /Ilias
>
> >
> > Cc: Peter Jones <pjones@redhat.com>
> > Cc: Leif Lindholm <leif@nuviainc.com>
> > Cc: Arvind Sankar <nivedita@alum.mit.edu>
> > Cc: Matthew Garrett <mjg59@google.com>
> > Cc: Daniel Kiper <daniel.kiper@oracle.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > Ard Biesheuvel (7):
> >   efi/libstub: whitespace cleanup
> >   efi/libstub: fix prototype of efi_tcg2_protocol::get_event_log()
> >   efi/libstub: x86/mixed: increase supported argument count
> >   efi/libstub: move TPM related prototypes into efistub.h
> >   efi/libstub: add prototype of
> >     efi_tcg2_protocol::hash_log_extend_event()
> >   efi/libstub: consolidate initrd handling across architectures
> >   efi/libstub: measure loaded initrd info into the TPM
> >
> >  arch/x86/boot/compressed/efi_thunk_64.S       | 17 ++++--
> >  arch/x86/include/asm/efi.h                    | 13 +++--
> >  arch/x86/platform/efi/efi_thunk_64.S          | 17 ++++--
> >  .../firmware/efi/libstub/efi-stub-helper.c    | 56 +++++++++++++++----
> >  drivers/firmware/efi/libstub/efi-stub.c       | 10 +---
> >  drivers/firmware/efi/libstub/efistub.h        | 34 ++++++++++-
> >  drivers/firmware/efi/libstub/x86-stub.c       | 26 ++++-----
> >  include/linux/efi.h                           | 13 +----
> >  8 files changed, 123 insertions(+), 63 deletions(-)
> >
> > --
> > 2.17.1
> >
