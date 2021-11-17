Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A43A4541A8
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 08:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhKQHTE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 02:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhKQHTD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Nov 2021 02:19:03 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE323C061570;
        Tue, 16 Nov 2021 23:16:05 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b13so1370687plg.2;
        Tue, 16 Nov 2021 23:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rIrkP0DhReUnuC45R3StNf8dVDdMxxV3+wuwmqd5zGA=;
        b=YhedbSwQuIunJGK0+bpJydFa6uMjQxX6SvMswYXaFUV7VzSJOKakUhVORTWNi+CoeP
         x5ATidWzhP5TcxX/M81ZRxCkeY0b6NAXTIVeoR8v92p6AbTtWrvxJNahwIUCRbQLhqNI
         ongHZAU2yXW4wHn5J7Uv1nXV70DWoDtBfaUZKNZM3D73TOQyzKCLu+1MhcakCRm+IbRC
         1D6gselZo/oIvfs1XmSslYEpgdn7eSQCVesE6Z0aW/MbHKmgScpulpOk/IrfQuPMLEdi
         sBiPl0C6lRjSQRFHHBroK5z8yFwQikOmzh7R9C8hNHIebJErzNyYa+SoRQNdxJFiipDk
         9KqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rIrkP0DhReUnuC45R3StNf8dVDdMxxV3+wuwmqd5zGA=;
        b=5IS908UBXwIB031nK7xUQCgrCf3+CNplFzOX6H/D3p1GQvUIkJx7xs+3l0qZu+DjzO
         /SNZ0fD3ODydPdGnZhuwI8zdqaYzSnN83xp1gMTQLzhi9KpcgIalLA46zQXNhy+/hPOQ
         qagfzQXnm5YuMLwqhm8nzwhCkZk/dLSLc2XPDBCsVcbkax7k31gQMIG7IWNDXjtjlz1L
         UB9708D0o0wQVRHfZXd4/WrSjJG1eQgPMZJnCDgGyr6hKh4+QfKjD2VsZTXElMNYDyVL
         tMgikyb60nU9k+h1t0C3Z6P4UTPZCKiRyXhi6nscARkb13lz9qPPCWg+j4OntZcWpPiq
         gDcg==
X-Gm-Message-State: AOAM531ujJYb1yN2qbYzozkTCtCD/FqUB0yvxsbyezaFzxuKQVXrOgzx
        iD69xaKGp8/rt1Hh9Je/Bsod/5BrYvk=
X-Google-Smtp-Source: ABdhPJxQoHG0o9y0cEa3j9C/XHz9ohnWloI1n996YG+5JQ1EDhe8ucwfq/DSgh0jRYXgJAptuDMZMg==
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr6903896pjb.204.1637133364664;
        Tue, 16 Nov 2021 23:16:04 -0800 (PST)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id bf19sm4268688pjb.6.2021.11.16.23.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 23:16:03 -0800 (PST)
Subject: Re: [PATCH v2 18/20] extcon: intel-cht-wc: Refactor
 cht_wc_extcon_get_charger()
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
 <20211114170335.66994-19-hdegoede@redhat.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <f84e2060-f6b7-64f9-78cd-e8ad8776ab2d@gmail.com>
Date:   Wed, 17 Nov 2021 16:15:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211114170335.66994-19-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

I think that you need to squash it with patch21
I'm not sure that this patch is either atomic or not because
you remove the 'return EXTCON_CHG_USB_SDP/EXTCON_CHG_USB_SDP'
without explaining why it is no problem. Just mention that
pass the role to next 'switch' cases. But, before this change,
there were any reason to return the type of charger cable
before switch statement.

According to your patch description, you don't need
to make the separate patch of it. Please squash it with patch21.

On 21. 11. 15. 오전 2:03, Hans de Goede wrote:
> Refactor cht_wc_extcon_get_charger() to have all the returns are in
> the "switch (usbsrc)" cases.
> 
> This is a preparation patch for adding support for registering
> a power_supply class device.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/extcon/extcon-intel-cht-wc.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 119b83793123..f2b93a99a625 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -153,14 +153,15 @@ static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext,
>   	} while (time_before(jiffies, timeout));
>   
>   	if (status != CHT_WC_USBSRC_STS_SUCCESS) {
> -		if (ignore_errors)
> -			return EXTCON_CHG_USB_SDP; /* Save fallback */
> +		if (!ignore_errors) {
> +			if (status == CHT_WC_USBSRC_STS_FAIL)
> +				dev_warn(ext->dev, "Could not detect charger type\n");
> +			else
> +				dev_warn(ext->dev, "Timeout detecting charger type\n");
> +		}
>   
> -		if (status == CHT_WC_USBSRC_STS_FAIL)
> -			dev_warn(ext->dev, "Could not detect charger type\n");
> -		else
> -			dev_warn(ext->dev, "Timeout detecting charger type\n");
> -		return EXTCON_CHG_USB_SDP; /* Save fallback */
> +		/* Save fallback */
> +		usbsrc = CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT;
>   	}
>   
>   	usbsrc = (usbsrc & CHT_WC_USBSRC_TYPE_MASK) >> CHT_WC_USBSRC_TYPE_SHIFT;
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
