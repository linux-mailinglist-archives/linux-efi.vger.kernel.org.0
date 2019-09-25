Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFDFBE14F
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2019 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439713AbfIYP3X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Sep 2019 11:29:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46586 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439704AbfIYP3W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Sep 2019 11:29:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so7460978wrv.13
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2019 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbH1JRsE5gNzk5r+HOai2FAWFvIqOQyEdzFA3kJ7aIM=;
        b=oHS3VjAECmGmMqMZ3iEEidrVarDdrXO6OQ9B7/lbkNCoLhAtpnb1Yk/NTBHjx+kTPJ
         P32IgqhLdOTctj8lS60GThdHB4sZlozMGmTKJMFC37QVH2QOMP7QYMqIxa4vucJO6Dio
         8iascMWvSwkXYVF2LYTiIPq6zSOUMljmzKaZyylnlc8fbWRGODlHQgYQa0PaSQwtKtN1
         QM0/HSEeH8R3YJO4jNj/QOfrtMTrzjwlALTFY3FyOiCvE+eeYLkylRKW+G804eKFFXTY
         M1Deq29dgXgl05zKwgTGMJ5rvZzb/KUtf+WACyL4JRVq8T5iHvl+TqtPI0rA0nNZpsrR
         cmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbH1JRsE5gNzk5r+HOai2FAWFvIqOQyEdzFA3kJ7aIM=;
        b=qJtJXq4Q2dWNvR5Xz4eKMBn1EqvuqkIHpdjwjt6CL/jFZVGMRy7vude3NdHS3yfr8H
         +fpYPBKGb2d67Ks5a7L9bAmR6hX0r3bmIPbUOb5goTTwjfwXpNpO9YbNXqsBvfoPJhUQ
         WCD17OsmM8SK+I2GfjosEM0x7VLZEY+kD8W82dydzfM7079nhdDwSPgAy/VVuhLwdD8u
         8vit/BlaMO5b2cHozlNHad1yCZvSPs0vdrIXUa/PUnnaCAWNrbarEOmUV+uvyWweLGkW
         DMEpQVZu0/ECzDK4HOf1HkNy8jVxsbLiwVSrHtIpjhHI3QmEKdyfyZY6t1rBRNXXfwjR
         LBZQ==
X-Gm-Message-State: APjAAAW/Rgz5vkKjKkasV5mpPCuLR/27pVYMpeFpaCR04ZjlUg4VdcTD
        XNwqTgkLlnAJxegNCZndgwVBXFbbm+L7DxwAHddTSA==
X-Google-Smtp-Source: APXvYqyYWffK09yJ7cnY0gJYYdcBl2WjFnmEgGos4uhahh/oCQSf21nPqCg5cjdbAff0Y+/eZcRAh8goLL+TeDOlrbY=
X-Received: by 2002:adf:fe88:: with SMTP id l8mr9484640wrr.32.1569425359779;
 Wed, 25 Sep 2019 08:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <775bcf46-0f4e-a1a9-5a40-05f833cd7a1a@huawei.com>
In-Reply-To: <775bcf46-0f4e-a1a9-5a40-05f833cd7a1a@huawei.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 25 Sep 2019 17:29:08 +0200
Message-ID: <CAKv+Gu-dd5=TJ62GtCvZ5iPTRjqjSpPwx-oNQJ2dv9ZBHB0c8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: Add efi_memmap_free() to free EFI memory map
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 25 Sep 2019 at 11:17, Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>
> In efi_fake_memmap(), the commit 20b1e22d01a4 ("x86/efi: Don't allocate
> memmap through memblock after mm_init()") replace memblock_alloc() with
> efi_memmap_alloc(), but there is no matching modification of
> memblock_free() when early_memremap() fail.
>
> Fix this by adding efi_memmap_free() to instead of memblock_free().
>
> Fixes: 20b1e22d01a4 ("x86/efi: Don't allocate memmap through memblock after mm_init()")
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

What happens if you try to call efi_memmap_free() /after/ slab has
become available on an allocation that was created before?

> ---
>  drivers/firmware/efi/fake_mem.c |  2 +-
>  drivers/firmware/efi/memmap.c   | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/efi.h             |  1 +
>  3 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
> index 9501edc..c2f69f6 100644
> --- a/drivers/firmware/efi/fake_mem.c
> +++ b/drivers/firmware/efi/fake_mem.c
> @@ -65,7 +65,7 @@ void __init efi_fake_memmap(void)
>         new_memmap = early_memremap(new_memmap_phy,
>                                     efi.memmap.desc_size * new_nr_map);
>         if (!new_memmap) {
> -               memblock_free(new_memmap_phy, efi.memmap.desc_size * new_nr_map);
> +               efi_memmap_free(new_memmap_phy, new_nr_map);
>                 return;
>         }
>
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 38b686c..35dc189 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -18,6 +18,11 @@ static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
>         return memblock_phys_alloc(size, SMP_CACHE_BYTES);
>  }
>
> +static void __init __efi_memmap_free_early(phys_addr_t addr, unsigned long size)
> +{
> +       memblock_free(addr, size);
> +}
> +
>  static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
>  {
>         unsigned int order = get_order(size);
> @@ -29,6 +34,15 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
>         return PFN_PHYS(page_to_pfn(p));
>  }
>
> +static void __init __efi_memmap_free_late(phys_addr_t addr, unsigned long size)
> +{
> +       unsigned int order = get_order(size);
> +       struct page *p = pfn_to_page(PHYS_PFN(addr));
> +
> +       if (p)
> +               __free_pages(p, order);
> +}
> +
>  /**
>   * efi_memmap_alloc - Allocate memory for the EFI memory map
>   * @num_entries: Number of entries in the allocated map.
> @@ -50,6 +64,26 @@ phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
>  }
>
>  /**
> + * efi_memmap_free - Free memory for the EFI memory map
> + * @addr: Physical address of the EFI memory map to be freed.
> + * @num_entries: Number of the EFI memory map entries.
> + *
> + * Depending on whether mm_init() has already been invoked or not,
> + * either memblock or "normal" page free is used.
> + */
> +void __init efi_memmap_free(phys_addr_t addr, unsigned int num_entries)
> +{
> +       unsigned long size = num_entries * efi.memmap.desc_size;
> +
> +       if (slab_is_available()) {
> +               __efi_memmap_free_late(addr, size);
> +
> +               return;
> +       }
> +       __efi_memmap_free_early(addr, size);
> +}
> +
> +/**
>   * __efi_memmap_init - Common code for mapping the EFI memory map
>   * @data: EFI memory map data
>   * @late: Use early or late mapping function?
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index bd38370..8bb741a 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1057,6 +1057,7 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
>  extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
>
>  extern phys_addr_t __init efi_memmap_alloc(unsigned int num_entries);
> +extern void __init efi_memmap_free(phys_addr_t addr, unsigned int num_entries);
>  extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
>  extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
>  extern void __init efi_memmap_unmap(void);
> --
> 1.8.3.1
>
