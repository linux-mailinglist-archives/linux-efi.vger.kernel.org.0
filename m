Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B37E15BA1D
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 08:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgBMHgo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 02:36:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727123AbgBMHgo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Feb 2020 02:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581579402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBXPJhUoAHcQ7M3m69S6L3MhY5s1my7cwigdsudghqM=;
        b=YK9leWoN6P5d5dlEkAX6ZBWzklwB9Fa3Hc6By9phJbLmmH5d8SGWBQEDw/yYzxdzeBu+Ki
        M4E9Xxl9V6Gvurx64m5ZbGC/DeA+5gzIMOX0qmVTG9xF647DSEb6+SxFUHoNO5z+s2UcDn
        N4eDPOZMzdB/Dnf4Vi8oJN1+DakQcYw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-gWyObvnXMaOYh7YCyvjCtg-1; Thu, 13 Feb 2020 02:36:40 -0500
X-MC-Unique: gWyObvnXMaOYh7YCyvjCtg-1
Received: by mail-wm1-f69.google.com with SMTP id p2so1653072wmi.8
        for <linux-efi@vger.kernel.org>; Wed, 12 Feb 2020 23:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YBXPJhUoAHcQ7M3m69S6L3MhY5s1my7cwigdsudghqM=;
        b=XeB9trM70tMF8hObE11G4raDoXSVMP3eyhwNloAq0/zsHFu7cclhaYs1nHxbM+08H7
         fJNw/eG2BoD3tPvnBDvYYfAf8O4X5g7Lcq42TeByU2Vbl2VR7qskVFROGFXvxaUJkkZx
         Cq2tHYlh8y/gixlVd6FxoGvpcCofzwxaoggjIKRRqf2GJiqQaHCjmJ0JUstelzZjcGTG
         Gqa3izfjliVAL/vystQDN+w50nSj+nVIcD3s6VM9qh63ML/ADcqxakDGkhpd4aVtAASS
         yiUHF77lu9qMwLFw3B+/C3/1OgYrg5fuaoxxpyMQtgTSMBpKSeb2d+4ifWkJY2BD59qA
         qNOA==
X-Gm-Message-State: APjAAAVl7qk6Q6mA2rV+TW5FklezWnxUYfjr4adkn41AmkdFd8bhaIF6
        hbNmqgB8UPE2lKKL3N0eqnF/16qJ7+vZSvW0Ge5kEfR3K2bqnsCUsKC4zxFjM4eanxBdm14wdNr
        D03STlBxEzW8jbzrfc2T3
X-Received: by 2002:adf:ec84:: with SMTP id z4mr20298490wrn.61.1581579399040;
        Wed, 12 Feb 2020 23:36:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqwrmJ48pQ1YfwKzApyzyXYNMi6f59s5Ia7OrvGBleMuycuiATrBbTqMzY7FS0H3qPFpFhOAjQ==
X-Received: by 2002:adf:ec84:: with SMTP id z4mr20298458wrn.61.1581579398738;
        Wed, 12 Feb 2020 23:36:38 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id f65sm1788950wmf.29.2020.02.12.23.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 23:36:38 -0800 (PST)
Subject: Re: New EFI thunk alignment WARN_ON in 5.6 triggers multiple times
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>
References: <aaf658ab-82ff-4a35-2984-77150924d3a7@redhat.com>
 <CAKv+Gu9fh_reYp65QXCeL4X3iovrCQFGNZWS3jMkpveZLgre-A@mail.gmail.com>
 <ab45ebd9-b2c3-d2f9-8947-be95aaab80bd@redhat.com>
 <CAKv+Gu8GmNaS3vffDHcrCvKrbz5YLaVuZ_JoX0nNHBg3Tu0yhQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fcfc69c7-7f29-9415-9f33-b46cf29b0118@redhat.com>
Date:   Thu, 13 Feb 2020 08:36:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8GmNaS3vffDHcrCvKrbz5YLaVuZ_JoX0nNHBg3Tu0yhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 2/12/20 10:08 PM, Ard Biesheuvel wrote:
> On Wed, 12 Feb 2020 at 16:00, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 2/12/20 12:53 PM, Ard Biesheuvel wrote:
>>> On Wed, 12 Feb 2020 at 12:44, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi Ard,
>>>>
>>>> While booting 5.6-rc1 on one of my test machines I noticed the WARN_ON
>>>> on line 198 of arch/x86/platform/efi/efi_64.c trigger many times.
>>>>
>>>> I've done some debugging on this an this is caused by the following
>>>> call path:
>>>>
>>>> drivers/firmware/efi/vars.c: efivar_init():
>>>>
>>>>            unsigned long variable_name_size = 1024;
>>>>            efi_char16_t *variable_name;
>>>>            efi_guid_t vendor_guid;
>>>>
>>>>            variable_name = kzalloc(variable_name_size, GFP_KERNEL);
>>>>            if (!variable_name) {
>>>>                    printk(KERN_ERR "efivars: Memory allocation failed.\n");
>>>>                    return -ENOMEM;
>>>>            }
>>>>
>>>>           ...
>>>>
>>>>
>>>>            do {
>>>>                    variable_name_size = 1024;
>>>>
>>>>                    status = ops->get_next_variable(&variable_name_size,
>>>>                                                    variable_name,
>>>>                                                    &vendor_guid);
>>>>           ...
>>>>
>>>> arch/x86/platform/efi/efi_64.c: efi_thunk_get_next_variable()
>>>>
>>>>           ...
>>>>            phys_vendor = virt_to_phys_or_null(vendor);
>>>>           ...
>>>>
>>>> arch/x86/platform/efi/efi_64.c: virt_to_phys_or_null_size()
>>>>
>>>>           ...
>>>>           WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
>>>>           ...
>>>>
>>>> Specifically the problem is that the efi_guid_t vendor_guid has an 8 bytes
>>>> aligned address and the WARN_ON checks for it being aligned to\
>>>> sizeof(efi_guid_t) which is 16 bytes.
>>>>
>>>> I've fixed this for now with the following local fix, but I'm not sure
>>>> what the alignment rules actually are so I'm not sure this is correct:
>>>>
>>>> --- a/arch/x86/platform/efi/efi_64.c
>>>> +++ b/arch/x86/platform/efi/efi_64.c
>>>> @@ -181,6 +181,7 @@ static inline phys_addr_t
>>>>     virt_to_phys_or_null_size(void *va, unsigned long size)
>>>>     {
>>>>           bool bad_size;
>>>> +       int alignment;
>>>>
>>>>           if (!va)
>>>>                   return 0;
>>>> @@ -195,7 +196,8 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
>>>>            */
>>>>           bad_size = size > PAGE_SIZE || !is_power_of_2(size);
>>>>
>>>> -       WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
>>>> +       alignment = size > 8 ? 8 : size;
>>>> +       WARN_ON(!IS_ALIGNED((unsigned long)va, alignment) || bad_size);
>>>>
>>>>           return slow_virt_to_phys(va);
>>>>     }
>>>>
>>>>
>>>> I have a feeling that this is the right thing to do, but as said I'm not 100%
>>>> sure. If you can confirm that this is the right fix, then I can submit this
>>>> upstream.
>>>>
>>>
>>>
>>> It seems that the purpose of the alignment check is to ensure that the
>>> data does not cross a page boundary, so that the data is guaranteed to
>>> be contiguous in the physical address space as well.
>>>
>>> So in that light, the fix is most definitely wrong, although I am not
>>> sure how this is supposed to work generally.
>>
>> I'm not sure that is what it is trying to check, if that is what it is
>> trying to check then the code is certainly wrong.
>>
>> Let me first quote the entire check:
>>
>>           /*
>>            * A fully aligned variable on the stack is guaranteed not to
>>            * cross a page bounary. Try to catch strings on the stack by
>>            * checking that 'size' is a power of two.
>>            */
>>           bad_size = size > PAGE_SIZE || !is_power_of_2(size);
>>
>>           WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
>>
>> AFAIK EFI is using the identity map, and the kernel stack is
>> physically contiguous, so crossing a page boundary should not a
>> problem.
> 
> CONFIG_HAVE_ARCH_VMAP_STACK=y means the kernel stack may not be
> contiguous in physical memory, which is why this was added in the
> first place.
> 
> We do allocate a special stack for mixed mode, but we only switch to
> it in the .S thunking code, so at this point, we are still running
> from the vmap'ed stack
> 
>> Also notice how the bad_size thing is talking about
>> page boundary crossing, but the thing triggering is the
>> IS_ALIGNED check. AFAIK there is no requirement for a struct, e.g.
>> an UUID (which is the problem here) to be aligned to its size,
>> it just needs to be 8 byte / 64 bit aligned, which it is yet
>> the IS_ALIGNED check is failing because it is checking for
>> a larger, in this case twice as large, but possibly it will
>> end up checking for a much larger alignment.
>>
> 
> The idea is that a data structure of size < PAGE_SIZE is guaranteed
> not to cross a page boundary if it is aligned to a power-of-2 upper
> bound of its size. This has nothing to do with the data type or the
> minimal alignment of any of its constituent parts.

Ok, so I guess that the correct fix is to switch to kmalloc-ing
"efi_guid_t vendor_guid" in efivar_init() instead of declaring it on
the stack?

Regards,

Hans

