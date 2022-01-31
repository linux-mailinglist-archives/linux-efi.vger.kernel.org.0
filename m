Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B844A4A75
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379356AbiAaPWY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 10:22:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359126AbiAaPWY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jan 2022 10:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643642543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1yKKyQNpn9GQvDG3vl3rth1pSqIt5HzIp/zlMMSE9sc=;
        b=gkDuW+PDl98uqK3247Xom9PCsBzQsDpCNwF4QDpxW8a6/UNWt2P8kejstDYspP+YGu9ful
        /XBFPaiIxQbIieQYIdFbEPPHbodWNpa2FYQ/ajpWgSCWJWvXgNc1QewVwTL1bH/OxDuYze
        qCYhneT1alD0lY4NfhM9hsw2k1P6Bt0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-Hc0hoYOjNJaPoplYkzAJ2Q-1; Mon, 31 Jan 2022 10:22:22 -0500
X-MC-Unique: Hc0hoYOjNJaPoplYkzAJ2Q-1
Received: by mail-ed1-f69.google.com with SMTP id i22-20020a0564020f1600b00407b56326a2so7133224eda.18
        for <linux-efi@vger.kernel.org>; Mon, 31 Jan 2022 07:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1yKKyQNpn9GQvDG3vl3rth1pSqIt5HzIp/zlMMSE9sc=;
        b=jNmjSIVrwYIlsRt23YJFKxes23yxSkmEWR3KMWYZ00fhL8iA+kQvuDh6v1FEe8+/gn
         9rc4IzSDkQPJbLgtlrQSLrzd9lCN7H0K8TecrVMSezJp96BfBN9t90J5zqneAtMcYTgI
         oGlVTG5NDHu2mqFZgf1Vr1NzrdzqZ0yK6OD3Amht1ZjU6IdS6tKubw5C9dQoNfjuzAYe
         ov2Sz3WlSmyYdXN45dEEskot9ooDfnG+wtYhdf3Mud1dtmsQLtjHPQoSRHRdBFZ+QBWr
         xk5rzYORH6KD0NTsPdsoUWinKy7DSI9uEhWIQ+0YoFGEl4k/3salpOpH8HOQWkWqa6Fn
         Mixw==
X-Gm-Message-State: AOAM530nnsybIj6KtmAmw7GSyg7x41g56bXnYv+5e4GuMZ0KkTLtq1X/
        /HYvtqRD8fe+aYX0pJDLIZddV6SKj1xx0kNTlqwxw6LNOY+cPlTZFGN+J3CDUUxkhVX4Rhbse0P
        cKWb/glAt/owEJz4FMv24
X-Received: by 2002:a05:6402:2c7:: with SMTP id b7mr21496661edx.217.1643642541109;
        Mon, 31 Jan 2022 07:22:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZCKT74UkCDZBDQNDUdwOtrJDPJ19WVDRL2LkVmN7hZB3+nxQLwq0VfY4rGEwkR0/CEPHnog==
X-Received: by 2002:a05:6402:2c7:: with SMTP id b7mr21496648edx.217.1643642540992;
        Mon, 31 Jan 2022 07:22:20 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t13sm13466973ejs.187.2022.01.31.07.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 07:22:20 -0800 (PST)
Message-ID: <7aefe6a7-eff9-bd86-10d0-f2c51517aeba@redhat.com>
Date:   Mon, 31 Jan 2022 16:22:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 18/20] extcon: intel-cht-wc: Refactor
 cht_wc_extcon_get_charger()
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
 <20220130204557.15662-19-hdegoede@redhat.com>
 <Yffqd4c7WrxTrHHL@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yffqd4c7WrxTrHHL@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 1/31/22 14:56, Andy Shevchenko wrote:
> On Sun, Jan 30, 2022 at 09:45:55PM +0100, Hans de Goede wrote:
>> This is a preparation patch for adding support for registering
>> a power_supply class device.
>>
>> Setting usbsrc to "CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT"
>> will make the following switch-case return EXTCON_CHG_USB_SDP
>> just as before, so there is no functional change.
> 
> ...
> 
>> -		return EXTCON_CHG_USB_SDP; /* Save fallback */
> 
>> +		/* Save fallback */
> 
> I see it's in the previous code, but what does it mean?
> I would read it as "Safe fallback", bit I have no clue.

Ah yes that should be safe not save, sorry will fix for v5.

Regards,

Hans

