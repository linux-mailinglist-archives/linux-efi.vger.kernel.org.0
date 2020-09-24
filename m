Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CCC277916
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 21:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgIXTWD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 15:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbgIXTWD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Sep 2020 15:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600975321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dX4OD1ueMgsQEoq8Z4Y0fDxS0O0Ba9CI60nRT5IRO0=;
        b=H0mw99pBiSXIggkF713Pf0HTJ+ArK0t6HG4MIZnGmhWuxcpsrJF0Z1vIluSM9Yf6twCEt/
        YSm8/ZJObnLqQJKaPVafkZ12ue058jh/5XAP5GaUYdfZhADv9/nALIXk0wK2CZAOFCmZvh
        aLY+S/lMB58yP1hA9pDNkydiOVl6OHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-gsZM9C0XOPexWMCmJcaswg-1; Thu, 24 Sep 2020 15:21:59 -0400
X-MC-Unique: gsZM9C0XOPexWMCmJcaswg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D780388EF0F;
        Thu, 24 Sep 2020 19:21:57 +0000 (UTC)
Received: from [10.10.110.8] (unknown [10.10.110.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3F6627BAA;
        Thu, 24 Sep 2020 19:21:56 +0000 (UTC)
Subject: Re: [PATCH] efi: mokvar-table: fix some issues in new code
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@alien8.de>
References: <20200924160546.8967-1-ardb@kernel.org>
 <20200924191217.GA121581@rani.riverdale.lan>
From:   Lenny Szubowicz <lszubowi@redhat.com>
Message-ID: <eb4aa484-e5bf-49e6-6768-bae9bf591e0f@redhat.com>
Date:   Thu, 24 Sep 2020 15:21:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924191217.GA121581@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/24/20 3:12 PM, Arvind Sankar wrote:
> On Thu, Sep 24, 2020 at 06:05:46PM +0200, Ard Biesheuvel wrote:
>> Fix a couple of issues in the new mokvar-table handling code, as
>> pointed out by Arvind and Boris:
>> - don't bother checking the end of the physical region against the start
>>    address of the mokvar table,
>> - ensure that we enter the loop with err = -EINVAL,
>> - replace size_t with unsigned long to appease pedantic type equality
>>    checks.
>>
>> Cc: Lenny Szubowicz <lszubowi@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Arvind Sankar <nivedita@alum.mit.edu>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Reviewed-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Lenny Szubowicz <lszubowi@redhat.com>

> 
>> ---
>>   drivers/firmware/efi/mokvar-table.c | 25 +++++++++++--------------
>>   1 file changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
>> index b1cd49893d4d..72a9e1736fef 100644
>> --- a/drivers/firmware/efi/mokvar-table.c
>> +++ b/drivers/firmware/efi/mokvar-table.c
>> @@ -98,15 +98,14 @@ static struct kobject *mokvar_kobj;
>>   void __init efi_mokvar_table_init(void)
>>   {
>>   	efi_memory_desc_t md;
>> -	u64 end_pa;
>>   	void *va = NULL;
>> -	size_t cur_offset = 0;
>> -	size_t offset_limit;
>> -	size_t map_size = 0;
>> -	size_t map_size_needed = 0;
>> -	size_t size;
>> +	unsigned long cur_offset = 0;
>> +	unsigned long offset_limit;
>> +	unsigned long map_size = 0;
>> +	unsigned long map_size_needed = 0;
>> +	unsigned long size;
>>   	struct efi_mokvar_table_entry *mokvar_entry;
>> -	int err = -EINVAL;
>> +	int err;
>>   
>>   	if (!efi_enabled(EFI_MEMMAP))
>>   		return;
>> @@ -122,18 +121,16 @@ void __init efi_mokvar_table_init(void)
>>   		pr_warn("EFI MOKvar config table is not within the EFI memory map\n");
>>   		return;
>>   	}
>> -	end_pa = efi_mem_desc_end(&md);
>> -	if (efi.mokvar_table >= end_pa) {
>> -		pr_err("EFI memory descriptor containing MOKvar config table is invalid\n");
>> -		return;
>> -	}
>> -	offset_limit = end_pa - efi.mokvar_table;
>> +
>> +	offset_limit = efi_mem_desc_end(&md) - efi.mokvar_table;
>> +
>>   	/*
>>   	 * Validate the MOK config table. Since there is no table header
>>   	 * from which we could get the total size of the MOK config table,
>>   	 * we compute the total size as we validate each variably sized
>>   	 * entry, remapping as necessary.
>>   	 */
>> +	err = -EINVAL;
>>   	while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
>>   		mokvar_entry = va + cur_offset;
>>   		map_size_needed = cur_offset + sizeof(*mokvar_entry);
>> @@ -150,7 +147,7 @@ void __init efi_mokvar_table_init(void)
>>   				       offset_limit);
>>   			va = early_memremap(efi.mokvar_table, map_size);
>>   			if (!va) {
>> -				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%zu.\n",
>> +				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%lu.\n",
>>   				       efi.mokvar_table, map_size);
>>   				return;
>>   			}
>> -- 
>> 2.17.1
>>
> 

