Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE547B12E
	for <lists+linux-efi@lfdr.de>; Mon, 20 Dec 2021 17:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhLTQhl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Dec 2021 11:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhLTQhk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Dec 2021 11:37:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDD8C061574;
        Mon, 20 Dec 2021 08:37:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4763061236;
        Mon, 20 Dec 2021 16:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93174C36AE2;
        Mon, 20 Dec 2021 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640018259;
        bh=0y4EA3j+C2zRXjKfcZnsg71PP3YQmaK34Chj/6+oScs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRtnBe/AJPpB2U+SLEkr3UkT0ohTeC8c7uyPq3q5AXM/M81NcCTdkOUCwpvotynZw
         TTI8soTgLfMavU28gGDWLX9EXFsSiJYJQ/+UbZ729bCHHW/TjWEcAgoqEeTabptjW7
         9rKiib6u01/7qhNooFyV8F6AbrWW0kTlisfiMEU4=
Date:   Mon, 20 Dec 2021 17:37:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        rafael@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Subject: Re: [PATCH v4 3/5] x86/e820: Tag e820_entry with crypto capabilities
Message-ID: <YcCxUHSMnUJgXIJF@kroah.com>
References: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
 <20211216192222.127908-4-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216192222.127908-4-martin.fernandez@eclypsium.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 16, 2021 at 04:22:20PM -0300, Martin Fernandez wrote:
> Add a new member in e820_entry to hold whether an entry is able to do
> hardware memory encryption or not.
> 
> Add a new argument to __e820__range_add to accept this new
> crypto_capable.
> 
> Add a new argument to __e820__update_range to be able to change a
> region's crypto_capable member. Also, change its behavior a little,
> before if you wanted to update a region with its same type it was a
> BUG_ON; now if you call it with both old_type and new_type equals,
> then the function won't change the types, just crypto_capable.
> 
> Change e820__update_table to handle merging and overlap problems
> taking into account crypto_capable.
> 
> Add a function to mark a range as crypto, using __e820__range_update
> in the background. This will be called when initializing EFI.
> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  arch/x86/include/asm/e820/api.h   |  1 +
>  arch/x86/include/asm/e820/types.h |  1 +
>  arch/x86/kernel/e820.c            | 59 ++++++++++++++++++++++++-------
>  3 files changed, 49 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index e8f58ddd06d9..677dcbabcc8b 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -17,6 +17,7 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
> +extern u64  e820__range_mark_as_crypto_capable(u64 start, u64 size);
>  
>  extern void e820__print_table(char *who);
>  extern int  e820__update_table(struct e820_table *table);
> diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
> index 314f75d886d0..7b510dffd3b9 100644
> --- a/arch/x86/include/asm/e820/types.h
> +++ b/arch/x86/include/asm/e820/types.h
> @@ -56,6 +56,7 @@ struct e820_entry {
>  	u64			addr;
>  	u64			size;
>  	enum e820_type		type;
> +	u8			crypto_capable;

Why isn't this a bool?

>  } __attribute__((packed));
>  
>  /*
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index bc0657f0deed..001d64686938 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -163,7 +163,7 @@ int e820__get_entry_type(u64 start, u64 end)
>  /*
>   * Add a memory region to the kernel E820 map.
>   */
> -static void __init __e820__range_add(struct e820_table *table, u64 start, u64 size, enum e820_type type)
> +static void __init __e820__range_add(struct e820_table *table, u64 start, u64 size, enum e820_type type, u8 crypto_capable)

Horrid api change, but it's internal to this file so oh well :(

Hint, don't add flags to functions like this, it forces you to have to
always remember what those flags are when you read the code.  Right now
you stuck "0" and "1" in the function call, which is not instructional
at all.

Heck, why not make it an enum to have it be self-describing?  Like the
type is here.  that would make it much better and easier to understand
and maintain over time.

>  {
>  	int x = table->nr_entries;
>  
> @@ -176,12 +176,13 @@ static void __init __e820__range_add(struct e820_table *table, u64 start, u64 si
>  	table->entries[x].addr = start;
>  	table->entries[x].size = size;
>  	table->entries[x].type = type;
> +	table->entries[x].crypto_capable = crypto_capable;
>  	table->nr_entries++;
>  }
>  
>  void __init e820__range_add(u64 start, u64 size, enum e820_type type)
>  {
> -	__e820__range_add(e820_table, start, size, type);
> +	__e820__range_add(e820_table, start, size, type, 0);
>  }
>  
>  static void __init e820_print_type(enum e820_type type)
> @@ -211,6 +212,8 @@ void __init e820__print_table(char *who)
>  			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
>  
>  		e820_print_type(e820_table->entries[i].type);
> +		if (e820_table->entries[i].crypto_capable)
> +			pr_cont("; crypto-capable");
>  		pr_cont("\n");
>  	}
>  }
> @@ -327,6 +330,7 @@ int __init e820__update_table(struct e820_table *table)
>  	unsigned long long last_addr;
>  	u32 new_nr_entries, overlap_entries;
>  	u32 i, chg_idx, chg_nr;
> +	u8 current_crypto, last_crypto;
>  
>  	/* If there's only one memory region, don't bother: */
>  	if (table->nr_entries < 2)
> @@ -367,6 +371,7 @@ int __init e820__update_table(struct e820_table *table)
>  	new_nr_entries = 0;	 /* Index for creating new map entries */
>  	last_type = 0;		 /* Start with undefined memory type */
>  	last_addr = 0;		 /* Start with 0 as last starting address */
> +	last_crypto = 0;
>  
>  	/* Loop through change-points, determining effect on the new map: */
>  	for (chg_idx = 0; chg_idx < chg_nr; chg_idx++) {
> @@ -388,13 +393,17 @@ int __init e820__update_table(struct e820_table *table)
>  		 * 1=usable, 2,3,4,4+=unusable)
>  		 */
>  		current_type = 0;
> +		current_crypto = 1;
>  		for (i = 0; i < overlap_entries; i++) {
> +			current_crypto = current_crypto && overlap_list[i]->crypto_capable;

Is it a u8 or not?  You treat it as a boolean a lot :(

>  			if (overlap_list[i]->type > current_type)
>  				current_type = overlap_list[i]->type;
>  		}
>  
>  		/* Continue building up new map based on this information: */
> -		if (current_type != last_type || e820_nomerge(current_type)) {
> +		if (current_type != last_type ||
> +		    current_crypto != last_crypto ||
> +		    e820_nomerge(current_type)) {

Why check it before calling e820_nomerge()?  Is that required?

>  			if (last_type != 0)	 {
>  				new_entries[new_nr_entries].size = change_point[chg_idx]->addr - last_addr;
>  				/* Move forward only if the new size was non-zero: */
> @@ -406,9 +415,12 @@ int __init e820__update_table(struct e820_table *table)
>  			if (current_type != 0)	{
>  				new_entries[new_nr_entries].addr = change_point[chg_idx]->addr;
>  				new_entries[new_nr_entries].type = current_type;
> +				new_entries[new_nr_entries].crypto_capable = current_crypto;
> +
>  				last_addr = change_point[chg_idx]->addr;
>  			}
>  			last_type = current_type;
> +			last_crypto = current_crypto;
>  		}
>  	}
>  
> @@ -459,14 +471,20 @@ static int __init append_e820_table(struct boot_e820_entry *entries, u32 nr_entr
>  	return __append_e820_table(entries, nr_entries);
>  }
>  
> +/*
> + * Update a memory range.
> + *
> + * If old_type and new_type are the same then ignore the types and
> + * just change crypto_capable.
> + */
>  static u64 __init
> -__e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
> +__e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type, u8 crypto_capable)

Same api comment here.

>  {
>  	u64 end;
>  	unsigned int i;
>  	u64 real_updated_size = 0;
>  
> -	BUG_ON(old_type == new_type);

No more bug?

> +	bool update_crypto = new_type == old_type;

if statement?  This looks really odd and is easy to overlook.

>  
>  	if (size > (ULLONG_MAX - start))
>  		size = ULLONG_MAX - start;
> @@ -476,6 +494,8 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>  	e820_print_type(old_type);
>  	pr_cont(" ==> ");
>  	e820_print_type(new_type);
> +	if (crypto_capable)
> +		pr_cont("; crypto-capable");
>  	pr_cont("\n");
>  
>  	for (i = 0; i < table->nr_entries; i++) {
> @@ -483,22 +503,27 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>  		u64 final_start, final_end;
>  		u64 entry_end;
>  
> -		if (entry->type != old_type)
> +		if (entry->type != old_type && !update_crypto)
>  			continue;
>  
> +		if (update_crypto)
> +			new_type = entry->type;
> +
>  		entry_end = entry->addr + entry->size;
>  
>  		/* Completely covered by new range? */
>  		if (entry->addr >= start && entry_end <= end) {
>  			entry->type = new_type;
> +			entry->crypto_capable = crypto_capable;
>  			real_updated_size += entry->size;
>  			continue;
>  		}
>  
>  		/* New range is completely covered? */
>  		if (entry->addr < start && entry_end > end) {
> -			__e820__range_add(table, start, size, new_type);
> -			__e820__range_add(table, end, entry_end - end, entry->type);
> +			__e820__range_add(table, start, size, new_type, crypto_capable);
> +			__e820__range_add(table, end, entry_end - end,
> +					  entry->type, entry->crypto_capable);
>  			entry->size = start - entry->addr;
>  			real_updated_size += size;
>  			continue;
> @@ -510,7 +535,8 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>  		if (final_start >= final_end)
>  			continue;
>  
> -		__e820__range_add(table, final_start, final_end - final_start, new_type);
> +		__e820__range_add(table, final_start, final_end - final_start,
> +				  new_type, crypto_capable);
>  
>  		real_updated_size += final_end - final_start;
>  
> @@ -527,14 +553,19 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>  	return real_updated_size;
>  }
>  
> +u64 __init e820__range_mark_as_crypto_capable(u64 start, u64 size)
> +{
> +	return __e820__range_update(e820_table, start, size, 0, 0, true);
> +}
> +
>  u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
>  {
> -	return __e820__range_update(e820_table, start, size, old_type, new_type);
> +	return __e820__range_update(e820_table, start, size, old_type, new_type, false);

See, what does "false" here mean?  You have to now go look that up.

thanks,

greg k-h
