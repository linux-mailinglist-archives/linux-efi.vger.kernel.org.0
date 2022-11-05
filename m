Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5761DFA0
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 00:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiKEXLQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Nov 2022 19:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKEXLM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Nov 2022 19:11:12 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3ADFA1
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 16:11:10 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1068A412CA
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 23:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667689868;
        bh=CnjNsYUiE3jdMgAhWBEGga3tYdGIV/5rIupuUIZlDLQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pfnlBzFemXF8C+EpXBrtHJq6CY2jnl4RS0l2hAdJ+/MA/xRJe7dIyAoDBmV+zkXbR
         jmK/Y9LvAW/vBTGaiRtOgNpYxyaDHR2giAP3oTvY8EoOXzmD3V849pW9oNycVgcJTc
         qAHZmWoGZqo4H+MphtdswN6PLOAX4i2VDqcDzFldWf0uN73Z4SLyfqLMqLwbz5eYdN
         PsQercZaPk/2mnz7GuEehDcjdijCnZMPc65X4qIhE2DVVI9KZMkCH4YTSbVb4YLMSs
         p25iOh1zVrgJ7cnMlruvdw+3mehIiCfBl2Xan4KL70HZEfw1dqDVe0HggGCQzTl8gx
         X/aHYJNaix6NA==
Received: by mail-wm1-f71.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so6326031wme.7
        for <linux-efi@vger.kernel.org>; Sat, 05 Nov 2022 16:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnjNsYUiE3jdMgAhWBEGga3tYdGIV/5rIupuUIZlDLQ=;
        b=q8L9wWZu+MZNnY4T0pqwNxX8M58xPIBHuXXndF7HED9Le9HUPew3aocz43orGqgzT9
         254O50wdOqjRSPtmHVsH8XuWQqL/T7mIgXXakZVWPTOgAdiNv5PgFH0V4hiL+zMgStw7
         QpClVQiRyvEoAjPJ+Er6nU0RIjOI/zUOnJm7AtTin0y6DroTQEjfdMDeWU12Chk7Jbkq
         /oSHjGloJviM4YiciAauSC3fBB+U266rv+ARGVwwTZiLd+BYosjTBn8KWMyY2VCNxPAZ
         Gxxq+0qyOy6HM4ivO/GZ2S4gBGwhnQIhutahf1sSjiuTSYDRbpHCIu6iAg+oPeIjGH4i
         EAvQ==
X-Gm-Message-State: ACrzQf1fXL1wWX92F0k5kz8nmTrXnjuF9HuamlredZIcKMgeUFKgj0q7
        3MuQAbLS5mCijRjDXKCDyvinXuH/Xf7SirlCIfnzynKEdGEKob+lfCXfCpI/DWnD0USoHIRl1yR
        nRJ0+E3plkAiltO1zoLuJ3xU70ov35yDs5h0Oxg==
X-Received: by 2002:a05:600c:1d8f:b0:3cf:54f4:ef4 with SMTP id p15-20020a05600c1d8f00b003cf54f40ef4mr34828283wms.190.1667689866413;
        Sat, 05 Nov 2022 16:11:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7cGzltDfgIoI4/yQ8PuBWrjNanx0LRt3IW7tF8w3cWqE8twNQahYqe+qDqeLKgPDBenIj2cQ==
X-Received: by 2002:a05:600c:1d8f:b0:3cf:54f4:ef4 with SMTP id p15-20020a05600c1d8f00b003cf54f40ef4mr34828275wms.190.1667689866119;
        Sat, 05 Nov 2022 16:11:06 -0700 (PDT)
Received: from [192.168.123.94] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id t13-20020a5d460d000000b002366f9bd717sm3983173wrq.45.2022.11.05.16.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 16:11:05 -0700 (PDT)
Message-ID: <0653f2f4-cde5-40e0-c576-4e7c23dc5d90@canonical.com>
Date:   Sun, 6 Nov 2022 00:11:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Remove WARN_ONCE for unaligned UEFI region?
To:     Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        G Edhaya Chandran <Edhaya.Chandran@arm.com>
References: <CAHk-=whPRmHQ=KV9B3_jeOG4ydj8gkMwQKnde7BJ4wJjveyMDQ@mail.gmail.com>
 <CAMj1kXFkp_W4P7twyZhM2mrP0PibOdWAwvKg-rb_jvh08RG_sg@mail.gmail.com>
 <CAHk-=wg2j9Fz-QVjmwqs+Uv9K-+rO9cviAokmvbFhwimtOGJpw@mail.gmail.com>
 <CAMj1kXG5q_UZuPUtifSxwstMBf4QD-Q0=gObk1WzLmMMegduqg@mail.gmail.com>
Content-Language: en-US
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXG5q_UZuPUtifSxwstMBf4QD-Q0=gObk1WzLmMMegduqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/5/22 22:54, Ard Biesheuvel wrote:
> (cc Heinrich and Ilias)
> 
> On Sat, 5 Nov 2022 at 21:27, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Sat, Nov 5, 2022 at 1:18 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>
>>> Yeah just rip it out. In the beginning, we tended to make these
>>> warnings noisy so people will actually notice.
>>
>> Rip it out entirely, or replace ith pr_warn_once()?
>>
> 
> A warning that can only trigger on 16k or 64k page size kernels
> clearly doesn't have a lot of coverage, so either we just drop it, or
> we make the warning use SZ_64K and not PAGE_SIZE.
> 
> And if we keep the warning, it should be separate from the if(): when
> the regions are misaligned, we have to use RWX mappings because an
> adjacent region that gets covered by the same mapping might require
> it.
> 
> Maybe I'll just whip up a patch myself.
> 
>>> I'd still like to see a memory map (boot with efi=debug) so we can get
>>> this reported and fixed in uboot. We need that so 16k and 64k pages
>>> boot doesn't cause surprises with overlapping mappings.
>>
>> Here's the dmesg attached with efi=debug for your viewing pleasure.
>>
> 
> Thanks.
> 
> I've cc'ed the u-boot EFI maintainers, who take EFI spec compliance
> very seriously, so I'm sure we'll get this fixed quickly.

It seems the thread
https://lore.kernel.org/linux-efi/CAHk-=whPRmHQ=KV9B3_jeOG4ydj8gkMwQKnde7BJ4wJjveyMDQ@mail.gmail.com/
refers to:

arch/arm64/kernel/efi.c:28:
if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),

Function create_mapping_protection() checks UEFI Permission Attributes 
of pages.

This is the related requirement in the UEFI 2.9 specification:

<cite>
The ARM architecture allows mapping pages at a variety of granularities, 
including 4KiB and 64KiB. If a 64KiB physical page contains any 4KiB 
page with any of the following types listed below, then all 4KiB pages 
in the 64KiB page must use identical ARM Memory Page Attributes (as 
described in Map EFI Cacheability Attributes to AArch64 Memory Types ):

- EfiRuntimeServicesCode
- EfiRuntimeServicesData
- EfiReserved
- EfiACPIMemoryNVS
</cite>

The specification only refers to EFI cacheability attributes but not to 
UEFI Permission Attributes. Should the specification be updated in this 
regard?

The next steps to take are:

1) clarify the ARM hardware requirements for UEFI Permission Attributes
2) update the UEFI specification to make it clear if UEFI Permission 
Attributes have to follow the 64 KiB rule.
3) update the UEFI Self-Certification Test (SCT) to check the rules.
4) update U-Boot to respect 64 KiB requirements when allocating new pages.

We already have commit 7a82c3051c8 ("efi_loader: Align runtime section 
to 64kb") in U-Boot but that neither covers runtime data nor allocation 
of memory (AllocatePages(), AllocatedPool()).

The warning in question indicates that Linux currently is not able to 
establish secure page attributes. I see no reason to remove it.

cc: U-Boot mailing list
cc: Edhaya Chandran (regarding UEFI SCT)

Best regards

Heinrich
