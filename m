Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8E3447524
	for <lists+linux-efi@lfdr.de>; Sun,  7 Nov 2021 20:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbhKGTKR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Nov 2021 14:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhKGTKO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 Nov 2021 14:10:14 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC36C061570;
        Sun,  7 Nov 2021 11:07:30 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p16so31311558lfa.2;
        Sun, 07 Nov 2021 11:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eMHkjPc5rIa5X9zRJiGLsZ3MoAtpjiPyEbEU/3emZIY=;
        b=jUhmHlGin5sEj5r9B3duWZRYeZfWXFTNWh3fjVMDJalE4cgJbKUOBCVy+HI8gCwirs
         3XvxuZH5zrrIMShFl0fwn1DIUJPx1G+MhjL0TS/jL7T8SH1Qn8CyBZq+c1INVx9qxC6/
         chCfa/fERQRXgAgzBM0eamEQGzO/tnPEFLzfJmcJzPJsMtZX3GjVHaPSMJSthYahkzvw
         +0K/IAndgglgZqZDAVZEsLjOzaV+FmxOQ7p+zmmct6v7RRXkdU3bOfSZ+y+d+zBVf6MA
         DCeY9cKiZpeNf5XniqAHn4Z8HJAxoTbjxIox7i+HDLfH2gHhP/fUW2qx/dsV3oKKooQt
         eC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eMHkjPc5rIa5X9zRJiGLsZ3MoAtpjiPyEbEU/3emZIY=;
        b=z84M3HiLN0SKCcTzt8D/lcHKaNwKDrX7s5rDhyM7SoHITG3Ltct3yR/w74YfV8ioPO
         4TkTGGXBGDrnVVGLy0WjNQqiLCi4nPePFtRUBcLEVpMdmSgJryPt5ggGkWHjJlQ66kAg
         tyfY0ZJJtVwXTeUrsYJwGXfG3IbSr0FIro6NunXpzdBzqJRxwPMNja8Iketx+pHgoVbF
         Ck3iiHfmn1YqFk+doEmZAYT8/y83KVsFfrTQCl9yoNSLwbi41lMWBBMaOmoNZKVMMvao
         JqLtWx1j1YlreCO0Z+J/9e/YhIGApC/H+2gwhgc5cXnOv3ySMpKyjV0GTHqP3fJFquGC
         1t5w==
X-Gm-Message-State: AOAM531jHSqQP5zybn1RN4E302m772SO99t0C0IvaX+dg6eSb8L7CAeA
        T3tgRLzNQsAf2icnRnnh11c=
X-Google-Smtp-Source: ABdhPJzUJ5poKvvs/VhmuOpJ1CRdoOUCkyn+FOLd4UWOiP0k8z3t7BkeU2jY07xzV7LmfnKlKW81nQ==
X-Received: by 2002:ac2:5df4:: with SMTP id z20mr57205513lfq.97.1636312048924;
        Sun, 07 Nov 2021 11:07:28 -0800 (PST)
Received: from localhost.localdomain ([37.45.143.17])
        by smtp.gmail.com with ESMTPSA id b22sm251387lfv.20.2021.11.07.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 11:07:28 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mjnVn-000Dnk-DT;
        Sun, 07 Nov 2021 22:07:27 +0300
Date:   Sun, 7 Nov 2021 22:07:27 +0300
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
Message-ID: <YYgj7zN6h+cqQzns@jeknote.loshitsa1.net>
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-12-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030182813.116672-12-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 30, 2021 at 08:28:11PM +0200, Hans de Goede wrote:
> The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
> in that it is always connected to the I2C charger IC of the board on
> which the PMIC is used; and the charger IC is not described in ACPI,
> so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.
> 
> So far there has been a rudimentary check to make sure the ACPI tables
> are at least somewhat as expected by checking for the presence of an
> INT33FE device and sofar the code has assumed that if this INT33FE
> device is present that the used charger then is a bq24290i.
> 
> But some boards with an INT33FE device in their ACPI tables use a
> different charger IC and some boards don't have an INT33FE device at all.
> 
> Since the information about the used charger + fuel-gauge + other chips is
> necessary in other places too, the kernel now adds a "intel,cht-wc-setup"
> string property to the Whiskey Cove PMIC i2c-client based on DMI matching,
> which reliably describes the board's setup of the PMIC.
> 
> Switch to using the "intel,cht-wc-setup" property and add support for
> instantiating an i2c-client for either a bq24292i or a bq25890 charger.
> 
> This has been tested on a GPD pocket (which uses the old bq24292i setup)
> and on a Xiaomi Mi Pad 2 with a bq25890 charger.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/i2c/busses/i2c-cht-wc.c | 77 +++++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
> index 1cf68f85b2e1..e7d62af6c39d 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/power/bq24190_charger.h>
> +#include <linux/power/bq25890_charger.h>
>  #include <linux/slab.h>
>  
>  #define CHT_WC_I2C_CTRL			0x5e24
> @@ -304,18 +305,55 @@ static struct bq24190_platform_data bq24190_pdata = {
>  	.regulator_init_data = &bq24190_vbus_init_data,
>  };
>  
> +static struct i2c_board_info bq24190_board_info = {
> +	.type = "bq24190",
> +	.addr = 0x6b,
> +	.dev_name = "bq24190",
> +	.swnode = &bq24190_node,
> +	.platform_data = &bq24190_pdata,
> +};
> +
> +static struct regulator_consumer_supply bq25890_vbus_consumer = {
> +	.supply = "vbus",
> +	.dev_name = "cht_wcove_pwrsrc",
> +};
> +
> +static const struct regulator_init_data bq25890_vbus_init_data = {
> +	.constraints = {
> +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +	},
> +	.consumer_supplies = &bq25890_vbus_consumer,
> +	.num_consumer_supplies = 1,
> +};
> +
> +static struct bq25890_platform_data bq25890_pdata = {
> +	.regulator_init_data = &bq25890_vbus_init_data,
> +};
> +
> +static const struct property_entry bq25890_props[] = {
> +	PROPERTY_ENTRY_BOOL("ti,skip-init"),
> +	{ }
> +};

The Lenovo Yoga Book firmware set the IINLIM field to 500 mA at
initialization, we need a way to pass maximum allowed current in the fast
charging mode to driver. I have added 'ti,input-max-current' in my port, for
example.

> +
> +static const struct software_node bq25890_node = {
> +	.properties = bq25890_props,
> +};
> +
> +static struct i2c_board_info bq25890_board_info = {
> +	.type = "bq25890",
> +	.addr = 0x6a,
> +	.dev_name = "bq25890",
> +	.swnode = &bq25890_node,
> +	.platform_data = &bq25890_pdata,
> +};
> +
>  static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>  {
>  	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
> +	struct i2c_board_info *board_info = NULL;
>  	struct cht_wc_i2c_adap *adap;
> -	struct i2c_board_info board_info = {
> -		.type = "bq24190",
> -		.addr = 0x6b,
> -		.dev_name = "bq24190",
> -		.swnode = &bq24190_node,
> -		.platform_data = &bq24190_pdata,
> -	};
>  	int ret, reg, irq;
> +	const char *str;
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> @@ -379,17 +417,20 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto remove_irq_domain;
>  
> -	/*
> -	 * Normally the Whiskey Cove PMIC is paired with a TI bq24292i charger,
> -	 * connected to this i2c bus, and a max17047 fuel-gauge and a fusb302
> -	 * USB Type-C controller connected to another i2c bus. In this setup
> -	 * the max17047 and fusb302 devices are enumerated through an INT33FE
> -	 * ACPI device. If this device is present register an i2c-client for
> -	 * the TI bq24292i charger.
> -	 */
> -	if (acpi_dev_present("INT33FE", NULL, -1)) {
> -		board_info.irq = adap->client_irq;
> -		adap->client = i2c_new_client_device(&adap->adapter, &board_info);
> +	ret = device_property_read_string(pdev->dev.parent, "intel,cht-wc-setup", &str);
> +	if (ret)
> +		dev_warn(&pdev->dev, "intel,cht-wc-setup not set, not instantiating charger device\n");
> +	else if (!strcmp(str, "bq24292i,max17047,fusb302,pi3usb30532"))
> +		board_info = &bq24190_board_info;
> +	else if (!strcmp(str, "bq25890,bq27520"))
> +		board_info = &bq25890_board_info;
> +	else
> +		dev_warn(&pdev->dev, "Unknown intel,cht-wc-setup value: '%s', not instantiating charger device\n",
> +			 str);
> +
> +	if (board_info) {
> +		board_info->irq = adap->client_irq;
> +		adap->client = i2c_new_client_device(&adap->adapter, board_info);
>  		if (IS_ERR(adap->client)) {
>  			ret = PTR_ERR(adap->client);
>  			goto del_adapter;
> -- 
> 2.31.1
> 

-- 
Yauhen Kharuzhy
