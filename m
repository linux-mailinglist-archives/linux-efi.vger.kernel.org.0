Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF0F2576
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 03:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfKGCeE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Nov 2019 21:34:04 -0500
Received: from foss.arm.com ([217.140.110.172]:48960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbfKGCeE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 6 Nov 2019 21:34:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ADE246A;
        Wed,  6 Nov 2019 18:34:03 -0800 (PST)
Received: from [192.168.0.10] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A53C23F6C4;
        Wed,  6 Nov 2019 18:34:01 -0800 (PST)
Subject: Re: [PATCH] efi: Return EFI_RESERVED_TYPE in efi_mem_type() for
 absent addresses
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <1572931429-487-1-git-send-email-anshuman.khandual@arm.com>
 <CAKv+Gu-q16Z=tyeb3b5NnjBkw9cRoeEM6OQaT6dGe1i+9iJa9w@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ea8db10a-503d-b1b6-2674-8533bb804715@arm.com>
Date:   Thu, 7 Nov 2019 08:04:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-q16Z=tyeb3b5NnjBkw9cRoeEM6OQaT6dGe1i+9iJa9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/06/2019 10:31 PM, Ard Biesheuvel wrote:
> On Tue, 5 Nov 2019 at 21:39, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> The function efi_mem_type() is expected (per documentation above) to return
>> EFI_RESERVED_TYPE when a given physical address is not present in the EFI
>> memory map. Even though EFI_RESERVED_TYPE is not getting checked explicitly
>> anywhere in the callers, it is always better to return expected values.
>>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: linux-efi@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> This reverts commit f99afd08a45fbbd9ce35a7624ffd1d850a1906c0.
> 
> Could you explain why it is better to fix the code than fix the comment?

From the above commit message, its not clear how returning EFI_RESERVED_TYPE
would have meant that a memory descriptor really exists.

Just wondering if firmware itself can send across memory descriptors with
EFI_RESERVED_TYPE attribute or it is only a software specific attribute ?
Currently it is being used while merging two adjacent regions with similar
type and attributes. Searching for physical addresses within those merged
memory descriptors will return EFI_RESERVED_TYPE but that is different than
the entry not being present at all. So I think the previous commit which
introduced -EINVAL/-ENOTSUPP in place for EFI_RESERVED_TYPE did the right
thing.

We should fix the comment instead, will send a patch.

> 
>> ---
>>  drivers/firmware/efi/efi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
>> index 69f00f7453a3..bdda90a4601e 100644
>> --- a/drivers/firmware/efi/efi.c
>> +++ b/drivers/firmware/efi/efi.c
>> @@ -914,7 +914,7 @@ int efi_mem_type(unsigned long phys_addr)
>>                                   (md->num_pages << EFI_PAGE_SHIFT))))
>>                         return md->type;
>>         }
>> -       return -EINVAL;
>> +       return EFI_RESERVED_TYPE;
>>  }
>>  #endif
>>
>> --
>> 2.20.1
>>
