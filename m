Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7386F45304B
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhKPLYv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbhKPLYY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:24:24 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95943C061208;
        Tue, 16 Nov 2021 03:21:13 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so86215408edv.1;
        Tue, 16 Nov 2021 03:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGUzW8oU278JfYrY7N9IF7tN1n/tXliVYmfQC61IxV8=;
        b=JQVvA1qWRgODHDOSLlagiGOfAXEHF7KxMNWe7LPWtqGmLHJiWZqhx7wzACas6AONv+
         CAkZ1x83Da19F69Y4szYWBOdQL+g/VUfY93OJyeul01/oezFSOQ6LE5gLKIoAmzWjqbQ
         hVScUsbwSOsewMQo+Ag4kVJC8jfz6QxeZbLCzCSqcLtwPFrJf7bcJ3pZZKe4qA20MqHi
         sRiCruhHwvVNi6VRP7p2jZuDMhj8I8FstuiDEoUUygeq5GN/qbWOoXGHoSCEEMM6U0bb
         /ZL166tglWsxqa7Wt+md18G3lU0bd8L1nY6Qttagny+96fQKAONUvcRdlWPzyCXM2Xyr
         NBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGUzW8oU278JfYrY7N9IF7tN1n/tXliVYmfQC61IxV8=;
        b=vqoPQ6a212+uBfrUqbXvhvSTWALBagVy4Q0UZJw0g6iyi/ozzsZYygG8uAL7q2dLLF
         mONP0E0ftmieg0nfzaH29MtNGSUh3ENbHkGU3WdxYnt+FMLH5AjmwVms2bd5E8D74n8F
         v2bnWJc3IwPNqwehRJ2wZiFYsUrm5ALowU2SvkhbHYfBY74n1P+m6XXHhLDQ6ZZs89xm
         /LoWTHdCy0Zh9rzwn7/dkLmFboIo4rKx5Xo5RuOHKX4svq4uPh+62MV6+0IZNazXt8op
         VzWlVoRR9Z1PtgrTF7Npu/XPp4fMp7euLhCPq/bW8Str+dExviB8K1zLTRjuSqah3xoA
         o6QA==
X-Gm-Message-State: AOAM530eb7KbT11M4s7n4xwnh37Ba+CZ3ox3uYnF0fo6rO/krRtqN7Uz
        ny2hf3MufVsWBc92I9c7q+vXQc/oXYq4FGOHbI8=
X-Google-Smtp-Source: ABdhPJyKSwdFtfR7TpsDewfi37mChVACwnf+QUTy7V6gWiRnFog2qqdct+xLdwNvdm+Gqux0Kkbtu642mJPn2EzrZQE=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr8693082ejb.377.1637061672128;
 Tue, 16 Nov 2021 03:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20211114170335.66994-1-hdegoede@redhat.com> <20211114170335.66994-16-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-16-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 13:20:31 +0200
Message-ID: <CAHp75VfYGmW6kO18BL39ippuzyzebNXuBn0PkEV8WScB2-bN6A@mail.gmail.com>
Subject: Re: [PATCH v2 15/20] i2c: cht-wc: Make charger i2c-client
 instantiation board/device-model specific
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
> The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
> in that it is always connected to the I2C charger IC of the board on
> which the PMIC is used; and the charger IC is not described in ACPI,
> so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.
>
> So far this was hardcoded to instantiate an i2c-client for the
> bq24292i, with all properties, etc. set to match how this charger
> is used on the GPD win and GPD pcoket devices.

"pocket" I believe?

> There is a rudimentary check to make sure the ACPI tables are at least
> somewhat as expected, but this is far from accurate, leading to
> a wrong i2c-client being instantiated for the charger on some boards.
>
> Switch to the new DMI based intel_cht_wc_get_model() helper which is
> exported by the MFD driver for the CHT Whiskey Cove PMIC to help PMIC
> cell drivers like the i2c-cht-wc code reliably detect which board
> they are running on.
>
> And add board_info for the charger ICs as found on the other 2 known
> boards with a Whisky Cove PMIC.
>
> This has been tested on all 3 known boards.

...

> +/********** Lenovo Yogabook YB1-X90F/-X91F/-X91L charger settings **********/
> +static const char * const lenovo_yb1_bq25892_suppliers[] = {
> +       "cht_wcove_pwrsrc" };

Something went wrong with indentation...

...

> +       /*
> +        * The firmware sets everything to the defaults, which leads to a
> +        * somewhat low charge-current of 2048mA and worse to a batter-voltage

battery?

> +        * of 4.2V instead of 4.35V (when booted without a charger connected).
> +        * Use our own values instead of "linux,read-back-settings" to fix this.
> +        */

...

> +       switch (intel_cht_wc_get_model()) {
> +       case INTEL_CHT_WC_GPD_WIN_POCKET:
> +               board_info = &gpd_win_board_info;
> +               break;
> +       case INTEL_CHT_WC_XIAOMI_MIPAD2:
> +               board_info = &xiaomi_mipad2_board_info;
> +               break;
> +       case INTEL_CHT_WC_LENOVO_YOGABOOK1:
> +               board_info = &lenovo_yogabook1_board_info;
> +               break;
> +       default:
> +               dev_warn(&pdev->dev, "Unknown model, not instantiating charger device\n");

break;

> +       }

-- 
With Best Regards,
Andy Shevchenko
