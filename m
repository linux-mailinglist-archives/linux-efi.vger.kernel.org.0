Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CDA45412B
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 07:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhKQGuF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 01:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhKQGuF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Nov 2021 01:50:05 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349DEC061570;
        Tue, 16 Nov 2021 22:47:07 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y8so1315041plg.1;
        Tue, 16 Nov 2021 22:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K8hQ7EoGLHPzJEOUqLh53x2PqG5Z11xoXxWoUxixwAo=;
        b=ZObv9d0suY83gCtzvLDJPyTu3SblNRysv9327yg4BpeCIJmkHAHMzR9CqmD7mRq9Kc
         P6S/1JEmwjCTTU4Ky23LCklK1R5sbReRI9O+S24gAdSTiJGlzuwxvxp0XzrIaZAS7BA7
         y8Ly1UfkDbRxLqH+ympZF9ct+65ZmTtVIq2dLd0z7kqKVBqgj+M6UMoUpHskmxTXvRbi
         WD6/hvCZdswytO0MaH4WziR+qXsQGMWue3bhu0gVMO7xnqMTVTtIKRqtO1+q8SHiiBSW
         ydS/UCxrDqCXV/C4+ow33fblAMFKhQFzFYbF1QnMghY6QgTwUFZAAxLnju5iFXjn+MoS
         NIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K8hQ7EoGLHPzJEOUqLh53x2PqG5Z11xoXxWoUxixwAo=;
        b=gTET7QTTpSeBLwo7B4StKe+1BSJk9015rsZf7HTflNkrlRi6RvKTBwqwaTXlN3ekgA
         9KASG+evAujvyPj89ptaRl19VCgBHAIpN1ggskrK/iwHyEIbt0c6reoi375mgJuZ7ibV
         KwS/qeCvA6brA9ytfRx4PfFi2BXIFG2eE0TMlP3MaHbMkc2zlHfDFh78tfu4qGrDt4TC
         MQlRIbWVR1/cYsqUmFC2EZMjq1WBiP7bYBICqeBWiO0KBf2wxdUs9iONDoXflmvb/lf5
         HjwznOgfXAGvygv5EL9xCzxC1wXRZqyIsodLfuJN3Le+ZqUZfcJPc55LILaXUAPsvRXt
         sKfA==
X-Gm-Message-State: AOAM533YOlGzBDp5uZ+PO6deg+WQtkAhnY/x3ErWOH31ANIkFauLZSvG
        zmGYaGNPQlkgxZHgxWsmCkJ2oSSnCDM=
X-Google-Smtp-Source: ABdhPJzc8lIml+nVKxr+aa73T3c6vvLM/h3aDDWDI9Ge2UeEStvAY9/ye9hFpdf6zkHlg7ooIanXog==
X-Received: by 2002:a17:903:408d:b0:142:22f1:5886 with SMTP id z13-20020a170903408d00b0014222f15886mr52836128plc.34.1637131626311;
        Tue, 16 Nov 2021 22:47:06 -0800 (PST)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id 95sm4126303pjo.2.2021.11.16.22.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 22:47:05 -0800 (PST)
Subject: Re: [PATCH v2 16/20] extcon: intel-cht-wc: Use new
 intel_cht_wc_get_model() helper
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-17-hdegoede@redhat.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <5653c424-e12a-e889-1ae5-14a768dcf221@gmail.com>
Date:   Wed, 17 Nov 2021 15:47:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211114170335.66994-17-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 21. 11. 15. 오전 2:03, Hans de Goede wrote:
> The CHT_WC_VBUS_GPIO_CTLO GPIO actually driving an external 5V Vboost
> converter for Vbus depends on the board on which the Cherry Trail -
> Whiskey Cove PMIC is actually used.
> 
> Since the information about the exact PMIC setup is necessary in other
> places too, the drivers/mfd/intel_soc_pmic_chtwc.c code now has a new
> intel_cht_wc_get_model() helper.
> 
> Only poke the CHT_WC_VBUS_GPIO_CTLO GPIO if this new helper returns
> INTEL_CHT_WC_GPD_WIN_POCKET, which indicates the Type-C (with PD and
> DP-altmode) setup used on the GPD pocket and GPD win; and on which
> this GPIO actually controls an external 5V Vboost converter.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/extcon/extcon-intel-cht-wc.c | 35 +++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 771f6f4cf92e..a5aeeecc44fb 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -14,6 +14,7 @@
>   #include <linux/module.h>
>   #include <linux/mod_devicetable.h>
>   #include <linux/platform_device.h>
> +#include <linux/property.h>
>   #include <linux/regmap.h>
>   #include <linux/slab.h>
>   
> @@ -358,20 +359,26 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>   	if (IS_ERR(ext->edev))
>   		return PTR_ERR(ext->edev);
>   
> -	/*
> -	 * When a host-cable is detected the BIOS enables an external 5v boost
> -	 * converter to power connected devices there are 2 problems with this:
> -	 * 1) This gets seen by the external battery charger as a valid Vbus
> -	 *    supply and it then tries to feed Vsys from this creating a
> -	 *    feedback loop which causes aprox. 300 mA extra battery drain
> -	 *    (and unless we drive the external-charger-disable pin high it
> -	 *    also tries to charge the battery causing even more feedback).
> -	 * 2) This gets seen by the pwrsrc block as a SDP USB Vbus supply
> -	 * Since the external battery charger has its own 5v boost converter
> -	 * which does not have these issues, we simply turn the separate
> -	 * external 5v boost converter off and leave it off entirely.
> -	 */
> -	cht_wc_extcon_set_5v_boost(ext, false);
> +	switch (intel_cht_wc_get_model()) {

intel_cht_wc_get_model() is defined in driver/mfd/intel_soc_pmic_chtwc.c

Usually, mfd drivers share the data structure such as struct 
intel_soc_pmic. But, didn't call the exported function for only
specific driver between linux kernel framework (extcon vs. mfd).

So that I think that you better to update the mode information
to 'struct intel_soc_pmic' data structure and then use it
instead of using the exported function which may make the confusion.

> +	case INTEL_CHT_WC_GPD_WIN_POCKET:
> +		/*
> +		 * When a host-cable is detected the BIOS enables an external 5v boost
> +		 * converter to power connected devices there are 2 problems with this:
> +		 * 1) This gets seen by the external battery charger as a valid Vbus
> +		 *    supply and it then tries to feed Vsys from this creating a
> +		 *    feedback loop which causes aprox. 300 mA extra battery drain
> +		 *    (and unless we drive the external-charger-disable pin high it
> +		 *    also tries to charge the battery causing even more feedback).
> +		 * 2) This gets seen by the pwrsrc block as a SDP USB Vbus supply
> +		 * Since the external battery charger has its own 5v boost converter
> +		 * which does not have these issues, we simply turn the separate
> +		 * external 5v boost converter off and leave it off entirely.
> +		 */
> +		cht_wc_extcon_set_5v_boost(ext, false);
> +		break;
> +	default:
> +		break;
> +	}
>   
>   	/* Enable sw control */
>   	ret = cht_wc_extcon_sw_control(ext, true);
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
