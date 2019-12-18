Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C3B123CFB
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 03:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLRCPA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Dec 2019 21:15:00 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33671 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfLRCO7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Dec 2019 21:14:59 -0500
Received: by mail-oi1-f194.google.com with SMTP id v140so325050oie.0
        for <linux-efi@vger.kernel.org>; Tue, 17 Dec 2019 18:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJLy770YGqzkELOCvbFFD3CzTSJb3Fm9LrGS1w2fcfg=;
        b=IdLbKoGGtGhRtEGBUCMwCVwCVw26dfeUlZwo1+BCPHeJEt9dxZDYFNDVvZd8QZSPFH
         PGHJcOLdjrz0rnp9qhRRt8hMF51JiPleMoj063DffM1YetrD4jXq4IWGuj7nzMIYV0km
         4G43lQVysb1moVLRxY+H4lf4/t3qORgrm4FAEWwjPXJwsEtqT4mW0WoCNxHnBzDqwElq
         NnYn6wdUkqOZ84gOiMzqiwg6khhz6G3/nFY6eQTg5G0h1CvgJDoQWG4oKrcaKgtMchGT
         aRGCQ9tg1OIkm9HW3m+DmNMTqSMOAw7g2eVrH36UWgMr3qTk4wLIYWSninCO2HTn8cwa
         GbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJLy770YGqzkELOCvbFFD3CzTSJb3Fm9LrGS1w2fcfg=;
        b=nir1m6G9wn/HEwnbt7CGdYQwgXAwyEbk+A1We1Fz3j1BAGo9zlk9ygTIIFfBNJ4BCv
         ywuWZNYaA7KQor1g/ZS2dsQB2co0XVnRgzklPAqr+YHR0b+70JYMGr92WQv8ys64tz1w
         2ajblLYE537sO5WiZJdyiqsp3Qc4yil9fIvSL5iWqni7bOeLMcEiiJnt3YY2gakCjO3o
         1yIckG+vJSiwC80CpVH2lVXijUN7oK2UoD87jZHQxjhwj67L7yt2vV7txkT9WQ6P20hT
         wXx/cVjHFr/KJ0TVr37ge1PaLUvfZVXdX8JM4usM0XgizneKM+ZUq+/BvWmcIeZ4cTp+
         NIKw==
X-Gm-Message-State: APjAAAW2pFP/IObhrXB4SGKxb0nvIUxQ7cMaMrPF1Ov0NzDTB3gp3Ezz
        i67Ha4i/wReFQhYRGcE4oWj1j7br2kKXpjWbiZg8nQ==
X-Google-Smtp-Source: APXvYqxd2HlxlJmwTNCYZHO0xOeD3uGAhhlt3LslSwVY13A95b5LlfdM8DVaccZbqeHOUsGEYnbbM5RWVEpudAKooPI=
X-Received: by 2002:aca:5490:: with SMTP id i138mr101718oib.69.1576635298004;
 Tue, 17 Dec 2019 18:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20191126162902.16788-1-ardb@kernel.org> <CAGETcx8SftK_=-Z374AzQ7vy2RGWqvF3ry+q9Y+cQ5dUhgNEew@mail.gmail.com>
 <CAKv+Gu_-1b=3_hUq41T_RNDtaUWBbFquDWQK64sZKGNdMseHGQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_-1b=3_hUq41T_RNDtaUWBbFquDWQK64sZKGNdMseHGQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 17 Dec 2019 18:14:22 -0800
Message-ID: <CAGETcx8zKwbDvVGcJXgw9GC61bzQt2kC2CYcgqTfMrDnMNDBrQ@mail.gmail.com>
Subject: Re: [PATCH] efi: arm: defer probe of PCIe backed efifb on DT systems
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 28, 2019 at 12:19 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 28 Nov 2019 at 20:29, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Nov 26, 2019 at 8:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > The new of_devlink support breaks PCIe probing on ARM platforms booting
> > > via UEFI if the firmware exposes a EFI framebuffer that is backed by a
> > > PCI device.
> >
> > Thanks for testing with of_devlink enabled!
> >
>
> Sure, no trouble at all.
>
> > > The reason is that the probing order gets reversed,
> > > resulting in a resource conflict on the framebuffer memory window when
> > > the PCIe probes last, causing it to give up entirely.
> >
> > Just so I understand it clearly, the probe order reversal is only
> > between this efi-framebuffer device and the PCIe device right? Not all
> > PCI devices or something like that, right? Do you have any info on
> > what dependency causes this reversal? Just curious.
> >
>
> It is the probe reversal between the efi-framebuffer on the one hand
> and the entire PCIe hierarchy on the other.
>
> For some reason, PCIe host controllers are usually probed very early,
> and I wouldn't be surprised if deferring that may cause other issues
> as well. However, of_devlink is presumably specific to DT systems,
> where PCIe does not play such a fundamental role like it does on x86,
> for instance.
>
> > > Given that we rely on PCI quirks to deal with EFI framebuffers that get
> > > moved around in memory, we cannot simply drop the memory reservation, so
> > > instead, let's use the device link infrastructure to register this
> > > dependency, and force the probing to occur in the expected order.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  drivers/firmware/efi/arm-init.c | 66 ++++++++++++++++++--
> > >  1 file changed, 61 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> > > index 311cd349a862..617226d50774 100644
> > > --- a/drivers/firmware/efi/arm-init.c
> > > +++ b/drivers/firmware/efi/arm-init.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/memblock.h>
> > >  #include <linux/mm_types.h>
> > >  #include <linux/of.h>
> > > +#include <linux/of_address.h>
> > >  #include <linux/of_fdt.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/screen_info.h>
> > > @@ -267,15 +268,70 @@ void __init efi_init(void)
> > >                 efi_memmap_unmap();
> > >  }
> > >
> > > +static bool __init efifb_overlaps_pci_range(const struct of_pci_range *range)
> > > +{
> > > +       u64 fb_base = screen_info.lfb_base;
> > > +
> > > +       if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> > > +               fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
> > > +
> > > +       return fb_base >= range->cpu_addr &&
> > > +              fb_base < (range->cpu_addr + range->size);
> > > +}
> > > +
> > >  static int __init register_gop_device(void)
> > >  {
> > > -       void *pd;
> > > +       struct platform_device *pd;
> > > +       struct device_node *np;
> > > +       bool found = false;
> > > +       int err;
> > >
> > >         if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> > >                 return 0;
> > >
> > > -       pd = platform_device_register_data(NULL, "efi-framebuffer", 0,
> > > -                                          &screen_info, sizeof(screen_info));
> > > -       return PTR_ERR_OR_ZERO(pd);
> > > +       pd = platform_device_alloc("efi-framebuffer", 0);
> > > +       if (!pd)
> > > +               return -ENOMEM;
> > > +
> > > +       err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       /*
> > > +        * If the efifb framebuffer is backed by a PCI graphics controller, we
> > > +        * have to ensure that this relation is expressed using a device link
> > > +        * when running in DT mode, or the probe order may be reversed,
> > > +        * resulting in a resource reservation conflict on the memory window
> > > +        * that the efifb framebuffer steals from the PCIe host bridge.
> > > +        */
> > > +       for_each_node_by_type(np, "pci") {
> > > +               struct of_pci_range_parser parser;
> > > +               struct of_pci_range range;
> > > +               struct device *sup_dev;
> > > +
> > > +               if (found) {
> > > +                       of_node_put(np);
> > > +                       break;
> > > +               }
> >
> > It looks like you are doing this here because you can't break out of
> > two loops when you set found = true. Is that right? If so, I think
> > doing this at the end of the loop would make it more obvious on what's
> > going on.
> >
>
> Yeah, I realized that after I posted it.
>
> > > +
> > > +               err = of_pci_range_parser_init(&parser, np);
> > > +               if (err) {
> > > +                       pr_warn("of_pci_range_parser_init() failed: %d\n", err);
> > > +                       continue;
> > > +               }
> > > +
> > > +               sup_dev = get_dev_from_fwnode(&np->fwnode);
> > > +
> > > +               for_each_of_pci_range(&parser, &range) {
> > > +                       if (efifb_overlaps_pci_range(&range)) {
> > > +                               found = true;
> > > +                               if (!device_link_add(&pd->dev, sup_dev, 0))
> > > +                                       pr_warn("device_link_add() failed\n");
> >
> > I think dev_warn(&pd->dev,...) might make the message more useful.
> > Otherwise, it's so confusing.
> >
>
> OK
>
> > > +                               break;
> > > +                       }
> > > +               }
> > > +               put_device(sup_dev);
> >
> > Can't you do the if (found) here? Another option is to simply do a
> > "goto out;" at the end of the if block where you set found = true.
> >
>
> Indeed.
>
> > > +       }
> > > +       return platform_device_add(pd);
> > >  }
> > > -subsys_initcall(register_gop_device);
> > > +device_initcall(register_gop_device);
> >
> > Looks like you are doing this so that this efi-framebuffer device gets
> > added after the PCIe device? So that device_add_link() succeeds?
> >
>
> I should have mentioned this in the commit log, I suppose: I copied
> this from the x86 code that registers the efifb platform device, it
> also uses device_initcall() to prevent probing too early.
>
> > I'm wondering if it would be better to implement this as a
> > fwnode_operations.add_links(). Since this efi-framebuffer device won't have any
> > fwnode, you can create your own fwnode and implement the add_links()
> > property. Not a strong opinion on this, but some food for thought.
> >
>
> I have no idea how that would look, Could you elaborate? I'd prefer it
> if we could have a solution where this logic is only invoked when
> necessary, i.e., when we are using device links in the first place.

I haven't forgotten this thread -- it's in my TODO list. I'm hoping to
get to this during the holiday weeks. I plan on sending an example
patch with some of your code in it and you can take it from there.
Does that sound good?

Thanks,
Saravana
