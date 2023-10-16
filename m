Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AB07CB02B
	for <lists+linux-efi@lfdr.de>; Mon, 16 Oct 2023 18:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjJPQtW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Oct 2023 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343664AbjJPQtM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Oct 2023 12:49:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A5510CC;
        Mon, 16 Oct 2023 09:41:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 017C51FEC1;
        Mon, 16 Oct 2023 16:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697474464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEefq32sBpLzJx2lGNyuxGH/nqJxW/5t5zmBcj5F6Ac=;
        b=l9WsDi6kmvu6IvcoWBYG976vX4FGtLkDTLqQzCItBRi/1ekOptrfqe2NByqKfSndcdsKl7
        5Sb3g4KaZgOC5i/oLNKXKSc5i/lc4cT9pj2/2EYNM+bTX59iiXaQKhPaGAXnV8LssgqShL
        fvpYgCyWJ4r+jtAci6jwRDmCzyKufpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697474464;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEefq32sBpLzJx2lGNyuxGH/nqJxW/5t5zmBcj5F6Ac=;
        b=IywH00l91MbjWq7du2aCvwlTuYrCsljv8qEifxJMZRpyDI36lSOQDXKGwVshOVggkqnMYs
        PvImr/h4iRaXh/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D5BF133B7;
        Mon, 16 Oct 2023 16:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AyLMGZ9nLWXEKgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 16 Oct 2023 16:41:03 +0000
Message-ID: <5d4eda63-d479-bf4a-7bfb-98a7fb8f953d@suse.cz>
Date:   Mon, 16 Oct 2023 18:41:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv2] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
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
        philip.cox@canonical.com, aarcange@redhat.com, peterx@redhat.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, Nikolay Borisov <nik.borisov@suse.com>
References: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.65
X-Spamd-Result: default: False [-3.65 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.00)[20.47%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-2.99)[-0.997];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.56)[-0.563];
         RCPT_COUNT_TWELVE(0.00)[32];
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

On 10/16/23 18:31, Kirill A. Shutemov wrote:
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
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

<snip>

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
> +		/*
> +		 * Keep interrupts disabled until the accept operation is
> +		 * complete in order to prevent deadlocks.
> +		 *
> +		 * Enabling interrupts before calling arch_accept_memory()
> +		 * creates an opportunity for an interrupt handler to request
> +		 * acceptance for the same memory. The handler will continuously
> +		 * spin with interrupts disabled, preventing other task from
> +		 * making progress with the acceptance process.
> +		 */

AFAIU on PREEMPT_RT the spin_lock_irqsave() doesn't disable interrupts, so
this does not leave them disabled. But it also shouldn't be a risk of
deadlock because the interrupt handlers are themselves preemptible. The
latency might be bad as the cpu_relax() retry loop will not cause the task
everyone might be waiting for to be prioritised, but I guess it's not a big
issue as anyone with RT requirements probably won't use unaccepted memory in
the first place, and as you mention hitting the retry loop after boot in a
normal configuration should be pretty much never.

> +		spin_unlock(&unaccepted_memory_lock);
> +
>  		arch_accept_memory(phys_start, phys_end);
> +
> +		spin_lock(&unaccepted_memory_lock);
>  		bitmap_clear(unaccepted->bitmap, range_start, len);
>  	}
> +
> +	list_del(&range.list);
>  	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>  }
>  

