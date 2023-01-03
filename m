Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECFB65BCF4
	for <lists+linux-efi@lfdr.de>; Tue,  3 Jan 2023 10:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjACJS1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Jan 2023 04:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjACJSZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Jan 2023 04:18:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8BFE0B8;
        Tue,  3 Jan 2023 01:18:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2DD261228;
        Tue,  3 Jan 2023 09:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE2FC433D2;
        Tue,  3 Jan 2023 09:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672737499;
        bh=s+N6KD+86oG0++UXYbUpyhAUG0jvAMbglBu26PpGXg0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lbc0Jq1S28K22mZGoYVRQ693zlNISLskqNBrRIIcAEn06JIl4Z9AJnMc9yLfxL2/u
         9HUZ+fRnKk/2PDE1C6f546lcUWcxxMB5w41nlXv4uuZNif3pFO4ESB+JVJ7WgLUGqW
         AET90onoKKpK58e6XCqlraEZgxqbyhoFAknP8vh1ZZSmPFciyi01FhPZZ21sloplfx
         sY52PFBgjX7xScPqARXwK7OSSCYbIxC6d8nQSkBGQYgiwFCgSwhqaWld9yQpdVqqrC
         CyqCQALt+la0WXF0v6x5pBGlj1sKiYb+dm0AffLXWvuIrBTF2TIxnwcSRibz3e6rnG
         y/DWoZVycmYXw==
Received: by mail-lf1-f54.google.com with SMTP id cf42so44829100lfb.1;
        Tue, 03 Jan 2023 01:18:19 -0800 (PST)
X-Gm-Message-State: AFqh2kp9Mx1O3EdSDnMRAVZLr+KuU2bcVf5TkVOOuJI9LEcKYuLCCElB
        w4DdScxwx8Ps1CrZgGMmWu4wMpUente63J26UUU=
X-Google-Smtp-Source: AMrXdXvkVhxG6CDAz4jktl5i2Ea8YmhMpWWWyVopRTNbeCFDBSJmnhtnhUOoYpib0V6yh9xj2t+lQHsZ9UtLAtWJdU4=
X-Received: by 2002:a19:ad4b:0:b0:4cb:315d:e9b8 with SMTP id
 s11-20020a19ad4b000000b004cb315de9b8mr924274lfd.110.1672737497327; Tue, 03
 Jan 2023 01:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20221227040925.1619833-1-sdonthineni@nvidia.com>
 <CAMj1kXG79-MxGJEwvnekqbVyeEMVHBfhNjwZkz91mMwv4-vT3Q@mail.gmail.com> <Y7NY+ba2USk7hEAx@mail.local>
In-Reply-To: <Y7NY+ba2USk7hEAx@mail.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Jan 2023 10:18:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHAYvGdGJN0rfEL2y1jRP8P5YotKMmCmx0h07vJP=YfBA@mail.gmail.com>
Message-ID: <CAMj1kXHAYvGdGJN0rfEL2y1jRP8P5YotKMmCmx0h07vJP=YfBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi: rtc: Enable SET/GET WAKEUP services as optional
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
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

On Mon, 2 Jan 2023 at 23:21, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 02/01/2023 11:47:11+0100, Ard Biesheuvel wrote:
> > On Tue, 27 Dec 2022 at 05:09, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
> > >
> > > The current implementation of rtc-efi is expecting all the 4
> > > time services GET{SET}_TIME{WAKEUP} must be supported by UEFI
> > > firmware. As per the EFI_RT_PROPERTIES_TABLE, the platform
> > > specific implementations can choose to enable selective time
> > > services based on the RTC device capabilities.
> > >
> > > This patch does the following changes to provide GET/SET RTC
> > > services on platforms that do not support the WAKEUP feature.
> > >
> > > 1) Relax time services cap check when creating a platform device.
> > > 2) Clear RTC_FEATURE_ALARM bit in the absence of WAKEUP services.
> > > 3) Conditional alarm entries in '/proc/driver/rtc'.
> > >
> > > Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> >
> > Queued as a fix in efi/urgent, thanks.
>
> This rather seems like an rtc heavy patch and the subject line is
> misleading. This should be rtc: efi:
> Also, I'm pretty sure this doesn't qualify as an urgent fix.
>

I'm happy to drop it from my tree, but please add a cc:stable so it
gets backported to v6.1 at least. Otherwise, EFI compliant systems
that implement get/set_time but not get/set_wakeup_time have no RTC at
all on any LTS kernel until a year from now, and this was never the
intent when we introduced the EFI_RT_PROPERTIES_TABLE.
