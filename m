Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0FCFDE9C
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2019 14:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKONMs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Nov 2019 08:12:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44314 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKONMr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Nov 2019 08:12:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id f2so10932198wrs.11
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2019 05:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sEYSGTSJDKzUwBAh8fcuNYCosZyCTzduJ2DkxC0jug=;
        b=k0meMcHyHRi8IMMGaFonTbXO4f+14DU3rC0q88SHS++dw9AESHWGzJ2Ifk424JZIMU
         cfzRaiw9BS0abePHlk2h+XgGTwyTE0+0T1h2okDq0w4PRMfmBtBXonw6VHzsMLwSe1bY
         zww8vdbiO1jsY2DxYUXXbzp9vGxcKkXUZi5CZLFn7p3KHmARxAYK8HUXqZmq3nGOA4oI
         DZLLQgZa1GjM/2w0ZpWCk6/tbfQUtI8sz5bAP3UySLxJKWdKFzbODXOPBGP2ahKkTcTl
         tQQRMxNvVMkO7ucP91T4dm+aDnPQxelrgwe9D3lvNGEXio5a0YU5/u7wPPb3C3hjxJa7
         7EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sEYSGTSJDKzUwBAh8fcuNYCosZyCTzduJ2DkxC0jug=;
        b=TdCPcT2XDyemVf6f/IFs0iMFcyK5eoi28GLMXy0bBsloUK2cLpAqGyAuG2J5BRSdAR
         MHg1/UeN1qZpLZPnnD1HBdsBhr92XsQ4gJ4XGvQsLmSM87jhZ+l3Zfm11XsVtN3P7/g5
         HxQTWFzFRoSbBkt9AzTBOfx17YV8YPHART9F+X+ucmAP1h7rQ4zFmTAoRYAMQnL5KfAM
         aSuoe2s0wIvml+pxZBsgrsNQCTOIgq7/PT2xGLUQZswaFLQGcypnvB3rS1D+ASd5HxeX
         9mYq8JSdxoOyNEb7sHOzqeU5sK34Ke+NjKxz5LQy6dr+Y3AFw3E/W/2iRVl516QVLRJn
         hGgw==
X-Gm-Message-State: APjAAAX8fwtrZsQeRlolSMZqI4stG1wNjekB3cc/q9/QUXAJNPzBLErt
        ovMTZgdfElagKkTJmuOjQ1J49YcrU2omr2NybUNBUQ==
X-Google-Smtp-Source: APXvYqyZu8vc9S3JWnr6modp0oGzydqBZDIO1WDkoJriFjQtagqC6WATfChyzkQoKlbkobAdJXMrf4yJCbdQ4iEKQwE=
X-Received: by 2002:adf:f20d:: with SMTP id p13mr14398508wro.325.1573823565516;
 Fri, 15 Nov 2019 05:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20191112161240.4734-1-andriy.shevchenko@linux.intel.com> <20191115123707.GU32742@smile.fi.intel.com>
In-Reply-To: <20191115123707.GU32742@smile.fi.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 15 Nov 2019 13:12:37 +0000
Message-ID: <CAKv+Gu-sOBKZmZKLZtBFpiB0hO=WbJrLFY+bp5vxgX0xsU5Ygw@mail.gmail.com>
Subject: Re: [PATCH v2] efi/earlycon: Remap entire framebuffer after page initialization
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

On Fri, 15 Nov 2019 at 12:37, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 12, 2019 at 06:12:40PM +0200, Andy Shevchenko wrote:
> > When the commit 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk
> > into generic earlycon implementation") moved x86 specific EFI earlyprintk
> > implementation to shared location it also tweaked the behaviour. In particular
> > it dropped a trick with full framebuffer remapping after page initialization.
> > This led to two regressions:
> > 1) very slow scrolling after page initialization;
> > 2) kernel hang when keep_bootcon parameter is being provided.
> >
> > Returning the trick back fixes #2 and mitigates, i.e. reduces the window when
> > slowness appears, #1 presumably due to eliminating heavy map()/unmap()
> > operations per each pixel line on the screen.
>
> Please, hold on. I found an issue when no earlycon is not being provided in command line.
> I will fix, test and send a v3 soon.
>

Ok

> >
> > Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: Matt Fleming <matt@codeblueprint.co.uk>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2:
> > - add __exitcall()
> > - swap type and attribute for __init / __exit functions as most used in the kernel
> >  drivers/firmware/efi/earlycon.c | 34 +++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
> > index c9a0efca17b0..8c6a3c67b7f2 100644
> > --- a/drivers/firmware/efi/earlycon.c
> > +++ b/drivers/firmware/efi/earlycon.c
> > @@ -17,14 +17,48 @@ static const struct font_desc *font;
> >  static u32 efi_x, efi_y;
> >  static u64 fb_base;
> >  static pgprot_t fb_prot;
> > +static void *efi_fb;
> > +
> > +/*
> > + * efi earlycon needs to use early_memremap() to map the framebuffer.
> > + * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
> > + * memremap() should be used instead. memremap() will be available after
> > + * paging_init() which is earlier than initcall callbacks. Thus adding this
> > + * early initcall function early_efi_map_fb() to map the whole efi framebuffer.
> > + */
> > +static int __init early_efi_map_fb(void)
> > +{
> > +     u32 size;
> > +
> > +     size = screen_info.lfb_size;
> > +     if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > +             efi_fb = memremap(fb_base, size, MEMREMAP_WB);
> > +     else
> > +             efi_fb = memremap(fb_base, size, MEMREMAP_WC);
> > +
> > +     return efi_fb ? 0 : -ENOMEM;
> > +}
> > +early_initcall(early_efi_map_fb);
> > +
> > +static void __exit early_efi_unmap_fb(void)
> > +{
> > +     memunmap(efi_fb);
> > +}
> > +__exitcall(early_efi_unmap_fb);
> >
> >  static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
> >  {
> > +     if (efi_fb)
> > +             return efi_fb + start;
> > +
> >       return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
> >  }
> >
> >  static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
> >  {
> > +     if (efi_fb)
> > +             return;
> > +
> >       early_memunmap(addr, len);
> >  }
> >
> > --
> > 2.24.0
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
