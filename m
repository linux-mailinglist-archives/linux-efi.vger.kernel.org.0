Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF6444755C
	for <lists+linux-efi@lfdr.de>; Sun,  7 Nov 2021 20:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhKGTu1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Nov 2021 14:50:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236331AbhKGTu1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 Nov 2021 14:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636314463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fw9CdIc3/VRk9UdBCM9N1QjnoS+qQtswidra737/jxs=;
        b=c5CewyPmVX0bsOgaIjUGT4GTxgH+YnHkTYOAkz4ghmFEBZtsShGdarZsRm7HpF4czKGXTZ
        Z3RKXdDkc3ocv7N1E3RnZmvYDF4ejWluovuoDAvxxc8JJedGKIUkNwtPnVJkbLaiF7Qfaq
        mKk6Zute4EODJoO+GgYBisaDjOU50Xw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-WIyzE-mtNryOQLRBXxAC1Q-1; Sun, 07 Nov 2021 14:47:42 -0500
X-MC-Unique: WIyzE-mtNryOQLRBXxAC1Q-1
Received: by mail-ed1-f70.google.com with SMTP id w12-20020aa7da4c000000b003e28acbf765so13089526eds.6
        for <linux-efi@vger.kernel.org>; Sun, 07 Nov 2021 11:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fw9CdIc3/VRk9UdBCM9N1QjnoS+qQtswidra737/jxs=;
        b=1X8wpuwy1BPNDXJ9o53+Ci2rq0x25f0IXOtAkJE3XdD6nnpda1L/Pdabf53bYnR4kF
         bNkC4+FzaA0yUY/iqW0Gjrhn0folZFAalawNgqkXqv2jWzeaJiNf8GJQNYLlG+x9kQqk
         0DDMM/Q+t/vsr5qw+CIAEJ2zpqITKfAbPhZLe4hqNi5LNzQW7oWvXIXcvoxpdUDFiEWe
         5P1+C1Xl59cwlnhVD/j0OjeGvlMC9MCDp03+zY7ZmOCMoyOlPHSrv9yd3l1GtMQ3g0xL
         oHdV0kM0DUNFSy3OHZod1DSwghoDDnyJTSWb1z3tGVABWFySBtsMidnvwoGSQlEZeuGy
         /kEA==
X-Gm-Message-State: AOAM533AJ8YIpsgkBZjlUFSDOIYurg8FMisAzk6boP9EPd2DAjhibDpS
        r+j+/iRa3QJiEjFKpepD+dAQLd8xsvGRFnpgfRSFaWnC9lKmH1cRzw98OFcxnFzJraTvFVv8QtL
        4MbGqWjf4+vmJs/+fFZ8V
X-Received: by 2002:a17:907:86a6:: with SMTP id qa38mr15296498ejc.286.1636314460901;
        Sun, 07 Nov 2021 11:47:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyVGhkmgcFGuqMzn8WOTkwmWDnsl+HZ/qxHl33o4RtOQFpGH7JcUHAZVAEJCsmkh7POvwFdg==
X-Received: by 2002:a17:907:86a6:: with SMTP id qa38mr15296473ejc.286.1636314460694;
        Sun, 07 Nov 2021 11:47:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bx27sm8277661edb.7.2021.11.07.11.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 11:47:40 -0800 (PST)
Message-ID: <df053343-cf20-791e-f745-d3956ace25a0@redhat.com>
Date:   Sun, 7 Nov 2021 20:47:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 09/13] power: supply: bq25890: Add bq25890_set_otg_cfg()
 helper
Content-Language: en-US
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-10-hdegoede@redhat.com>
 <YYgfpJCUDs+dU++a@jeknote.loshitsa1.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YYgfpJCUDs+dU++a@jeknote.loshitsa1.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11/7/21 19:49, Yauhen Kharuzhy wrote:
> On Sat, Oct 30, 2021 at 08:28:09PM +0200, Hans de Goede wrote:
>> Add a bq25890_set_otg_cfg() helper function, this is a preparation
>> patch for adding regulator support.
> 
> The same notice here: if we enabling the boost mode to supply USB OTG
> device, we should disable charging and vice versa. I don't remember if
> enabling of OTG with CHG enabled really caused issues but I avoided this
> in my Yoga Book work.
> 
> I made quick check — seems that charging can be enabled during of boost
> operation, there are no visible side effects in registers and no
> limitation in the datasheet, so your approach may be good.

Right, the charging bit can simply be always on, if the OTG boost
converter is enabled then the charger it will automatically stop
charging (AFAIK it is partly re-using the same hw even).

I've no idea why the charging bit is being cleared by the BIOS, there
really is no need for this, with the exception of either:

1. Using an external Vbus boost converter, because that can e.g.
deliver more current, then charging does need to be disabled.

2. Disabling charging for battery health reasons

1. is not the case here; and 2. is something which we could export
as something userspace can request but that is optional.

So for normal use there really is no reason to set the charging
bit to 0 ever (and it is 1 on reset), so just setting it to 1
makes the behavior the same as on many ARM devices where this
charger is also used and the same as how similar chargers
like the bq2419x and bq2429x are used on other X86 devices.

Regards,

Hans




> 
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/bq25890_charger.c | 28 ++++++++++++++------------
>>  1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
>> index 163ca5d761aa..7504e30f1e4d 100644
>> --- a/drivers/power/supply/bq25890_charger.c
>> +++ b/drivers/power/supply/bq25890_charger.c
>> @@ -773,6 +773,17 @@ static int bq25890_power_supply_init(struct bq25890_device *bq)
>>  	return PTR_ERR_OR_ZERO(bq->charger);
>>  }
>>  
>> +static int bq25890_set_otg_cfg(struct bq25890_device *bq, u8 val)
>> +{
>> +	int ret;
>> +
>> +	ret = bq25890_field_write(bq, F_OTG_CFG, val);
>> +	if (ret < 0)
>> +		dev_err(bq->dev, "Error switching to boost/charger mode: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>>  static void bq25890_usb_work(struct work_struct *data)
>>  {
>>  	int ret;
>> @@ -782,25 +793,16 @@ static void bq25890_usb_work(struct work_struct *data)
>>  	switch (bq->usb_event) {
>>  	case USB_EVENT_ID:
>>  		/* Enable boost mode */
>> -		ret = bq25890_field_write(bq, F_OTG_CFG, 1);
>> -		if (ret < 0)
>> -			goto error;
>> +		bq25890_set_otg_cfg(bq, 1);
>>  		break;
>>  
>>  	case USB_EVENT_NONE:
>>  		/* Disable boost mode */
>> -		ret = bq25890_field_write(bq, F_OTG_CFG, 0);
>> -		if (ret < 0)
>> -			goto error;
>> -
>> -		power_supply_changed(bq->charger);
>> +		ret = bq25890_set_otg_cfg(bq, 0);
>> +		if (ret == 0)
>> +			power_supply_changed(bq->charger);
>>  		break;
>>  	}
>> -
>> -	return;
>> -
>> -error:
>> -	dev_err(bq->dev, "Error switching to boost/charger mode.\n");
>>  }
>>  
>>  static int bq25890_usb_notifier(struct notifier_block *nb, unsigned long val,
>> -- 
>> 2.31.1
>>
> 

