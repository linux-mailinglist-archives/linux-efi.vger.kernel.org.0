Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B7E446B4A
	for <lists+linux-efi@lfdr.de>; Sat,  6 Nov 2021 00:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhKEXmZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Nov 2021 19:42:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:19216 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhKEXmY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Nov 2021 19:42:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="295445523"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="295445523"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:39:44 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="490503668"
Received: from luhan1-mobl2.amr.corp.intel.com (HELO [10.212.219.183]) ([10.212.219.183])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:39:43 -0700
Subject: Re: [PATCH 3/5] Extend e820_table to hold information about memory
 encryption
To:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alison.schofield@intel.com, alex@eclypsium.com
References: <20211105212724.2640-1-martin.fernandez@eclypsium.com>
 <20211105212724.2640-4-martin.fernandez@eclypsium.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <37cdad39-7616-df3d-3c8d-84d26a59b62a@intel.com>
Date:   Fri, 5 Nov 2021 16:39:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211105212724.2640-4-martin.fernandez@eclypsium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/5/21 2:27 PM, Martin Fernandez wrote:
> Add a new member in e820_entry to hold whether an entry is able to do
> hardware memory encryption or not.

That's a bit sparse for what this is doing.  It covers the first hunk at
best.

> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index e8f58ddd06d9..f3a09b6afca1 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -18,6 +18,8 @@ extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
>  
> +extern void e820__mark_regions_as_crypto_capable(u64 start, u64 size);
> +
>  extern void e820__print_table(char *who);
>  extern int  e820__update_table(struct e820_table *table);
>  extern void e820__update_table_print(void);
> diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
> index 314f75d886d0..231c9ad9a9c3 100644
> --- a/arch/x86/include/asm/e820/types.h
> +++ b/arch/x86/include/asm/e820/types.h
> @@ -56,6 +56,7 @@ struct e820_entry {
>  	u64			addr;
>  	u64			size;
>  	enum e820_type		type;
> +	bool			crypto_capable;
>  } __attribute__((packed));
>  
>  /*
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index bc0657f0deed..3e0aaa5525e0 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -176,6 +176,7 @@ static void __init __e820__range_add(struct e820_table *table, u64 start, u64 si
>  	table->entries[x].addr = start;
>  	table->entries[x].size = size;
>  	table->entries[x].type = type;
> +	table->entries[x].crypto_capable = false;
>  	table->nr_entries++;
>  }
>  
> @@ -184,6 +185,19 @@ void __init e820__range_add(u64 start, u64 size, enum e820_type type)
>  	__e820__range_add(e820_table, start, size, type);
>  }
>  
> +void __init e820__mark_regions_as_crypto_capable(u64 start, u64 size)
> +{
> +	int i;
> +	u64 end = start + size;
> +
> +	for (i = 0; i < e820_table->nr_entries; i++) {
> +		struct e820_entry *const entry = &e820_table->entries[i];
> +
> +		if (entry->addr >= start && entry->addr + entry->size <= end)
> +			entry->crypto_capable = true;
> +	}
> +}

Looking at this in isolation, this is really tricky.  I have no idea
what this is _supposed_ to or expected to be doing.  It also makes me
wonder what happens when start/size don't line up exactly on an e820 entry.

>  static void __init e820_print_type(enum e820_type type)
>  {
>  	switch (type) {
> @@ -211,6 +225,8 @@ void __init e820__print_table(char *who)
>  			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
>  
>  		e820_print_type(e820_table->entries[i].type);
> +		pr_cont("%s",
> +			e820_table->entries[i].crypto_capable ? "; crypto-capable" : "");

Am I missing something or should this just be:

	if (e820_table->entries[i].crypto_capable)
		pr_cont("; crypto-capable");

In general, I find code that retreats to the ternary form is almost
always doing something nasty.

>  		pr_cont("\n");
>  	}
>  }
> @@ -327,6 +343,8 @@ int __init e820__update_table(struct e820_table *table)
>  	unsigned long long last_addr;
>  	u32 new_nr_entries, overlap_entries;
>  	u32 i, chg_idx, chg_nr;
> +	bool current_crypto;
> +	bool last_crypto = false;
>  
>  	/* If there's only one memory region, don't bother: */
>  	if (table->nr_entries < 2)
> @@ -388,13 +406,17 @@ int __init e820__update_table(struct e820_table *table)
>  		 * 1=usable, 2,3,4,4+=unusable)
>  		 */
>  		current_type = 0;
> +		current_crypto = false;
>  		for (i = 0; i < overlap_entries; i++) {
> +			current_crypto = current_crypto || overlap_list[i]->crypto_capable;

No comment, eh?

This seems backwards to me.  If there are overlapping region and only
one is crypto-capable, shouldn't the whole thing become non-crypto-capable?

>  			if (overlap_list[i]->type > current_type)
>  				current_type = overlap_list[i]->type;
>  		}
>  
>  		/* Continue building up new map based on this information: */
> -		if (current_type != last_type || e820_nomerge(current_type)) {
> +		if (current_type != last_type ||
> +		    current_crypto != last_crypto ||
> +		    e820_nomerge(current_type)) {
>  			if (last_type != 0)	 {
>  				new_entries[new_nr_entries].size = change_point[chg_idx]->addr - last_addr;
>  				/* Move forward only if the new size was non-zero: */
> @@ -406,6 +428,9 @@ int __init e820__update_table(struct e820_table *table)
>  			if (current_type != 0)	{
>  				new_entries[new_nr_entries].addr = change_point[chg_idx]->addr;
>  				new_entries[new_nr_entries].type = current_type;
> +				new_entries[new_nr_entries].crypto_capable = current_crypto;
> +
> +				last_crypto = current_crypto;
>  				last_addr = change_point[chg_idx]->addr;
>  			}
>  			last_type = current_type;

The "current_crypto != last_crypto" checks seem to go with the
current_type/last_type checks.  I'm naively surprised that the
last_crypto assignment wasn't paired with the last_type assignment.

I kinda get the impression this was just quickly hacked in here.  It
seems like "crypto" and "type" are very closely related in how they are
being handled.  It's a shame they're not being managed in a common way.

> @@ -1321,7 +1346,10 @@ void __init e820__memblock_setup(void)
>  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
>  			continue;
>  
> -		memblock_add(entry->addr, entry->size);
> +		if (entry->crypto_capable)
> +			memblock_add_crypto_capable(entry->addr, entry->size);
> +		else
> +			memblock_add(entry->addr, entry->size);

Having a different memblock_add_foo() doesn't seem to be the way this is
done.  See:

	memblock_mark_hotplug();
or
	memblock_mark_mirror();

Shouldn't this be: memblock_mark_crypto()

By the way, how was this tested?
