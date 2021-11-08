Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2E14498AB
	for <lists+linux-efi@lfdr.de>; Mon,  8 Nov 2021 16:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbhKHPq5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Nov 2021 10:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241055AbhKHPq5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Nov 2021 10:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636386252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2RyU8qhSeZit5hKsiu2hQbRUAvUK+e+McPaAjHTnw30=;
        b=HS6x5FyGQQVlFuQGME6P34WvESt32V2oisiWSOpoMV/PAyCf+0SqzxF9nTz0hteXflCb1c
        mGXG9s4JQcm/Lf9krUchKvOOswr41RRqe/Mf9oPHrvikOZUV7y/AqI8Wkmw8bS+arxBM4T
        EmjPUDugHiNcrflsXVgZ+8/T1J4VXqM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-HKK1WGJsPn6iWIlErii02g-1; Mon, 08 Nov 2021 10:44:11 -0500
X-MC-Unique: HKK1WGJsPn6iWIlErii02g-1
Received: by mail-ed1-f72.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so15173770edx.15
        for <linux-efi@vger.kernel.org>; Mon, 08 Nov 2021 07:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2RyU8qhSeZit5hKsiu2hQbRUAvUK+e+McPaAjHTnw30=;
        b=8E1+zjiebeE5Z0APae5ZCDuzlCA6IPb7xTKVievqRgUEwp38rJT1z7K/4vZCbpt2lC
         Euq/gET36zvy9wFUkRkClRGNGWMWHqPX1Nae2fAG5bRS+X0mOzBq8Jx4DQ1IfrMzjuU1
         nCco66mLRtaKLwEvISUTFVhSyQ2er4fHXxG0jNe3W1lBkPBFpFEyNCVoGt6mOcfwunN8
         BNv6HrvNhqQLTlMJRepTOFVCfDPyK+o6A6D5fJxUqJ8Q+OLHPzkvkEBfwAoH7JM3DXdU
         q3kTBuY0ZziBzKW6YdSqy9ZIF+2FpwN/vj750SjtN4TcQVgQycwEbwrddCSo8j9HckhC
         ZSdA==
X-Gm-Message-State: AOAM532NrmgGM72bk/7IFTu4v52OZksjEr3OvPCxgJoLhxKx9mUrCvY+
        pe6AeBgtK9KqTYAXwQRxd38gSOjHuWDeBbsZWyrg5FaX1XF76ANnAkpoFNPofepIjyavarOgC5k
        fXL1kVKWcfOeFRY5cR4Ca
X-Received: by 2002:a17:906:2c16:: with SMTP id e22mr215021ejh.501.1636386250058;
        Mon, 08 Nov 2021 07:44:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlq0HQMHgB4Zj6dSwUyUqA2pyHOS5wXAZQanD1ylnLhmhVrP+t0k2sXvtMwqypw3DeXs0uyg==
X-Received: by 2002:a17:906:2c16:: with SMTP id e22mr214996ejh.501.1636386249907;
        Mon, 08 Nov 2021 07:44:09 -0800 (PST)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id sd28sm9076804ejc.37.2021.11.08.07.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 07:44:09 -0800 (PST)
Message-ID: <0b27cd90-3174-01f5-359c-be0c2e094fc8@redhat.com>
Date:   Mon, 8 Nov 2021 16:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 13/13] extcon: intel-cht-wc: Add support for devices with
 an USB-micro-B connector
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-14-hdegoede@redhat.com>
 <CAHp75VfRALjbGaY8rdt5HCte3_NPuwpdkr+GNZV7qMWBK1idWg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VfRALjbGaY8rdt5HCte3_NPuwpdkr+GNZV7qMWBK1idWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 10/31/21 13:52, Andy Shevchenko wrote:
> On Sat, Oct 30, 2021 at 9:29 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> So far the extcon-intel-cht-wc code has only been tested on devices with
>> a Type-C connector with USB-PD, USB3 (superspeed) and DP-altmode support
>> through a FUSB302 Type-C controller.
>>
>> Some devices with the intel-cht-wc PMIC however come with an USB-micro-B
>> connector, or an USB-2 only Type-C connector without USB-PD.
>>
>> These device are identified by "intel,cht-wc-setup" = "bq25890,bq27520",
>> since there is no Type-C controller on these devices the extcon code must
>> control the Vbus 5V boost converter and the USB role switch depending on
>> the detected cable-type.
> 
> ...
> 
>> +       if (ext->vbus_boost && ext->vbus_boost_enabled != enable) {
>> +               if (enable)
>> +                       ret = regulator_enable(ext->vbus_boost);
>> +               else
>> +                       ret = regulator_disable(ext->vbus_boost);
> 
>> +               if (ret == 0)
>> +                       ext->vbus_boost_enabled = enable;
>> +               else
>> +                       dev_err(ext->dev, "Error updating Vbus boost regulator: %d\n", ret);
> 
> if (ret)
>  dev_err()
> else
>  ...
> 
> ?

When doing if-else branches around an error code I always put the success
handling in the if branch and have the else branch deal with the error
to me that feels as the most natural way to do it the error is the exception
and thus the "else"

> 
>> +       }
> 
> ...
> 
> 
>> +               /*
>> +                * Classic micro USB-B setup, this requires controling
> 
> controlling

Fixed for the next version.

Thanks & Regards,

Hans


> 
>> +                * the role-sw and vbus based on the id-pin.
>> +                */
> 

