Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A2446AB32
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 23:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356227AbhLFWJK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 17:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356011AbhLFWJJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 17:09:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15D6C061746;
        Mon,  6 Dec 2021 14:05:39 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r25so48678898edq.7;
        Mon, 06 Dec 2021 14:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJfiE4cGLCRU3DrNG1N9c4wCYqq8toA4+2VtacckEIk=;
        b=QH6xU1KzmgyN6U5zZxqDFdED+AuUY0irI0GF72907SxdOLClppffOtcPq3RhwT4JsA
         b2kGlwa2kh7UodmlsI5SUoX4SkXvoXFCHJOL5XtRNgupPU70oWfVDsiFUmyeKzkNnRX7
         xLLOoVDMDO74fAj1fktbmyi12MNPEQVVCpoXAQNE3bEaDpGpHPrB01bU6XbE/sR+3r8X
         H/FFwLRCXVEQaxB9mvaRXBAanNRBKHWiGB/efaHfBH22l8iGNPl90zDMF9CEVPsfty/k
         jqEI9NeTv1AZIzuU5SawhoGhCrKJVV0tm5XvJs8nCU359d0VHm1gTANLueUrn0sBT7Iq
         dCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJfiE4cGLCRU3DrNG1N9c4wCYqq8toA4+2VtacckEIk=;
        b=SPNOVSXLQcMsLVjDAiLIDLH70mv2EFa9AMj/euOpTKf0FErqo7ECworJ3bBsp3gjxy
         IQHtKbqqXTwh/09J5ZmiXfQXVFxlfJyvAG+7h/cZBk+1XHmkvIlRyqVZKQ2MaLAZ6b15
         E2cb3uWS3w9pFM+w0TOphN8iy98YGZpNrqyqwncPcl1c9pYrEU+oZPq9wvQftjVcPK/4
         n66vnrSn0QRMI1kmN9m4I9qBm1Ydi6AQRG3WpggJwFQsuexihLExfq9GCeof0v+fHUcD
         RLk93925q7DZInra7dNzlDZmUl8pa65sj9za8BJFqhWZUQPYlyhi5vzt+1rD1c7XwQ4M
         w5Gw==
X-Gm-Message-State: AOAM533d1o210trnBPjkZeK/o80EN6BQxFr5TgOHVHsPaXXYXlfLyTF6
        X2HttWyl4ZGBCy9Okhm0r5/nO5H8i7T7N+jhCv4=
X-Google-Smtp-Source: ABdhPJxOLCQiTt5iJi9D8ojYBEeTXiWilxAcvNpf63FBk+kOzk7fJYSceGQCwoK/BEAWFxRygbs/uzjQjGs66UpOsX0=
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr2723333edd.258.1638828338334;
 Mon, 06 Dec 2021 14:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20211206093318.45214-1-hdegoede@redhat.com> <20211206093318.45214-15-hdegoede@redhat.com>
 <CAHp75Vc+z0nqUXbqrX9YXi2+rzz4BKT7maFipyB8QgOEKQ9SPw@mail.gmail.com> <94738e2d-8b8d-08a0-be39-343ac275fa5f@redhat.com>
In-Reply-To: <94738e2d-8b8d-08a0-be39-343ac275fa5f@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Dec 2021 00:04:04 +0200
Message-ID: <CAHp75Vc507NWY-PyZ6j1J65fvDBj92PpikP1pW--FTk+P=2bog@mail.gmail.com>
Subject: Re: [PATCH v4 14/20] mfd: intel_soc_pmic_chtwc: Add cht_wc_model data
 to struct intel_soc_pmic
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 6, 2021 at 11:46 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 12/6/21 20:55, Andy Shevchenko wrote:
> > On Mon, Dec 6, 2021 at 11:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Tablet / laptop designs using an Intel Cherry Trail x86 main SoC with
> >> an Intel Whiskey Cove PMIC do not use a single standard setup for
> >> the charger, fuel-gauge and other chips surrounding the PMIC /
> >> charging+data USB port.
> >>
> >> Unlike what is normal on x86 this diversity in designs is not handled
> >> by the ACPI tables. On 2 of the 3 known designs there are no standard
> >> (PNP0C0A) ACPI battery devices and on the 3th design the ACPI battery
> >> device does not work under Linux due to it requiring non-standard
> >> and undocumented ACPI behavior.
> >>
> >> So to make things work under Linux we use native charger and fuel-gauge
> >> drivers on these devices, re-using the native drivers used on ARM boards
> >> with the same charger / fuel-gauge ICs.
> >>
> >> This requires various MFD-cell drivers for the CHT-WC PMIC cells to
> >> know which model they are exactly running on so that they can e.g.
> >> instantiate an I2C-client for the right model charger-IC (the charger
> >> is connected to an I2C-controller which is part of the PMIC).
> >>
> >> Rather then duplicating DMI-id matching to check which model we are
> >> running on in each MFD-cell driver, add a check for this to the
> >> shared drivers/mfd/intel_soc_pmic_chtwc.c code by using a
> >> DMI table for all 3 known models:
> >>
> >> 1. The GPD Win and GPD Pocket mini-laptops, these are really 2 models
> >> but the Pocket re-uses the GPD Win's design in a different housing:
> >>
> >> The WC PMIC is connected to a TI BQ24292i charger, paired with
> >> a Maxim MAX17047 fuelgauge + a FUSB302 USB Type-C Controller +
> >> a PI3USB30532 USB switch, for a fully functional Type-C port.
> >>
> >> 2. The Xiaomi Mi Pad 2:
> >>
> >> The WC PMIC is connected to a TI BQ25890 charger, paired with
> >> a TI BQ27520 fuelgauge, using the TI BQ25890 for BC1.2 charger type
> >> detection, for a USB-2 only Type-C port without PD.
> >>
> >> 3. The Lenovo Yoga Book YB1-X90 / Lenovo Yoga Book YB1-X91 series:
> >>
> >> The WC PMIC is connected to a TI BQ25892 charger, paired with
> >> a TI BQ27542 fuelgauge, using the WC PMIC for BC1.2 charger type
> >> detection and using the BQ25892's Mediatek Pump Express+ (1.0)
> >> support to enable charging with up to 12V through a micro-USB port.
> >
> > ...
> >
> >> +enum intel_cht_wc_models {
> >> +       INTEL_CHT_WC_UNKNOWN,
> >> +       INTEL_CHT_WC_GPD_WIN_POCKET,
> >> +       INTEL_CHT_WC_XIAOMI_MIPAD2,
> >> +       INTEL_CHT_WC_LENOVO_YOGABOOK1,
> >> +};
> >
> > ...
> >
> >> +       enum intel_cht_wc_models cht_wc_model;
> >
> > I'm wondering what will you do when something similar will be needed
> > for another PMIC?
> >
> > I see possible solutions to eliminate additional churn:
> > - make just one enum for all models (can be done now, can be renamed later)
> > - make a union if we have such situation
> >
> > because I wouldn't like to have another field for each possible
> > variant of PMIC in the generic structure.
> >
> > Hence the question, does it make sense to just name it (enum and
> > member) less cht_wc oriented?
>
> I agree that renaming these to make them generic makes sense if we get a
> second user (which I doubt, but you never know). For now I would like to
> keep this as is though, this is a big series and I would like to avoid
> to respin it just for this and we can always rename this later.
>
> If I need to do a v5 anyways though, then I'll do the rename for v5.

Yeah, either way:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
