Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867F7297575
	for <lists+linux-efi@lfdr.de>; Fri, 23 Oct 2020 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbgJWRCj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Oct 2020 13:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S464587AbgJWRCi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 23 Oct 2020 13:02:38 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5442F20790
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603472557;
        bh=2xuIQDh7qQdMkDMHNq16R463rYJIabbp8+dRBnBCSyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bOOD8whbFYQAepRXCVMN4M6NDQoU7b5i5vr9VHPsAKz1oRmvcWlA+cAWrwYt3ji+d
         Bg9srgd6U6mRX9trLNLg6R01zf8Q/WIrL4waCXEjoSPeWmU0zq3VUJfeth4hQxl2jd
         p7DMzJMhDjr24MC/WsOVwY2jgFyiaQ3Gp6z5zdUw=
Received: by mail-ot1-f41.google.com with SMTP id k3so1421265otp.1
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 10:02:37 -0700 (PDT)
X-Gm-Message-State: AOAM532x78r5xk50MurfFdefEuEy0rbHOakXee93jNmpIV2oshwE01Gc
        a7CUFxjeC+n+5USD4Sbjnl3BXEw6MRN/0kRKFjY=
X-Google-Smtp-Source: ABdhPJwGSg1TYPfVnRArCHDaimXKG47og3NyR79HVf3l8+tYw44jpSjMee0wr452D95vZQTYtSqkxVOQfZqAHB68sks=
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr2252002ots.90.1603472556468;
 Fri, 23 Oct 2020 10:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201023120825.30466-1-ard.biesheuvel@arm.com>
 <20201023120825.30466-4-ard.biesheuvel@arm.com> <20201023123246.GC1664@vanye>
In-Reply-To: <20201023123246.GC1664@vanye>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 23 Oct 2020 19:02:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH-YvaVpbCcvYR9xvykTmgRQ57cO14r72bJ7JHqZTTFxg@mail.gmail.com>
Message-ID: <CAMj1kXH-YvaVpbCcvYR9xvykTmgRQ57cO14r72bJ7JHqZTTFxg@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi: implemented LoadFile2 initr loading protocol for Linux
To:     Leif Lindholm <leif@nuviainc.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>, grub-devel@gnu.org,
        Daniel Kiper <daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 23 Oct 2020 at 14:32, Leif Lindholm <leif@nuviainc.com> wrote:
>
> initrd typo in subject
>
> minor style comments below
>
> On Fri, Oct 23, 2020 at 14:08:24 +0200, Ard Biesheuvel wrote:
> > Recent Linux kernels will invoke the LoadFile2 protocol installed on
> > a well-known vendor media path to load the initrd if it is exposed by
> > the firmware. Using this method is preferred for two reasons:
> > - the Linux kernel is in charge of allocating the memory, and so it can
> >   implement any placement policy it wants (given that these tend to
> >   change between kernel versions),
> > - it is no longer necessary to modify the device tree provided by the
> >   firmware.
> >
> > So let's install this protocol when handling the 'initrd' command if
> > such a recent kernel was detected (based on the PE/COFF image version),
> > and defer loading the initrd contents until the point where the kernel
> > invokes the LoadFile2 protocol.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> > ---
> >  grub-core/loader/arm64/linux.c | 117 +++++++++++++++++++-
> >  1 file changed, 116 insertions(+), 1 deletion(-)
> >
> > diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
> > index ef3e9f9444ca..285422c7bd43 100644
> > --- a/grub-core/loader/arm64/linux.c
> > +++ b/grub-core/loader/arm64/linux.c
> > @@ -48,9 +48,16 @@ static grub_uint32_t cmdline_size;
> >  static grub_addr_t initrd_start;
> >  static grub_addr_t initrd_end;
> >
> > +static struct grub_linux_initrd_context initrd_ctx = { 0, 0, 0 };
> > +static grub_efi_handle_t initrd_lf2_handle;
> > +static int initrd_use_loadfile2;
> > +
> >  grub_err_t
> >  grub_arch_efi_linux_check_image (struct linux_arch_kernel_header * lh)
> >  {
> > +  struct grub_pe32_coff_header *coff_header;
> > +  struct grub_pe32_optional_header *optional_header;
> > +
> >    if (lh->magic != GRUB_LINUX_ARMXX_MAGIC_SIGNATURE)
> >      return grub_error(GRUB_ERR_BAD_OS, "invalid magic number");
> >
> > @@ -61,6 +68,21 @@ grub_arch_efi_linux_check_image (struct linux_arch_kernel_header * lh)
> >    grub_dprintf ("linux", "UEFI stub kernel:\n");
> >    grub_dprintf ("linux", "PE/COFF header @ %08x\n", lh->hdr_offset);
> >
> > +  coff_header = (struct grub_pe32_coff_header *)((unsigned long)lh + lh->hdr_offset);
> > +  optional_header = (struct grub_pe32_optional_header *)(coff_header + 1);
> > +
> > +  /*
> > +   * Linux kernels built for any architecture are guaranteed to support the
> > +   * LoadFile2 based initrd loading protocol if the image version is >= 1.
> > +   */
> > +  if (optional_header->major_image_version >= 1)
> > +    initrd_use_loadfile2 = 1;
> > +   else
>
> funky indentation
>
> > +    initrd_use_loadfile2 = 0;
> > +
> > +  grub_dprintf ("linux", "LoadFile2 initrd loading %sabled\n",
> > +             initrd_use_loadfile2 ? "en" : "dis");
> > +
> >    return GRUB_ERR_NONE;
> >  }
> >
> > @@ -230,13 +252,88 @@ allocate_initrd_mem (int initrd_pages)
> >                                      GRUB_EFI_LOADER_DATA);
> >  }
> >
> > +struct initrd_media_device_path {
> > +  grub_efi_vendor_media_device_path_t        vendor;
> > +  grub_efi_device_path_t             end;
> > +} GRUB_PACKED;
> > +
> > +#define LINUX_EFI_INITRD_MEDIA_GUID  \
> > +  { 0x5568e427, 0x68fc, 0x4f3d, \
> > +    { 0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68 } \
> > +  }
> > +
> > +static struct initrd_media_device_path initrd_lf2_device_path = {
> > +  {
> > +    {
> > +      GRUB_EFI_MEDIA_DEVICE_PATH_TYPE,
> > +      GRUB_EFI_VENDOR_MEDIA_DEVICE_PATH_SUBTYPE,
> > +      sizeof(grub_efi_vendor_media_device_path_t),
> > +    },
> > +    LINUX_EFI_INITRD_MEDIA_GUID
> > +  }, {
> > +    GRUB_EFI_END_DEVICE_PATH_TYPE,
> > +    GRUB_EFI_END_ENTIRE_DEVICE_PATH_SUBTYPE,
> > +    sizeof(grub_efi_device_path_t)
> > +  }
> > +};
> > +
> > +static grub_efi_status_t
> > +grub_efi_initrd_load_file2(grub_efi_load_file2_t *this,
>
> Static functions don't need global prefixes (i.e., initrd_load_file2
> would be sufficient).
>
> > +                           grub_efi_device_path_t *device_path,
> > +                           grub_efi_boolean_t boot_policy,
> > +                           grub_efi_uintn_t *buffer_size,
> > +                           void *buffer);
> > +
> > +static grub_efi_load_file2_t initrd_lf2 = {
> > +  grub_efi_initrd_load_file2
> > +};
> > +
> > +static grub_efi_status_t
> > +grub_efi_initrd_load_file2(grub_efi_load_file2_t *this,
> > +                        grub_efi_device_path_t *device_path,
> > +                        grub_efi_boolean_t boot_policy,
> > +                        grub_efi_uintn_t *buffer_size,
> > +                        void *buffer)
> > +{
> > +  grub_efi_status_t status = GRUB_EFI_SUCCESS;
> > +  grub_efi_uintn_t initrd_size;
> > +
> > +  if (!this || this != &initrd_lf2 || !buffer_size)
> > +    return GRUB_EFI_INVALID_PARAMETER;
> > +
> > +  if (device_path->type != GRUB_EFI_END_DEVICE_PATH_TYPE ||
> > +      device_path->subtype != GRUB_EFI_END_ENTIRE_DEVICE_PATH_SUBTYPE)
> > +    return GRUB_EFI_NOT_FOUND;
> > +
> > +  if (boot_policy)
> > +    return GRUB_EFI_UNSUPPORTED;
> > +
> > +  initrd_size = grub_get_initrd_size (&initrd_ctx);
> > +  if (!buffer || *buffer_size < initrd_size)
> > +    {
> > +      *buffer_size = initrd_size;
> > +      return GRUB_EFI_BUFFER_TOO_SMALL;
> > +    }
> > +
> > +  grub_dprintf ("linux", "Loading initrd via LOAD_FILE2_PROTOCOL\n");
> > +
> > +  if (grub_initrd_load (&initrd_ctx, NULL, buffer))
> > +    status = GRUB_EFI_LOAD_ERROR;
> > +
> > +  grub_initrd_close (&initrd_ctx);
> > +  return status;
> > +}
> > +
> >  static grub_err_t
> >  grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
> >                int argc, char *argv[])
> >  {
> > -  struct grub_linux_initrd_context initrd_ctx = { 0, 0, 0 };
> >    int initrd_size, initrd_pages;
> >    void *initrd_mem = NULL;
> > +  grub_efi_guid_t load_file2_guid = GRUB_EFI_LOAD_FILE2_PROTOCOL_GUID;
> > +  grub_efi_guid_t device_path_guid = GRUB_EFI_DEVICE_PATH_GUID;
> > +  grub_efi_boot_services_t *b;
> > +  grub_efi_status_t status;
> >
> >    if (argc == 0)
> >      {
> > @@ -254,6 +351,24 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
> >    if (grub_initrd_init (argc, argv, &initrd_ctx))
> >      goto fail;
> >
> > +  if (initrd_use_loadfile2 && !initrd_lf2_handle)
> > +    {
> > +      b = grub_efi_system_table->boot_services;
> > +      status = b->install_multiple_protocol_interfaces (&initrd_lf2_handle,
> > +                                                     &load_file2_guid,
> > +                                                     &initrd_lf2,
> > +                                                     &device_path_guid,
> > +                                                     &initrd_lf2_device_path,
> > +                                                     NULL);
> > +      if (status == GRUB_EFI_OUT_OF_RESOURCES)
> > +        {
>
> indented by spaces
>
> > +       grub_error (GRUB_ERR_OUT_OF_MEMORY, N_("out of memory"));
> > +       return grub_errno;
> > +     }
>
> indented with tab
>

Thanks. I'll fix that up for the next revision. There's actually a bug
in this patch which I need to fix too: the code that checks the
PE/COFF header for the image version doesn't actually load the entire
header :-(
