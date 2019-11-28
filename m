Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19AE10CF1D
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2019 21:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfK1UTV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Nov 2019 15:19:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44064 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1UTV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Nov 2019 15:19:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so32440759wrn.11
        for <linux-efi@vger.kernel.org>; Thu, 28 Nov 2019 12:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwfbITtTKZf6U4UKVcFswXjKlWYF5vruKcu6KmOu+jE=;
        b=R/b0ZkjsDQkkCZ2RZ77zpVd2zqx00vWlOhSSe39JfmVB29SGL5khb6sgtzq/KvnSZX
         /Zg7XMrhbcPnBhi5h+EW2Gb2NQAWjujMAw1eet1+WzpN1bAATd2BJeq8ImuWHGN2J+MQ
         FYtISt7ks+N+Nyd1JVUSkyUPVDX9i7mZ5EDwT61JeojrfyW0B/wzFNeUm/NXEl9lvxIS
         1h2oFx37NpAeuMemhPnQkd+JR3ZZ/hzBVo0uQV4hPZ0o1OTwZ9JGlhm41yhfsEDiWkUt
         TKDNzMIuYoHJBMsZBOq1QV9aRkHG5SwFdNIJD36uVOhX7cGEd0FKq6eIoCKcKYZRPtJt
         oysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwfbITtTKZf6U4UKVcFswXjKlWYF5vruKcu6KmOu+jE=;
        b=r2szZV+ba9p5n7Htqex11QdJegMJIJuipnu/E3jNObs0g291GW8Q+mCKRG5U9An4da
         9RfbYhVQ9GAqakK/lIittnY7SeUKKNJVewlhTp038VQx06jvm8c1DDDttwhreJSJw6Rw
         w6xkq7c/g9Z5AyVX89EM4XCrnY6L88HX0iue+j9kWInagKNl0OfNI3jR20fdohy3JO7H
         UMn/ktlV/l3ZIwXyGKMBEmZNmrP2omvu6ZbAdnkHsDb257iobB8+g4M45FQfJ7BEHlsd
         Z95lcxf6mzs/ijbNzG5jshlSBctNzqsZpK7N8q4LxAXOp41Rsy8zmrIgSBV0xyxQ+qrT
         s7mA==
X-Gm-Message-State: APjAAAVrgJyQ+gDXvfcrYSxXB+y1vSH/S/XzqSb8Vmzq+Yb5Im3tik09
        dvWaeYxYjKjT8Oq6xQ7oAG80N9qX8UED5NkxRIhngK7Cp+8=
X-Google-Smtp-Source: APXvYqynieOBcZ8Zilip2yTJnXgPUsKF3Z1rCvcfJjq3jGJ71IFLcZaiJgkovL+bo7Y/Bk3FTD9F4jUJmIpa9U+JPk4=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr29005289wrs.200.1574972358213;
 Thu, 28 Nov 2019 12:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20191126162902.16788-1-ardb@kernel.org> <CAGETcx8SftK_=-Z374AzQ7vy2RGWqvF3ry+q9Y+cQ5dUhgNEew@mail.gmail.com>
In-Reply-To: <CAGETcx8SftK_=-Z374AzQ7vy2RGWqvF3ry+q9Y+cQ5dUhgNEew@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 28 Nov 2019 21:19:07 +0100
Message-ID: <CAKv+Gu_-1b=3_hUq41T_RNDtaUWBbFquDWQK64sZKGNdMseHGQ@mail.gmail.com>
Subject: Re: [PATCH] efi: arm: defer probe of PCIe backed efifb on DT systems
To:     Saravana Kannan <saravanak@google.com>
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

On Thu, 28 Nov 2019 at 20:29, Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Nov 26, 2019 at 8:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > The new of_devlink support breaks PCIe probing on ARM platforms booting
> > via UEFI if the firmware exposes a EFI framebuffer that is backed by a
> > PCI device.
>
> Thanks for testing with of_devlink enabled!
>

Sure, no trouble at all.

> > The reason is that the probing order gets reversed,
> > resulting in a resource conflict on the framebuffer memory window when
> > the PCIe probes last, causing it to give up entirely.
>
> Just so I understand it clearly, the probe order reversal is only
> between this efi-framebuffer device and the PCIe device right? Not all
> PCI devices or something like that, right? Do you have any info on
> what dependency causes this reversal? Just curious.
>

It is the probe reversal between the efi-framebuffer on the one hand
and the entire PCIe hierarchy on the other.

For some reason, PCIe host controllers are usually probed very early,
and I wouldn't be surprised if deferring that may cause other issues
as well. However, of_devlink is presumably specific to DT systems,
where PCIe does not play such a fundamental role like it does on x86,
for instance.

> > Given that we rely on PCI quirks to deal with EFI framebuffers that get
> > moved around in memory, we cannot simply drop the memory reservation, so
> > instead, let's use the device link infrastructure to register this
> > dependency, and force the probing to occur in the expected order.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/arm-init.c | 66 ++++++++++++++++++--
> >  1 file changed, 61 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> > index 311cd349a862..617226d50774 100644
> > --- a/drivers/firmware/efi/arm-init.c
> > +++ b/drivers/firmware/efi/arm-init.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/memblock.h>
> >  #include <linux/mm_types.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_fdt.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/screen_info.h>
> > @@ -267,15 +268,70 @@ void __init efi_init(void)
> >                 efi_memmap_unmap();
> >  }
> >
> > +static bool __init efifb_overlaps_pci_range(const struct of_pci_range *range)
> > +{
> > +       u64 fb_base = screen_info.lfb_base;
> > +
> > +       if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> > +               fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
> > +
> > +       return fb_base >= range->cpu_addr &&
> > +              fb_base < (range->cpu_addr + range->size);
> > +}
> > +
> >  static int __init register_gop_device(void)
> >  {
> > -       void *pd;
> > +       struct platform_device *pd;
> > +       struct device_node *np;
> > +       bool found = false;
> > +       int err;
> >
> >         if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> >                 return 0;
> >
> > -       pd = platform_device_register_data(NULL, "efi-framebuffer", 0,
> > -                                          &screen_info, sizeof(screen_info));
> > -       return PTR_ERR_OR_ZERO(pd);
> > +       pd = platform_device_alloc("efi-framebuffer", 0);
> > +       if (!pd)
> > +               return -ENOMEM;
> > +
> > +       err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
> > +       if (err)
> > +               return err;
> > +
> > +       /*
> > +        * If the efifb framebuffer is backed by a PCI graphics controller, we
> > +        * have to ensure that this relation is expressed using a device link
> > +        * when running in DT mode, or the probe order may be reversed,
> > +        * resulting in a resource reservation conflict on the memory window
> > +        * that the efifb framebuffer steals from the PCIe host bridge.
> > +        */
> > +       for_each_node_by_type(np, "pci") {
> > +               struct of_pci_range_parser parser;
> > +               struct of_pci_range range;
> > +               struct device *sup_dev;
> > +
> > +               if (found) {
> > +                       of_node_put(np);
> > +                       break;
> > +               }
>
> It looks like you are doing this here because you can't break out of
> two loops when you set found = true. Is that right? If so, I think
> doing this at the end of the loop would make it more obvious on what's
> going on.
>

Yeah, I realized that after I posted it.

> > +
> > +               err = of_pci_range_parser_init(&parser, np);
> > +               if (err) {
> > +                       pr_warn("of_pci_range_parser_init() failed: %d\n", err);
> > +                       continue;
> > +               }
> > +
> > +               sup_dev = get_dev_from_fwnode(&np->fwnode);
> > +
> > +               for_each_of_pci_range(&parser, &range) {
> > +                       if (efifb_overlaps_pci_range(&range)) {
> > +                               found = true;
> > +                               if (!device_link_add(&pd->dev, sup_dev, 0))
> > +                                       pr_warn("device_link_add() failed\n");
>
> I think dev_warn(&pd->dev,...) might make the message more useful.
> Otherwise, it's so confusing.
>

OK

> > +                               break;
> > +                       }
> > +               }
> > +               put_device(sup_dev);
>
> Can't you do the if (found) here? Another option is to simply do a
> "goto out;" at the end of the if block where you set found = true.
>

Indeed.

> > +       }
> > +       return platform_device_add(pd);
> >  }
> > -subsys_initcall(register_gop_device);
> > +device_initcall(register_gop_device);
>
> Looks like you are doing this so that this efi-framebuffer device gets
> added after the PCIe device? So that device_add_link() succeeds?
>

I should have mentioned this in the commit log, I suppose: I copied
this from the x86 code that registers the efifb platform device, it
also uses device_initcall() to prevent probing too early.

> I'm wondering if it would be better to implement this as a
> fwnode_operations.add_links(). Since this efi-framebuffer device won't have any
> fwnode, you can create your own fwnode and implement the add_links()
> property. Not a strong opinion on this, but some food for thought.
>

I have no idea how that would look, Could you elaborate? I'd prefer it
if we could have a solution where this logic is only invoked when
necessary, i.e., when we are using device links in the first place.

Thanks,
Ard.
