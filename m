Return-Path: <linux-efi+bounces-2331-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEDF9E9BF2
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 17:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7F5281A55
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 16:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB8514AD24;
	Mon,  9 Dec 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPRJ3r3Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489B014AD19;
	Mon,  9 Dec 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762452; cv=none; b=FaKDlHg/X+3CENNiA8YXhe8rhIVnKj9WQB1ej5iOgpVPyyvZhKA96d+3KiiMrJ8JVioGN0JgUth6Mfk2B9HdzixGPtHB4IDusqgTo2qOIeQD0poe+Aug9TkfS5Eh1mwWlqGgcjhFQffPCjvD63eCXlqZHHFFY0iNMUXq6R+C1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762452; c=relaxed/simple;
	bh=2YH9hsbk9BUYlRaw0AjEiD/6YOppO+5bV2Cn1CltciU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPjgH73QM02HXxI79xJc3O9+sv60x/l+FlbyeCkXe0c67CQocheGNmXrppHY7RstGwZiXP8mwffXKnXtf6KEwOLNl9/pPDGsuO0qT3k1bi1erJgPIRssidBsiwjzcG3HIZCaAQeMbH8nULJuSTrUVWx/Gsf5tSwYbsvpfz4Oq9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPRJ3r3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241F8C4CEE9;
	Mon,  9 Dec 2024 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733762452;
	bh=2YH9hsbk9BUYlRaw0AjEiD/6YOppO+5bV2Cn1CltciU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oPRJ3r3ZNg5XAaQq/ddYWZ10/bsTC8ay9kN7fs3qoMZaH8+wV7+Xxn32wJkNd9LT4
	 29aI58k8Z07/ENGam/nJgHnx9xg67DYbBLWcUcgU8sK3YABR0FdJZIJkdaUsPRm85u
	 jY9rYpqNhfeEdY/HOwfa9XHox6lCMfZFcd2eUh62dI1Rpfna1p/YL+O3AGOjC52zpz
	 I5tWbQsdAB4VNKag2aoEyJ8abDtqUK1kfOHaH0CA+qQ0U+BXnGYMxzxQ/2FcoYzGm7
	 MUFxV9rgg1chcJmxvZc+Elimnp28SV6U7QFEoukQVyjfkcF/w2WDy2enTKK1np8xYD
	 krqqor2uSSz2w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e3778bffdso3151238e87.0;
        Mon, 09 Dec 2024 08:40:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjxPMY2bpfHYESOeQr7I7QHmisvZ8zsCqEL94ObxC+Y/Niq3C94CGCA9f6mGuDp8TCiy3oLN1erj7QJlI=@vger.kernel.org, AJvYcCWlz4ceBt9DT+CaG/ygMprS11w1/rF4y+cMRFYBlErUEPp0N8IGuMnhWK9X8HEYr6zAIZOCalIJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbTGurJ6ii6U7g5P/eIarqsVALQzRUqZSUWduYHpUQK2QE9+i
	y6u7rdwHguJu8qocpcprSR/9zTaCrS9Xve1BSj5LGl8i71RnGBxgj7K3h7/3bjwVm+oENq99aeh
	/463uNTuj1DIBdW7lOgbjAIr57rI=
X-Google-Smtp-Source: AGHT+IE/8DE0dfbEwG+Wqb59z111GYonaD1p6VbmjBAEq5VgM410O9jD6dhoLoJ9EjrzdnDdZCErQ8NcrtGjlhTL2iI=
X-Received: by 2002:a05:6512:39d1:b0:53e:3a01:cf47 with SMTP id
 2adb3069b0e04-540240b0fecmr573900e87.4.1733762450303; Mon, 09 Dec 2024
 08:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209162449.48390-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20241209162449.48390-1-hamzamahfooz@linux.microsoft.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 9 Dec 2024 17:40:39 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF=f-QAhXJA=U=jbn++Vyzf+e2k+cCS+Jk4Om4p0puD5Q@mail.gmail.com>
Message-ID: <CAMj1kXF=f-QAhXJA=U=jbn++Vyzf+e2k+cCS+Jk4Om4p0puD5Q@mail.gmail.com>
Subject: Re: [PATCH] efi: make the min and max mmap slack slots configurable
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-efi@vger.kernel.org, stable@vger.kernel.org, 
	Tyler Hicks <code@tyhicks.com>, Brian Nguyen <nguyenbrian@microsoft.com>, 
	Jacob Pan <panj@microsoft.com>, Allen Pais <apais@microsoft.com>, 
	Jonathan Marek <jonathan@marek.ca>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jeremy Linton <jeremy.linton@arm.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	=?UTF-8?B?S09ORE8gS0FaVU1BKOi/keiXpCDlkoznnJ8p?= <kazuma-kondo@nec.com>, 
	Kees Cook <kees@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, Yuntao Wang <ytcoode@gmail.com>, 
	Aditya Garg <gargaditya08@live.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Hamza,

Thanks for the patch.

On Mon, 9 Dec 2024 at 17:25, Hamza Mahfooz
<hamzamahfooz@linux.microsoft.com> wrote:
>
> Recent platforms

Which platforms are you referring to here?

> require more slack slots than the current value of
> EFI_MMAP_NR_SLACK_SLOTS, otherwise they fail to boot. So, introduce
> EFI_MIN_NR_MMAP_SLACK_SLOTS and EFI_MAX_NR_MMAP_SLACK_SLOTS
> and use them to determine a number of slots that the platform
> is willing to accept.
>

What does 'acceptance' mean in this case?

> Cc: stable@vger.kernel.org
> Cc: Tyler Hicks <code@tyhicks.com>
> Tested-by: Brian Nguyen <nguyenbrian@microsoft.com>
> Tested-by: Jacob Pan <panj@microsoft.com>
> Reviewed-by: Allen Pais <apais@microsoft.com>

I appreciate the effort of your colleagues, but if these
tested/reviewed-bys were not given on an open list, they are
meaningless, and I am going to drop them unless the people in question
reply to this thread.

> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  drivers/firmware/efi/Kconfig                  | 23 +++++++++++++++++
>  .../firmware/efi/libstub/efi-stub-helper.c    |  2 +-
>  drivers/firmware/efi/libstub/efistub.h        | 15 +----------
>  drivers/firmware/efi/libstub/kaslr.c          |  2 +-
>  drivers/firmware/efi/libstub/mem.c            | 25 +++++++++++++++----
>  drivers/firmware/efi/libstub/randomalloc.c    |  2 +-
>  drivers/firmware/efi/libstub/relocate.c       |  2 +-
>  drivers/firmware/efi/libstub/x86-stub.c       |  8 +++---
>  8 files changed, 52 insertions(+), 27 deletions(-)
>

This looks rather intrusive for a patch that is intended as cc:stable.

> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index e312d731f4a3..7fedc271d543 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -155,6 +155,29 @@ config EFI_TEST
>           Say Y here to enable the runtime services support via /dev/efi_test.
>           If unsure, say N.
>
> +#
> +# An efi_boot_memmap is used by efi_get_memory_map() to return the
> +# EFI memory map in a dynamically allocated buffer.
> +#
> +# The buffer allocated for the EFI memory map includes extra room for
> +# a range of [EFI_MIN_NR_MMAP_SLACK_SLOTS, EFI_MAX_NR_MMAP_SLACK_SLOTS]
> +# additional EFI memory descriptors. This facilitates the reuse of the
> +# EFI memory map buffer when a second call to ExitBootServices() is
> +# needed because of intervening changes to the EFI memory map. Other
> +# related structures, e.g. x86 e820ext, need to factor in this headroom
> +# requirement as well.
> +#
> +
> +config EFI_MIN_NR_MMAP_SLACK_SLOTS
> +       int
> +       depends on EFI
> +       default 8
> +
> +config EFI_MAX_NR_MMAP_SLACK_SLOTS
> +       int
> +       depends on EFI
> +       default 64
> +

What would be the reason for not always bumping this to 64?

>  config EFI_DEV_PATH_PARSER
>         bool
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index c0c81ca4237e..adf2b0c0dd34 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -432,7 +432,7 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
>         if (efi_disable_pci_dma)
>                 efi_pci_disable_bridge_busmaster();
>
> -       status = efi_get_memory_map(&map, true);
> +       status = efi_get_memory_map(&map, true, NULL);
>         if (status != EFI_SUCCESS)
>                 return status;
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 76e44c185f29..d86c6e13de5f 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -160,19 +160,6 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
>   */
>  #define EFI_100NSEC_PER_USEC   ((u64)10)
>
> -/*
> - * An efi_boot_memmap is used by efi_get_memory_map() to return the
> - * EFI memory map in a dynamically allocated buffer.
> - *
> - * The buffer allocated for the EFI memory map includes extra room for
> - * a minimum of EFI_MMAP_NR_SLACK_SLOTS additional EFI memory descriptors.
> - * This facilitates the reuse of the EFI memory map buffer when a second
> - * call to ExitBootServices() is needed because of intervening changes to
> - * the EFI memory map. Other related structures, e.g. x86 e820ext, need
> - * to factor in this headroom requirement as well.
> - */
> -#define EFI_MMAP_NR_SLACK_SLOTS        8
> -
>  typedef struct efi_generic_dev_path efi_device_path_protocol_t;
>
>  union efi_device_path_to_text_protocol {
> @@ -1059,7 +1046,7 @@ void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_si
>  char *efi_convert_cmdline(efi_loaded_image_t *image);
>
>  efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
> -                               bool install_cfg_tbl);
> +                               bool install_cfg_tbl, unsigned int *n);
>
>  efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
>                                 unsigned long max);
> diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
> index 6318c40bda38..06e7a1ef34ab 100644
> --- a/drivers/firmware/efi/libstub/kaslr.c
> +++ b/drivers/firmware/efi/libstub/kaslr.c
> @@ -62,7 +62,7 @@ static bool check_image_region(u64 base, u64 size)
>         bool ret = false;
>         int map_offset;
>
> -       status = efi_get_memory_map(&map, false);
> +       status = efi_get_memory_map(&map, false, NULL);
>         if (status != EFI_SUCCESS)
>                 return false;
>
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index 4f1fa302234d..cab25183b790 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -13,32 +13,47 @@
>   *                     configuration table
>   *
>   * Retrieve the UEFI memory map. The allocated memory leaves room for
> - * up to EFI_MMAP_NR_SLACK_SLOTS additional memory map entries.
> + * up to CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS additional memory map entries.
>   *
>   * Return:     status code
>   */
>  efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
> -                               bool install_cfg_tbl)
> +                               bool install_cfg_tbl,
> +                               unsigned int *n)

What is the purpose of 'n'? Having single letter names for function
parameters is not great for legibility.

>  {
>         int memtype = install_cfg_tbl ? EFI_ACPI_RECLAIM_MEMORY
>                                       : EFI_LOADER_DATA;
>         efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
> +       unsigned int nr = CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS;
>         struct efi_boot_memmap *m, tmp;
>         efi_status_t status;
>         unsigned long size;
>
> +       BUILD_BUG_ON(!is_power_of_2(CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS) ||
> +                    !is_power_of_2(CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS) ||
> +                    CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS >=
> +                    CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS);
> +
>         tmp.map_size = 0;
>         status = efi_bs_call(get_memory_map, &tmp.map_size, NULL, &tmp.map_key,
>                              &tmp.desc_size, &tmp.desc_ver);
>         if (status != EFI_BUFFER_TOO_SMALL)
>                 return EFI_LOAD_ERROR;
>
> -       size = tmp.map_size + tmp.desc_size * EFI_MMAP_NR_SLACK_SLOTS;
> -       status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
> -                            (void **)&m);
> +       do {
> +               size = tmp.map_size + tmp.desc_size * nr;
> +               status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
> +                                    (void **)&m);
> +               nr <<= 1;
> +       } while (status == EFI_BUFFER_TOO_SMALL &&
> +                nr <= CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS);
> +

Under what circumstances would you expect AllocatePool() to return
EFI_BUFFER_TOO_SMALL? What is the purpose of this loop?

How did you test this code?

>         if (status != EFI_SUCCESS)
>                 return status;
>
> +       if (n)
> +               *n = nr;
> +
>         if (install_cfg_tbl) {
>                 /*
>                  * Installing a configuration table might allocate memory, and
> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
> index c41e7b2091cd..e80a65e7b87a 100644
> --- a/drivers/firmware/efi/libstub/randomalloc.c
> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> @@ -65,7 +65,7 @@ efi_status_t efi_random_alloc(unsigned long size,
>         efi_status_t status;
>         int map_offset;
>
> -       status = efi_get_memory_map(&map, false);
> +       status = efi_get_memory_map(&map, false, NULL);
>         if (status != EFI_SUCCESS)
>                 return status;
>
> diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
> index d694bcfa1074..b7b0aad95ba4 100644
> --- a/drivers/firmware/efi/libstub/relocate.c
> +++ b/drivers/firmware/efi/libstub/relocate.c
> @@ -28,7 +28,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
>         unsigned long nr_pages;
>         int i;
>
> -       status = efi_get_memory_map(&map, false);
> +       status = efi_get_memory_map(&map, false, NULL);
>         if (status != EFI_SUCCESS)
>                 goto fail;
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 188c8000d245..cb14f0d2a3d9 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -740,15 +740,15 @@ static efi_status_t allocate_e820(struct boot_params *params,
>         struct efi_boot_memmap *map;
>         efi_status_t status;
>         __u32 nr_desc;
> +       __u32 nr;
>
> -       status = efi_get_memory_map(&map, false);
> +       status = efi_get_memory_map(&map, false, &nr);
>         if (status != EFI_SUCCESS)
>                 return status;
>
>         nr_desc = map->map_size / map->desc_size;
> -       if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
> -               u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) +
> -                                EFI_MMAP_NR_SLACK_SLOTS;
> +       if (nr_desc > ARRAY_SIZE(params->e820_table) - nr) {
> +               u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) + nr;
>
>                 status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
>         }
> --
> 2.47.1
>

