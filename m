Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831CD1A114F
	for <lists+linux-efi@lfdr.de>; Tue,  7 Apr 2020 18:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgDGQ11 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Apr 2020 12:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbgDGQ11 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 7 Apr 2020 12:27:27 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EF3F20771;
        Tue,  7 Apr 2020 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586276846;
        bh=DXfJAMkkUWsJDT/ebxAmwcGSnTaDukpCMdayhwgngH8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HNUm6cWPlsaYj94XBDXkmRQ/ohx/biK14TzWRfjG7+QWyC3YEF2+cifZmtg1VWvMs
         90Yfh6F+rBwI6DqQnm/DbK/+bnEOELu5r0/5brXFZ/JpTnvjWpmfp3Q46109LTFDvj
         mws0v2r828sLFUUIv1wdS0dyfyjDeAEGLMNFtAj0=
Received: by mail-il1-f171.google.com with SMTP id t6so3796238ilj.8;
        Tue, 07 Apr 2020 09:27:26 -0700 (PDT)
X-Gm-Message-State: AGi0PubUgyQcYLUifMSlyRJr+0bahjLK4SQQuOZsuIsD1BcwVSwptWDj
        v/UzUzUaVJwGU3ULCDGC9jH1qvZ6/R0mHNsLaoI=
X-Google-Smtp-Source: APiQypKm3VrkYe5UxgfIN5ado+NfIR/07pwBMtvzFm5MwEbxNXM8eZHqWjEZwLJS2O55c9CYj2kHDy6Syn+lbSesyP4=
X-Received: by 2002:a05:6e02:4c:: with SMTP id i12mr3335984ilr.211.1586276845309;
 Tue, 07 Apr 2020 09:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200407153206.17360-1-ardb@kernel.org> <20200407162017.GD9616@zn.tnic>
In-Reply-To: <20200407162017.GD9616@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Apr 2020 18:27:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH5-CzFC43WaV6iLqqHAhZUwMmV0sRT6D_L0iGCOP=zFg@mail.gmail.com>
Message-ID: <CAMj1kXH5-CzFC43WaV6iLqqHAhZUwMmV0sRT6D_L0iGCOP=zFg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: efi/x86: clarify EFI handover protocol and
 its requirements
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>, x86@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Apr 2020 at 18:20, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Apr 07, 2020 at 05:32:06PM +0200, Ard Biesheuvel wrote:
> > The EFI handover protocol was introduced on x86 to permit the boot
> > loader to pass a populated boot_params structure as an additional
> > function argument to the entry point. This allows the bootloader to
> > pass the base and size of a initrd image, which is more flexible
> > than relying on the EFI stub's file I/O routines, which can only
> > access the file system from which the kernel image itself was loaded
> > from firmware.
> >
> > This approach requires a fair amount of internal knowledge regarding
> > the layout of the boot_params structure on the part of the boot loader,
> > as well as knowledge regarding the allowed placement of the initrd in
> > memory, and so it has been deprecated in favour of a new initrd loading
> > method that is based on existing UEFI protocols and best practices.
> >
> > So update the x86 boot protocol documentation to clarify that the EFI
> > handover protocol has been deprecated, and while at it, add a note that
> > invoking the EFI handover protocol still requires the PE/COFF image to
> > be loader properly (as opposed to simply being copied into memory). Also,
> > drop the code32_start header field from the list of values that need to be
> > provided, as this is no longer required.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  Documentation/x86/boot.rst | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> > index fa7ddc0428c8..22ac52921692 100644
> > --- a/Documentation/x86/boot.rst
> > +++ b/Documentation/x86/boot.rst
> > @@ -1399,14 +1399,19 @@ must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
> >  must be __BOOT_DS; interrupt must be disabled; %rsi must hold the base
> >  address of the struct boot_params.
> >
> > -EFI Handover Protocol
> > -=====================
> > +EFI Handover Protocol (deprecated)
> > +==================================
> >
> >  This protocol allows boot loaders to defer initialisation to the EFI
> >  boot stub. The boot loader is required to load the kernel/initrd(s)
> >  from the boot media and jump to the EFI handover protocol entry point
> >  which is hdr->handover_offset bytes from the beginning of
> >  startup_{32,64}.
>
> Perhaps a newline here.
>

OK

> > +The boot loader MUST respect the kernel's PE/COFF metadata when it comes
> > +to section alignment, the memory footprint of the executable image beyond
> > +the size of the file itself, and any other aspect of the PE/COFF header
> > +that may affect correct operation of the image as a PE/COFF binary in the
> > +execution context provided by the EFI firmware.
> >
> >  The function prototype for the handover entry point looks like this::
> >
> > @@ -1419,9 +1424,15 @@ UEFI specification. 'bp' is the boot loader-allocated boot params.
> >
> >  The boot loader *must* fill out the following fields in bp::
> >
> > -  - hdr.code32_start
> >    - hdr.cmd_line_ptr
> >    - hdr.ramdisk_image (if applicable)
> >    - hdr.ramdisk_size  (if applicable)
> >
> >  All other fields should be zero.
> > +
> > +NOTE: The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
> > +      entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
> > +      loading protocol, which removes the need for any knowledge on the part of
> > +      the EFI bootloader regarding the internal representation of boot_params or
> > +      any requirements/limitations regarding the placement of the command line
> > +      and ramdisk in memory, or the placement of the kernel image itself.
>
> Yap, nice.
>
> I wonder if it might be even better if that would point people to
> efi_load_initrd_dev_path() or better yet to an actual example of how to
> do it.
>

I'll add a reference to [0] here, which is the u-boot implementation.

> Alternatively, the comment over initrd_dev_path almost spells it out
> what to do so I guess you could repeat that comment here so that it is
> perfectly clear, as in "We would like you to provide us an initrd in
> this exact manner." :-)
>
> In any case, thanks!
>
> Reviewed-by: Borislav Petkov <bp@suse.de>
>

Thanks

[0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
