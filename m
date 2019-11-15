Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13E3FE2B4
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2019 17:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKOQ2U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Nov 2019 11:28:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39913 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfKOQ2U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Nov 2019 11:28:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so11086556wmi.4
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2019 08:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+V0QiQSoCj4k49EY49nJq90kEBC7Yfhy2bOMluqbVo=;
        b=hZp+QccwjL4WvbbKO5rtid/3Qdt0IuPqRX+pmKYjrTsWjvr6NC50oP2F9g7hot+AqM
         uHkB1mOY3BygfL+MgoAgE0qrGcaSihZEgHXNBGw6QyTd/0ZQ9+m8pfZG/g4lgWklXGvs
         uWDmJGYYzef0Zz9bslcDTanv/sYDr6t1CC5DaVBiqeH5nCI83Dki9hr8yKEKA4SbS8Hv
         Z/wBW/6jxzQw1yKYyPREs2o1q7oOScu61zveGSr9ug4GlZ5bl5Oequ0IP89kHto7gtjg
         zFMqLiDMeXoRT154nK1L9UnGen+I4FSgKU8z3CdSFnHLCLIkTRYmQgiyS8O4huGKHXll
         qIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+V0QiQSoCj4k49EY49nJq90kEBC7Yfhy2bOMluqbVo=;
        b=r1QINc/EMA4u12OOzdolZLsCNsRyduIR2s6PsGCNo5F3Iu9oAKfoy+1lWo7U9HVxgQ
         MDOeKPoGmIijRwaLI91tFJBcCgDwv6xEmS2j98bT2Gd4vzgHevxSIMEQXejaH7Iw++Vj
         Fp8PJdc02SuKnusckvO65OKdKcGpB3idLMovPw139ZAckC0AqFqXyGJckanC6pL9qJ/r
         VkQdwhHG2wdAwXugFEPwJ9psPrrqL1D9mgF5c4hdyDQwzGD1UcLIbSXEaviRu+XQsRQs
         tmVMId+hUx3av9+9iY+hxsJo0olNimX5b7f2+WoRYD1iBWLtkvB8Piwuk80YqZ6cG8Sh
         z83g==
X-Gm-Message-State: APjAAAW3DQNcftQq3gZEJCTbGdnzZ+MotC0jrPd84Oh3t3Dl89DuDP5A
        uy0rZI9gyw+axEkWMDjvT/twO78NUO4oIgNbbC6jGrypztWPKQ==
X-Google-Smtp-Source: APXvYqwbGXbkxad19SZAx2qD4Vo+5buLyQaIs2DKxY/366DkGj6vQFmwPBK+mH3p2jK1rGicJFdNLmu3USCFa3CIvkQ=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr14426699wmb.136.1573835298305;
 Fri, 15 Nov 2019 08:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20191115153102.51921-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191115153102.51921-1-andriy.shevchenko@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 15 Nov 2019 16:28:10 +0000
Message-ID: <CAKv+Gu9wKQ_yXjfkB6-6f8Tfu+cfpSNnxn04ZqExYxuPSQS-ww@mail.gmail.com>
Subject: Re: [PATCH v3] efi/earlycon: Remap entire framebuffer after page initialization
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

On Fri, 15 Nov 2019 at 15:31, Andy Shevchenko
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
> ---
> v3:
> - assign size in efi_earlycon_setup()
> - check base and size before mapping in early_efi_map_fb()
>  drivers/firmware/efi/earlycon.c | 37 +++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
> index c9a0efca17b0..60b5350c6105 100644
> --- a/drivers/firmware/efi/earlycon.c
> +++ b/drivers/firmware/efi/earlycon.c
> @@ -16,15 +16,50 @@
>  static const struct font_desc *font;
>  static u32 efi_x, efi_y;
>  static u64 fb_base;
> +static u32 fb_size;
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
> +static int __init early_efi_map_fb(void)
> +{
> +       if (!fb_base || !fb_size)
> +               return NULL;
> +

'return 0' please.

I'll test this on actual arm64 hardware somewhere next week, and queue
it if it doesn't break anything (no need to resend for the above)


> +       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> +               efi_fb = memremap(fb_base, fb_size, MEMREMAP_WB);
> +       else
> +               efi_fb = memremap(fb_base, fb_size, MEMREMAP_WC);
> +
> +       return efi_fb ? 0 : -ENOMEM;
> +}
> +early_initcall(early_efi_map_fb);
> +
> +static void __exit early_efi_unmap_fb(void)
> +{
> +       memunmap(efi_fb);
> +}
> +__exitcall(early_efi_unmap_fb);
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
> @@ -176,6 +211,8 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
>         if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
>                 fb_base |= (u64)screen_info.ext_lfb_base << 32;
>
> +       fb_size = screen_info.lfb_size;
> +
>         if (opt && !strcmp(opt, "ram"))
>                 fb_prot = PAGE_KERNEL;
>         else
> --
> 2.24.0
>
