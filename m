Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19745311A
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhKPLrn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:47:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235135AbhKPLqr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637063030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vRsoxvevCyhGVLcNeM2T5rbQ+V+SV53ugMJAEKfPsM=;
        b=d4Stmr/lKZKcwUcZh/BWNgiVwPLQUgE+zkt6s0WW3NrwhsapVjawsq7JOdF+ZZwlZ24l0e
        HOnkd/c6CGfDi5OWOW+tVK+bwSGbEDfDRa7Ano5tyyTATZdicQX/GQajpu6v/aHVR+ksjR
        ZM5aE7pJKMzPVAiFp9o4LxPKvtiBhdU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-DTE7Op-XPxqlwVHu0MG7Hw-1; Tue, 16 Nov 2021 06:43:49 -0500
X-MC-Unique: DTE7Op-XPxqlwVHu0MG7Hw-1
Received: by mail-ed1-f72.google.com with SMTP id v10-20020aa7d9ca000000b003e7bed57968so5693417eds.23
        for <linux-efi@vger.kernel.org>; Tue, 16 Nov 2021 03:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4vRsoxvevCyhGVLcNeM2T5rbQ+V+SV53ugMJAEKfPsM=;
        b=LPnB5eeWmCkyIqod58TNLZrNBRXlIPuwqBQlUwsQDqIIdRMN3lS4LF9kiKaLWjgion
         +Q+6yYzMNck1WvLMe/kP+/Fx32lHcD/x+UET70+7SlCRFWqkrmtJSkTIfbLcPp96Veip
         LXB5lAGX+EK2qs6YNMTB+QUWQ3Zb1HkbWNuWyEiKtVSY6qBXr5IbI6kJtR8+JLZiW4O0
         6au+/EXlaIugKnVa7NVhoz65RNgU1VxA+wsXo2bmlEuONv5M2r8sJwub/pVYNb0R47/G
         5IPmHvlbpAowt2zjzmvx0XayG1B9Cb809UMWy5vm+a/FCxeiMNJdV0ZFpG4zkJM+g51Y
         McNw==
X-Gm-Message-State: AOAM532JJsDz11sAZszq88xu1LEwD4kqy/fvyJyJ5LjBfXKUy0XOkuSQ
        BkBGqoFhtOZjZddEUWmpNeWmpjchq9ipASUNyalsEJqoU9uF8VF7eHRXmdMxoVr4fwDCjQzzPlE
        AzqfbhbGE1cCExG5YxJV8
X-Received: by 2002:a17:907:7f18:: with SMTP id qf24mr8846499ejc.568.1637063028299;
        Tue, 16 Nov 2021 03:43:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxorjzDWIRAmEbvRgvpElkTkwaACQCtFfD0c4lURehHQt9+yRF5Gj7Kuw1B1DdECgMRMVOBtQ==
X-Received: by 2002:a17:907:7f18:: with SMTP id qf24mr8846477ejc.568.1637063028124;
        Tue, 16 Nov 2021 03:43:48 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ig1sm7877234ejc.77.2021.11.16.03.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 03:43:47 -0800 (PST)
Message-ID: <4e424077-6a7f-a86f-9c89-74a2028401c6@redhat.com>
Date:   Tue, 16 Nov 2021 12:43:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 14/20] mfd: intel_soc_pmic_chtwc: Add
 intel_cht_wc_get_model() helper function
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
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-15-hdegoede@redhat.com>
 <CAHp75Ve=UkSF_fTjJSkAKgxV3hdzGbT5Hqzxi0ACu-Q-=rF3Qw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75Ve=UkSF_fTjJSkAKgxV3hdzGbT5Hqzxi0ACu-Q-=rF3Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11/16/21 12:18, Andy Shevchenko wrote:
> On Sun, Nov 14, 2021 at 7:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Tablet / laptop designs using an Intel Cherry Trail x86 main SoC with
>> an Intel Whiskey Cove PMIC do not use a single standard setup for
> 
> does not
> 
>> the charger, fuel-gauge and other chips surrounding the PMIC /
>> charging+data USB port.
>>
>> Unlike what is normal on X86 this diversity in designs is not handled
>> by the ACPI tables. On 2 of the 3 known designs there are no standard
>> (PNP0C0A) ACPI battery devices and on the 3th design the ACPI battery
>> device does not work under Linux due to it requiring non-standard
>> and undocumented ACPI behavior.
>>
>> So to make things work under Linux we use native charger and fuel-gauge
>> drivers on these devices, re-using the native drivers used on ARM boards
>> with the same charger / fuel-gauge ICs.
>>
>> This requires various MFD-cell drivers for the CHT-WC PMIC cells to
>> know which model they are exactly running on so that they can e.g.
>> instantiate an I2C-client for the right model charger-IC (the charger
>> is connected to an I2C-controller which is part of the PMIC).
>>
>> Rather then duplicating DMI-id matching to check which model we are
>> running on in each MFD-cell driver add a helper function for this
>> and make this id all 3 known models:
>>
>> 1. The GPD Win and GPD Pocket mini-laptops, these are really 2 models
>> but the Pocket re-uses the GPD Win's design in a different housing:
>>
>> The WC PMIC is connected to a TI BQ24292i charger, paired with
>> a Maxim MAX17047 fuelgauge + a FUSB302 USB Type-C Controller +
>> a PI3USB30532 USB switch, for a fully functional Type-C port.
>>
>> 2. The Xiaomi Mi Pad 2:
>>
>> The WC PMIC is connected to a TI BQ25890 charger, paired with
>> a TI BQ27520 fuelgauge, using the TI BQ25890 for BC1.2 charger type
>> detection, for a USB-2 only Type-C port without PD.
>>
>> 3. The Lenovo Yoga Book YB1-X90 / Lenovo Yoga Book YB1-X91 series:
>>
>> The WC PMIC is connected to a TI BQ25892 charger, paired with
>> a TI BQ27542 fuelgauge, using the WC PMIC for BC1.2 charger type
>> detection and using the BQ25892's Mediatek Pump Express+ (1.0)
>> support to enable charging with up to 12V through a micro-USB port.
> 
> ...
> 
>> +               /*
>> +                * Note this may not seem like a very unique match, but in the
>> +                * 24000+ DMI decode dumps from linux-hardware.org only 42 have
> 
> Can you add https:// (or is it gopher? :)

linux-hardware.org is intended here as an identifier of the projects, not an
URL. The DMI decode database lives here:

https://github.com/linuxhw/DMI.git

But I don't believe that adding the exact URL in the comment is important,
esp. since that may change over time.

> 
>> +                * a board_vendor value of "AMI Corporation" and of those 42
>> +                * only 1 (the GPD win/pocket entry) has a board_name of
>> +                * "Default string". Also very few devices have both board_ and
>> +                * product_name not set.
>> +                */
> 
> ...
> 
>> +enum intel_cht_wc_models intel_cht_wc_get_model(void)
>> +{
>> +       const struct dmi_system_id *id;
>> +
>> +       id = dmi_first_match(cht_wc_model_dmi_ids);
>> +       if (!id)
>> +               return INTEL_CHT_WC_UNKNOWN;
>> +
>> +       return (long)id->driver_data;
> 
> Why not proper casting, i.e. (enum intel_...)?

Because sizeof(enum) != sizeof(void *) so then the compiler will
complain. Where as sizeof(long) == sizeof(void *)

> 
>> +}
>> +EXPORT_SYMBOL_GPL(intel_cht_wc_get_model);
> 
> Are you planning to use EXPORT_SYMBOL_GPL_NS()? If not, please consider it.

No I was not planning on this and it seems overkill for just a single
exported symbol.

Regards,

Hans

