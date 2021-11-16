Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4532E453026
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhKPLWL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbhKPLVp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:21:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ECAC061766;
        Tue, 16 Nov 2021 03:18:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so86188487edv.1;
        Tue, 16 Nov 2021 03:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VyMAc7dpvHTlKlsyO57WoyKftdnKMxSnombRa4KIG48=;
        b=q17SjuNpBdpF72E29J1AT8On7SfHik/DFggjvQ1DV8nVDFDTbL0T5VLTdukwyyv/ZB
         0UJ4P2GgtDKcSjaHJydduW43uU1BvlK4R+znHE/bmRVUgDFwDemOZYKs2821AsHRlitN
         j9OKQqHqIWB5ZBOaOiYLQyZykeag7DjC3vW1ZTy6PK+KJXnoTQ9QqIQCNVp/AB4nHWY6
         Uddgvv4K6+1rEBXZO4bsghKrNZD4gChiDrDQZcD4i7XzQU6lvZqFaBaTe7nRX1tF2nsr
         Ix23645Rd/l3HAaqw1jp78dJbbHUzKjI0ylT31PW9300gF/2wdis8Yzsx//8fuKoSMHe
         w6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyMAc7dpvHTlKlsyO57WoyKftdnKMxSnombRa4KIG48=;
        b=cA0rcxo9ecx+3DOc7oq7DlLVDZ3L7HjQUXvc6KD7PR5+gBVzNDxlFQZidiYFFjqvtI
         E57a0SLP/3wtYwwbEvjMgJEA7SjsrnniJDCYbbT9kReSoheOTzTtne4pDxtYA0ZSPv50
         DCbCVU9zZjw34EwQiJow5q8bmVwkr2eq7Fz9QVe4XHN5WJp3C9gnanVPCaCaraqWQ4O/
         PX1MRg737n+nJEx8mkVxUtQtK6DeFQ0l/9NSlasbVhRP6iweq2bCISaopwzxVydBbhbD
         lXDLDd/CIBPVqnIbRHlXESwg1OMhCdmMcNmrpAEVz37nsifES4/hJJnioq5pjMUXSlvE
         BwNw==
X-Gm-Message-State: AOAM532HHPAScExhFtDv9QUzptph7vygJSG3cNFEm1L/LuQkDlIadMkV
        P7EiFKfrW4A819cn34JN3x7rJhioy9EELd1MECk=
X-Google-Smtp-Source: ABdhPJyX+qeK2c/XHC0iTbAM1IfAzxE9FZwWuplmNuNoIO560ov6kgB7Uo84lq2YRr0JcpLE+s3Nd8dtcZN2x/mrdnI=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr8592220ejb.69.1637061526653;
 Tue, 16 Nov 2021 03:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20211114170335.66994-1-hdegoede@redhat.com> <20211114170335.66994-15-hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-15-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 13:18:05 +0200
Message-ID: <CAHp75Ve=UkSF_fTjJSkAKgxV3hdzGbT5Hqzxi0ACu-Q-=rF3Qw@mail.gmail.com>
Subject: Re: [PATCH v2 14/20] mfd: intel_soc_pmic_chtwc: Add
 intel_cht_wc_get_model() helper function
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
> Tablet / laptop designs using an Intel Cherry Trail x86 main SoC with
> an Intel Whiskey Cove PMIC do not use a single standard setup for

does not

> the charger, fuel-gauge and other chips surrounding the PMIC /
> charging+data USB port.
>
> Unlike what is normal on X86 this diversity in designs is not handled
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
> running on in each MFD-cell driver add a helper function for this
> and make this id all 3 known models:
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

> +               /*
> +                * Note this may not seem like a very unique match, but in the
> +                * 24000+ DMI decode dumps from linux-hardware.org only 42 have

Can you add https:// (or is it gopher? :)

> +                * a board_vendor value of "AMI Corporation" and of those 42
> +                * only 1 (the GPD win/pocket entry) has a board_name of
> +                * "Default string". Also very few devices have both board_ and
> +                * product_name not set.
> +                */

...

> +enum intel_cht_wc_models intel_cht_wc_get_model(void)
> +{
> +       const struct dmi_system_id *id;
> +
> +       id = dmi_first_match(cht_wc_model_dmi_ids);
> +       if (!id)
> +               return INTEL_CHT_WC_UNKNOWN;
> +
> +       return (long)id->driver_data;

Why not proper casting, i.e. (enum intel_...)?

> +}
> +EXPORT_SYMBOL_GPL(intel_cht_wc_get_model);

Are you planning to use EXPORT_SYMBOL_GPL_NS()? If not, please consider it.

-- 
With Best Regards,
Andy Shevchenko
