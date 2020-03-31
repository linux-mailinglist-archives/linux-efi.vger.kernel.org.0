Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6314D199640
	for <lists+linux-efi@lfdr.de>; Tue, 31 Mar 2020 14:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgCaMUk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Mar 2020 08:20:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33677 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbgCaMUk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Mar 2020 08:20:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id m14so18751468oic.0;
        Tue, 31 Mar 2020 05:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26HG4zFgugkC6qzQClM9onqv7r2JKUuvQ00Kk/wIJGg=;
        b=FXONAX0YpRtypaPZSQ3Wl+XD3tf3+JlmJqeg/M7PVGwJ6lhsSmO/xszNzUo0ZFEH7C
         QjxAU8sb/l/5ym0tVfMZevO3fuPtaEFq85Fyk2lVDUXwUP/HlqVcG48C9u6aavlD558u
         1Vewn+ET4rtfukpG+ZfadBHSRNXtnrqQn/FtO6yVKF93tL7NSimv4+dkpi2gcW138oCD
         RQGPOKWeO1w9JBNtgn9C/wdWlI++DmlEZOWM/zvcpmQC7ISgpnQr5lh22R6QvPNXNGjK
         XrwehwHU6Zw/wm4wf6FDTvQmBI0rS2XsGxCZwcOKeSuMEFIJ/guK4Yd24c+YFUFKVn3F
         b6mQ==
X-Gm-Message-State: ANhLgQ2xFzXvel5n+ntHqhCCoNZvzNaqaHADOoajsLlkkhRwQs0b308P
        JLbe/qqQRP8IMU/ueFHAlEJiAOrh37Wb4DAReH8=
X-Google-Smtp-Source: ADFU+vvJjq6t9HN5MU6KVtgDmhuo8qjq6hgZzLnrDwNCTZl1iXr18JU6fsxiGfnMFt3tCqOJSDnBy8jyMBNiZHZ3piU=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr1719981oig.153.1585657239572;
 Tue, 31 Mar 2020 05:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200222014038.180923-1-saravanak@google.com> <20200222014038.180923-6-saravanak@google.com>
In-Reply-To: <20200222014038.180923-6-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Mar 2020 14:20:27 +0200
Message-ID: <CAMuHMdW_pvt1b6Y8e5j0Q5yDFMsg5z61upOo+gFaq7zf1F0V6w@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] of: property: Delete of_devlink kernel commandline option
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Saravana,

On Sat, Feb 22, 2020 at 2:41 AM Saravana Kannan <saravanak@google.com> wrote:
> With the addition of fw_devlink kernel commandline option, of_devlink is
> redundant and not useful anymore. So, delete it.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks for your patch!

This is now commit e94f62b7140fa3da ("of: property: Delete of_devlink
kernel commandline option") upstream.

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3299,12 +3299,6 @@
>                         This can be set from sysctl after boot.
>                         See Documentation/admin-guide/sysctl/vm.rst for details.
>
> -       of_devlink      [OF, KNL] Create device links between consumer and
> -                       supplier devices by scanning the devictree to infer the
> -                       consumer/supplier relationships.  A consumer device
> -                       will not be probed until all the supplier devices have
> -                       probed successfully.
> -
>         ohci1394_dma=early      [HW] enable debugging via the ohci1394 driver.
>                         See Documentation/debugging-via-ohci1394.txt for more
>                         info.

While I agree with the thunk above...

> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 15fc9315f1a7..f104f15b57fb 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1299,15 +1299,9 @@ static int of_link_to_suppliers(struct device *dev,
>         return ret;
>  }
>
> -static bool of_devlink;
> -core_param(of_devlink, of_devlink, bool, 0);
> -
>  static int of_fwnode_add_links(const struct fwnode_handle *fwnode,
>                                struct device *dev)
>  {
> -       if (!of_devlink)
> -               return 0;
> -
>         if (unlikely(!is_of_node(fwnode)))
>                 return 0;

... I have some reservations about removing the actual code.
The "of_devlink" kernel parameter was supported in v5.5 and v5.6, so
removing its support may silently break some setups.

Is this likely to happen?
Do we need a compatibility fallback that warns to user to update his kernel
command line?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
