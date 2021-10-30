Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97219440BFD
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhJ3WAI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 18:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJ3WAI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 18:00:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6CC061570;
        Sat, 30 Oct 2021 14:57:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h7so51407751ede.8;
        Sat, 30 Oct 2021 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShCdtHGtTJX3k7s3o60+cmi18j6hz5z0Vi8NYUkIn24=;
        b=eLQCPdP9OFb/rD9LSPbbiZEZ6TlLA0crMUHK/pdacd7cKTwOhnwpGMMDx1/UEto3CS
         ykdlyeGtEqye76FGX15ie+KnBVXoFkOV221xzOGK3DjDlv9HvYNyIClwt5BVa76lTtve
         vLIsZd0yMgWLKh7AjT7duZxrP26N0qColaMHO0oLbcsBrw+X43KJ5r/cmwZFk5v61yOU
         B0RJUF5kxvUuVHHcrvkT7qIo6yZ/1mSWsEzUU5aAZBv5W/LlkG1voLQdQ4Pl0iq2xS8r
         +M/hjrgXW/mCkTKIvPg7AzjK/Fnf0061C7ISadeox7KmKfHenHNA2AhJLsvusSnz9Xae
         3GeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShCdtHGtTJX3k7s3o60+cmi18j6hz5z0Vi8NYUkIn24=;
        b=ofa/hJE58WjFMl9WxCy2rWBl/IVaDbOslKd+g2i5h+pjsT9Wr+MGluuPn3F2vzb67Q
         yw4ex+VNyTFmX8I66h0BZRB5udTa7nEXRPf43o0mhdierDyj4GJFn+M0/KNOpMZ6ck5j
         kcs0UtoHotsLMNNYm73avZK4W7aTxPQ6hUg1s1mvluGUEeGnNoiwH5XmmzSCrGvR+xJV
         u/nKKIgg+PBypr3e0n1uvP/S29/LQP1VRX0VBT4UvMTqMOGsgdX52Vv8uwuwFq5D8vT9
         I3ZvytE04l1nzgBmhlvuCG3vWtZueqDYpzAhC0AAVYEPurGi8YMI7qhu7wbUisR4gfMG
         9Gpg==
X-Gm-Message-State: AOAM530jkFJkGxvJm16BQaj9bWOHtzs0wOA14TKyc3OjpVQalbidYnHI
        Z2rnDqDWKdHlF1DHfFcYPZhMkJnbNvPyJM5F8JE=
X-Google-Smtp-Source: ABdhPJyFTQHQQVOr3Kd+bpxO4x1Eaxp00pzw/JjszZMHBg9c62WLJ9oDApdRNoEWgGI0qrNxL7G9GWdz1WP8joJYKdg=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr24286203ejc.69.1635631055885;
 Sat, 30 Oct 2021 14:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211030182813.116672-1-hdegoede@redhat.com> <20211030182813.116672-3-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-3-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 00:56:59 +0300
Message-ID: <CAHp75VeXJauH1YQZxYvRWucDwsP_RF5T5yiwpMcB-r4O60ZPJQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] platform/x86: dmi_device_properties: Add setup info
 for boards with a CHT Whiskey Cove PMIC
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
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 30, 2021 at 9:28 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add a new "intel,cht-wc-setup" string property to the "INT34D3:00"
> i2c_client for the Whiskey Cove PMIC found on several Cherry Trail
> based devices. At least 3 setups are known:
>
> 1. The WC PMIC is connected to a TI BQ24292i charger, paired with
>    a Maxim MAX17047 fuelgauge + a FUSB302 USB Type-C Controller +
>    a PI3USB30532 USB switch, for a fully functional Type-C port
>
> 2. The WC PMIC is connected to a TI BQ25890 charger, paired with
>    a TI BQ27520 fuelgauge, for a USB-2 only Type-C port without PD
>
> 3. The WC PMIC is connected to a TI BQ25890 charger, paired with
>    a TI BQ27542 fuelgauge, for a micro-USB port
>
> Which setup is in use cannot be determined reliably from the ACPI tables
> and various drivers (extcon-intel-cht-wc.c, i2c-cht-wc.c, ...) need
> to know which setup they are dealing with.

If it's internal property only, I would rather expect it to start with
'linux,' as DWC3 does. And it's also USB related.

...

> +       PROPERTY_ENTRY_STRING("intel,cht-wc-setup", "bq24292i,max17047,fusb302,pi3usb30532"),

> +       PROPERTY_ENTRY_STRING("intel,cht-wc-setup", "bq25890,bq27520"),

 Besides that I'm not sure about the name of the property, maybe
'linux,cht-wc-usb-chips' or alike? And since it's a list, can we make
it a string array?

-- 
With Best Regards,
Andy Shevchenko
