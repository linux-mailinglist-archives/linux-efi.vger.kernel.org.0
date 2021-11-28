Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F33460708
	for <lists+linux-efi@lfdr.de>; Sun, 28 Nov 2021 16:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhK1PH1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Nov 2021 10:07:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234880AbhK1PF0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Nov 2021 10:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638111730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iX13/SG9QVzjtgOCFE9A2Tjj7ExPs6uzaEpwB6t8MCU=;
        b=QyPEDMbFDypau/Khl1OOWeShmfVITji/aFqFvmDZPyJVcwibm8Kzy9IIqi/jdRw8UPaKJ5
        idAFApvmUQS7MxeqL7vt4gvjUdQy/YSZ12ZMFNCACEh5zLeW0JM3ZKE3QTjv0J905oaS5P
        9P79ngwXRiS8u6JvhvNhCjLCtki+p5c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-jTWYTUqNME-vel9OS3FVhQ-1; Sun, 28 Nov 2021 10:02:08 -0500
X-MC-Unique: jTWYTUqNME-vel9OS3FVhQ-1
Received: by mail-ed1-f70.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so11557867edx.4
        for <linux-efi@vger.kernel.org>; Sun, 28 Nov 2021 07:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iX13/SG9QVzjtgOCFE9A2Tjj7ExPs6uzaEpwB6t8MCU=;
        b=b77YZKN6mXkljqmdz9xc+t6kWrc7GrcjLz0F2tUDQyk56s9jv8fZo8mdbJ9zMyamfz
         11t3xPVNBZz8XQAXXudQ/2xZKykuST82U/PPnI9tvDAtBI96sFnJsKLYQ+bQ6DNkY8US
         OO4PYc/Plx1Ygz3WZ+nZ/2m6CeDnPwbZDoBpGXKToHD1Pw7Qn13OvBdGx5uo6Idh3hJ3
         jAhRdhv5U0BXT96KdRpNgOscTo+cmJFZqOhiOEc6E6DudDqniRG/cEeV6fCz9N1fAko8
         sTTMa8P5zUODovP0d1NysgWj1pVfTrxblm2iZ0V2fOdh6o3GoCYrtpO7K6J22kq38yuy
         IRMw==
X-Gm-Message-State: AOAM532KhnlWtJCG4rv8tAG7I6PHcUDs6Mz3/q3ZHKCdgwy/5RnwOuzR
        +OK4DOy2FAZW6RjdMfzg1edhYgSwzgGkSSgucMlVLNBpiJDLzQzAeAFoPPW6fAkdHdsv8EMEyWd
        BJiPEfLCbCcUBTDHalzol
X-Received: by 2002:a17:906:cb82:: with SMTP id mf2mr53839652ejb.266.1638111727659;
        Sun, 28 Nov 2021 07:02:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEowT50fZ7ivaFDJ6V5lUqwpF6775Ln26cgBO1XkuRoo+Nxd33Br4pIX2oVkufpwJATaPlWA==
X-Received: by 2002:a17:906:cb82:: with SMTP id mf2mr53839613ejb.266.1638111727453;
        Sun, 28 Nov 2021 07:02:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id nb17sm6253338ejc.7.2021.11.28.07.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 07:02:07 -0800 (PST)
Message-ID: <fbc88a7a-317f-9b81-fc76-2ceefcf6c7f5@redhat.com>
Date:   Sun, 28 Nov 2021 16:02:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 10/20] power: supply: bq25890: Add
 bq25890_set_otg_cfg() helper
Content-Language: en-US
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-11-hdegoede@redhat.com>
 <YZIyQ1BdJ0v8QTtj@jeknote.loshitsa1.net>
 <66fbed75-7b48-6d91-1ef5-5df1c075e91c@redhat.com>
 <CAKWEGV7WVsZK=890UG=t3dhqCuoD-6N44DPMzk-_8TSPBm4_Dg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAKWEGV7WVsZK=890UG=t3dhqCuoD-6N44DPMzk-_8TSPBm4_Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11/16/21 12:07, Yauhen Kharuzhy wrote:
> 
> 
> аў, 16 ліс 2021, 12:33 карыстальнік Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> напісаў:
> 
>     Hi Yauhen,
> 
>     On 11/15/21 11:11, Yauhen Kharuzhy wrote:
>     > On Sun, Nov 14, 2021 at 06:03:25PM +0100, Hans de Goede wrote:
>     >> Add a bq25890_set_otg_cfg() helper function, this is a preparation
>     >> patch for adding regulator support.
>     >>
>     >> Signed-off-by: Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>>
>     >> ---
>     >>  drivers/power/supply/bq25890_charger.c | 28 ++++++++++++++------------
>     >>  1 file changed, 15 insertions(+), 13 deletions(-)
>     >>
>     >> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
>     >> index 2bdfb58cda75..3c41fe86b3d3 100644
>     >> --- a/drivers/power/supply/bq25890_charger.c
>     >> +++ b/drivers/power/supply/bq25890_charger.c
>     >> @@ -801,6 +801,17 @@ static int bq25890_power_supply_init(struct bq25890_device *bq)
>     >>      return PTR_ERR_OR_ZERO(bq->charger);
>     >>  }
>     >> 
>     >> +static int bq25890_set_otg_cfg(struct bq25890_device *bq, u8 val)
>     >> +{
>     >> +    int ret;
>     >> +
>     >> +    ret = bq25890_field_write(bq, F_OTG_CFG, val);
>     >> +    if (ret < 0)
>     >> +            dev_err(bq->dev, "Error switching to boost/charger mode: %d\n", ret);
>     >
>     > Just a note: if a connected USB device has relative big capacitor
>     > at power wires inside, then a starting current pulse may be enough to
>     > overload the boost reguator and VBUS will not be powered. I met this
>     > at Yoga Book: the firmware set boost current limit to 1.4 A (default
>     > value for bq25892) but when USB hub connected, the BOOST_FAULT event
>     > appeared.
>     >
>     > To avoid this, Lenovo uses following trick in its kernel: set a boost
>     > current limit to big value (2.1 A), wait some time (500 ms) and set
>     > the current limit to right value (1.4A). This provides enough current to
>     > charge capacitors in the connected device but saves desired long-time limit
>     > to prevent overloading if the device consumes too much power itself.
> 
>     Right I saw this in your git repo, but I cannot reproduce the issue (1)
>     I was hoping that since you can reproduce this, that you can rebase
>     your fix on top of my patch-set ?
> 
>     Also I'm wondering if this behavior should be the default, I believe
>     that the max. boost current may also be dependent on some external
>     factors, so maybe we should make this behavior conditional on a
>     new device-property ?
> 
> Yes, defining of max VBUS current may be a good idea. Another possible approach may be to use some empirical multiplier, like 150% of max 'long time' current limit setting. I almost sure that all hardware will work with short impulse of such current, its usual condition at device connection.
> 
> 
>     Regards,
> 
>     Hans
> 
> 
> 
>     1) I must admit I did not try really hard, I guess I could try an
>     USB powered hdd enclosure with a spinning disk
> 
>     What device are you seeing this with?
> 
> I cannot remember exactly device but this was a USB hub, possible with keyboard, mouse receiver and USB dongle inserted. I can recheck this issue but one week after, when will return home.

So as I mentioned before I've just tried to reproduce this problem, but
I cannot reproduce it with an 2.5" USB disk enclosure with a spinning
disk, which typically will cause a nice current-peak when spinning up.

I think this might also require an almost empty battery to reproduce ?

Regards,

Hans

