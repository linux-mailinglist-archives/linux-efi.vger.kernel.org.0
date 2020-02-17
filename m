Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A014F160FD5
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 11:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgBQKWV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 05:22:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbgBQKWV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 05:22:21 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76F7822464
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581934940;
        bh=FUjf9GMM5bYNMdqW0EEu086wDGI935Eaue4FXllc6P8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C3tUPolGmi4u4OZJoYOdynjgDLw3rv9+LtJLDtwPIfU7P5rs1Wh9Y+b1c4iQOXkXv
         AnLfTFtkYEgdF8LO0Je3Q4VeGtj7fPQKJ7NnNGZ4HyZwbkH5fRzcsi2HDBtEpKKwD8
         0FWXJhL5Oohk1WNjM9VN6JRSPBC2tvQZrbRAlwhM=
Received: by mail-wm1-f48.google.com with SMTP id p9so16557623wmc.2
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 02:22:20 -0800 (PST)
X-Gm-Message-State: APjAAAWbxEmDvJDxIfC4AiTLg9Ee1uedNNH+Lm0n+8YAwCSibzqD64xP
        dG8UzxyMLLBtXIcEqxzppusdRU7k26AmFFJbz5qx3Q==
X-Google-Smtp-Source: APXvYqwwkF+c0FUerp1kIaBRtENAy8VTts+RWB6Dfu/2huDMOEOqCjBirvMJIWNc998VgcOlSd/hI/wUajJ+2s6NQKk=
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr21340370wmj.1.1581934938588;
 Mon, 17 Feb 2020 02:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20200216141104.21477-1-ardb@kernel.org> <20200216141104.21477-3-ardb@kernel.org>
 <4e427366-4141-e360-b1da-c5cb37f8092b@redhat.com> <CAKv+Gu8h17EdfEW_DDE9S_drLTJ3e3pVzJG29uij5DoGGMXpxA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8h17EdfEW_DDE9S_drLTJ3e3pVzJG29uij5DoGGMXpxA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Feb 2020 11:22:07 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8LEBFiXOXWv6nbKFpKvT8whaLr3-DkcHSNzW3BRTi8iQ@mail.gmail.com>
Message-ID: <CAKv+Gu8LEBFiXOXWv6nbKFpKvT8whaLr3-DkcHSNzW3BRTi8iQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi/libstub: Add support for loading the initrd
 from a device path
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 17 Feb 2020 at 10:23, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 17 Feb 2020 at 10:15, Laszlo Ersek <lersek@redhat.com> wrote:
> >
> > On 02/16/20 15:11, Ard Biesheuvel wrote:
> > > There are currently two ways to specify the initrd to be passed to the
> > > Linux kernel when booting via the EFI stub:
> > > - it can be passed as a initrd= command line option when doing a pure PE
> > >   boot (as opposed to the EFI handover protocol that exists for x86)
> > > - otherwise, the bootloader or firmware can load the initrd into memory,
> > >   and pass the address and size via the bootparams struct (x86) or
> > >   device tree (ARM)
> > >
> > > In the first case, we are limited to loading from the same file system
> > > that the kernel was loaded from, and it is also problematic in a trusted
> > > boot context, given that we cannot easily protect the command line from
> > > tampering without either adding complicated white/blacklisting of boot
> > > arguments or locking down the command line altogether.
> > >
> > > In the second case, we force the bootloader to duplicate knowledge about
> > > the boot protocol which is already encoded in the stub, and which may be
> > > subject to change over time, e.g., bootparams struct definitions, memory
> > > allocation/alignment requirements for the placement of the initrd etc etc.
> > > In the ARM case, it also requires the bootloader to modify the hardware
> > > description provided by the firmware, as it is passed in the same file.
> > > On systems where the initrd is measured after loading, it creates a time
> > > window where the initrd contents might be manipulated in memory before
> > > handing over to the kernel.
> > >
> > > Address these concerns by adding support for loading the initrd into
> > > memory by invoking the EFI LoadFile2 protocol installed on a vendor
> > > GUIDed device path that specifically designates a Linux initrd.
> > > This addresses the above concerns, by putting the EFI stub in charge of
> > > placement in memory and of passing the base and size to the kernel proper
> > > (via whatever means it desires) while still leaving it up to the firmware
> > > or bootloader to obtain the file contents, potentially from other file
> > > systems than the one the kernel itself was loaded from. On platforms that
> > > implement measured boot, it permits the firmware to take the measurement
> > > right before the kernel actually consumes the contents.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  drivers/firmware/efi/libstub/arm-stub.c        | 15 +++-
> > >  drivers/firmware/efi/libstub/efi-stub-helper.c | 82 ++++++++++++++++++++
> > >  drivers/firmware/efi/libstub/efistub.h         |  4 +
> > >  drivers/firmware/efi/libstub/x86-stub.c        | 23 ++++++
> > >  include/linux/efi.h                            |  1 +
> > >  5 files changed, 122 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> > > index 2edc673ea06c..4bae620b95b9 100644
> > > --- a/drivers/firmware/efi/libstub/arm-stub.c
> > > +++ b/drivers/firmware/efi/libstub/arm-stub.c
> > > @@ -160,6 +160,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
> > >       enum efi_secureboot_mode secure_boot;
> > >       struct screen_info *si;
> > >       efi_properties_table_t *prop_tbl;
> > > +     unsigned long max_addr;
> > >
> > >       sys_table = sys_table_arg;
> > >
> > > @@ -258,10 +259,18 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
> > >       if (!fdt_addr)
> > >               pr_efi("Generating empty DTB\n");
> > >
> > > -     status = efi_load_initrd(image, &initrd_addr, &initrd_size, ULONG_MAX,
> > > -                              efi_get_max_initrd_addr(dram_base, *image_addr));
> > > +     max_addr = efi_get_max_initrd_addr(dram_base, *image_addr);
> > > +     status = efi_load_initrd_dev_path(&initrd_addr, &initrd_size, max_addr);
> > > +     if (status == EFI_SUCCESS) {
> > > +             pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> > > +     } else if (status == EFI_NOT_FOUND) {
> > > +             status = efi_load_initrd(image, &initrd_addr, &initrd_size,
> > > +                                      ULONG_MAX, max_addr);
> > > +             if (status == EFI_SUCCESS)
> > > +                     pr_efi("Loaded initrd from command line option\n");
> > > +     }
> > >       if (status != EFI_SUCCESS)
> > > -             pr_efi_err("Failed initrd from command line!\n");
> > > +             pr_efi_err("Failed to load initrd!\n");
> > >
> > >       efi_random_get_seed();
> > >
> > > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > index 49008ac88b63..e37afe2c752e 100644
> > > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > @@ -299,3 +299,85 @@ void efi_char16_printk(efi_char16_t *str)
> > >       efi_call_proto(efi_table_attr(efi_system_table(), con_out),
> > >                      output_string, str);
> > >  }
> > > +
> > > +/*
> > > + * The LINUX_EFI_INITRD_MEDIA_GUID vendor media device path below provides a way
> > > + * for the firmware or bootloader to expose the initrd data directly to the stub
> > > + * via the trivial LoadFile2 protocol, which is defined in the UEFI spec, and is
> > > + * very easy to implement. It is a simple Linux initrd specific conduit between
> > > + * kernel and firmware, allowing us to put the EFI stub (being part of the
> > > + * kernel) in charge of where and when to load the initrd, while leaving it up
> > > + * to the firmware to decide whether it needs to expose its filesystem hierarchy
> > > + * via EFI protocols.
> > > + */
> > > +static const struct {
> > > +     struct efi_vendor_dev_path      vendor;
> > > +     struct efi_generic_dev_path     end;
> > > +} __packed initrd_dev_path = {
> > > +     {
> > > +             EFI_DEV_MEDIA,
> > > +             EFI_DEV_MEDIA_VENDOR,
> > > +             sizeof(struct efi_vendor_dev_path),
> > > +             LINUX_EFI_INITRD_MEDIA_GUID
> > > +     }, {
> > > +             EFI_DEV_END_PATH,
> > > +             EFI_DEV_END_ENTIRE,
> > > +             sizeof(struct efi_generic_dev_path)
> > > +     }
> > > +};
> > > +
> > > +/**
> > > + * efi_load_initrd_dev_path - load the initrd from the Linux initrd device path
> > > + * @load_addr:       pointer to store the address where the initrd was loaded
> > > + * @load_size:       pointer to store the size of the loaded initrd
> > > + * @max:     upper limit for the initrd memory allocation
> > > + * @return:  %EFI_SUCCESS if the initrd was loaded successfully, in which case
> > > + *           @load_addr and @load_size are assigned accordingly
> > > + *           %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
> > > + *           device path
> > > + *           %EFI_LOAD_ERROR in all other cases
> >
> > [*]
> >
> > > + */
> > > +efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
> > > +                                   unsigned long *load_size,
> > > +                                   unsigned long max)
> > > +{
> > > +     efi_guid_t lf2_proto_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
> > > +     efi_device_path_protocol_t *dp;
> > > +     efi_load_file2_protocol_t *lf2;
> > > +     unsigned long initrd_addr;
> > > +     unsigned long initrd_size;
> > > +     efi_handle_t handle;
> > > +     efi_status_t status;
> > > +
> > > +     if (!load_addr || !load_size)
> > > +             return EFI_INVALID_PARAMETER;
> >
> > Doesn't return EFI_LOAD_ERROR.
> >
> > > +
> > > +     dp = (efi_device_path_protocol_t *)&initrd_dev_path;
> > > +     status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle);
> > > +     if (status != EFI_SUCCESS)
> > > +             return status;
> >
> > Seems safe (the only plausible error could be EFI_NOT_FOUND).
> >
> > > +
> > > +     status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
> > > +                          (void **)&lf2);
> > > +     if (status != EFI_SUCCESS)
> > > +             return status;
> >
> > Interesting case; this should never fail... but note, if it does, it
> > returns EFI_UNSUPPORTED, not EFI_NOT_FOUND (if the protocol is missing
> > from the handle).
> >
> > > +
> > > +     status = efi_call_proto(lf2, load_file, dp, false, &initrd_size, NULL);
> > > +     if (status != EFI_BUFFER_TOO_SMALL)
> > > +             return EFI_LOAD_ERROR;
> > > +
> > > +     status = efi_allocate_pages(initrd_size, &initrd_addr, max);
> > > +     if (status != EFI_SUCCESS)
> > > +             return status;
> >
> > Not sure about the efi_allocate_pages() wrapper (?); the UEFI service
> > could return EFI_OUT_OF_RESOURCES.
> >
>
> Hmm, guess I was a bit sloppy with the return codes. The important
> thing is that EFI_NOT_FOUND is only returned in the one specifically
> defined case.
>

For the record [in case no respin+resend is needed for other reasons],
I intend to update the comment block as below, and keep the code as
is:


  * @load_addr: pointer to store the address where the initrd was loaded
  * @load_size: pointer to store the size of the loaded initrd
  * @max:       upper limit for the initrd memory allocation
- * @return:    %EFI_SUCCESS if the initrd was loaded successfully, in
which case
- *             @load_addr and @load_size are assigned accordingly
- *             %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
- *             device path
+ * @return:    %EFI_SUCCESS if the initrd was loaded successfully, in which
+ *             case @load_addr and @load_size are assigned accordingly
+ *             %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
+ *             device path
+ *             %EFI_INVALID_PARAMETER if load_addr == NULL or load_size == NULL
+ *             %EFI_OUT_OF_RESOURCES if memory allocation failed
  *             %EFI_LOAD_ERROR in all other cases
