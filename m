Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613EE61DFFA
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 03:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKFC3R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Nov 2022 22:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKFC3Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Nov 2022 22:29:16 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8BBDEBD
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 19:29:15 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D266D412CA
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 02:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667701753;
        bh=/f55BZLitcHTwTwefO/ARcommTLNzWMCRB4dPy3Hz7M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=VKe0pWYOrGQ9Mt6A62ABiodgk11dRVVK6PNS+JmqkQ07ghpcKGLA00wbs5nTAoKE0
         QcceeCZV/COX88S64MlYeeXR/WWJWXFidG4TXAaWlkDJtWN+ZHgfxkExINaWRrHxi3
         jrqg5t6i1sDPcJXuF+9Yuc5WDcqs1qNqlCwe6M8MUPSgY8xwQab+8/lG0yELroWKVX
         Qry9A3KBaCb7ivcVD9batYh+ckzSJLhSA5qW8zj8N41PT9OU4lT++7kDJObmD65am9
         zYLbRbU/P9J4b7sX0rcLY192Lqjdk5HVMkCDLxjqNfk+g/X/eO5eSBilbSiuhbv/SD
         MCzE0EimDkhxA==
Received: by mail-wm1-f70.google.com with SMTP id v125-20020a1cac83000000b003cfa148576dso1329969wme.3
        for <linux-efi@vger.kernel.org>; Sat, 05 Nov 2022 19:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/f55BZLitcHTwTwefO/ARcommTLNzWMCRB4dPy3Hz7M=;
        b=C1FXJU6CjATxMHT1KbMbcVM/DGak7efpeSbrYxvtzt5GsRDigpUmYUwXuQ0TUfetMq
         vJ3w5h9c/EIinslakeCPM+bkYz3HUDWSGB3A0UvU14A3H5iSUN+eDr73cd8+0X9tBwmn
         IjkYeb8ovGYfKhN7CJgCj0NlkWN1sRmehhMyYLFOdKlCg7QOCPT/HL/ZO8s3ghS1IUHi
         OyUY4FWyFTTFiNpmjbmYOgj9aEM84de6Dce3thkvGlQ9rr/cu7oVuDIVl8GE/uCUKfm3
         pijnWbfujeKbtPAalM7Z6+JO/FuXvZcqAYiTUlaiFVIJ8L9BbFDmhABpi+JAaxhe2fG8
         xQvA==
X-Gm-Message-State: ACrzQf0Ykgevy1Ci6DA7Il/jhyv8tXsv6ztIoeOIQaj86UiVc9cWC86p
        dkTLWXC4GOQ34C7CI8sFqkX/XOKNzzbwPWD9z/X43QpqwYDHXor0PpQRzaOS/UW8+8rWHjKxCMU
        E8IUlPOlHJeeEk0AFu8ckIj5VKRaBbmi0FUKeZQ==
X-Received: by 2002:a5d:6b02:0:b0:236:d484:2d01 with SMTP id v2-20020a5d6b02000000b00236d4842d01mr20490108wrw.623.1667701753349;
        Sat, 05 Nov 2022 19:29:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM67QakdIlUQcldTF4NHxMfFvjogi1ITSuOAYa/WQ/sFjcISrZdkmg/sNdWX+3eu3e2MiGSvWA==
X-Received: by 2002:a5d:6b02:0:b0:236:d484:2d01 with SMTP id v2-20020a5d6b02000000b00236d4842d01mr20490095wrw.623.1667701753100;
        Sat, 05 Nov 2022 19:29:13 -0700 (PDT)
Received: from [192.168.123.94] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id bh2-20020a05600005c200b002366d1cc198sm3527336wrb.41.2022.11.05.19.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 19:29:12 -0700 (PDT)
Message-ID: <9c937c47-4d5c-14f9-af6f-e28f6dd1c9dc@canonical.com>
Date:   Sun, 6 Nov 2022 03:29:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Remove WARN_ONCE for unaligned UEFI region?
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=whPRmHQ=KV9B3_jeOG4ydj8gkMwQKnde7BJ4wJjveyMDQ@mail.gmail.com>
 <CAMj1kXFkp_W4P7twyZhM2mrP0PibOdWAwvKg-rb_jvh08RG_sg@mail.gmail.com>
 <CAHk-=wg2j9Fz-QVjmwqs+Uv9K-+rO9cviAokmvbFhwimtOGJpw@mail.gmail.com>
 <CAMj1kXG5q_UZuPUtifSxwstMBf4QD-Q0=gObk1WzLmMMegduqg@mail.gmail.com>
 <CAMj1kXHau=dVvSCBTDxqPeXiiXEYHTqQ_fBZym3D=4vaB9FMhg@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXHau=dVvSCBTDxqPeXiiXEYHTqQ_fBZym3D=4vaB9FMhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/5/22 23:43, Ard Biesheuvel wrote:
> On Sat, 5 Nov 2022 at 22:54, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> (cc Heinrich and Ilias)
>>
>> On Sat, 5 Nov 2022 at 21:27, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> On Sat, Nov 5, 2022 at 1:18 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>
>>>> Yeah just rip it out. In the beginning, we tended to make these
>>>> warnings noisy so people will actually notice.
>>>
>>> Rip it out entirely, or replace ith pr_warn_once()?
>>>
>>
>> A warning that can only trigger on 16k or 64k page size kernels
>> clearly doesn't have a lot of coverage, so either we just drop it, or
>> we make the warning use SZ_64K and not PAGE_SIZE.
>>
>> And if we keep the warning, it should be separate from the if(): when
>> the regions are misaligned, we have to use RWX mappings because an
>> adjacent region that gets covered by the same mapping might require
>> it.
>>
>> Maybe I'll just whip up a patch myself.
>>
>>>> I'd still like to see a memory map (boot with efi=debug) so we can get
>>>> this reported and fixed in uboot. We need that so 16k and 64k pages
>>>> boot doesn't cause surprises with overlapping mappings.
>>>
>>> Here's the dmesg attached with efi=debug for your viewing pleasure.
>>>
>>
>> Thanks.
>>
>> I've cc'ed the u-boot EFI maintainers, who take EFI spec compliance
>> very seriously, so I'm sure we'll get this fixed quickly.
> 
> Grrr looking at the spec, it seems the wording we proposed at the time
> never made it in, and at the moment, it just reads:

Could you, please, provide a link to the proposal.

Best regards

Heinrich

> 
> """
> If a 64KiB physical page contains any 4KiB page with any of the
> following types listed below, then all 4KiB pages in the 64KiB page
> must use identical ARM Memory Page Attributes:
> — EfiRuntimeServicesCode
> — EfiRuntimeServicesData
> ...
> """
> 
> The problem here is that it doesn't take permission attributes into
> account, allowing the firmware to cram code and data regions into the
> same 64k page, and instructing the OS to use R-X for the code and RW-
> for the data, which it cannot do if it uses 16k or 64k pages.
> 
> So let's drop the warning and add it back later once the spec actually
> supports it.
> 
> Patch on its way ...
