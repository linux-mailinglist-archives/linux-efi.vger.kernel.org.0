Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20994410A1
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 20:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhJaUCT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 16:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhJaUCT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Oct 2021 16:02:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE6C061570;
        Sun, 31 Oct 2021 12:59:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c28so32309590lfv.13;
        Sun, 31 Oct 2021 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6UvgRuI7XbNqIfqNVOEWY23ExzCc8UbZzMD6rauIp0=;
        b=iLlP/alnjyy+ylWPHTD3OpMQe7A3UGPOJdV319qLPjhMvt0Ok89KsjMHmI7VYahqMu
         9/8SqlgJcs/6k4L+Cicm8i/FLb7NyWi7dD6aGZmgBafgsfWbrOyMltCGK7Ld86Xh8GJ7
         QojeNWtJYQDfbZBSmT6CAAkekqBR+ycdJYjtUXyUNR3lzN+M/+k/dTZzFL4wWbXHhGdC
         C+tj8RNzFboEtTGXLz7qqfuSG6Hd93ECR1BoOVhi1Wf4Wt88rHPKfnbLjsw3WmwqNsHt
         Sg4BXHTZ635JFNVlADzDSzNbDcCG3SOUC0zcsEEJ7UdXYieN4Xgb50K8Q68DBTG9+pEl
         p87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6UvgRuI7XbNqIfqNVOEWY23ExzCc8UbZzMD6rauIp0=;
        b=V2l6q666lbILeWUWKS2Vh4qpZfVt0zls45CDZxFtbLwqMy4oR45M/eWZKrWnZm3nmU
         yIQIJ5Hs6GQk+oYYbAk/Z6fbxAEfow3jPSnf3PpU49RxlvHUMG4itgFhcNap7JI0vh0H
         F3jBamHp/WsVNK1bpAVj5yc0IOka0Tvqd3p5bdKbd1KWuKwCOKz3yTYHUeBHBY5MPiKm
         Kj39R+8WkwUHyaaRuw+9a03QYDLETuvlC1y7Fm5wa2JJXfG4/okFAZssKIpLIOLuhAb3
         N/rnDypg5t4Tms5PNLjTIBEbw5xGNNuRvf62Wnkq9QOzR48/Jju+5gf19+dUa1Z6W23U
         bJAA==
X-Gm-Message-State: AOAM532JreI9ck0p8ww5v9T3Ep9ZQXuDXCNYH7ZY3hW5VoPC+p02W4uR
        ChQWBXQwZ3Cwngd080uhnrEXyo/7V5QH9iYPvD4=
X-Google-Smtp-Source: ABdhPJxBUn/T91pzFAlv4rXV7y8MqwzF8mye5VRmZZMPel/Wb75yuN0PRzJzHPETPyz2UxpSutUqPtK8McolL57Omxg=
X-Received: by 2002:a05:6512:acd:: with SMTP id n13mr23317747lfu.60.1635710385010;
 Sun, 31 Oct 2021 12:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211031162428.22368-1-hdegoede@redhat.com> <20211031162428.22368-4-hdegoede@redhat.com>
In-Reply-To: <20211031162428.22368-4-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 21:59:08 +0200
Message-ID: <CAHp75Vf-EOfF_XfqfWFQZNLp3B03o79xHf4bUrf9x9D9pTrvgw@mail.gmail.com>
Subject: Re: [RFC 3/5] gpiolib: acpi: Add a new "ignore" module option
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

On Sun, Oct 31, 2021 at 6:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add a new "ignore" module option to completely ignore controller@pin combos
> from _AEI lists.
>
> And add a DMI quirk to ignore the interrupt of the BQ27520 fuel-gauge IC
> on the Xiaomi Mi Pad 2. On this device we use native charger + fuel-gauge
> drivers because of issues with the ACPI battery implementation. The _AEI
> listing of the fuel-gauge IRQ is intended for use with the unused ACPI
> battery implementation and is blocking the bq27xxx fuel-gauge driver
> from binding.

I'm wondering if the idea behind this is something relative to
https://elixir.bootlin.com/linux/latest/source/drivers/acpi/sysfs.c

-- 
With Best Regards,
Andy Shevchenko
