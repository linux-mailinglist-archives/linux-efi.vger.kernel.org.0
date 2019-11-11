Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C09CF7A59
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2019 18:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKKR74 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Nov 2019 12:59:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37500 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKR74 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Nov 2019 12:59:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so15666508wrv.4
        for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2019 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5QiXXoVlK4nMghmO4aN60pbvXa865y+Rw0kiLku7uM=;
        b=IPckIGIedRBx2GwWiQwt9l/K+Z53bMLX27Y1d4kyiwRX5QH7H7wxBCboD/dQV/wint
         CbJjQU8OcoHLV+6KXxbde4lWhr5faV914BBSxRcF6s+fW0evxkGHPVQJjWy8TwI9PKly
         haItH0L7tk6FfHVtv5aYA9tPNussQBOEWfMoXTv2tcKcI2SQWkV6FbuNtfx8zG7kKtku
         g2VzJBuvunq8nF33HMeLi3c9CbAwYKr9QVGH0G50KT1o1AUbokRAHqMb1a6JPKeKVcfL
         +ZLGiAgxClvsPeQ9JrieNkjYdF9QPjb3w+Cetmgr92roAA0rBIW0ahOJTmYYbNnN90lT
         e/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5QiXXoVlK4nMghmO4aN60pbvXa865y+Rw0kiLku7uM=;
        b=rBeuEWxF/JF2CMud7LfD7daZbQqL8JJrS6Q/fg/xlIY6yZeT+W9wJQD2IS1IdBwMwG
         MKy3igmcoEFsP5sG1HUpC2QQFpWcdSr7sxIKbww0itn5zzsxGflMLPxRbTIDlMDxQ6bc
         wFqMvAYelwiZmS/T2LSBhBNyg9Ehps6EKI2Rrf2sO1CXQNIcVrDEFfULjAjNZY8CfM0M
         znY+9UOym3yGWkrrbFVgx82zd2LSMjARCc3KKY5Daq+ggyzg08SJyRe9sL+hVnwzEKlF
         NCfcY5Mw0IWiy/qSCgO1ZcbtN0K/+HXBtVipDChv/Fp6Yhe2km4DSfSRtbvf1m0QIyEU
         3IHA==
X-Gm-Message-State: APjAAAVqI8+DvWLUW6lPXAkucqDq8aFfm+1P5iOgGXPomp3P/eQxq7jz
        00N3vMRAYO002vCtBEMvK2zMDUY1fiWYwjXRpU7tbw==
X-Google-Smtp-Source: APXvYqxGHkYmJXXCSWD65nykzzaUdkPWnhx+HZyyeMdYfmhf/7By2DNIXzhVr0RxKtZfB6hGxBjIN0sKoWvyCoTRfiM=
X-Received: by 2002:adf:f20d:: with SMTP id p13mr20931849wro.325.1573495193884;
 Mon, 11 Nov 2019 09:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20191111154413.1505-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191111154413.1505-1-andriy.shevchenko@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Nov 2019 17:59:42 +0000
Message-ID: <CAKv+Gu_R1mprDnYUS0HWR2XOWysZnO6AnEt_XkfwzZZVcg64XQ@mail.gmail.com>
Subject: Re: [PATCH v1] efi/earlycon: Remap entire framebuffer after page initialization
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alexander Graf <agraf@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 11 Nov 2019 at 15:44, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When the commit 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk
> into generic earlycon implementation") moved x86 specific EFI earlyprintk
> implementation to shared location it also tweaked the behaviour. In particular
> it dropped a trick with full framebuffer remapping after page initialization.
> This lead to two regressions:
> 1) very slow scrolling after page initialization;
> 2) kernel hang when keep_bootcon parameter is being provided.
>
> Returning the trick back fixes #2 and mitigates, i.e. reduces the window when
> slowness appears, #1 presumably due to eliminating heavy map()/unmap()
> operations per each pixel line on the screen.
>
> Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Andy,

Thanks for fixing this. One question below.

> ---
>  drivers/firmware/efi/earlycon.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
> index c9a0efca17b0..ddb6c0ff2553 100644
> --- a/drivers/firmware/efi/earlycon.c
> +++ b/drivers/firmware/efi/earlycon.c
> @@ -17,14 +17,47 @@ static const struct font_desc *font;
>  static u32 efi_x, efi_y;
>  static u64 fb_base;
>  static pgprot_t fb_prot;
> +static void *efi_fb;
> +
> +/*
> + * efi earlycon needs to use early_memremap() to map the framebuffer.
> + * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
> + * memremap() should be used instead. memremap() will be available after
> + * paging_init() which is earlier than initcall callbacks. Thus adding this
> + * early initcall function early_efi_map_fb() to map the whole efi framebuffer.
> + */
> +static __init int early_efi_map_fb(void)
> +{
> +       u32 size;
> +
> +       size = screen_info.lfb_size;
> +       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> +               efi_fb = memremap(fb_base, size, MEMREMAP_WB);
> +       else
> +               efi_fb = memremap(fb_base, size, MEMREMAP_WC);
> +
> +       return efi_fb ? 0 : -ENOMEM;
> +}
> +early_initcall(early_efi_map_fb);
> +
> +static __exit void early_efi_unmap_fb(void)

Will there be a user for this routine? If not, can we just drop it?

> +{
> +       memunmap(efi_fb);
> +}
>
>  static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
>  {
> +       if (efi_fb)
> +               return efi_fb + start;
> +
>         return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
>  }
>
>  static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
>  {
> +       if (efi_fb)
> +               return;
> +
>         early_memunmap(addr, len);
>  }
>
> --
> 2.24.0.rc1
>
