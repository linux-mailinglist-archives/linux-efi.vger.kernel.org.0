Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8D561DFF9
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 03:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKFC1C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Nov 2022 22:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKFC1B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Nov 2022 22:27:01 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F24BCB0
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 19:26:59 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2FDA7423EB
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 02:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667701615;
        bh=P6u2WmRDYL1dlzlL/pYw5uAsAA/GGQRj4sa9fHVMvCM=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=TCGHij+iV+40zOMXki6Bd0wzb56PZ2EQfwMMGh69imiVIHHCqjLVFoMLrzq8RjfXI
         zGFUea6RAqNigE5fxTWcc5U2OYll2zyw8c582eTWfdy0JJrn5pnosN9iUC2Fi6REQw
         twNqdZd0tOqhPcfgPNLkjMCX2AgtJDnAz90L37Ioohe61OKadbS3P7TSax1IrvqYxQ
         wqpZQrO5QFZt94b212F2VRJqLCthRPexRKeFTl5cHgGBQjTW0CQlY0D5ygDzT2Q5aV
         iUxYzonXev1BosPUp0wkNiyxrnbP4sC9o0b7zQPVqWkLDFik7EolOKbzwTkQSwNnVo
         6PvG/VK4iUY5A==
Received: by mail-wm1-f69.google.com with SMTP id l42-20020a05600c1d2a00b003cf8e70c1ecso2979464wms.4
        for <linux-efi@vger.kernel.org>; Sat, 05 Nov 2022 19:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6u2WmRDYL1dlzlL/pYw5uAsAA/GGQRj4sa9fHVMvCM=;
        b=pcePAm2YkbVmFatNGyU1iN8VA9dVROmaKiBZovUbhfRc9PuhszbY/p1dsbW5enj2JF
         BbbwiKnRdZF/Uvz7owSdE+srgCJrVyS9GMuUlqP4tnOY/+HM6k5MvnnGZih69N+UJmdw
         Kxp4xxDeK1oAdhc1V39NfCfETYpX70jPfT9IowC3wKhCPXiyLbqmQhXoSoHf5TrqLljT
         7Wt3FXP/GSfFBK3ClBA8Uk0cK2wKQNiCnyC2GpTtG9qDwa0kL+NOdNSks7ig3WT/Pgq0
         0iMMUEZ9ySuGMqRxARXgj6z/K8ThMPc7a/8cqJ3W3Cm1ycuO0j6UQGZwgCh1g7ty5oTe
         SMnQ==
X-Gm-Message-State: ANoB5pnMQ+cJJfRD5KGTFbyRNDX41vVTfq3t863gwQxlnIf+xhSF4f8j
        utuwrI8sFNNKKRJDASf3XZHQC5qqCdZ4wq3NHzFGeWRYXbniHqWu0CyecUn3+sZIOccpq5aG2ha
        tibpyYe2PAn3NEeL+5VjLJUzK0LJGSl7t9xMyhQ==
X-Received: by 2002:a5d:544a:0:b0:236:77f4:6e15 with SMTP id w10-20020a5d544a000000b0023677f46e15mr4603233wrv.117.1667701614013;
        Sat, 05 Nov 2022 19:26:54 -0700 (PDT)
X-Google-Smtp-Source: AA0mqf40N6PYclPiroMdh1e2+5CBDCxUdDowaHykfj0wzixs/MxFgbet+HuwnOR90PHe1G9ffnBuMw==
X-Received: by 2002:a5d:544a:0:b0:236:77f4:6e15 with SMTP id w10-20020a5d544a000000b0023677f46e15mr4603219wrv.117.1667701613715;
        Sat, 05 Nov 2022 19:26:53 -0700 (PDT)
Received: from [192.168.123.94] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id iw14-20020a05600c54ce00b003cf71b1f66csm4133416wmb.0.2022.11.05.19.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 19:26:53 -0700 (PDT)
Message-ID: <467c7858-305f-8a98-d974-d5dea8b84101@canonical.com>
Date:   Sun, 6 Nov 2022 03:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: efi: Make runtime region misalignment warning less
 noisy
Content-Language: en-US
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        torvalds@linux-foundation.org
References: <20221105225234.3089177-1-ardb@kernel.org>
 <86e2cd39-630a-da76-bbfd-99815a8c2753@canonical.com>
In-Reply-To: <86e2cd39-630a-da76-bbfd-99815a8c2753@canonical.com>
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



On 11/6/22 00:24, Heinrich Schuchardt wrote:
> On 11/5/22 23:52, Ard Biesheuvel wrote:
>> The EFI spec requires that on arm64 systems, all runtime code and data
>> regions that share a 64k page can be mapped with the same memory type
>> attributes. Unfortunately, this does not take permission attributes into
>> account, and so the firmware is permitted to expose runtime code and
>> data regions that share 64k pages, and this may prevent the OS from
>> using restricted permissions in such cases, e.g., map data regions with
>> non-exec attributes.
> 
> This is the relevant paragraph in the UEFI specification:
> 
> <cite>
> The ARM architecture allows mapping pages at a variety of granularities, 
> including 4KiB and 64KiB. If a 64KiB physical page contains any 4KiB 
> page with any of the following types listed below, then all 4KiB pages 
> in the 64KiB page must use identical ARM Memory Page Attributes (as 
> described in Map EFI Cacheability Attributes to AArch64 Memory Types):
> 
> - EfiRuntimeServicesCode
> - EfiRuntimeServicesData
> - EfiReserved
> - EfiACPIMemoryNVS
> 
> Mixed attribute mappings within a larger page are not allowed.
> </cite>
> 
> It remains unclear if only EFI Cacheability of also other page 
> attributes are meant. The UEFI specification should be clarified in this 
> respect.
> 
>>
>> We currently emit a warning when hitting this at boot, but the warning
>> is problematic for a number of reasons:
>> - it uses WARN() which spews a lot of irrelevant information into the
>>    log about the execution context where the issue was detected;
>> - it only takes the start of the region into account and not the size
> 
> Is the occurrence of the warning specific to U-Boot or do you see the 
> warning with EDK II too?
> 
>>
>> Let's just drop the warning, as the condition does not strictly violate
>> the spec (although it only occurs with U-Boot), and fix the check to
>> take both the start and the end addresses into account.
>>
>> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>   arch/arm64/kernel/efi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
>> index e1be6c429810d0d5..3dd6f0c66f8aeb78 100644
>> --- a/arch/arm64/kernel/efi.c
>> +++ b/arch/arm64/kernel/efi.c
>> @@ -25,8 +25,8 @@ static __init pteval_t 
>> create_mapping_protection(efi_memory_desc_t *md)
>>       if (type == EFI_MEMORY_MAPPED_IO)
>>           return PROT_DEVICE_nGnRE;
>> -    if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
>> -              "UEFI Runtime regions are not aligned to 64 KB -- buggy 
>> firmware?"))
>> +    if (!PAGE_ALIGNED(md->phys_addr) ||
>> +        !PAGE_ALIGNED(md->num_pages * EFI_PAGE_SIZE))
> 
> Enhancing the check is correct.

The UEFI requirement is that within a 64 KiB page all memory descriptors
shall use the same page attributes if any 4 KiB sub-page is of one of 
the following types.

- EfiRuntimeServicesCode
- EfiRuntimeServicesData
- EfiReserved
- EfiACPIMemoryNVS

It is not required that memory descriptors shall be aligned to 64 KiB 
boundaries.

So the following map should not pose any problem:

00000-00fff - EfiBootServicesData (not used at runtime)
01000-13fff - EfiRuntimeServicesData
14000-1ffff - EfiRuntimeServicesData
20000-24fff - EfiRuntimeServicesCode
25000-27fff - EfiBootServicesCode (not used at runtime)
28000-3ffff - EfiRuntimeServicesCode

Evaluating each memory descriptor individually looks wrong. You first 
have to extend each memory descriptor of one of the four aforementioned 
memory types to the next 64 KiB boundary or within a 64 KiB boundary to 
the next descriptor of one of the aforementioned memory types. Next you 
have to merge adjacent descriptors with same attributes within the same 
64 KiB page.

So the map for which you set attributes would become

00000-1ffff - EfiRuntimeServicesData
20000-3ffff - EfiRuntimeServicesCode

I guess all that alignment and merging should go into efi_virtmap_init().

Best regards

Heinrich

> 
> The warning tells that Linux cannot establish secure settings for some 
> pages. It would be preferable to keep it and fix the UEFI specification 
> and the firmware instead.
> 
> Best regards
> 
> Heinrich
> 
>>           /*
>>            * If the region is not aligned to the page size of the OS, we
>>            * can not use strict permissions, since that would also affect
