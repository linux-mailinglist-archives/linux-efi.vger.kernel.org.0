Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625AB281B86
	for <lists+linux-efi@lfdr.de>; Fri,  2 Oct 2020 21:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbgJBTVw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Oct 2020 15:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388351AbgJBTVw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 2 Oct 2020 15:21:52 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22362206DD;
        Fri,  2 Oct 2020 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601666511;
        bh=L4m1QJWBqKGzyrw/xVJmG3tj2xwKO6e7HGpDzISiC74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BbILnrR4o3jxGxwLlp/CfPGAV1vMdoFLx0WtSwsaJAdnQ6a6HyTbNvVrZFjsQkwA1
         r83xWrA44SgQ3OzDPHJk/beEVGrH5x2Kv0YGutYJ9CM1eWUKewIxUyGGTdtQEjrEiX
         Z2q9P5yIXBpXvLx8ow7xWZbKUT/8rB6UZK0lsOws=
Received: by mail-ot1-f53.google.com with SMTP id c2so2459053otp.7;
        Fri, 02 Oct 2020 12:21:51 -0700 (PDT)
X-Gm-Message-State: AOAM532drHdCQak6d3iAdlhUc3nCgXnY64Hf+ZbRnRhotkgqG7/pb2C4
        qr2bZupdDmZk7d0e4H/fPmhGF9bLdN4Bhb3AEZw=
X-Google-Smtp-Source: ABdhPJwPTuuKRRs/1VwnEQiU3DRy6PM2jXlhvsHksNAjczi2LGkB2x4u0P+7zSB7fV7ebzj/Iq+1SJ3c4T8wtSFFSqc=
X-Received: by 2002:a9d:335:: with SMTP id 50mr2674457otv.90.1601666510446;
 Fri, 02 Oct 2020 12:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201002171112.22738-1-xypron.glpk@gmx.de> <CAMj1kXHsGcAX-DqfcpgxzZY3M+JzY-Ef9OdJ+JdysNnx1fK6zg@mail.gmail.com>
 <9899cc58-c856-38ca-3a89-4b545c973a4f@gmx.de>
In-Reply-To: <9899cc58-c856-38ca-3a89-4b545c973a4f@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 2 Oct 2020 21:21:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGBGb5yU0XH3oBJfTUDiFzhqa8ihyYo=n_qyj1VcCs5zA@mail.gmail.com>
Message-ID: <CAMj1kXGBGb5yU0XH3oBJfTUDiFzhqa8ihyYo=n_qyj1VcCs5zA@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs: admin-guide: fdt and initrd load in EFI stub
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2 Oct 2020 at 21:14, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/2/20 7:21 PM, Ard Biesheuvel wrote:
> > Hi Heinrich,
> >
> > Thanks for documenting this.
> >
> >
> > On Fri, 2 Oct 2020 at 19:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> Describe how a device tree and an initial RAM disk can be passed to the EFI
> >> Boot Stub.
> >>
> >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> ---
> >>  Documentation/admin-guide/efi-stub.rst | 35 ++++++++++++++++++++++++++
> >>  1 file changed, 35 insertions(+)
> >>
> >> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
> >> index 833edb0d0bc4..86f50a33884c 100644
> >> --- a/Documentation/admin-guide/efi-stub.rst
> >> +++ b/Documentation/admin-guide/efi-stub.rst
> >> @@ -38,6 +38,34 @@ arch/arm/boot/zImage should be copied to the system partition, and it
> >>  may not need to be renamed. Similarly for arm64, arch/arm64/boot/Image
> >>  should be copied but not necessarily renamed.
> >>
> >> +Passing an initial RAM disk to the EFI Boot Stub
> >> +------------------------------------------------
> >> +
> >> +The following means sorted by decreasing priority can be used to provide an
> >> +initial RAM disk to the EFI Boot Stub:
> >> +
> >> +* The firmware may provide a UEFI Load File 2 Protocol. The stub will try to
> >> +  load the RAM disk by calling the LoadFile() service of the protocol using
> >> +  a vendor device path with the vendor GUID
> >> +  5568e427-0x68fc-4f3d-ac74-ca555231cc68.
> >> +* Next the EFI stub will try to load the file indicated by the "initrd=" command
> >> +  line parameter.
> >> +* The prior boot stage may pass the location of the initial RAM disk via the
> >> +  "linux,initrd-start" and "linux,initrd-end" properties of the "/chosen" node
> >> +  of the device-tree.
> >> +
> >
> > On x86, the boot_params struct is used to pass the address and size of
> > the initrd in memory. Maybe include that for completeness?
>
> On x86 boot_params is set in function efi_pe_entry() after loading the
> file indicated by the initrd= command line.
>
> boot_params is not accessible by a caller of the EFI stub but is a
> structure used at the interface between EFI stub and main kernel. This
> interface is not in the scope of the admin-guide.
>

 I don't see the difference between dt for arm and boot_params for
x86. Both can be provided by the bootloader, and will be created from
scratch by the efi stub if not. They both carry the command line and
address and size of the initrd, and the efi stub will load  the initrd
and update this Information, or pass it on unmodified if the
bootloader already loaded the initrd into memory.



> The main Linux entry point is already described in
> Documentation/x86/boot.rst and ./Documentation/x86/zero-page.rst.
>
> We can add Sphinx style documentation for function efi_pe_entry()
> mentioning that it fills in boot_params.
> drivers/firmware/efi/libstub/x86-stub.c then can be added to
> Documentation/driver-api/firmware/efi/index.rst in an x86 chapter. But
> these will be separate patches.
>
> Best regards
>
> Heinrich
>
> >
> >> +The first two items are inhibited by the "noinitrd" command line parameter.
> >> +
> >
> > Interesting. Are you saying noinitrd is ignored by the kernel itself?
> >
> > Looking at the code, it might only work for preventing the load of old
> > style initrd ramdisks, whereas initramfs images are handled
> > separately.
> >
> > This is something that we should probably fix one way or the other.
> >
> >
> >> +Passing a device-tree to the EFI Boot Stub
> >> +------------------------------------------
> >> +
> >> +A device-tree can be passed to the EFI Boot Stub in decreasing priority using
> >> +
> >> +* command line option dtb=
> >> +* a UEFI configuration table with GUID b1b621d5-f19c-41a5-830b-d9152c69aae0.
> >> +
> >> +The command line option is only available if CONFIG_EFI_ARMSTUB_DTB_LOADER=y
> >> +and secure boot is disabled.
> >>
> >>  Passing kernel parameters from the EFI shell
> >>  --------------------------------------------
> >> @@ -46,6 +74,10 @@ Arguments to the kernel can be passed after bzImage.efi, e.g.::
> >>
> >>         fs0:> bzImage.efi console=ttyS0 root=/dev/sda4
> >>
> >> +The "noinitrd" option
> >> +---------------------
> >> +
> >> +The "noinitrd" option stops the EFI stub from loading an initial RAM disk.
> >>
> >>  The "initrd=" option
> >>  --------------------
> >> @@ -98,3 +130,6 @@ CONFIGURATION TABLE.
> >>
> >>  "dtb=" is processed in the same manner as the "initrd=" option that is
> >>  described above.
> >> +
> >> +This option is only available if CONFIG_EFI_ARMSTUB_DTB_LOADER=y and secure
> >> +boot is disabled.
> >> --
> >> 2.28.0
> >>
>
