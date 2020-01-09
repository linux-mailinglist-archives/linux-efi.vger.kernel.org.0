Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5231B135AF9
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2020 15:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgAIOGB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jan 2020 09:06:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39020 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgAIOGB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jan 2020 09:06:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so7528310wrt.6
        for <linux-efi@vger.kernel.org>; Thu, 09 Jan 2020 06:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wHV7fLu1+idd5lVfa6Y08ed98hFBV7NTBA+k+ClsUc=;
        b=s8+lJx8XPCKl1bu/IDbDXnGALgg5kCvFvoWSnaeATdrbv9UyIVL47+GxgeX7EZzEQ/
         CEhTmb4J1Pub+C8EdKXf49I16Fg76XlSzshUSdokReGc4W0S8ZVzYFqtiu6lCgcX1v0v
         7E4HEtIHMZHgjfItNNZY5avIw/0bEZMUGGEF7TMzZ/RgfvttxI9cWuBeYhFx2hgu/XWO
         kfFFJBqHxxshh+xkmV0vF8EJbO2L3D1woe3KT4K8YayKhNepIIXuq0Ub1ijiji2pBsEU
         YdfuBxcyX1Hx9AYsgEkDmu/VZVX7oP8GDALRix0uFaa8w1zZCpzKXBMqxHQj4aRhZClv
         b6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wHV7fLu1+idd5lVfa6Y08ed98hFBV7NTBA+k+ClsUc=;
        b=TVFnLTiqfXmZ1+stpyd6wCyan3VMFSKz79mi79W2aFSw4kvQzZ91I5KFbre1b8xdw1
         aP3AT2H0koWbMnbpmclbBq15J/HvqFvBlq23DdD5dkQryzNCi1EoUwh2+VkQa2t/pV3B
         RGo+saRyDhCPPQfIDKKEyrWEuptweB9IV47GijpyDtc8J4TvHw5yvVba2ZFxgLT7ybVf
         eyEtBtLfM1eFcuHwzSsKc4iSMfnVqxDXPJI7s7RhMSQ/GMIK6BRtmRRs2jZmiycs81EU
         n+IlP7xYO4lEpIcD7XZWL4P0nvphj3g6tdA35tthB4EdCTqCA+JgSxyXgLnZQ8gn3l3j
         l/Sg==
X-Gm-Message-State: APjAAAUMFUf9ZLBZHJYGIhbIFrHHge2Bi2ATXKCSLUuYTlOGIRneRv/t
        5SlD9HGb08XOHR//0ZXnuhBLAFd9GtTvnjxYNjVcbA==
X-Google-Smtp-Source: APXvYqwpjC3WHE1zynzAigSBunMBepaBFYapFG+fVgkhXZNIcZe8TqNUmQIFjSFfBzCL2JNVxbvTaTG3U6WW8FMSEEE=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr10620602wrr.32.1578578759741;
 Thu, 09 Jan 2020 06:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20191224044146.232713-1-saravanak@google.com>
In-Reply-To: <20191224044146.232713-1-saravanak@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 9 Jan 2020 15:05:48 +0100
Message-ID: <CAKv+Gu_yDWhvR80Wg1-bzpD1aGwGC-UA+obcgn8CEKKjMdR7rQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi: arm: defer probe of PCIe backed efifb on DT systems
To:     Saravana Kannan <saravanak@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 24 Dec 2019 at 05:41, Saravana Kannan <saravanak@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The new of_devlink support breaks PCIe probing on ARM platforms booting
> via UEFI if the firmware exposes a EFI framebuffer that is backed by a
> PCI device. The reason is that the probing order gets reversed,
> resulting in a resource conflict on the framebuffer memory window when
> the PCIe probes last, causing it to give up entirely.
>
> Given that we rely on PCI quirks to deal with EFI framebuffers that get
> moved around in memory, we cannot simply drop the memory reservation, so
> instead, let's use the device link infrastructure to register this
> dependency, and force the probing to occur in the expected order.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Co-developed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>
> Hi Ard,
>
> I compile tested it and I think it should work. If you can actually run
> and test it, that'd be nice.
>
> You can also optimize find_pci_overlap_node() by caching the result if
> you think that's necessary.
>
> Right now this code will run always just like your code did. But once I
> rename of_devlink to fw_devlink, this code won't be run if fw_devlink is
> disabled.
>
> v1 -> v2:
> - Rewrote the device linking part to not depend on initcall ordering
>
>  drivers/firmware/efi/arm-init.c | 106 ++++++++++++++++++++++++++++++--
>  1 file changed, 102 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index 904fa09e6a6b..8b789ff83af0 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -10,10 +10,12 @@
>  #define pr_fmt(fmt)    "efi: " fmt
>
>  #include <linux/efi.h>
> +#include <linux/fwnode.h>
>  #include <linux/init.h>
>  #include <linux/memblock.h>
>  #include <linux/mm_types.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_fdt.h>
>  #include <linux/platform_device.h>
>  #include <linux/screen_info.h>
> @@ -276,15 +278,111 @@ void __init efi_init(void)
>                 efi_memmap_unmap();
>  }
>
> +static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
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
> +static struct device_node *find_pci_overlap_node(void)
> +{
> +       struct device_node *np;
> +
> +       for_each_node_by_type(np, "pci") {
> +               struct of_pci_range_parser parser;
> +               struct of_pci_range range;
> +               int err;
> +
> +               err = of_pci_range_parser_init(&parser, np);
> +               if (err) {
> +                       pr_warn("of_pci_range_parser_init() failed: %d\n", err);
> +                       continue;
> +               }
> +
> +               for_each_of_pci_range(&parser, &range)
> +                       if (efifb_overlaps_pci_range(&range))
> +                               return np;
> +       }
> +       return NULL;
> +}
> +
> +/*
> + * If the efifb framebuffer is backed by a PCI graphics controller, we have
> + * to ensure that this relation is expressed using a device link when
> + * running in DT mode, or the probe order may be reversed, resulting in a
> + * resource reservation conflict on the memory window that the efifb
> + * framebuffer steals from the PCIe host bridge.
> + */
> +static int efifb_add_links(const struct fwnode_handle *fwnode,
> +                          struct device *dev)
> +{
> +       struct device_node *sup_np;
> +       struct device *sup_dev;
> +
> +       sup_np = find_pci_overlap_node();
> +
> +       /*
> +        * If there's no PCI graphics controller backing the efifb, we are
> +        * done here.
> +        */
> +       if (!sup_np)
> +               return 0;
> +
> +       sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
> +       of_node_put(sup_np);
> +
> +       /*
> +        * Return -ENODEV if the PCI graphics controller device hasn't been
> +        * registered yet.  This ensures that efifb isn't allowed to probe
> +        * and this function is retried again when new devices are
> +        * registered.
> +        */
> +       if (!sup_dev)
> +               return -ENODEV;
> +
> +       /*
> +        * If this fails, retrying this function at a later point won't
> +        * change anything. So, don't return an error after this.
> +        */
> +       if (!device_link_add(dev, sup_dev, 0))
> +               dev_warn(dev, "device_link_add() failed\n");
> +
> +       put_device(sup_dev);
> +
> +       return 0;
> +}
> +
> +static struct fwnode_operations efifb_fwnode_ops = {

Please make this const

> +       .add_links = efifb_add_links,
> +};
> +
> +static struct fwnode_handle efifb_fwnode = {
> +       .ops = &efifb_fwnode_ops,
> +};
> +
>  static int __init register_gop_device(void)
>  {
> -       void *pd;
> +       struct platform_device *pd;
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

Add

  if (IS_ENABLED(CONFIG_PCI))

here

> +       pd->dev.fwnode = &efifb_fwnode;
> +
> +       err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
> +       if (err)
> +               return err;
> +
> +       return platform_device_add(pd);
>  }
>  subsys_initcall(register_gop_device);
> --
> 2.24.1.735.g03f4e72817-goog
>

With the changes above

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

but it still needs testing as well.
