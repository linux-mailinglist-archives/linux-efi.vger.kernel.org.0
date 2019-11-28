Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B26610CEE0
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2019 20:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK1T3H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Nov 2019 14:29:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33568 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1T3H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Nov 2019 14:29:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id q23so17196362otn.0
        for <linux-efi@vger.kernel.org>; Thu, 28 Nov 2019 11:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWjSSi5aq5uM2KHYjbtzMMEROQeiD1YWonOayYvqyPY=;
        b=phfC43VyqugLnkw06GjuHHWximhkOGnseIDlCLCBW6Im/uakoX4EPLz3itzutNZ5Pv
         IQ1M7RmmU11Ii1EuG3UowxXy1UEDz+GdM3YeBrQ0KgHHQdo0WxSuBEpqexb1vnRt3KB7
         SADjzJ4ytVG72KfvJxKEzqfQBYlrDjIgnr9qncgm4gvNZGzRWgo+mcJySBMXpWTySECh
         n82UmgugzoDYfE+k0PpQVN1/abJA/ZIKDRYBGHB04uCa7tRquxvyfzpdKaNv5IreEUSC
         pzrd5m/kCzSCJW7CrI1xJhsPjsM2CEvJUUMkJMSNwF/APeK6HET441BoWxMl5SYikxu7
         HtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWjSSi5aq5uM2KHYjbtzMMEROQeiD1YWonOayYvqyPY=;
        b=qnfj9Hv+7qjVJV1/o9mSXAmjhkytwZPQEKyxFkcXUmqDex50HXXBN3d7pLqqt7WhdK
         O6JITd5gbima673LSQGBX1cLlv47kvTcsePhr+9nWQtMTffKDtoVvGACItKXV+dNEGNv
         Q4USebCJ8LrfbU2EplXx6LU1ZXw1MxT5owty/moasP/7jqnjPEGHG1cZ/SF5ZBZOoHTc
         33/StXgNjga7JbSFFMQDvsAjhq6idqSNTF8HNP1eFKi9ctfAEZWiazPEORM1GgAM944d
         2PKeZR67DEDsqARbK9H3MBmvFHxF0qpSqFcUpfx5C52ofh0XfodcCyZwNawtaLZW+my3
         zh1g==
X-Gm-Message-State: APjAAAXT7/2N7F0csk+hF23lMrkuPaIB2TWnWhJFcmyqkdWooAdX7ddE
        SQx3AW6sv2Q1jgx069OWNESdmbdLP9ja3qxmVl2i4w==
X-Google-Smtp-Source: APXvYqzxl3D+VhUEF/SkqMh+WTUSoybuysILJoeq0mHnv087jrYtxmnSe3o+CfKdqWBhCUzE9NGlSxmw/YdVLxl/TZc=
X-Received: by 2002:a05:6830:60f:: with SMTP id w15mr8509841oti.225.1574969344088;
 Thu, 28 Nov 2019 11:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20191126162902.16788-1-ardb@kernel.org>
In-Reply-To: <20191126162902.16788-1-ardb@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 28 Nov 2019 11:28:27 -0800
Message-ID: <CAGETcx8SftK_=-Z374AzQ7vy2RGWqvF3ry+q9Y+cQ5dUhgNEew@mail.gmail.com>
Subject: Re: [PATCH] efi: arm: defer probe of PCIe backed efifb on DT systems
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 26, 2019 at 8:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The new of_devlink support breaks PCIe probing on ARM platforms booting
> via UEFI if the firmware exposes a EFI framebuffer that is backed by a
> PCI device.

Thanks for testing with of_devlink enabled!

> The reason is that the probing order gets reversed,
> resulting in a resource conflict on the framebuffer memory window when
> the PCIe probes last, causing it to give up entirely.

Just so I understand it clearly, the probe order reversal is only
between this efi-framebuffer device and the PCIe device right? Not all
PCI devices or something like that, right? Do you have any info on
what dependency causes this reversal? Just curious.

> Given that we rely on PCI quirks to deal with EFI framebuffers that get
> moved around in memory, we cannot simply drop the memory reservation, so
> instead, let's use the device link infrastructure to register this
> dependency, and force the probing to occur in the expected order.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/arm-init.c | 66 ++++++++++++++++++--
>  1 file changed, 61 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index 311cd349a862..617226d50774 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -14,6 +14,7 @@
>  #include <linux/memblock.h>
>  #include <linux/mm_types.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_fdt.h>
>  #include <linux/platform_device.h>
>  #include <linux/screen_info.h>
> @@ -267,15 +268,70 @@ void __init efi_init(void)
>                 efi_memmap_unmap();
>  }
>
> +static bool __init efifb_overlaps_pci_range(const struct of_pci_range *range)
> +{
> +       u64 fb_base = screen_info.lfb_base;
> +
> +       if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> +               fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
> +
> +       return fb_base >= range->cpu_addr &&
> +              fb_base < (range->cpu_addr + range->size);
> +}
> +
>  static int __init register_gop_device(void)
>  {
> -       void *pd;
> +       struct platform_device *pd;
> +       struct device_node *np;
> +       bool found = false;
> +       int err;
>
>         if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
>                 return 0;
>
> -       pd = platform_device_register_data(NULL, "efi-framebuffer", 0,
> -                                          &screen_info, sizeof(screen_info));
> -       return PTR_ERR_OR_ZERO(pd);
> +       pd = platform_device_alloc("efi-framebuffer", 0);
> +       if (!pd)
> +               return -ENOMEM;
> +
> +       err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
> +       if (err)
> +               return err;
> +
> +       /*
> +        * If the efifb framebuffer is backed by a PCI graphics controller, we
> +        * have to ensure that this relation is expressed using a device link
> +        * when running in DT mode, or the probe order may be reversed,
> +        * resulting in a resource reservation conflict on the memory window
> +        * that the efifb framebuffer steals from the PCIe host bridge.
> +        */
> +       for_each_node_by_type(np, "pci") {
> +               struct of_pci_range_parser parser;
> +               struct of_pci_range range;
> +               struct device *sup_dev;
> +
> +               if (found) {
> +                       of_node_put(np);
> +                       break;
> +               }

It looks like you are doing this here because you can't break out of
two loops when you set found = true. Is that right? If so, I think
doing this at the end of the loop would make it more obvious on what's
going on.

> +
> +               err = of_pci_range_parser_init(&parser, np);
> +               if (err) {
> +                       pr_warn("of_pci_range_parser_init() failed: %d\n", err);
> +                       continue;
> +               }
> +
> +               sup_dev = get_dev_from_fwnode(&np->fwnode);
> +
> +               for_each_of_pci_range(&parser, &range) {
> +                       if (efifb_overlaps_pci_range(&range)) {
> +                               found = true;
> +                               if (!device_link_add(&pd->dev, sup_dev, 0))
> +                                       pr_warn("device_link_add() failed\n");

I think dev_warn(&pd->dev,...) might make the message more useful.
Otherwise, it's so confusing.

> +                               break;
> +                       }
> +               }
> +               put_device(sup_dev);

Can't you do the if (found) here? Another option is to simply do a
"goto out;" at the end of the if block where you set found = true.

> +       }
> +       return platform_device_add(pd);
>  }
> -subsys_initcall(register_gop_device);
> +device_initcall(register_gop_device);

Looks like you are doing this so that this efi-framebuffer device gets
added after the PCIe device? So that device_add_link() succeeds?

I'm wondering if it would be better to implement this as a
fwnode_operations.add_links(). Since this efi-framebuffer device won't have any
fwnode, you can create your own fwnode and implement the add_links()
property. Not a strong opinion on this, but some food for thought.

Thanks,
Saravana
