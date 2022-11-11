Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D40662549F
	for <lists+linux-efi@lfdr.de>; Fri, 11 Nov 2022 08:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKKHvY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Nov 2022 02:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKKHvX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Nov 2022 02:51:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F23DFC5
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 23:51:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A09261EBF
        for <linux-efi@vger.kernel.org>; Fri, 11 Nov 2022 07:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E722DC433C1
        for <linux-efi@vger.kernel.org>; Fri, 11 Nov 2022 07:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668153080;
        bh=1vupJla92Iek4cjuGBlj+wrBQ/8U0QUX5YyYtRrB+7w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HPSYMOyLvbTwPfaOVN0T7ve1k1tgL57Z127F2pJJYF+Dk1T81Z5rgqyjhNh4olW2z
         a07tIUO1l5eYDjyGcSxGCDKKpcPIVnu3yPQicMvXddiwdKoS6Ch6a8KyFmKOiNvi9X
         zd6EENs0nXPO4tg4POgn27J4+pl8onYeGqqi2vJaIKSgg+KjxTQAvf6j7I5gVJ4l58
         Dp4ptzQXvJzMCXZCp/niUceRtFyuiTP4LVRg2vWJp+ap8a93JAWV5D4xqol08sDC9U
         bP71N5P31JefoFPY5N9lDfc2avPYSupNUXD0Otx4p4fpEFxXnajbtReCbeGhSsdKkd
         GXFB1kqH8QDpA==
Received: by mail-lf1-f44.google.com with SMTP id b3so7209156lfv.2
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 23:51:20 -0800 (PST)
X-Gm-Message-State: ANoB5plOKF8qnAhDY+s0bEce+lYDwx7TXJ2LKg74gJCLsfwfP+3yh0Kw
        3+mq+mSl7R0PjL1YqFaWYOHuPEj61bAhZ+K3MD0=
X-Google-Smtp-Source: AA0mqf5QbHABNk6KqrzPuGEK1Ob6Hb5l1CYkgT8+3zdA0ofmSW43DQbD0eA194VWz32XJdwIGhYROiwqcTbF/MbzSMI=
X-Received: by 2002:ac2:48b0:0:b0:4a2:740b:5b02 with SMTP id
 u16-20020ac248b0000000b004a2740b5b02mr347702lfg.122.1668153078935; Thu, 10
 Nov 2022 23:51:18 -0800 (PST)
MIME-Version: 1.0
References: <20221109172750.2823891-1-ardb@kernel.org> <Y20MjzkbX+yM/A0G@monolith.localdoman>
In-Reply-To: <Y20MjzkbX+yM/A0G@monolith.localdoman>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 11 Nov 2022 08:51:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH06=sAx8dSK7qMkvAwuFmJ6n2b92XA6VHfKha7mo6xtA@mail.gmail.com>
Message-ID: <CAMj1kXH06=sAx8dSK7qMkvAwuFmJ6n2b92XA6VHfKha7mo6xtA@mail.gmail.com>
Subject: Re: [PATCH] efi: Override runtime supported mask from a EFI variable
 if present
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 10 Nov 2022 at 15:37, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>
> Hi,
>
> On Wed, Nov 09, 2022 at 06:27:50PM +0100, Ard Biesheuvel wrote:
> > For debugging purposes, allow the runtime override mask to be set from a
> > EFI variable if one exists. For instance, the RT supported mask can be
> > set to 0xfffd to disable the SetTime() runtime service, and enable all
> > others:
> >
> >   echo -ne "\x7\0\0\0\xfd\xff" \
> >     > /sys/firmware/efi/efivars/LinuxRtMaskOverride-eb66918a-7eef-402a-842e-931d21c38ae9
>
> I'm really sorry, I applied this patch, but I couldn't find the file
> (LinuxRtMaskOverride*) under efivars, and couldn't find another way of
> setting the variable.
>

The variable will be created by writing to the file.

But no worries, I think we have enough context now. I've queued up the
patch that checks the SMBIOS record for Altra machines.


> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/efi.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index a46df5d1d0942751..faed1ef78c044924 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -367,7 +367,17 @@ static int __init efisubsys_init(void)
> >               }
> >       }
> >
> > -     if (efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES))
> > +     if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> > +             unsigned long size = sizeof(efi.runtime_supported_mask);
> > +
> > +             if (efi.get_variable(L"LinuxRtMaskOverride",
> > +                                  &EFI_RT_PROPERTIES_TABLE_GUID, NULL, &size,
> > +                                  &efi.runtime_supported_mask) == EFI_SUCCESS)
> > +                     pr_info("Overriding runtime_supported_mask to 0x%x\n",
> > +                             efi.runtime_supported_mask);
> > +     }
> > +
> > +     if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_TIME))
> >               platform_device_register_simple("rtc-efi", 0, NULL, 0);
> >
> >       /* We register the efi directory at /sys/firmware/efi */
> > --
> > 2.35.1
> >
