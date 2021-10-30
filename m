Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942DC440C16
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 00:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhJ3WRI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 18:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJ3WRH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 18:17:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088D4C061570;
        Sat, 30 Oct 2021 15:14:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ee16so37889152edb.10;
        Sat, 30 Oct 2021 15:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZW96vbK8Teu6OjvSzaXi6oYccLSbo4NeNB+PnxDYjs=;
        b=DHOAo1ppJJP8d81/gQ3MXN4x6pffoigju7/27smlLAyMH7XC+hnC6Es2UGVZFkyKp0
         BWh1ANbfYlGei6kjYwjBWNqA6IXv4+hWNVInl3YtUerR95UgdEl7Lcgb11XwQsfSqixr
         wR9AcZF2uBqAFvTtAJ6u6R/kxebeS49Ln32Usig5kPmyNyW0fyS2n7s48I2y/rK+2Sjb
         vnyLBPJW1u7nVgsNw1gCAxcPNefDhZbh5yB/ZkC0wMf1ERDaMkg05ZaVtRsJRY4nxfpz
         JxQ1vQknx4gnmQePosJtL1cWaCRqk8s3ZQHaIzj6+UO7A9dHBmk0lPDN1TJBdEVPudbS
         gIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZW96vbK8Teu6OjvSzaXi6oYccLSbo4NeNB+PnxDYjs=;
        b=bzFBU+Qhj0Z5eNibEh6LHprMWXMFOSwITzd0ZHZXTWf4ZWx0k3QpymP119bl99M61v
         TawgNd9LSo6yeuTDRm9KmqSBGEmluPJL0w0AzQVeS36C85eqyuL1iiLJyB882WFFwDIo
         zRk0GPTSHXyC9tu9VDoebVIPgglOWpdlEpzGpt6r2AHv9J4dziWPUPTEt4gFL/5zTGA+
         gX7NSLDlRd97YQIh1fyGY2V+tp/OknGGr9sUkRyI+6Tr6y4Dyh2mNAqD6IOs5VFGgytb
         s3hd2mUeIRAt2hJOlohD/hVKTQKqr9WdtqZZipwJFLeJp+CMOFmE/kynL/e72tDgTz+Z
         vMaw==
X-Gm-Message-State: AOAM531rS/Rn/CcOFgXQaegqL5OdjGzyJV04HhyUwEuGz62zLLRjoncH
        rhMvtvmTQ4R/xUnaJCuQlmmheWoSQngPwHa4xFQ=
X-Google-Smtp-Source: ABdhPJx3A7gXmeumq/rnSnxMOHcO0tGHTrpMnAPU7K+xilax92WAeU73erjyBal2eFFy7rg4hXkZP3JHvPJLjNss3Og=
X-Received: by 2002:a17:907:1c9e:: with SMTP id nb30mr24504525ejc.141.1635632075516;
 Sat, 30 Oct 2021 15:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211030182813.116672-1-hdegoede@redhat.com> <20211030182813.116672-11-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-11-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 01:13:59 +0300
Message-ID: <CAHp75Vc=dZ1FPeDgaY8S+dSu8i=QUgbLN2NVOcsMz6h0uytNeg@mail.gmail.com>
Subject: Re: [PATCH 10/13] power: supply: bq25890: Add support for registering
 the Vbus boost converter as a regulator
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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

On Sat, Oct 30, 2021 at 9:28 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The bq25890_charger code supports enabling/disabling the boost converter
> based on usb-phy notifications. But the usb-phy framework is not used on
> all boards/platforms. At support for registering the Vbus boost converter
> as a standard regulator when there is no usb-phy on the board.
>
> Also add support for providing regulator_init_data through platform_data
> for use on boards where device-tree is not used and the platform code must
> thus provide the regulator_init_data.

...

> @@ -1018,6 +1059,21 @@ static int bq25890_probe(struct i2c_client *client,
>                 INIT_WORK(&bq->usb_work, bq25890_usb_work);
>                 bq->usb_nb.notifier_call = bq25890_usb_notifier;
>                 usb_register_notifier(bq->usb_phy, &bq->usb_nb);
> +#ifdef CONFIG_REGULATOR
> +       } else {
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
> +#endif
>         }

}
#ifdef
else {
  ...
}
#endif

is a bit better to maintain (less error prone in case of new code).

...

> +#ifndef _BQ25890_CHARGER_H_
> +#define _BQ25890_CHARGER_H_

> +#include <linux/regulator/machine.h>

struct regulator_init_data;

should be sufficient, no header is needed.

> +struct bq25890_platform_data {
> +       const struct regulator_init_data *regulator_init_data;
> +};
> +
> +#endif

-- 
With Best Regards,
Andy Shevchenko
