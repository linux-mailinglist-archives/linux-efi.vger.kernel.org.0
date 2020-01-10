Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8113678D
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2020 07:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbgAJGlH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jan 2020 01:41:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33736 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbgAJGlH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jan 2020 01:41:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so694216wrq.0
        for <linux-efi@vger.kernel.org>; Thu, 09 Jan 2020 22:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/RZ4u0JUpuGVwwhSIZqye0oIIcumhyPw3EAY8ouXyM=;
        b=GxZgFbxDOTwF4adCXyVdmjulIseFJKagZ1Y48ouQhAPdK6sb4/Dco+KIaYEcXpnqSC
         InD5wvPYobtLG8O4DZSW2Uo3RJSVw1+7vH+jr8AqOQxNSkdHHUAPX7RdPX3+i6ZuQGxl
         VuIgTzHeIrnYwn3HmzXrTUIqyN9SzPYlTWr2bNqSV2xK1QUiOxUwU53df5AXWrQv9inN
         IjolUD49XRU+mZ07jmPLXFZ9q7JP//LrSNKJItAjVEc28ZUGlawCVWIjR8PHZqj4ZmYw
         uKj4srBNEbULWNrWGSNOnr88NiGVhQ2pmzCigYjeBzakOvoKZSkormLVo0MWzwt9E4zI
         YNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/RZ4u0JUpuGVwwhSIZqye0oIIcumhyPw3EAY8ouXyM=;
        b=FNJKtbffhBnTF8iGhx+Ac4vvt5dz2AVLSiztaI6U0vRuZJdIcpCrfaIwPWzmW3kVDn
         5D7GMouJZNfKH2m+VSTj9Myd1hn+8daGw238YcQll8+eyLbvS8oDF6wo2ye5TZIOU8uB
         5/vKAbnA8EJQU5SCRP3RtA8f2hHYwX9yOKJUtA4RVeNYtuRp+xyCMalwZyx6DGBUKdV6
         7bVomeUha5tiwoEysGLy6aM95JITWj8e90lZ5s8HxYT6YumHqaepuJNlCT7nr73Mpt42
         UypWOijgeSNY28IlJIu2oLCvHKASt+7HGpbhlFQLtUAzlfQ6pzGuPPvLAJYbmAO4FkPk
         V9UQ==
X-Gm-Message-State: APjAAAVbqNZDItsnheTGfk+cxPqhDf2lawih2iSMlIEnRJ46ZeR71yew
        MflCkCSCjZhttvH9krFvFy4HeVBs9IOnQgMqo0A0HhObMK4=
X-Google-Smtp-Source: APXvYqyk1pyuZcdjeKNy45f1N63H1kc2qf5vnApG+al6Fj/bt/H8O3hNITqWTrhPnJLQOJ3XZCNvnBrhx1euH7XIxRw=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr1571884wrs.200.1578638464682;
 Thu, 09 Jan 2020 22:41:04 -0800 (PST)
MIME-Version: 1.0
References: <20200110030112.188845-1-saravanak@google.com>
In-Reply-To: <20200110030112.188845-1-saravanak@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 10 Jan 2020 07:40:53 +0100
Message-ID: <CAKv+Gu-4jvME3cuPBDtTVFn+-ZzttneFuBkor+N3G0JpeO4BzA@mail.gmail.com>
Subject: Re: [PATCH v3] efi: arm: defer probe of PCIe backed efifb on DT systems
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

On Fri, 10 Jan 2020 at 04:01, Saravana Kannan <saravanak@google.com> wrote:
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
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>
> v1 -> v2:
> - Rewrote the device linking part to not depend on initcall ordering
> v2 -> v3:
> - Added const and check for CONFIG_PCI
>

Thanks. I've queued this version in efi/next for v5.6


>  drivers/firmware/efi/arm-init.c | 107 ++++++++++++++++++++++++++++++--
>  1 file changed, 103 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index 904fa09e6a6b..d99f5b0c8a09 100644
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
> @@ -276,15 +278,112 @@ void __init efi_init(void)
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
> +static const struct fwnode_operations efifb_fwnode_ops = {
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
> +       if (IS_ENABLED(CONFIG_PCI))
> +               pd->dev.fwnode = &efifb_fwnode;
> +
> +       err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
> +       if (err)
> +               return err;
> +
> +       return platform_device_add(pd);
>  }
>  subsys_initcall(register_gop_device);
> --
> 2.25.0.rc1.283.g88dfdc4193-goog
>
