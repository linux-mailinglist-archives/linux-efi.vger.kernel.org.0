Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74767CA62A
	for <lists+linux-efi@lfdr.de>; Mon, 16 Oct 2023 12:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjJPK6j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Oct 2023 06:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJPK6i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Oct 2023 06:58:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A945E95;
        Mon, 16 Oct 2023 03:58:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 19EF61FEB7;
        Mon, 16 Oct 2023 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697453915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EpJxWQRVZ9dNT5iVhQyoKAbtpxpQp9FHaAZXCYmJKV8=;
        b=x9uHVukIBNTBXEqpoJeva/xL5zwbE7Gy6hp+IzuqxoJtD7e+mq3coAVRePtH9VUWF3me3R
        nCYH53coKBCHXh3mgcqx2hgpBVCZZsDWXfIxePFThTifez4OYCd4xvJF8/lSjd/mdI1KAB
        VW5ZoFZ+cy0Is0Wd5uHxgDmcYvyT90s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697453915;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EpJxWQRVZ9dNT5iVhQyoKAbtpxpQp9FHaAZXCYmJKV8=;
        b=P4KkO+VBuwRuNwx0Ba+M0yDl8ETGkwF0EzWOMVMisK0sDMy70Tz4Z+M094ZLvOsjLDGUU3
        pouvFY/fCpA+nGBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D6D7138EF;
        Mon, 16 Oct 2023 10:58:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lfu0IVoXLWXvZgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 16 Oct 2023 10:58:34 +0000
Message-ID: <088593ea-e001-fa87-909f-a196b1373ca4@suse.cz>
Date:   Mon, 16 Oct 2023 12:58:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
References: <20231014204040.28765-1-kirill.shutemov@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231014204040.28765-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.10
X-Spamd-Result: default: False [-1.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         NEURAL_SPAM_LONG(3.00)[1.000];
         RCPT_COUNT_TWELVE(0.00)[33];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/14/23 22:40, Kirill A. Shutemov wrote:
> Michael reported soft lockups on a system that has unaccepted memory.
> This occurs when a user attempts to allocate and accept memory on
> multiple CPUs simultaneously.
> 
> The root cause of the issue is that memory acceptance is serialized with
> a spinlock, allowing only one CPU to accept memory at a time. The other
> CPUs spin and wait for their turn, leading to starvation and soft lockup
> reports.
> 
> To address this, the code has been modified to release the spinlock
> while accepting memory. This allows for parallel memory acceptance on
> multiple CPUs.
> 
> A newly introduced "accepting_list" keeps track of which memory is
> currently being accepted. This is necessary to prevent parallel
> acceptance of the same memory block. If a collision occurs, the lock is
> released and the process is retried.
> 
> Such collisions should rarely occur. The main path for memory acceptance
> is the page allocator, which accepts memory in MAX_ORDER chunks. As long
> as MAX_ORDER is equal to or larger than the unit_size, collisions will
> never occur because the caller fully owns the memory block being
> accepted.
> 
> Aside from the page allocator, only memblock and deferered_free_range()
> accept memory, but this only happens during boot.
> 
> The code has been tested with unit_size == 128MiB to trigger collisions
> and validate the retry codepath.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Michael Roth <michael.roth@amd.com
> Fixes: 2053bc57f367 ("efi: Add unaccepted memory support")
> Cc: <stable@kernel.org>
> ---
>  drivers/firmware/efi/unaccepted_memory.c | 55 ++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> index 853f7dc3c21d..8af0306c8e5c 100644
> --- a/drivers/firmware/efi/unaccepted_memory.c
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -5,9 +5,17 @@
>  #include <linux/spinlock.h>
>  #include <asm/unaccepted_memory.h>
>  
> -/* Protects unaccepted memory bitmap */
> +/* Protects unaccepted memory bitmap and accepting_list */
>  static DEFINE_SPINLOCK(unaccepted_memory_lock);
>  
> +struct accept_range {
> +	struct list_head list;
> +	unsigned long start;
> +	unsigned long end;
> +};
> +
> +static LIST_HEAD(accepting_list);
> +
>  /*
>   * accept_memory() -- Consult bitmap and accept the memory if needed.
>   *
> @@ -24,6 +32,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>  {
>  	struct efi_unaccepted_memory *unaccepted;
>  	unsigned long range_start, range_end;
> +	struct accept_range range, *entry;
>  	unsigned long flags;
>  	u64 unit_size;
>  
> @@ -78,20 +87,58 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>  	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
>  		end = unaccepted->size * unit_size * BITS_PER_BYTE;
>  
> -	range_start = start / unit_size;
> -
> +	range.start = start / unit_size;
> +	range.end = DIV_ROUND_UP(end, unit_size);
> +retry:
>  	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +
> +	/*
> +	 * Check if anybody works on accepting the same range of the memory.
> +	 *
> +	 * The check with unit_size granularity. It is crucial to catch all

"The check is done ..." ?

> +	 * accept requests to the same unit_size block, even if they don't
> +	 * overlap on physical address level.
> +	 */
> +	list_for_each_entry(entry, &accepting_list, list) {
> +		if (entry->end < range.start)
> +			continue;
> +		if (entry->start >= range.end)
> +			continue;

Hmm we really don't have a macro for ranges_intersect()? Given how easy is
to make a mistake. I found only zone_intersects().

> +
> +		/*
> +		 * Somebody else accepting the range. Or at least part of it.
> +		 *
> +		 * Drop the lock and retry until it is complete.
> +		 */
> +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +		cond_resched();
> +		goto retry;
> +	}
> +
> +	/*
> +	 * Register that the range is about to be accepted.
> +	 * Make sure nobody else will accept it.
> +	 */
> +	list_add(&range.list, &accepting_list);
> +
> +	range_start = range.start;
>  	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
> -				   DIV_ROUND_UP(end, unit_size)) {
> +				   range.end) {
>  		unsigned long phys_start, phys_end;
>  		unsigned long len = range_end - range_start;
>  
>  		phys_start = range_start * unit_size + unaccepted->phys_base;
>  		phys_end = range_end * unit_size + unaccepted->phys_base;
>  
> +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);

Hm so this is bad, AFAICS. We enable IRQs, then an IRQ can come and try to
accept in the same unit_size block, so it will keep the retrying by the goto
above and itself have irqs disabled so the cond_resched() will never let us
finish?

> +
>  		arch_accept_memory(phys_start, phys_end);
> +
> +		spin_lock_irqsave(&unaccepted_memory_lock, flags);
>  		bitmap_clear(unaccepted->bitmap, range_start, len);
>  	}
> +
> +	list_del(&range.list);
>  	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>  }
>  

