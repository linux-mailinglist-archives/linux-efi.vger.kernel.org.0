Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF01C9AFA
	for <lists+linux-efi@lfdr.de>; Thu,  7 May 2020 21:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGTYv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 May 2020 15:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgEGTYu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 7 May 2020 15:24:50 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C705E208D6;
        Thu,  7 May 2020 19:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879489;
        bh=wW6HapZyPKcAS2pniJhuefRACI9qGnuvgtx2jsOUUYE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tVFkrN62oIpbiYkxCjb/8By3qy2iMEIOcK+pWpF803xbdCZK8zJRavcXuPz8RhnBz
         Cfm9DLoGHTPTo6WudSn26XaNslq6BVQbLrY2I1T6t3/67Jm1OKkxaPCfBpmJjMaahS
         ONLGUPtYJwACf5Xt69gfZKdBghnpVBXq2Jk7rMOE=
Received: by mail-io1-f49.google.com with SMTP id 19so1709952ioz.10;
        Thu, 07 May 2020 12:24:49 -0700 (PDT)
X-Gm-Message-State: AGi0PuaJA+0C+9YYiKQtzQOgB24RfwS3p71pXh28BCoeMa3d1J9mFswx
        Ojlfq9HpstMYuj1Ej/DeN8N7FRdC2wyc9/kMMmg=
X-Google-Smtp-Source: APiQypLRkklJ7aV3gPOvJS6Io4eaLQ9MNmNRgbveyH5ByIhA36D82P/M8hjRUyBis2HMj1IJCsrQAqmip8GynNzHFQg=
X-Received: by 2002:a5d:8045:: with SMTP id b5mr15433368ior.16.1588879489201;
 Thu, 07 May 2020 12:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200507183332.6153-1-lszubowi@redhat.com>
In-Reply-To: <20200507183332.6153-1-lszubowi@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 May 2020 21:24:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE-ozARWTkRhaG3h0H6-2B_B3hgqp+tR7j0Ved8j3i53w@mail.gmail.com>
Message-ID: <CAMj1kXE-ozARWTkRhaG3h0H6-2B_B3hgqp+tR7j0Ved8j3i53w@mail.gmail.com>
Subject: Re: [PATCH V3] efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820()
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     eric.snowberg@oracle.com, Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 7 May 2020 at 20:33, Lenny Szubowicz <lszubowi@redhat.com> wrote:
>
> In allocate_e820(), call the EFI get_memory_map() service directly
> instead of indirectly via efi_get_memory_map(). This avoids allocation
> of a buffer and return of the full EFI memory map, which is not needed
> here and would otherwise need to be freed.
>
> Routine allocate_e820() only needs to know how many EFI memory
> descriptors there are in the map to allocate an adequately sized
> e820ext buffer, if it's needed. Note that since efi_get_memory_map()
> returns a memory map buffer sized with extra headroom, allocate_e820()
> now needs to explicitly factor that into the e820ext size calculation.
>
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>

Thanks Lenny. I'll get this queued up.

> --
> v3:
>   - Move define of EFI_MMAP_NR_SLACK_SLOTS to efistub.h instead
>     of providing a helper function to get it.
>
> v2:
>   - Instead of freeing the EFI memory map buffer allocated by
>     efi_get_memory_map(), avoid the allocation in the first place.
>
>   - Changed the title of the patch because the v1 title no longer
>     applies. v1 ref:
>     https://lore.kernel.org/lkml/20200505190016.4350-1-lszubowi@redhat.com/
> --
> ---
>  drivers/firmware/efi/libstub/efistub.h  | 13 +++++++++++++
>  drivers/firmware/efi/libstub/mem.c      |  2 --
>  drivers/firmware/efi/libstub/x86-stub.c | 22 ++++++++--------------
>  3 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 67d26949fd26..62943992f02f 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -92,6 +92,19 @@ extern __pure efi_system_table_t  *efi_system_table(void);
>  #define EFI_LOCATE_BY_REGISTER_NOTIFY          1
>  #define EFI_LOCATE_BY_PROTOCOL                 2
>
> +/*
> + * An efi_boot_memmap is used by efi_get_memory_map() to return the
> + * EFI memory map in a dynamically allocated buffer.
> + *
> + * The buffer allocated for the EFI memory map includes extra room for
> + * a minimum of EFI_MMAP_NR_SLACK_SLOTS additional EFI memory descriptors.
> + * This facilitates the reuse of the EFI memory map buffer when a second
> + * call to ExitBootServices() is needed because of intervening changes to
> + * the EFI memory map. Other related structures, e.g. x86 e820ext, need
> + * to factor in this headroom requirement as well.
> + */
> +#define EFI_MMAP_NR_SLACK_SLOTS        8
> +
>  struct efi_boot_memmap {
>         efi_memory_desc_t       **map;
>         unsigned long           *map_size;
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index 869a79c8946f..09f4fa01914e 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -5,8 +5,6 @@
>
>  #include "efistub.h"
>
> -#define EFI_MMAP_NR_SLACK_SLOTS        8
> -
>  static inline bool mmap_has_headroom(unsigned long buff_size,
>                                      unsigned long map_size,
>                                      unsigned long desc_size)
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 05ccb229fb45..a0aeb1cda8e3 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -606,24 +606,18 @@ static efi_status_t allocate_e820(struct boot_params *params,
>                                   struct setup_data **e820ext,
>                                   u32 *e820ext_size)
>  {
> -       unsigned long map_size, desc_size, buff_size;
> -       struct efi_boot_memmap boot_map;
> -       efi_memory_desc_t *map;
> +       unsigned long map_size, desc_size;
>         efi_status_t status;
>         __u32 nr_desc;
>
> -       boot_map.map            = &map;
> -       boot_map.map_size       = &map_size;
> -       boot_map.desc_size      = &desc_size;
> -       boot_map.desc_ver       = NULL;
> -       boot_map.key_ptr        = NULL;
> -       boot_map.buff_size      = &buff_size;
> +       /* Only need the size of the mem map and size of each mem descriptor */
> +       map_size = 0;
> +       status = efi_bs_call(get_memory_map, &map_size, NULL, NULL,
> +                            &desc_size, NULL);
> +       if (status != EFI_BUFFER_TOO_SMALL)
> +               return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
>
> -       status = efi_get_memory_map(&boot_map);
> -       if (status != EFI_SUCCESS)
> -               return status;
> -
> -       nr_desc = buff_size / desc_size;
> +       nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
>
>         if (nr_desc > ARRAY_SIZE(params->e820_table)) {
>                 u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
> --
> 2.18.4
>
