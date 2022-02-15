Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADFA4B6E78
	for <lists+linux-efi@lfdr.de>; Tue, 15 Feb 2022 15:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiBOOOw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Feb 2022 09:14:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiBOOOv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Feb 2022 09:14:51 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2989AE6C
        for <linux-efi@vger.kernel.org>; Tue, 15 Feb 2022 06:14:40 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id p5so56203654ybd.13
        for <linux-efi@vger.kernel.org>; Tue, 15 Feb 2022 06:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5TB6dGxazC1uji3PM0bPijKJuSzmBt7/lbdUM4chpqU=;
        b=YDCb3hCHhZLLEPG5t2STM5k0BBUZ1OEQR1TmPowgoYCROFj1eheYFEv8Zi7sstHXNL
         VCBTAIw2bDn79YlEFIL/v80w7H7F5VUUrP4QmZylVQptNG183UARrdVBR1riwFhuPWLG
         RnrdND1gvstyq87OFph0FtblJkH4LvT8UxjIaie/w22X2pX3Ju6XRdRu17qLHgEij1kk
         xKLKK1zYpenx+E76kTXm1UPrgNnOneMahJtbCupPCBENe/oLh3Wlvj/ngbz/FBn/zGiv
         b0mllHKRloGS5T5sYehEFiPGnwRjKHq7NGaMGcodGBBncoOYkFY+BppdgSRblGKXKrAB
         +j6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5TB6dGxazC1uji3PM0bPijKJuSzmBt7/lbdUM4chpqU=;
        b=4VnZWJg8ikXIJ1PdSQaxiLDyx2lLNwA3QHfHTIv+Vayx6PFgnamIGFNtfJxBQiqXZw
         SfiroZcZeEAN8PQmjUAFTwXCmwRH0Qa1WrKI0rc9j8qDTDj6/sFTn9oqKY+NqQaWlwR/
         6l6IVM+2f/mlpIlX61ldixXF+1Z20uszBN9ySaPEv7vfgSx1G3qKwk23wAc2O/EHkUIL
         zx9EG8q0SY+jkva/lMlfHfbXMhFJXp6ZsxGCDva/X/+mMI9cQx+v8EO/hWI1jKcmL+5K
         CMN9/G14lNc9ticIj7al0Jd9MVv4htqqDXh9m7laBUKwzGAJgQNWRpD1tLZIPJ9BL2hd
         WAog==
X-Gm-Message-State: AOAM5302v/hrRY1ZEro2v9lukSzjBs9dZfUI+orVpCisbdAm8NvsHtL4
        0+RHHXo8fFcMT/sMFcJYJ6g4c3JBE/jvCZtNT7iuFA==
X-Google-Smtp-Source: ABdhPJxiNz0d2nqELO9RSvILyKX1eArLqLnZoM38DGg0w/FBN2U8DfR5PNrq+qbmCdAr+SwUpTSLA3xgu53apagAxwM=
X-Received: by 2002:a25:ad51:: with SMTP id l17mr3946323ybe.20.1644934480016;
 Tue, 15 Feb 2022 06:14:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:174d:0:0:0:0:0 with HTTP; Tue, 15 Feb 2022 06:14:39
 -0800 (PST)
In-Reply-To: <YgtR++NUG3w6DH11@kernel.org>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-4-martin.fernandez@eclypsium.com> <202202071325.F8450B3B2D@keescook>
 <YgIseIEMotD2jg83@kernel.org> <CAKgze5a_o=+f6fE55p4D50qZSRNUEHUWBe+Fn8Fc=1RjFLfgeQ@mail.gmail.com>
 <YgtR++NUG3w6DH11@kernel.org>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 15 Feb 2022 11:14:39 -0300
Message-ID: <CAKgze5YFMugCsum8SX+qE26BwxQRW0Uu2qKjEYusFerqk3cEMA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] x86/e820: Refactor range_update and range_remove
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/15/22, Mike Rapoport <rppt@kernel.org> wrote:
> Hi Martin,
>
> On Tue, Feb 08, 2022 at 06:01:21PM -0300, Martin Fernandez wrote:
>> On 2/8/22, Mike Rapoport <rppt@kernel.org> wrote:
>> > On Mon, Feb 07, 2022 at 01:45:40PM -0800, Kees Cook wrote:
>> >> On Thu, Feb 03, 2022 at 01:43:25PM -0300, Martin Fernandez wrote:
>> >> > __e820__range_update and e820__range_remove had a very similar
>> >> > implementation with a few lines different from each other, the lines
>> >> > that actually perform the modification over the e820_table. The
>> >> > similiraties were found in the checks for the different cases on how
>> >> > each entry intersects with the given range (if it does at all).
>> >> > These
>> >> > checks were very presice and error prone so it was not a good idea
>> >> > to
>> >> > have them in both places.
>> >>
>> >> Yay removing copy/paste code! :)
>> >
>> > Removing copy/paste is nice but diffstat of
>> >
>> >  arch/x86/kernel/e820.c | 383 ++++++++++++++++++++++++++++++-----------
>> >  1 file changed, 283 insertions(+), 100 deletions(-)
>> >
>> > does not look nice even accounting for lots of comments :(
>> >
>> > I didn't look closely, but diffstat clues that the refactoring making
>> > things much more complex.
>> >
>>
>> Yes, that diffstat surprised me as well.
>>
>> I have to mention that 110 of those lines are kerneldocs and blank
>> lines, which is quite a lot. Also you have to take into account that I
>> expanded most of the function definitions for better formatting, which
>> also took some space.
>
> At last I had time to look more closely and I think that using a set of
> callbacks is over-complicated.
>
> I think this can be done way simpler, e.g like this (untested) draft:
>
> https://git.kernel.org/rppt/h/x86/e820-update-range
>

Thanks for taking the time to reviewing it.

Yeah, I did something like that in a previous version. Altough I
wasn't really happy with that.

https://lore.kernel.org/linux-efi/20220113213027.457282-4-martin.fernandez@eclypsium.com/

I think that with the struct with the function arguments looks more
clear than what I did, but you have to take into account that I need
to create yet
another function similar to those and another parameter to the struct,
and with that I think that __e820__range_update will look scary.

I'll give it a try anyway!
