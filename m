Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5746478864
	for <lists+linux-efi@lfdr.de>; Fri, 17 Dec 2021 11:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhLQKJI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Dec 2021 05:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhLQKJH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Dec 2021 05:09:07 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D915EC061574
        for <linux-efi@vger.kernel.org>; Fri, 17 Dec 2021 02:09:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t18so2973532wrg.11
        for <linux-efi@vger.kernel.org>; Fri, 17 Dec 2021 02:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=n+YbVGAkqXP7PNsKwcT3CjJ8IfCXro/+lbWQf9Na6IY=;
        b=YQPToKZO2L1+/Jp9JTCHBiTeUenosTzut1YioFA8go6CfazZ1hb01A+c+NnddYSLka
         6kXt/3yBtLzSNddXvU9qGnfFwQfkjfX3kc9iAP6kVuJxDE4+8v9vbnsoc4AdyOfq8VcU
         mKSxeV8lN7S4Ynswm4g9hAgObhvAMEfF961NfHxvQrMAUXhtVx7x5N6BiwQlIkHDEF6M
         naPoLVi8HpUQ/3U8z89bbmg8LF1liWCFGkQHj2sMcPWl5aKrVViXgY7onGzAavfAr9z6
         KQOjTF1ykpsaF86ksZEMfmZo9zjgaHs7GeL5a5nXbbrzYGKmV8X6GR0BKmjsp4/OTttW
         uNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n+YbVGAkqXP7PNsKwcT3CjJ8IfCXro/+lbWQf9Na6IY=;
        b=cdv8t95lAPjlUr7g5ey2yVsHc2PP72yHHUKHxiRje33cm9FdoYjMGyUVqyg2OSlNEZ
         LEQgClNjfIlVQ/DpxVdHcbcflJ1SYSgxn89hDj6cY6obrp+GU0Jvd0HKFyMrPYZkEDPB
         ToDeuxtkgqDaBiSxedxK1pxDiUbn7powUwMlaBribDBD3O3chCi90g6rVoBQfIZBJWr8
         5qxbJ/dudarNS9VL2zspauQVAh0BtAqdwfJNPtI8RL3YQWDE7tJWyT7sJzgRCwXooI9H
         EuUtnbskGTG+Kd38gSOspceZagqRRkdHruflzNxqvIsDgxRC2WjoT03OG9PuNJ3gOEqL
         5LyA==
X-Gm-Message-State: AOAM532zPByRax7lNfE8DBhrsXgGLCPiwUgAf//jAPNUofD1bvqdmZQ7
        VLUn8BccttqpmXo95uoIJLaErQ==
X-Google-Smtp-Source: ABdhPJyeYq83KgmGcHrxXJdvJn8Xm3CjiDEwUAwqxGagBcrQ+NX6Ld1B/KV07XAB9B48wvadGO120g==
X-Received: by 2002:adf:906d:: with SMTP id h100mr1833018wrh.259.1639735745366;
        Fri, 17 Dec 2021 02:09:05 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id o4sm5301113wry.80.2021.12.17.02.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 02:09:04 -0800 (PST)
Date:   Fri, 17 Dec 2021 10:09:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 14/20] mfd: intel_soc_pmic_chtwc: Add cht_wc_model
 data to struct intel_soc_pmic
Message-ID: <Ybxhvk5rB+82WaU5@google.com>
References: <20211206093318.45214-1-hdegoede@redhat.com>
 <20211206093318.45214-15-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211206093318.45214-15-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 06 Dec 2021, Hans de Goede wrote:

> Tablet / laptop designs using an Intel Cherry Trail x86 main SoC with
> an Intel Whiskey Cove PMIC do not use a single standard setup for
> the charger, fuel-gauge and other chips surrounding the PMIC /
> charging+data USB port.
> 
> Unlike what is normal on x86 this diversity in designs is not handled
> by the ACPI tables. On 2 of the 3 known designs there are no standard
> (PNP0C0A) ACPI battery devices and on the 3th design the ACPI battery
> device does not work under Linux due to it requiring non-standard
> and undocumented ACPI behavior.
> 
> So to make things work under Linux we use native charger and fuel-gauge
> drivers on these devices, re-using the native drivers used on ARM boards
> with the same charger / fuel-gauge ICs.
> 
> This requires various MFD-cell drivers for the CHT-WC PMIC cells to
> know which model they are exactly running on so that they can e.g.
> instantiate an I2C-client for the right model charger-IC (the charger
> is connected to an I2C-controller which is part of the PMIC).
> 
> Rather then duplicating DMI-id matching to check which model we are
> running on in each MFD-cell driver, add a check for this to the
> shared drivers/mfd/intel_soc_pmic_chtwc.c code by using a
> DMI table for all 3 known models:
> 
> 1. The GPD Win and GPD Pocket mini-laptops, these are really 2 models
> but the Pocket re-uses the GPD Win's design in a different housing:
> 
> The WC PMIC is connected to a TI BQ24292i charger, paired with
> a Maxim MAX17047 fuelgauge + a FUSB302 USB Type-C Controller +
> a PI3USB30532 USB switch, for a fully functional Type-C port.
> 
> 2. The Xiaomi Mi Pad 2:
> 
> The WC PMIC is connected to a TI BQ25890 charger, paired with
> a TI BQ27520 fuelgauge, using the TI BQ25890 for BC1.2 charger type
> detection, for a USB-2 only Type-C port without PD.
> 
> 3. The Lenovo Yoga Book YB1-X90 / Lenovo Yoga Book YB1-X91 series:
> 
> The WC PMIC is connected to a TI BQ25892 charger, paired with
> a TI BQ27542 fuelgauge, using the WC PMIC for BC1.2 charger type
> detection and using the BQ25892's Mediatek Pump Express+ (1.0)
> support to enable charging with up to 12V through a micro-USB port.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v4:
> - Put '{' and comment of DMI entries on separate lines (requested by Lee)
> - Drop comment on terminating empty entry in DMI table
> 
> Changes in v3:
> - Store the model in struct intel_soc_pmic instead of adding a helper
>   function to retreive it
> 
> Changes in v2:
> - New patch in v2 of this patch-set
> ---
>  drivers/mfd/intel_soc_pmic_chtwc.c | 40 ++++++++++++++++++++++++++++++
>  include/linux/mfd/intel_soc_pmic.h |  8 ++++++
>  2 files changed, 48 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
