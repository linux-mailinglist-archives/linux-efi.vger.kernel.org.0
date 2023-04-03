Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77A36D45FA
	for <lists+linux-efi@lfdr.de>; Mon,  3 Apr 2023 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjDCNj5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Apr 2023 09:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjDCNj4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Apr 2023 09:39:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4FC10419;
        Mon,  3 Apr 2023 06:39:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59B801FF74;
        Mon,  3 Apr 2023 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680529194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBPTbLZUOtliF78vhoUgkDjz9De2UOd6RXubIlxxUKQ=;
        b=dEh5UzE1UMQXLCM7as0vLJd3lLaAkNuz5oZm7EVWGb0tjn9HYVXCIAvDAUoukhgA70kPZB
        OtYnXIKmaVriUCxbdHKMQUsD9UIvzi3WA4Eijj1LeIMqYbgSXvSQJGY8bhxy+qCQT+CQWU
        Pm4kuCMToUXj8Y7O0X9pdm0g1sEUR78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680529194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBPTbLZUOtliF78vhoUgkDjz9De2UOd6RXubIlxxUKQ=;
        b=WbJPtdz1aelIPmv4RiiH9qqqXo9se976+n4KO/1kCFFo7ccoNETeWtvQIc9EwVWEgmI0sl
        BQ95eQ4jYpieDNDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC90C13416;
        Mon,  3 Apr 2023 13:39:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s08tMSnXKmQ4eAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 03 Apr 2023 13:39:53 +0000
Message-ID: <835dfe65-d9dd-0b16-37d4-920e97f1bca0@suse.cz>
Date:   Mon, 3 Apr 2023 15:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv9 03/14] mm/page_alloc: Fake unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <20230330114956.20342-4-kirill.shutemov@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230330114956.20342-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 3/30/23 13:49, Kirill A. Shutemov wrote:
> For testing purposes, it is useful to fake unaccepted memory in the
> system. It helps to understand unaccepted memory overhead to the page
> allocator.

Ack on being useful for testing, but the question is if we want to also
merge this patch into mainline as it is?

> The patch allows to treat memory above the specified physical memory
> address as unaccepted.
> 
> The change only fakes unaccepted memory for page allocator. Memblock is
> not affected.
> 
> It also assumes that arch-provided accept_memory() on already accepted
> memory is a nop.

I guess to be in mainline it would have to at least gracefully handle the
case of accept_memory actually not being a nop, and running on a system with
actual unaccepted memory (probably by ignoring the parameter in such case).
Then also the parameter would have to be documented.

Speaking of documented parameters, I found at least two that seem a more
generic variant of this (but I didn't look closely if that makes sense):

efi_fake_mem=   nn[KMG]@ss[KMG]:aa[,nn[KMG]@ss[KMG]:aa,..] [EFI; X86]
    Add arbitrary attribute to specific memory range by
    updating original EFI memory map.

memmap=<size>%<offset>-<oldtype>+<newtype>
    [KNL,ACPI] Convert memory within the specified region
    from <oldtype> to <newtype>. If "-<oldtype>" is left

Would any of those be usable for this usecase?

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/page_alloc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d62fcb2f28bd..509a93b7e5af 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7213,6 +7213,8 @@ static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
>  
>  static bool lazy_accept = true;
>  
> +static unsigned long fake_unaccepted_start = -1UL;
> +
>  static int __init accept_memory_parse(char *p)
>  {
>  	if (!strcmp(p, "lazy")) {
> @@ -7227,11 +7229,30 @@ static int __init accept_memory_parse(char *p)
>  }
>  early_param("accept_memory", accept_memory_parse);
>  
> +static int __init fake_unaccepted_start_parse(char *p)
> +{
> +	if (!p)
> +		return -EINVAL;
> +
> +	fake_unaccepted_start = memparse(p, &p);
> +
> +	if (*p != '\0') {
> +		fake_unaccepted_start = -1UL;
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +early_param("fake_unaccepted_start", fake_unaccepted_start_parse);
> +
>  static bool page_contains_unaccepted(struct page *page, unsigned int order)
>  {
>  	phys_addr_t start = page_to_phys(page);
>  	phys_addr_t end = start + (PAGE_SIZE << order);
>  
> +	if (start >= fake_unaccepted_start)
> +		return true;
> +
>  	return range_contains_unaccepted_memory(start, end);
>  }
>  

