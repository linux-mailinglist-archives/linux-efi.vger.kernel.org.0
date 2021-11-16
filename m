Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0845300F
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhKPLSN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhKPLSM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:18:12 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB4CC061570;
        Tue, 16 Nov 2021 03:15:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so86146456edv.1;
        Tue, 16 Nov 2021 03:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkZFfA/8Vo4M0ATDzw+B35VKugfG9PCfqQsRbw+b6m8=;
        b=jkqAK+JWVRn0w98KUq4NkzuLOABLt13n2JddFDdfexLVRqk24e8ggwzZmgTSbStRDq
         AePz4HzzzV0cRzTNCrSauuoYofJBP3lXrWh8p/hFr6ZE3lTqMkHM3Rt+J427zpxN20hr
         jERRniF5YClvb4xEYspUlBIvF1DcbW93OYfwcF1FlQ8nD1GUo3L5bIUk0Q1SbUsaKirm
         muqN7di+IRkDe2Vct+r2jPU+9NoP3jzKLUNheI7wzpa5qEJ++8HVbESLX7u7fSJM/LsR
         BnOdBt33BM+bVTrQr3vljns3+wEQAqclIrhoWLcCPjxHl/0EZeudmvQ7XN3D5Vrc9aiU
         ZrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkZFfA/8Vo4M0ATDzw+B35VKugfG9PCfqQsRbw+b6m8=;
        b=BsVCOrIFzEujyBpURgo/R1ZLTou8PqHBQB60+nKLg4swerHEeVjw43Khakn5fjc6wV
         LkFY8oGwtGuVllS/Mugxeh2moEHEfPL/xqpzH4Ts57UXDtQ6u3y+a/5sqB9J5ElqhYCI
         tp+KmTCZSt6R5umdExRz9Ox7Y629lUoWLHkuEQWLnO8aAzBKEYKs9E6DoM5YYo3Jji8w
         3zaV3xxdFW6j6kGyV5d+0Mc+vBJlqxI+xfGRcslZnoafJDaWOBXPuQlJS/bsj6a2Kbub
         TgQKkBOie1hEFxyEdcjjz6pAtaPwjPtp9k/IqEg41seqv364UdKsMSPRlXLIvUuCHtns
         K7TA==
X-Gm-Message-State: AOAM531SyKrvrhozPP5atQ0W9wOoi2Xwq1CbUk39EFBREGmlyGOFWpFk
        LgwZU0J23FrHXvyPvpQKTyaf7V0DGbvMi7anKJI=
X-Google-Smtp-Source: ABdhPJyR1qdyGemqIcMe5rTUUfxMj/78+fSI+6fmvXklXbXjaoZR9lzQxYaVws2FlPkpWYrUaezzg7U4nuaoAyh26+0=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr8640653ejb.377.1637061314258;
 Tue, 16 Nov 2021 03:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20211114170335.66994-1-hdegoede@redhat.com> <20211114170335.66994-14-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-14-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 13:14:33 +0200
Message-ID: <CAHp75VceeV634BPm4X8vgKCFG7CFSnApPrB-uxG8-F+hgXXMvA@mail.gmail.com>
Subject: Re: [PATCH v2 13/20] power: supply: bq25890: Support higher charging
 voltages through Pump Express+ protocol
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
> From: Yauhen Kharuzhy <jekhor@gmail.com>
>
> Add a "linux,pump-express-vbus-max" property which indicates if the Pump
> Express+ protocol should be used to increase the charging protocol.
>
> If this new property is set and a DCP charger is detected then request
> a higher charging voltage through the Pump Express+ protocol.
>
> So far this new property is only used on X86/ACPI (non devicetree) devs,
> IOW it is not used in actual devicetree files. The devicetree-bindings
> maintainers have requested properties like these to not be added to the
> devicetree-bindings, so the new property is deliberately not added
> to the existing devicetree-bindings.
>
> Changes by Hans de Goede:
> - Port to my bq25890 patch-series + various cleanups
> - Make behavior configurable through a new "linux,pump-express-vbus-max"
>   device-property
> - Sleep 1 second before re-checking the Vbus voltage after requesting
>   it to be raised, to ensure that the ADC has time to sampled the new Vbus
> - Add VBUSV bq25890_tables[] entry and use it in bq25890_get_vbus_voltage()
> - Tweak commit message

...

> +#define PUMP_EXPRESS_START_DELAY       (5 * HZ)
> +#define PUMP_EXPRESS_MAX_TRIES         6
> +#define PUMP_EXPRESS_VBUS_MARGIN       1000000

Units? Perhaps "_uV"?

...

> +               dev_dbg(bq->dev, "input voltage = %d mV\n", voltage);

Just to be sure, is it indeed "mV" and not "uV"?

...

> +               while (bq25890_field_read(bq, F_PUMPX_UP) == 1)
> +                       msleep(100);

Infinite loop?

Sounds like a good candidate to switch to read_poll_timeout() // note
it accepts any type of (op) with a variadic number of args.

...

> +error:

error_print: ?

> +       dev_err(bq->dev, "Failed to request hi-voltage charging\n");

...

> +       ret = device_property_read_u32(bq->dev, "linux,pump-express-vbus-max",
> +                                      &bq->pump_express_vbus_max);
> +       if (ret < 0)
> +               bq->pump_express_vbus_max = 0;

Isn't it 0 by default?

Anyway, for all optional properties one may use

bq->...property... = $default;
device_property_read_u32(bq->dev, "linux,...property...", &bq->...property...);

I.e. no conditional needed.

-- 
With Best Regards,
Andy Shevchenko
