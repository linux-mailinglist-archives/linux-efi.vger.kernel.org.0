Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32206154FB1
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 01:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgBGAV5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Feb 2020 19:21:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32967 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBGAV5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Feb 2020 19:21:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so630550wrt.0
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2020 16:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMnGuflRYGoiP5JHY+B8/WAIE0jw3MFkdl0crKJD8Y8=;
        b=lEXKsotyahf+Ez/EMT/t4UKz73DOyPb7AJHQq1B+apNPH09ALo+mt95T3OsuHjkHYb
         py36l3Tmcl7NHpN/DrafFAnTucnUYM+OU/u8h7LKAPzeSTLipZvHIxvLmdfBk9BjeJJW
         pezluwXq7833ZRKZ0opHyT/lV+KRXcInbERV6mR5B7ytZ69jXFfMHx8PgBUfD6Ijxln0
         l+LRe6tOqUrxl16QiOI6xMls+Ag3jCnvgHwj8jT7p+2/h00Ci+R0UBQzHW8fOZfz4gL6
         qiieVekE6xp7+7wyIOAcH98WwR0Y/UCiALmjdb2ZiBA5x+Y5XyzeTaUZj+jMjcBoRJwE
         yUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMnGuflRYGoiP5JHY+B8/WAIE0jw3MFkdl0crKJD8Y8=;
        b=mlXBtlYSeZYjB+WkTV1gKfaMi+4tJkpOKrvUSHQzWorvGkZCQYjPL+D5u+XkbwGEq3
         ftKu41uEi4TK2q7vQJr1Og2ap4jLevLhGkYYilpH9r03NiRCrhYc0HhuqB6yZ67tmHlU
         5YT2Tpl2Pb3hqg7yB1Q3k0J0ei7oWzlmG9d9OTjVCKlI0IBETmlF3qal6MM8t9cPimM+
         1Va7qk9yoQGKJhucgN/lK1Jxmpe/9vDuONyNLyu5sIHOcumK9nrh+WgD4IWoC8IRzGCT
         Kib6ui0bYR5B8JiyHO++hVDm/o8oXmSkD4Pqr1lfj0yd1f21NFPIguIuArwU1ZkelE8R
         AKdA==
X-Gm-Message-State: APjAAAVS9hQLEtpa8PZVjbpynAyQCDcLxqe5lXZsIgr+apwCEUoKxT2p
        Ueyq/S1vCjCoNdF7aoOcgOpIK8pQ8LyFY97+lmPH8ZISlCVS9A==
X-Google-Smtp-Source: APXvYqzaca1K8ayiTXQ0HG7VDmfYFuJLxNK+zwUtEpxFMZIhF1viRgjZuce11zVilATXgdPSMmBXgoNrMQzhnpSNfU0=
X-Received: by 2002:a5d:42c6:: with SMTP id t6mr659184wrr.151.1581034911988;
 Thu, 06 Feb 2020 16:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20200206140352.6300-1-ardb@kernel.org> <20200206140352.6300-2-ardb@kernel.org>
 <a6d7fefb-2f02-86a3-66aa-c3c129a91fb1@gmx.de> <CAKv+Gu9Z24GeqrqKhPJN+aAu8crSKvT0ZBeFL=0ik=z2Sd1FmQ@mail.gmail.com>
 <b2535bc9-f9be-e250-4da1-bce0b67abb6f@gmx.de>
In-Reply-To: <b2535bc9-f9be-e250-4da1-bce0b67abb6f@gmx.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Feb 2020 00:21:40 +0000
Message-ID: <CAKv+Gu-X6DKhtbfVgRLPomkkKJ7=4vRs-crLL0p7E7043J4H0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/libstub: add support for loading the initrd from
 a device path
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Daniel Kiper <daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 7 Feb 2020 at 00:01, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 2/6/20 11:35 PM, Ard Biesheuvel wrote:
> > On Thu, 6 Feb 2020 at 18:26, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 2/6/20 3:03 PM, Ard Biesheuvel wrote:
> >>> There are currently two ways to specify the initrd to be passed to the
> >>> Linux kernel when booting via the EFI stub:
> >>> - it can be passed as a initrd= command line option when doing a pure PE
> >>>     boot (as opposed to the EFI handover protocol that exists for x86)
> >>> - otherwise, the bootloader or firmware can load the initrd into memory,
> >>>     and pass the address and size via the bootparams struct (x86) or
> >>>     device tree (ARM)
> >>>
> >>> In the first case, we are limited to loading from the same file system
> >>> that the kernel was loaded from, and it is also problematic in a trusted
> >>
> >> Hello Ard,
> >>
> >> "same file system" is not a limitation of using a command line
> >> parameter. Any device path can be passed as a string.
> >>
> >
> > What do you mean? The current implementation opens the volume via the
> > loaded_image_info struct, and finds the file based on its filename,
> > not on a device path. So how can it access files on other file
> > systems?
> >
>
> I talked aobut the information can be transmitted in a parameter not
> about the restrictions the current Linux command line implementation has.
>
> If you would pass a complete device path as parameter, you could use the
> UEFI API to find the device with block file system and use the
> EFI_SIMPLE_FILE_SYSTEM_PROTOCOL to load the file.
>

Yes, but that still requires the bootloader to expose the file system
via EFI protocols, and it requires some degree of trust in the
contents of the command line. The command line in Linux is a bit hairy
in any case, but allowing it to override the very first thing that
gets executed is something we should try to avoid.


> >
> >>> boot context, given that we cannot easily protect the command line from
> >>> tampering without either adding complicated white/blacklisting of boot
> >>> arguments or locking down the command line altogether.
> >>
> >> Not relying on the command line for finding the initrd image does not
> >> secure the integrity and the validity of the initrd image.
> >>
> >
> > It does. It ensures that [signed] bootloader code is in charge of
> > providing the initrd at the point during the boot where the kernel is
> > ready to consume this data.
> >
> >> A signature on the initrd image could solve the security problem you
> >> describe. It would not require non-Linux software to be changed, and
> >> would provide much better security.
> >>
> >
> > A signed initrd would be useful, too, but it doesn't fix the whole problem.
> >
> > Linux does not support signed initrds today, and this feature permits
> > a firmware implementation to do something very similar, i.e., it
> > permits the bootloader to perform the verification as it is passed to
> > the kernel.
>
> One source of changed initrds is update-initramfs called in an operating
> system update process.
>
> How shall a bootloader verify the new initrd if we do not define what a
> signed initrd looks like?
>

Initrd signing is probably not feasible for this reason. But measuring
it, and using PCR value prediction to reseal keys when they change is
something we should be able to do in this context.

For that reason, it would be preferable for the command line not to
have control over whether or not an initrd gets loaded, and which.

> Would a bootloader be in a better position to verify an intird then
> Linux which already has code for file verification used when loading
> modules?
>

The bootloader already has code for file verification when loading the
kernel, so I fail to see your point here.

> >
> >
> >>>
> >>> In the second case, we force the bootloader to duplicate knowledge about
> >>> the boot protocol which is already encoded in the stub, and which may be
> >>> subject to change over time, e.g., bootparams struct definitions, memory
> >>> allocation/alignment requirements for the placement of the initrd etc etc.
> >>> In the ARM case, it also requires the bootloader to modify the hardware
> >>> description provided by the firmware, as it is passed in the same file.
> >>> On systems where the initrd is measured after loading, it creates a time
> >>> window where the initrd contents might be manipulated in memory before
> >>> handing over to the kernel.
> >>>
> >>> Address these concerns by adding support for loading the initrd into
> >>> memory by invoking the EFI LoadFile2 protocol installed on a vendor
> >>> GUIDed device path that specifically designates a Linux initrd.
> >>> This addresses the above concerns, by putting the EFI stub in charge of
> >>> placement in memory and of passing the base and size to the kernel proper
> >>> (via whatever means it desires) while still leaving it up to the firmware
> >>> or bootloader to obtain the file contents, potentially from other file
> >>> systems than the one the kernel itself was loaded from. On platforms that
> >>> implement measured boot, it permits the firmware to take the measurement
> >>> right before the kernel actually consumes the contents.
> >>
> >> A firmware implementing the UEFI standard will not be aware of any
> >> initrd image as such an object does not exist in the standard. It was a
> >> wise decision that the UEFI standard is operating system agnostic
> >> (accomodating BSD, Linux, Windows, etc.). So the firmware (EDK2, U-Boot,
> >> etc.) seems to be out of scope for providing a Linux specific
> >> EFI_LOAD_FILE2_PROTOCOL.
> >>
> >
> > You know we are currently patching bootparams struct and DTs to
> > provide the initrd information, right? And we have code that knows
> > about low/high memory limits, alignment, etc, that is different per
> > architecture.
> >
> >> When booting via GRUB it will be GRUB knowing which initrd to load.
> >>
> >
> > Exactly, which is why GRUB will implement this protocol. That way, it
> > does not have to touch the DT at all, or create a bootparams struct
> > from setup data and inspect the various flags about placement,
> > alignment, preferred addresses, etc.
> >
> >> Please, indicate which software you expect to expose the initrd related
> >> EFI_LOAD_FILE2_PROTOCOL.
> >>
> >
> > The primary use case is GRUB and other intermediate loaders, since it
> > would remove any need for these components to know any such details.
> > My aim is to make the next architecture that gets added to GRUB for
> > EFI boot 100% generic.
> >
> >> Using an UEFI variable for passing the initrd device path would be a
> >> leaner solution on the bootloader side than requiring an extra
> >> EFI_LOAD_FILE2_PROTOCOL implementation.
> >>
> >
> > This would also require kernel changes, since we don't currently load
> > initrds from arbitrary device paths. The EFI_FILE_PROTOCOL is much
> > more complicated than needed, and it doesn't work well with mixed
> > mode. It also requires GRUB to expose the filesystem it loads the
> > initrd from via EFI protocols, which is currently unnecessary and
> > therefore not implemented.
>
> This means you move the complexity of EFI_FILE_PROTOCOL from Linux to GRUB.
>

No. I am not interested in EFI_FILE_PROTOCOL, only in LoadFile2, which
is a single method that needs to be implemented.

> I would not have a problem if this would only touch GRUB. But if listen
> to Ilias we are replacing one implementation in Linux by one in GRUB and
> one in U-Boot and one in EDK2 and one in any other firmware.
>

If u-boot will be used to boot RISC-V in EFI mode without GRUB, then I
expect that we will need an implementation of this in u-boot.

> >
> > Also, using an EFI variable defeats the purpose. The whole point of
> > this is making it more likely that the kernel loaded the initrd that
> > the bootloader or firmware intended it to load, and having a piece of
> > simple [signed] code that implements this is the easiest way to
> > achieve that.
>
> At least on my Debian system it is the operating system creating initrd
> and defining which initrd matches which kernel. GRUB simply assumes that
> files ending on the same version number match. Therefore I would say
> Linux hopes that GRUB loads what Linux intended.
>
> The chain of trust would not be broken if the kernel were responsible
> for loading the initrd and for checking if it matches the kernel. Linux
> already does this for the kernel modules in initrd.
>

We can still sign the initrd and Linux can verify the signature. What
I am after is an interface that does not require the initrd to
originate from a EFI file system protocol, and which doesn't require
the loaded initrd to sit in memory for an unspecified amount of time
and its information passed via DT properties or bootparams structs.

So invoking EFI_FILE_PROTOCOL directly is not going to work,
regardless of whether we get the devicepath from the command line or
from a EFI variable.

> >
> > For u-boot, it should be trivial to implement a simple LoadFile2
> > protocol wrapper around EFI_FILE_PROTOCOL that can be installed on a
> > handle that also carries EFI_FILE_PROTOCOL.
> >
>
> A U-Boot implementation of the EFI_LOAD_FILE2_PROTOCOL would need a
> device path variable to find the block device and to open the
> EFI_SIMPLE_FILE_SYSTEM_PROTOCOL before accessing the file.
>
> Linux would not be needing more lines and we would not repeat the same
> code in GRUB, U-Boot, EDK2, etc.
>
> As said Linux updates the initrd often. If that file is not signed by
> Linux in a well defined way, do not expect any security at all.
>

It is not only about security. The primary goal is to remove the need
for arch specific knowledge in the firmware about DT, bootparams and
initrd allocation policies without being forced to load the initrd
from a filesystem that is exposed via a EFI protocol.

> If Linux does not tell which kernel matches which initrd, how should
> U-Boot know? - How do you plan to transfer this piece of information?
>

How does u-boot know today? If you can tell it which initrd to load
into memory, why is it difficult to put that same data into a buffer
in response to a protocol invocation?


> >>>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>> ---
> >>>    drivers/firmware/efi/libstub/arm-stub.c        | 16 +++--
> >>>    drivers/firmware/efi/libstub/efi-stub-helper.c | 65 ++++++++++++++++++++
> >>>    drivers/firmware/efi/libstub/efistub.h         | 12 ++++
> >>>    drivers/firmware/efi/libstub/x86-stub.c        | 36 ++++++++++-
> >>>    include/linux/efi.h                            |  1 +
> >>>    5 files changed, 123 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> >>> index c7b091f50e55..1db943c1ba2b 100644
> >>> --- a/drivers/firmware/efi/libstub/arm-stub.c
> >>> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> >>> @@ -157,6 +157,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
> >>>        enum efi_secureboot_mode secure_boot;
> >>>        struct screen_info *si;
> >>>        efi_properties_table_t *prop_tbl;
> >>> +     unsigned long max_addr;
> >>>
> >>>        sys_table = sys_table_arg;
> >>>
> >>> @@ -255,11 +256,18 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
> >>>        if (!fdt_addr)
> >>>                pr_efi("Generating empty DTB\n");
> >>>
> >>> -     status = efi_load_initrd(image, ULONG_MAX,
> >>> -                              efi_get_max_initrd_addr(dram_base, *image_addr),
> >>> -                              &initrd_addr, &initrd_size);
> >>> +     max_addr = efi_get_max_initrd_addr(dram_base, *image_addr);
> >>> +     status = efi_load_initrd_devpath(&initrd_addr, &initrd_size, max_addr);
> >>> +     if (status == EFI_SUCCESS)
> >>> +             pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> >>> +     else if (status == EFI_NOT_FOUND) {
> >>> +             status = efi_load_initrd(image, ULONG_MAX, max_addr,
> >>> +                                      &initrd_addr, &initrd_size);
> >>> +             if (status == EFI_SUCCESS)
> >>> +                     pr_efi("Loaded initrd from command line option\n");
> >>> +     }
>
> As already mentioned in another mail: If the initrd intended to be
> loaded by the the EFI_LOAD_FILE2_PROTOCOL, you fall back to the old
> behavior. So the security is not increased by this patch.
>

If the bootloader is signed, it is justified to place a higher degree
of trust in the code we run than in the [unsigned] data we pass as the
command line.

> >>>        if (status != EFI_SUCCESS)
> >>> -             pr_efi_err("Failed initrd from command line!\n");
> >>> +             pr_efi_err("Failed to load initrd!\n");
> >>>
> >>>        efi_random_get_seed();
> >>>
> >>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> >>> index 8e60a39df3c5..eaf45ea749b3 100644
> >>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> >>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> >>> @@ -323,3 +323,68 @@ void efi_char16_printk(efi_char16_t *str)
> >>>        efi_call_proto(efi_table_attr(efi_system_table(), con_out),
> >>>                       output_string, str);
> >>>    }
> >>> +
> >>> +static const struct {
> >>> +     struct efi_vendor_dev_path      vendor;
> >>> +     struct efi_generic_dev_path     end;
> >>> +} __packed initrd_devpath = {
> >>> +     {
> >>> +             EFI_DEV_MEDIA,
> >>> +             EFI_DEV_MEDIA_VENDOR,
> >>> +             sizeof(struct efi_vendor_dev_path),
> >>> +             LINUX_EFI_INITRD_MEDIA_GUID
> >>> +     }, {
> >>> +             EFI_DEV_END_PATH,
> >>> +             EFI_DEV_END_ENTIRE,
> >>> +             sizeof(struct efi_generic_dev_path)
> >>> +     }
> >>> +};
> >>> +
> >>> +efi_status_t efi_load_initrd_devpath(unsigned long *load_addr,
> >>> +                                  unsigned long *load_size,
> >>> +                                  unsigned long max)
> >>> +{
> >>> +     efi_guid_t lf2_proto_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
> >>> +     efi_device_path_protocol_t *dp;
> >>> +     efi_load_file2_protocol_t *lf2;
> >>> +     unsigned long initrd_addr;
> >>> +     unsigned long initrd_size;
> >>> +     efi_handle_t handle;
> >>> +     efi_status_t status;
> >>> +
> >>> +     if (!load_addr || !load_size)
> >>> +             return EFI_INVALID_PARAMETER;
> >>> +
> >>> +     dp = (efi_device_path_protocol_t *)&initrd_devpath;
> >>> +     status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle);
> >>> +     if (status != EFI_SUCCESS)
> >>> +             return status;
> >>> +
> >>> +     status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
> >>> +                          (void **)&lf2);
> >>> +     if (status != EFI_SUCCESS)
> >>> +             return status;
> >>
> >> You require here that there is a handle exposing the device path
> >> protocol with the initrd specific device path. On the same handle the
> >> EFI_LOAD_FILE2_PROTOCOL must be installed which will load the initrd
> >> file when called with the same device path.
> >>
> >
> > Exactly.
> >
> >> An alternative implementation would simple loop over all instances of
> >> the EFI_LOAD_FILE2_PROTOCOL and try to load the initrd.
> >>
> >
> > How do I distinguish the initrd from other EFI_LOAD_FILE2_PROTOCOL
> > instances? For instance, PCI option ROMs are also exposed as
> > EFI_LOAD_FILE2_PROTOCOL.
>
> These would respond with EFI_NOT_FOUND. The advantage of looping over
> all instances could be that the same handle could be used to provide
> multiple files. But how this is implemented is the least of my worries.
>
> Best regards
>
> Heinrich
>
> >
> >> It would be worthwhile to describe the requirements on the
> >> implementation of the EFI_LOAD_FILE2_PROTOCOL in a code comment and in
> >> the documentation.
> >>
> >> Unfortunately the documentation of UEFI has been duplicated into two files:
> >>
> >> Documentation/arm/uefi.rst
> >> Documentation/x86/x86_64/uefi.rst
> >>
> >
> > Yes, that is a good point. I will work on factoring out the generic
> > parts and share them.
> >
> >
> > Thanks for the review,
> > Ard.
> >
> >
> >
> >>
> >>> +
> >>> +     initrd_size = 0;
> >>> +     status = efi_call_proto(lf2, load_file,
> >>> +                             (efi_device_path_protocol_t *)&initrd_devpath,
> >>> +                             false, &initrd_size, NULL);
> >>> +     if (status != EFI_BUFFER_TOO_SMALL)
> >>> +             return EFI_LOAD_ERROR;
> >>> +
> >>> +     status = efi_allocate_pages(initrd_size, &initrd_addr, max);
> >>> +     if (status != EFI_SUCCESS)
> >>> +             return status;
> >>> +
> >>> +     status = efi_call_proto(lf2, load_file,
> >>> +                             (efi_device_path_protocol_t *)&initrd_devpath,
> >>> +                             false, &initrd_size, (void *)initrd_addr);
> >>> +     if (status != EFI_SUCCESS) {
> >>> +             efi_free(initrd_size, initrd_addr);
> >>> +             return status;
> >>> +     }
> >>> +
> >>> +     *load_addr = initrd_addr;
> >>> +     *load_size = initrd_size;
> >>> +     return EFI_SUCCESS;
> >>> +}
> >>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> >>> index 99e93fd76ec5..fbf9f9442eed 100644
> >>> --- a/drivers/firmware/efi/libstub/efistub.h
> >>> +++ b/drivers/firmware/efi/libstub/efistub.h
> >>> @@ -566,6 +566,14 @@ union efi_load_file_protocol {
> >>>        } mixed_mode;
> >>>    };
> >>>
> >>> +struct efi_vendor_dev_path {
> >>> +     u8              type;
> >>> +     u8              sub_type;
> >>> +     u16             length;
> >>> +     efi_guid_t      vendorguid;
> >>> +     u8              vendordata[];
> >>> +} __packed;
> >>> +
> >>>    void efi_pci_disable_bridge_busmaster(void);
> >>>
> >>>    typedef efi_status_t (*efi_exit_boot_map_processing)(
> >>> @@ -651,4 +659,8 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> >>>                             unsigned long *load_addr,
> >>>                             unsigned long *load_size);
> >>>
> >>> +efi_status_t efi_load_initrd_devpath(unsigned long *load_addr,
> >>> +                                  unsigned long *load_size,
> >>> +                                  unsigned long max);
> >>> +
> >>>    #endif
> >>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> >>> index f3e2ff31b624..7f38f95676dd 100644
> >>> --- a/drivers/firmware/efi/libstub/x86-stub.c
> >>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> >>> @@ -419,9 +419,20 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> >>>        if (status != EFI_SUCCESS)
> >>>                goto fail2;
> >>>
> >>> -     status = efi_load_initrd(image, hdr->initrd_addr_max,
> >>> -                              above4g ? ULONG_MAX : hdr->initrd_addr_max,
> >>> -                              &ramdisk_addr, &ramdisk_size);
> >>> +     /*
> >>> +      * The initrd loaded from the Linux initrd vendor device
> >>> +      * path should take precedence, as we don't want the
> >>> +      * [unverified] command line to override the initrd
> >>> +      * supplied by the [potentially verified] firmware.
> >>> +      */
> >>> +     status = efi_load_initrd_devpath(&ramdisk_addr, &ramdisk_size,
> >>> +                                      above4g ? ULONG_MAX
> >>> +                                              : hdr->initrd_addr_max);
> >>> +     if (status == EFI_NOT_FOUND)
> >>> +             status = efi_load_initrd(image, hdr->initrd_addr_max,
> >>> +                                      above4g ? ULONG_MAX
> >>> +                                              : hdr->initrd_addr_max,
> >>> +                                      &ramdisk_addr, &ramdisk_size);
> >>>        if (status != EFI_SUCCESS)
> >>>                goto fail2;
> >>>        hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
> >>> @@ -732,6 +743,25 @@ struct boot_params *efi_main(efi_handle_t handle,
> >>>                         ((u64)boot_params->ext_cmd_line_ptr << 32));
> >>>        efi_parse_options((char *)cmdline_paddr);
> >>>
> >>> +     if (!hdr->ramdisk_size && !boot_params->ext_ramdisk_size) {
> >>> +             unsigned long max = hdr->initrd_addr_max;
> >>> +             unsigned long addr, size;
> >>> +
> >>> +             if (hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G)
> >>> +                     max = ULONG_MAX;
> >>> +
> >>> +             status = efi_load_initrd_devpath(&addr, &size, max);
> >>> +             if (status == EFI_SUCCESS) {
> >>> +                     hdr->ramdisk_image              = (u32)addr;
> >>> +                     hdr->ramdisk_size               = (u32)size;
> >>> +                     boot_params->ext_ramdisk_image  = (u64)addr >> 32;
> >>> +                     boot_params->ext_ramdisk_size   = (u64)size >> 32;
> >>> +             } else if (status != EFI_NOT_FOUND) {
> >>> +                     efi_printk("efi_load_initrd_devpath() failed!\n");
> >>> +                     goto fail;
> >>> +             }
> >>> +     }
> >>> +
> >>>        /*
> >>>         * If the boot loader gave us a value for secure_boot then we use that,
> >>>         * otherwise we ask the BIOS.
> >>> diff --git a/include/linux/efi.h b/include/linux/efi.h
> >>> index 9ccf313fe9de..75c83c322c40 100644
> >>> --- a/include/linux/efi.h
> >>> +++ b/include/linux/efi.h
> >>> @@ -353,6 +353,7 @@ void efi_native_runtime_setup(void);
> >>>    #define LINUX_EFI_TPM_EVENT_LOG_GUID                EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
> >>>    #define LINUX_EFI_TPM_FINAL_LOG_GUID                EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
> >>>    #define LINUX_EFI_MEMRESERVE_TABLE_GUID             EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
> >>> +#define LINUX_EFI_INITRD_MEDIA_GUID          EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
> >>>
> >>>    /* OEM GUIDs */
> >>>    #define DELLEMC_EFI_RCI2_TABLE_GUID         EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> >>>
> >>
>
