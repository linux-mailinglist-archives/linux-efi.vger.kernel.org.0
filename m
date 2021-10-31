Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E978441095
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 20:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhJaTwv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 15:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhJaTwu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Oct 2021 15:52:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E476C061570;
        Sun, 31 Oct 2021 12:50:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m14so4600486edd.0;
        Sun, 31 Oct 2021 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZOhoPZ1UsW3Q2cSKLXaXRiYKNcpoaTbLA9PDJGYSsU=;
        b=MYP0svOVSB///qDnzDmKDBIIkyqXDZbE02CGarXWXmdbn2ndKfCAetGjFmj9BXH05m
         6iU+CllDu5MBIunvCLEdkmsjecvbfoBtgaliCdV1OU8oNEhTpgvQqHJ17nhgl72KQSvU
         JdT16f6BZd4JC1e57mY2UCuBlQ6myuJWU6T7xKec2/H6P4+PoAczsqBeR5Bf+I6kFtXJ
         IPZ0yu87mtcG8xOCueXXHh7NAtriZxrxhCOejSnNDCz8hJSRiFg9zDdBxSKVWZxpYwO8
         6y/Wxahp1111eBJkPIjDWNppQe637dKXNxbWErCC5iv9bEAmub7aAWNc6A+9A7J6CKqC
         Zkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZOhoPZ1UsW3Q2cSKLXaXRiYKNcpoaTbLA9PDJGYSsU=;
        b=ClOCqW/z35VyzI+owTMK0VZadfPGmxXQiMKvM95PGx8rnOA0M/GGOhgdGMe3XkqTex
         vUn1RML5T21uYmcZkwVOnnofwIzirqieENFkRvOwpS00aUwHDmR5RqbqAyLOPBRLHzMu
         zMbFvvw/k029tc0jSJWiTlY9usM8hgElHH+YsT94t9Kk1UXIDu0admfZfThifnHsB8OT
         +QU5O8nZ5UFI5EjWihx1tyDa+eRhn6C2BZ6pCxCxXvM5eeG/zyTUHFPflBDREaG88cCM
         fRGsqgxyXykT1GKhjU5qWvRAV9zCxJNLy4d2smYChrDewkn3M/fsbnWDY0+kMY7b+xTM
         fMhg==
X-Gm-Message-State: AOAM5324z2O1NP1S0PJdurezVU8awjOClDyOMJVUHsrk7URc3Ng0osym
        BuQo+OiX5yzfVITCZrMpD5KAqKyYg0xmXX+vkxw=
X-Google-Smtp-Source: ABdhPJxPogPqOtx+XhQdhjfHNyKJ5/pSIaEuGMfO18vdCBpSYqcIgcFYEfAK6Foid49HydOdqQRy3GRsviKh/cNpzu0=
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr30032288ejc.128.1635709814768;
 Sun, 31 Oct 2021 12:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211031162428.22368-1-hdegoede@redhat.com>
In-Reply-To: <20211031162428.22368-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 21:49:38 +0200
Message-ID: <CAHp75VdFcfEyEsFWVS_zxr-aehpqELAwN1eBs-KHVkEwxO2e5Q@mail.gmail.com>
Subject: Re: [RFC 0/5] ACPI/power-suppy add fuel-gauge support on cht-wc PMIC
 without USB-PD support devs
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
> Hi All,
>
> Together with my earlier series to hookup the charger, Vbus boost converter
> and USB role-switching:
> https://lore.kernel.org/platform-driver-x86/20211030182813.116672-1-hdegoede@redhat.com/T/#t
>
> This series also adds battery-monitoring support on the Xiaomi Mi Pad 2
> and the generic parts of it should also be usable on other devices with
> the same PMIC setup.
>
> I've marked this series as a RFC because I'm not happy about the amount of
> DMI quirks this series requires. The 3 separate quirks in
> drivers/acpi/x86/utils.c are a bit much, but esp. when combined with also
> the changes needed in drivers/gpio/gpiolib-acpi.c it all becomes a bit too
> much special casing for just a single device.
>
> So I've been thinking about alternatives for this and I've come up with
> 3 ways to deal with this:
>
> 1. This patch set.
>
> 2. Instead of the quirks in drivers/acpi/x86/utils.c, write an old-fashioned
> "board" .c file/module which autoloads based on a DMI match and manually
> instantiates i2c-clients for the BQ27520 fuel-gauge and the KTD20260 LED ctrlr.
> Combined with not giving an IRQ to the fuel-gauge i2c-client (i), this allows
> completely dropping the gpiolib-acpi.c changes and only requires 1 quirk for
> the 2nd PWM controller in drivers/acpi/x86/utils.c. As an added bonus this
> approach will also removes the need to add ACPI enumeration support to the
> bq27xxx_battery code.
>
> 3. While working on this I noticed that the Mi Pad 2 DSDT actually has
> full ac and battery ACPI code in its DSDT, which Linux was not trying to
> use because of the Whiskey Cove PMIC ACPI HID in acpi_ac_blacklist[] in
> drivers/apci/ac.c, resp. a missing _DEP for the ACPI battery.
>
> With the native drivers disabled (the default in 5.15-rc7 without patches),
> both those things fixed and a fix to intel_pmic_regs_handler() in
> drivers/acpi/pmic/intel_pmic.c, battery monitoring actually starts working
> somwhat!
>
> I say somewhat because changes are not detected until userspace polls
> the power_supply and switching from charge/device to host mode and
> back does not work at all. This is due to the AML code for this relying
> on _AEI ACPI events on virtual GPIOs on the PMIC :|  This means that we
> would need to reverse engineer which events these virtual GPIO interrupts
> represent; and then somehow rework the whole MFD + child driver setup
> to deliver, e.g. extcon/pwrsrc events to a to-be-written GPIO driver
> which supports these virtual GPIOs, while at the same time also keeping
> normal native driver support since boards which USB-PD support need the
> native drivers...  So OTOH this option has the promise of solving this
> in a generic way which may work on more boards, OTOH it is a big mess
> and we lack documentation for it.  Interestingly enough the ACPI
> battery/ac code also takes ownership of the notification LED, downgrading
> it from a full RGB led to a green charging LED, which is both a pre
> and a con at the same time (since we would loose full RGB function).
>
> ###

> Although I started out with implementing option 1, I now think I
> Would personally prefer option 2. This isolates most of the code
> needed to support some of these special boards into a single
> (per board) file which can be build as a module which can be
> autoloaded, rather then growing vmlinuz by adding quirks there.

Even before reading this my attention was on option 2 as well.
However, we might give another round of searching the documentation
for the vGPIO lines.

Meanwhile, have you tried to see if Android tree(s) has(ve) the
patches related to all this? (I'm a bit sceptical they do the right
thing and most probably just fall into board files case)

> The downside would be this sorta re-introduces the old ARM model
> of one board file per (special-case) board, but there are only
> 1 or 2 more x86 tablets (ii) that I know about which may also
> need such a board file. Which I think is managable and should
> not run into the original objections against the original ARM
> approach where there were way too many board files in the end.
>
> Option 3 IMHO is a no go unless someone at Intel manages to
> come up with documentation on all the virtual GPIOs which the
> Windows PMIC drivers implement as method of communicating
> between the PMIC driver and the AML code in the DSDT.
>
> I'm a bit in dubio about how to progress with this, so I would
> love to hear what others think about this. I would esp. appreciate
> Rafael's and Mika's input on this since most of the added ugliness
> in this RFC is in the ACPI code.
>
> Regards,
>
> Hans
>
>
> i) This means that the _AEI ACPI handler for the fuel-gauge will run on
> FG interrupts. This is fine it does a single I2C read and a couple of
> ACPI notifies which will get ignored. Note the interrupts are "something
> changed" pulses which don't need IRQ clearing.
>
> ii) There are not that many CHT boards with a Whiskey Cove PMIC, other
> then the GPD win/pocket with full USB-PD support and the Xiaomi Mi Pad 2
> I'm only aware of one other, the Lenovo Yoga Book YB1-X91L/F . Since this
> whole saga has gotten me quite curious and I already have the other
> 2 devices I've decided to spend some money on this and bought a 2nd hand
> Lenovo Yoga Book YB1-X91L, whose setup is similar to the Mi Pad 2.
> I should have this in about a week. I'll post a reply to this thread
> with info no how the DSDT looks on the Lenovo Yoga Book and if e.g.
> using the standard ACPI battery interface seems to be an option there.
>
> iii) Note the "power: supply: bq27xxx: Add dev helper variable to
> bq27xxx_battery_i2c_probe()" patch applies on top of the
> "power: supply: bq27xxx: Fix kernel crash on IRQ handler register error"
> bug-fix which I send out earlier.

-- 
With Best Regards,
Andy Shevchenko
