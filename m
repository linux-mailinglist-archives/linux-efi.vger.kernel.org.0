Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECAB4345A5
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 09:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhJTHE6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 03:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhJTHE5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Oct 2021 03:04:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7268E6117A;
        Wed, 20 Oct 2021 07:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634713363;
        bh=jN7yv8run4Ayqqb3+UhVPOlINbSDDvmCbhXXx46lR7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NpUX8Gwi+YiTKClMBVAlG4F9DBOUf6DR5hf+VtqwBYWt5z8BrOzSuCdKF6Ohnqz/F
         Zq5mQVXrhdJCGqtKgmFqcJdCduqE0rXl0cqnK+XQcj05bz08ynNJX6K+gi/d/zRlK6
         B2aqoW8c/ikAhaf1dnSJ6SMRVPcvgR8QF6O9RjvJ6FXxZvP/1OU/kuEVcFPXb2Ugvd
         FwusfmsXCu1drCPWzRBs89lhTX7UouaROSPBOPkiI+veB6dYn+aOHXQNBGhtscLoyD
         l67CehCUYaoFXgMVK2Vdf5wlMuhMMhIrtFY9kQPgFiP7HCkluKEJD+CpFoPrjgENec
         Hx+5UpwqXtJbQ==
Received: by mail-ot1-f43.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so6074993otb.10;
        Wed, 20 Oct 2021 00:02:43 -0700 (PDT)
X-Gm-Message-State: AOAM531X6Te89ASLQvh3NpZpnEriGHSNq1fX4+NkbycsvHerf8M0B8c9
        TakWHnU9666YHq7KHdNmbpqnvfY3hMHLWaX+aD0=
X-Google-Smtp-Source: ABdhPJwYRVJIzsSfj2nAKrpnN6uPLhrQg0ywBbGOA4lDI5+X5CVLwgjQpfGV2ww+CojcAv7now7bmHiWsCxO9TSMtK8=
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr9137717otg.147.1634713362598;
 Wed, 20 Oct 2021 00:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
 <20211020061408.3447533-2-dovmurik@linux.ibm.com> <YW+5phDcxynJD2qy@kroah.com>
In-Reply-To: <YW+5phDcxynJD2qy@kroah.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 20 Oct 2021 09:02:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG6sfAf2=hqmQziJv5+qe6AagV7GfJoG9vZ4FobHQZJWw@mail.gmail.com>
Message-ID: <CAMj1kXG6sfAf2=hqmQziJv5+qe6AagV7GfJoG9vZ4FobHQZJWw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] efi/libstub: Copy confidential computing secret area
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 20 Oct 2021 at 08:44, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 20, 2021 at 06:14:06AM +0000, Dov Murik wrote:
> > Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
> > Virtualization) allows a guest owner to inject secrets into the VMs
> > memory without the host/hypervisor being able to read them.
> >
> > Firmware support for secret injection is available in OVMF, which
> > reserves a memory area for secret injection and includes a pointer to it
> > the in EFI config table entry LINUX_EFI_COCO_SECRET_TABLE_GUID.
> > However, OVMF doesn't force the guest OS to keep this memory area
> > reserved.
> >
> > If EFI exposes such a table entry, efi/libstub will copy this area to a
> > reserved memory for future use inside the kernel.
> >
> > A pointer to the new copy is kept in the EFI table under
> > LINUX_EFI_COCO_SECRET_AREA_GUID.
> >
> > The new functionality can be enabled with CONFIG_EFI_COCO_SECRET=y.
> >
> > Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> > ---
> >  drivers/firmware/efi/Kconfig            | 12 +++++
> >  drivers/firmware/efi/libstub/Makefile   |  1 +
> >  drivers/firmware/efi/libstub/coco.c     | 68 +++++++++++++++++++++++++
> >  drivers/firmware/efi/libstub/efi-stub.c |  2 +
> >  drivers/firmware/efi/libstub/efistub.h  |  6 +++
> >  drivers/firmware/efi/libstub/x86-stub.c |  2 +
> >  include/linux/efi.h                     |  6 +++
> >  7 files changed, 97 insertions(+)
> >  create mode 100644 drivers/firmware/efi/libstub/coco.c
> >
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 2c3dac5ecb36..68d1c5e6a7b5 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -284,3 +284,15 @@ config EFI_CUSTOM_SSDT_OVERLAYS
> >
> >         See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
> >         information.
> > +
> > +config EFI_COCO_SECRET
> > +     bool "Copy and reserve EFI Confidential Computing secret area"
> > +     depends on EFI
> > +     default n
>
> default is always "n", no need to list this.
>
> > +     help
> > +       Copy memory reserved by EFI for Confidential Computing (coco)
> > +       injected secrets, if EFI exposes such a table entry.
>
> Why would you want to "copy" secret memory?
>
> This sounds really odd here, it sounds like you are opening up a
> security hole.  Are you sure this is the correct text that everyone on
> the "COCO" group agrees with?
>
> > +
> > +       If you say Y here, the EFI stub copy the EFI secret area (if
> > +       available) and reserve it for use inside the kernel.  This will
> > +       allow the virt/coo/efi_secret module to access the secrets.
>
> What is "virt/coo/efi_secret"?
>
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index d0537573501e..fdada3fd5d9b 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -66,6 +66,7 @@ $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
> >  lib-$(CONFIG_EFI_GENERIC_STUB)       += efi-stub.o fdt.o string.o \
> >                                  $(patsubst %.c,lib-%.o,$(efi-deps-y))
> >
> > +lib-$(CONFIG_EFI_COCO_SECRET)        += coco.o
> >  lib-$(CONFIG_ARM)            += arm32-stub.o
> >  lib-$(CONFIG_ARM64)          += arm64-stub.o
> >  lib-$(CONFIG_X86)            += x86-stub.o
> > diff --git a/drivers/firmware/efi/libstub/coco.c b/drivers/firmware/efi/libstub/coco.c
> > new file mode 100644
> > index 000000000000..bf546b6a3f72
> > --- /dev/null
> > +++ b/drivers/firmware/efi/libstub/coco.c
> > @@ -0,0 +1,68 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Confidential computing (coco) secret area handling
> > + *
> > + * Copyright (C) 2021 IBM Corporation
> > + * Author: Dov Murik <dovmurik@linux.ibm.com>
> > + */
> > +
> > +#include <linux/efi.h>
> > +#include <linux/sizes.h>
> > +#include <asm/efi.h>
> > +
> > +#include "efistub.h"
> > +
> > +#define LINUX_EFI_COCO_SECRET_TABLE_GUID                                                           \
> > +     EFI_GUID(0xadf956ad, 0xe98c, 0x484c, 0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
> > +
> > +/**
> > + * struct efi_coco_secret_table - EFI config table that points to the
> > + * confidential computing secret area. The guid
> > + * LINUX_EFI_COCO_SECRET_TABLE_GUID holds this table.
> > + * @base:    Physical address of the EFI secret area
> > + * @size:    Size (in bytes) of the EFI secret area
> > + */
> > +struct efi_coco_secret_table {
> > +     u64 base;
> > +     u64 size;
>
> __le64?  Or is this really in host endian format?
>

EFI hosts are always LE so either is fine.

> > +} __attribute((packed));
> > +
> > +/*
> > + * Create a copy of EFI's confidential computing secret area (if available) so
> > + * that the secrets are accessible in the kernel after ExitBootServices.
> > + */
> > +void efi_copy_coco_secret_area(void)
> > +{
> > +     efi_guid_t linux_secret_area_guid = LINUX_EFI_COCO_SECRET_AREA_GUID;
> > +     efi_status_t status;
> > +     struct efi_coco_secret_table *secret_table;
> > +     struct linux_efi_coco_secret_area *secret_area;
> > +
> > +     secret_table = get_efi_config_table(LINUX_EFI_COCO_SECRET_TABLE_GUID);
> > +     if (!secret_table)
> > +             return;
> > +
> > +     if (secret_table->size == 0 || secret_table->size >= SZ_4G)
> > +             return;
> > +
> > +     /* Allocate space for the secret area and copy it */
> > +     status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> > +                          sizeof(*secret_area) + secret_table->size, (void **)&secret_area);
> > +
> > +     if (status != EFI_SUCCESS) {
> > +             efi_err("Unable to allocate memory for confidential computing secret area copy\n");
> > +             return;
> > +     }
> > +
> > +     secret_area->size = secret_table->size;
> > +     memcpy(secret_area->area, (void *)(unsigned long)secret_table->base, secret_table->size);
>
> Why the double cast?
>

This is generally needed for compatibility with 32-bit hosts, where
casting a u64 to void* causes warnings, even though we know in that
case that only the lower 32 bits will contain anything (even with PAE
etc, as 32-bit UEFI only uses 32-bit addressable memory)

In this particular case, it probably makes little sense, as COCO is
not going to run on 32-bit hosts anyway (famous last words)

> And you can treat this value as a "raw" pointer directly?  No need to
> map it at all?  What could go wrong...
>

Yes. EFI boot services (as well as this code) are guaranteed to run
under a 1:1 mapping of system memory.

> > +
> > +     status = efi_bs_call(install_configuration_table, &linux_secret_area_guid, secret_area);
> > +     if (status != EFI_SUCCESS)
> > +             goto err_free;
> > +
> > +     return;
> > +
> > +err_free:
> > +     efi_bs_call(free_pool, secret_area);
>
> This memory is never freed when shutting down the system?
>

All boot services memory is implicitly freed when the system calls
ExitBootServices() so this is fine.
