Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6C7330349
	for <lists+linux-efi@lfdr.de>; Sun,  7 Mar 2021 18:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCGRZM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Mar 2021 12:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhCGRZK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 7 Mar 2021 12:25:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8041B64F94;
        Sun,  7 Mar 2021 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615137910;
        bh=/y6qzZpbYK7THlrH68APtLg3sNQ3GG873WCpVXCpQBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uDoIx55IS6tXkFwoxappnWI9ZHYOJzMcs591ck5jfaTetNEN+ggsQ8UJ7SBp4BjKL
         Bi++un+dXQZOwVnvDGncgEjaU6eqjTkL8igZQzUFpylH3sIdT2pZWL5v1n9N3dFKAV
         yNrcu/C6HhE6S3g5m2ULPyTtoW8tYZkS5eJu3zO36eqD7t1OX3Fa3/7Q3exJl4Bg7I
         q5A8eCb0cSX03Z7WuVcfLoxGdNngDmOm+VkO/yut0ggIutCMOeMpYXFpIjB7v6u/uF
         jPGOyFrRAykasA6lUEvlA6GaN0OrmBYmTQ2a8VKd2DJxBJonv871Z7nmN2jKgx6UNB
         8Q/GQf4sYVYFA==
Received: by mail-oo1-f53.google.com with SMTP id i11so1679273ood.6;
        Sun, 07 Mar 2021 09:25:10 -0800 (PST)
X-Gm-Message-State: AOAM533tyBK/F3KlBf1Jxg+l/My6rbDf1vl9JpitQeZUD/mgpa3Rr3X9
        IouwZcG7sFvW9LCcLwqxtgPydk5rKDrisuDptQ0=
X-Google-Smtp-Source: ABdhPJyM7ZOIl/eABEUL6Pvj0sxrn5oehgo7nNFJnHTBZetrpDHkf72QrcTVzca6trtlzaFuQOdyJHdC8d4g5yCp6hE=
X-Received: by 2002:a4a:e1e4:: with SMTP id u4mr15789228ood.41.1615137909871;
 Sun, 07 Mar 2021 09:25:09 -0800 (PST)
MIME-Version: 1.0
References: <20210224184308.1416903-1-kasong@redhat.com>
In-Reply-To: <20210224184308.1416903-1-kasong@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 7 Mar 2021 18:24:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHP5ixY9GJxNCFkwwb8mpRbjZdx5ZQOf7zy3W9sBjsV5Q@mail.gmail.com>
Message-ID: <CAMj1kXHP5ixY9GJxNCFkwwb8mpRbjZdx5ZQOf7zy3W9sBjsV5Q@mail.gmail.com>
Subject: Re: [PATCH] efi: memmap insertion should adjust the vaddr as well
To:     Kairui Song <kasong@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 24 Feb 2021 at 19:43, Kairui Song <kasong@redhat.com> wrote:
>
> Currently when efi_memmap_insert is called, only the
> physical memory addresses are re-calculated. The virt
> addresses of the split entries are untouched.
>
> If any later operation depends on the virt_addaress info, things
> will go wrong. One case it may fail is kexec on x86, after kexec,
> efi is already in virtual mode, kernel simply do fixed mapping
> reuse the recorded virt address. If the virt address is incorrect,
> the mapping will be invalid.
>
> Update the virt_addaress as well when inserting a memmap entry to
> fix this potential issue.
>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  drivers/firmware/efi/memmap.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 2ff1883dc788..de5c545b2074 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -292,7 +292,7 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
>  {
>         u64 m_start, m_end, m_attr;
>         efi_memory_desc_t *md;
> -       u64 start, end;
> +       u64 start, end, virt_offset;
>         void *old, *new;
>
>         /* modifying range */
> @@ -321,6 +321,11 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
>                 start = md->phys_addr;
>                 end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
>
> +               if (md->virt_addr)
> +                       virt_offset = md->virt_addr - md->phys_addr;
> +               else
> +                       virt_offset = -1;
> +

Should we take EFI_MEMORY_RUNTIME into account here? I don't think we
should expect to see non-zero virtual addresses if that attribute is
missing.


>                 if (m_start <= start && end <= m_end)
>                         md->attribute |= m_attr;
>
> @@ -337,6 +342,8 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
>                         md->phys_addr = m_end + 1;
>                         md->num_pages = (end - md->phys_addr + 1) >>
>                                 EFI_PAGE_SHIFT;
> +                       if (virt_offset != -1)
> +                               md->virt_addr = md->phys_addr + virt_offset;
>                 }
>
>                 if ((start < m_start && m_start < end) && m_end < end) {
> @@ -351,6 +358,8 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
>                         md->phys_addr = m_start;
>                         md->num_pages = (m_end - m_start + 1) >>
>                                 EFI_PAGE_SHIFT;
> +                       if (virt_offset != -1)
> +                               md->virt_addr = md->phys_addr + virt_offset;
>                         /* last part */
>                         new += old_memmap->desc_size;
>                         memcpy(new, old, old_memmap->desc_size);
> @@ -358,6 +367,8 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
>                         md->phys_addr = m_end + 1;
>                         md->num_pages = (end - m_end) >>
>                                 EFI_PAGE_SHIFT;
> +                       if (virt_offset != -1)
> +                               md->virt_addr = md->phys_addr + virt_offset;
>                 }
>
>                 if ((start < m_start && m_start < end) &&
> @@ -373,6 +384,8 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
>                         md->num_pages = (end - md->phys_addr + 1) >>
>                                 EFI_PAGE_SHIFT;
>                         md->attribute |= m_attr;
> +                       if (virt_offset != -1)
> +                               md->virt_addr = md->phys_addr + virt_offset;
>                 }
>         }
>  }
> --
> 2.29.2
>
