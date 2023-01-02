Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88D65B79C
	for <lists+linux-efi@lfdr.de>; Mon,  2 Jan 2023 23:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjABWV7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Jan 2023 17:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjABWVv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Jan 2023 17:21:51 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C66C266;
        Mon,  2 Jan 2023 14:21:47 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 19EA260003;
        Mon,  2 Jan 2023 22:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672698106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R5DrDO09m6WnwQyi2kay4oAXjZqJHjCaf1rEMgSoC5c=;
        b=OHPPWtAX9RLWTA/5LDUrbvji9uaDWVUYsPhSl5kHTOzmdzXh/9MH93Hz0UCo5hkqCiX7xF
        mD0Wm/nkSVyY0SLpaxW1137+HQjzV/91HLhQv1/bAjla26HtmCaYWM+u4AvfSRdgxew/1H
        bQ3e50GZ/kTUR4S333if6PNiiM27dp2jpgN2uBrnND0MdzZQNnUSxTRDj8Dsj37MAaHEEp
        cj+txXbbi1GoILCGv+Gm3HFvRe/zsv3hpkp/YmoIN87mO+UwbO6Y1ax4ZUc+mL4jY+lptZ
        Fy8J7JoLDEida52Xa07dJ4EbKzEfkCym+sonr7ux3JVbI9NMCgWgNJiaVBC6xA==
Date:   Mon, 2 Jan 2023 23:21:45 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH 1/1] efi: rtc: Enable SET/GET WAKEUP services as optional
Message-ID: <Y7NY+ba2USk7hEAx@mail.local>
References: <20221227040925.1619833-1-sdonthineni@nvidia.com>
 <CAMj1kXG79-MxGJEwvnekqbVyeEMVHBfhNjwZkz91mMwv4-vT3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG79-MxGJEwvnekqbVyeEMVHBfhNjwZkz91mMwv4-vT3Q@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 02/01/2023 11:47:11+0100, Ard Biesheuvel wrote:
> On Tue, 27 Dec 2022 at 05:09, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
> >
> > The current implementation of rtc-efi is expecting all the 4
> > time services GET{SET}_TIME{WAKEUP} must be supported by UEFI
> > firmware. As per the EFI_RT_PROPERTIES_TABLE, the platform
> > specific implementations can choose to enable selective time
> > services based on the RTC device capabilities.
> >
> > This patch does the following changes to provide GET/SET RTC
> > services on platforms that do not support the WAKEUP feature.
> >
> > 1) Relax time services cap check when creating a platform device.
> > 2) Clear RTC_FEATURE_ALARM bit in the absence of WAKEUP services.
> > 3) Conditional alarm entries in '/proc/driver/rtc'.
> >
> > Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> 
> Queued as a fix in efi/urgent, thanks.

This rather seems like an rtc heavy patch and the subject line is
misleading. This should be rtc: efi:
Also, I'm pretty sure this doesn't qualify as an urgent fix.

> 
> 
> > ---
> >  drivers/rtc/rtc-efi.c | 48 ++++++++++++++++++++++++-------------------
> >  include/linux/efi.h   |  3 ++-
> >  2 files changed, 29 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> > index e991cccdb6e9c..1e8bc6cc1e12d 100644
> > --- a/drivers/rtc/rtc-efi.c
> > +++ b/drivers/rtc/rtc-efi.c
> > @@ -188,9 +188,10 @@ static int efi_set_time(struct device *dev, struct rtc_time *tm)
> >
> >  static int efi_procfs(struct device *dev, struct seq_file *seq)
> >  {
> > -       efi_time_t      eft, alm;
> > -       efi_time_cap_t  cap;
> > -       efi_bool_t      enabled, pending;
> > +       efi_time_t        eft, alm;
> > +       efi_time_cap_t    cap;
> > +       efi_bool_t        enabled, pending;
> > +       struct rtc_device *rtc = dev_get_drvdata(dev);
> >
> >         memset(&eft, 0, sizeof(eft));
> >         memset(&alm, 0, sizeof(alm));
> > @@ -213,23 +214,25 @@ static int efi_procfs(struct device *dev, struct seq_file *seq)
> >                 /* XXX fixme: convert to string? */
> >                 seq_printf(seq, "Timezone\t: %u\n", eft.timezone);
> >
> > -       seq_printf(seq,
> > -                  "Alarm Time\t: %u:%u:%u.%09u\n"
> > -                  "Alarm Date\t: %u-%u-%u\n"
> > -                  "Alarm Daylight\t: %u\n"
> > -                  "Enabled\t\t: %s\n"
> > -                  "Pending\t\t: %s\n",
> > -                  alm.hour, alm.minute, alm.second, alm.nanosecond,
> > -                  alm.year, alm.month, alm.day,
> > -                  alm.daylight,
> > -                  enabled == 1 ? "yes" : "no",
> > -                  pending == 1 ? "yes" : "no");
> > -
> > -       if (eft.timezone == EFI_UNSPECIFIED_TIMEZONE)
> > -               seq_puts(seq, "Timezone\t: unspecified\n");
> > -       else
> > -               /* XXX fixme: convert to string? */
> > -               seq_printf(seq, "Timezone\t: %u\n", alm.timezone);
> > +       if (test_bit(RTC_FEATURE_ALARM, rtc->features)) {
> > +               seq_printf(seq,
> > +                          "Alarm Time\t: %u:%u:%u.%09u\n"
> > +                          "Alarm Date\t: %u-%u-%u\n"
> > +                          "Alarm Daylight\t: %u\n"
> > +                          "Enabled\t\t: %s\n"
> > +                          "Pending\t\t: %s\n",
> > +                          alm.hour, alm.minute, alm.second, alm.nanosecond,
> > +                          alm.year, alm.month, alm.day,
> > +                          alm.daylight,
> > +                          enabled == 1 ? "yes" : "no",
> > +                          pending == 1 ? "yes" : "no");
> > +
> > +               if (eft.timezone == EFI_UNSPECIFIED_TIMEZONE)
> > +                       seq_puts(seq, "Timezone\t: unspecified\n");
> > +               else
> > +                       /* XXX fixme: convert to string? */
> > +                       seq_printf(seq, "Timezone\t: %u\n", alm.timezone);
> > +       }
> >
> >         /*
> >          * now prints the capabilities
> > @@ -269,7 +272,10 @@ static int __init efi_rtc_probe(struct platform_device *dev)
> >
> >         rtc->ops = &efi_rtc_ops;
> >         clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
> > -       set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
> > +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES))
> > +               set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
> > +       else
> > +               clear_bit(RTC_FEATURE_ALARM, rtc->features);
> >
> >         device_init_wakeup(&dev->dev, true);
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 4b27519143f56..98598bd1d2fa5 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -668,7 +668,8 @@ extern struct efi {
> >
> >  #define EFI_RT_SUPPORTED_ALL                                   0x3fff
> >
> > -#define EFI_RT_SUPPORTED_TIME_SERVICES                         0x000f
> > +#define EFI_RT_SUPPORTED_TIME_SERVICES                         0x0003
> > +#define EFI_RT_SUPPORTED_WAKEUP_SERVICES                       0x000c
> >  #define EFI_RT_SUPPORTED_VARIABLE_SERVICES                     0x0070
> >
> >  extern struct mm_struct efi_mm;
> > --
> > 2.25.1
> >

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
