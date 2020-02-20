Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1571658D6
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 08:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBTHxD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 02:53:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgBTHxD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Feb 2020 02:53:03 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56792467B
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 07:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582185182;
        bh=LykCzXjJkCMwbbh+Gw9s82BtfDJb9IualA+/QWv+QIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Szecd76bZ+d4eoYfnhOGncBZwXvNNvLPuPtKmzI96kpm4DhUe4J0cv0Q+LQyBy0Cx
         Y70Rkb+gPtKko37eOpHA+aja1AqAlTspW3o9pPUoLEksWEgAlR0SSd3QJ62OZBVVsc
         EmSUGL5HXnkstnYgQBe0nxMUT4aUQdomjUTYsjV8=
Received: by mail-wm1-f54.google.com with SMTP id n3so901712wmk.4
        for <linux-efi@vger.kernel.org>; Wed, 19 Feb 2020 23:53:01 -0800 (PST)
X-Gm-Message-State: APjAAAWIJXJB85bOZAPtswEWavcGJqtkMY+IKtj6xlR15Wba8Dhncfun
        kjRF633wmVUM+WLdip7ELMMkrOsEoZclHus5fU798w==
X-Google-Smtp-Source: APXvYqyabUj41A0pBwBLgb5xOjJ9QmNHeJJ1dr9qa7YeLfOPG0cvAaJ8/hp7/WtM9uitoGU7gkWhcCeGeYUATYOvd+c=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr2765906wmf.40.1582185180146;
 Wed, 19 Feb 2020 23:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20200220065317.9096-1-xypron.glpk@gmx.de> <9687832d-e9a9-ca47-34d5-7b912b2f718a@infradead.org>
In-Reply-To: <9687832d-e9a9-ca47-34d5-7b912b2f718a@infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Feb 2020 08:52:48 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8ZvxPdgz9d2ZrbO1vaCrUZs8WW8Bc2sxsrvrCtXtviqg@mail.gmail.com>
Message-ID: <CAKv+Gu8ZvxPdgz9d2ZrbO1vaCrUZs8WW8Bc2sxsrvrCtXtviqg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: describe efi_relocate_kernel()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 20 Feb 2020 at 08:02, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
> Mostly looks good.  One comment below:
>
> On 2/19/20 10:53 PM, Heinrich Schuchardt wrote:
> > Update the description of of efi_relocate_kernel() to match Sphinx style.
> >
> > Update parameter references in the description of other memory functions
> > to use @param style.
> >
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >  drivers/firmware/efi/libstub/mem.c | 38 +++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> > index 0d57078e5e62..7efe3ed2d5a6 100644
> > --- a/drivers/firmware/efi/libstub/mem.c
> > +++ b/drivers/firmware/efi/libstub/mem.c
> > @@ -86,7 +86,7 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
> >   *
> >   * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned according
> >   * to EFI_ALLOC_ALIGN. The last allocated page will not exceed the address
> > - * given by 'max'.
> > + * given by @max.
> >   *
> >   * Return:   status code
> >   */
> > @@ -126,10 +126,10 @@ efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
> >   * @addr:    on exit the address of the allocated memory
> >   * @min:     minimum address to used for the memory allocation
> >   *
> > - * Allocate at the lowest possible address that is not below 'min' as
> > - * EFI_LOADER_DATA. The allocated pages are aligned according to 'align' but at
> > + * Allocate at the lowest possible address that is not below @min as
> > + * EFI_LOADER_DATA. The allocated pages are aligned according to @align but at
> >   * least EFI_ALLOC_ALIGN. The first allocated page will not below the address
> > - * given by 'min'.
> > + * given by @min.
> >   *
> >   * Return:   status code
> >   */
> > @@ -214,7 +214,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
> >   * @addr:    start of the memory area to free (must be EFI_PAGE_SIZE
> >   *           aligned)
> >   *
> > - * 'size' is rounded up to a multiple of EFI_ALLOC_ALIGN which is an
> > + * @size is rounded up to a multiple of EFI_ALLOC_ALIGN which is an
> >   * architecture specific multiple of EFI_PAGE_SIZE. So this function should
> >   * only be used to return pages allocated with efi_allocate_pages() or
> >   * efi_low_alloc_above().
> > @@ -230,15 +230,25 @@ void efi_free(unsigned long size, unsigned long addr)
> >       efi_bs_call(free_pages, addr, nr_pages);
> >  }
> >
> > -/*
> > - * Relocate a kernel image, either compressed or uncompressed.
> > - * In the ARM64 case, all kernel images are currently
> > - * uncompressed, and as such when we relocate it we need to
> > - * allocate additional space for the BSS segment. Any low
> > - * memory that this function should avoid needs to be
> > - * unavailable in the EFI memory map, as if the preferred
> > - * address is not available the lowest available address will
> > - * be used.
> > +/**
> > + * efi_relocate_kernel() - copy memory area
> > + * @image_addr:              address of memory area to copy, on exit target address
>
> The "on exit target address" is a little bit confusing IMO.
> Is it like this?
>
>   On exit, @image_addr is updated to the target copy address that was used.
>

Agreed.

> ?  or some other better description?
>
> Thanks.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>

Applied to efi/next with Randy's suggestion folded in

Heinrich: I folded the first few hunks into the respective changes of
yours that were already queued up

Thanks,


>
> > + * @image_size:              size of memory area to copy
> > + * @alloc_size:              minimum size of memory to allocate, must be greater or
> > + *                   equal to image_size
> > + * @preferred_addr:  preferred target address
> > + * @alignment:               minimum alignment of the allocated memory area. It
> > + *                   should be a power of two.
> > + * @min_addr:                minimum target address
> > + *
> > + * Copy a memory area to a newly allocated memory area aligned according
> > + * to @alignment but at least EFI_ALLOC_ALIGN. If the preferred address
> > + * is not available, the allocated address will not be below @min_addr.
> > + *
> > + * This function is used to copy the Linux kernel verbatim. It does not apply
> > + * any relocation changes.
> > + *
> > + * Return:           status code
> >   */
> >  efi_status_t efi_relocate_kernel(unsigned long *image_addr,
> >                                unsigned long image_size,
> > --
> > 2.25.0
> >
>
>
> --
> ~Randy
>
