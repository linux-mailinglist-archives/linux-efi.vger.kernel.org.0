Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE191C0665
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgD3T36 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 15:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgD3T36 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Apr 2020 15:29:58 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0788D207DD;
        Thu, 30 Apr 2020 19:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588274998;
        bh=dqOhFaVS/FHSwNgYPL+ZhKklnBTId0tcH+qEXB2Z4SI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cot2utlG3y0Gt/oOfcDlDE+GNGkj/OyGc4H5wTmvXaDy1uDnixBKkzv2Sue2Yo+By
         iUiT3TD1+3PzV+L+7OxY/2zFwLq04r7VsLb5K2kwWgjKUOw8Iid3+MxORM5j9bTe4b
         uLfc3pgMAGlVveHj1oCst4LSaHbRx4AjC0iFycRA=
Received: by mail-io1-f48.google.com with SMTP id w4so2734251ioc.6;
        Thu, 30 Apr 2020 12:29:58 -0700 (PDT)
X-Gm-Message-State: AGi0Pub4dP6ZVDvVWW2C2xQg+MfD3IUaX3O4u7KikLBNdTYGkDm6Qdys
        I/O6fS1SlnY+pwWDRVynCulZrf9/M1pFr+NwoA0=
X-Google-Smtp-Source: APiQypLWAJ1YdntzLHZLjMYVxGRBKiRsbrCNSKOvHqF1XCfzaw2CvWW2UMzg+mi/2CSg3LGdl28pif/t+uvM3xHv2DU=
X-Received: by 2002:a6b:5904:: with SMTP id n4mr380223iob.142.1588274997255;
 Thu, 30 Apr 2020 12:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182843.2510180-1-nivedita@alum.mit.edu> <091e3fc3bdbc5f480af7d3b3ac096d174a4480d0.1588273612.git.joe@perches.com>
In-Reply-To: <091e3fc3bdbc5f480af7d3b3ac096d174a4480d0.1588273612.git.joe@perches.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 30 Apr 2020 21:29:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGMnTfYiU_vMDYG0uy7Na7wy=5DRHERTzZQeb4UBusn0g@mail.gmail.com>
Message-ID: <CAMj1kXGMnTfYiU_vMDYG0uy7Na7wy=5DRHERTzZQeb4UBusn0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/libstub: efi_info/efi_err message neatening
To:     Joe Perches <joe@perches.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 30 Apr 2020 at 21:12, Joe Perches <joe@perches.com> wrote:
>
> Use a standard style for these output logging messages.
>
> Miscellanea:
>
> o Use more common macro #defines with fmt, ##__VA_ARGS__
> 0 Remove trailing messages periods and odd ' uses
> o Remove embedded function names and use %s, __func__
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> Perhaps these trivialities on top of this series?
>

The EFI printing routines don't actually support format strings.

Removing trailing periods is not really necessary IMO, but i'll take a
patch that fixes those weird quotes.

Thanks,
Ard.



>  drivers/firmware/efi/libstub/arm32-stub.c | 10 +++++-----
>  drivers/firmware/efi/libstub/efi-stub.c   |  2 +-
>  drivers/firmware/efi/libstub/efistub.h    |  9 ++++++---
>  drivers/firmware/efi/libstub/fdt.c        |  8 ++++----
>  drivers/firmware/efi/libstub/pci.c        |  4 ++--
>  drivers/firmware/efi/libstub/relocate.c   |  2 +-
>  drivers/firmware/efi/libstub/secureboot.c |  4 ++--
>  7 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
> index b038afe..5795781 100644
> --- a/drivers/firmware/efi/libstub/arm32-stub.c
> +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> @@ -120,7 +120,7 @@ static efi_status_t reserve_kernel_base(unsigned long dram_base,
>          */
>         status = efi_get_memory_map(&map);
>         if (status != EFI_SUCCESS) {
> -               efi_err("reserve_kernel_base(): Unable to retrieve memory map.\n");
> +               efi_err("%s(): Unable to retrieve memory map\n", __func__);
>                 return status;
>         }
>
> @@ -162,7 +162,7 @@ static efi_status_t reserve_kernel_base(unsigned long dram_base,
>                                              (end - start) / EFI_PAGE_SIZE,
>                                              &start);
>                         if (status != EFI_SUCCESS) {
> -                               efi_err("reserve_kernel_base(): alloc failed.\n");
> +                               efi_err("%s(): alloc failed\n", __func__);
>                                 goto out;
>                         }
>                         break;
> @@ -219,7 +219,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>
>         status = reserve_kernel_base(kernel_base, reserve_addr, reserve_size);
>         if (status != EFI_SUCCESS) {
> -               efi_err("Unable to allocate memory for uncompressed kernel.\n");
> +               efi_err("Unable to allocate memory for uncompressed kernel\n");
>                 return status;
>         }
>
> @@ -232,7 +232,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>         status = efi_relocate_kernel(image_addr, *image_size, *image_size,
>                                      kernel_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
>         if (status != EFI_SUCCESS) {
> -               efi_err("Failed to relocate kernel.\n");
> +               efi_err("Failed to relocate kernel\n");
>                 efi_free(*reserve_size, *reserve_addr);
>                 *reserve_size = 0;
>                 return status;
> @@ -244,7 +244,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>          * address at which the zImage is loaded.
>          */
>         if (*image_addr + *image_size > dram_base + ZIMAGE_OFFSET_LIMIT) {
> -               efi_err("Failed to relocate kernel, no low memory available.\n");
> +               efi_err("Failed to relocate kernel, no low memory available\n");
>                 efi_free(*reserve_size, *reserve_addr);
>                 *reserve_size = 0;
>                 efi_free(*image_size, *image_addr);
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index c2484b..19b42b 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -251,7 +251,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
>         if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
>              secure_boot != efi_secureboot_mode_disabled) {
>                 if (strstr(cmdline_ptr, "dtb="))
> -                       efi_err("Ignoring DTB from command line.\n");
> +                       efi_err("Ignoring DTB from command line\n");
>         } else {
>                 status = efi_load_dtb(image, &fdt_addr, &fdt_size);
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 874233..369262 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -49,11 +49,14 @@ extern const efi_system_table_t *efi_system_table;
>  #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
>  #endif
>
> -#define efi_info(msg)          do {                    \
> -       if (!efi_quiet) efi_printk("EFI stub: "msg);    \
> +#define efi_info(fmt, ...)                                             \
> +do {                                                                   \
> +       if (!efi_quiet)                                                 \
> +               efi_printk("EFI stub: " fmt, ##__VA_ARGS__);            \
>  } while (0)
>
> -#define efi_err(msg) efi_printk("EFI stub: ERROR: "msg)
> +#define efi_err(fmt, ...)                                              \
> +       efi_printk("EFI stub: ERROR: " fmt, ##__VA_ARGS__)
>
>  /* Helper macros for the usual case of using simple C variables: */
>  #ifndef fdt_setprop_inplace_var
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 11ecf3c..7c7257 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -270,7 +270,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>          */
>         status = efi_get_memory_map(&map);
>         if (status != EFI_SUCCESS) {
> -               efi_err("Unable to retrieve UEFI memory map.\n");
> +               efi_err("Unable to retrieve UEFI memory map\n");
>                 return status;
>         }
>
> @@ -279,7 +279,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>         map.map = &memory_map;
>         status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, max_addr);
>         if (status != EFI_SUCCESS) {
> -               efi_err("Unable to allocate memory for new device tree.\n");
> +               efi_err("Unable to allocate memory for new device tree\n");
>                 goto fail;
>         }
>
> @@ -296,7 +296,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>                             initrd_addr, initrd_size);
>
>         if (status != EFI_SUCCESS) {
> -               efi_err("Unable to construct new device tree.\n");
> +               efi_err("Unable to construct new device tree\n");
>                 goto fail_free_new_fdt;
>         }
>
> @@ -342,7 +342,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>                 return EFI_SUCCESS;
>         }
>
> -       efi_err("Exit boot services failed.\n");
> +       efi_err("Exit boot services failed\n");
>
>  fail_free_new_fdt:
>         efi_free(MAX_FDT_SIZE, *new_fdt_addr);
> diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
> index 60af51b..111c44b 100644
> --- a/drivers/firmware/efi/libstub/pci.c
> +++ b/drivers/firmware/efi/libstub/pci.c
> @@ -28,7 +28,7 @@ void efi_pci_disable_bridge_busmaster(void)
>
>         if (status != EFI_BUFFER_TOO_SMALL) {
>                 if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
> -                       efi_err("Failed to locate PCI I/O handles'\n");
> +                       efi_err("Failed to locate PCI I/O handles\n");
>                 return;
>         }
>
> @@ -42,7 +42,7 @@ void efi_pci_disable_bridge_busmaster(void)
>         status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL, &pci_proto,
>                              NULL, &pci_handle_size, pci_handle);
>         if (status != EFI_SUCCESS) {
> -               efi_err("Failed to locate PCI I/O handles'\n");
> +               efi_err("Failed to locate PCI I/O handles\n");
>                 goto free_handle;
>         }
>
> diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
> index 93c04d..62e2d6 100644
> --- a/drivers/firmware/efi/libstub/relocate.c
> +++ b/drivers/firmware/efi/libstub/relocate.c
> @@ -157,7 +157,7 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
>                                              min_addr);
>         }
>         if (status != EFI_SUCCESS) {
> -               efi_err("Failed to allocate usable memory for kernel.\n");
> +               efi_err("Failed to allocate usable memory for kernel\n");
>                 return status;
>         }
>
> diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
> index 5efc524..796a31 100644
> --- a/drivers/firmware/efi/libstub/secureboot.c
> +++ b/drivers/firmware/efi/libstub/secureboot.c
> @@ -67,10 +67,10 @@ enum efi_secureboot_mode efi_get_secureboot(void)
>                 return efi_secureboot_mode_disabled;
>
>  secure_boot_enabled:
> -       efi_info("UEFI Secure Boot is enabled.\n");
> +       efi_info("UEFI Secure Boot is enabled\n");
>         return efi_secureboot_mode_enabled;
>
>  out_efi_err:
> -       efi_err("Could not determine UEFI Secure Boot status.\n");
> +       efi_err("Could not determine UEFI Secure Boot status\n");
>         return efi_secureboot_mode_unknown;
>  }
> --
> 2.26.0
>
