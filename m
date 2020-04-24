Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9170F1B76B9
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDXNP6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgDXNP6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:15:58 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54E082064C;
        Fri, 24 Apr 2020 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587734157;
        bh=UfO8sRYKuo/pz1Q45H7AZOBfZwv38wx8cPJ/ibe3tPM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W9lJ5dfY/6a5Tc7qyKlXFG0/YfXzha8L6ct/q39+9gIoZzU7cE/YdUvNrOvngXa/s
         +C28giA6sHUStBr9u7PriK8PY8yUKSHB6dQ69hbBaXYBpAGXIbVH0Lw+53SdwkbNxc
         R9kfc/7CVCIVbbsPzKcAdkKB6/QT4w0DHlFiE38Q=
Received: by mail-io1-f43.google.com with SMTP id k6so10287089iob.3;
        Fri, 24 Apr 2020 06:15:57 -0700 (PDT)
X-Gm-Message-State: AGi0PuZMtd/YppFIKHdRSM/NoCoyqvDpxRrUwrfgIGJwsebQv8kaWI3R
        cLkLnN6vLiapr3jGuhmIWuIlBnsGfD9O254axwY=
X-Google-Smtp-Source: APiQypKY/SzfZ+A1Se0pe3wJTUiJ3PKRGi+s4MQi4645cKSc5Z27DyuQpKXmBBrS31TBp6w+NQFGhM7HWek0QV9Na/I=
X-Received: by 2002:a6b:5904:: with SMTP id n4mr8750114iob.142.1587734156649;
 Fri, 24 Apr 2020 06:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200424130531.30518-1-ardb@kernel.org> <20200424130531.30518-3-ardb@kernel.org>
In-Reply-To: <20200424130531.30518-3-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Apr 2020 15:15:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHxG_7Om=O5XJCAGrWEUnOBoNLvF20amSc=5JegCdFqew@mail.gmail.com>
Message-ID: <CAMj1kXHxG_7Om=O5XJCAGrWEUnOBoNLvF20amSc=5JegCdFqew@mail.gmail.com>
Subject: Re: [PATCH 02/33] efi/libstub: Make initrd file loader configurable
To:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 24 Apr 2020 at 15:06, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Loading an initrd passed via the kernel command line is deprecated: it
> is limited to files that reside in the same volume as the one the kernel
> itself was loaded from, and we have more flexible ways to achieve the
> same. So make it configurable so new architectures can decide not to
> enable it.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/Kconfig           | 11 ++++++++
>  drivers/firmware/efi/libstub/efistub.h | 38 ++++++++++++++++++++------
>  drivers/firmware/efi/libstub/file.c    | 32 +++++-----------------
>  3 files changed, 47 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 2a2b2b96a1dc..4e788dd55b03 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -124,6 +124,17 @@ config EFI_ARMSTUB_DTB_LOADER
>           functionality for bootloaders that do not have such support
>           this option is necessary.
>
> +config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
> +       bool "Enable the command line initrd loader"
> +       depends on EFI_GENERIC_STUB

Right after hitting send, I realised this should be

depends on EFI_GENERIC_STUB || X86

Care to fix that up before applying, please?



> +       default y
> +       help
> +         Select this config option to add support for the initrd= command
> +         line parameter, allowing an initrd that resides on the same volume
> +         as the kernel image to be loaded into memory.
> +
> +         This method is deprecated.
> +
>  config EFI_BOOTLOADER_CONTROL
>         tristate "EFI Bootloader Control"
>         depends on EFI_VARS
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 67d26949fd26..7517683b31e9 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -651,15 +651,35 @@ efi_status_t efi_parse_options(char const *cmdline);
>  efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
>                            unsigned long size);
>
> -efi_status_t efi_load_dtb(efi_loaded_image_t *image,
> -                         unsigned long *load_addr,
> -                         unsigned long *load_size);
> -
> -efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> -                            unsigned long *load_addr,
> -                            unsigned long *load_size,
> -                            unsigned long soft_limit,
> -                            unsigned long hard_limit);
> +efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
> +                                 const efi_char16_t *optstr,
> +                                 int optstr_size,
> +                                 unsigned long soft_limit,
> +                                 unsigned long hard_limit,
> +                                 unsigned long *load_addr,
> +                                 unsigned long *load_size);
> +
> +
> +static inline efi_status_t efi_load_dtb(efi_loaded_image_t *image,
> +                                       unsigned long *load_addr,
> +                                       unsigned long *load_size)
> +{
> +       return handle_cmdline_files(image, L"dtb=", sizeof(L"dtb=") - 2,
> +                                   ULONG_MAX, ULONG_MAX, load_addr, load_size);
> +}
> +
> +static inline efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> +                                          unsigned long *load_addr,
> +                                          unsigned long *load_size,
> +                                          unsigned long soft_limit,
> +                                          unsigned long hard_limit)
> +{
> +       if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER))
> +               return EFI_SUCCESS;
> +
> +       return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
> +                                   soft_limit, hard_limit, load_addr, load_size);
> +}
>
>  efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
>                                       unsigned long *load_size,
> diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
> index ea66b1f16a79..27e014ea4459 100644
> --- a/drivers/firmware/efi/libstub/file.c
> +++ b/drivers/firmware/efi/libstub/file.c
> @@ -121,13 +121,13 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
>   * We only support loading a file from the same filesystem as
>   * the kernel image.
>   */
> -static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
> -                                        const efi_char16_t *optstr,
> -                                        int optstr_size,
> -                                        unsigned long soft_limit,
> -                                        unsigned long hard_limit,
> -                                        unsigned long *load_addr,
> -                                        unsigned long *load_size)
> +efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
> +                                 const efi_char16_t *optstr,
> +                                 int optstr_size,
> +                                 unsigned long soft_limit,
> +                                 unsigned long hard_limit,
> +                                 unsigned long *load_addr,
> +                                 unsigned long *load_size)
>  {
>         const efi_char16_t *cmdline = image->load_options;
>         int cmdline_len = image->load_options_size / 2;
> @@ -239,21 +239,3 @@ static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
>         efi_free(alloc_size, alloc_addr);
>         return status;
>  }
> -
> -efi_status_t efi_load_dtb(efi_loaded_image_t *image,
> -                         unsigned long *load_addr,
> -                         unsigned long *load_size)
> -{
> -       return handle_cmdline_files(image, L"dtb=", sizeof(L"dtb=") - 2,
> -                                   ULONG_MAX, ULONG_MAX, load_addr, load_size);
> -}
> -
> -efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> -                            unsigned long *load_addr,
> -                            unsigned long *load_size,
> -                            unsigned long soft_limit,
> -                            unsigned long hard_limit)
> -{
> -       return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
> -                                   soft_limit, hard_limit, load_addr, load_size);
> -}
> --
> 2.17.1
>
