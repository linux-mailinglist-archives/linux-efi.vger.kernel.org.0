Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9751F5E7C6B
	for <lists+linux-efi@lfdr.de>; Fri, 23 Sep 2022 15:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiIWN6S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 09:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiIWN6R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 09:58:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D069613D1F5;
        Fri, 23 Sep 2022 06:58:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w2so274560pfb.0;
        Fri, 23 Sep 2022 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=jwnL6AdmiAwRSvoQMy4HH8FrhC+fgkQUGrP8Gp2lEIU=;
        b=p2CiGU77a5ijdEp/zFKjpYWWHVIGPbnt2vr3fGYdb1AckD5yQdGidDiDRd41GqDPmy
         2LvAyJTNmrNNJHd8pTWgDM6+inN6A8krhaTdl6McEvz1kSkpBU5h8/BSTEsew9p9gBIi
         cSHu8v6h8JjY3T8TEe7RnWEh9MQOVl2iAoK8u6Tl7LeDmjHkpadUuFICHEXgwn/cFaj6
         kZZfHu/5LSuadEYdFDbD1frghMW/PBccETw5nGLZmEMinl78x1asbfj4wNrhmD+SY+YM
         j0iAkNXLE8R4uovVL02PXkxl88gdYjoHa3WQiUSBTFFWdC/JqLm2+Obf/A6z8W5DmjoI
         eU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jwnL6AdmiAwRSvoQMy4HH8FrhC+fgkQUGrP8Gp2lEIU=;
        b=K27WwA8kQI9qkWnW29VdORZkxZ0xOLEzkEiHnZZwwrMlzm19d64sgBZlZ+t2vfPCnU
         0Qe2vb08R8eNBgSgGk7wqDlGBgvQ6QTzlw93VlE7dnLeJBeMboC+s9lFX7lH5w97zJSy
         JLFa9kWtq0Ro98+8HNSB4LoRReyA7FzvVNVV7+9hlN5/fNDF4MnVGKj2GeG+e36WeLBg
         0DuwDOXoOG+4m8uWLsdPqQgW/S1VV/4R9Dp5pAzKv/bDc/eMrdATW+23J6Wc+p/H0VGD
         i6fEnp0UePOrIeZAVP1H1V/UV6BYahCGvtbh+IGow0K3RWfz9OOszsypKg6RPspvGE0a
         1JCQ==
X-Gm-Message-State: ACrzQf1ehLP9wifKX09j2LDQDk2emt3t9JnbTL7fTGxOFV+tvzqFzVTK
        X0CX2H/V2LegvoCkEqTVXZA=
X-Google-Smtp-Source: AMsMyM5cHbyKsuiNw9mMjM5h5Am4DN2cfKMaRqpWTqEUyRASNJJjFcgKZaMa5+Dpt8GirXAU0AP3+Q==
X-Received: by 2002:a05:6a00:180d:b0:540:ec09:293 with SMTP id y13-20020a056a00180d00b00540ec090293mr9434371pfa.3.1663941496321;
        Fri, 23 Sep 2022 06:58:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v11-20020a17090ad58b00b001fd77933fb3sm1678677pju.17.2022.09.23.06.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 06:58:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5f443915-b38a-c78d-cccd-876501434cef@roeck-us.net>
Date:   Fri, 23 Sep 2022 06:58:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
References: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net>
 <20220922193157.1673623-1-dave.hansen@linux.intel.com>
 <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
 <Yy1ZadE6Vnnc2dNf@hirez.programming.kicks-ass.net>
 <CAMj1kXEvt-TQzO5jO6srkC8jW5fbou95VKu=os3gt_y87ZPJWg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] x86/mm+efi: Avoid creating W+X mappings
In-Reply-To: <CAMj1kXEvt-TQzO5jO6srkC8jW5fbou95VKu=os3gt_y87ZPJWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/23/22 02:49, Ard Biesheuvel wrote:
> (cc Kees)
> 
> On Fri, 23 Sept 2022 at 09:00, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Fri, Sep 23, 2022 at 12:08:57AM +0200, Ard Biesheuvel wrote:
>>> On Thu, 22 Sept 2022 at 21:32, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>>>>
>>>> From: Peter Zijlstra <peterz@infradead.org>
>>>>
>>>> I'm planning on sticking this in x86/mm so that it goes upstream
>>>> along with the W+X detection code.
>>>>
>>>> --
>>>>
>>>> A recent x86/mm change warns and refuses to create W+X mappings.
>>>>
>>>> The 32-bit EFI code tries to create such a mapping and trips over
>>>> the new W+X refusal.
>>>>
>>>> Make the EFI_RUNTIME_SERVICES_CODE mapping read-only to fix it.
>>>>
>>>
>>> This is not safe. EFI_RUNTIME_SERVICES_CODE covers both .text and
>>> .data sections of the EFI runtime PE/COFF executables in memory, so
>>> you are essentially making .data and .bss read-only. (Whether those
>>> executables actually modify their .data and .bss at runtime is a
>>> different matter, but the point is that it used to be possible)
>>>
>>> More recent firmwares may provide a 'memory attributes table'
>>> separately which describes the individual sections, but older 32-bit
>>> firmwares are not even built with 4k section alignment, so code and
>>> data may share a single page. Note that we haven't wired up this
>>> memory attributes table on i386 at the moment, and I seriously doubt
>>> that 32-bit firmware in the field exposes it.
>>>
>>> Can we just turn off this feature for 32-bit?
>>
>> Goodie; some seriously security minded people who did that EFI turd :/
> 
> To be fair, most people tended to care more about memory footprint
> than about security at the time. And I don't recall a lot of
> enthusiasm in the Linux community either for rounding up kernel
> sections so they could be mapped with W^X permissions. And without
> PAE, all memory is executable anyway.
> 
>> Let's just heap it on the pile of 32bit sucks and should not be
>> considered a security target anymore and indeed kill this feature.
>>
> 
> I take it this issue is triggered by the fact that i386 maps the EFI
> runtime regions into the kernel page tables, and are therefore always
> mapped, right? If anyone cares enough about this to go and fix it, we
> could switch to the approach we use everywhere else, i.e., treat EFI
> memory as user space mappings, and activate them only while a runtime
> service is in progress.
> 
> But frankly, why would anyone still be running this? With the EFI
> mixed mode support, only systems with CPUs that don't actually
> implement long mode still need this, and I am skeptical that such
> deployments would use recent kernels.

It is supported, thus I run qemu tests for it. That is the whole point
of testing, after all. If PAE (assuming that is what you are talking
about) is no longer supported or supportable, its support should be
removed. If so, I'll be very happy to stop testing it.

Thanks,
Guenter
