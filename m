Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D674A4A6D
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 16:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359325AbiAaPVn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 10:21:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241337AbiAaPVm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jan 2022 10:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643642502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdfkzDy8NOhTBqtuHXtxmiymZAS5QYBSRJm2QyyoNdY=;
        b=Dom73B6F2YvZhSL4LhX6bZQZnRfbZUq5psB7lXBMbkm4eKPLWrvnrQYVSLUMhXvPdTXBqx
        R8r/R43x33kJRn5Hkk7sVDoFkpRe38C7DdiaOjSOGep7LTJN//tt6i/6qoUwfQ7IzIAxyJ
        1qLEMg1jbDbCXToqLsepUVgWRsoQ7HQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-dHI_1f2yOVmIyh-2nVU86A-1; Mon, 31 Jan 2022 10:21:40 -0500
X-MC-Unique: dHI_1f2yOVmIyh-2nVU86A-1
Received: by mail-ed1-f70.google.com with SMTP id n7-20020a05640205c700b0040b7be76147so2610138edx.10
        for <linux-efi@vger.kernel.org>; Mon, 31 Jan 2022 07:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MdfkzDy8NOhTBqtuHXtxmiymZAS5QYBSRJm2QyyoNdY=;
        b=TubQInG3c+zRFJ7ePbziy7AHF7hVZEpNq/sLouQzAJ2AqBFoYLQ7yZMoiqX5Ph+yKi
         YD/nhdl34gDMD9UoiXc4Dpflc2xslrFBflVZVKcej8u0P6x6LSs0sDyJ8ANnZessAare
         xff1CswQ+qORiwVy5+V2svkK0VX1shWmfbkjKoiZUo2jzXzEgdR5p4B1cAo/6SdU7qAU
         fndgNqny3bXkJlU2Ulo05zuEa4UAjnpFdHEBW6ZJZzKJmC0DH5YWqTqRciu9oyiMuiFB
         Vnz7einBnQU3W+U+HIbIQykN52bFdpcfFiQHAwW6QjQOM1UVmAbDa0U1UY3+8SUV3ivD
         4aWQ==
X-Gm-Message-State: AOAM530aph5caWVd0S7JkF7xs0aJS6kikhx21ZBV0rlMaVeU5yMaND4H
        BfHF1izyVE0WgvG2P//hDcKOfe5jJnblq25dLXGoDRC9k4PP8uRIlZfeXPFKsCxxDBvx/J7eSeU
        e+n24s4/iqHHYl/D8NiuN
X-Received: by 2002:a17:906:4781:: with SMTP id cw1mr17627274ejc.264.1643642499341;
        Mon, 31 Jan 2022 07:21:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzL6ut6uoXdZKf0ORkBSmscT1UsWg0LyIbjDV6wxHssSTU4bpAYPSIeeR88zu/rPpO0EsoiQg==
X-Received: by 2002:a17:906:4781:: with SMTP id cw1mr17627255ejc.264.1643642499185;
        Mon, 31 Jan 2022 07:21:39 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id j26sm9941299edt.65.2022.01.31.07.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 07:21:38 -0800 (PST)
Message-ID: <48dad73d-7632-3367-98f7-98f7739d0c21@redhat.com>
Date:   Mon, 31 Jan 2022 16:21:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 17/20] extcon: intel-cht-wc: Support devs with Micro-B
 / USB-2 only Type-C connectors
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
References: <20220130204557.15662-1-hdegoede@redhat.com>
 <20220130204557.15662-18-hdegoede@redhat.com>
 <YffqAchYMoSVqMTz@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YffqAchYMoSVqMTz@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 1/31/22 14:54, Andy Shevchenko wrote:
> On Sun, Jan 30, 2022 at 09:45:54PM +0100, Hans de Goede wrote:
>> So far the extcon-intel-cht-wc code has only been tested on devices with
>> a Type-C connector with USB-PD, USB3 (superspeed) and DP-altmode support
>> through a FUSB302 Type-C controller.
>>
>> Some devices with the intel-cht-wc PMIC however come with an USB-micro-B
>> connector, or an USB-2 only Type-C connector without USB-PD.
>>
>> Which device-model we are running on can be identified with the new
>> cht_wc_model intel_soc_pmic field. On models without a Type-C controller
>> the extcon code must control the Vbus 5V boost converter and the USB role
>> switch depending on the detected cable-type.
> 
> ...
> 
>> +	if (ext->vbus_boost && ext->vbus_boost_enabled != enable) {
>> +		if (enable)
>> +			ret = regulator_enable(ext->vbus_boost);
>> +		else
>> +			ret = regulator_disable(ext->vbus_boost);
> 
>> +		if (ret == 0)
>> +			ext->vbus_boost_enabled = enable;
>> +		else
>> +			dev_err(ext->dev, "Error updating Vbus boost regulator: %d\n", ret);
> 
> Can we go with
> 
> 		if (ret)
> 			dev_err(ext->dev, "Error updating Vbus boost regulator: %d\n", ret);
> 		else
> 			ext->vbus_boost_enabled = enable;
> 
> ?

Ack, fixed for v5.

Regards,

Hans

