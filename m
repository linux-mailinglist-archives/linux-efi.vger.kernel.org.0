Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A69D161CC3
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 22:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgBQV0A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 16:26:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729849AbgBQV0A (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 16:26:00 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207402072C
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 21:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581974759;
        bh=l0dOy2UpBtryST2iZLUusaGeXO0CcQ2p8oMEQoFeVKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vbp6SrXM29IkGlb9ZpFUPS1enfgo1NxT11uUwLYyeA5OEpR0Yok7iQMZ3bqVdAgM7
         5p4mtShysT/cSued0BEY/WS1s3g4Wtm42pe0JX4B1cUrXwYIHsd101fKfpJCgRlftn
         /kmykk0mexaqiIT0i87kZ5hiGSPwy9Oq/ge17KQM=
Received: by mail-wm1-f50.google.com with SMTP id a5so747067wmb.0
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 13:25:59 -0800 (PST)
X-Gm-Message-State: APjAAAWBOiA+J5APEK6RRGYd1u/8nvpysVwqm/Qwt5c7gKUa33OUvbV4
        t069SFOpCybYKWmklEfd5UKXG+NMplgugx2Z0n8cJQ==
X-Google-Smtp-Source: APXvYqz4ckzSLSn80+EGpOONKPp+2jjUqj+eeWcBoPgxAti+TmJLW8eu5TALGjuu2ktF7TcJP3e4JE/+OlwHGNPCWbM=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr927700wmf.133.1581974757521;
 Mon, 17 Feb 2020 13:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20200217211323.4878-1-xypron.glpk@gmx.de>
In-Reply-To: <20200217211323.4878-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Feb 2020 22:25:46 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9fxdag7Fmevd0Nxhwt-qNYcCg0YaBoq0LzsjyOu2z0mQ@mail.gmail.com>
Message-ID: <CAKv+Gu9fxdag7Fmevd0Nxhwt-qNYcCg0YaBoq0LzsjyOu2z0mQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: describe memory functions
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 17 Feb 2020 at 22:14, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Provide descriptions of:
>
> * efi_get_memory_map()
> * efi_low_alloc_above()
> * efi_free()
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks Heinrich. One comment below.

> ---
>  drivers/firmware/efi/libstub/mem.c | 31 ++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index c25fd9174b74..be24c062115f 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -16,6 +16,15 @@ static inline bool mmap_has_headroom(unsigned long buff_size,
>         return slack / desc_size >= EFI_MMAP_NR_SLACK_SLOTS;
>  }
>
> +/**
> + * efi_get_memory_map() - get memory map
> + * @map                on return pointer to memory map
> + *
> + * Retrieve the UEFI memory map. The allocated memory leaves room for
> + * up to EFI_MMAP_NR_SLACK_SLOTS additional memory map entries.
> + *
> + * Return:     status code
> + */
>  efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
>  {
>         efi_memory_desc_t *m = NULL;
> @@ -109,8 +118,20 @@ efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
>         }
>         return EFI_SUCCESS;
>  }
> -/*
> - * Allocate at the lowest possible address that is not below 'min'.
> +/**
> + * efi_low_alloc_above() - allocate pages at or above given address
> + * @size:      size of the memory area to allocate
> + * @align:     minimum alignment of the allocated memory area. It should
> + *             a power of two.
> + * @addr:      on exit the address of the allocated memory
> + * @min:       minimum address to used for the memory allocation
> + *
> + * Allocate at the lowest possible address that is not below 'min' as
> + * EFI_LOADER_DATA. The allocated pages are aligned according to 'align' but at
> + * least EFI_ALLOC_ALIGN. The first allocated page will not below the address
> + * given by 'min'.
> + *
> + * Return:     status code
>   */
>  efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
>                                  unsigned long *addr, unsigned long min)
> @@ -187,6 +208,12 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
>         return status;
>  }
>
> +/**
> + * efi_free() - free memory pages
> + * @size       size of the memory area to free in bytes
> + * @addr       start of the memory area to free (must be EFI_PAGE_SIZE
> + *             aligned)
> + */

It may be good to mention here that the allocation is rounded up to
EFI_ALLOC_ALIGN again, so it should only be used for allocation that
were made using efi_allocate_pages() or efi_low_alloc_above().


>  void efi_free(unsigned long size, unsigned long addr)
>  {
>         unsigned long nr_pages;
> --
> 2.25.0
>
