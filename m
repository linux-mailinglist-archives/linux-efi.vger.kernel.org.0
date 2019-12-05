Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8E1145AF
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfLERSh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 12:18:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53863 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbfLERSh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Dec 2019 12:18:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id n9so4254558wmd.3
        for <linux-efi@vger.kernel.org>; Thu, 05 Dec 2019 09:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHpqxvaUgnk44dPrsG65ofcnX3nIRy1UzgIHEHebgDA=;
        b=noalt3BUT4dwHrKmG3QCMhKgWC+NgmoD5U/65cFoidvxGT5x3WtOKAOKXYMMJ9jHuP
         FfGsp3Un+Y9wDeqpYJl91Ap8BpJ27S4J6cY0R1UICP4HLj6B9RPJ9RUClACtmEHvUMH7
         TFIKeL3Iqp7L/EvTZHGKXTiQSbg6TNzZQLVoAkjBCT2fwFM6UI4FQQiTyKGBC6ysMEHV
         vya9Qdchyal4XRaS1VAKC5FMSc4tfLbI3vJdZUF1T7/7gZEnuln0JqoyE5GTKyGnBAL9
         s6G3S8C2POP+wi7GeoEBcEhGl/OlY631xlmSeX9hZfT1ln3zOJm4rtntJyLnoaHQn37e
         H4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHpqxvaUgnk44dPrsG65ofcnX3nIRy1UzgIHEHebgDA=;
        b=gY/5ziNijk34Ea7518f/Fm/cah3CUikAtoqlYyCzKmfhuXMKLyTUq5/xV2aIp3NcxV
         kzL9YowGCAijkhBkUj88n1430qimK5otvZzgrDuM9QuCefCXKS4Hm6MkHzF3vr0zgndP
         K2Tid+bpJIAIySM7KVXhOi+pCnfliS5KbE2m1X7aG7THkWWEIcqgQo0wvC04Hm3r7Y4y
         HSBzQsK7vaML2Cn4el2L5Hs3jfhMRxrqNdSCH9rRwMltnKKGG+92t7omxgRz4wPLorOf
         BPIHAAz57S6IrazMapRdars5Q6l//u5fGehNzB5tmnmWYfbgjAOZfFpMWFwjVV9Zz3hb
         /Y6w==
X-Gm-Message-State: APjAAAXC7uZQuHxcQL8Y7WTKf1kbF9GJ7M+sQ0tYkZzqx/rcHbYa/Fjo
        HFZvaCf6gNhutb8k/nfWICTgaJQngfFf0MfI9js3Mg==
X-Google-Smtp-Source: APXvYqwQYdfauJ3ZLI4ADyFJda+yHyTQg66eR4/iNvlMv+f0EYyqb5E9AgnaEPTAtMxDQc0lRBM2P+t2v/aQleeEibg=
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr6250284wml.67.1575566314348;
 Thu, 05 Dec 2019 09:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20191205164248.14511-1-ardb@kernel.org> <CAKv+Gu9Q3TULTu9-=BtsCdzQJBb6ta=4=2RWNR-Q-NtqwCBQWg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9Q3TULTu9-=BtsCdzQJBb6ta=4=2RWNR-Q-NtqwCBQWg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 5 Dec 2019 17:18:30 +0000
Message-ID: <CAKv+Gu8+omXeHWOGSPOP3i8vF7awX1ajSFvEaRLTg5W4pMX7HA@mail.gmail.com>
Subject: Re: [PATCH v4] efi/earlycon: Remap entire framebuffer after page initialization
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 5 Dec 2019 at 17:16, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 5 Dec 2019 at 16:42, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
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
> > +       /* bail if there is no bootconsole or it has been disabled already */
> > +       if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
> > +               return 0;
> > +
> > +       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > +               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
> > +       else
> > +               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
> > +
> > +       return efi_fb ? 0 : -ENOMEM;
> > +}
> > +early_initcall(efi_earlycon_remap_fb);
> > +
> > +static int __init efi_earlycon_unmap_fb(void)
> > +{
> > +       /* unmap the bootconsole fb unless keep_bootcon has left it enabled */
> > +       if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
> > +               memunmap(efi_fb);
> > +       return 0;
> > +}
> > +late_initcall(efi_earlycon_unmap_fb);
> >
> >  static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
> >  {
> > +       if (efi_fb)
> > +               return efi_fb + start;
> > +
> >         return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
> >  }
> >
>
> Actually, now I'm not so sure we really need the early map/unmap for
> every line. If we switch from an early mapping to an ordinary mapping
> at early_initcall() time, we can just map it once, and tear it down
> when we do the ordinary memremap()
>

Never mind ... early_memremap() cannot map the entire framebuffer in one go.

>
> >  static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
> >  {
> > +       if (efi_fb)
> > +               return;
> > +
> >         early_memunmap(addr, len);
> >  }
> >
> > @@ -201,6 +240,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
> >                 efi_earlycon_scroll_up();
> >
> >         device->con->write = efi_earlycon_write;
> > +       earlycon_console = device->con;
> >         return 0;
> >  }
> >  EARLYCON_DECLARE(efifb, efi_earlycon_setup);
> > --
> > 2.17.1
> >
