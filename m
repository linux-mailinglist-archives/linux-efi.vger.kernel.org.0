Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F330C44755E
	for <lists+linux-efi@lfdr.de>; Sun,  7 Nov 2021 20:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbhKGTx4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Nov 2021 14:53:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230364AbhKGTx4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 Nov 2021 14:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636314672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ISQHp33JZv+veOlWG7UsO8OxcF62yPS/55R+u1kO5uM=;
        b=W8bDgrtbPE+NwfMG4btdG2qH6zeB6dWJ7eFtsFkgW0BO0AQ+qvPXsTFN4Y+wnRb0Q/uN0w
        b6p16+EoAIB8+tjPpg5AoR2C8MwKf2sBKXP26z0OY/Mb47G4TN+MFgYBE9goBtYOiaZOnL
        jFx/Us1U5pmuz+6vXF6u45x0H+MoPzU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-eWCCp2Z9POysRktBk81c6A-1; Sun, 07 Nov 2021 14:51:11 -0500
X-MC-Unique: eWCCp2Z9POysRktBk81c6A-1
Received: by mail-ed1-f71.google.com with SMTP id f20-20020a0564021e9400b003e2ad3eae74so13083619edf.5
        for <linux-efi@vger.kernel.org>; Sun, 07 Nov 2021 11:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ISQHp33JZv+veOlWG7UsO8OxcF62yPS/55R+u1kO5uM=;
        b=oUELKk8unQElyxtPZVL8wxyTwaLGbXAKQv05kaGrDkLAUk1qTgf0IOrg0/Vtqk9vSN
         hoPuSWr59ltVfd+WiWqFICf8pTHlo1fOzZOZjscJPKYsUsV+va3UMNHbML7YqBD+x5x4
         77hLXE0wPHfoPE4Rtl8OV48WWaTuRibN5x/Wgdf8D5+Olk8ehkdjTB6wd7V863UiaI4v
         XdKBiMhekCg+GBPFF3T76h2YMBoNrvlTNHdPNvnrjAHLJ1kd/kfiy8NpV3UETQH71prT
         IQsHuARY/FFrMbQ/h30DNTuhZaHO9bSKjtahMsGfwHa0hcwR7yN/dOv5Q7j7li3xhz/J
         ws3Q==
X-Gm-Message-State: AOAM530bBQ8hYtAd7fsDKRk1NSOECAZa0hYOVDpWBJpZ0IS1Z8uUcf+t
        OiRFDmK2G9bipiDvZBA07uVZYmihKI4lbgK703VfvJf20Iv+NzI2IHRkfeRoi8QabWk5aBMspLg
        9Ku5bwTvQtiWP268mI39T
X-Received: by 2002:a17:907:7d94:: with SMTP id oz20mr69029180ejc.410.1636314670516;
        Sun, 07 Nov 2021 11:51:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbGXmReFcqBQ9rcnodepeBPANCjouWpspfpvWKViriCMVnVWFRpqHh0U+LEGeDsyxuYBatOQ==
X-Received: by 2002:a17:907:7d94:: with SMTP id oz20mr69029153ejc.410.1636314670260;
        Sun, 07 Nov 2021 11:51:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o5sm8765113edc.25.2021.11.07.11.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 11:51:09 -0800 (PST)
Message-ID: <8a5935b2-880e-eca0-265d-13b8538caefe@redhat.com>
Date:   Sun, 7 Nov 2021 20:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 11/13] i2c: cht-wc: Add support for devices using a
 bq25890 charger
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
 <20211030182813.116672-12-hdegoede@redhat.com>
 <YYgj7zN6h+cqQzns@jeknote.loshitsa1.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YYgj7zN6h+cqQzns@jeknote.loshitsa1.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11/7/21 20:07, Yauhen Kharuzhy wrote:
> On Sat, Oct 30, 2021 at 08:28:11PM +0200, Hans de Goede wrote:
>> The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
>> in that it is always connected to the I2C charger IC of the board on
>> which the PMIC is used; and the charger IC is not described in ACPI,
>> so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.
>>
>> So far there has been a rudimentary check to make sure the ACPI tables
>> are at least somewhat as expected by checking for the presence of an
>> INT33FE device and sofar the code has assumed that if this INT33FE
>> device is present that the used charger then is a bq24290i.
>>
>> But some boards with an INT33FE device in their ACPI tables use a
>> different charger IC and some boards don't have an INT33FE device at all.
>>
>> Since the information about the used charger + fuel-gauge + other chips is
>> necessary in other places too, the kernel now adds a "intel,cht-wc-setup"
>> string property to the Whiskey Cove PMIC i2c-client based on DMI matching,
>> which reliably describes the board's setup of the PMIC.
>>
>> Switch to using the "intel,cht-wc-setup" property and add support for
>> instantiating an i2c-client for either a bq24292i or a bq25890 charger.
>>
>> This has been tested on a GPD pocket (which uses the old bq24292i setup)
>> and on a Xiaomi Mi Pad 2 with a bq25890 charger.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/i2c/busses/i2c-cht-wc.c | 77 +++++++++++++++++++++++++--------
>>  1 file changed, 59 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
>> index 1cf68f85b2e1..e7d62af6c39d 100644
>> --- a/drivers/i2c/busses/i2c-cht-wc.c
>> +++ b/drivers/i2c/busses/i2c-cht-wc.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/power/bq24190_charger.h>
>> +#include <linux/power/bq25890_charger.h>
>>  #include <linux/slab.h>
>>  
>>  #define CHT_WC_I2C_CTRL			0x5e24
>> @@ -304,18 +305,55 @@ static struct bq24190_platform_data bq24190_pdata = {
>>  	.regulator_init_data = &bq24190_vbus_init_data,
>>  };
>>  
>> +static struct i2c_board_info bq24190_board_info = {
>> +	.type = "bq24190",
>> +	.addr = 0x6b,
>> +	.dev_name = "bq24190",
>> +	.swnode = &bq24190_node,
>> +	.platform_data = &bq24190_pdata,
>> +};
>> +
>> +static struct regulator_consumer_supply bq25890_vbus_consumer = {
>> +	.supply = "vbus",
>> +	.dev_name = "cht_wcove_pwrsrc",
>> +};
>> +
>> +static const struct regulator_init_data bq25890_vbus_init_data = {
>> +	.constraints = {
>> +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
>> +	},
>> +	.consumer_supplies = &bq25890_vbus_consumer,
>> +	.num_consumer_supplies = 1,
>> +};
>> +
>> +static struct bq25890_platform_data bq25890_pdata = {
>> +	.regulator_init_data = &bq25890_vbus_init_data,
>> +};
>> +
>> +static const struct property_entry bq25890_props[] = {
>> +	PROPERTY_ENTRY_BOOL("ti,skip-init"),
>> +	{ }
>> +};
> 
> The Lenovo Yoga Book firmware set the IINLIM field to 500 mA at
> initialization, we need a way to pass maximum allowed current in the fast
> charging mode to driver. I have added 'ti,input-max-current' in my port, for
> example.

500 mA is fine, we will run BC1.2 spec charger-type detection
in the PMIC extcon code and then pass the result of that to
the charger-IC. This is not present in this version of the
patch-set because I did not have a yogabook yet when
I wrote this, v2 will take care of this.

I hope to post a v2 sometime the coming 2 weeks.

Regards,

Hans





> 
>> +
>> +static const struct software_node bq25890_node = {
>> +	.properties = bq25890_props,
>> +};
>> +
>> +static struct i2c_board_info bq25890_board_info = {
>> +	.type = "bq25890",
>> +	.addr = 0x6a,
>> +	.dev_name = "bq25890",
>> +	.swnode = &bq25890_node,
>> +	.platform_data = &bq25890_pdata,
>> +};
>> +
>>  static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>>  {
>>  	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
>> +	struct i2c_board_info *board_info = NULL;
>>  	struct cht_wc_i2c_adap *adap;
>> -	struct i2c_board_info board_info = {
>> -		.type = "bq24190",
>> -		.addr = 0x6b,
>> -		.dev_name = "bq24190",
>> -		.swnode = &bq24190_node,
>> -		.platform_data = &bq24190_pdata,
>> -	};
>>  	int ret, reg, irq;
>> +	const char *str;
>>  
>>  	irq = platform_get_irq(pdev, 0);
>>  	if (irq < 0)
>> @@ -379,17 +417,20 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto remove_irq_domain;
>>  
>> -	/*
>> -	 * Normally the Whiskey Cove PMIC is paired with a TI bq24292i charger,
>> -	 * connected to this i2c bus, and a max17047 fuel-gauge and a fusb302
>> -	 * USB Type-C controller connected to another i2c bus. In this setup
>> -	 * the max17047 and fusb302 devices are enumerated through an INT33FE
>> -	 * ACPI device. If this device is present register an i2c-client for
>> -	 * the TI bq24292i charger.
>> -	 */
>> -	if (acpi_dev_present("INT33FE", NULL, -1)) {
>> -		board_info.irq = adap->client_irq;
>> -		adap->client = i2c_new_client_device(&adap->adapter, &board_info);
>> +	ret = device_property_read_string(pdev->dev.parent, "intel,cht-wc-setup", &str);
>> +	if (ret)
>> +		dev_warn(&pdev->dev, "intel,cht-wc-setup not set, not instantiating charger device\n");
>> +	else if (!strcmp(str, "bq24292i,max17047,fusb302,pi3usb30532"))
>> +		board_info = &bq24190_board_info;
>> +	else if (!strcmp(str, "bq25890,bq27520"))
>> +		board_info = &bq25890_board_info;
>> +	else
>> +		dev_warn(&pdev->dev, "Unknown intel,cht-wc-setup value: '%s', not instantiating charger device\n",
>> +			 str);
>> +
>> +	if (board_info) {
>> +		board_info->irq = adap->client_irq;
>> +		adap->client = i2c_new_client_device(&adap->adapter, board_info);
>>  		if (IS_ERR(adap->client)) {
>>  			ret = PTR_ERR(adap->client);
>>  			goto del_adapter;
>> -- 
>> 2.31.1
>>
> 

