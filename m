Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF14447500
	for <lists+linux-efi@lfdr.de>; Sun,  7 Nov 2021 19:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhKGSvz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Nov 2021 13:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhKGSvy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 Nov 2021 13:51:54 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3868EC061570;
        Sun,  7 Nov 2021 10:49:11 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b40so1821038lfv.10;
        Sun, 07 Nov 2021 10:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Kvqe3QF82ECK9GYNMpVKEaKXVXkIkwuX0fCsiIXQlPA=;
        b=Shm3pfux80imjkrKdny47+7puHyO4FTeCbvOxc8ELNIAxNkPyaOeulu7dQe1Br9jx6
         xVcCzNPTBanVqoEta6LeXw+x4EKtqTA1540M3za/q2Ir7ONSbmb0x0GuJn5xmBdWr1x7
         rxLS+960C3ZfiswmSDKpiw1H5hHmhJxpIKwtX4LWEYoF06FQlIaRmnSzJAM5LVNZtPPP
         73H9YJpKZPhum2RefotfyeZbfY1MFsulvlAmaVHdQ6MMM5a8G1pyClOOTW9N8M77NltR
         XYMGl5SWfIF4TF+lyyIbYSL9h9g5xKEuH+ZawUhpqnrRU7IvXr3Gh6CePlNo9R7ZoLXP
         uPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Kvqe3QF82ECK9GYNMpVKEaKXVXkIkwuX0fCsiIXQlPA=;
        b=xa8G/R6c9feShJ8ZDjDynqAl3LgQzdryZarjsxsM4Z1o7usSISxahjVrG1q4kHheVs
         8THqXEB4SMT9ccSq1JcESJVF9rq6YJCJIZtJMLuhoA1Zf+TT9ZqY7KAl1AfTe5d1ozj4
         b2FLZjGps59gP2T3kITG5P6Qa0siWlH/sJCsrcP4sGq6RdVCbpkrjUp1r+IteXYcSKP+
         vuYoZqxX0T49K0fLZIbwLsImwsLqe6un9O5xC/UsmL57Xm8GKh2/4DikBAKEkRo2NNbu
         1fiica4sBSMYgQaDPW7cMmA+x5WKpGG4LrP/wADTqnTJz83HCqLKWgudGiv9tICkyLOS
         S84A==
X-Gm-Message-State: AOAM531ym9bCo57n/D4FlLEt0/h98IiPAl8hr3Auw2vxdGa2tWG3NFeJ
        y4+6U5eXnbCrGEMmeRMRKW0=
X-Google-Smtp-Source: ABdhPJynOiqxajhXT73uWxDBk5IOQuEq9NPRBVANqUybEBmCtEJtqmqY++t24DXeYcrj084HI0d4KQ==
X-Received: by 2002:a05:6512:607:: with SMTP id b7mr4861030lfe.489.1636310949543;
        Sun, 07 Nov 2021 10:49:09 -0800 (PST)
Received: from localhost.localdomain ([37.45.143.17])
        by smtp.gmail.com with ESMTPSA id n5sm1540957lfu.126.2021.11.07.10.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 10:49:09 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mjnE4-000DjM-9a;
        Sun, 07 Nov 2021 21:49:08 +0300
Date:   Sun, 7 Nov 2021 21:49:08 +0300
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
Subject: Re: [PATCH 09/13] power: supply: bq25890: Add bq25890_set_otg_cfg()
 helper
Message-ID: <YYgfpJCUDs+dU++a@jeknote.loshitsa1.net>
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-10-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211030182813.116672-10-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 30, 2021 at 08:28:09PM +0200, Hans de Goede wrote:
> Add a bq25890_set_otg_cfg() helper function, this is a preparation
> patch for adding regulator support.

The same notice here: if we enabling the boost mode to supply USB OTG
device, we should disable charging and vice versa. I don't remember if
enabling of OTG with CHG enabled really caused issues but I avoided this
in my Yoga Book work.

I made quick check — seems that charging can be enabled during of boost
operation, there are no visible side effects in registers and no
limitation in the datasheet, so your approach may be good.

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 28 ++++++++++++++------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 163ca5d761aa..7504e30f1e4d 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -773,6 +773,17 @@ static int bq25890_power_supply_init(struct bq25890_device *bq)
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
> +
> +	return ret;
> +}
> +
>  static void bq25890_usb_work(struct work_struct *data)
>  {
>  	int ret;
> @@ -782,25 +793,16 @@ static void bq25890_usb_work(struct work_struct *data)
>  	switch (bq->usb_event) {
>  	case USB_EVENT_ID:
>  		/* Enable boost mode */
> -		ret = bq25890_field_write(bq, F_OTG_CFG, 1);
> -		if (ret < 0)
> -			goto error;
> +		bq25890_set_otg_cfg(bq, 1);
>  		break;
>  
>  	case USB_EVENT_NONE:
>  		/* Disable boost mode */
> -		ret = bq25890_field_write(bq, F_OTG_CFG, 0);
> -		if (ret < 0)
> -			goto error;
> -
> -		power_supply_changed(bq->charger);
> +		ret = bq25890_set_otg_cfg(bq, 0);
> +		if (ret == 0)
> +			power_supply_changed(bq->charger);
>  		break;
>  	}
> -
> -	return;
> -
> -error:
> -	dev_err(bq->dev, "Error switching to boost/charger mode.\n");
>  }
>  
>  static int bq25890_usb_notifier(struct notifier_block *nb, unsigned long val,
> -- 
> 2.31.1
> 

-- 
Yauhen Kharuzhy
