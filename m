Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFBE11A5C4
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2019 09:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfLKIXB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Dec 2019 03:23:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38963 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbfLKIXA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Dec 2019 03:23:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so22957305wrt.6
        for <linux-efi@vger.kernel.org>; Wed, 11 Dec 2019 00:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MvP5CDDQa/EYnC3I21knQmDLzwiuAJInqxz17NV1qE=;
        b=KtQ9xaFkAH4tQ6lbUb0bcBl29m+QNoIoFu/FH3lUy08SUkP7E2Ky/s+DKzLXJFpL/L
         4Ue5I/klrjoiC+SZAXyYXeXlsrL5M7McYmWx+Ybbu3b6wS10c/r/wqQs9TN9xsHzmx4m
         +YdCaC9o2oC8VsLOb4LEuy18Q5+Ya6GcK1evhEXMzLJ4EW1sNHQd9C7YT6hSGsJt1o7A
         oYHbFvd/oDAph4xOyiV2Bv8TllfEkTRafk5FOaTYPoL/yipa17j0DE6Vq6ILAQdjOUZI
         QhOIQSaGPyVF+elUnh97MCR8/CbQca7TWa+5bvKraQ2a1gN6gz+WS51JRCbpVX4TSMsC
         eNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MvP5CDDQa/EYnC3I21knQmDLzwiuAJInqxz17NV1qE=;
        b=NEkxfirxPCIuYrFRybtjYflN1HkvoXw4eOOuxTnhAK5r3itwvEZIGKCmplBWnpsMPA
         NQ3pWVLrq/Izylbps3/nhOOPWwyHlYS7vaPbDEvdXn1rRZRHOJCeYwzrM7YiQbFxHzgM
         rMa3RJoYpI5Un6IHc6BooqH46T+oih22hpQRdQo5RQdKkSzZYIRjv/e82PYvwgiQKrVa
         WwHD4u/M2bso9nkAqZs33ph7NLcktRRC+hfT624A2QBBAK+jmjPFinvhrzOiCpX44piy
         T3k93rJF/oAPhf/al3B8JhlOYpDNedDjm0BVxo/6d/sOJ/nGZJlvm/PRYazEbeSuvcdC
         dTYQ==
X-Gm-Message-State: APjAAAUlBBo46ZZc4wMWGa2OV3RakyAGJCh6RyynWuVek5NdU1mwzktw
        e/fkBZvijemIbfKWwjfsZhS9RkAL42llIOfT8sXrFA==
X-Google-Smtp-Source: APXvYqx+8e7Bz3N7yclMcfpyQEL88NdFp0q7hm7skmlraq03D2kRd3BcbuTsyytgIUDwiT+N0p0pt/nUmSQ2W0G0Nfc=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr2154239wrj.325.1576052578146;
 Wed, 11 Dec 2019 00:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20191210232410.17890-1-nivedita@alum.mit.edu>
In-Reply-To: <20191210232410.17890-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Dec 2019 08:22:56 +0000
Message-ID: <CAKv+Gu8s=kT_21WasEsTRh+6COQYD0mpzOT5n0qhD1Y+YdR3JQ@mail.gmail.com>
Subject: Re: [PATCH] efi/earlycon: Fix write-combine mapping on x86
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Andy)

On Wed, 11 Dec 2019 at 00:24, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On x86, until PAT is initialized, WC translates into UC-. Since we
> calculate and store pgprot_writecombine(PAGE_KERNEL) when earlycon is
> initialized, this means we actually use UC- mappings instead of WC
> mappings, which makes scrolling very slow.
>
> Instead store a boolean flag to indicate whether we want to use
> writeback or write-combine mappings, and recalculate the actual pgprot_t
> we need on every mapping. Once PAT is initialized, we will start using
> write-combine mappings, which speeds up the scrolling considerably.
>
> Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
> This applies on top of
>         efi/earlycon: Remap entire framebuffer after page initialization
>         https://git.kernel.org/tip/b418d660bb9798d2249ac6a46c844389ef50b6a5
>
>  drivers/firmware/efi/earlycon.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
> index ee5a6431fb9c..18f6a61f3e17 100644
> --- a/drivers/firmware/efi/earlycon.c
> +++ b/drivers/firmware/efi/earlycon.c
> @@ -17,7 +17,7 @@ static const struct console *earlycon_console __initdata;
>  static const struct font_desc *font;
>  static u32 efi_x, efi_y;
>  static u64 fb_base;
> -static pgprot_t fb_prot;
> +static bool fb_wb;
>  static void *efi_fb;
>
>  /*
> @@ -33,10 +33,8 @@ static int __init efi_earlycon_remap_fb(void)
>         if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
>                 return 0;
>
> -       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
> -       else
> -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
> +       efi_fb = memremap(fb_base, screen_info.lfb_size,
> +                         fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
>
>         pr_info("Mapped earlycon framebuffer\n");
>
> @@ -58,9 +56,12 @@ late_initcall(efi_earlycon_unmap_fb);
>
>  static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
>  {
> +       pgprot_t fb_prot;
> +
>         if (efi_fb)
>                 return efi_fb + start;
>
> +       fb_prot = fb_wb ? PAGE_KERNEL : pgprot_writecombine(PAGE_KERNEL);
>         return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
>  }
>
> @@ -220,10 +221,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
>         if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
>                 fb_base |= (u64)screen_info.ext_lfb_base << 32;
>
> -       if (opt && !strcmp(opt, "ram"))
> -               fb_prot = PAGE_KERNEL;
> -       else
> -               fb_prot = pgprot_writecombine(PAGE_KERNEL);
> +       fb_wb = opt && !strcmp(opt, "ram");
>
>         si = &screen_info;
>         xres = si->lfb_width;
> --
> 2.23.0
>
