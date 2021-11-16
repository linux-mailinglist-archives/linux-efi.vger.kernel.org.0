Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB72E45315D
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhKPLya (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235574AbhKPLyV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637063481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AhivTIOpjPA1rMsW7/cjbVF1w7BJWhc6FOerNF9l7U0=;
        b=GJWZpPwWHkBU8xKekviNdtSwc/zNvzoBOxH3ij8nPb8NiXZBJvB83iz5JLBrQ+ViSljWBb
        fSlbSIjl+wwauqQlKdAXRIUwCzQIXUe9AqhR57PxX6/MvjkeY9js35puWtBMqu1EXuRn1e
        zXv8NfDTLyWHLmahav4KSvYwHL8uYSc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-zqh9qajwOUC_NlYCVx5Y7w-1; Tue, 16 Nov 2021 06:51:20 -0500
X-MC-Unique: zqh9qajwOUC_NlYCVx5Y7w-1
Received: by mail-ed1-f71.google.com with SMTP id w4-20020aa7cb44000000b003e7c0f7cfffso5189840edt.2
        for <linux-efi@vger.kernel.org>; Tue, 16 Nov 2021 03:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AhivTIOpjPA1rMsW7/cjbVF1w7BJWhc6FOerNF9l7U0=;
        b=YT0ofUcy6D8xc9ak9992ZwxwxGp1T43O7mt3MXaKD6e6eaPOfW5ASCyXOrJ/aOtv4S
         Y0g0LZLHuMfOrfLyHNsDv3cztzU1MC6gS5gt2c/4Yw8+cIL69zOdg6YNpt8vO0FBCfS5
         jr3a0SEyVe6amvRScIGgj4/ipwn4jFHV3U76o4VeNww0FVrQrXbfZqRdq3b3IIh7LTeo
         fMqT8o+pG2KXIQRD18ypRvXHjKVlwYsmljT3piEDYzDPTUUDyTgjdaP27eu6jgsFqMQj
         E2GGblDEdOk4k3cHr5iec1SxkqT5m7d+1AJ39ddbbdipX11Ro7T1RhG/tSO5KCaeoJom
         KAAw==
X-Gm-Message-State: AOAM530tYwWCodd/yotLDLzOv4KwVtlsgfBadsqMTCb6WNYcYddLzbRs
        cm7wZOhwJKgzVtUYtSB3WJtvimBr1Ci1yEePQimSj8iacc0J0Q8bNVk72rcm8ZkPalBr90MZ1ST
        iaqhUbxZ2GS9EG3rHQqLc
X-Received: by 2002:a50:da06:: with SMTP id z6mr9515614edj.50.1637063479404;
        Tue, 16 Nov 2021 03:51:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziWnZi0A7YtidAFr8ClW2EWX17vgnSRICyshdZ6kN7QttTEebqs+HGy0b0miUzYX8l1w2ccA==
X-Received: by 2002:a50:da06:: with SMTP id z6mr9515577edj.50.1637063479254;
        Tue, 16 Nov 2021 03:51:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h10sm6076957edr.95.2021.11.16.03.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 03:51:18 -0800 (PST)
Message-ID: <d5679e3a-7500-7b6b-5421-441de306afb7@redhat.com>
Date:   Tue, 16 Nov 2021 12:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 17/20] extcon: intel-cht-wc: Support devs with Micro-B
 / USB-2 only Type-C connectors
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
 <20211114170335.66994-18-hdegoede@redhat.com>
 <CAHp75VdXSdhNtPwNdpssnmt+sZb+ZoAUm-cKJu-PqymmHMOpRw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VdXSdhNtPwNdpssnmt+sZb+ZoAUm-cKJu-PqymmHMOpRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11/16/21 12:28, Andy Shevchenko wrote:
> On Sun, Nov 14, 2021 at 7:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> So far the extcon-intel-cht-wc code has only been tested on devices with
>> a Type-C connector with USB-PD, USB3 (superspeed) and DP-altmode support
>> through a FUSB302 Type-C controller.
>>
>> Some devices with the intel-cht-wc PMIC however come with an USB-micro-B
>> connector, or an USB-2 only Type-C connector without USB-PD.
>>
>> Which device-model we are running on can be identified with the new
>> intel_cht_wc_get_model() helper and on models without a Type-C controller
>> the extcon code must control the Vbus 5V boost converter and the USB role
>> switch depending on the detected cable-type.
> 
> ...
> 
>>  config EXTCON_INTEL_CHT_WC
>>         tristate "Intel Cherrytrail Whiskey Cove PMIC extcon driver"
>> -       depends on INTEL_SOC_PMIC_CHTWC
> 
>> +       depends on INTEL_SOC_PMIC_CHTWC && USB_SUPPORT
> 
> Having these two in one expression sounds a bit alogical to me, can
> you just add a separate "depends on"?

Sure.

> 
>> +       select USB_ROLE_SWITCH
> 
> ...
> 
>> +       if (ext->vbus_boost && ext->vbus_boost_enabled != enable) {
>> +               if (enable)
>> +                       ret = regulator_enable(ext->vbus_boost);
>> +               else
>> +                       ret = regulator_disable(ext->vbus_boost);
> 
> Redundant blank line here (but it's up to you)
> 
>> +               if (ret == 0)
>> +                       ext->vbus_boost_enabled = enable;
>> +               else
>> +                       dev_err(ext->dev, "Error updating Vbus boost regulator: %d\n", ret);
> 
> Why not a traditional pattern, i.e. error handling first?

As I've mentioned before (to a very similar remark) error handling
first is not the traditional pattern, at least not for me.

Traditionally (to me) the else case is the error case. This
is just how humans work. E.g. if I need help for something
saying something like:

"If you have time can you help me with this please? Otherwise
I'm afraid that I am never going to solve this."

Feels natural, where as saying it like this:

"If you do not have time I'm afraid I am never going to solve
this, otherwise can you help me with this please ?"

Feels quite unnatural, at least to me.

>> +       }
> 
> ...
> 
>> +/* Some boards require controlling the role-sw and vbus based on the id-pin */
> 
> Vbus ? VBUS? Here and there the inconsistency of some terms...

"Vbus", I'll try to fix this up everywhere.

Regards,

Hans

