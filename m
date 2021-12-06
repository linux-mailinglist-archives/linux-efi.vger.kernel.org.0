Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304B646A65F
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 20:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349497AbhLFUBV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 15:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349551AbhLFUBC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 15:01:02 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674A6C0698C3;
        Mon,  6 Dec 2021 11:57:32 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z5so48110916edd.3;
        Mon, 06 Dec 2021 11:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDbD429x7EGhGMhsVDh9494mFqKE/H+dYpI7efBswy4=;
        b=qyHAG2uEzGWAT0b3t0AT1UWTaT7NTaH8qGdIPfOphRXY0HMHmVtRT9PMuxqeZU4i7t
         vDUVGwg+8WtDOjZ2/hghyXXhffb6oVw184AaM/Ib4u3T3hPhXJAaS/0cdsWUI3xGT3hX
         BfZ0/qeiHd3FOLdK4PIe3izOUqYYK2W+bnY1/FKdscbcvQ9gt/vXZay3kbkZwuRArqPD
         upUx6fnXzcThe1hfrh+04gD60srBXbRI5Xt4MERGIvIlYxKLC3lXPac+Tw7Wg6WrrjJj
         e1cRzJcTYVtillCjhTHiFqHhs+fehdvFPxUtI6qbT7Naf1Ph9v0PCawauveywl8bfngc
         F/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDbD429x7EGhGMhsVDh9494mFqKE/H+dYpI7efBswy4=;
        b=AP9qe8mARfaLgXHIeGMyyastGGGZS/R+llUvtlBAW3OLyIPLV8l9GLyMgSqkxeg4CQ
         OeSmKYNDzRw4T9LEN3zxCcEJ/Un3/Ei/7LGurhr6G/zeORiwVVM29SKAzV+IPDL16nI1
         tTmSaJRK35F9AlWbN2SUIQt4uD4lhFlgSGEuTLiJ5xYPofwzFFW9DMPxOVjoq7Okb4AD
         jwMAi1KHuAuN02fcAKRlbcXUDvHXGe34PsS+HVSaubyNxew7R41+51fTifpTvUcbZ2Cp
         7vopiLZC+tv42YCVLc0fpPiqAADdP28FSp9Z+WtDKx72u97TPwAN811MaYXDJ3agPPxp
         ifEA==
X-Gm-Message-State: AOAM532HDfRr2DV8ZlArgJvF9H4NYxLjUY8CNp3ycr2vDgZCXDux3Ee8
        TdlGbdk6+gLBOu14PSKdUjilEsmSO48nb5EqBas=
X-Google-Smtp-Source: ABdhPJzWAtk+egcPYv+YJzS0Q5UW6JXgWqCbk4YgT7bZZlKPZAsHB+shis4xeMBPhZKqn9hbkv+BiK/vOUsqe4ZlBEg=
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr45495850ejc.356.1638820650915;
 Mon, 06 Dec 2021 11:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20211206093318.45214-1-hdegoede@redhat.com> <20211206093318.45214-15-hdegoede@redhat.com>
In-Reply-To: <20211206093318.45214-15-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Dec 2021 21:55:56 +0200
Message-ID: <CAHp75Vc+z0nqUXbqrX9YXi2+rzz4BKT7maFipyB8QgOEKQ9SPw@mail.gmail.com>
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

On Mon, Dec 6, 2021 at 11:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Tablet / laptop designs using an Intel Cherry Trail x86 main SoC with
> an Intel Whiskey Cove PMIC do not use a single standard setup for
> the charger, fuel-gauge and other chips surrounding the PMIC /
> charging+data USB port.
>
> Unlike what is normal on x86 this diversity in designs is not handled
> by the ACPI tables. On 2 of the 3 known designs there are no standard
> (PNP0C0A) ACPI battery devices and on the 3th design the ACPI battery
> device does not work under Linux due to it requiring non-standard
> and undocumented ACPI behavior.
>
> So to make things work under Linux we use native charger and fuel-gauge
> drivers on these devices, re-using the native drivers used on ARM boards
> with the same charger / fuel-gauge ICs.
>
> This requires various MFD-cell drivers for the CHT-WC PMIC cells to
> know which model they are exactly running on so that they can e.g.
> instantiate an I2C-client for the right model charger-IC (the charger
> is connected to an I2C-controller which is part of the PMIC).
>
> Rather then duplicating DMI-id matching to check which model we are
> running on in each MFD-cell driver, add a check for this to the
> shared drivers/mfd/intel_soc_pmic_chtwc.c code by using a
> DMI table for all 3 known models:
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
> support to enable charging with up to 12V through a micro-USB port.

...

> +enum intel_cht_wc_models {
> +       INTEL_CHT_WC_UNKNOWN,
> +       INTEL_CHT_WC_GPD_WIN_POCKET,
> +       INTEL_CHT_WC_XIAOMI_MIPAD2,
> +       INTEL_CHT_WC_LENOVO_YOGABOOK1,
> +};

...

> +       enum intel_cht_wc_models cht_wc_model;

I'm wondering what will you do when something similar will be needed
for another PMIC?

I see possible solutions to eliminate additional churn:
- make just one enum for all models (can be done now, can be renamed later)
- make a union if we have such situation

because I wouldn't like to have another field for each possible
variant of PMIC in the generic structure.

Hence the question, does it make sense to just name it (enum and
member) less cht_wc oriented?

-- 
With Best Regards,
Andy Shevchenko
