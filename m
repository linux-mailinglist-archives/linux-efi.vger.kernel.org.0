Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD946AADB
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 22:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353452AbhLFVuR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 16:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353403AbhLFVuP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 16:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638827205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XD7Nb7Clb95GARwOtJlUClbhUySnCjxtvaRAf+MfT8g=;
        b=eeHNXCS5U012FeAbEIT6fKQLYgBI76AZkKF0GIEwXwvtD4huTC6w2ZruAhSMKt4KhOgUX+
        iA6K2Vt3+i85RIqtDBj8uIC+L6WeWHXUWYdk6XT7i8lK+jU/5qezqRazXLCN0ve5Cbni6b
        RAgN2iRsEm20b71JX/tq/rCJwv5A6L4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-jNNXnZa-MqO7EqgIDOrYpg-1; Mon, 06 Dec 2021 16:46:44 -0500
X-MC-Unique: jNNXnZa-MqO7EqgIDOrYpg-1
Received: by mail-ed1-f72.google.com with SMTP id v10-20020aa7d9ca000000b003e7bed57968so9431893eds.23
        for <linux-efi@vger.kernel.org>; Mon, 06 Dec 2021 13:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XD7Nb7Clb95GARwOtJlUClbhUySnCjxtvaRAf+MfT8g=;
        b=yVIZqc9JuHicozRsXeq/h0gnallozEQgdU6aL3zW4BI1tpZnb25bSR6BXJJUoXkhG8
         i+m1QcYtJcW64EuoT9fSioIzT+ABVapv1Zy7mAIDJMz+U5N9dZvJGO2x5lwpYHJw7h7Y
         hBHiXewNpzgpgak5lLm0n+295n0TSZ2a5tZ/ttlVLCiXaBNLPkvHMBpF1v7bu3ClgWJ9
         yW3FnnO69oayOtgv0SxyU8mFz3excXQxgfZD/X522JRke96qsaAkUEXb0mqOQ8tURWzI
         CB0e9vVDC8iUdcYTtGUBeCoAu34TAPcPDzwUOpl2LNzw9o74g8R/NKUrQjKfH/z2hYwy
         yBQA==
X-Gm-Message-State: AOAM5332ib1TmwYnx0pl/QfZ7RVnkwSCYlpzj9s54cd3EoX2BmekQEte
        RFbx4T9fp7Q3Dbfag9EOSbFJQ2KdzOV7lxyt/2eglQY0gVvfboQgypWsSwQI/WT5MUHSNkQYPUx
        YktsIB35UmBanzaFIjefC
X-Received: by 2002:a17:906:4787:: with SMTP id cw7mr51624544ejc.311.1638827203290;
        Mon, 06 Dec 2021 13:46:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4f2WW8YPhyWFg5/uoyC3KUk6k0aakXD8ww8CSE0oZjb95JLyqnZj9joGInxQhM8NA1Ex+gQ==
X-Received: by 2002:a17:906:4787:: with SMTP id cw7mr51624512ejc.311.1638827202988;
        Mon, 06 Dec 2021 13:46:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id j14sm9301207edw.96.2021.12.06.13.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 13:46:42 -0800 (PST)
Message-ID: <94738e2d-8b8d-08a0-be39-343ac275fa5f@redhat.com>
Date:   Mon, 6 Dec 2021 22:46:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 14/20] mfd: intel_soc_pmic_chtwc: Add cht_wc_model data
 to struct intel_soc_pmic
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
References: <20211206093318.45214-1-hdegoede@redhat.com>
 <20211206093318.45214-15-hdegoede@redhat.com>
 <CAHp75Vc+z0nqUXbqrX9YXi2+rzz4BKT7maFipyB8QgOEKQ9SPw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75Vc+z0nqUXbqrX9YXi2+rzz4BKT7maFipyB8QgOEKQ9SPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 12/6/21 20:55, Andy Shevchenko wrote:
> On Mon, Dec 6, 2021 at 11:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Tablet / laptop designs using an Intel Cherry Trail x86 main SoC with
>> an Intel Whiskey Cove PMIC do not use a single standard setup for
>> the charger, fuel-gauge and other chips surrounding the PMIC /
>> charging+data USB port.
>>
>> Unlike what is normal on x86 this diversity in designs is not handled
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
>> running on in each MFD-cell driver, add a check for this to the
>> shared drivers/mfd/intel_soc_pmic_chtwc.c code by using a
>> DMI table for all 3 known models:
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
>> +enum intel_cht_wc_models {
>> +       INTEL_CHT_WC_UNKNOWN,
>> +       INTEL_CHT_WC_GPD_WIN_POCKET,
>> +       INTEL_CHT_WC_XIAOMI_MIPAD2,
>> +       INTEL_CHT_WC_LENOVO_YOGABOOK1,
>> +};
> 
> ...
> 
>> +       enum intel_cht_wc_models cht_wc_model;
> 
> I'm wondering what will you do when something similar will be needed
> for another PMIC?
> 
> I see possible solutions to eliminate additional churn:
> - make just one enum for all models (can be done now, can be renamed later)
> - make a union if we have such situation
> 
> because I wouldn't like to have another field for each possible
> variant of PMIC in the generic structure.
> 
> Hence the question, does it make sense to just name it (enum and
> member) less cht_wc oriented?

I agree that renaming these to make them generic makes sense if we get a
second user (which I doubt, but you never know). For now I would like to
keep this as is though, this is a big series and I would like to avoid
to respin it just for this and we can always rename this later.

If I need to do a v5 anyways though, then I'll do the rename for v5.

Regards,

Hans

