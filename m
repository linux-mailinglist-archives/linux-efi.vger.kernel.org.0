Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECF861E1B5
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 11:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKFKoP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Nov 2022 05:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKFKoO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Nov 2022 05:44:14 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4465D5
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 02:44:12 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 25082423F0
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667731450;
        bh=yTMknv/6Yx1Mng8Iwd12qY4QniqopqUzJwFCRjtzytU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=N4J1v3KhDqp2E1elKzBCMU3z3DAUhBrN5ZvZxLGF5vYrtkikDtbzq62GmCotnlPma
         5L0QroIddg36pfuWOX5w3vh0fOzagGzfjSI+uY95UhjnAlwO0L7iFJOgyOuVWmoVuz
         lTkpKqmTUIetVDtVS/oNMj3pTPogPtnDrAsuA6soUHqKUjoqa44iHPhT+C5EfbsOBi
         K3u6iZuNvOD5iFXgfMopOqaz9psrXSFyL76hpxQjQUQ3YQqRq/tTdaL7aZewtZk9UD
         +JwQtNAyHiZnBx+bvPG/aktT+4AHprxCsXn/gn4yD9694CYohWbR15eCHpK6pljsHD
         Smc1XoWmSo5AQ==
Received: by mail-wm1-f70.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso746658wmh.2
        for <linux-efi@vger.kernel.org>; Sun, 06 Nov 2022 02:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTMknv/6Yx1Mng8Iwd12qY4QniqopqUzJwFCRjtzytU=;
        b=I9jv4kyNGRDnnmdFqkxjw09ZVg//dXgx7kYzuJvGigIDCQIcytuGjqAk/3KZZKXDNn
         WgCINgV3h7abf4J7xubsAeaV+ZBMbNOUOC5JQ/x+Lrl1wylpgV+rggQwXwl1deMLEvqu
         Q83sPRPR3NSlWWLzBxJPnCUPs8ZbOIkIoUncWD/xbGuQTsbTP/X7GP1CEn1ABu43tfzH
         49TQ0PSRSbazNKTmdw0C59nAXIRuIyDiIt7fYyU/JW8RRFwgnof7oCy6RcmnEJVcAhjw
         j2rX4vdYBvTTE1Sj3Qhy6Fhfw5qK8xFaskxKENT2p4p4mEZcD3+LN3+q4g3yiWzQ8h25
         9rAw==
X-Gm-Message-State: ACrzQf3koQiQWTu8sHlG6tyaRwKZhWOUuPV7arTXCiC9/KfC/HEMrr7w
        RhBadaCisFAycxqcIfCkAAb+Bsugf/zFUoFMhZG7MoHQm08k6uc6lvqxMY43ccpwoR49UzlLJhg
        Dq6sQtl9xH+TtxUunl7DPN9LvcVAeQ3ZWXzY5Ag==
X-Received: by 2002:a05:6000:16c8:b0:236:c60d:22b9 with SMTP id h8-20020a05600016c800b00236c60d22b9mr24232472wrf.526.1667731449018;
        Sun, 06 Nov 2022 02:44:09 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6sHkiALxsyv9ubyqRHw3GNEj21IvidBdYiEkzm6i3FRlE2dHF3rRIapy50DQN8igxfk/TE0Q==
X-Received: by 2002:a05:6000:16c8:b0:236:c60d:22b9 with SMTP id h8-20020a05600016c800b00236c60d22b9mr24232452wrf.526.1667731448623;
        Sun, 06 Nov 2022 02:44:08 -0800 (PST)
Received: from [172.25.0.188] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b003b4c979e6bcsm9026136wms.10.2022.11.06.02.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 02:44:07 -0800 (PST)
Message-ID: <37dfb84c-dcf1-a78e-0895-ab3e8b21f554@canonical.com>
Date:   Sun, 6 Nov 2022 11:44:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: efi: Make runtime region misalignment warning less
 noisy
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        torvalds@linux-foundation.org
References: <20221105225234.3089177-1-ardb@kernel.org>
 <86e2cd39-630a-da76-bbfd-99815a8c2753@canonical.com>
 <467c7858-305f-8a98-d974-d5dea8b84101@canonical.com>
 <CAMj1kXHX3rZ=jEA-AFqSAkVQbmtFkWCPk1XxMaQB7c8xutPVbw@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXHX3rZ=jEA-AFqSAkVQbmtFkWCPk1XxMaQB7c8xutPVbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/6/22 10:48, Ard Biesheuvel wrote:
> On Sun, 6 Nov 2022 at 03:27, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>>
>>
>> On 11/6/22 00:24, Heinrich Schuchardt wrote:
>>> On 11/5/22 23:52, Ard Biesheuvel wrote:
>>>> The EFI spec requires that on arm64 systems, all runtime code and data
>>>> regions that share a 64k page can be mapped with the same memory type
>>>> attributes. Unfortunately, this does not take permission attributes into
>>>> account, and so the firmware is permitted to expose runtime code and
>>>> data regions that share 64k pages, and this may prevent the OS from
>>>> using restricted permissions in such cases, e.g., map data regions with
>>>> non-exec attributes.
>>>
>>> This is the relevant paragraph in the UEFI specification:
>>>
>>> <cite>
>>> The ARM architecture allows mapping pages at a variety of granularities,
>>> including 4KiB and 64KiB. If a 64KiB physical page contains any 4KiB
>>> page with any of the following types listed below, then all 4KiB pages
>>> in the 64KiB page must use identical ARM Memory Page Attributes (as
>>> described in Map EFI Cacheability Attributes to AArch64 Memory Types):
>>>
>>> - EfiRuntimeServicesCode
>>> - EfiRuntimeServicesData
>>> - EfiReserved
>>> - EfiACPIMemoryNVS
>>>
>>> Mixed attribute mappings within a larger page are not allowed.
>>> </cite>
>>>
>>> It remains unclear if only EFI Cacheability of also other page
>>> attributes are meant. The UEFI specification should be clarified in this
>>> respect.
>>>
>>>>
>>>> We currently emit a warning when hitting this at boot, but the warning
>>>> is problematic for a number of reasons:
>>>> - it uses WARN() which spews a lot of irrelevant information into the
>>>>     log about the execution context where the issue was detected;
>>>> - it only takes the start of the region into account and not the size
>>>
>>> Is the occurrence of the warning specific to U-Boot or do you see the
>>> warning with EDK II too?
>>>
>>>>
>>>> Let's just drop the warning, as the condition does not strictly violate
>>>> the spec (although it only occurs with U-Boot), and fix the check to
>>>> take both the start and the end addresses into account.
>>>>
>>>> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>> ---
>>>>    arch/arm64/kernel/efi.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
>>>> index e1be6c429810d0d5..3dd6f0c66f8aeb78 100644
>>>> --- a/arch/arm64/kernel/efi.c
>>>> +++ b/arch/arm64/kernel/efi.c
>>>> @@ -25,8 +25,8 @@ static __init pteval_t
>>>> create_mapping_protection(efi_memory_desc_t *md)
>>>>        if (type == EFI_MEMORY_MAPPED_IO)
>>>>            return PROT_DEVICE_nGnRE;
>>>> -    if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
>>>> -              "UEFI Runtime regions are not aligned to 64 KB -- buggy
>>>> firmware?"))
>>>> +    if (!PAGE_ALIGNED(md->phys_addr) ||
>>>> +        !PAGE_ALIGNED(md->num_pages * EFI_PAGE_SIZE))
>>>
>>> Enhancing the check is correct.
>>
>> The UEFI requirement is that within a 64 KiB page all memory descriptors
>> shall use the same page attributes if any 4 KiB sub-page is of one of
>> the following types.
>>
>> - EfiRuntimeServicesCode
>> - EfiRuntimeServicesData
>> - EfiReserved
>> - EfiACPIMemoryNVS
>>
>> It is not required that memory descriptors shall be aligned to 64 KiB
>> boundaries.
>>
> 
> Indeed, this is what I misremembered.
> 
>> So the following map should not pose any problem:
>>
>> 00000-00fff - EfiBootServicesData (not used at runtime)
>> 01000-13fff - EfiRuntimeServicesData
>> 14000-1ffff - EfiRuntimeServicesData
>> 20000-24fff - EfiRuntimeServicesCode
>> 25000-27fff - EfiBootServicesCode (not used at runtime)
>> 28000-3ffff - EfiRuntimeServicesCode
>>
>> Evaluating each memory descriptor individually looks wrong. You first
>> have to extend each memory descriptor of one of the four aforementioned
>> memory types to the next 64 KiB boundary or within a 64 KiB boundary to
>> the next descriptor of one of the aforementioned memory types. Next you
>> have to merge adjacent descriptors with same attributes within the same
>> 64 KiB page.
>>
> 
> So now we have to look at adjacent descriptors, which means we have to
> sort the memory map, as there is no guarantee that the descriptors
> appear in order.
> 
>> So the map for which you set attributes would become
>>
>> 00000-1ffff - EfiRuntimeServicesData
>> 20000-3ffff - EfiRuntimeServicesCode
>>
>> I guess all that alignment and merging should go into efi_virtmap_init().
>>
> 
> U-boot does not provide a memory attributes table either, so we don't
> know which parts of the code regions should be mapped R-X and which
> parts RW- (Firmware implementations such as EDK2 that are based on
> PE/COFF images internally use code descriptors for each executable,
> which means they cover both the .text/.rodata and .data/.bss sections
> of the image. The data descriptors are used for dynamic allocations).
> 
> This is why we use RWX for RTcode and RW- for RTdata in absence of the
> RO/XP attributes (which are passed via the memory attributes table
> usually).
> 
> So in summary, I think the patch is fine. The warning is spurious
> given that the condition in question is actually permitted by the
> spec.
> 
> On the uboot side, which already seems to align and round up RTcode
> sections to 64k, we might set the EFI_MEMORY_RO attribute on such
> regions if they really only contain .text and .rodata segments, and
> can tolerate being mapped without writable permissions. That way, the
> kernel will understand that it does not need to provide RWX
> permissions, which is really what all this code is trying to prevent.

Shouldn't EFI_MEMORY_RO only be set if the UEFI firmware actually sets 
up the MMU to make the corresponding memory read only?

Best regards

Heinrich
