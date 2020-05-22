Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034761DEBF5
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgEVPev (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 11:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbgEVPeu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 22 May 2020 11:34:50 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5B2C206F6
        for <linux-efi@vger.kernel.org>; Fri, 22 May 2020 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590161689;
        bh=6a7pggxIB+wqKFYQ4fVgg3bZNhZ8ceQJOiYGDOevjZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e6khmz7BSF6yHp12Lyc4SQp/V6JhVHloObeZ904oTaGXZv1vC2S3u1rt7kLrjsIV9
         C3aaGQqg87NFvNDCs90m6n+gCE98cekT7We6Ta+Zr09NmBTOn4oUG4vgurM7QAHN1h
         DJVsVsFayA0FjL0+CRmRsn7NazyMlJLEC8ZIpffs=
Received: by mail-io1-f52.google.com with SMTP id o5so11750809iow.8
        for <linux-efi@vger.kernel.org>; Fri, 22 May 2020 08:34:49 -0700 (PDT)
X-Gm-Message-State: AOAM533xeKEL72zIUpJkEkLPGdaAsKUFL40FqcPo373LXVfeS8RDUwsT
        9yB+RPU8hh6ZV88M0qMDGa3ksOPv9L5BgdSMOrM=
X-Google-Smtp-Source: ABdhPJxDwDQdll7ve9En/fQB4pkPmJFFGsplLa6bQXvOrePUMjWMmGDCon8grEmV0TdBAiqhMQAYbChTBgbTZ8dBN3g=
X-Received: by 2002:a5d:9b8a:: with SMTP id r10mr3623858iom.171.1590161689310;
 Fri, 22 May 2020 08:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200522141726.19220-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200522141726.19220-1-andriy.shevchenko@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 22 May 2020 17:34:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF4hrhsag31dNxJjeAs4bzZRfhYVGrwuZfzS285gdgr_A@mail.gmail.com>
Message-ID: <CAMj1kXF4hrhsag31dNxJjeAs4bzZRfhYVGrwuZfzS285gdgr_A@mail.gmail.com>
Subject: Re: [PATCH v1] efi/dev-path-parser: Switch to acpi_dev_get_first_match_dev()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Lukas)

On Fri, 22 May 2020 at 16:17, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The acpi_dev_get_first_match_dev() helper will find and return
> an ACPI device pointer of the first registered device in the system
> by its HID and UID (if present). Use it instead of open coded variant.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/firmware/efi/dev-path-parser.c | 41 ++++++++------------------
>  1 file changed, 12 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
> index 5c9625e552f4..9edd56f8d01c 100644
> --- a/drivers/firmware/efi/dev-path-parser.c
> +++ b/drivers/firmware/efi/dev-path-parser.c
> @@ -12,51 +12,34 @@
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
> +       char hid[3 + 4 + 1];    /* 3 characters + 4 hex digits + null byte */
> +       char uid[10 + 1];       /* UINT_MAX + null byte */
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
> +       sprintf(uid, "%u", node->acpi.uid);
>
> -       *child = bus_find_device(&acpi_bus_type, NULL, &hid_uid,
> -                                match_acpi_dev);
> -       if (!*child)
> +       adev = acpi_dev_get_first_match_dev(hid, node->acpi.uid ? uid : NULL, -1);
> +       if (!adev)
>                 return -ENODEV;
>
> -       phys_dev = acpi_get_first_physical_node(to_acpi_device(*child));
> +       phys_dev = acpi_get_first_physical_node(adev);
>         if (phys_dev) {
> -               get_device(phys_dev);
> -               put_device(*child);
> -               *child = phys_dev;
> +               *child = get_device(phys_dev);
> +               acpi_dev_put(adev);
> +       } else {
> +               *child = &adev->dev;
>         }
>
>         return 0;
> --
> 2.26.2
>
