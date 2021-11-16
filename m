Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05FB452FA4
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhKPLDp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhKPLDm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:03:42 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD73EC061570;
        Tue, 16 Nov 2021 03:00:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so10986917edd.13;
        Tue, 16 Nov 2021 03:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZYsLA03c0ESxUBqInit0nIdPnOqA/BXoaX/WaT1Xo0=;
        b=qsMKMXQ3gqvfq5vm5Xf6kKGtzHl2sjvIqH1Gona6Hfq+inlnsBjP6WvPIKKuFZvHd6
         /rzUb9Cbew5anK1AQxoFWqLS99sguSvNzIoEOCUVYUSPgk6V4fYa9ccVLhg6tBtmiQAf
         rV8aNSozQxrftK7Srj92YJIgXthyLHX3yGVo0NBYMGH7gjfD1qyL9dA9oS/kac8yJIwf
         viSXfcoavOU5yTotlfb2h1C0IA897ylObp8c7KTdGXB78lSs7BHxt++3+daIIz2jAKOs
         JRjCh6S3UMndPpG7HiS9/qA/IUIO/UN/UVB2T/gQt/OyVBAvYxzHjZIM9s2F1hbpSJdR
         HvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZYsLA03c0ESxUBqInit0nIdPnOqA/BXoaX/WaT1Xo0=;
        b=7+jxa2UdH3+ke0vTe8+S57RS919OnDiCec9uH+HDavIinHtgqbpIZa4fCiuemk6WKN
         JWPr8cFbyHciNxvLtF6hfDG8HWhhQZQ4GB9jm3b8eZZzu0dYhNfi5vf4NQ8yyjMMrhGU
         FQvFIo8Lg2MYBdK7bnQDYnfB04cGypXVHKvbU4yj0EAhWBsIljwPhXRYNN0qCldVEQFj
         +UPz9Nyn0Z6LZVI1/hSy8HHJURGUgpNloZ0T8sY6qaQiaiJ/AK6uhI6Zaf71ph1NiSJy
         IlDViUPc5glBugEzkRgrbzskdbC3GhYN9vodoO0SLLCmc69PnkCuVexS2LU+W2Mdh84t
         4ggw==
X-Gm-Message-State: AOAM531zRv8TyoUTfqieMtn7AoJsGc8N3452dmFXBaaofkuAUj33L3sH
        ky2d0SGzoacp5/Gd8+jIsYGFIDRHHHPB0vIL3o9SJT6qc8M=
X-Google-Smtp-Source: ABdhPJy10veqr4r8kc5EiKNBhkcv6gYr2Kc2qm+82DyZ67lYKpyQ540qJr8Bgm1flhfPv1liIBqriGFL/Tu2lCppA5I=
X-Received: by 2002:a50:9ec9:: with SMTP id a67mr8829518edf.238.1637060444315;
 Tue, 16 Nov 2021 03:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20211114170335.66994-1-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 13:00:02 +0200
Message-ID: <CAHp75Vf+0yw8Nb4Lxbf9ukYWw9xPnpy2C0OyaXJ+o5xsamP4qA@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] power-suppy/i2c/extcon: Fix charger setup on
 Xiaomi Mi Pad 2 and Lenovo Yogabook
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

On Sun, Nov 14, 2021 at 7:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> This is version 2 of my series previously titled:
> "[PATCH 00/13] power-suppy/i2c/extcon: Add support for cht-wc PMIC
> without USB-PD support".
>
> So far almost all the kernel code surrounding the Cherry Trail Whiskey Cove
> PMIC has been developed on the GPD win / pocket devices and it has various
> assumption based on that. In the mean time I've learned (and gotten access
> to) about 2 more designs and none of the 3 now known designs use a single
> standard setup for the charger, fuel-gauge and other chips surrounding the
> PMIC / charging+data USB port:
>
> 1. The GPD Win and GPD Pocket mini-laptops, these are really 2 models
> but the Pocket re-uses the GPD Win's design in a different housing:
>
> The WC PMIC is connected to a TI BQ24292i charger, paired with
> a Maxim MAX17047 fuelgauge + a FUSB302 USB Type-C Controller +
> a PI3USB30532 USB switch, for a fully functional Type-C port.
>
> 2. The Xiaomi Mi Pad 2:
>
> The WC PMIC is connected to a TI BQ25890 charger, paired with
> a TI BQ27520 fuelgauge, using the TI BQ25890 for BC1.2 charger type
> detection, for a USB-2 only Type-C port without PD.
>
> 3. The Lenovo Yoga Book YB1-X90 / Lenovo Yoga Book YB1-X91 series:
>
> The WC PMIC is connected to a TI BQ25892 charger, paired with
> a TI BQ27542 fuelgauge, using the WC PMIC for BC1.2 charger type
> detection and using the BQ25892's Mediatek Pump Express+ (1.0)
>
> ###
>
> Unlike what is normal on X86 this diversity in designs is not handled /
> abstracted away by the ACPI tables.

I will briefly look into it, right now two observations (or nit-picks):
- you may utilize Co-developed-by tag when it makes sense
- I would rather see "x86/ACPI" in all texts (note small "x")

-- 
With Best Regards,
Andy Shevchenko
