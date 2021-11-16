Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690254530B6
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhKPLc4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbhKPLcb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:32:31 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2396C061570;
        Tue, 16 Nov 2021 03:29:33 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so22612013edb.8;
        Tue, 16 Nov 2021 03:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmE5I+KwN9wX/3DI+6oAR1as1MTfdlvqvq7gy6oaBLw=;
        b=SMlhMM1pNbxAB1nu2cCyGH/LuM8ogF4FG0KvbeYoYZtw9HP3tp4vTmdss7+cN3o8zf
         WMHzFTd8k4E0aXJf6qaXoZa4qNQn2LCHzLkx2VkEyn5O6mGc8xwK9HNjvdcgGBZIkvIY
         i9ll/nEFIKMzg/MZQWv/hs6d6zplgo6eAIpr1H/PhIUmmuSPYRslGW7GWVQu7y43H9UO
         DhLuPQWIGgWLilpdysSUIQ9qu88mOdsU/qE+D935KScIy0yHJk5mGOnp0dj4s+D+Mgy7
         Wxpx0y0zINoZ0Vhgl3Q/0U+fbzgs9lk7ilIucLXEJ9+EqVye+m6JWWuEjldIWXIWrYol
         ElPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmE5I+KwN9wX/3DI+6oAR1as1MTfdlvqvq7gy6oaBLw=;
        b=NP+a1gAqn+DaxI1E+G5EyTL4g0gV6PKEFNFRed3b1T0C1psRFjXz2vBW8Hc5gySZpk
         KbVoxVBqzLrM6kInH1tN/SYKqeQwURD7nCVknaCKAhWbGb0DLcEia8Jvsxo2MqSfxo0t
         gq9iubKmVTpQwzAZ5VN0kdVqlqwU8/PGI+eilUjdpWGGarNEYu01pqOxPl4Ju1BXUFjB
         ltqBSF0ZqZPLfW+tYR53A4R6y+fZl4r+TzywkgQv1aAiJLR1rrSGQFLvYAlhBhsuBocL
         4eh3/3aza8Pt526HGkrzsCW0apfJB9ay9N5SgCegGXUZa20AvNfeGJV5qZ1AhbcJK/Cz
         anLg==
X-Gm-Message-State: AOAM531g5UDGOJztu2r3q30+9xmy0K81qxia5Sf1ltM1XFlmb5bjcWlz
        AadADppbzD+gAY3gXlVi1gCT5DGk0YTR7xiT9/vWyyzE7IH6yA==
X-Google-Smtp-Source: ABdhPJxAn5qrLYWqOD8UPTRedV2AQCbwEPm4K81wyq0r1N3LJLLy2Xx52b3zNNu3oO4Xmo0O2+MJa3+vAOZJ2uKpYZM=
X-Received: by 2002:a50:fd16:: with SMTP id i22mr9250032eds.224.1637062172295;
 Tue, 16 Nov 2021 03:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20211114170335.66994-1-hdegoede@redhat.com> <20211114170335.66994-18-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-18-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 13:28:51 +0200
Message-ID: <CAHp75VdXSdhNtPwNdpssnmt+sZb+ZoAUm-cKJu-PqymmHMOpRw@mail.gmail.com>
Subject: Re: [PATCH v2 17/20] extcon: intel-cht-wc: Support devs with Micro-B
 / USB-2 only Type-C connectors
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
> So far the extcon-intel-cht-wc code has only been tested on devices with
> a Type-C connector with USB-PD, USB3 (superspeed) and DP-altmode support
> through a FUSB302 Type-C controller.
>
> Some devices with the intel-cht-wc PMIC however come with an USB-micro-B
> connector, or an USB-2 only Type-C connector without USB-PD.
>
> Which device-model we are running on can be identified with the new
> intel_cht_wc_get_model() helper and on models without a Type-C controller
> the extcon code must control the Vbus 5V boost converter and the USB role
> switch depending on the detected cable-type.

...

>  config EXTCON_INTEL_CHT_WC
>         tristate "Intel Cherrytrail Whiskey Cove PMIC extcon driver"
> -       depends on INTEL_SOC_PMIC_CHTWC

> +       depends on INTEL_SOC_PMIC_CHTWC && USB_SUPPORT

Having these two in one expression sounds a bit alogical to me, can
you just add a separate "depends on"?

> +       select USB_ROLE_SWITCH

...

> +       if (ext->vbus_boost && ext->vbus_boost_enabled != enable) {
> +               if (enable)
> +                       ret = regulator_enable(ext->vbus_boost);
> +               else
> +                       ret = regulator_disable(ext->vbus_boost);

Redundant blank line here (but it's up to you)

> +               if (ret == 0)
> +                       ext->vbus_boost_enabled = enable;
> +               else
> +                       dev_err(ext->dev, "Error updating Vbus boost regulator: %d\n", ret);

Why not a traditional pattern, i.e. error handling first?

> +       }

...

> +/* Some boards require controlling the role-sw and vbus based on the id-pin */

Vbus ? VBUS? Here and there the inconsistency of some terms...

...

> +       ext->vbus_boost = devm_regulator_get_optional(ext->dev, "vbus");
> +       if (IS_ERR(ext->vbus_boost)) {
> +               ret = PTR_ERR(ext->vbus_boost);
> +               if (ret == -ENODEV)
> +                       ret = -EPROBE_DEFER;
> +
> +               return dev_err_probe(ext->dev, ret, "getting vbus regulator");

Can be also written as

    if (PTR_ERR(ext->vbus_boost) == -ENODEV ||
PTR_ERR(ext->vbus_boost) == -EPROBE_DEFER)
        return dev_err_probe(ext->dev, -EPROBE_DEFER, "getting vbus regulator");

    return PTR_ERR(ext->vbus_boost);

but up to you.

> +       }

-- 
With Best Regards,
Andy Shevchenko
