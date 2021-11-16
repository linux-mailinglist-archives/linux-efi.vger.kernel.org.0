Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CB1453106
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhKPLnx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:43:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235605AbhKPLn1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637062829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2yhddqwOIyYZPL3FhXeGjYy0DQgznm+v+3hij7ERdE=;
        b=NVaV+fApsyINJgLaHkxx3KOlDh/E0PX8Ak4LCme/X5Q0drbuR+uhbu1DgG86EZznxixv3e
        SZ9fb78uBBXHSNf+ip5VF+o3ru2PQo4HyRklxHpiYnxq4jNZrOGhpx1L8vBvbTCo4lajGf
        9WS5mt0H58jt1rI3ogMhh/8TpLb5xcE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-DTVd_68OO1W4QJVg3bB7JQ-1; Tue, 16 Nov 2021 06:40:28 -0500
X-MC-Unique: DTVd_68OO1W4QJVg3bB7JQ-1
Received: by mail-ed1-f72.google.com with SMTP id d13-20020a056402516d00b003e7e67a8f93so1101103ede.0
        for <linux-efi@vger.kernel.org>; Tue, 16 Nov 2021 03:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q2yhddqwOIyYZPL3FhXeGjYy0DQgznm+v+3hij7ERdE=;
        b=bMwiazRkaUh6bgYATojDlPH6ZR+VHUdVI7AQgY4Qoxw7PRUeLbHn9YNF8/lHJEpIbv
         9E4aK7/ZKqxlEIL8Ns4NoQ4ewBHljfz4Uy/PCZ6sUjDiqmkjZwp5MBfNlz60fVZEm8OM
         4cPy8v5h5aPztpjvPhkyd3zpUvCko5EFI7kD/JBMBfhFHYGZ0Agp/LCChnfYLGQR5vKD
         AsowCZDOYPPHOufP+It3hFgaVdMkVsKWskTXei64NqD0Kuv9kK6dYGeiBqUAZ2LULczT
         ODeYEI144DFskf1gs2VrRX+cxCqf40u37Fb062Tdy/MMKL86uwgAyBsbI51OpUSIu9tO
         CQIg==
X-Gm-Message-State: AOAM532rc3GjWtAkYMa+7wisfB/E4TtZG6xynmttrXvGrcBJmXn62wdf
        gendoUqA2zhz2AtZboILnYXTtWVh94HxsSKC7dpd+DUGKSHsk2tF2RjXxd8Ty9X6lyEBOAu2OEQ
        DrGDQdvURSSltnlZdI6Sf
X-Received: by 2002:a50:bf01:: with SMTP id f1mr9257998edk.102.1637062827601;
        Tue, 16 Nov 2021 03:40:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymU6yKouEKafBLdercgexA8Y6Lq4DD1sfYwW1qjfS7Zl1Y82tULN5DbCIDyJTLShnlIyoCVQ==
X-Received: by 2002:a50:bf01:: with SMTP id f1mr9257958edk.102.1637062827380;
        Tue, 16 Nov 2021 03:40:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gs17sm8188492ejc.28.2021.11.16.03.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 03:40:26 -0800 (PST)
Message-ID: <b592e94f-5bff-0f9e-7297-94f7ad646fb7@redhat.com>
Date:   Tue, 16 Nov 2021 12:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 13/20] power: supply: bq25890: Support higher charging
 voltages through Pump Express+ protocol
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
 <20211114170335.66994-14-hdegoede@redhat.com>
 <CAHp75VceeV634BPm4X8vgKCFG7CFSnApPrB-uxG8-F+hgXXMvA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VceeV634BPm4X8vgKCFG7CFSnApPrB-uxG8-F+hgXXMvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11/16/21 12:14, Andy Shevchenko wrote:
> On Sun, Nov 14, 2021 at 7:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> From: Yauhen Kharuzhy <jekhor@gmail.com>
>>
>> Add a "linux,pump-express-vbus-max" property which indicates if the Pump
>> Express+ protocol should be used to increase the charging protocol.
>>
>> If this new property is set and a DCP charger is detected then request
>> a higher charging voltage through the Pump Express+ protocol.
>>
>> So far this new property is only used on X86/ACPI (non devicetree) devs,
>> IOW it is not used in actual devicetree files. The devicetree-bindings
>> maintainers have requested properties like these to not be added to the
>> devicetree-bindings, so the new property is deliberately not added
>> to the existing devicetree-bindings.
>>
>> Changes by Hans de Goede:
>> - Port to my bq25890 patch-series + various cleanups
>> - Make behavior configurable through a new "linux,pump-express-vbus-max"
>>   device-property
>> - Sleep 1 second before re-checking the Vbus voltage after requesting
>>   it to be raised, to ensure that the ADC has time to sampled the new Vbus
>> - Add VBUSV bq25890_tables[] entry and use it in bq25890_get_vbus_voltage()
>> - Tweak commit message
> 
> ...
> 
>> +#define PUMP_EXPRESS_START_DELAY       (5 * HZ)
>> +#define PUMP_EXPRESS_MAX_TRIES         6
>> +#define PUMP_EXPRESS_VBUS_MARGIN       1000000
> 
> Units? Perhaps "_uV"?
> 
> ...
> 
>> +               dev_dbg(bq->dev, "input voltage = %d mV\n", voltage);
> 
> Just to be sure, is it indeed "mV" and not "uV"?

It is uV, will fix for the next version.

> 
> ...
> 
>> +               while (bq25890_field_read(bq, F_PUMPX_UP) == 1)
>> +                       msleep(100);
> 
> Infinite loop?
> 
> Sounds like a good candidate to switch to read_poll_timeout() // note> it accepts any type of (op) with a variadic number of args.

Good catch, will fix.

> 
> ...
> 
>> +error:
> 
> error_print: ?
> 
>> +       dev_err(bq->dev, "Failed to request hi-voltage charging\n");
> 
> ...
> 
>> +       ret = device_property_read_u32(bq->dev, "linux,pump-express-vbus-max",
>> +                                      &bq->pump_express_vbus_max);
>> +       if (ret < 0)
>> +               bq->pump_express_vbus_max = 0;
> 
> Isn't it 0 by default?
> 
> Anyway, for all optional properties one may use
> 
> bq->...property... = $default;
> device_property_read_u32(bq->dev, "linux,...property...", &bq->...property...);
> 
> I.e. no conditional needed.

Ack, will fix.

Regards,

Hans

