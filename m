Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B809340CC2
	for <lists+linux-efi@lfdr.de>; Thu, 18 Mar 2021 19:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhCRSSV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Mar 2021 14:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232520AbhCRSRx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Mar 2021 14:17:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 498E764F1D;
        Thu, 18 Mar 2021 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616091472;
        bh=Gq0Q8gKOwpVXyByKGAa5jJL40jar/QLwtYEcv1B0tjI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QMXzloZrVamfrEr8TEfQdm3uN+usp/2mzrcJlIcJIwG2GOwjy/Tgt7NPtGNwsb2k7
         sXjFByz7b6J6oDeroafri51ojv9tkhg8vRcQxSQWByd3pFlfQtyqKq+bUSIBETOpUZ
         XpBIu5tc6gxFLES7gEDHr1W3/qbHVKKIIB+aAA4tUFfVndU7S8ZOWcwtxhgs3YaNn7
         +QtNJOvIyidNPZnODf75YoPBQ98z2ELZ3LkXRPJKeno/6TfvePgKtS2f38Ti/qE5zd
         zgR7fwzKiqZLDl8015bd8VtB7/NtQWq6mwJJTwMksfz4D/bjIgqqZjmtpjue08hk5F
         QWvgJbptQCD9Q==
Received: by mail-oo1-f47.google.com with SMTP id n12-20020a4ad12c0000b02901b63e7bc1b4so1661023oor.5;
        Thu, 18 Mar 2021 11:17:52 -0700 (PDT)
X-Gm-Message-State: AOAM533CAoHlcn19TOzFQ3uYLulftd9nn5b+UqJij5RLG7KtWediBl8V
        lCaCmJqPf6XSoYxlybSIxB8X5A/tlSn4E4BcN1s=
X-Google-Smtp-Source: ABdhPJw+C9b1zRhUVvBjlvQyrzhtXyLaneQxhEg0ejiSLyRGwVjmvZ+7NtXGfkUUl4VIEhtsQf6bYJXLVbSGfLgif2I=
X-Received: by 2002:a4a:bd1a:: with SMTP id n26mr8501906oop.45.1616091471572;
 Thu, 18 Mar 2021 11:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210310083127.5784-1-lyl2019@mail.ustc.edu.cn>
In-Reply-To: <20210310083127.5784-1-lyl2019@mail.ustc.edu.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 Mar 2021 19:17:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXESeiozq=DAsYsKOP6DVEOQknPqUdam_LpRiPzhLhCCBg@mail.gmail.com>
Message-ID: <CAMj1kXESeiozq=DAsYsKOP6DVEOQknPqUdam_LpRiPzhLhCCBg@mail.gmail.com>
Subject: Re: [PATCH] firmware/efi: Fix a use after bug in efi_mem_reserve_persistent
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     jonathan.richardson@broadcom.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 10 Mar 2021 at 09:37, Lv Yunlong <lyl2019@mail.ustc.edu.cn> wrote:
>
> In the for loop in efi_mem_reserve_persistent(), prsv = rsv->next
> use the unmapped rsv. Use the unmapped pages will cause segment
> fault.
>
> Fixes: 18df7577adae6 ("efi/memreserve: deal with memreserve entries in unmapped memory")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>

Queued as a fix, thanks.

> ---
>  drivers/firmware/efi/efi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index df3f9bcab581..4b7ee3fa9224 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -927,7 +927,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>         }
>
>         /* first try to find a slot in an existing linked list entry */
> -       for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
> +       for (prsv = efi_memreserve_root->next; prsv; ) {
>                 rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
>                 index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
>                 if (index < rsv->size) {
> @@ -937,6 +937,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>                         memunmap(rsv);
>                         return efi_mem_reserve_iomem(addr, size);
>                 }
> +               prsv = rsv->next;
>                 memunmap(rsv);
>         }
>
> --
> 2.25.1
>
>
