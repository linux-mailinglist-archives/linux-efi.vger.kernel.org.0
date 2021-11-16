Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024A4453597
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbhKPPWs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 10:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbhKPPWr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 10:22:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B442C061570;
        Tue, 16 Nov 2021 07:19:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so89618060edd.10;
        Tue, 16 Nov 2021 07:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmBWvXQj8znoaNlP/XJEaiijvOo6PBGp1wWsFw5sd+Y=;
        b=dHKt+qxBxbb/Rv6TLuF27ll6/vi/79PRdmfilrqAAdoy78Zib/N8o3KpEJvaZLBza1
         8Cpdi36wDvKg9pqXXhjVliG4WJfPYlEkTw7qx8Tqv/KYAZay8Thq5fj+XPcVC2zNTY3O
         LsAs1JuSfg5m8eNCCVi78V0i4Y4+O1D7AE2511ss6/JwumN4jOPAG7nNT/EQOH4TgCyQ
         xLW7K1XNkDmNAtwRuIGRn/0G9uTYVB8m6aGRcQbyX5pqMAfAFnbMzNKqO9ovd8Ks64aU
         JLC9LugV7CO8n/7+gnbPknr9e4qhN1F7pAeBElMxhGy1hdtRdSB9S0N295uvkBesTq0O
         BP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmBWvXQj8znoaNlP/XJEaiijvOo6PBGp1wWsFw5sd+Y=;
        b=uFHXRgOq2NCRGW9PQ53EMFq0m5fPtape47SPPn+HkSSQusViBTwIxVNQ6UTZgE55u1
         TI3hvV1nprf9xTPFPRscDEmXEDJsYLXLvVFAfVqdiJan2H/ZRb7pUd5E6AYyhpwR5KD4
         wr2huv+a7eGKmPIj+fzKjdo/DCSMu/E+BMXZBlLrR0StyN/0l8ds+XWvIl7PubVvFmGC
         6nAGtaqhVoMPgbqT7ZnLww6BxstKK6nS48tYEHCGgE0BB3fdhfcohVIAAV8tANHBMQSp
         mgAC6akBgcOgGH23uFu/XoCsohCKukxrHwzWXgazlR9MqmTR2dOcQLRaYjeCgq3cvIKD
         D5aw==
X-Gm-Message-State: AOAM533xnscUr8lD27ULjTb04vUbtd+3wj6KM91casoa1oE4q6xLDL+u
        FApCkNwdqLktORNOMKQzr5i4QVm5s0ykpIABjfmzx0ojJT4=
X-Google-Smtp-Source: ABdhPJxyPvxtL5u41BdFRCmpus5JQskyeQT/k/mvLjEvqbLp9EodkDIsgxUvTRaAyeaG4TXjaUVO/qDhhLGfrls95CU=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr10768857ejb.69.1637075988577;
 Tue, 16 Nov 2021 07:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20211114170335.66994-1-hdegoede@redhat.com> <20211114170335.66994-20-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-20-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 17:19:07 +0200
Message-ID: <CAHp75Vd2ytGkaSDZXuKNLihsK5JYrFv5ezkTAd73o2xFjoNDHQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/20] extcon: intel-cht-wc: Add support for
 registering a power_supply class-device
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

On Sun, Nov 14, 2021 at 7:05 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The bq25890 used on the Yogabook YB1-X90 / -X91 models relies on
> the extcon-driver's BC-1.2 charger detection, and the bq25890 driver
> expect this info to be  available through a parent power_supply
> class-device which models the detected charger (idem to how the Type-C
> TCPM code registers a power_supply classdev for the connected charger).
>
> Add support for registering the power_supply class-device expected
> by this setup.

...

> +       struct cht_wc_extcon_data *ext = power_supply_get_drvdata(psy);

> +       int ret = 0;

Not needed.

> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_USB_TYPE:
> +               val->intval = ext->usb_type;
> +               break;
> +       case POWER_SUPPLY_PROP_ONLINE:
> +               val->intval = ext->usb_type ? 1 : 0;
> +               break;
> +       default:

> +               ret = -EINVAL;
> +               break;

return -EINVAL;

> +       }
> +
> +       return ret;

return 0;

> +}

P.S. And here you have a "break", which is nice!

-- 
With Best Regards,
Andy Shevchenko
