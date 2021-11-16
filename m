Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1233452FD0
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhKPLIx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:08:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234662AbhKPLIE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637060706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbmIBzriyMiidR902JIsFIskMTSm37Jsy4HrcpI1HxQ=;
        b=MTtNDb0Y5Vr++FyvqS3QlHWbaCi64VovjxfIdvo6JaVbkqJZxHOpaWhu1OTgI3pxbyVC8R
        nnWKS36b7CotW+eOxVAEZgGAz6Axg7r19NQkNWCWgeYyxOEcLfZZVgWbqSqtJE3LAjW2c7
        BINPCcgCGk21rp9KhA10vjy1Rcu3tiM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-D3bxLnzjNAaXtRO5vke5rg-1; Tue, 16 Nov 2021 06:05:05 -0500
X-MC-Unique: D3bxLnzjNAaXtRO5vke5rg-1
Received: by mail-ed1-f70.google.com with SMTP id w4-20020aa7cb44000000b003e7c0f7cfffso5093379edt.2
        for <linux-efi@vger.kernel.org>; Tue, 16 Nov 2021 03:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wbmIBzriyMiidR902JIsFIskMTSm37Jsy4HrcpI1HxQ=;
        b=vMphgSYGO7WFG1QDxfkmVfX+SyBhnTUnomRf/tOGPh438f5nABbFj/pjTYI0bxcZ85
         BNsxL3h010+DJ9xE85HNoRgroZQ8PqI9tOsSIJdUmxKOVKMX/dsYdkPXef/sKsPC+FaT
         BKHKW7Bz7j/YukXhX+wSTLsXavK/STl0Ik6CFg/Fu4WAPVyc+7dyzmItyQu9yOOkohhi
         2T/8UUO7DuR7btH4mhsY8AD4UrS+VGeUljMsSZROEf/b1WI8fCUupjO1Tla/x4GY40Nn
         2jZ9gC9Ka+A+yRHjgQaGOHdkUgMTDTis/XFVbQB/iBsDIZCmfXAPkveTwZuQRADw4RFo
         h0vA==
X-Gm-Message-State: AOAM533vSJn7kMgJVJmtlaSq2q3l6UyqWFJ71HCU6DtnTuFYqBs6zmKa
        idzV/vjT7fsBFeLC6L7Q7BUzMcly7gCNDDmXZPpqFzSxgReZHgqgyxLOgJP29cKmIr+VPzmi1Ds
        MPk3hEZQTw/Nl/gqUUP6V
X-Received: by 2002:a17:907:160b:: with SMTP id hb11mr9113618ejc.336.1637060704466;
        Tue, 16 Nov 2021 03:05:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzV6WFQipfuLRwIm3t2+exoHw4xftYYeP1WniIIsmjPL9BrCl5c8f4Sd8heJ8XXEUWJ6Yizg==
X-Received: by 2002:a17:907:160b:: with SMTP id hb11mr9113572ejc.336.1637060704229;
        Tue, 16 Nov 2021 03:05:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m22sm6649409eda.97.2021.11.16.03.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 03:05:03 -0800 (PST)
Message-ID: <684c11bc-3703-1de9-3073-96701405cd2c@redhat.com>
Date:   Tue, 16 Nov 2021 12:05:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 00/20] power-suppy/i2c/extcon: Fix charger setup on
 Xiaomi Mi Pad 2 and Lenovo Yogabook
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
 <CAHp75Vf+0yw8Nb4Lxbf9ukYWw9xPnpy2C0OyaXJ+o5xsamP4qA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75Vf+0yw8Nb4Lxbf9ukYWw9xPnpy2C0OyaXJ+o5xsamP4qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11/16/21 12:00, Andy Shevchenko wrote:
> On Sun, Nov 14, 2021 at 7:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> This is version 2 of my series previously titled:
>> "[PATCH 00/13] power-suppy/i2c/extcon: Add support for cht-wc PMIC
>> without USB-PD support".
>>
>> So far almost all the kernel code surrounding the Cherry Trail Whiskey Cove
>> PMIC has been developed on the GPD win / pocket devices and it has various
>> assumption based on that. In the mean time I've learned (and gotten access
>> to) about 2 more designs and none of the 3 now known designs use a single
>> standard setup for the charger, fuel-gauge and other chips surrounding the
>> PMIC / charging+data USB port:
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
>>
>> ###
>>
>> Unlike what is normal on X86 this diversity in designs is not handled /
>> abstracted away by the ACPI tables.
> 
> I will briefly look into it, right now two observations (or nit-picks):

Thank you.

> - you may utilize Co-developed-by tag when it makes sense

Right, I intended to do so in patch 13/20, but I now see that I
somehow forgot that :)

> - I would rather see "x86/ACPI" in all texts (note small "x")

Ack.

Regards,

Hans

