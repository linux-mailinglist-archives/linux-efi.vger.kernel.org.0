Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9849B440C0E
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 00:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhJ3WNO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 18:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJ3WNN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 18:13:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D071DC061570;
        Sat, 30 Oct 2021 15:10:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m17so49621675edc.12;
        Sat, 30 Oct 2021 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Op3eI1JHXwzcqHAY7sxmXFKCkDFAklic1E73M/hLzFE=;
        b=qwrbaCEzsVB+8ini8aiFgRYsWH2zxfMu3mxlq5aXlOTNUQF/JTKC6F9FFC3nA46q6f
         BnTtynveL7MlmwuXCiLrC32VaxfakmvuJA8WJzcAivsBzKB7xvyCB9BCdGKlExklTiDz
         4UinqmctC00yKKHdCd1gTHDyv6f3SyDziyLXLLjbzpKlCqxnFytTefKJtPxhOFGUCU+S
         slnO1cb1fQB4wiP5aJjcvl68GKgDvmn6xjhDzvOXJEAREFNpWgxlaI5HL1it5hTxgHUD
         R+2jAPrzjwJDjW/keDGRv0/tgoOMuaMPuA7HG9lxEFLGnYht1H7Y6JTueBJHEi1gG7fd
         76mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Op3eI1JHXwzcqHAY7sxmXFKCkDFAklic1E73M/hLzFE=;
        b=Dl3jvdv7/JM6/PGink4/jIALIvRzt7PC0qNmJv+nNw/Ii9N8Lz2a3yuvvI4t+W0Jh7
         77/l+NSw/4gTXBhqreJut7zWFo5ViIxK757YGPvU3y9xuEsOTxXkJIXan7hV0tJJmiOO
         dMS0exY14wcZbChxm8WFTpCtElG2NeJAvd9A0VoPnjUmsd9Mm62sPZp5GenkiRsz84Ev
         lAvwZXQ2wtOudCosA2dek7AYdeoUaC8JIIM+TDJgk6RriItUCzHoa05y8GRWgD7bFC8T
         DTbTouPToPqlzD/J7skHgukhoYz/6GtM9KQ/QQLZpq47NN7r8C7ohgDOac+etBwU8xi4
         UGXw==
X-Gm-Message-State: AOAM533tamVDlYpsgfQHmnXxqe6pAZ4HRhTFTMxQrfIZkr6LX9Wv1a+z
        Xu73z+wzBQft/BWO2apDgXJJevE9BFu29X3eW8s=
X-Google-Smtp-Source: ABdhPJwrDAHE7CO1uaS8TMOScMEm6zCi6LJ+UDCgiD2oof8dG5XQyU/TVroX3Cx1YbzHP2l0fQ9jPUw5ttxujPLesgA=
X-Received: by 2002:aa7:cb09:: with SMTP id s9mr27472809edt.359.1635631841220;
 Sat, 30 Oct 2021 15:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211030182813.116672-1-hdegoede@redhat.com> <20211030182813.116672-10-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-10-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 01:10:05 +0300
Message-ID: <CAHp75Vf=ff840YD8_4QJpir_u__Rr_aN_0C-sqQOkt7PboWpww@mail.gmail.com>
Subject: Re: [PATCH 09/13] power: supply: bq25890: Add bq25890_set_otg_cfg() helper
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
> Add a bq25890_set_otg_cfg() helper function, this is a preparation
> patch for adding regulator support.

...

>         switch (bq->usb_event) {
>         case USB_EVENT_ID:
>                 /* Enable boost mode */
> -               ret = bq25890_field_write(bq, F_OTG_CFG, 1);
> -               if (ret < 0)
> -                       goto error;
> +               bq25890_set_otg_cfg(bq, 1);
>                 break;
>
>         case USB_EVENT_NONE:
>                 /* Disable boost mode */
> -               ret = bq25890_field_write(bq, F_OTG_CFG, 0);
> -               if (ret < 0)
> -                       goto error;
> -
> -               power_supply_changed(bq->charger);
> +               ret = bq25890_set_otg_cfg(bq, 0);
> +               if (ret == 0)
> +                       power_supply_changed(bq->charger);
>                 break;
>         }

While at it,

default:
 break;

?

-- 
With Best Regards,
Andy Shevchenko
