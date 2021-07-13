Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D263C79B8
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jul 2021 00:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhGMWfY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Jul 2021 18:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbhGMWfX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Jul 2021 18:35:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D4C0613DD;
        Tue, 13 Jul 2021 15:32:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t5so623598wrw.12;
        Tue, 13 Jul 2021 15:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3Y86rds+qthTs+3jeWO/3jomPKWg78OdmsOc8VtLnBI=;
        b=W39CAfIRXwTWrKvQOtsx61xG7xI9Jc3tYx5DUlZcQcJW8IsPEDmIR4x1dizFyoq2t0
         xECGqCTOEaXZiStggEPXMOyhccM1zHbGGW77HGFdbT6IF/+Kwky7pt1qjiR521S3K/7h
         +H6Nc/gVBjtd0uK+3lMool/2i9Hrz/AfY5q2XH8yA5H0JR53qvKUjm6CZBhtxkWeSl8b
         alj0iUjH4+BWYAIV63iu/nqKMT0zOlKtoaFUL3s10Qr9RLu3JJBHmm0hjL8Wvn1fxHY2
         lA09iGr8qXq6Wv2oLnTg3TvinYFGxWRlKP1n7GqLvDTEkzOlvNA+WKcSLq3PF8r/qhiG
         5eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3Y86rds+qthTs+3jeWO/3jomPKWg78OdmsOc8VtLnBI=;
        b=DUd4wla56rKcB9LHAFwcIsZXX4eu9R1f21uKbFXVdPi3ugKvSRv0Vt2SzSDgtHngVg
         Ya/rJTMfLmoysRKi7njCpOy5mpRVoAAGEwBOp5DjzbSStESTiZN/WelA+4bmrHiP4mh+
         kmr6vsGohEhnzUyfqjhQ8DAGG2tgXWtGfE8lZtD3m4WS6QX5btwTca9fVhs+M2A+Ewl8
         kX6pFRYXrHP4R9hEZANt5qOTSyCgaumXaIc10N5zy818hLlfpO19ERjrfQZmto+5cqhk
         6wm5Jv0vr/Rs2jXjGWu1sz8Yxm7ln1Kh7v9fpLv9j2EugtGU8H0a8p2L4G2Q2+oovmDv
         p5aw==
X-Gm-Message-State: AOAM530mUgcP0jm4kzNuFOaf32ml/JsYuKJKqCmGFwjCbr2RBlpccj0Y
        KDsOn0bDwHqSrE93p5Qi8meS4CHRJc8=
X-Google-Smtp-Source: ABdhPJxm9Po+KvV1TqfW2KOBH0KZ+3/WqUVunDpah1FTOg9MWc61MCOCJr/qsSJGhTezyFmXUOCfqw==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr8731903wru.253.1626215550711;
        Tue, 13 Jul 2021 15:32:30 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.111])
        by smtp.gmail.com with ESMTPSA id q19sm3388948wmq.38.2021.07.13.15.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 15:32:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] ACPI: utils: Fix reference counting in
 for_each_acpi_dev_match()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-media@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
References: <20210712182121.2936794-1-andy.shevchenko@gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <d542bc45-6e52-dc12-69bf-76fa6dcaaf5e@gmail.com>
Date:   Tue, 13 Jul 2021 23:32:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712182121.2936794-1-andy.shevchenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Andy - thanks for fixing this

On 12/07/2021 19:21, Andy Shevchenko wrote:
> Currently it's possible to iterate over the dangling pointer in case the device
> suddenly disappears. This may happen becase callers put it at the end of a loop.
>
> Instead, let's move that call inside acpi_dev_get_next_match_dev().
>
> Fixes: 803abec64ef9 ("media: ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver")
> Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro")
> Fixes: edbd1bc4951e ("efi/dev-path-parser: Switch to use for_each_acpi_dev_match()")
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Daniel Scally <djrscally@gmail.com>


> ---
> v2:
> - rebased on top of v5.14-rc1 and hence added fix for EFI code
> - added kernel documentation update to point out that
>   acpi_dev_get_next_match_dev() drops a reference on the given
>   ACPI device (Rafael)
>
>  drivers/acpi/utils.c                       | 7 +++----
>  drivers/firmware/efi/dev-path-parser.c     | 1 -
>  drivers/media/pci/intel/ipu3/cio2-bridge.c | 6 ++----
>  include/acpi/acpi_bus.h                    | 5 -----
>  4 files changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index e7ddd281afff..d5cedffeeff9 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -860,11 +860,9 @@ EXPORT_SYMBOL(acpi_dev_present);
>   * Return the next match of ACPI device if another matching device was present
>   * at the moment of invocation, or NULL otherwise.
>   *
> - * FIXME: The function does not tolerate the sudden disappearance of @adev, e.g.
> - * in the case of a hotplug event. That said, the caller should ensure that
> - * this will never happen.
> - *
>   * The caller is responsible for invoking acpi_dev_put() on the returned device.
> + * On the other hand the function invokes  acpi_dev_put() on the given @adev
> + * assuming that its reference counter had been increased beforehand.
>   *
>   * See additional information in acpi_dev_present() as well.
>   */
> @@ -880,6 +878,7 @@ acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const cha
>  	match.hrv = hrv;
>  
>  	dev = bus_find_device(&acpi_bus_type, start, &match, acpi_dev_match_cb);
> +	acpi_dev_put(adev);
>  	return dev ? to_acpi_device(dev) : NULL;
>  }
>  EXPORT_SYMBOL(acpi_dev_get_next_match_dev);
> diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
> index 10d4457417a4..eb9c65f97841 100644
> --- a/drivers/firmware/efi/dev-path-parser.c
> +++ b/drivers/firmware/efi/dev-path-parser.c
> @@ -34,7 +34,6 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
>  			break;
>  		if (!adev->pnp.unique_id && node->acpi.uid == 0)
>  			break;
> -		acpi_dev_put(adev);
>  	}
>  	if (!adev)
>  		return -ENODEV;
> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> index 4657e99df033..59a36f922675 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> @@ -173,10 +173,8 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>  	int ret;
>  
>  	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> -		if (!adev->status.enabled) {
> -			acpi_dev_put(adev);
> +		if (!adev->status.enabled)
>  			continue;
> -		}
>  
>  		if (bridge->n_sensors >= CIO2_NUM_PORTS) {
>  			acpi_dev_put(adev);
> @@ -185,7 +183,6 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>  		}
>  
>  		sensor = &bridge->sensors[bridge->n_sensors];
> -		sensor->adev = adev;
>  		strscpy(sensor->name, cfg->hid, sizeof(sensor->name));
>  
>  		ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
> @@ -215,6 +212,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>  			goto err_free_swnodes;
>  		}
>  
> +		sensor->adev = acpi_dev_get(adev);
>  		adev->fwnode.secondary = fwnode;
>  
>  		dev_info(&cio2->dev, "Found supported sensor %s\n",
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 1ae993fee4a5..b9d434a93632 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -707,11 +707,6 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
>   * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
>   *
>   * The caller is responsible for invoking acpi_dev_put() on the returned device.
> - *
> - * FIXME: Due to above requirement there is a window that may invalidate @adev
> - * and next iteration will use a dangling pointer, e.g. in the case of a
> - * hotplug event. That said, the caller should ensure that this will never
> - * happen.
>   */
>  #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
>  	for (adev = acpi_dev_get_first_match_dev(hid, uid, hrv);	\
