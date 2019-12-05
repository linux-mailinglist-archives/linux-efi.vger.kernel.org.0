Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C57811476D
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 20:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfLETDD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 14:03:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53449 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLETDD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Dec 2019 14:03:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id n9so4596229wmd.3
        for <linux-efi@vger.kernel.org>; Thu, 05 Dec 2019 11:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJ6JxBvziYiCNrA7jgudzED31L4BeNayPItHqU5Qm5A=;
        b=KwBYm4GEf9A0/aQANCacIpdCw+MCvWHB5nlmV/wPmfYCLWO96zmAcDqAxEf6w/UtDM
         Tl+GuUIHas3Nwxj32pUevjhuBE6EQzlY6G3vAJ701EAoCrC5AKGjuBLCymyVUZwJVC/T
         3z1DcKp68FeU4eg3j1HG+8ZoxbDRzTVcf0l6NvUaFRZclp6GR2mDnYHePPe7W+AoRs+I
         jsjSanoioL34g51G+nvq9Jmh0/tAaAR/YNfmA7LPZkBM7VGcSlS4AOhj5y4OE5qBNCmi
         XNHVTllqsDvP9HpVPJ+vNUGBZs2qqFSGoSxF8c6aENbCYu9bQjzLttFnXa2twFAKOFyR
         Htbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJ6JxBvziYiCNrA7jgudzED31L4BeNayPItHqU5Qm5A=;
        b=ei+ET2JlmouDSlePgPFitdyQNrgblO6BCK+SdSvxwFmWM0+2W6Cm7AKRlpJ4b6yipm
         r1B57UTSEpyfiexw+apGah6xZ89ZeIo5K34e32q1KIdsw6wW+41nm9P0Pf99WvWk8YoA
         YBOQwir9griKIFiCn7CdkMCphzykJkXacewcjZnmQltHm3c2nbz5U9lbUTqoPmYO3+lQ
         VVoi+AVxrIayHTjr/Q7tkGqjLuCdIKrTulPZN32sqA7qzNCV15HlQiSC3t1V1XtKgIVr
         WnGhlvRD/r2ZV111S3DlHw1QbvFhABuYFtqkaLJC3P4e9k0ZHNNnez9fx9gECuDusnCZ
         pQfA==
X-Gm-Message-State: APjAAAVKc6lCN96/IG0Ao8GovBfVyFJzOYm1FudW8QUKYClPfWE2J8lJ
        oBcelVsShG3Cx6qILRrk9bZTFg1H3EQLMBt5TbCBdQ==
X-Google-Smtp-Source: APXvYqxLLpje08yc4tzwNYot/JZ3rMaojaWEqTRI2K4naEIqp9MYphoCHBB7H6X92xFiEhLs6nC3bDpcXTOMoPoPclI=
X-Received: by 2002:a7b:c006:: with SMTP id c6mr4428347wmb.52.1575572580418;
 Thu, 05 Dec 2019 11:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20191205164248.14511-1-ardb@kernel.org> <20191205185632.GA32742@smile.fi.intel.com>
In-Reply-To: <20191205185632.GA32742@smile.fi.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 5 Dec 2019 19:02:56 +0000
Message-ID: <CAKv+Gu8iRfNVAywXvXxEOvV=OTwbCZ62rBDWDV2JdDZpXSRkrA@mail.gmail.com>
Subject: Re: [PATCH v4] efi/earlycon: Remap entire framebuffer after page initialization
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 5 Dec 2019 at 18:56, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 05, 2019 at 04:42:48PM +0000, Ard Biesheuvel wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > When commit 69c1f396f25b
> >
> >   "efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation"
> >
> > moved the x86 specific EFI earlyprintk implementation to a shared location,
> > it also tweaked the behaviour. In particular, it dropped a trick with full
> > framebuffer remapping after page initialization, leading to two regressions:
> > 1) very slow scrolling after page initialization,
> > 2) kernel hang when the 'keep_bootcon' command line argument is passed.
> >
> > Putting the tweak back fixes #2 and mitigates #1, i.e., it limits the slow
> > behavior to the early boot stages, presumably due to eliminating heavy
> > map()/unmap() operations per each pixel line on the screen.
> >
> > Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > [ardb: ensure efifb is unmapped again unless keep_bootcon is in effect]
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/earlycon.c | 40 +++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
> > index c9a0efca17b0..0bc4fe741415 100644
> > --- a/drivers/firmware/efi/earlycon.c
> > +++ b/drivers/firmware/efi/earlycon.c
> > @@ -13,18 +13,57 @@
> >
> >  #include <asm/early_ioremap.h>
> >
> > +static const struct console *earlycon_console __initdata;
> >  static const struct font_desc *font;
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
> > +static int __init efi_earlycon_remap_fb(void)
> > +{
> > +     /* bail if there is no bootconsole or it has been disabled already */
> > +     if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
> > +             return 0;
> > +
> > +     if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > +             efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
> > +     else
> > +             efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
> > +
> > +     return efi_fb ? 0 : -ENOMEM;
> > +}
> > +early_initcall(efi_earlycon_remap_fb);
> > +
> > +static int __init efi_earlycon_unmap_fb(void)
> > +{
> > +     /* unmap the bootconsole fb unless keep_bootcon has left it enabled */
>
> > +     if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
>
> Isn't efi_fb test superfluous here?
>

Well, it could be NULL so it is not superfluous. The initcall() is
always executed, even if you are not using earlycon=efifb at all.

> > +             memunmap(efi_fb);
>
> > +     return 0;
> > +}
> > +late_initcall(efi_earlycon_unmap_fb);
>
> I still think we need __exitcall() to clean up the stuff in any case.
>

Why? As far as I can tell, exitcalls go straight into a /DISCARD/
section, and I really don't see the point of carrying dead code in
this file.

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
> > @@ -201,6 +240,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
> >               efi_earlycon_scroll_up();
> >
> >       device->con->write = efi_earlycon_write;
> > +     earlycon_console = device->con;
> >       return 0;
> >  }
> >  EARLYCON_DECLARE(efifb, efi_earlycon_setup);
> > --
> > 2.17.1
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
