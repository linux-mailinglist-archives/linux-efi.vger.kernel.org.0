Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2213459D2
	for <lists+linux-efi@lfdr.de>; Tue, 23 Mar 2021 09:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCWIfl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Mar 2021 04:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhCWIf0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 23 Mar 2021 04:35:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA4A2619B1;
        Tue, 23 Mar 2021 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616488525;
        bh=DcC/OPoatnEa6xKGovTO3O2/NR4DqnqQmACycnTfAa8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IHR/vOrMdK3JwAQY2UQGTjIrjpCJM3A8l52ytzNurHs+tWCZeKeeVhxcxPvLbXSRo
         cASiYNnfW0534g8kFQ1N8BgKajSBrEXKO7bqIe8SVGBCCUmYJoTFJUF2U0DZ6K/Bq/
         4Cr3+KlN2UBF3jDB9px900hPIbGE8fDgVy7U0xhXlFleUtdxJVD+5vFtCkmGJtgljh
         1dHUOGRfxXgGSEBN3BINHAAfyPqL58jKblPgneIge1gxiKl58PRqRYp7hppoSGdiob
         TY1ggDh5Dj/993ZACAe0JKkMSpe6mFHsG0LK18KcOGp33mCfN66/wIxRrKl4CEVXlZ
         YiuZ8vCuu0idg==
Received: by mail-oi1-f179.google.com with SMTP id i81so14705425oif.6;
        Tue, 23 Mar 2021 01:35:25 -0700 (PDT)
X-Gm-Message-State: AOAM53045bpYmPL7dGMI47XxR0icWOqNaPbKXPSYQVeYcEQmC+E6sqg8
        rUA7+CUb3Pa0KcowMKg3TJ4oubIHERLtGApt92k=
X-Google-Smtp-Source: ABdhPJxDVRqu9ToH4dXXW+I7e4DfRQbinakQ0Le879vAYmwwTshy2SPkicOQe/XlAM6KUIvzgLAeZhQ0h+YMTG9FTXQ=
X-Received: by 2002:aca:478d:: with SMTP id u135mr2492067oia.174.1616488525135;
 Tue, 23 Mar 2021 01:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210322221441.3555003-1-slyfox@gentoo.org>
In-Reply-To: <20210322221441.3555003-1-slyfox@gentoo.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 23 Mar 2021 09:35:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF5ufbDPLhBboYav0bU3C1tnn1ZrDesPGGnni=+1N8hjw@mail.gmail.com>
Message-ID: <CAMj1kXF5ufbDPLhBboYav0bU3C1tnn1ZrDesPGGnni=+1N8hjw@mail.gmail.com>
Subject: Re: [PATCH] ia64: fix EFI_DEBUG build
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, linux-ia64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 22 Mar 2021 at 23:16, Sergei Trofimovich <slyfox@gentoo.org> wrote:
>
> When enabled local debugging via `#define EFI_DEBUG 1` noticed
> build failure:
>
>     ia64/kernel/efi.c:564:8: error: 'i' undeclared (first use in this function)
>       564 |   for (i = 0, p = efi_map_start; p < efi_map_end;
>           |        ^
>
> CC: Ard Biesheuvel <ardb@kernel.org>
> CC: linux-efi@vger.kernel.org
> CC: linux-ia64@vger.kernel.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>

What are the other changes for?

> ---
>  arch/ia64/kernel/efi.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
> index c5fe21de46a8..31149e41f9be 100644
> --- a/arch/ia64/kernel/efi.c
> +++ b/arch/ia64/kernel/efi.c
> @@ -415,10 +415,10 @@ efi_get_pal_addr (void)
>                 mask  = ~((1 << IA64_GRANULE_SHIFT) - 1);
>
>                 printk(KERN_INFO "CPU %d: mapping PAL code "
> -                       "[0x%lx-0x%lx) into [0x%lx-0x%lx)\n",
> -                       smp_processor_id(), md->phys_addr,
> -                       md->phys_addr + efi_md_size(md),
> -                       vaddr & mask, (vaddr & mask) + IA64_GRANULE_SIZE);
> +                       "[0x%llx-0x%llx) into [0x%llx-0x%llx)\n",
> +                       smp_processor_id(), md->phys_addr,
> +                       md->phys_addr + efi_md_size(md),
> +                       vaddr & mask, (vaddr & mask) + IA64_GRANULE_SIZE);
>  #endif
>                 return __va(md->phys_addr);
>         }
> @@ -560,6 +560,7 @@ efi_init (void)
>         {
>                 efi_memory_desc_t *md;
>                 void *p;
> +               unsigned int i;
>
>                 for (i = 0, p = efi_map_start; p < efi_map_end;
>                      ++i, p += efi_desc_size)
> @@ -586,7 +587,7 @@ efi_init (void)
>                         }
>
>                         printk("mem%02d: %s "
> -                              "range=[0x%016lx-0x%016lx) (%4lu%s)\n",
> +                              "range=[0x%016llx-0x%016llx) (%4lu%s)\n",
>                                i, efi_md_typeattr_format(buf, sizeof(buf), md),
>                                md->phys_addr,
>                                md->phys_addr + efi_md_size(md), size, unit);
> --
> 2.31.0
>
