Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486FF4474F5
	for <lists+linux-efi@lfdr.de>; Sun,  7 Nov 2021 19:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhKGSev (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Nov 2021 13:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhKGSeu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 Nov 2021 13:34:50 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D8EC061570;
        Sun,  7 Nov 2021 10:32:07 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id i26so25118997ljg.7;
        Sun, 07 Nov 2021 10:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xEe8YV5zex3IUUrlwlsM+jxA0ZmD/oEVxilzDfJY8Pg=;
        b=RD8zj1qKsRG/JOkdoiwYZmqWdLyjc3C5BtBAFeNz4BR6DSobtFrM2kQr2NeiTz3vsA
         vljFQG7sD/nHA6h/q2jPizipw5nvtHY3mFZSLtP4Tvc/NP0ZAkq/4nKygRo9dRscE0Fh
         yWu0grWpVIbuewkxNzn8Jq884n8d1tff939crbTGsgAi/Vkg3YtsMhQjo0kgC9BPb6J9
         sA9PBRDRudczpD4+LI64MDitpg9nkWv7ZbefyrEDyWupHglNxgkltaeSTavfLl2SpjNW
         iQglvNH/a8aItKa1D+9mNy4kZpVmS9yewZniE1iRaWoIq38JW7c81v2eVnpjv7LpONwn
         mfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xEe8YV5zex3IUUrlwlsM+jxA0ZmD/oEVxilzDfJY8Pg=;
        b=5R6Amkixn9Ek/bqGMDS5/O/1FLL+3HB083BqLKyWUDtz7wq7Zbs7slqmkLXGxWxzUe
         cpxtSTjbe6ORMD6rsez8CswttNVRqWL4y+L8OiUDpiw/oAQwzHWx95QVq4bmif9I2eHj
         eDV3WM6nGVaOvR7jOU6jwQb6GUZpcEmXeZlTuffOwwTBMyJbMwsVugBifN8yNUN1R40J
         f5FE3heFFd+3WZ3iR4P2T8P/OR8azcL/rXEepJ0PcLTe1XwXQWChIov0tUgKjD82vWHd
         G86dqT8J4AoL+7dOrxENWYWQKexC+owrHL5FFDF/w1Rs4EV/GpFDPXyWLHAelvrGhLTM
         Byfg==
X-Gm-Message-State: AOAM5334B+63kKC876D7NkR6rEjQ+F52NT2h57UWy0KznZ8Vo05e0omQ
        5b1RDd6HQTCZ7Qe87V40ZB8Nk1aQqoBo4d55HqI=
X-Google-Smtp-Source: ABdhPJyHP5yN4c6XQspvRyl4zuWAcRgxKsnsKGLghX1/QQQB4WWTaLB8IGGE1DvN88n9Mgw+2/DxJA==
X-Received: by 2002:a05:651c:1503:: with SMTP id e3mr26097662ljf.181.1636309925445;
        Sun, 07 Nov 2021 10:32:05 -0800 (PST)
Received: from localhost.localdomain ([37.45.143.17])
        by smtp.gmail.com with ESMTPSA id i13sm337351lfe.233.2021.11.07.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 10:32:04 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mjmxX-000Ddu-Nd;
        Sun, 07 Nov 2021 21:32:03 +0300
Date:   Sun, 7 Nov 2021 21:32:03 +0300
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
Subject: Re: [PATCH 07/13] power: supply: bq25890: Enable charging on boards
 where we skip reset
Message-ID: <YYgbo0wySBbUZSmx@jeknote.loshitsa1.net>
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-8-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030182813.116672-8-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 30, 2021 at 08:28:07PM +0200, Hans de Goede wrote:
> On boards where the "ti,skip-init" boolean property is set we don't reset
> the charger; and on some boards where the fw takes care of initalizition
> F_CHG_CFG is set to 0 before handing control over to the OS.
> 
> Explicitly set F_CHG_CFG to 1 on boards where we don't reset the charger,
> so that charging is always enabled on these boards, like it is always
> enabled on boards where we do reset the charger.

We should check if an OTG host mode with powering of bus by bq25890 is
not enabled before enable charging. If we boot with OTG device
connected, this can cause troubles.

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 280821a6a6c6..aa4d04d20cdc 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -689,6 +689,17 @@ static int bq25890_hw_init(struct bq25890_device *bq)
>  			dev_dbg(bq->dev, "Reset failed %d\n", ret);
>  			return ret;
>  		}
> +	} else {
> +		/*
> +		 * Ensure charging is enabled, on some boards where the fw
> +		 * takes care of initalizition F_CHG_CFG is set to 0 before
> +		 * handing control over to the OS.
> +		 */
> +		ret = bq25890_field_write(bq, F_CHG_CFG, 1);
> +		if (ret < 0) {
> +			dev_dbg(bq->dev, "Enabling charging failed %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	/* disable watchdog */
> -- 
> 2.31.1
> 

-- 
Yauhen Kharuzhy
