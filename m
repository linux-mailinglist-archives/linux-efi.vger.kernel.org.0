Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BBE35ABE8
	for <lists+linux-efi@lfdr.de>; Sat, 10 Apr 2021 10:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhDJId7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 10 Apr 2021 04:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhDJId6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 10 Apr 2021 04:33:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37172610C8;
        Sat, 10 Apr 2021 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618043624;
        bh=lS9lkcfqzV/7AwxdfQRujIQfHTrH03nU7vYgR5usPVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VpG9rx3xPsw5/BSNCa5fwbE2C+vDvyvvHj4gJryTTE9cGTGm22DYfmEw+j20S4x0Q
         KilUGuKbi2hP9EzW1Qy1Vw6JnX/17/EL+7D32nJoB1+CnQWQOpB2jAMyQKYXpsHcbo
         ipsjjr634aDXX85tAUIs3/It7hnWLeDyai77GwdAfCxFs0//P+tYs+cEGZq9qvkv9c
         N7cwaEEBsbl8kJXSRBdSAQPOjEX2WXLgwwesu7GyN7OjIzRMV3d23ftIlm7/Y4QV6X
         f20MljMFwYGkrkxobUf5e/398b3wFBptpYoz8LJyrC9B5/3RMfo6Ec8a7hoMy1EftQ
         AF1k4vzuRIpLw==
Received: by mail-ot1-f42.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso6076754otb.13;
        Sat, 10 Apr 2021 01:33:44 -0700 (PDT)
X-Gm-Message-State: AOAM530hOEYel4O55sNFg2OPotXsG5aIzFzG+vWHcCo2rSjSiW1h32Bz
        9Y2vqrmH+oYPkM1BmW6NkipsFiqrIaVHvIWpPoI=
X-Google-Smtp-Source: ABdhPJyDxw2NORXjwupt1IqrCmpfOr8jpKJwdR/Fri5xj8u+ukRamo2nRRO/GrR9a6BBpomrFPchSg804GKu5ccAMoo=
X-Received: by 2002:a9d:12cb:: with SMTP id g69mr15336611otg.77.1618043623547;
 Sat, 10 Apr 2021 01:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210404181216.1450776-1-andy.shevchenko@gmail.com>
In-Reply-To: <20210404181216.1450776-1-andy.shevchenko@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 10 Apr 2021 10:33:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHTWf-9=y2kSVm09Ln9Aq=mriL57zEHwfBnS_K0Sqn86A@mail.gmail.com>
Message-ID: <CAMj1kXHTWf-9=y2kSVm09Ln9Aq=mriL57zEHwfBnS_K0Sqn86A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi/dev-path-parser: Switch to use for_each_acpi_dev_match()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 4 Apr 2021 at 20:12, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> Switch to use for_each_acpi_dev_match() instead of home grown analogue.
> No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v2: fixed refcounting
>     (example from which I took the v1 approach has been broken, fix is sent :-)

Queued up in efi/next, thanks

>  drivers/firmware/efi/dev-path-parser.c | 49 ++++++++++----------------
>  1 file changed, 18 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
> index 5c9625e552f4..10d4457417a4 100644
> --- a/drivers/firmware/efi/dev-path-parser.c
> +++ b/drivers/firmware/efi/dev-path-parser.c
> @@ -12,52 +12,39 @@
>  #include <linux/efi.h>
>  #include <linux/pci.h>
>
> -struct acpi_hid_uid {
> -       struct acpi_device_id hid[2];
> -       char uid[11]; /* UINT_MAX + null byte */
> -};
> -
> -static int __init match_acpi_dev(struct device *dev, const void *data)
> -{
> -       struct acpi_hid_uid hid_uid = *(const struct acpi_hid_uid *)data;
> -       struct acpi_device *adev = to_acpi_device(dev);
> -
> -       if (acpi_match_device_ids(adev, hid_uid.hid))
> -               return 0;
> -
> -       if (adev->pnp.unique_id)
> -               return !strcmp(adev->pnp.unique_id, hid_uid.uid);
> -       else
> -               return !strcmp("0", hid_uid.uid);
> -}
> -
>  static long __init parse_acpi_path(const struct efi_dev_path *node,
>                                    struct device *parent, struct device **child)
>  {
> -       struct acpi_hid_uid hid_uid = {};
> +       char hid[ACPI_ID_LEN], uid[11]; /* UINT_MAX + null byte */
> +       struct acpi_device *adev;
>         struct device *phys_dev;
>
>         if (node->header.length != 12)
>                 return -EINVAL;
>
> -       sprintf(hid_uid.hid[0].id, "%c%c%c%04X",
> +       sprintf(hid, "%c%c%c%04X",
>                 'A' + ((node->acpi.hid >> 10) & 0x1f) - 1,
>                 'A' + ((node->acpi.hid >>  5) & 0x1f) - 1,
>                 'A' + ((node->acpi.hid >>  0) & 0x1f) - 1,
>                         node->acpi.hid >> 16);
> -       sprintf(hid_uid.uid, "%u", node->acpi.uid);
> -
> -       *child = bus_find_device(&acpi_bus_type, NULL, &hid_uid,
> -                                match_acpi_dev);
> -       if (!*child)
> +       sprintf(uid, "%u", node->acpi.uid);
> +
> +       for_each_acpi_dev_match(adev, hid, NULL, -1) {
> +               if (adev->pnp.unique_id && !strcmp(adev->pnp.unique_id, uid))
> +                       break;
> +               if (!adev->pnp.unique_id && node->acpi.uid == 0)
> +                       break;
> +               acpi_dev_put(adev);
> +       }
> +       if (!adev)
>                 return -ENODEV;
>
> -       phys_dev = acpi_get_first_physical_node(to_acpi_device(*child));
> +       phys_dev = acpi_get_first_physical_node(adev);
>         if (phys_dev) {
> -               get_device(phys_dev);
> -               put_device(*child);
> -               *child = phys_dev;
> -       }
> +               *child = get_device(phys_dev);
> +               acpi_dev_put(adev);
> +       } else
> +               *child = &adev->dev;
>
>         return 0;
>  }
> --
> 2.31.1
>
