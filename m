Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864424530DF
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhKPLhp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhKPLfs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:35:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC96C06121D;
        Tue, 16 Nov 2021 03:31:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w1so20213977edc.6;
        Tue, 16 Nov 2021 03:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gm0iaiusdciMrx8928GSRwf0HXjOL1IswPuzIDzix+o=;
        b=THxRtB5bhZqhV9920ZnZeRAQUoWjdx1qnBW8txpKshjpwevq4Ax/wKdI2YmGkd26Qw
         dkk6/4XQvUMoWLW3wgFO+yfVmbBBxT2o9p76/W+uF0T90tSRmkeEGf1WXrbdt8F64Gju
         flITnryzQ+6SFgHfICuXaD43d6Q+rTmYGSTKuqnvyc/VJULeaUifCE408d0P7BWdsKqH
         quow204qEQQ/QGK1e5grkUyW9DP5p3ygCl2TdlosZj/nv34s1TF6J7bXuiEoMx3CZKNk
         /JUb8LPy6R43HMWV5mQma5/6MixmSuhk1yAKrq+jZqGKD0p433THtj5z/nDXjMH9Og3c
         UIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gm0iaiusdciMrx8928GSRwf0HXjOL1IswPuzIDzix+o=;
        b=HRGAvpUKjxgW6P6zXrBRnePO1EJ2WirQovAt/GHCdYdsiqKoLt/LelWthGELAaP/fn
         5TISOxHVEiN68ZYUDhczE7ihQfiQXANmNd7do38Y0YNeQo9CdV+d6Q1Fq42IpDGrYnkl
         HF88cy7HQ2WF9CbmGtnpiwwDGcJokyhWo1rRuH+TiyTEsT/zHAyZVh0vDzE5c4JRT2yh
         L0S8yccDEaH4eIO5hZbjHggEHiBoxsnUEb1egqq6lsY0+DKMnDgh+35PnUgnQ17sDKxx
         kkDmG2N5uCwhU0p/sICUyQWbDzhQgGNOqvUqOZMCsUGgZGSG1opsxcbsjwYT3uOrZWit
         iq2w==
X-Gm-Message-State: AOAM533LrfOxZyL7xVhTSSrD+PHzGUGbsbEkCutiDxAhPuOiXkXntjfB
        btkdUh5R0gqbvv9J2BGlV9BzbDMxhqkSo8WSv+g=
X-Google-Smtp-Source: ABdhPJzQfh6CnE+Adt6rJoKUiS8IbAoxCjDjjVO60IzlqtV3MQ7qPZyGGziK9o6lTdlwriGZeqCUvxgSVdNIo4hymlI=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr8705569ejb.69.1637062306909;
 Tue, 16 Nov 2021 03:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20211114170335.66994-1-hdegoede@redhat.com> <20211114170335.66994-18-hdegoede@redhat.com>
 <CAHp75VdXSdhNtPwNdpssnmt+sZb+ZoAUm-cKJu-PqymmHMOpRw@mail.gmail.com>
In-Reply-To: <CAHp75VdXSdhNtPwNdpssnmt+sZb+ZoAUm-cKJu-PqymmHMOpRw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 13:31:05 +0200
Message-ID: <CAHp75VfSwf0SKDHDOG7WO9xY5Q52o1Zw2GPkxi7UnrLhMtiobA@mail.gmail.com>
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

On Tue, Nov 16, 2021 at 1:28 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Nov 14, 2021 at 7:04 PM Hans de Goede <hdegoede@redhat.com> wrote:

...

> > +       ext->vbus_boost = devm_regulator_get_optional(ext->dev, "vbus");
> > +       if (IS_ERR(ext->vbus_boost)) {
> > +               ret = PTR_ERR(ext->vbus_boost);
> > +               if (ret == -ENODEV)
> > +                       ret = -EPROBE_DEFER;
> > +
> > +               return dev_err_probe(ext->dev, ret, "getting vbus regulator");
>
> Can be also written as
>
>     if (PTR_ERR(ext->vbus_boost) == -ENODEV ||
> PTR_ERR(ext->vbus_boost) == -EPROBE_DEFER)
>         return dev_err_probe(ext->dev, -EPROBE_DEFER, "getting vbus regulator");
>
>     return PTR_ERR(ext->vbus_boost);

Oops, other way around, of course.

  if (PTR_ERR(ext->vbus_boost) == -ENODEV ||
      PTR_ERR(ext->vbus_boost) == -EPROBE_DEFER)
        return -EPROBE_DEFER;

  return dev_err_probe(ext->dev, PTR_ERR(ext->vbus_boost), "getting
vbus regulator");

> but up to you.
>
> > +       }



-- 
With Best Regards,
Andy Shevchenko
