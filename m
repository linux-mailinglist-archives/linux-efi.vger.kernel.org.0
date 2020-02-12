Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1D15AB97
	for <lists+linux-efi@lfdr.de>; Wed, 12 Feb 2020 16:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgBLPAb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Feb 2020 10:00:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36741 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727231AbgBLPAb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Feb 2020 10:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581519629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVLTL3wtc9guvBIMXw4f+j+RLRJsUe4n3G+RDm49UEw=;
        b=B67OMb0srGx5bw6vkf8CE6s/ilKOesSm1f9Pj6XAev1Xb6wMahe3vnYij3unIuZ9cNRTbN
        1F4ZmszWgDVbUa4Z5OA64jZ6tR8tWmvS5+3gNadFYCbwoSra0JqqLyNx/i9iIPWP11JD/I
        D9X1cYaZQ4occ2+CB55/sA5HFNhWv0E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-pTWSrrhaP6mi1iyNN9B7fw-1; Wed, 12 Feb 2020 10:00:27 -0500
X-MC-Unique: pTWSrrhaP6mi1iyNN9B7fw-1
Received: by mail-wm1-f72.google.com with SMTP id y125so1897008wmg.1
        for <linux-efi@vger.kernel.org>; Wed, 12 Feb 2020 07:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SVLTL3wtc9guvBIMXw4f+j+RLRJsUe4n3G+RDm49UEw=;
        b=hS2Ljh9l5NtdQD5e3QnNqGpwr46jjaqR+fHfntcpx5s2L2d31Uc33SrwNmiqm1vA2Q
         jRyfwCwuvkVzOdwZjbVr+Q5LSElOobzl9iWKvIE9WgDfCzmrfOTivuuvdg9BQTKiJILq
         NwVBjpXEf6NcIBTFo9LKstMhh5am6eS8EWSO/4G0sB2/q0BNZzSFmPy4Cf39f4CmbsWJ
         U6U230Q7YCeC5fDjFsfz2kRmaOwWx+kWkWENDL2TMZdDg4wR042tMNl1FPSlwMECcl5m
         tYq6rUlqoyo58RrOua8jTgcD36zDb9sD5taMia2wQI4KU+664GVvwILjPmcrzFeJDHMQ
         s7sw==
X-Gm-Message-State: APjAAAVeAHgYkAESc6UtKuGJsLLz6MNNVjyzNsJcA20PRAwqL2S6OvkD
        IndNvLKpyIeKLR0xt5gP3MCAWbnsR6Q6OOGYGZWs4ZiS8cvHT2RdFQFJS6heTUcIfC0ur+u26Ql
        Kg8uGTKNJwzIBZ9bP3T9S
X-Received: by 2002:adf:dfce:: with SMTP id q14mr16003145wrn.324.1581519626049;
        Wed, 12 Feb 2020 07:00:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxB/cKB9aYu/zbdmuHr62rluM/5xYoNcO2axfdsL1+F5z6uFkk/zEE561uTJ93T3++KBnrrIA==
X-Received: by 2002:adf:dfce:: with SMTP id q14mr16003118wrn.324.1581519625690;
        Wed, 12 Feb 2020 07:00:25 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id w1sm984408wro.72.2020.02.12.07.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 07:00:25 -0800 (PST)
Subject: Re: New EFI thunk alignment WARN_ON in 5.6 triggers multiple times
To:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Matt Fleming <matt@codeblueprint.co.uk>
Cc:     linux-efi <linux-efi@vger.kernel.org>
References: <aaf658ab-82ff-4a35-2984-77150924d3a7@redhat.com>
 <CAKv+Gu9fh_reYp65QXCeL4X3iovrCQFGNZWS3jMkpveZLgre-A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ab45ebd9-b2c3-d2f9-8947-be95aaab80bd@redhat.com>
Date:   Wed, 12 Feb 2020 16:00:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9fh_reYp65QXCeL4X3iovrCQFGNZWS3jMkpveZLgre-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 2/12/20 12:53 PM, Ard Biesheuvel wrote:
> On Wed, 12 Feb 2020 at 12:44, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Ard,
>>
>> While booting 5.6-rc1 on one of my test machines I noticed the WARN_ON
>> on line 198 of arch/x86/platform/efi/efi_64.c trigger many times.
>>
>> I've done some debugging on this an this is caused by the following
>> call path:
>>
>> drivers/firmware/efi/vars.c: efivar_init():
>>
>>           unsigned long variable_name_size = 1024;
>>           efi_char16_t *variable_name;
>>           efi_guid_t vendor_guid;
>>
>>           variable_name = kzalloc(variable_name_size, GFP_KERNEL);
>>           if (!variable_name) {
>>                   printk(KERN_ERR "efivars: Memory allocation failed.\n");
>>                   return -ENOMEM;
>>           }
>>
>>          ...
>>
>>
>>           do {
>>                   variable_name_size = 1024;
>>
>>                   status = ops->get_next_variable(&variable_name_size,
>>                                                   variable_name,
>>                                                   &vendor_guid);
>>          ...
>>
>> arch/x86/platform/efi/efi_64.c: efi_thunk_get_next_variable()
>>
>>          ...
>>           phys_vendor = virt_to_phys_or_null(vendor);
>>          ...
>>
>> arch/x86/platform/efi/efi_64.c: virt_to_phys_or_null_size()
>>
>>          ...
>>          WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
>>          ...
>>
>> Specifically the problem is that the efi_guid_t vendor_guid has an 8 bytes
>> aligned address and the WARN_ON checks for it being aligned to\
>> sizeof(efi_guid_t) which is 16 bytes.
>>
>> I've fixed this for now with the following local fix, but I'm not sure
>> what the alignment rules actually are so I'm not sure this is correct:
>>
>> --- a/arch/x86/platform/efi/efi_64.c
>> +++ b/arch/x86/platform/efi/efi_64.c
>> @@ -181,6 +181,7 @@ static inline phys_addr_t
>>    virt_to_phys_or_null_size(void *va, unsigned long size)
>>    {
>>          bool bad_size;
>> +       int alignment;
>>
>>          if (!va)
>>                  return 0;
>> @@ -195,7 +196,8 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
>>           */
>>          bad_size = size > PAGE_SIZE || !is_power_of_2(size);
>>
>> -       WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
>> +       alignment = size > 8 ? 8 : size;
>> +       WARN_ON(!IS_ALIGNED((unsigned long)va, alignment) || bad_size);
>>
>>          return slow_virt_to_phys(va);
>>    }
>>
>>
>> I have a feeling that this is the right thing to do, but as said I'm not 100%
>> sure. If you can confirm that this is the right fix, then I can submit this
>> upstream.
>>
> 
> 
> It seems that the purpose of the alignment check is to ensure that the
> data does not cross a page boundary, so that the data is guaranteed to
> be contiguous in the physical address space as well.
> 
> So in that light, the fix is most definitely wrong, although I am not
> sure how this is supposed to work generally.

I'm not sure that is what it is trying to check, if that is what it is
trying to check then the code is certainly wrong.

Let me first quote the entire check:

         /*
          * A fully aligned variable on the stack is guaranteed not to
          * cross a page bounary. Try to catch strings on the stack by
          * checking that 'size' is a power of two.
          */
         bad_size = size > PAGE_SIZE || !is_power_of_2(size);

         WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);

AFAIK EFI is using the identity map, and the kernel stack is
physically contiguous, so crossing a page boundary should not a
problem. Also notice how the bad_size thing is talking about
page boundary crossing, but the thing triggering is the
IS_ALIGNED check. AFAIK there is no requirement for a struct, e.g.
an UUID (which is the problem here) to be aligned to its size,
it just needs to be 8 byte / 64 bit aligned, which it is yet
the IS_ALIGNED check is failing because it is checking for
a larger, in this case twice as large, but possibly it will
end up checking for a much larger alignment.

As said I'm not exactly familiar with the alignment requirements
but the current check certainly seems wrong.

It seems that we have had this around for a while, it stems from:

###
 From f6697df36bdf0bf7fce984605c2918d4a7b4269f Mon Sep 17 00:00:00 2001
From: Matt Fleming <matt@codeblueprint.co.uk>
Date: Sat, 12 Nov 2016 21:04:24 +0000
Subject: [PATCH v3] x86/efi: Prevent mixed mode boot corruption with
  CONFIG_VMAP_STACK=y

Booting an EFI mixed mode kernel has been crashing since commit:

   e37e43a497d5 ("x86/mm/64: Enable vmapped stacks (CONFIG_HAVE_ARCH_VMAP_STACK=y

The user-visible effect in my test setup was the kernel being unable
to find the root file system ramdisk. This was likely caused by silent
memory or page table corruption.

Enabling CONFIG_DEBUG_VIRTUAL=y immediately flagged the thunking code as
abusing virt_to_phys() because it was passing addresses that were not
part of the kernel direct mapping.

Use the slow version instead, which correctly handles all memory
regions by performing a page table walk.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
###

But I guess the recent changes are triggering the alignment check now.

Alternatively we could make the GUID kalloc-ed instead of having it
on the stack, but that seems unnecessary.

Andy, Matt, do you have any input on this?

Regards,

Hans


