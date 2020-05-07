Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136E01C96B6
	for <lists+linux-efi@lfdr.de>; Thu,  7 May 2020 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEGQlZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 May 2020 12:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgEGQlY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 7 May 2020 12:41:24 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D708020B1F;
        Thu,  7 May 2020 16:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588869683;
        bh=DSUTjCCxNm3sP/U59GvleaC+aqqLrMMiFJPUPPM3rNg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rKqfVrO+PGON4u2l06umNYir1hgHA7wHRVwuBwBfI+d0VGPqQUAhEmABQ9jN/7jQP
         60F28/aaTaB4x1Rpogvd60KSPhW8osb7/zIRmn5DnohVSeaaZ8ctYellWiYlCAAoeq
         k6biTonvn/T1nILLNowzIeHnO+vq8CpRQ/LclJNc=
Received: by mail-il1-f176.google.com with SMTP id c16so1848295ilr.3;
        Thu, 07 May 2020 09:41:23 -0700 (PDT)
X-Gm-Message-State: AGi0PuYbQkdm+OJXI+nnGKIkjw/1zMe1ofwDeeJDgUHOXfcj+ziUFErj
        RtMbI0VMfjXDow6lPgg4lCIm/Z0/ujcEOvQlLG4=
X-Google-Smtp-Source: APiQypIj0KSdZxFox1BHJ/6cE4G6Uxkcc+tq2R3E3HWKuTRfFFPT2U4mqxVz355oahAkQQdP9Rj6pDgE7UpnhtQCCnU=
X-Received: by 2002:a92:3c55:: with SMTP id j82mr16149345ila.258.1588869683281;
 Thu, 07 May 2020 09:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200507133707.7123-1-lszubowi@redhat.com>
In-Reply-To: <20200507133707.7123-1-lszubowi@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 May 2020 18:41:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG69bsC-WCHhS1zturX0AuAJwMnfeNCEM5HXrRfkXjjPg@mail.gmail.com>
Message-ID: <CAMj1kXG69bsC-WCHhS1zturX0AuAJwMnfeNCEM5HXrRfkXjjPg@mail.gmail.com>
Subject: Re: [PATCH V2] efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820()
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

On Thu, 7 May 2020 at 15:37, Lenny Szubowicz <lszubowi@redhat.com> wrote:
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
> --
> v2:
>   - Instead of freeing the EFI memory map buffer allocated by
>     efi_get_memory_map(), avoid the allocation in the first place.
>
>   - Changed the title of the patch because the v1 title no longer
>     applies. v1 ref:
>     https://lore.kernel.org/lkml/20200505190016.4350-1-lszubowi@redhat.com/
> --
> ---
>  drivers/firmware/efi/libstub/efistub.h  |  2 ++
>  drivers/firmware/efi/libstub/mem.c      |  5 +++++
>  drivers/firmware/efi/libstub/x86-stub.c | 22 ++++++++--------------
>  3 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 67d26949fd26..191468b771b6 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -616,6 +616,8 @@ void efi_printk(char *str);
>
>  void efi_free(unsigned long size, unsigned long addr);
>
> +unsigned int efi_get_mmap_nr_slack_slots(void);
> +
>  char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len,
>                           unsigned long max_addr);
>
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index 869a79c8946f..fc8b4fb08505 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -7,6 +7,11 @@
>
>  #define EFI_MMAP_NR_SLACK_SLOTS        8
>
> +unsigned int efi_get_mmap_nr_slack_slots(void)
> +{
> +       return EFI_MMAP_NR_SLACK_SLOTS;
> +}
> +

Can we just move this #define to efistub.h and use it directly?

>  static inline bool mmap_has_headroom(unsigned long buff_size,
>                                      unsigned long map_size,
>                                      unsigned long desc_size)
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 05ccb229fb45..9a5ee0678434 100644
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
> +       nr_desc = map_size / desc_size + efi_get_mmap_nr_slack_slots();
>
>         if (nr_desc > ARRAY_SIZE(params->e820_table)) {
>                 u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
> --
> 2.18.4
>
