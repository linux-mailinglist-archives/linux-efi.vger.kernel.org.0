Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3936449BC7
	for <lists+linux-efi@lfdr.de>; Mon,  8 Nov 2021 19:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhKHSna (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Nov 2021 13:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbhKHSnO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Nov 2021 13:43:14 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3426CC061714
        for <linux-efi@vger.kernel.org>; Mon,  8 Nov 2021 10:40:29 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id g17so21882369ybe.13
        for <linux-efi@vger.kernel.org>; Mon, 08 Nov 2021 10:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=53iMcNjjE0aZUmKJGrEzcDSavWlVVXF6QsjPkzF9vD8=;
        b=J4g7ZkyqtN59N47kUpoT8b23ZJOeBM7IBqsCd/oH0tl6z8WTRnMWKT7XGFJi/08H9l
         /yaBN+VS99J694dfhCl5PFHdlgpinNMUVmJYKy/c26Ns29lYI7JMzdoLgBeiu1F0beNd
         kMPRrUR1Tx0FeRrJgst+9D/aq96neqq9Z3CZXFtggKlJ2eOKKMVnMB1IV4JYV1zOmqBg
         w51s3ukpm0l9JD4SwlqdxxqT2MTHIDBx7jAFI569CUR60ei0OfPNm360cG1w6CLbhgSF
         IjM0QhhRT98FHgza0WhOMV97som5bHB4ejeK1lQtcwMD6LNvrkt6Grf280BQFz3j/uRC
         Jdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=53iMcNjjE0aZUmKJGrEzcDSavWlVVXF6QsjPkzF9vD8=;
        b=5mXRyw4qQkFqvq9neLGrssEuntjM47o8ZuZPT0kYE5yPSSFQNmRwW7+j8DpXO9Sstb
         +aVE3f5MHP4DwU4+9TsSP9/9BOG089jqO25ADl+tf+QteVDBlJqVjt8HjjZwktqK2JoY
         Ct4I72qMgJAp5UN2IOksfaC35IJE5tek94GoC17Zyi5kDlrp6duziaxLH0NuyAl6WAPt
         rfVuJISKr/Wb/79QtXf3A4h3Q5Ru1pM2rfr5jLbg/oKm+2R6X2Qb0KLmKV1bPNVukJM8
         weW2wdScCRITfwup5H2xhJLmoxYsrwHVuXlXuXKEnqKyWnETc57E3m3OM0jsuhaqpnlv
         T1Rg==
X-Gm-Message-State: AOAM530CB28bFDIUR1QX2WSv+sZPVnoiSDEj0EAALxAYptiB3LyUThIL
        eTzmA3f/6yB7cYh0G6XgM8vhkZz6zV478efuPEjDFQ==
X-Google-Smtp-Source: ABdhPJxQrIjcHk7OnO3j3PBJIUz2m3KlL/5FEkNB/SRrRp6Z3e0EX/IPz9mdcfZ1EBVUd7cxa8pFONjh+izH5Ei0mBA=
X-Received: by 2002:a05:6902:110e:: with SMTP id o14mr1570209ybu.161.1636396828330;
 Mon, 08 Nov 2021 10:40:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:1f09:0:0:0:0:0 with HTTP; Mon, 8 Nov 2021 10:40:27 -0800 (PST)
In-Reply-To: <37cdad39-7616-df3d-3c8d-84d26a59b62a@intel.com>
References: <20211105212724.2640-1-martin.fernandez@eclypsium.com>
 <20211105212724.2640-4-martin.fernandez@eclypsium.com> <37cdad39-7616-df3d-3c8d-84d26a59b62a@intel.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Mon, 8 Nov 2021 15:40:27 -0300
Message-ID: <CAKgze5ZnLo7eXeRQ0kp-TABtegH-2n_W2LA69Nm5mhqT9s5+Dw@mail.gmail.com>
Subject: Re: [PATCH 3/5] Extend e820_table to hold information about memory encryption
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alison.schofield@intel.com, alex@eclypsium.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/5/21, Dave Hansen <dave.hansen@intel.com> wrote:
> On 11/5/21 2:27 PM, Martin Fernandez wrote:
>> +void __init e820__mark_regions_as_crypto_capable(u64 start, u64 size)
>> +{
>> +	int i;
>> +	u64 end = start + size;
>> +
>> +	for (i = 0; i < e820_table->nr_entries; i++) {
>> +		struct e820_entry *const entry = &e820_table->entries[i];
>> +
>> +		if (entry->addr >= start && entry->addr + entry->size <= end)
>> +			entry->crypto_capable = true;
>> +	}
>> +}
>
> Looking at this in isolation, this is really tricky.  I have no idea
> what this is _supposed_ to or expected to be doing.  It also makes me
> wonder what happens when start/size don't line up exactly on an e820 entry.

Do you think it's better to just add new entries, just as they are in
the EFI memmap and then let e820__update_table handle them?

Although, as it is it's faster, the other way would be clearer in the
code (since efi_mark_e820_regions_as_crypto_capable in part 4/5 isn't
also the nicest of the functions and with this change it would be very
straightforward), but it would require one e820__update_table. Also,
it would more accurate, since if you call this with a start and size
that doesn't cover at least one e820_entry then it will do nothing.

>>  static void __init e820_print_type(enum e820_type type)
>>  {
>>  	switch (type) {
>> @@ -211,6 +225,8 @@ void __init e820__print_table(char *who)
>>  			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
>>
>>  		e820_print_type(e820_table->entries[i].type);
>> +		pr_cont("%s",
>> +			e820_table->entries[i].crypto_capable ? "; crypto-capable" : "");
>
> Am I missing something or should this just be:
>
> 	if (e820_table->entries[i].crypto_capable)
> 		pr_cont("; crypto-capable");
>
> In general, I find code that retreats to the ternary form is almost
> always doing something nasty.

You're right, I'll fix that.

>> @@ -327,6 +343,8 @@ int __init e820__update_table(struct e820_table
>> *table)
>>  	unsigned long long last_addr;
>>  	u32 new_nr_entries, overlap_entries;
>>  	u32 i, chg_idx, chg_nr;
>> +	bool current_crypto;
>> +	bool last_crypto = false;
>>
>>  	/* If there's only one memory region, don't bother: */
>>  	if (table->nr_entries < 2)
>> @@ -388,13 +406,17 @@ int __init e820__update_table(struct e820_table
>> *table)
>>  		 * 1=usable, 2,3,4,4+=unusable)
>>  		 */
>>  		current_type = 0;
>> +		current_crypto = false;
>>  		for (i = 0; i < overlap_entries; i++) {
>> +			current_crypto = current_crypto || overlap_list[i]->crypto_capable;
>
> No comment, eh?
>
> This seems backwards to me.  If there are overlapping region and only
> one is crypto-capable, shouldn't the whole thing become non-crypto-capable?

The reason for that is that right now, if a region is mark as
crypto_capable is because EFI memmap says so, and again, right now
that's the only source to fill the crypto_capable value, so I have to
"believe" it. Now that I think about it, yes I should have a least put
a comment on it.

>>  		/* Continue building up new map based on this information: */
>> -		if (current_type != last_type || e820_nomerge(current_type)) {
>> +		if (current_type != last_type ||
>> +		    current_crypto != last_crypto ||
>> +		    e820_nomerge(current_type)) {
>>  			if (last_type != 0)	 {
>>  				new_entries[new_nr_entries].size = change_point[chg_idx]->addr -
>> last_addr;
>>  				/* Move forward only if the new size was non-zero: */
>> @@ -406,6 +428,9 @@ int __init e820__update_table(struct e820_table
>> *table)
>>  			if (current_type != 0)	{
>>  				new_entries[new_nr_entries].addr = change_point[chg_idx]->addr;
>>  				new_entries[new_nr_entries].type = current_type;
>> +				new_entries[new_nr_entries].crypto_capable = current_crypto;
>> +
>> +				last_crypto = current_crypto;
>>  				last_addr = change_point[chg_idx]->addr;
>>  			}
>>  			last_type = current_type;
>
> The "current_crypto != last_crypto" checks seem to go with the
> current_type/last_type checks.  I'm naively surprised that the
> last_crypto assignment wasn't paired with the last_type assignment.
>
> I kinda get the impression this was just quickly hacked in here.  It
> seems like "crypto" and "type" are very closely related in how they are
> being handled.  It's a shame they're not being managed in a common way.

Yes, "crypto" and "type" seems really close, but to be honest, this
function has a very weird flow, or something that I couldn't
completely understand. After a while thinking about it I came up with
that.

Again, this function is a pain, but I'll dedicate it some more time to
see if I can come up with something better.

>> @@ -1321,7 +1346,10 @@ void __init e820__memblock_setup(void)
>>  		if (entry->type != E820_TYPE_RAM && entry->type !=
>> E820_TYPE_RESERVED_KERN)
>>  			continue;
>>
>> -		memblock_add(entry->addr, entry->size);
>> +		if (entry->crypto_capable)
>> +			memblock_add_crypto_capable(entry->addr, entry->size);
>> +		else
>> +			memblock_add(entry->addr, entry->size);
>
> Having a different memblock_add_foo() doesn't seem to be the way this is
> done.  See:
>
> 	memblock_mark_hotplug();
> or
> 	memblock_mark_mirror();
>
> Shouldn't this be: memblock_mark_crypto()

I thought it would be good to add it and mark it all together, but I
can add it and then mark it, no problem.

> By the way, how was this tested?

This was tested on my laptop that doesn't have the EFI attribute, so I
faked it, bypassing the check for this attribute in
efi_mark_e820_regions_as_crypto_capable (patch 4/5).
