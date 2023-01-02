Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2703865AFC2
	for <lists+linux-efi@lfdr.de>; Mon,  2 Jan 2023 11:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjABKr1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Jan 2023 05:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjABKr0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Jan 2023 05:47:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D422BF9;
        Mon,  2 Jan 2023 02:47:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18BA660F24;
        Mon,  2 Jan 2023 10:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75214C433F0;
        Mon,  2 Jan 2023 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672656444;
        bh=NNLP/vZpHU+PfmdYh2ChIRutfy40ix9EsAAO6zT8okM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SXIwWe8D29pCqSG8a5My/ezyADOXWvTOmkQXd1W76hwOcZN9jCqc8nGGg+O7/PjJZ
         miCrdP5gFreWlZhkstHX5w7FB9/2MHj67TGyK5SFJwC/C9wJctxpU1Xxwf8tJXn/ME
         dlOD6J49sIZKCLnh0Jca58RsHJflbrQCgFg86eFycr7t3AA9RFuiye2JgaeipGazMZ
         ioaejg2C8b8w619R0xcwKxRxFjxcpTrGHxKmjkonyYjyLP839EJGh+XgntjdQMmJRw
         B6mR81HEgTYBmn/TSZx2g9AafD47n/fDG2GCmTc/sG439rewS/0uzIWJo+ggDPmSmO
         zvzjXtprhdoDg==
Received: by mail-lf1-f49.google.com with SMTP id bp15so41074706lfb.13;
        Mon, 02 Jan 2023 02:47:24 -0800 (PST)
X-Gm-Message-State: AFqh2koulzhqpcpFY+z33v+fta8WciZP3g0+UuhLIcc0KOnzyucBmFcy
        OCgKMvF86231b1AODf9/XRCIiSelo8xBejxCMAM=
X-Google-Smtp-Source: AMrXdXtWDHlASI4f5M+PVE+/cTHXGxLZaLL/htM9ePTQtpm3kxfpYjYJmSBfBJXwcde8wUb8ps2z7WzNjgqBxjTg/4s=
X-Received: by 2002:ac2:4a72:0:b0:4b6:f37c:c123 with SMTP id
 q18-20020ac24a72000000b004b6f37cc123mr2805183lfp.539.1672656442482; Mon, 02
 Jan 2023 02:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20221227040925.1619833-1-sdonthineni@nvidia.com>
In-Reply-To: <20221227040925.1619833-1-sdonthineni@nvidia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Jan 2023 11:47:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG79-MxGJEwvnekqbVyeEMVHBfhNjwZkz91mMwv4-vT3Q@mail.gmail.com>
Message-ID: <CAMj1kXG79-MxGJEwvnekqbVyeEMVHBfhNjwZkz91mMwv4-vT3Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi: rtc: Enable SET/GET WAKEUP services as optional
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 27 Dec 2022 at 05:09, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>
> The current implementation of rtc-efi is expecting all the 4
> time services GET{SET}_TIME{WAKEUP} must be supported by UEFI
> firmware. As per the EFI_RT_PROPERTIES_TABLE, the platform
> specific implementations can choose to enable selective time
> services based on the RTC device capabilities.
>
> This patch does the following changes to provide GET/SET RTC
> services on platforms that do not support the WAKEUP feature.
>
> 1) Relax time services cap check when creating a platform device.
> 2) Clear RTC_FEATURE_ALARM bit in the absence of WAKEUP services.
> 3) Conditional alarm entries in '/proc/driver/rtc'.
>
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>

Queued as a fix in efi/urgent, thanks.


> ---
>  drivers/rtc/rtc-efi.c | 48 ++++++++++++++++++++++++-------------------
>  include/linux/efi.h   |  3 ++-
>  2 files changed, 29 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index e991cccdb6e9c..1e8bc6cc1e12d 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -188,9 +188,10 @@ static int efi_set_time(struct device *dev, struct rtc_time *tm)
>
>  static int efi_procfs(struct device *dev, struct seq_file *seq)
>  {
> -       efi_time_t      eft, alm;
> -       efi_time_cap_t  cap;
> -       efi_bool_t      enabled, pending;
> +       efi_time_t        eft, alm;
> +       efi_time_cap_t    cap;
> +       efi_bool_t        enabled, pending;
> +       struct rtc_device *rtc = dev_get_drvdata(dev);
>
>         memset(&eft, 0, sizeof(eft));
>         memset(&alm, 0, sizeof(alm));
> @@ -213,23 +214,25 @@ static int efi_procfs(struct device *dev, struct seq_file *seq)
>                 /* XXX fixme: convert to string? */
>                 seq_printf(seq, "Timezone\t: %u\n", eft.timezone);
>
> -       seq_printf(seq,
> -                  "Alarm Time\t: %u:%u:%u.%09u\n"
> -                  "Alarm Date\t: %u-%u-%u\n"
> -                  "Alarm Daylight\t: %u\n"
> -                  "Enabled\t\t: %s\n"
> -                  "Pending\t\t: %s\n",
> -                  alm.hour, alm.minute, alm.second, alm.nanosecond,
> -                  alm.year, alm.month, alm.day,
> -                  alm.daylight,
> -                  enabled == 1 ? "yes" : "no",
> -                  pending == 1 ? "yes" : "no");
> -
> -       if (eft.timezone == EFI_UNSPECIFIED_TIMEZONE)
> -               seq_puts(seq, "Timezone\t: unspecified\n");
> -       else
> -               /* XXX fixme: convert to string? */
> -               seq_printf(seq, "Timezone\t: %u\n", alm.timezone);
> +       if (test_bit(RTC_FEATURE_ALARM, rtc->features)) {
> +               seq_printf(seq,
> +                          "Alarm Time\t: %u:%u:%u.%09u\n"
> +                          "Alarm Date\t: %u-%u-%u\n"
> +                          "Alarm Daylight\t: %u\n"
> +                          "Enabled\t\t: %s\n"
> +                          "Pending\t\t: %s\n",
> +                          alm.hour, alm.minute, alm.second, alm.nanosecond,
> +                          alm.year, alm.month, alm.day,
> +                          alm.daylight,
> +                          enabled == 1 ? "yes" : "no",
> +                          pending == 1 ? "yes" : "no");
> +
> +               if (eft.timezone == EFI_UNSPECIFIED_TIMEZONE)
> +                       seq_puts(seq, "Timezone\t: unspecified\n");
> +               else
> +                       /* XXX fixme: convert to string? */
> +                       seq_printf(seq, "Timezone\t: %u\n", alm.timezone);
> +       }
>
>         /*
>          * now prints the capabilities
> @@ -269,7 +272,10 @@ static int __init efi_rtc_probe(struct platform_device *dev)
>
>         rtc->ops = &efi_rtc_ops;
>         clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
> -       set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES))
> +               set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
> +       else
> +               clear_bit(RTC_FEATURE_ALARM, rtc->features);
>
>         device_init_wakeup(&dev->dev, true);
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 4b27519143f56..98598bd1d2fa5 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -668,7 +668,8 @@ extern struct efi {
>
>  #define EFI_RT_SUPPORTED_ALL                                   0x3fff
>
> -#define EFI_RT_SUPPORTED_TIME_SERVICES                         0x000f
> +#define EFI_RT_SUPPORTED_TIME_SERVICES                         0x0003
> +#define EFI_RT_SUPPORTED_WAKEUP_SERVICES                       0x000c
>  #define EFI_RT_SUPPORTED_VARIABLE_SERVICES                     0x0070
>
>  extern struct mm_struct efi_mm;
> --
> 2.25.1
>
