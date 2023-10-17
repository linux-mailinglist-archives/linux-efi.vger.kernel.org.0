Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0597CBBDF
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 09:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjJQHDH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 03:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQHDG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 03:03:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF9C93;
        Tue, 17 Oct 2023 00:03:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9761F1FF05;
        Tue, 17 Oct 2023 07:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697526180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwwNvAigAAi7nUry5w30QAg/uXny2ATe2TlP2bVBtsQ=;
        b=zbP31VwS0TiYjeY8Qcy33MlsMVX4fY1hQup2mWLYSYcfwgJq2Y03wNeLGl1YTnAgMWW+iI
        7OmZnzaqYmpuRe1kIrnLbak+FhcQDXIwanfCLdyjnDKe+1O3iSOpPhjrQwgvmWcf462aOh
        u8uGRqlc9Phg/oyK/HtLmNtPm1F4u0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697526180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwwNvAigAAi7nUry5w30QAg/uXny2ATe2TlP2bVBtsQ=;
        b=B6kyNT5/YcPcPEaRd9LTI/a97RV6FI2s0eAGqLKpfZJC86qQLm8Qh3NAwDnw2jpQbDj1y8
        Pc++xJVStrAgipBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26DF013584;
        Tue, 17 Oct 2023 07:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hNHCCKQxLmXrHAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Oct 2023 07:03:00 +0000
Message-ID: <3ccb822e-fc46-3087-d6ad-2f754dcf218c@suse.cz>
Date:   Tue, 17 Oct 2023 09:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv2] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
To:     Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
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
 <20231016205419.c3sfriemyaiczxie@amd.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231016205419.c3sfriemyaiczxie@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -11.10
X-Spamd-Result: default: False [-11.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[33];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/16/23 22:54, Michael Roth wrote:
> On Mon, Oct 16, 2023 at 07:31:22PM +0300, Kirill A. Shutemov wrote:
>> Michael reported soft lockups on a system that has unaccepted memory.
>> This occurs when a user attempts to allocate and accept memory on
>> multiple CPUs simultaneously.
>> 
>> The root cause of the issue is that memory acceptance is serialized with
>> a spinlock, allowing only one CPU to accept memory at a time. The other
>> CPUs spin and wait for their turn, leading to starvation and soft lockup
>> reports.
>> 
>> To address this, the code has been modified to release the spinlock
>> while accepting memory. This allows for parallel memory acceptance on
>> multiple CPUs.
>> 
>> A newly introduced "accepting_list" keeps track of which memory is
>> currently being accepted. This is necessary to prevent parallel
>> acceptance of the same memory block. If a collision occurs, the lock is
>> released and the process is retried.
>> 
>> Such collisions should rarely occur. The main path for memory acceptance
>> is the page allocator, which accepts memory in MAX_ORDER chunks. As long
>> as MAX_ORDER is equal to or larger than the unit_size, collisions will
>> never occur because the caller fully owns the memory block being
>> accepted.
>> 
>> Aside from the page allocator, only memblock and deferered_free_range()
>> accept memory, but this only happens during boot.
>> 
>> The code has been tested with unit_size == 128MiB to trigger collisions
>> and validate the retry codepath.
>> 
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Reported-by: Michael Roth <michael.roth@amd.com
> 
> Tested-by: Michael Roth <michael.roth@amd.com>
> 
> This seems to improve things pretty dramatically for me. Previously I
> saw soft-lockups with 16 vCPUs and 16 processes faulting into memory,
> and now I can do 128+ vCPUs/processes.
> 
> I can still trigger soft lock-ups on occassion if the number of processes
> faulting in memory exceeds the number of vCPUs available to the guest, but
> with a 32 vCPU guest even something like this:
> 
>   stress --vm 128 --vm-bytes 2G --vm-keep --cpu 255
> 
> still seems to avoid the soft lock-up messages. So that's probably well
> into "potential future optimization" territory and this patch fixes the
> more immediate issues.

Do you mean that the guest pretends it has more cpus than the host provides
to it? I think such cpu starving configuration is prone to softlockups
already, so it wouldn't be new.

If you mean the guest has as many cpus as the host provides to it, but you
stress with many more than that number of processes, then I wonder how
softlockups would happen due to the extra processes. Since irqs are disabled
through the whole operation, the extra processes can't become scheduled, and
not being scheduled due to overloading doesn't trigger softlockups, hmm...

> Thanks!
> 
> -Mike
> 
>> Fixes: 2053bc57f367 ("efi: Add unaccepted memory support")
>> Cc: <stable@kernel.org>
>> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>> 
>>   v2:
>>    - Fix deadlock (Vlastimil);
>>    - Fix comments (Vlastimil);
>>    - s/cond_resched()/cpu_relax()/ -- cond_resched() cannot be called
>>      from atomic context;
>> 

