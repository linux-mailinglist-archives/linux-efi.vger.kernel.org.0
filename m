Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9205B16C7
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 10:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiIHIVK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 04:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiIHIVI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 04:21:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1460DA2AAC;
        Thu,  8 Sep 2022 01:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7A10CE1E99;
        Thu,  8 Sep 2022 08:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B85CC43146;
        Thu,  8 Sep 2022 08:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662625261;
        bh=juJ+Obww8wGr6tHeP9vf9AOYM2NQPYUQZ/m7TW5mLNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tizFdmsAzfuZlcCB1PzQp+Fstqe0Gz/AU3kH4AsoFOt+oJE/o4IJp0tANnzRfQ+ds
         O0udAzI/++KI8ecttK/dmXVBeehu33B5OHBJfPfYOD4W9GI9EB8Kfz8+LtQqxdX99E
         U9JC0ZstQrPGvahqbtM61E7xpDN79w48fkW7if2xCQ0ObfHZnU4RimHHLqLVSjExGq
         J1ta3+FMDkBK7Y80bcqW5f7OJuZyn2E2uCwFYbn8vwnaUqaW1iZ2MK7uO9nyc4De8R
         V9zKT+azQeKqRyWVEL5IEdVS0frhuR7XvnlvfWARjzvUkAmOs1BHXVPqIA0UVRL9sc
         sLgENxteOH48Q==
Received: by mail-lf1-f46.google.com with SMTP id q21so12247568lfo.0;
        Thu, 08 Sep 2022 01:21:01 -0700 (PDT)
X-Gm-Message-State: ACgBeo3BR0ABJEmP3N7Kfbfk66qDdm/WEp8W/O8qhpAcot3AHHPJGIPn
        YDMkAzODaTSbGfzXuTTN8g52Ndx6T4311ysyfnU=
X-Google-Smtp-Source: AA6agR6dVHNrG/c/DlIxGmDXzttHjB7dvERz4OoFS1ZmwhxbUMB6F4NaUD6zTLgJ+iw33LlIWsyPAIONcZdrrPXC6Rg=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr2222287lfb.583.1662625259228; Thu, 08
 Sep 2022 01:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com> <20220907164606.65742-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220907164606.65742-9-andriy.shevchenko@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 8 Sep 2022 10:20:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFLgo2fC80Z6zKUC8ULyLrFJ7XOvzwE5tYYLtzDhqqHOw@mail.gmail.com>
Message-ID: <CAMj1kXFLgo2fC80Z6zKUC8ULyLrFJ7XOvzwE5tYYLtzDhqqHOw@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] efi/dev-path-parser: Refactor _UID handling to use acpi_dev_uid_to_integer()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 7 Sept 2022 at 18:57, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
> an integer. Use it instead of custom approach.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/firmware/efi/dev-path-parser.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
> index eb9c65f97841..113b3ca1bd76 100644
> --- a/drivers/firmware/efi/dev-path-parser.c
> +++ b/drivers/firmware/efi/dev-path-parser.c
> @@ -15,9 +15,11 @@
>  static long __init parse_acpi_path(const struct efi_dev_path *node,
>                                    struct device *parent, struct device **child)
>  {
> -       char hid[ACPI_ID_LEN], uid[11]; /* UINT_MAX + null byte */
>         struct acpi_device *adev;
>         struct device *phys_dev;
> +       char hid[ACPI_ID_LEN];
> +       long ret;
> +       u64 uid;
>
>         if (node->header.length != 12)
>                 return -EINVAL;
> @@ -27,12 +29,12 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
>                 'A' + ((node->acpi.hid >>  5) & 0x1f) - 1,
>                 'A' + ((node->acpi.hid >>  0) & 0x1f) - 1,
>                         node->acpi.hid >> 16);
> -       sprintf(uid, "%u", node->acpi.uid);
>
>         for_each_acpi_dev_match(adev, hid, NULL, -1) {
> -               if (adev->pnp.unique_id && !strcmp(adev->pnp.unique_id, uid))
> +               ret = acpi_dev_uid_to_integer(adev, &uid);
> +               if (ret == -ENODATA && node->acpi.uid == 0)
>                         break;
> -               if (!adev->pnp.unique_id && node->acpi.uid == 0)
> +               if (ret == 0 && node->acpi.uid == uid)

Is it necessary to reorder the conditions here? I.e., why not

> +               ret = acpi_dev_uid_to_integer(adev, &uid);
> +               if (ret == 0 && node->acpi.uid == uid)
>                         break;
> +               if (ret == -ENODATA && node->acpi.uid == 0)
>                         break;

?

With that fixed,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
