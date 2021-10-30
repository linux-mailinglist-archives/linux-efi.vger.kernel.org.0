Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A655440B69
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 21:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhJ3TKB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhJ3TKB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 15:10:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE036C061570;
        Sat, 30 Oct 2021 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=bmy4IYSKZwvwFVeSRZbDjHhDmJTOl/4idb6IkNEJeuw=; b=tXebt0Ch+iH3QwCdQqe/ybO+jv
        q9JY/iIPB6mzFo8isjNI+2z/X38joq2un0HRrabrnsfPvqq3JPLKVk62QEWbUtqWvTiB8HMBTzlDT
        NRQ3KW0PyStFt1msEN5N6s3/+75pHAtgLafXcVQQlGeVn9kJvoAH4oNuPF/9EfYtLm7jEIpKfd8/v
        gFNoUI2pnCwsU+BY10b8Wwgx5//HUbIQOu7BLgSkJdcwpZ9lHLBX2zopif69bdDZKW8CRN6RVqUeR
        dB6DTL+V60Ro34a422xHrw6CWdV9J3ktE+k5sY7IEW5GsMd4l88FD8+MMzhQKwPhYflZBQ6OaH49h
        m7bXiKVQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgthM-00DSqD-Mh; Sat, 30 Oct 2021 19:07:24 +0000
Subject: Re: [PATCH 01/13] platform/x86: Rename touchscreen_dmi to
 dmi_device_properties
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-2-hdegoede@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c01f2bf6-1385-3cf8-d180-9051494fc04e@infradead.org>
Date:   Sat, 30 Oct 2021 12:07:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211030182813.116672-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi--

On 10/30/21 11:28 AM, Hans de Goede wrote:
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index b110a2e6b8f3..9cb8d33cc6e1 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -981,17 +981,19 @@ config MLX_PLATFORM
>   
>   	  If you have a Mellanox system, say Y or M here.
>   
> -config TOUCHSCREEN_DMI
> -	bool "DMI based touchscreen configuration info"
> -	depends on ACPI && DMI && I2C=y && TOUCHSCREEN_SILEAD
> +config DMI_DEVICE_PROPERTIES
> +	bool "DMI based extra device properties"

	      DMI-based

> +	depends on ACPI && DMI && I2C=y
>   	select EFI_EMBEDDED_FIRMWARE if EFI
>   	help
> -	  Certain ACPI based tablets with e.g. Silead or Chipone touchscreens
> -	  do not have enough data in ACPI tables for the touchscreen driver to
> -	  handle the touchscreen properly, as OEMs expect the data to be baked
> -	  into the tablet model specific version of the driver shipped with the
> -	  the OS-image for the device. This option supplies the missing info.
> -	  Enable this for x86 tablets with Silead or Chipone touchscreens.
> +	  Sometimes ACPI based x86 devices do not have enough data in their ACPI

	            ACPI-based

> +	  tables to fully describe the hardware. This option enables support for
> +	  supplying the missing info based on DMI (vendor & model string)
> +	  matching for devices where this info has been added to the
> +	  dmi-device-properties code.
> +
> +	  This option is often necessary for correct operation of x86 based

	                                                          x86-based

> +	  tablets and 2-in-1 devices. If in doubt, say Y here.


-- 
~Randy
