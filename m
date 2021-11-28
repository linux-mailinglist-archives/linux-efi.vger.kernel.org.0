Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE32460984
	for <lists+linux-efi@lfdr.de>; Sun, 28 Nov 2021 20:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhK1Tva (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Nov 2021 14:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240139AbhK1Tt0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Nov 2021 14:49:26 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EF5C061574;
        Sun, 28 Nov 2021 11:46:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bi37so38909436lfb.5;
        Sun, 28 Nov 2021 11:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5c2x7L/3GBh3yUpNOqfBo5XiVGRYdFLXSX4SbETDqQo=;
        b=mKnm7iytAs3F5zG4gvNhQKUjuYRdZTaDXrdkogodsE0nfRRe6guLcGJgNkNw7/c652
         J3cUmpVkMGnDHP42iDGhSp6ZXqH+1BxsXBGsmMRrMrSMK9JwQSkoRjWf8cd828bCl1KE
         O6Ac0ldb+GAaxvOAiSzX3oxQGqcBylzD6TEBfYHl96VNBN8bsHGVl+qX3AWEGWukH5Ih
         re/6cAOigJnVGjZmXWF6CGBKcB8WaVGnP4b5ox23lGs4Y5z7dj/8PcuN2VpaJq7wYucr
         /4vokqY59uSpd/DIq8PMNS1odRBRH3xtWzI6uvh/Psfz3TsbuYBRaCAIeSde/OtuH/3G
         nBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5c2x7L/3GBh3yUpNOqfBo5XiVGRYdFLXSX4SbETDqQo=;
        b=0FA8W9kOqjHbzQ3XVZHzC+KaxFQnNm6CX8C7q0omC70XTRVJiK9kroOievbB0yfmF9
         oYPctfe81LwewKEbJXPw21hfplHWtT2q4LBx1TIw4V8USYcqmo0tcHz7J6+s5qJ7lTcG
         G/ZePJZC66R0dUe9dq34uJAQOs2IMUZtyL3mVgfzNvHwpuW983zMcnxgyfVx+lqsbzxA
         YT4MDatWGZO03+ImXn3KP8zMuwSaSfUIGAu0+9jlkpdDNu7KKFzbZatLjcOD9uCxQITn
         F+WPwoVz6oq+DLn0S3F9vYYuFetvijTC7/BuIW87/+yGWB6+EebEJya2bXQ0eYsYwtFW
         4Jxg==
X-Gm-Message-State: AOAM530kj8sxJWBzhPUWnkq4eC7yA8RMUdso+224X4i0lKmkLyyNxSLw
        OYM7nw1pzNlDBUYAVJVgsqw=
X-Google-Smtp-Source: ABdhPJx4QZQBawYmjCibcf6YH73t5aAjTPkIW4EGO0RP0T+O3QOZcTbk7xlMWehAp+wIYBz2ng4YEg==
X-Received: by 2002:a19:6412:: with SMTP id y18mr43593647lfb.494.1638128768070;
        Sun, 28 Nov 2021 11:46:08 -0800 (PST)
Received: from localhost.localdomain ([37.45.176.136])
        by smtp.gmail.com with ESMTPSA id z28sm1149185ljn.77.2021.11.28.11.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 11:46:07 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mrQ7h-000qFw-SL;
        Sun, 28 Nov 2021 22:46:05 +0300
Date:   Sun, 28 Nov 2021 22:46:05 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
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
Subject: Re: [PATCH v2 10/20] power: supply: bq25890: Add
 bq25890_set_otg_cfg() helper
Message-ID: <YaPcfZQ8OsPNUjwK@jeknote.loshitsa1.net>
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-11-hdegoede@redhat.com>
 <YZIyQ1BdJ0v8QTtj@jeknote.loshitsa1.net>
 <66fbed75-7b48-6d91-1ef5-5df1c075e91c@redhat.com>
 <CAKWEGV7WVsZK=890UG=t3dhqCuoD-6N44DPMzk-_8TSPBm4_Dg@mail.gmail.com>
 <fbc88a7a-317f-9b81-fc76-2ceefcf6c7f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbc88a7a-317f-9b81-fc76-2ceefcf6c7f5@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Nov 28, 2021 at 04:02:06PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/16/21 12:07, Yauhen Kharuzhy wrote:
> > 
> > 
> > аў, 16 ліс 2021, 12:33 карыстальнік Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> напісаў:
> > 
> >     Hi Yauhen,
> > 
> >     On 11/15/21 11:11, Yauhen Kharuzhy wrote:
> >     > On Sun, Nov 14, 2021 at 06:03:25PM +0100, Hans de Goede wrote:
> >     >> Add a bq25890_set_otg_cfg() helper function, this is a preparation
> >     >> patch for adding regulator support.
> >     >>
> >     >> Signed-off-by: Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>>
> >     >> ---
> >     >>  drivers/power/supply/bq25890_charger.c | 28 ++++++++++++++------------
> >     >>  1 file changed, 15 insertions(+), 13 deletions(-)
> >     >>
> >     >> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> >     >> index 2bdfb58cda75..3c41fe86b3d3 100644
> >     >> --- a/drivers/power/supply/bq25890_charger.c
> >     >> +++ b/drivers/power/supply/bq25890_charger.c
> >     >> @@ -801,6 +801,17 @@ static int bq25890_power_supply_init(struct bq25890_device *bq)
> >     >>      return PTR_ERR_OR_ZERO(bq->charger);
> >     >>  }
> >     >> 
> >     >> +static int bq25890_set_otg_cfg(struct bq25890_device *bq, u8 val)
> >     >> +{
> >     >> +    int ret;
> >     >> +
> >     >> +    ret = bq25890_field_write(bq, F_OTG_CFG, val);
> >     >> +    if (ret < 0)
> >     >> +            dev_err(bq->dev, "Error switching to boost/charger mode: %d\n", ret);
> >     >
> >     > Just a note: if a connected USB device has relative big capacitor
> >     > at power wires inside, then a starting current pulse may be enough to
> >     > overload the boost reguator and VBUS will not be powered. I met this
> >     > at Yoga Book: the firmware set boost current limit to 1.4 A (default
> >     > value for bq25892) but when USB hub connected, the BOOST_FAULT event
> >     > appeared.
> >     >
> >     > To avoid this, Lenovo uses following trick in its kernel: set a boost
> >     > current limit to big value (2.1 A), wait some time (500 ms) and set
> >     > the current limit to right value (1.4A). This provides enough current to
> >     > charge capacitors in the connected device but saves desired long-time limit
> >     > to prevent overloading if the device consumes too much power itself.
> > 
> >     Right I saw this in your git repo, but I cannot reproduce the issue (1)
> >     I was hoping that since you can reproduce this, that you can rebase
> >     your fix on top of my patch-set ?
> > 
> >     Also I'm wondering if this behavior should be the default, I believe
> >     that the max. boost current may also be dependent on some external
> >     factors, so maybe we should make this behavior conditional on a
> >     new device-property ?
> > 
> > Yes, defining of max VBUS current may be a good idea. Another possible approach may be to use some empirical multiplier, like 150% of max 'long time' current limit setting. I almost sure that all hardware will work with short impulse of such current, its usual condition at device connection.
> > 
> > 
> >     Regards,
> > 
> >     Hans
> > 
> > 
> > 
> >     1) I must admit I did not try really hard, I guess I could try an
> >     USB powered hdd enclosure with a spinning disk
> > 
> >     What device are you seeing this with?
> > 
> > I cannot remember exactly device but this was a USB hub, possible with keyboard, mouse receiver and USB dongle inserted. I can recheck this issue but one week after, when will return home.
> 
> So as I mentioned before I've just tried to reproduce this problem, but
> I cannot reproduce it with an 2.5" USB disk enclosure with a spinning
> disk, which typically will cause a nice current-peak when spinning up.
> 
> I think this might also require an almost empty battery to reproduce ?

Hi.

I tried to reproduce just now with success.

I have the UNITEK Y-2165B OTG USB hub with cardreader. It has three
100 uF capacitors connected to the VBUS inside.

If the boost current limit is set to 1.4A, boot failure condition is appeared
when the hub connected, there is no USB device detected.

If the limit is set to 2.15A, the device detected and works, there is no
fault condition appeared.

So, I think that you may add 1-3 100uF capacitors to
any USB device or cable and try to reproduce.

Debug I2C dumps are below.

Before connection of the hub:

root@yogabook:/home/jek# i2cdump -f -y 7 0x6b
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 06 00 0a 42 13 80 cc 03 44 73 02 00 8d 58 57    .?.?B????Ds?.?XW
10: 4e 00 00 00 05 ff ff ff ff ff ff ff ff ff ff ff    N...?...........
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

Immediately after connection (look to 0x0c register):

root@yogabook:/home/jek# i2cdump -f -y 7 0x6b
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 06 00 2a 42 13 82 cc 03 44 73 e2 40 8d 57 57    .?.*B????Ds?@?WW
10: 4d 00 00 00 05 ff ff ff ff ff ff ff ff ff ff ff    M...?...........
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

Increase current limit manually and restart the boost converter:

root@yogabook:/home/jek# i2cset -f -y 7 0x6b 0x0a 0x76
root@yogabook:/home/jek# i2cset -f -y 7 0x6b 0x03 0x0a
root@yogabook:/home/jek# i2cset -f -y 7 0x6b 0x03 0x2a

root@yogabook:/home/jek# i2cdump -f -y 7 0x6b
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 06 00 2a 42 13 82 cc 03 44 76 e2 00 8d 57 57    .?.*B????Dv?.?WW
10: 4d 00 00 00 05 ff ff ff ff ff ff ff ff ff ff ff    M...?...........
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................



> 
> Regards,
> 
> Hans
> 

-- 
Yauhen Kharuzhy
