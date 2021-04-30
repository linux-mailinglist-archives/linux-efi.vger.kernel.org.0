Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA7636F88E
	for <lists+linux-efi@lfdr.de>; Fri, 30 Apr 2021 12:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhD3KjG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Apr 2021 06:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3KjF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Apr 2021 06:39:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A2C06174A
        for <linux-efi@vger.kernel.org>; Fri, 30 Apr 2021 03:38:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x5so19726795wrv.13
        for <linux-efi@vger.kernel.org>; Fri, 30 Apr 2021 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cuFa95T82yuRw/x01hx9oSP09ZQtscJFMU/krcRIhtQ=;
        b=C1iTLjx1+hc72qoJApGHVjEgs7Qo88BM0NrwpHY8K/KRtH0hYT3H7sCwX6xZtPuusY
         nIJ5sDoLL4HsWl1joJY17AFU9hPUUi449gWKL2F0Aycv4LOLrlkJ46ZV132HwNsrs+FR
         D1o9vKHegoqJP1qViR5Ak1Yffg6UtSSUYnt+OYX1pnop9sBb1fN9A+f3LGmHYiGWYckP
         sm4JAI8p4V9IlMb+EF/gIv9a/zdlCCvqNGrkEztIQWIh4erCwswiCkYDpkbqZrRTgn3w
         kdHeI9aCXmZFCbibZJiOMJj0Fo3miVjD85GeIuOaDyKMWE/+GyYU2MGU08/F15600ZBx
         M7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cuFa95T82yuRw/x01hx9oSP09ZQtscJFMU/krcRIhtQ=;
        b=i7zN6jU62V4eW1LTYBz7p17x/j2xsmM5kE6vyr5wFMTRRuahArhTbjHU83+3RTZY/e
         sw6YMQbO28yvfzB4cEbGAfinYAkb4eeBwHz7kePl/fj1BDe5/zaaHelG/uRWzZJUvf8p
         jvc9rRVa2H1j5nv9hTO30oU6LbUEhAR2hk3laegoeDacFowrSC/MH3UwCeYzEqHfAa5K
         i7dzIOUvhXeWw8hWe7q7RzbKIJ3H4dyf3retNKj2Z3Phlkx6em7+/XkMkNBvRM0Zwuqo
         hsVpRTqGy6h5VlFf3irMt8GNSNYuRhL7fKRO5OmRx7AyFhlbkJljNQfRwtFFp6PIJflJ
         4nEg==
X-Gm-Message-State: AOAM530aWee3yeBUZw46omEESF/Ba3TRnK83vgA2ZWAGlXcZsJwLkiYP
        tZ8m77Uy1PBANZRFRbpeyMVjLpY8KnBujg==
X-Google-Smtp-Source: ABdhPJy2RYePxJYx3nVKABoflmWo8YJFh/2V1caUYvHoklNXFkh9/8yRmZAKMBD8pJvZFdThh3x+uQ==
X-Received: by 2002:adf:e74d:: with SMTP id c13mr970053wrn.242.1619779094884;
        Fri, 30 Apr 2021 03:38:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:ad00:f6bf:8c3b:84f1? (p200300ea8f384600ad00f6bf8c3b84f1.dip0.t-ipconnect.de. [2003:ea:8f38:4600:ad00:f6bf:8c3b:84f1])
        by smtp.googlemail.com with ESMTPSA id l5sm2820326wmh.0.2021.04.30.03.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 03:38:14 -0700 (PDT)
Subject: Re: Still required that EFI_MEMORY_XP and EFI_MEMORY_RO must not both
 be cleared?
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>
References: <c32f0994-605c-3770-cda8-335acaa53c66@gmail.com>
 <CAMj1kXHYxREHi_gUrajioaPAS8miHdpoqxUaqH9wYGpNAkCn0A@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <336afe38-b6db-d6cf-71f6-cf47d5db8235@gmail.com>
Date:   Fri, 30 Apr 2021 12:38:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHYxREHi_gUrajioaPAS8miHdpoqxUaqH9wYGpNAkCn0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 30.04.2021 11:40, Ard Biesheuvel wrote:
> On Fri, 30 Apr 2021 at 10:06, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> I'm one of the people seeing the following warning:
>>
>> efi: memattr: Entry attributes invalid: RO and XP bits both cleared
>> efi: memattr: ! 0x000000090000-0x000000090fff [Runtime Code|RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ]
>>
>> Out of curiosity I checked UEFI spec 2.9. On p.108 there's table 4.1:
>>
>>                                                    EFI_MEMORY_RO EFI_MEMORY_XP EFI_MEMORY_RUNTIME
>> No memory access protection is possible for Entry  0             0             1
>> Write-protected Code                               1             0             1
>> Read/Write Data                                    0             1             1
>> Read-only Data                                     1             1             1
>>
>> So it seems to be valid that both attributes are cleared.
>> Also in the surrounding text I didn't find a hint mandating
>> that at least one the attributes has to be set.
> 
> You are right. My assumption at the time was that not having either of
> RO or XP in the memory attributes table makes little sense, as it
> describes the default case. However, this interpretation may conflict
> with the requirement that entries in the memory attributes table cover
> an entry in the EFI memory map entirely, or not at all. IOW, if a
> memory map entry consists of a code region, a data region and a region
> that requires both execute and write permissions, there would be no
> way to describe it unless we permit entries that have RO and XP both
> cleared.
> 
> Patches welcome!
> 
Thanks for the comprehensive explanation. Then I'll submit a patch
for removing this check.
