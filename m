Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601167C8B99
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJMQov (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 12:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMQou (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 12:44:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16FDB7;
        Fri, 13 Oct 2023 09:44:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64602210DD;
        Fri, 13 Oct 2023 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697215486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JqX75Zi0TdK1SmGPAZ5miYmrbIOPlJaIeQlD1x+zdUg=;
        b=UQRotTIHMoU/AK0y+quvKMhR2J/LCldJHRe/w5Np0WFVyCYulv9ffRb6tz8F6DN4p+YB0r
        sw99P4r48hO5nV9Ao3oGF50Hq93oHTVwca2vF1bxWM953FWXLsAa2kxx8KCFNT7wxyAoUi
        xinBMa7CngkECPtSLczQKzwDH1l7rO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697215486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JqX75Zi0TdK1SmGPAZ5miYmrbIOPlJaIeQlD1x+zdUg=;
        b=+WUoplQ8+AqVFXsmtjtdqC9+eroodPLlAmARY9dR3HwLQB3ll+qQ4e5W3MvsWBz/pHWlR6
        gh4V2NzRf0SOlMDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0198E1358F;
        Fri, 13 Oct 2023 16:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ey0IO/1zKWVtcgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 13 Oct 2023 16:44:45 +0000
Message-ID: <34d94c58-f5f3-48eb-5833-0ef0c90cf868@suse.cz>
Date:   Fri, 13 Oct 2023 18:44:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv14 5/9] efi: Add unaccepted memory support
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
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
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
 <20231010210518.jguawj7bscwgvszv@amd.com>
 <20231013123358.y4pcdp5fgtt4ax6g@box.shutemov.name>
 <20231013162210.bqepgz6wnh7uohqq@box>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231013162210.bqepgz6wnh7uohqq@box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
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

On 10/13/23 18:22, Kirill A. Shutemov wrote:
> On Fri, Oct 13, 2023 at 03:33:58PM +0300, Kirill A. Shutemov wrote:
>> > While testing SNP guests running today's tip/master (ef19bc9dddc3) I ran
>> > into what seems to be fairly significant lock contention due to the
>> > unaccepted_memory_lock spinlock above, which results in a constant stream
>> > of soft-lockups until the workload gets all its memory accepted/faulted
>> > in if the guest has around 16+ vCPUs.
>> > 
>> > I've included the guest dmesg traces I was seeing below.
>> > 
>> > In this case I was running a 32 vCPU guest with 200GB of memory running on
>> > a 256 thread EPYC (Milan) system, and can trigger the above situation fairly
>> > reliably by running the following workload in a freshly-booted guests:
>> > 
>> >   stress --vm 32 --vm-bytes 5G --vm-keep
>> > 
>> > Scaling up the number of stress threads and vCPUs should make it easier
>> > to reproduce.
>> > 
>> > Other than unresponsiveness/lockup messages until the memory is accepted,
>> > the guest seems to continue running fine, but for large guests where
>> > unaccepted memory is more likely to be useful, it seems like it could be
>> > an issue, especially when consider 100+ vCPU guests.
>> 
>> Okay, sorry for delay. It took time to reproduce it with TDX.
>> 
>> I will look what can be done.
> 
> Could you check if the patch below helps?
> 
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> index 853f7dc3c21d..591da3f368fa 100644
> --- a/drivers/firmware/efi/unaccepted_memory.c
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -8,6 +8,14 @@
>  /* Protects unaccepted memory bitmap */
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
> @@ -80,7 +89,25 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>  
>  	range_start = start / unit_size;
>  
> +	range.start = start;
> +	range.end = end;
> +retry:
>  	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +
> +	list_for_each_entry(entry, &accepting_list, list) {
> +		if (entry->end < start)
> +			continue;
> +		if (entry->start > end)
> +			continue;
> +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +
> +		/* Somebody else accepting the range */
> +		cpu_relax();

Should this be rather cond_resched()? I think cpu_relax() isn't enough to
prevent soft lockups.
Although IIUC hitting this should be rare, as the contending tasks will pick
different ranges via try_to_accept_memory_one(), right?

> +		goto retry;
> +	}
> +
> +	list_add(&range.list, &accepting_list);
> +
>  	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
>  				   DIV_ROUND_UP(end, unit_size)) {
>  		unsigned long phys_start, phys_end;
> @@ -89,9 +116,15 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>  		phys_start = range_start * unit_size + unaccepted->phys_base;
>  		phys_end = range_end * unit_size + unaccepted->phys_base;
>  
> +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
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

