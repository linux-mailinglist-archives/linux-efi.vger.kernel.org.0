Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D297247B456
	for <lists+linux-efi@lfdr.de>; Mon, 20 Dec 2021 21:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhLTU1C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Dec 2021 15:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLTU1B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Dec 2021 15:27:01 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD98C061574
        for <linux-efi@vger.kernel.org>; Mon, 20 Dec 2021 12:27:01 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id q74so32160762ybq.11
        for <linux-efi@vger.kernel.org>; Mon, 20 Dec 2021 12:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rRwMSlkH/R/Ejd2xR1IoVjCK03bMv+NXVLtTI3SMpA0=;
        b=Y3Pau7LNCIr2y1Y9ghCCa3rQnyA9qj9XY5g5cGpj6ry+a9R7jHkNMjzotoebUINbzo
         Fe0i1XsGFU0uLXNkeuwauwHBNgkgOopEg+LmSKXB3b4BUhILBpxlgzf8xZnqn3XBLfd5
         3RuN9WvJdqrCxaDajDhefPsR1wHfooLNdE3ceZZyju8I3nmr0/2yXqwOuNSEEMUZ8uLb
         GsZC2Su5Y5Ckc81BqSIAuAyZs17DrbhuENf6N466eTRwMsnocZ6tuEB1vMEvVfV/YfzN
         DOwdQoSDm5zJdJ0+qhEg9qxRiWkbRR8TMw7Gkjx30vuEIfo+oUsZNPUWoVfSJjj4AR1e
         ehHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rRwMSlkH/R/Ejd2xR1IoVjCK03bMv+NXVLtTI3SMpA0=;
        b=4xcigoLtTVzhBJPW24HhksBnuaSYACywrvYss74VvIjKWTWquU/P8HZSTFBCHoL2RO
         JfQkrf73FksYy03YlSGyXS7dkXsPOUIKN9vRtGCwRalgLES0TpZX7c1cmGuYB7KhOPsN
         /kihIiC8QoKAs7mvECHo3rGbFM/rclCdcB1F1YXD77Xre3ZObKpdI4jm1BBp+Nf0yJtW
         usak6wk4tzGPThwMgU3s/2r1Zw1BkIASyLTIeU/XTnUfIbQfUrmgxEUsZvms71an4z/F
         sevNJf8OBTsrzJoJ67Ekqa9VLpXwRr6koWNOCzEK8l+K3tNQcAXJkg+78C79e+ywz94M
         NaQg==
X-Gm-Message-State: AOAM531lO0QTUJUWxZu1zVLOpLC8VqpjeQL/LUZHlttr+KS5RqyU6YRP
        K/hows1687Clw+NTOgFjaj3Q2y8a//6ohMYeq/uPbA==
X-Google-Smtp-Source: ABdhPJy5aQeVM5BTCDPW7ri/FhZ5zyL8WxXRrX2MYvSW/3GaHvFjpnNE8ZYr3gN2N2z+je57vIJCj3D7/pkMvWG6G+o=
X-Received: by 2002:a25:d04d:: with SMTP id h74mr24451313ybg.266.1640032020723;
 Mon, 20 Dec 2021 12:27:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0d:c906:0:0:0:0:0 with HTTP; Mon, 20 Dec 2021 12:27:00
 -0800 (PST)
In-Reply-To: <YcCxUHSMnUJgXIJF@kroah.com>
References: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
 <20211216192222.127908-4-martin.fernandez@eclypsium.com> <YcCxUHSMnUJgXIJF@kroah.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Mon, 20 Dec 2021 17:27:00 -0300
Message-ID: <CAKgze5boi5h08ffpodqsKp5xNS=+u_zJWEVnExdbsXRgJ+eCTQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] x86/e820: Tag e820_entry with crypto capabilities
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        rafael@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/20/21, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Dec 16, 2021 at 04:22:20PM -0300, Martin Fernandez wrote:
>> diff --git a/arch/x86/include/asm/e820/types.h
>> b/arch/x86/include/asm/e820/types.h
>> index 314f75d886d0..7b510dffd3b9 100644
>> --- a/arch/x86/include/asm/e820/types.h
>> +++ b/arch/x86/include/asm/e820/types.h
>> @@ -56,6 +56,7 @@ struct e820_entry {
>>  	u64			addr;
>>  	u64			size;
>>  	enum e820_type		type;
>> +	u8			crypto_capable;
>
> Why isn't this a bool?

It was a bool initially, but Andy Shevchenko told me that it couldn't
be that way because boolean may not be part of firmware ABIs.

>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index bc0657f0deed..001d64686938 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -163,7 +163,7 @@ int e820__get_entry_type(u64 start, u64 end)
>>  /*
>>   * Add a memory region to the kernel E820 map.
>>   */
>> -static void __init __e820__range_add(struct e820_table *table, u64 start,
>> u64 size, enum e820_type type)
>> +static void __init __e820__range_add(struct e820_table *table, u64 start,
>> u64 size, enum e820_type type, u8 crypto_capable)
>
> Horrid api change, but it's internal to this file so oh well :(
>
> Hint, don't add flags to functions like this, it forces you to have to
> always remember what those flags are when you read the code.  Right now
> you stuck "0" and "1" in the function call, which is not instructional
> at all.
>
> Heck, why not make it an enum to have it be self-describing?  Like the
> type is here.  that would make it much better and easier to understand
> and maintain over time.
>

Yes, an enum will absolutely improve things. I'll do that.

>> @@ -327,6 +330,7 @@ int __init e820__update_table(struct e820_table
>> *table)
>>  	unsigned long long last_addr;
>>  	u32 new_nr_entries, overlap_entries;
>>  	u32 i, chg_idx, chg_nr;
>> +	u8 current_crypto, last_crypto;
>>
>>  	/* If there's only one memory region, don't bother: */
>>  	if (table->nr_entries < 2)
>> @@ -367,6 +371,7 @@ int __init e820__update_table(struct e820_table
>> *table)
>>  	new_nr_entries = 0;	 /* Index for creating new map entries */
>>  	last_type = 0;		 /* Start with undefined memory type */
>>  	last_addr = 0;		 /* Start with 0 as last starting address */
>> +	last_crypto = 0;
>>
>>  	/* Loop through change-points, determining effect on the new map: */
>>  	for (chg_idx = 0; chg_idx < chg_nr; chg_idx++) {
>> @@ -388,13 +393,17 @@ int __init e820__update_table(struct e820_table
>> *table)
>>  		 * 1=usable, 2,3,4,4+=unusable)
>>  		 */
>>  		current_type = 0;
>> +		current_crypto = 1;
>>  		for (i = 0; i < overlap_entries; i++) {
>> +			current_crypto = current_crypto && overlap_list[i]->crypto_capable;
>
> Is it a u8 or not?  You treat it as a boolean a lot :(
>
>>  			if (overlap_list[i]->type > current_type)
>>  				current_type = overlap_list[i]->type;
>>  		}
>>
>>  		/* Continue building up new map based on this information: */
>> -		if (current_type != last_type || e820_nomerge(current_type)) {
>> +		if (current_type != last_type ||
>> +		    current_crypto != last_crypto ||
>> +		    e820_nomerge(current_type)) {
>
> Why check it before calling e820_nomerge()?  Is that required?
>

I don't see how the order of the checks matter, am I missing something?

>>  			if (last_type != 0)	 {
>>  				new_entries[new_nr_entries].size = change_point[chg_idx]->addr -
>> last_addr;
>>  				/* Move forward only if the new size was non-zero: */
>> @@ -406,9 +415,12 @@ int __init e820__update_table(struct e820_table
>> *table)
>>  			if (current_type != 0)	{
>>  				new_entries[new_nr_entries].addr = change_point[chg_idx]->addr;
>>  				new_entries[new_nr_entries].type = current_type;
>> +				new_entries[new_nr_entries].crypto_capable = current_crypto;
>> +
>>  				last_addr = change_point[chg_idx]->addr;
>>  			}
>>  			last_type = current_type;
>> +			last_crypto = current_crypto;
>>  		}
>>  	}
>>
>> @@ -459,14 +471,20 @@ static int __init append_e820_table(struct
>> boot_e820_entry *entries, u32 nr_entr
>>  	return __append_e820_table(entries, nr_entries);
>>  }
>>
>> +/*
>> + * Update a memory range.
>> + *
>> + * If old_type and new_type are the same then ignore the types and
>> + * just change crypto_capable.
>> + */
>>  static u64 __init
>> -__e820__range_update(struct e820_table *table, u64 start, u64 size, enum
>> e820_type old_type, enum e820_type new_type)
>> +__e820__range_update(struct e820_table *table, u64 start, u64 size, enum
>> e820_type old_type, enum e820_type new_type, u8 crypto_capable)
>
> Same api comment here.
>
>>  {
>>  	u64 end;
>>  	unsigned int i;
>>  	u64 real_updated_size = 0;
>>
>> -	BUG_ON(old_type == new_type);
>
> No more bug?
>

No,

>> +	bool update_crypto = new_type == old_type;
>
> if statement?  This looks really odd and is easy to overlook.
>

because now I'm using those cases where new_type is equal to old_type
to change crypto_capable, because I don't care about the type if I
want to change crypto_capable. This is what I'm checking here, to
ignore the types inside the for and just leave them as they are.

I'm not really happy with this change, maybe a new function will be
better, although it will be pretty similar to this one and its
implementation is quite fragile, for checking the cases and
adding/removing the regions, so I decided to just have only one ugly
fragile function, instead of two fragile functions.

I can do the new function if you prefer.

>>
>>  	if (size > (ULLONG_MAX - start))
>>  		size = ULLONG_MAX - start;
>> @@ -476,6 +494,8 @@ __e820__range_update(struct e820_table *table, u64
>> start, u64 size, enum e820_ty
>>  	e820_print_type(old_type);
>>  	pr_cont(" ==> ");
>>  	e820_print_type(new_type);
>> +	if (crypto_capable)
>> +		pr_cont("; crypto-capable");
>>  	pr_cont("\n");
>>
>>  	for (i = 0; i < table->nr_entries; i++) {
>> @@ -483,22 +503,27 @@ __e820__range_update(struct e820_table *table, u64
>> start, u64 size, enum e820_ty
>>  		u64 final_start, final_end;
>>  		u64 entry_end;
>>
>> -		if (entry->type != old_type)
>> +		if (entry->type != old_type && !update_crypto)
>>  			continue;
>>
>> +		if (update_crypto)
>> +			new_type = entry->type;
>> +
>>  		entry_end = entry->addr + entry->size;
>>
>>  		/* Completely covered by new range? */
>>  		if (entry->addr >= start && entry_end <= end) {
>>  			entry->type = new_type;
>> +			entry->crypto_capable = crypto_capable;
>>  			real_updated_size += entry->size;
>>  			continue;
>>  		}
>>
>>  		/* New range is completely covered? */
>>  		if (entry->addr < start && entry_end > end) {
>> -			__e820__range_add(table, start, size, new_type);
>> -			__e820__range_add(table, end, entry_end - end, entry->type);
>> +			__e820__range_add(table, start, size, new_type, crypto_capable);
>> +			__e820__range_add(table, end, entry_end - end,
>> +					  entry->type, entry->crypto_capable);
>>  			entry->size = start - entry->addr;
>>  			real_updated_size += size;
>>  			continue;
>> @@ -510,7 +535,8 @@ __e820__range_update(struct e820_table *table, u64
>> start, u64 size, enum e820_ty
>>  		if (final_start >= final_end)
>>  			continue;
>>
>> -		__e820__range_add(table, final_start, final_end - final_start,
>> new_type);
>> +		__e820__range_add(table, final_start, final_end - final_start,
>> +				  new_type, crypto_capable);
>>
>>  		real_updated_size += final_end - final_start;
>>
>> @@ -527,14 +553,19 @@ __e820__range_update(struct e820_table *table, u64
>> start, u64 size, enum e820_ty
>>  	return real_updated_size;
>>  }
>>
>> +u64 __init e820__range_mark_as_crypto_capable(u64 start, u64 size)
>> +{
>> +	return __e820__range_update(e820_table, start, size, 0, 0, true);
>> +}
>> +
>>  u64 __init e820__range_update(u64 start, u64 size, enum e820_type
>> old_type, enum e820_type new_type)
>>  {
>> -	return __e820__range_update(e820_table, start, size, old_type,
>> new_type);
>> +	return __e820__range_update(e820_table, start, size, old_type, new_type,
>> false);
>
> See, what does "false" here mean?  You have to now go look that up.
>
> thanks,
>
> greg k-h
>
