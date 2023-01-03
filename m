Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B029E65C418
	for <lists+linux-efi@lfdr.de>; Tue,  3 Jan 2023 17:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjACQh5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Jan 2023 11:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjACQhy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Jan 2023 11:37:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF710FACB;
        Tue,  3 Jan 2023 08:37:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C80961477;
        Tue,  3 Jan 2023 16:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56DBC433D2;
        Tue,  3 Jan 2023 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672763871;
        bh=M4N2f7GfMcCQHVsFF1bmfV3KZYetYk8wN6MzN8veA1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C+uUqf+Idt5tgEWkA99tiRkqvRg9Q5DqDauno/z2lwnukBcgtFNjZ8MJyLz8+PXIK
         P8t5xoMiD4Nh7/zJXbUU5o4Wc7T+1IsJ6N9fLvC41046pIIQB61x02hvkZSmEE76Sn
         //swO2eTz+5SNEVLd5SKy7YL0Nr8hBi4ptt2FuALeaQPDlVJRsi9ScOnV5PAv76BOL
         zJczIrkw3+x4/F4S4NDqigiqw6e8kIWlMOSStNUG193v63V9Wvy0rlVPBGa0EJGn4l
         RA/j7aoYtS+83KTNAbiRwFAyLX3QUXzBxRZtiCl54Mjwa+jmkFqnkMromc/pywIYH/
         SzvkVfU7IWsaQ==
Received: by mail-lf1-f47.google.com with SMTP id 1so46359446lfz.4;
        Tue, 03 Jan 2023 08:37:51 -0800 (PST)
X-Gm-Message-State: AFqh2ko4a4v7wsCrcjU5MEVC6bwBeMTr6KiO2GrJRcQsqw9K0udNTRIQ
        Q4enO3rRxJz4upwNm5G6wgWCcjHL7M83JBpMVGw=
X-Google-Smtp-Source: AMrXdXv9gpvRdh9OhvcnDLtuZCB0bUo7F9oYqVO/4CzRni+qsejVAaKMh+42GmDaln8pqok0X0EiheQhmnBp43fAkkE=
X-Received: by 2002:ac2:5dfa:0:b0:4b7:3a0:45d2 with SMTP id
 z26-20020ac25dfa000000b004b703a045d2mr2308242lfq.228.1672763869799; Tue, 03
 Jan 2023 08:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20221227040925.1619833-1-sdonthineni@nvidia.com>
 <CAMj1kXG79-MxGJEwvnekqbVyeEMVHBfhNjwZkz91mMwv4-vT3Q@mail.gmail.com>
 <Y7NY+ba2USk7hEAx@mail.local> <CAMj1kXHAYvGdGJN0rfEL2y1jRP8P5YotKMmCmx0h07vJP=YfBA@mail.gmail.com>
 <7608579c-6ee5-f576-aa06-a763c3b6108a@nvidia.com>
In-Reply-To: <7608579c-6ee5-f576-aa06-a763c3b6108a@nvidia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Jan 2023 17:37:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFDAojDSAUwdSNbD1Wkjo8WH-i4hs3us-uiWt+AYM1OMQ@mail.gmail.com>
Message-ID: <CAMj1kXFDAojDSAUwdSNbD1Wkjo8WH-i4hs3us-uiWt+AYM1OMQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi: rtc: Enable SET/GET WAKEUP services as optional
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
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

On Tue, 3 Jan 2023 at 17:37, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>
> Hi Ard Biesheuvel,
>
> On 1/3/23 03:18, Ard Biesheuvel wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, 2 Jan 2023 at 23:21, Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> >>
> >> On 02/01/2023 11:47:11+0100, Ard Biesheuvel wrote:
> >>> On Tue, 27 Dec 2022 at 05:09, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
> >>>>
> >>>> The current implementation of rtc-efi is expecting all the 4
> >>>> time services GET{SET}_TIME{WAKEUP} must be supported by UEFI
> >>>> firmware. As per the EFI_RT_PROPERTIES_TABLE, the platform
> >>>> specific implementations can choose to enable selective time
> >>>> services based on the RTC device capabilities.
> >>>>
> >>>> This patch does the following changes to provide GET/SET RTC
> >>>> services on platforms that do not support the WAKEUP feature.
> >>>>
> >>>> 1) Relax time services cap check when creating a platform device.
> >>>> 2) Clear RTC_FEATURE_ALARM bit in the absence of WAKEUP services.
> >>>> 3) Conditional alarm entries in '/proc/driver/rtc'.
> >>>>
> >>>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> >>>
> >>> Queued as a fix in efi/urgent, thanks.
> >>
> >> This rather seems like an rtc heavy patch and the subject line is
> >> misleading. This should be rtc: efi:
> >> Also, I'm pretty sure this doesn't qualify as an urgent fix.
> >>
> >
> > I'm happy to drop it from my tree, but please add a cc:stable so it
> > gets backported to v6.1 at least. Otherwise, EFI compliant systems
> > that implement get/set_time but not get/set_wakeup_time have no RTC at
> > all on any LTS kernel until a year from now, and this was never the
> > intent when we introduced the EFI_RT_PROPERTIES_TABLE.
>
> Thanks for considering the fix for stable releases, I'll post v3 patch
> with tag 'CC: <stable@vger.kernel.org> # v6.0+'

No please don't resend the patch
