Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4125FD3682
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 02:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfJKAsE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Oct 2019 20:48:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41559 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfJKAsE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Oct 2019 20:48:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id t10so3629793plr.8;
        Thu, 10 Oct 2019 17:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ETkbKQ05O2dMgkNycPpQVBwLCdAj/RDEFMvpT31Ux5Y=;
        b=Zj/GSkEAIsW6/Hj5LpHp+UIaiS6HA2moMvIqo7XXXd4jtJ5ltiBYBMWqZhgVpvZkTg
         ItD6yLbI/7v5mDqRvJqDoHc9LQB5JUHYJiLcJvMFrdJDqxGW8fWkq72MnWenAarlKGvS
         bMbbllWxwhpfAWChsT6819vcv6rR5GHao+hDdBFw5B+qS2Fn/MEsvjU/qbiKR64F7SWs
         n2o0yICmO+TlAHQG5owjwGCDWM9dVi9/ZxOzx3jxyabP/wzzvDeyhVCdbV8aY4gIhRfS
         TKvtNM3kAA9lVPViPUmTstxCThqoRoSrscEC/7+IYOPj1NFcfqDVupo+g3IEx53iBGAI
         nmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ETkbKQ05O2dMgkNycPpQVBwLCdAj/RDEFMvpT31Ux5Y=;
        b=YPdHbywcqUKtw/600kIBAXQ4/2jWjq/M8f+biEj1JRn3PdMHYRs+syjbExXW56GNWR
         3zijBFipescvM/u4fP9ciJH/QGL455AMsfhv0kM+VXuuJ6mg1nv0QM97Mw/2KiwAENlt
         4bny/hGPaugtdhYbTRN7T3pVn0t7JFktMNXR40w9PDOAWJsezG8GUKRiyHzVmnlLJiJM
         poXzyda3MgFodsYvjFmIczJNn/XiN6A+xMeSfQPzWTgoXSvmSbklavqEokh90H3o444q
         Z+ar1o0Cw8eSHqAac6pJf31LBYbpxedycbyOEwToW1CyYRK/Hehdqo/QhHu1jRghbGsP
         o5MA==
X-Gm-Message-State: APjAAAWikUDKZqyAcekhErzwCQD1mKtKHgUqtQ8RKnr14sHzZtrQmu1p
        MzNHvWOj2wBateIRGWxQaEk=
X-Google-Smtp-Source: APXvYqw78u960V+A6kZKXgqbzv4NJaOehd9R02KWBPRr/QBxVXaeO/mbfXmlS+E62ZuZ/m/gwPzdlA==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9mr11980058plt.227.1570754882044;
        Thu, 10 Oct 2019 17:48:02 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e127sm7453781pfe.37.2019.10.10.17.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:48:01 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:47:59 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v7 6/8] Input: icn8505 - Switch to
 firmware_request_platform for retreiving the fw
Message-ID: <20191011004759.GD229325@dtor-ws>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-7-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 04, 2019 at 04:50:54PM +0200, Hans de Goede wrote:
> Unfortunately sofar we have been unable to get permission to redistribute
> icn8505 touchscreen firmwares in linux-firmware. This means that people
> need to find and install the firmware themselves before the touchscreen
> will work
> 
> Some UEFI/x86 tablets with an icn8505 touchscreen have a copy of the fw
> embedded in their UEFI boot-services code.
> 
> This commit makes the icn8505 driver use the new firmware_request_platform
> function, which will fallback to looking for such an embedded copy when
> direct filesystem lookup fails. This will make the touchscreen work OOTB
> on devices where there is a fw copy embedded in the UEFI code.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Feel free to merge with the rest of the series.

> ---
>  drivers/input/touchscreen/chipone_icn8505.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/chipone_icn8505.c b/drivers/input/touchscreen/chipone_icn8505.c
> index c768186ce856..f9ca5502ac8c 100644
> --- a/drivers/input/touchscreen/chipone_icn8505.c
> +++ b/drivers/input/touchscreen/chipone_icn8505.c
> @@ -288,7 +288,7 @@ static int icn8505_upload_fw(struct icn8505_data *icn8505)
>  	 * we may need it at resume. Having loaded it once will make the
>  	 * firmware class code cache it at suspend/resume.
>  	 */
> -	error = request_firmware(&fw, icn8505->firmware_name, dev);
> +	error = firmware_request_platform(&fw, icn8505->firmware_name, dev);
>  	if (error) {
>  		dev_err(dev, "Firmware request error %d\n", error);
>  		return error;
> -- 
> 2.23.0
> 

-- 
Dmitry
