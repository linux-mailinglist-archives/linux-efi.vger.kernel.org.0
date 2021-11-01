Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F444208E
	for <lists+linux-efi@lfdr.de>; Mon,  1 Nov 2021 20:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhKATPz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Nov 2021 15:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhKATPy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 1 Nov 2021 15:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635794000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uNXa8fBKQfy008maSJaxtZ2zCD7vx4uMQOlojPUS7ks=;
        b=NxSNtaWTo7p1owYn9uLgHa7mZOCjIoSxbKGCkfu9lcycLfN0CXEiGyelAzo6kx73MKNFT+
        +Zou8J63WW/n4DfJnq1jhHGNpPAVT1xni+eoEo+ajhBRpB81PKD/QbQ4jdC/FdR7uxj9HX
        i6r/quncxUH1FhrOCJy7gGAml4Oyulc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-3CBvUP5AN4GOY5OXFIc2yw-1; Mon, 01 Nov 2021 15:13:19 -0400
X-MC-Unique: 3CBvUP5AN4GOY5OXFIc2yw-1
Received: by mail-ed1-f72.google.com with SMTP id o22-20020a056402439600b003dd4f228451so16465188edc.16
        for <linux-efi@vger.kernel.org>; Mon, 01 Nov 2021 12:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uNXa8fBKQfy008maSJaxtZ2zCD7vx4uMQOlojPUS7ks=;
        b=c6cPVtrIUdpy/92mlF65hWADw66HyTMN0mYh4tfa/WGsbbrg21ST+deFqHH1jEhtJL
         fhkSLVGc/e3XJ1lJ+y4Wkftnw5hi4LG7NRlZnt/yFwqkZdRomWWUlhbmO1M4PXm8hrYR
         NPzIMjcGm2uxAGbs8Ef+qteNJBLlu5F8jDkM+6eYsRRRIJckMERwLlX0obv2ok4g/pwu
         M3lXB2r/tIwiCeIK06Kg+r645OOcb0eMtVT3ymixjZHx+DzkXtXkgPtNES6AnSZ4ZvIb
         EUNvRnLQOM7FvqjgHJh+ACVGB2G+o0hpjjH/lYdsQIlEMUyCODETm5A5Cu6aDOcL/DJf
         brGQ==
X-Gm-Message-State: AOAM532JWSUpGP2RNusSnmT36ftmackulRDcwdkwRGUP4SJEq1dQF6qW
        SusT3fkQJfb6FDZp6uQApDqcr2NY7cntjeUU1TsglWthFFp31N2Hy7vS7iawXoLn3I0GKulPbON
        c2p3xQgRjEktWpAaHZM6s
X-Received: by 2002:a05:6402:27c6:: with SMTP id c6mr10083047ede.152.1635793998502;
        Mon, 01 Nov 2021 12:13:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDCENu1cSGClGlzjt/UWsaSrQ56enERx4L8r0T465qiI6NxwdjP7/jBAJd8SscFR/+sF2cOA==
X-Received: by 2002:a05:6402:27c6:: with SMTP id c6mr10083006ede.152.1635793998301;
        Mon, 01 Nov 2021 12:13:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id dp8sm7563082ejc.83.2021.11.01.12.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 12:13:17 -0700 (PDT)
Message-ID: <81e3cf3e-12d9-46fe-23c3-d5fa95462a67@redhat.com>
Date:   Mon, 1 Nov 2021 20:13:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 0/5] ACPI/power-suppy add fuel-gauge support on cht-wc PMIC
 without USB-PD support devs
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
References: <20211031162428.22368-1-hdegoede@redhat.com>
 <CAHp75VdFcfEyEsFWVS_zxr-aehpqELAwN1eBs-KHVkEwxO2e5Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VdFcfEyEsFWVS_zxr-aehpqELAwN1eBs-KHVkEwxO2e5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 10/31/21 20:49, Andy Shevchenko wrote:
> On Sun, Oct 31, 2021 at 6:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> Together with my earlier series to hookup the charger, Vbus boost converter
>> and USB role-switching:
>> https://lore.kernel.org/platform-driver-x86/20211030182813.116672-1-hdegoede@redhat.com/T/#t
>>
>> This series also adds battery-monitoring support on the Xiaomi Mi Pad 2
>> and the generic parts of it should also be usable on other devices with
>> the same PMIC setup.
>>
>> I've marked this series as a RFC because I'm not happy about the amount of
>> DMI quirks this series requires. The 3 separate quirks in
>> drivers/acpi/x86/utils.c are a bit much, but esp. when combined with also
>> the changes needed in drivers/gpio/gpiolib-acpi.c it all becomes a bit too
>> much special casing for just a single device.
>>
>> So I've been thinking about alternatives for this and I've come up with
>> 3 ways to deal with this:
>>
>> 1. This patch set.
>>
>> 2. Instead of the quirks in drivers/acpi/x86/utils.c, write an old-fashioned
>> "board" .c file/module which autoloads based on a DMI match and manually
>> instantiates i2c-clients for the BQ27520 fuel-gauge and the KTD20260 LED ctrlr.
>> Combined with not giving an IRQ to the fuel-gauge i2c-client (i), this allows
>> completely dropping the gpiolib-acpi.c changes and only requires 1 quirk for
>> the 2nd PWM controller in drivers/acpi/x86/utils.c. As an added bonus this
>> approach will also removes the need to add ACPI enumeration support to the
>> bq27xxx_battery code.
>>
>> 3. While working on this I noticed that the Mi Pad 2 DSDT actually has
>> full ac and battery ACPI code in its DSDT, which Linux was not trying to
>> use because of the Whiskey Cove PMIC ACPI HID in acpi_ac_blacklist[] in
>> drivers/apci/ac.c, resp. a missing _DEP for the ACPI battery.
>>
>> With the native drivers disabled (the default in 5.15-rc7 without patches),
>> both those things fixed and a fix to intel_pmic_regs_handler() in
>> drivers/acpi/pmic/intel_pmic.c, battery monitoring actually starts working
>> somwhat!
>>
>> I say somewhat because changes are not detected until userspace polls
>> the power_supply and switching from charge/device to host mode and
>> back does not work at all. This is due to the AML code for this relying
>> on _AEI ACPI events on virtual GPIOs on the PMIC :|  This means that we
>> would need to reverse engineer which events these virtual GPIO interrupts
>> represent; and then somehow rework the whole MFD + child driver setup
>> to deliver, e.g. extcon/pwrsrc events to a to-be-written GPIO driver
>> which supports these virtual GPIOs, while at the same time also keeping
>> normal native driver support since boards which USB-PD support need the
>> native drivers...  So OTOH this option has the promise of solving this
>> in a generic way which may work on more boards, OTOH it is a big mess
>> and we lack documentation for it.  Interestingly enough the ACPI
>> battery/ac code also takes ownership of the notification LED, downgrading
>> it from a full RGB led to a green charging LED, which is both a pre
>> and a con at the same time (since we would loose full RGB function).
>>
>> ###
> 
>> Although I started out with implementing option 1, I now think I
>> Would personally prefer option 2. This isolates most of the code
>> needed to support some of these special boards into a single
>> (per board) file which can be build as a module which can be
>> autoloaded, rather then growing vmlinuz by adding quirks there.
> 
> Even before reading this my attention was on option 2 as well.

Its good to hear that you think this is likely the best option too.
I hope to send out another RFC patch-series taking this approach
instead soon.

> However, we might give another round of searching the documentation
> for the vGPIO lines.

Having those would be good regardless.

> Meanwhile, have you tried to see if Android tree(s) has(ve) the
> patches related to all this? (I'm a bit sceptical they do the right
> thing and most probably just fall into board files case)

The Android code takes the native driver path, when the EFI firmware
sees it is about to exec Xiaomi's Android bootloader (I think it
checks the signature) it sets OSID = 0x04 which makes all the
ACPI devices which patch 1/5 of this RFC makes "always_present"
return 0xf from their _STA method and it disables the troublesome
_AEI handler too when OSID==4.

So basically it does everything which this RFC series does with
quirks automatically correct based on the OSID. But we cannot
influence this ourselves, there is a BIOS option for it, but
that gets overridden by OS autodetect code at boot.

The fact that the Android on the tablet also goes the use
native charger + fuel-gauge drivers route does to me is a further
hint that using native drivers is probably the right thing to do
(OTOH some of the code in the Android port the device ships with
 is not so great).

Regards,

Hans

