Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3056D4607
	for <lists+linux-efi@lfdr.de>; Mon,  3 Apr 2023 15:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjDCNng (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Apr 2023 09:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjDCNnf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Apr 2023 09:43:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F6C1FCB;
        Mon,  3 Apr 2023 06:43:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F8C521D6B;
        Mon,  3 Apr 2023 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680529413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYHhbD4MHsOrgjUSCx36DUU/r9Dt3i0n6aCrmkt21ps=;
        b=TPNVXHVEPbTqKvrgilc4LHktaPlNBN4lfeGo2MCYTNy/y54aVAoXASVa8AO/8qrCvlx7Bw
        F/OcJLhrSdpUQVK8WTVQVWKdf5LI29HrO2A6sgfXh4gc3R915vcGapkwEdFQH8HTW/BwiW
        e24kAjh90STHS47LoXPbD5uctHHdAPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680529413;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYHhbD4MHsOrgjUSCx36DUU/r9Dt3i0n6aCrmkt21ps=;
        b=hfwjJzjGEn9VdgG14TUxyRzf8C5IBckNpnpL7i3pldeLTFJSQXGLzvhQ6HML/EUgvDzmGp
        JQd6/VUwZl24apCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E7FF13416;
        Mon,  3 Apr 2023 13:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2VD0JQTYKmRyegAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 03 Apr 2023 13:43:32 +0000
Message-ID: <4c319a60-c1fb-fe43-65be-9729f0261dab@suse.cz>
Date:   Mon, 3 Apr 2023 15:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv9 04/14] mm/page_alloc: Add sysfs handle to accept
 accept_memory
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
 <20230330114956.20342-5-kirill.shutemov@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230330114956.20342-5-kirill.shutemov@linux.intel.com>
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
> Write amount of memory to accept into the new sysfs handle
> /sys/kernel/mm/page_alloc/accept_memory.
> 
> Write 'all' to the handle to accept all memory in the system.
> 
> It can be used to implement background memory accepting from userspace.
> It is also useful for debugging.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Somewhat similarly to patch 3, I'd think we don't need this patch in
mainline without clear usecases first, although it's good to post for
testing/debugging.

> ---
>  mm/page_alloc.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 509a93b7e5af..07e16e9b49c4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7343,6 +7343,45 @@ static bool __free_unaccepted(struct page *page)
>  	return true;
>  }
>  
> +static ssize_t accept_memory_store(struct kobject *kobj,
> +				    struct kobj_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	unsigned long to_accept = 0;
> +	struct zone *zone;
> +	char *retptr;
> +
> +	if (sysfs_streq(buf, "all")) {
> +		to_accept = ULONG_MAX;
> +	} else {
> +		to_accept = memparse(buf, &retptr);
> +
> +		/* Get rid of trailing whitespace, including '\n' */
> +		retptr = skip_spaces(retptr);
> +
> +		if (*retptr != 0 || to_accept == 0)
> +			return -EINVAL;
> +	}
> +
> +	for_each_populated_zone(zone) {
> +		while (try_to_accept_memory_one(zone)) {
> +			if (to_accept <= PAGE_SIZE << MAX_ORDER)
> +				return count;
> +
> +			to_accept -= PAGE_SIZE << MAX_ORDER;
> +		}
> +	}
> +
> +	return count;
> +}
> +
> +static struct kobj_attribute accept_memory_attr = __ATTR_WO(accept_memory);
> +
> +static struct attribute *page_alloc_attr[] = {
> +	&accept_memory_attr.attr,
> +	NULL
> +};
> +
>  #else
>  
>  static bool page_contains_unaccepted(struct page *page, unsigned int order)
> @@ -7366,3 +7405,28 @@ static bool __free_unaccepted(struct page *page)
>  }
>  
>  #endif /* CONFIG_UNACCEPTED_MEMORY */
> +
> +static const struct attribute_group page_alloc_attr_group = {
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +	.attrs = page_alloc_attr,
> +#endif
> +};
> +
> +static int __init page_alloc_init_sysfs(void)
> +{
> +	struct kobject *page_alloc_kobj;
> +	int err;
> +
> +	page_alloc_kobj = kobject_create_and_add("page_alloc", mm_kobj);
> +	if (!page_alloc_kobj)
> +		return -ENOMEM;
> +
> +	err = sysfs_create_group(page_alloc_kobj, &page_alloc_attr_group);
> +	if (err) {
> +		kobject_put(page_alloc_kobj);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +late_initcall(page_alloc_init_sysfs);

