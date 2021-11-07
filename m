Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2F6447543
	for <lists+linux-efi@lfdr.de>; Sun,  7 Nov 2021 20:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhKGTiJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Nov 2021 14:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhKGTiI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 Nov 2021 14:38:08 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E08C061570;
        Sun,  7 Nov 2021 11:35:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l22so4591294lfg.7;
        Sun, 07 Nov 2021 11:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JQSgFGKQfcK4tDVKYXGmiQZ5K9YhZUxXc1mNLrrVvWk=;
        b=kcTtXUXmbCdeYgb87QlO1BWDCIQOqE49CRoRq4Q8QvNaBJ90jzYSvKGMTYAMplrTEE
         c9YwvCzXXJgzpGcgyIF5jokl3v14nXyH2nE/ev/DfD0gHVQ4bcmZarBGe1OJSdPoYD6Y
         VVwkz8vPL3dn2qpRY6Os7fLCwj+qCnQAmgSx045KxyGHT3kjYB8YxvBeFIX7a74LHz72
         FVAHfCzrZc97cEg0/aNx9IaOrAduXUsg24XWjO3cJLCY9bkuTzTyQ+Xbw/PgQknws21H
         48SEc9OciTYsTtyTs65zDvFDyPAYAm50d12vfHXr9aZH5gT7EHlGNU3GVKf9qM5Rf+2Q
         4ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JQSgFGKQfcK4tDVKYXGmiQZ5K9YhZUxXc1mNLrrVvWk=;
        b=hdgT/zsyGC/EJK1Q9fnyTeXYSOIKlA+YTjSfqDea7K/onqCMDOpdigPyk9WbFmQnit
         teN1WDIcDrOitoaen6t8n+kM7C8zf/WGoRGI7W4Jqkpxel5G0MiDd3HGkFUa9ivjQQ5Q
         qt2cnIOVs+px1pznxhlc1cS36SP0jN6M3MAOIU1rxbdSRb01HFbaHnFGqyq2av3kLJA9
         WkUdfnNP4dZAe+ulU4gpt6W8x5Ct3F93pR4Si5huwVKj3DigW7B2xuYXx2Uf07I6FWEJ
         o8zCxmhJEg6A+AlDh3Xh30l3zJhd7yw5Kxr0fRHFU0Orf/l81fAj/75suHA/MjH+W/4d
         ICUg==
X-Gm-Message-State: AOAM532jeznmUTvfeNzbVdqYje/N2VABCCMsbs1iwohGC1bGyrxAdbSw
        jlrp6n5JDqxZXVH5P9nFO5E=
X-Google-Smtp-Source: ABdhPJz7mT6mNxKN7JvuA8I7hK6KXveOG1d8GvJIKrh929pUeK3nfYfPysydF8TLEwZibT0OnJkTZA==
X-Received: by 2002:a05:6512:3501:: with SMTP id h1mr69003798lfs.235.1636313723048;
        Sun, 07 Nov 2021 11:35:23 -0800 (PST)
Received: from localhost.localdomain ([37.45.143.17])
        by smtp.gmail.com with ESMTPSA id f6sm1482828ljk.45.2021.11.07.11.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 11:35:22 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mjnwn-000DvT-6W;
        Sun, 07 Nov 2021 22:35:21 +0300
Date:   Sun, 7 Nov 2021 22:35:21 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
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
Subject: Re: [PATCH 11/13] i2c: cht-wc: Add support for devices using a
 bq25890 charger
Message-ID: <YYgqeR+VSCWER9bb@jeknote.loshitsa1.net>
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-12-hdegoede@redhat.com>
 <YYgj7zN6h+cqQzns@jeknote.loshitsa1.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYgj7zN6h+cqQzns@jeknote.loshitsa1.net>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Nov 07, 2021 at 10:07:27PM +0300, Yauhen Kharuzhy wrote:
> On Sat, Oct 30, 2021 at 08:28:11PM +0200, Hans de Goede wrote:
> > The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
> > in that it is always connected to the I2C charger IC of the board on
> > which the PMIC is used; and the charger IC is not described in ACPI,
> > so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.
> > 
> > So far there has been a rudimentary check to make sure the ACPI tables
> > are at least somewhat as expected by checking for the presence of an
> > INT33FE device and sofar the code has assumed that if this INT33FE
> > device is present that the used charger then is a bq24290i.
> > 
> > But some boards with an INT33FE device in their ACPI tables use a
> > different charger IC and some boards don't have an INT33FE device at all.
> > 
> > Since the information about the used charger + fuel-gauge + other chips is
> > necessary in other places too, the kernel now adds a "intel,cht-wc-setup"
> > string property to the Whiskey Cove PMIC i2c-client based on DMI matching,
> > which reliably describes the board's setup of the PMIC.
> > 
> > Switch to using the "intel,cht-wc-setup" property and add support for
> > instantiating an i2c-client for either a bq24292i or a bq25890 charger.
> > 
> > This has been tested on a GPD pocket (which uses the old bq24292i setup)
> > and on a Xiaomi Mi Pad 2 with a bq25890 charger.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/i2c/busses/i2c-cht-wc.c | 77 +++++++++++++++++++++++++--------
> >  1 file changed, 59 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
> > index 1cf68f85b2e1..e7d62af6c39d 100644
> > --- a/drivers/i2c/busses/i2c-cht-wc.c
> > +++ b/drivers/i2c/busses/i2c-cht-wc.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/power/bq24190_charger.h>
> > +#include <linux/power/bq25890_charger.h>
> >  #include <linux/slab.h>
> >  
> >  #define CHT_WC_I2C_CTRL			0x5e24
> > @@ -304,18 +305,55 @@ static struct bq24190_platform_data bq24190_pdata = {
> >  	.regulator_init_data = &bq24190_vbus_init_data,
> >  };
> >  
> > +static struct i2c_board_info bq24190_board_info = {
> > +	.type = "bq24190",
> > +	.addr = 0x6b,
> > +	.dev_name = "bq24190",
> > +	.swnode = &bq24190_node,
> > +	.platform_data = &bq24190_pdata,
> > +};
> > +
> > +static struct regulator_consumer_supply bq25890_vbus_consumer = {
> > +	.supply = "vbus",
> > +	.dev_name = "cht_wcove_pwrsrc",
> > +};
> > +
> > +static const struct regulator_init_data bq25890_vbus_init_data = {
> > +	.constraints = {
> > +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> > +	},
> > +	.consumer_supplies = &bq25890_vbus_consumer,
> > +	.num_consumer_supplies = 1,
> > +};
> > +
> > +static struct bq25890_platform_data bq25890_pdata = {
> > +	.regulator_init_data = &bq25890_vbus_init_data,
> > +};
> > +
> > +static const struct property_entry bq25890_props[] = {
> > +	PROPERTY_ENTRY_BOOL("ti,skip-init"),
> > +	{ }
> > +};
> 
> The Lenovo Yoga Book firmware set the IINLIM field to 500 mA at
> initialization, we need a way to pass maximum allowed current in the fast
> charging mode to driver. I have added 'ti,input-max-current' in my port, for
> example.

ICHG (charging current limit) is too low also (2A versus 4A in Android
sources for this device), so it should be set by properties.

-- 
Yauhen Kharuzhy
