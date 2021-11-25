Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1A945D52D
	for <lists+linux-efi@lfdr.de>; Thu, 25 Nov 2021 08:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351047AbhKYHMc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Nov 2021 02:12:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1351117AbhKYHKc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Nov 2021 02:10:32 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AP433Ev002410;
        Thu, 25 Nov 2021 07:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wfaBeUS+ZOWDYaoJepvJjZ6ryO94Fm7nIx1qEaVVd6g=;
 b=j8jJURY30EXuTM1b4aF1bZXYWVSeNqF8rn+/O5n+kRuSVIxws6k9x27w34bST4gwWsVB
 H8eKSch0vKdFMbSLwNSEm8joEaZ8YYh9OR+49v+JJ8TxWZTYl37dv5b+7kTgDFTLfvr3
 5gv0td6BWO/e7hD1V/fQu9oFu3wWUDrFvOO7ewsxuXbsFw3xmKtHTdoZ5zLKo2Gx0VYn
 bpw1snAKfTxfAyreSbZsNKdzyu9A2HOoocfxjYV3r/XaMoPRIRHX5/HCxbAy/b1zYL1/
 lYHs5zbJmB8BWhWplKK2Y3xFddcEtBnkJ6+td/9qd6gKw0H2G3eqgIi5hIZhZ6DsIGFG FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3chxxgpkqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 07:06:47 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AP76HvL024467;
        Thu, 25 Nov 2021 07:06:46 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3chxxgpkqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 07:06:46 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AP6wAW8025106;
        Thu, 25 Nov 2021 07:06:45 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 3cernb8var-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 07:06:45 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AP76jXN61014452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 07:06:45 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ED632805E;
        Thu, 25 Nov 2021 07:06:45 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 995012805A;
        Thu, 25 Nov 2021 07:06:41 +0000 (GMT)
Received: from [9.65.80.116] (unknown [9.65.80.116])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Nov 2021 07:06:41 +0000 (GMT)
Message-ID: <68e2a4ef-2bc7-7fa5-e5bd-58759fa57820@linux.ibm.com>
Date:   Thu, 25 Nov 2021 09:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 3/5] x86/e820: Tag e820_entry with crypto capabilities
Content-Language: en-US
To:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alison.schofield@intel.com, Dov Murik <dovmurik@linux.ibm.com>
References: <20211124203459.4578-1-martin.fernandez@eclypsium.com>
 <20211124203459.4578-4-martin.fernandez@eclypsium.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20211124203459.4578-4-martin.fernandez@eclypsium.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EO_itpPF2HIXK3z6V_-TzPL5eqrFql3r
X-Proofpoint-ORIG-GUID: EhHzfU8U-WTvVsRvkbxzMlK7BdV2vGT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-25_04,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111250038
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 24/11/2021 22:34, Martin Fernandez wrote:
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
>  arch/x86/kernel/e820.c            | 58 +++++++++++++++++++++++++------
>  3 files changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index e8f58ddd06d9..fdfe1c37dcfc 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -17,6 +17,7 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
> +extern u64  e820__range_mark_as_crypto(u64 start, u64 size);

I suggest: e820__range_mark_as_crypto_capable
(as you do in other function and field names)

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
>  } __attribute__((packed));
>  
>  /*
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index bc0657f0deed..4581598690a9 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -163,7 +163,7 @@ int e820__get_entry_type(u64 start, u64 end)
>  /*
>   * Add a memory region to the kernel E820 map.
>   */
> -static void __init __e820__range_add(struct e820_table *table, u64 start, u64 size, enum e820_type type)
> +static void __init __e820__range_add(struct e820_table *table, u64 start, u64 size, enum e820_type type, u8 crypto_capable)
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
>  {
>  	u64 end;
>  	unsigned int i;
>  	u64 real_updated_size = 0;
>  
> -	BUG_ON(old_type == new_type);
> +	bool update_crypto = new_type == old_type;
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
> +u64 __init e820__range_mark_as_crypto(u64 start, u64 size)
> +{
> +	return __e820__range_update(e820_table, start, size, 0, 0, true);
> +}
> +
>  u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
>  {
> -	return __e820__range_update(e820_table, start, size, old_type, new_type);
> +	return __e820__range_update(e820_table, start, size, old_type, new_type, false);
>  }
>  
>  static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
>  {
> -	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
> +	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type, false);
>  }
>  
>  /* Remove a range of memory from the E820 table: */
> @@ -573,6 +604,9 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
>  		/* Is the new range completely covered? */
>  		if (entry->addr < start && entry_end > end) {
>  			e820__range_add(end, entry_end - end, entry->type);
> +			if (entry->crypto_capable)
> +				e820__range_mark_as_crypto(end, entry_end - end);
> +

Why introduce this new function call instead of adding an extra
'crypto_capable' argument to e820__range_add() ?

-Dov


>  			entry->size = start - entry->addr;
>  			real_removed_size += size;
>  			continue;
> @@ -1322,6 +1356,8 @@ void __init e820__memblock_setup(void)
>  			continue;
>  
>  		memblock_add(entry->addr, entry->size);
> +		if (entry->crypto_capable)
> +			memblock_mark_crypto_capable(entry->addr, entry->size);
>  	}
>  
>  	/* Throw away partial pages: */
> 
