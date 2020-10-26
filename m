Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7E12998F1
	for <lists+linux-efi@lfdr.de>; Mon, 26 Oct 2020 22:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389924AbgJZViM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Oct 2020 17:38:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35779 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389925AbgJZViL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Oct 2020 17:38:11 -0400
Received: by mail-io1-f66.google.com with SMTP id k6so12359881ior.2
        for <linux-efi@vger.kernel.org>; Mon, 26 Oct 2020 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdubmnQhGkLez/ypmM7I8vCyfqCYbVC1HHwjimM60Qk=;
        b=hA0DRiAOmmurOvXhDUxEW7gb96Mh0YCG2kDrBAtran805oFVWxyLACJ5kiEJEDUVLx
         TkrEf+gpqMCjajuTkyu70NWvBZVIEw025MuSeZMDTVwai/xZMybZqtqGlAitAC0wpAWW
         4lbiN+MUC4AvHhQTeHXYW1O6xjiQd0WHq/GVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdubmnQhGkLez/ypmM7I8vCyfqCYbVC1HHwjimM60Qk=;
        b=oQl2IOX5usBy0HJ6bu4s4k1kxKuVUPDsv2InvoV9/nj0NdXISHOqdLuGW8Tvvbeqpc
         863Uz9+JMBqznvHRRtAQNYriDvehHc/SsybMNgmLrprbPNl7vcl202bEpr2Y/kV7aqhc
         3iluOHGozzu0GO0q4CH+9Sf2JpLli+GMzhzWN8q7T9C6mi1JGofa9zezbnWD9P394hEn
         x281GMOF0rxsNWyYv5R4Xlw3M2yyHogk0tJddnlD16U+G53wmRXi+GOqraACt61SPuCL
         eUBuEAp8vNGAkaO/4h/5TmuNO4noKsTutdiffsqEZw9/U1bl0PP2wJ8EdzxvONj5pSWt
         gMTA==
X-Gm-Message-State: AOAM532BOkO01ZxfyA03CPwj1abF20HG2murj4JTa4bQuD24+HZUT9xc
        6g5yvmY4Bg2nXAWPgX+iRA3znl4c/NnZYLyX4RsS
X-Google-Smtp-Source: ABdhPJwxRgxhipBYXsO0PhLXypb3MYG8cNvFD/KevJU/MN1cOp7iAKXqlZvMnjnuAyPqw/P150gTo1V6+ZrLJ2paVrE=
X-Received: by 2002:a6b:cd83:: with SMTP id d125mr12169093iog.174.1603748290231;
 Mon, 26 Oct 2020 14:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201025134941.4805-1-ard.biesheuvel@arm.com> <20201025134941.4805-8-ard.biesheuvel@arm.com>
In-Reply-To: <20201025134941.4805-8-ard.biesheuvel@arm.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 26 Oct 2020 14:37:59 -0700
Message-ID: <CAOnJCUJVRBBVm6id-5U_zrqqKewuXLt-c9tTBuBYaLXEnox-jQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] efi: implement LoadFile2 initrd loading protocol
 for Linux
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Oct 25, 2020 at 6:50 AM Ard Biesheuvel <ard.biesheuvel@arm.com> wrote:
>
> Recent Linux kernels will invoke the LoadFile2 protocol installed on a
> well-known vendor media devicepath to load the initrd if it is exposed
> by the firmware. Using this method is preferred for two reasons:
> - the Linux kernel is in charge of allocating the memory, and so it can
>   implement any placement policy it wants (given that these tend to
>   change between kernel versions),
> - it is no longer necessary to modify the device tree provided by the
>   firmware.
>
> So let's install this protocol when handling the 'initrd' command if
> such a recent kernel was detected (based on the PE/COFF image version),
> and defer loading the initrd contents until the point where the kernel
> invokes the LoadFile2 protocol.
>

Thanks for adding the support for LoadFile2 protocol. This was one of
the blockers for full RISC-V support.
How do you prefer to proceed with RISC-V support ?

For RISC-V, we just need to move the arm64 loader to a common file so
that both RISC-V/ARM64 can use it apart from
few header file fixes. During the last attempt[1], I moved it to
loader/efi/linux.c.

I am happy to test it on Qemu/hardware, if you want to send the series
either part of this one or a separate series.
I can rebase my previous series on top of this series as well. Please
let me know your preference.

[1] https://www.mail-archive.com/grub-devel@gnu.org/msg30107.html

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> ---
>  grub-core/loader/arm64/linux.c | 109 +++++++++++++++++++-
>  1 file changed, 108 insertions(+), 1 deletion(-)
>
> diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
> index 28ff8584a3b5..c6a95e1f0c43 100644
> --- a/grub-core/loader/arm64/linux.c
> +++ b/grub-core/loader/arm64/linux.c
> @@ -48,6 +48,10 @@ static grub_uint32_t cmdline_size;
>  static grub_addr_t initrd_start;
>  static grub_addr_t initrd_end;
>
> +static struct grub_linux_initrd_context initrd_ctx = { 0, 0, 0 };
> +static grub_efi_handle_t initrd_lf2_handle;
> +static int initrd_use_loadfile2;
> +
>  grub_err_t
>  grub_arch_efi_linux_load_image_header (grub_file_t file,
>                                        struct linux_arch_kernel_header * lh)
> @@ -81,6 +85,18 @@ grub_arch_efi_linux_load_image_header (grub_file_t file,
>         return grub_error(GRUB_ERR_FILE_READ_ERROR, "failed to read COFF image header");
>      }
>
> +  /*
> +   * Linux kernels built for any architecture are guaranteed to support the
> +   * LoadFile2 based initrd loading protocol if the image version is >= 1.
> +   */
> +  if (lh->coff_image_header.optional_header.major_image_version >= 1)
> +    initrd_use_loadfile2 = 1;
> +  else
> +    initrd_use_loadfile2 = 0;
> +
> +  grub_dprintf ("linux", "LoadFile2 initrd loading %sabled\n",
> +               initrd_use_loadfile2 ? "en" : "dis");
> +
>    return GRUB_ERR_NONE;
>  }
>
> @@ -250,13 +266,86 @@ allocate_initrd_mem (int initrd_pages)
>                                        GRUB_EFI_LOADER_DATA);
>  }
>
> +struct initrd_media_device_path {
> +  grub_efi_vendor_media_device_path_t  vendor;
> +  grub_efi_device_path_t               end;
> +} GRUB_PACKED;
> +
> +#define LINUX_EFI_INITRD_MEDIA_GUID  \
> +  { 0x5568e427, 0x68fc, 0x4f3d, \
> +    { 0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68 } \
> +  }
> +
> +static struct initrd_media_device_path initrd_lf2_device_path = {
> +  {
> +    {
> +      GRUB_EFI_MEDIA_DEVICE_PATH_TYPE,
> +      GRUB_EFI_VENDOR_MEDIA_DEVICE_PATH_SUBTYPE,
> +      sizeof(grub_efi_vendor_media_device_path_t),
> +    },
> +    LINUX_EFI_INITRD_MEDIA_GUID
> +  }, {
> +    GRUB_EFI_END_DEVICE_PATH_TYPE,
> +    GRUB_EFI_END_ENTIRE_DEVICE_PATH_SUBTYPE,
> +    sizeof(grub_efi_device_path_t)
> +  }
> +};
> +
> +static grub_efi_status_t initrd_load_file2(grub_efi_load_file2_t *this,
> +                                          grub_efi_device_path_t *device_path,
> +                                          grub_efi_boolean_t boot_policy,
> +                                          grub_efi_uintn_t *buffer_size,
> +                                          void *buffer);
> +
> +static grub_efi_load_file2_t initrd_lf2 = {
> +  initrd_load_file2
> +};
> +
> +static grub_efi_status_t initrd_load_file2(grub_efi_load_file2_t *this,
> +                                          grub_efi_device_path_t *device_path,
> +                                          grub_efi_boolean_t boot_policy,
> +                                          grub_efi_uintn_t *buffer_size,
> +                                          void *buffer)
> +{
> +  grub_efi_status_t status = GRUB_EFI_SUCCESS;
> +  grub_efi_uintn_t initrd_size;
> +
> +  if (!this || this != &initrd_lf2 || !buffer_size)
> +    return GRUB_EFI_INVALID_PARAMETER;
> +
> +  if (device_path->type != GRUB_EFI_END_DEVICE_PATH_TYPE ||
> +      device_path->subtype != GRUB_EFI_END_ENTIRE_DEVICE_PATH_SUBTYPE)
> +    return GRUB_EFI_NOT_FOUND;
> +
> +  if (boot_policy)
> +    return GRUB_EFI_UNSUPPORTED;
> +
> +  initrd_size = grub_get_initrd_size (&initrd_ctx);
> +  if (!buffer || *buffer_size < initrd_size)
> +    {
> +      *buffer_size = initrd_size;
> +      return GRUB_EFI_BUFFER_TOO_SMALL;
> +    }
> +
> +  grub_dprintf ("linux", "Loading initrd via LOAD_FILE2_PROTOCOL\n");
> +
> +  if (grub_initrd_load (&initrd_ctx, NULL, buffer))
> +    status = GRUB_EFI_LOAD_ERROR;
> +
> +  grub_initrd_close (&initrd_ctx);
> +  return status;
> +}
> +
>  static grub_err_t
>  grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
>                  int argc, char *argv[])
>  {
> -  struct grub_linux_initrd_context initrd_ctx = { 0, 0, 0 };
>    int initrd_size, initrd_pages;
>    void *initrd_mem = NULL;
> +  grub_efi_guid_t load_file2_guid = GRUB_EFI_LOAD_FILE2_PROTOCOL_GUID;
> +  grub_efi_guid_t device_path_guid = GRUB_EFI_DEVICE_PATH_GUID;
> +  grub_efi_boot_services_t *b;
> +  grub_efi_status_t status;
>
>    if (argc == 0)
>      {
> @@ -274,6 +363,24 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
>    if (grub_initrd_init (argc, argv, &initrd_ctx))
>      goto fail;
>
> +  if (initrd_use_loadfile2)
> +    {
> +      b = grub_efi_system_table->boot_services;
> +      status = b->install_multiple_protocol_interfaces (&initrd_lf2_handle,
> +                                                       &load_file2_guid,
> +                                                       &initrd_lf2,
> +                                                       &device_path_guid,
> +                                                       &initrd_lf2_device_path,
> +                                                       NULL);
> +      if (status == GRUB_EFI_OUT_OF_RESOURCES)
> +       {
> +         grub_error (GRUB_ERR_OUT_OF_MEMORY, N_("out of memory"));
> +         return grub_errno;
> +       }
> +      grub_dprintf ("linux", "LoadFile2 initrd loading protocol installed\n");
> +      return GRUB_ERR_NONE;
> +    }
> +
>    initrd_size = grub_get_initrd_size (&initrd_ctx);
>    grub_dprintf ("linux", "Loading initrd\n");
>
> --
> 2.17.1
>


-- 
Regards,
Atish
