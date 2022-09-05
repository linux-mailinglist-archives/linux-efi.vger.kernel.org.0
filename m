Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D895ACF60
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 12:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiIEJ75 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiIEJ74 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 05:59:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3719E17E31;
        Mon,  5 Sep 2022 02:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7AF8B80F9F;
        Mon,  5 Sep 2022 09:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AE9C433D6;
        Mon,  5 Sep 2022 09:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662371992;
        bh=m2tFKytoOyOHZ29GrB6wXIG/xB9cj2DAHqOf87NQtXw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hG5GOZX1YVFdccWZbshGeVejLjUK55i4IHcIjTRUp8b0rf9tvqDEgAxsQ7zBHfEd3
         6wHTNIa1Svdrs3tiM/+vJTh2lg+8eAJZ26fECUenUvYxt7OILg0N+duemR3REdh1Ke
         f0R0g5gdqdiyRazcRb9BaNm4eL89wxl/Iqg24yY4VYGxLNxjF6pJj4Kc8P8MH3Wc6x
         YVTGkTyu5PtrugEVXRhuoZuNDc2pYa1jzCROdbf9GrPUFcPDgdNnjLEgsR1sJYe1bN
         NUdFrUZ/a6bYZWFUPxMg5W8pCwdTqCOQz7kllGpObrKIGgUcMncOBchQOnDCW2TXrQ
         ugi/4Wkn0aWiw==
Received: by mail-lj1-f178.google.com with SMTP id by6so8659401ljb.11;
        Mon, 05 Sep 2022 02:59:52 -0700 (PDT)
X-Gm-Message-State: ACgBeo2t3+kD0dp+6mJ1L5RsDHtyQKmIuoyzjXXNicxY7hAPGSqVTsf2
        7nppCQzrZ70nrKX82RoEIbke5f2n5gV4pabpDT0=
X-Google-Smtp-Source: AA6agR6RfMFdNjIfa/4/plGUoXI69OCUj+956xThbfqstx8duexSRcdULXdZOz++tXvAz63pw92zZe7O0Fy/yDlX+z0=
X-Received: by 2002:a05:651c:1a0e:b0:268:94ad:85f8 with SMTP id
 by14-20020a05651c1a0e00b0026894ad85f8mr6330107ljb.415.1662371990383; Mon, 05
 Sep 2022 02:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220904165321.1140894-1-Jason@zx2c4.com> <CAMj1kXHC9Wfr74761gPcG=N8OC2P76FqSb8FVGWM7x1p-4hQKg@mail.gmail.com>
 <CAHmME9rAViyU3hCnziUkqGwtrOtu9oBOvniWV_uNCZ+TJGre5A@mail.gmail.com>
In-Reply-To: <CAHmME9rAViyU3hCnziUkqGwtrOtu9oBOvniWV_uNCZ+TJGre5A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 5 Sep 2022 11:59:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHPypCO5MNvFcw795LpZXPDRLjOdUJ4iRWxX7km7BF0ig@mail.gmail.com>
Message-ID: <CAMj1kXHPypCO5MNvFcw795LpZXPDRLjOdUJ4iRWxX7km7BF0ig@mail.gmail.com>
Subject: Re: [PATCH] efi: x86: Wipe setup_data on pure EFI boot
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 5 Sept 2022 at 11:57, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Mon, Sep 5, 2022 at 11:55 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Sun, 4 Sept 2022 at 18:53, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > When booting the x86 kernel via EFI using the LoadImage/StartImage boot
> > > services [as opposed to the deprecated EFI handover protocol], the setup
> > > header is taken from the image directly, and given that EFI's LoadImage
> > > has no Linux/x86 specific knowledge regarding struct bootparams or
> > > struct setup_header, any absolute addresses in the setup header must
> > > originate from the file and not from a prior loading stage.
> > >
> > > Since we cannot generally predict where LoadImage() decides to load an
> > > image (*), such absolute addresses must be treated as suspect: even if a
> > > prior boot stage intended to make them point somewhere inside the
> > > [signed] image, there is no way to validate that, and if they point at
> > > an arbitrary location in memory, the setup_data nodes will not be
> > > covered by any signatures or TPM measurements either, and could be made
> > > to contain an arbitrary sequence of SETUP_xxx nodes, which could
> > > interfere quite badly with the early x86 boot sequence.
> > >
> > > (*) Note that, while LoadImage() does take a buffer/size tuple in
> > > addition to a device path, which can be used to provide the image
> > > contents directly, it will re-allocate such images, as the memory
> > > footprint of an image is generally larger than the PE/COFF file
> > > representation.
> > >
> > > Next, in order to allow hypervisors to still use setup_data in scenarios
> > > where it may be useful, bump the x86 boot protocol version, so that
> > > hypervisors, e.g. QEMU in the linked patch, can do the right thing
> > > automatically depending on whether it is safe.
> > >
> > > Link: https://lore.kernel.org/qemu-devel/20220904165058.1140503-1-Jason@zx2c4.com/
> > > Coauthored-by: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > ---
> > >  arch/x86/boot/header.S                  | 2 +-
> > >  drivers/firmware/efi/libstub/x86-stub.c | 7 +++++++
> > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > > index f912d7770130..e4e2d6e33924 100644
> > > --- a/arch/x86/boot/header.S
> > > +++ b/arch/x86/boot/header.S
> > > @@ -307,7 +307,7 @@ _start:
> > >         # Part 2 of the header, from the old setup.S
> > >
> > >                 .ascii  "HdrS"          # header signature
> > > -               .word   0x020f          # header version number (>= 0x0105)
> > > +               .word   0x0210          # header version number (>= 0x0105)
> > >                                         # or else old loadlin-1.5 will fail)
> > >                 .globl realmode_swtch
> > >  realmode_swtch:        .word   0, 0            # default_switch, SETUPSEG
> > > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > > index 05ae8bcc9d67..9780f32a9f24 100644
> > > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > > @@ -517,6 +517,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> > >         hdr->ramdisk_image = 0;
> > >         hdr->ramdisk_size = 0;
> > >
> > > +       /*
> > > +        * Disregard any setup data that was provided by the bootloader:
> > > +        * setup_data could be pointing anywhere, and we have no way of
> > > +        * authenticating or validating the payload.
> > > +        */
> > > +       hdr->setup_data = 0;
> > > +
> > >         efi_stub_entry(handle, sys_table_arg, boot_params);
> > >         /* not reached */
> > >
> >
> > if the x86 folks are ok with this, I would like to send this to
> > cc:stable, but I imagine retroactively changing the header version
> > number might be something they would prefer to avoid. In that case,
> > better to split these up.
>
> Just FYI, the rng seed thing is new in 6.0 anyway. That still leaves
> the more obscure dtb one, and whatever else is used, but at least
> doing this for only 6.0+ would take care of the rng seed one.
>

Sure, but there is also the -dtb thing which can already be used to
crash the EFI stub. So even if this doesn't fix an issue occurring in
the wild, I think it is cleaner to clear setup_data on the pure EFI
entry path.
