Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FE2440C07
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 00:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhJ3WKS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 18:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhJ3WKR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 18:10:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECB0C061570;
        Sat, 30 Oct 2021 15:07:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r12so51088923edt.6;
        Sat, 30 Oct 2021 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pee8ZBtW4J/0kHa2OihH1OTdXP4DPJUldbwhC8A9wBE=;
        b=kCkKp61ro4nZid08tKGrglOJMO/IRih7RMyywJgwZLQWJwzgCAxUWV8iGbb0Atu6yB
         HreZ8HYflsHdIIqizdB5uaz5NLPSAAP304NwvfzRRSyIh3LkXCXj3FZMR4YhTvzdKUNQ
         NnCsqLMwMNLA694yLi5yI43w/0eOQE39J7b30aODi3lJTZBDIHG/a7E0s47RF3+uBmp9
         6BG/+n3zG4tSW3FfP4vRTJjFRALgUlBjprDTzeJYmd0WPA+HvvcxycIsHc5BiK2CmApQ
         U36mvSrMhumO6ukucWS8ciIi9ayTeXjo+jeMYIw4zdZhimT5HhpOQz8TAHItvj/wLEnL
         UuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pee8ZBtW4J/0kHa2OihH1OTdXP4DPJUldbwhC8A9wBE=;
        b=NCJsCvFr3fTKqOWeOzjCV7wjoGpQJPZVDmSSytauPiBVJPfdwK5CbeTkC4KDCDc/dL
         ozw7DsEFd0ym7kZZjx/wCAQp+7MhITWhLgDL3G2iVQ+CdHZkQciHLtiaugIBoGT7qX5U
         ar18MCAmMYhlhbIGZbDvHik0HiuefGn8C0aI02vstlYLWobvU2oQpaiS8WQllBzABmJu
         HB8F72pTm2cz//jEQYRNURfhm6ZUjLPnPl4kbg7DGUgzg7iqavbRZnlS3mR4fcYqrHwI
         q0J5EDF+8Pf8zJjZG5ESxlunGJOmkV/ZQtqFJFy9/HoSL+eaDTkbQ+E2+kb9o2xtMChz
         7IdQ==
X-Gm-Message-State: AOAM533cV/AuCAACk7AWHnNKdOBjpTRMqF1ovl8czLw/hS8O2Cy2KipZ
        mxMxsBvwKYUkBjYASFBryRwNQrdI5YxjldVFnO8=
X-Google-Smtp-Source: ABdhPJz6xe3SvnSC+lXjSbStIHrPm/fPXSauS0lUcEEGd00j56OWf7jTmeNR+AwWO/higXbVi0BfoFqHgtF7XsyselA=
X-Received: by 2002:a17:906:a158:: with SMTP id bu24mr22419463ejb.356.1635631665372;
 Sat, 30 Oct 2021 15:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211030182813.116672-1-hdegoede@redhat.com> <20211030182813.116672-7-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-7-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 01:07:09 +0300
Message-ID: <CAHp75VeO60umiJTAbL+nR==4pP0KkKQQ71yFNdK2SAkJ0rRXug@mail.gmail.com>
Subject: Re: [PATCH 06/13] power: supply: bq25890: Add support for skipping initialization
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
> On most X86/ACPI devices there is no devicetree to supply the necessary
> init-data. Instead the firmware already fully initializes the bq25890
> charger at boot.
>
> At support for a new "ti,skip-init" boolean property to support this.
> So far this new property is only used on X86/ACPI (non devicetree) devs,
> IOW it is not used in actual devicetree files. The devicetree-bindings
> maintainers have requested properties like these to not be added to the
> devicetree-bindings, so the new property is deliberately not added
> to the existing devicetree-bindings.

With 'ti,' prefix it can be a potential collision in name space, for
internal properties I would rather use 'linux,' one.

...

> +       init->write_cfg = !device_property_read_bool(bq->dev, "ti,skip-init");
> +       if (!init->write_cfg)
> +               return 0;

Why to have double negation here?
I would rather expect that you will have direct value in the structure
and do a respective check in the functions.

-- 
With Best Regards,
Andy Shevchenko
