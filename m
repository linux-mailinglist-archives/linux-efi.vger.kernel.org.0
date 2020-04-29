Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4FD1BE6EB
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgD2TGE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 15:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2TGE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 Apr 2020 15:06:04 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697E7205C9;
        Wed, 29 Apr 2020 19:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588187162;
        bh=WuJYQ53ZkuOkwgAjoJ5v5zI5lMg0jLRl2QUYDwYstGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QAucFIjryzdTB3MyJ5PH8Cw2+3i0fw2jgIwjXRshQa4NuL1TApobXKBGF+uxTq5qr
         P9kFV91tKxs3qSHVHy1elOWnyZRFM7VFSTxjlWWnqrkPitUmjtP791Ghd7hSFQm7Zp
         sJooFnsXX0aLbR+XSN19tbDrDOLRQXmZNqrYxG50=
Received: by mail-il1-f179.google.com with SMTP id u189so3539193ilc.4;
        Wed, 29 Apr 2020 12:06:02 -0700 (PDT)
X-Gm-Message-State: AGi0Pubc0M1wYmaimuQdSb4VSjv+uIZPMRLUKkJMbxQd12G8ANLi6AXH
        ZQOwNGfTfilsTpkNbA+zmelKoEv61iV0aTo6tVw=
X-Google-Smtp-Source: APiQypKWF7h0IYUs2F+80QDQY64o1jJn/LQ0m4ZctaBgGd+HchHNkvgxpxJ3zt+7YTF6UM0EZg+KdyYYte00vghL5Q0=
X-Received: by 2002:a92:39dd:: with SMTP id h90mr4635659ilf.80.1588187161819;
 Wed, 29 Apr 2020 12:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200429174120.1497212-1-nivedita@alum.mit.edu> <20200429174120.1497212-10-nivedita@alum.mit.edu>
In-Reply-To: <20200429174120.1497212-10-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Apr 2020 21:05:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFe0eEHnijuB3OGM2moHw0xH5viFvCiQ6Y0cLG7s=iHfg@mail.gmail.com>
Message-ID: <CAMj1kXFe0eEHnijuB3OGM2moHw0xH5viFvCiQ6Y0cLG7s=iHfg@mail.gmail.com>
Subject: Re: [PATCH 08/10] efi/x86: Drop soft_limit for x86 initrd loading
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 29 Apr 2020 at 19:41, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Currently the EFI stub attempts to load initrd(s) specified on the
> command line below hdr->initrd_addr_max (2G) and if that fails, falls
> back to allocating at an unrestricted address.
>
> The only case when loading at a low address helps is for the 32-bit
> kernel, where the initrd must be copied by the kernel into lowmem if
> it's not there already. The limit specified in hdr->initrd_addr_max is
> insufficient to ensure this in any case, since lowmem by default will
> extend to about 0.9G rather than 2G, and we don't attempt to load the
> initrd in lowmem at all for the new device-path based initrd.
>
> Simplify the code by dropping this optimization for the command line
> initrd(s) as well.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

It is not really an optimization, unfortunately. Commit 47226ad4f4cfd
has the details, but in short, loading above 4 GB broke some
platforms, so below 4 GB had to remain the default.

This was 6 years ago, and so we might be able to revisit this, but
characterising it as a mere optimization is inaccurate.


> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 14 +++++---------
>  drivers/firmware/efi/libstub/efi-stub.c        |  3 +--
>  drivers/firmware/efi/libstub/efistub.h         |  8 +++-----
>  drivers/firmware/efi/libstub/file.c            | 13 ++-----------
>  drivers/firmware/efi/libstub/x86-stub.c        |  3 +--
>  5 files changed, 12 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 2c0c2c34b4cc..32768fa04b32 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -378,8 +378,7 @@ static
>  efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
>                                      unsigned long *load_addr,
>                                      unsigned long *load_size,
> -                                    unsigned long soft_limit,
> -                                    unsigned long hard_limit)
> +                                    unsigned long max)
>  {
>         if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER) ||
>             (IS_ENABLED(CONFIG_X86) && (!efi_is_native() || image == NULL))) {
> @@ -388,27 +387,24 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
>         }
>
>         return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
> -                                   soft_limit, hard_limit,
> -                                   load_addr, load_size);
> +                                   max, load_addr, load_size);
>  }
>
>  efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>                              unsigned long *load_addr,
>                              unsigned long *load_size,
> -                            unsigned long soft_limit,
> -                            unsigned long hard_limit)
> +                            unsigned long max)
>  {
>         efi_status_t status;
>
>         if (!load_addr || !load_size)
>                 return EFI_INVALID_PARAMETER;
>
> -       status = efi_load_initrd_dev_path(load_addr, load_size, hard_limit);
> +       status = efi_load_initrd_dev_path(load_addr, load_size, max);
>         if (status == EFI_SUCCESS) {
>                 pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
>         } else if (status == EFI_NOT_FOUND) {
> -               status = efi_load_initrd_cmdline(image, load_addr, load_size,
> -                                                soft_limit, hard_limit);
> +               status = efi_load_initrd_cmdline(image, load_addr, load_size, max);
>                 if (status == EFI_SUCCESS && *load_size > 0)
>                         pr_efi("Loaded initrd from command line option\n");
>         }
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index d8f24f5c91bd..930302d9415a 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -265,8 +265,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
>
>         if (!efi_noinitrd) {
>                 max_addr = efi_get_max_initrd_addr(dram_base, image_addr);
> -               status = efi_load_initrd(image, &initrd_addr, &initrd_size,
> -                                        ULONG_MAX, max_addr);
> +               status = efi_load_initrd(image, &initrd_addr, &initrd_size, max_addr);
>                 if (status != EFI_SUCCESS)
>                         pr_efi_err("Failed to load initrd!\n");
>         }
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index dfdd7954bf58..1ba0887818d9 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -663,8 +663,7 @@ efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
>  efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
>                                   const efi_char16_t *optstr,
>                                   int optstr_size,
> -                                 unsigned long soft_limit,
> -                                 unsigned long hard_limit,
> +                                 unsigned long max,
>                                   unsigned long *load_addr,
>                                   unsigned long *load_size);
>
> @@ -674,13 +673,12 @@ static inline efi_status_t efi_load_dtb(efi_loaded_image_t *image,
>                                         unsigned long *load_size)
>  {
>         return handle_cmdline_files(image, L"dtb=", sizeof(L"dtb=") - 2,
> -                                   ULONG_MAX, ULONG_MAX, load_addr, load_size);
> +                                   ULONG_MAX, load_addr, load_size);
>  }
>
>  efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>                              unsigned long *load_addr,
>                              unsigned long *load_size,
> -                            unsigned long soft_limit,
> -                            unsigned long hard_limit);
> +                            unsigned long max);
>
>  #endif
> diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
> index 50aaf15f9ad5..7dee3c5d81fb 100644
> --- a/drivers/firmware/efi/libstub/file.c
> +++ b/drivers/firmware/efi/libstub/file.c
> @@ -124,8 +124,7 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
>  efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
>                                   const efi_char16_t *optstr,
>                                   int optstr_size,
> -                                 unsigned long soft_limit,
> -                                 unsigned long hard_limit,
> +                                 unsigned long max,
>                                   unsigned long *load_addr,
>                                   unsigned long *load_size)
>  {
> @@ -181,15 +180,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
>                     round_up(alloc_size, EFI_ALLOC_ALIGN)) {
>                         unsigned long old_addr = alloc_addr;
>
> -                       status = EFI_OUT_OF_RESOURCES;
> -                       if (soft_limit < hard_limit)
> -                               status = efi_allocate_pages(alloc_size + size,
> -                                                           &alloc_addr,
> -                                                           soft_limit);
> -                       if (status == EFI_OUT_OF_RESOURCES)
> -                               status = efi_allocate_pages(alloc_size + size,
> -                                                           &alloc_addr,
> -                                                           hard_limit);
> +                       status = efi_allocate_pages(alloc_size + size, &alloc_addr, max);
>                         if (status != EFI_SUCCESS) {
>                                 pr_efi_err("Failed to allocate memory for files\n");
>                                 goto err_close_file;
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 1d3f94f1dafa..85a924fecc87 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -755,8 +755,7 @@ unsigned long efi_main(efi_handle_t handle,
>         if (!efi_noinitrd) {
>                 unsigned long addr, size;
>
> -               status = efi_load_initrd(image, &addr, &size,
> -                                        hdr->initrd_addr_max, ULONG_MAX);
> +               status = efi_load_initrd(image, &addr, &size, ULONG_MAX);
>
>                 if (status != EFI_SUCCESS) {
>                         pr_efi_err("Failed to load initrd!\n");
> --
> 2.26.2
>
