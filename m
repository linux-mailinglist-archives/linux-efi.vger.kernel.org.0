Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B66450219
	for <lists+linux-efi@lfdr.de>; Mon, 15 Nov 2021 11:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhKOKOi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 05:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhKOKOP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 05:14:15 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B7CC061767;
        Mon, 15 Nov 2021 02:11:18 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b1so36244253lfs.13;
        Mon, 15 Nov 2021 02:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uxwfsA+44ef1b7hlksCPyj8IFexX6NAJcsqLHIbZtDw=;
        b=ED1+rjMpnaWFy7IyLpgI4t6+NWjYrk9yvRsbDXQNO4edejFPeS5Fluo5T9eRA4iZWY
         qyAtRjrCuhzRvbF7arz5giRx/1OyeHYOPGZ8idBnsCSX89Lz1hbrQoL1Q4hSMMvQY/vY
         sRTdgNumGFp9+brp6ZmdJVdNJA1Y1oYxwd5Rsl/tcpXCmRMO0cstWd6ECUQhnVeqMk66
         GMbaWu75HDQfPUtV03ha+oCfVVDZbuvVHXdBj/09cnQ8kjv4gtZmPvt4twaMUl5rf6qm
         V6HQpYyJTgipoGQBWZki3AkHxRPM7Nafs76W5lF1USMKUixqfNtzgAZBYmtw1Ok/Tfkq
         SMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uxwfsA+44ef1b7hlksCPyj8IFexX6NAJcsqLHIbZtDw=;
        b=yHDloWQsuFZ0WRGEVlzKfVhUrOFkWqSB1jeId550atKckqs5StOQKDkZx+YQsT5LAR
         jnTDW12I9hSb6vaUsFwJIXzGEuXDSpxYKz/MwFYXHvUF0d6jA0ymje5W3mzhdgxFFxAk
         HXnIj0jErpYzPktDUK52PFw6Ch2G+U7rcCMURsu2nwxPvgQjwlT5N9MOk/XRGzaWWvsw
         f8NHhY315VT/xjjyzm7WFC+Z0JprD6X/JYLcztZFFljm+f5LihD4woqUwzdYaeVyM33B
         QIK54OQX/P+CkPJhf+VJLYU1MxYLi7pYx6oDfGooDRwnZQWW2hLp9K3Ehq/FwIAJ+Gug
         QNOw==
X-Gm-Message-State: AOAM532nuAg4DbUHc5b0S+JUdX559GiByuNwTzUeruA4AUb+vzJ9LRZD
        ZlNH1zf1gtcArplj4Xbngw8=
X-Google-Smtp-Source: ABdhPJzzG0A94HwBEFevyB5R/o6ZsnhSI8DcBgN+Z4YhggnKS037qGfUrVTsqxrckLGnY2R6XXXm3w==
X-Received: by 2002:a05:6512:2201:: with SMTP id h1mr33409940lfu.397.1636971076884;
        Mon, 15 Nov 2021 02:11:16 -0800 (PST)
Received: from localhost.localdomain ([178.127.153.223])
        by smtp.gmail.com with ESMTPSA id f15sm1246622lfq.236.2021.11.15.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:11:16 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mmYxH-001Bq1-5o;
        Mon, 15 Nov 2021 13:11:15 +0300
Date:   Mon, 15 Nov 2021 13:11:15 +0300
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
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 10/20] power: supply: bq25890: Add
 bq25890_set_otg_cfg() helper
Message-ID: <YZIyQ1BdJ0v8QTtj@jeknote.loshitsa1.net>
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-11-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114170335.66994-11-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Nov 14, 2021 at 06:03:25PM +0100, Hans de Goede wrote:
> Add a bq25890_set_otg_cfg() helper function, this is a preparation
> patch for adding regulator support.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 28 ++++++++++++++------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 2bdfb58cda75..3c41fe86b3d3 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -801,6 +801,17 @@ static int bq25890_power_supply_init(struct bq25890_device *bq)
>  	return PTR_ERR_OR_ZERO(bq->charger);
>  }
>  
> +static int bq25890_set_otg_cfg(struct bq25890_device *bq, u8 val)
> +{
> +	int ret;
> +
> +	ret = bq25890_field_write(bq, F_OTG_CFG, val);
> +	if (ret < 0)
> +		dev_err(bq->dev, "Error switching to boost/charger mode: %d\n", ret);

Just a note: if a connected USB device has relative big capacitor
at power wires inside, then a starting current pulse may be enough to
overload the boost reguator and VBUS will not be powered. I met this
at Yoga Book: the firmware set boost current limit to 1.4 A (default
value for bq25892) but when USB hub connected, the BOOST_FAULT event
appeared.

To avoid this, Lenovo uses following trick in its kernel: set a boost
current limit to big value (2.1 A), wait some time (500 ms) and set
the current limit to right value (1.4A). This provides enough current to
charge capacitors in the connected device but saves desired long-time limit
to prevent overloading if the device consumes too much power itself.



-- 
Yauhen Kharuzhy
