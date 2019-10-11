Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378FBD367C
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 02:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfJKArb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Oct 2019 20:47:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45808 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfJKAra (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Oct 2019 20:47:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so3548886pgj.12;
        Thu, 10 Oct 2019 17:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JczpVAzRBwwAOYFIGonlJX1sjgIClw2IMnks9yUvCfI=;
        b=XYUsDF5LK7A0bep4RfUjjO6eu7m00xiDrfzh+6ctTRAPT9U9rGrm1f18yhoiC0yNuv
         Nh6Q/vQBZAQi46sXFInFLsQG0rJ1TvPS5C1Tzn9S2554Cx/vjGYs8EZZxhQbjpFJJD6E
         mq8y5nzxGtZqZ1HZVJIwUBzjLVcdQnK48XQKSiZxCb5muTP28sGxfiW6xttjRfoJz1zx
         NeVb7DJA0yv4PR4ePzAAkYf/zV1zufAalbNWeepOGoaGE35/H2qLJoSmoA/Zwa9D29j3
         KdTdgOaUArg8q/IgOcapzDuoHM5mLyE0yT9A/fXjWCpAe9PjwgLrM34bKVinTnpaDnwf
         ODjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JczpVAzRBwwAOYFIGonlJX1sjgIClw2IMnks9yUvCfI=;
        b=HpU5WoO+kB1v8CJVMiWALXKWGQ4HAjWji8I9PqE4xNRImHSWREkqflqJYgLFtGMv/q
         hEGnt4K2wFRtt5tIv8VzcCT6TPjK9vrU3CfVX92DxGwjETIRKQZp4uIAan8F+xEvLHa1
         TKTcnbNRFDb6+/WFC1SSfgc+JOjJsqe/ppyfxJ9vHQVGtIAiNRSuTe1Xs5Nxl97E2rx+
         S2YmYgIFd2mV2OnhPC68i9AeOOnskX7PogCqS7l+wvsKYk2fEDzPGC3s/GFtJFn1NmH+
         wPp24bc2rS/d6I5Wqai8TN8Uuy5f6loavNmz6XdTJdK2h8Svkcw5/lvn58/83woF7E2E
         9oAQ==
X-Gm-Message-State: APjAAAX+Vn15IDVtXusV+n3pC0M8VclZxB8OTvsdzoYMyBynVcfLnPSk
        3Lb3shHs+x12rYkCO2Lmi32qV+Dx
X-Google-Smtp-Source: APXvYqzLzsgjSK5rwCHu1G+VT4kiDmY0wF5F/U3chf6VGS4WhHCVPn+dKofGWhykmg9t9+gtci7OYg==
X-Received: by 2002:a65:66d1:: with SMTP id c17mr13897375pgw.169.1570754848017;
        Thu, 10 Oct 2019 17:47:28 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d76sm7692503pfd.185.2019.10.10.17.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:47:27 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:47:24 -0700
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
Subject: Re: [PATCH v7 5/8] Input: silead - Switch to
 firmware_request_platform for retreiving the fw
Message-ID: <20191011004724.GC229325@dtor-ws>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-6-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 04, 2019 at 04:50:53PM +0200, Hans de Goede wrote:
> Unfortunately sofar we have been unable to get permission to redistribute
> Silead touchscreen firmwares in linux-firmware. This means that people
> need to find and install the firmware themselves before the touchscreen
> will work
> 
> Some UEFI/x86 tablets with a Silead touchscreen have a copy of the fw
> embedded in their UEFI boot-services code.
> 
> This commit makes the silead driver use the new firmware_request_platform
> function, which will fallback to looking for such an embedded copy when
> direct filesystem lookup fails. This will make the touchscreen work OOTB
> on devices where there is a fw copy embedded in the UEFI code.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/touchscreen/silead.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index ad8b6a2bfd36..8fa2f3b7cfd8 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -288,7 +288,7 @@ static int silead_ts_load_fw(struct i2c_client *client)
>  
>  	dev_dbg(dev, "Firmware file name: %s", data->fw_name);
>  
> -	error = request_firmware(&fw, data->fw_name, dev);
> +	error = firmware_request_platform(&fw, data->fw_name, dev);
>  	if (error) {
>  		dev_err(dev, "Firmware request error %d\n", error);
>  		return error;
> -- 
> 2.23.0
> 

-- 
Dmitry
