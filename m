Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80806452FDB
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhKPLJo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbhKPLJQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:09:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594D8C061766;
        Tue, 16 Nov 2021 03:06:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id e3so49616303edu.4;
        Tue, 16 Nov 2021 03:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnCgHIIU7S6lgl53GeRYXIkPs0wK3gPDE9N5/GaJOxI=;
        b=UTE64Al//jFH0wp6HU98EPGUxyxydBFUlZ8hIMm6lcPbcD2gQZDrZWpHZMb/X82qWl
         FqNpDvg01n3z3wYANU0ZEAoVfoKdYr/YRXVdEmrEEk2ct+iiRa7w2JQAtsIZYrIm6hL8
         zVGdtHbN0gLYJ/2eCjAZgQDLBmq/EGJeVoUefIPoJs4VVps62te321gOQro5FfVVGXIW
         ryHxTbvx9384Gp0LZ5tjD/EGeFODE2ePeWJ+7VuTGP9HOOooRiSvie+z2pLWJKOUmOmg
         kXxgTrav+anqEU4N0iccN40KdBFLfXutZEeyfxuZ1pAwevULVdkic376xGhn8S/MBIYQ
         9EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnCgHIIU7S6lgl53GeRYXIkPs0wK3gPDE9N5/GaJOxI=;
        b=lb5+nkg1OgGIELNZ2WPBszOtsGPkAyMvPCKoFwav+hO3Fq75SD6BAhdUenC7F1BOER
         O9uElNO8SxUV0qOu4a/u6H1R10ZoAvHKxA0Y7s012als44nREMmS4NyukhbdMO1ZrlkS
         LZoXs3SsiBJHPcz4+ic+dvVOAQpgeI4jdxfCN/0ct9OUUppzR+dTL171IaqNzIguIzXZ
         J2tWxVYLZF+OHGgx2FpWIPaWyTN3EKoBRxfJWj+B7Fvudw8dDWbgGgdadnARMlpBrd1l
         4e5oKtbLOmKC3zS9NECeya1iN6IB+az94c43AVKBmHmvM7A6tB3KoeVdz/T8ZqjtpRQR
         s+UA==
X-Gm-Message-State: AOAM531zPcZxrwd2gD2nV7lWHgGYLYGl4usxoL6clNyT8HN0t/vb3YJ3
        TyAYDR5zYAELB6C1EhrqQHoPbwX6yFV+CENaq/E=
X-Google-Smtp-Source: ABdhPJz7/QGp0U62o+gSjHo/sv/mXAGLAinjrpKMJAdSDaV43g7EeE+oB5T0lS+OQaK4wvi3DyQ5RfaDhgBhCdwjoSc=
X-Received: by 2002:a50:fb09:: with SMTP id d9mr8672034edq.283.1637060777875;
 Tue, 16 Nov 2021 03:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20211114170335.66994-1-hdegoede@redhat.com> <20211114170335.66994-12-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-12-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 13:05:36 +0200
Message-ID: <CAHp75VciJJvJ95cNDCUKPxCzfTa=+SfN7qoH2wvXjgweauT8ow@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] power: supply: bq25890: Add support for
 registering the Vbus boost converter as a regulator
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Nov 14, 2021 at 7:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The bq25890_charger code supports enabling/disabling the boost converter
> based on usb-phy notifications. But the usb-phy framework is not used on
> all boards/platforms. At support for registering the Vbus boost converter
> as a standard regulator when there is no usb-phy on the board.
>
> Also add support for providing regulator_init_data through platform_data
> for use on boards where device-tree is not used and the platform code must
> thus provide the regulator_init_data.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

One remark below.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - When the usb-phy framework is not used, turn off the Vboost regulator
>   on shutdown
> - Some minor code-tweaks based on Andy's review
> ---
>  drivers/power/supply/bq25890_charger.c | 80 ++++++++++++++++++++++++++
>  include/linux/power/bq25890_charger.h  | 15 +++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 include/linux/power/bq25890_charger.h
>
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 3c41fe86b3d3..e06ca7b0eb3e 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -8,7 +8,9 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/power_supply.h>
> +#include <linux/power/bq25890_charger.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
>  #include <linux/types.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
> @@ -845,6 +847,45 @@ static int bq25890_usb_notifier(struct notifier_block *nb, unsigned long val,
>         return NOTIFY_OK;
>  }
>
> +#ifdef CONFIG_REGULATOR
> +static int bq25890_vbus_enable(struct regulator_dev *rdev)
> +{
> +       struct bq25890_device *bq = rdev_get_drvdata(rdev);
> +
> +       return bq25890_set_otg_cfg(bq, 1);
> +}
> +
> +static int bq25890_vbus_disable(struct regulator_dev *rdev)
> +{
> +       struct bq25890_device *bq = rdev_get_drvdata(rdev);
> +
> +       return bq25890_set_otg_cfg(bq, 0);
> +}
> +
> +static int bq25890_vbus_is_enabled(struct regulator_dev *rdev)
> +{
> +       struct bq25890_device *bq = rdev_get_drvdata(rdev);
> +
> +       return bq25890_field_read(bq, F_OTG_CFG);
> +}
> +
> +static const struct regulator_ops bq25890_vbus_ops = {
> +       .enable = bq25890_vbus_enable,
> +       .disable = bq25890_vbus_disable,
> +       .is_enabled = bq25890_vbus_is_enabled,
> +};
> +
> +static const struct regulator_desc bq25890_vbus_desc = {
> +       .name = "usb_otg_vbus",
> +       .of_match = "usb-otg-vbus",
> +       .type = REGULATOR_VOLTAGE,
> +       .owner = THIS_MODULE,
> +       .ops = &bq25890_vbus_ops,
> +       .fixed_uV = 5000000,
> +       .n_voltages = 1,
> +};
> +#endif
> +
>  static int bq25890_get_chip_version(struct bq25890_device *bq)
>  {
>         int id, rev;
> @@ -1044,6 +1085,22 @@ static int bq25890_probe(struct i2c_client *client,
>                 bq->usb_nb.notifier_call = bq25890_usb_notifier;
>                 usb_register_notifier(bq->usb_phy, &bq->usb_nb);
>         }
> +#ifdef CONFIG_REGULATOR
> +       else {
> +               struct bq25890_platform_data *pdata = dev_get_platdata(dev);
> +               struct regulator_config cfg = { };
> +               struct regulator_dev *reg;
> +
> +               cfg.dev = dev;
> +               cfg.driver_data = bq;
> +               if (pdata)
> +                       cfg.init_data = pdata->regulator_init_data;
> +
> +               reg = devm_regulator_register(dev, &bq25890_vbus_desc, &cfg);
> +               if (IS_ERR(reg))
> +                       return dev_err_probe(dev, PTR_ERR(reg), "registering regulator");
> +       }
> +#endif

I just realized that you may use even

} else {
#ifdef
...
#endif
}

w/o any compiler warning or so. But it's up to you.

>         ret = bq25890_power_supply_init(bq);
>         if (ret < 0) {
> @@ -1082,6 +1139,28 @@ static int bq25890_remove(struct i2c_client *client)
>         return 0;
>  }
>
> +static void bq25890_shutdown(struct i2c_client *client)
> +{
> +       struct bq25890_device *bq = i2c_get_clientdata(client);
> +
> +       /*
> +        * TODO this if + return should probably be removed, but that would
> +        * introduce a function change for boards using the usb-phy framework.
> +        * This needs to be tested on such a board before making this change.
> +        */
> +       if (!IS_ERR_OR_NULL(bq->usb_phy))
> +               return;
> +
> +       /*
> +        * Turn off the 5v Boost regulator which outputs Vbus to the device's
> +        * Micro-USB or Type-C USB port. Leaving this on drains power and
> +        * this avoids the PMIC on some device-models seeing this as Vbus
> +        * getting inserted after shutdown, causing the device to immediately
> +        * power-up again.
> +        */
> +       bq25890_set_otg_cfg(bq, 0);
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int bq25890_suspend(struct device *dev)
>  {
> @@ -1161,6 +1240,7 @@ static struct i2c_driver bq25890_driver = {
>         },
>         .probe = bq25890_probe,
>         .remove = bq25890_remove,
> +       .shutdown = bq25890_shutdown,
>         .id_table = bq25890_i2c_ids,
>  };
>  module_i2c_driver(bq25890_driver);
> diff --git a/include/linux/power/bq25890_charger.h b/include/linux/power/bq25890_charger.h
> new file mode 100644
> index 000000000000..c706ddb77a08
> --- /dev/null
> +++ b/include/linux/power/bq25890_charger.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Platform data for the TI bq25890 battery charger driver.
> + */
> +
> +#ifndef _BQ25890_CHARGER_H_
> +#define _BQ25890_CHARGER_H_
> +
> +struct regulator_init_data;
> +
> +struct bq25890_platform_data {
> +       const struct regulator_init_data *regulator_init_data;
> +};
> +
> +#endif
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
