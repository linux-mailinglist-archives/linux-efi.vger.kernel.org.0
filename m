Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0DB452FC2
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhKPLG5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbhKPLGF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:06:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1E7C061206;
        Tue, 16 Nov 2021 03:03:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w1so19857375edc.6;
        Tue, 16 Nov 2021 03:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VCk/+4OtpvNSsUc9AvuSmwBzqHKr0DmtUweG20smPg=;
        b=cRYdNzxSi+MOy01qo+dZP5foqGG0t0hYZMA5lEar9x2lWw2ijEWgp4H42Ybv6WXCke
         4/bXU1QqxZCtIVTEo3to+OGgeJlvAhm5EuzEk0R0tFJjnd6QZM8KlV+dUke3mLRtCiXZ
         uCtvKOY7Yut8tqudEPVj1vvNVQMeBUkhBjtLtaJl9akY6lzRGC/L+N8HO55vpe3n/JFp
         fj5a66lPevFnIGDihiAzzJuRn8DmeZ9zJDgRrnqu6ErAsn+ybnT8q0Ah0qD+8Lan80yS
         ku3/UmLoguWcoNTFE0JhejqbFnb+akeCuN/u74NBXCjX6g2zmxr0S/unzUxNfXxQ03kD
         6g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VCk/+4OtpvNSsUc9AvuSmwBzqHKr0DmtUweG20smPg=;
        b=UxaALSaT1LTTnBb7jPNMGD8y/SzPsqshtebX1WIuA8S7tHKA3HR0RPdOorvvgSqebA
         jb2up7C4qzF9nUslo+2eIFHN/q99W4+gDkzNuJEK3cOYHV0Ifol35CfPxqnTOwlgvvX5
         Xp2KkBdsIG09FMh96uK4D0a+VxxicsAynsfrLVzm6sLJ4z/n1fSvmGT8riJInI/WCH5n
         GfCoRgSnrecnGu8lNR3GzOf/jOp+Gljn7YFkq28LtjesuzV0CTZIHxFPoGwCFdbFp9X6
         3U+Fv0nyVEVZzwvHq1jSMQXpmQ3VQH6w+00ypcznp8trbPvaiZOPwEak6MACsHjaQFmZ
         X1kg==
X-Gm-Message-State: AOAM533NM4vPYBnIQtadUdS2Sisf3/5zckli2uaCiAlqYo/yyf8zOwyz
        WDcrb0D7SZlXd7pSYrULE+kAB6qUzxCeqDB9UfY=
X-Google-Smtp-Source: ABdhPJwwrplxw2jkBo4qJkPJ5+an40e8hFrzE3p7FIj0dM3gdIpgJvOHdFWjsUPGoR7utqRD3kEiy6MPt+zwu74DiV4=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr8534661ejb.377.1637060586730;
 Tue, 16 Nov 2021 03:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20211114170335.66994-1-hdegoede@redhat.com> <20211114170335.66994-10-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-10-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 13:02:25 +0200
Message-ID: <CAHp75VdoJ3ZT1EhNGM0wDmWrYJu5ndEwRt4mLZVKeP47xwgXWg@mail.gmail.com>
Subject: Re: [PATCH v2 09/20] power: supply: bq25890: Drop dev->platform_data
 == NULL check
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
> Drop the "if (!dev->platform_data)" check, this seems to be an attempt
> for allowing loading the driver on devices without devicetree stemming
> from the initial commit of the driver (with the presumed intention being
> the "return -ENODEV" else branch getting replaced with something else).
>
> With the new "linux,skip-init" and "linux,read-back-settings" properties
> the driver can actually supports devices without devicetree and this
> check no longer makes sense.
>
> While at it also switch to dev_err_probe(), which is already used in

"While at it, also ..."

> various other places in the driver.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index a69a2173e31a..2bdfb58cda75 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -1017,16 +1017,9 @@ static int bq25890_probe(struct i2c_client *client,
>                 return ret;
>         }
>
> -       if (!dev->platform_data) {
> -               ret = bq25890_fw_probe(bq);
> -               if (ret < 0) {
> -                       dev_err(dev, "Cannot read device properties: %d\n",
> -                               ret);
> -                       return ret;
> -               }
> -       } else {
> -               return -ENODEV;
> -       }
> +       ret = bq25890_fw_probe(bq);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "reading device properties\n");
>
>         ret = bq25890_hw_init(bq);
>         if (ret < 0) {
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
