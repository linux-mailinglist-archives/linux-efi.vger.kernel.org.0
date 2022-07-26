Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DAF58155C
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiGZOd1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbiGZOdZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 10:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E5292B636
        for <linux-efi@vger.kernel.org>; Tue, 26 Jul 2022 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658846003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LiBGC1b1QxEEeViky5NbRgM9y6bFr53DkHc/XfdWgQ8=;
        b=FYx2jhy9iKEIuDnvr+JYStiyj4yS2k4IvusxLZBJMpTgx4GV18SjTAUVtQWGTJ4JClja/y
        VidAYEhtVCcXiQMpc7N23P7nFQlzlS+3QtBsS8IyFUWG3fQNJbj+wR+kTX5BqrD3h8aSyW
        VWdEm7IqA4dIO+7+cZ99lUgHJCxvMUM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-ztf4gLytPR-U802Nx9DYkQ-1; Tue, 26 Jul 2022 10:33:22 -0400
X-MC-Unique: ztf4gLytPR-U802Nx9DYkQ-1
Received: by mail-wm1-f71.google.com with SMTP id n30-20020a05600c501e00b003a3264465ebso738859wmr.1
        for <linux-efi@vger.kernel.org>; Tue, 26 Jul 2022 07:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LiBGC1b1QxEEeViky5NbRgM9y6bFr53DkHc/XfdWgQ8=;
        b=etMH1Fzt9iM9ZY16CM8rWLDek8y6p2kwZVmBPAAQUDysdSqR7mx45d3a3DUbuyUq/7
         GBOiTGvemQTblBBDrfLLVedAvDrD5L0m1PYA1CONTIUyUaPAn3tOq4fJ9QVuNd1xfBh6
         NnHi8a64NJGayB08K2hWl5HnRR2UO+HPWxl0zbJcMm8AgBVWWnzr7FfY9r3pji9eGNBN
         I+/Kt4mLjFqghiSgitRkPIMu0kNprWmazbHt+ceRqlaXJiPNeQ2PwERSCNmBZanaS1dR
         DDhCjA8yYEIifsEgnxWqS9Psfx/oUirdyNEECNwkuCskNX+ppl1NoYBJgK87NiK4uX+2
         zdug==
X-Gm-Message-State: AJIora9TGMKPUfHD6cBOcrIAxyLHv6eolcpuIw5E46czXkBJAgW6RZp+
        iqy5fpithg/h8iqc47/ewDt9m2wLP699LM/PhZI6JvTjaHAXMnxy9A1hq9pWo9tnzyX7CUCcuF8
        AXOCTTeq+pLjFn6JUrU67
X-Received: by 2002:a05:600c:a18e:b0:3a3:10ef:672a with SMTP id id14-20020a05600ca18e00b003a310ef672amr24280338wmb.14.1658846000929;
        Tue, 26 Jul 2022 07:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t7oH12XlY/+hi4IxsJEdLzeaHKs9wMX+Cz8IWG78oiZGfbXTFAAmw67L/BOMUCstC0heXYBA==
X-Received: by 2002:a05:600c:a18e:b0:3a3:10ef:672a with SMTP id id14-20020a05600ca18e00b003a310ef672amr24280313wmb.14.1658846000544;
        Tue, 26 Jul 2022 07:33:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:fe00:8ba4:5871:abc3:8a75? (p200300cbc708fe008ba45871abc38a75.dip0.t-ipconnect.de. [2003:cb:c708:fe00:8ba4:5871:abc3:8a75])
        by smtp.gmail.com with ESMTPSA id az14-20020adfe18e000000b0021e529efa60sm9253089wrb.1.2022.07.26.07.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 07:33:20 -0700 (PDT)
Message-ID: <c87cf81d-c959-645c-ebed-635df43fdb88@redhat.com>
Date:   Tue, 26 Jul 2022 16:33:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 03/14] mm: Report unaccepted memory in meminfo
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
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-4-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220614120231.48165-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 14.06.22 14:02, Kirill A. Shutemov wrote:
> Track amount of unaccepted memory and report it in /proc/meminfo and in
> node meminfo.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  drivers/base/node.c    | 7 +++++++
>  fs/proc/meminfo.c      | 5 +++++
>  include/linux/mmzone.h | 1 +
>  mm/page_alloc.c        | 9 ++++++++-
>  mm/vmstat.c            | 1 +
>  5 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ac6376ef7a1..fc7cf4d91eb6 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -446,6 +446,9 @@ static ssize_t node_read_meminfo(struct device *dev,
>  			     "Node %d ShmemPmdMapped: %8lu kB\n"
>  			     "Node %d FileHugePages: %8lu kB\n"
>  			     "Node %d FilePmdMapped: %8lu kB\n"
> +#endif
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +			     "Node %d UnacceptedPages: %8lu kB\n"

Nit: I'd just call that "Unaccepted", as the unit is kB.

>  #endif
>  			     ,
>  			     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
> @@ -474,6 +477,10 @@ static ssize_t node_read_meminfo(struct device *dev,
>  			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
>  			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
>  			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED))
> +#endif
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +			     ,
> +			     nid, K(node_page_state(pgdat, NR_UNACCEPTED))
>  #endif
>  			    );
>  	len += hugetlb_report_node_meminfo(buf, len, nid);
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6e89f0e2fd20..796544e50365 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -153,6 +153,11 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  		    global_zone_page_state(NR_FREE_CMA_PAGES));
>  #endif
>  
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +	show_val_kb(m, "UnacceptedPages:",
> +		    global_node_page_state(NR_UNACCEPTED));

Dito.

> +#endif
> +
>  	hugetlb_report_meminfo(m);
>  
>  	arch_report_meminfo(m);
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aab70355d64f..aa08cd7eaaf5 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -212,6 +212,7 @@ enum node_stat_item {
>  	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
>  	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
>  	NR_KERNEL_STACK_KB,	/* measured in KiB */
> +	NR_UNACCEPTED,

Do we want to ifdef that as well? (and in all other cases below)

>  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
>  	NR_KERNEL_SCS_KB,	/* measured in KiB */
>  #endif
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 279c2746aaa8..6316d695a567 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1012,6 +1012,7 @@ static void accept_page(struct page *page, unsigned int order)
>  
>  	accept_memory(start, start + (PAGE_SIZE << order));
>  	__ClearPageUnaccepted(page);
> +	mod_node_page_state(page_pgdat(page), NR_UNACCEPTED, -(1 << order));
>  
>  	/* Assert that there is no PageUnaccepted() on tail pages */
>  	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
> @@ -1063,6 +1064,7 @@ static inline void __free_one_page(struct page *page,
>  	struct page *buddy;
>  	bool to_tail;
>  	bool page_needs_acceptance = false;
> +	int nr_unaccepted = 0;
>  
>  	VM_BUG_ON(!zone_is_initialized(zone));
>  	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> @@ -1076,6 +1078,7 @@ static inline void __free_one_page(struct page *page,
>  
>  	if (PageUnaccepted(page)) {
>  		page_needs_acceptance = true;
> +		nr_unaccepted += 1 << order;
>  		__ClearPageUnaccepted(page);
>  	}
>  
> @@ -1117,6 +1120,7 @@ static inline void __free_one_page(struct page *page,
>  		/* Mark page unaccepted if any of merged pages were unaccepted */
>  		if (PageUnaccepted(buddy)) {
>  			page_needs_acceptance = true;
> +			nr_unaccepted += 1 << order;
>  			__ClearPageUnaccepted(buddy);
>  		}
>  
> @@ -1143,8 +1147,11 @@ static inline void __free_one_page(struct page *page,
>  	 */
>  	if (!page_needs_acceptance && (fpi_flags & FPI_UNACCEPTED_SLOWPATH))
>  		page_needs_acceptance = page_contains_unaccepted(page, order);
> -	if (page_needs_acceptance)
> +	if (page_needs_acceptance) {
>  		__SetPageUnaccepted(page);
> +		__mod_node_page_state(page_pgdat(page), NR_UNACCEPTED,
> +				    (1 << order) - nr_unaccepted);
> +	}
>  
>  	if (fpi_flags & FPI_TO_TAIL)
>  		to_tail = true;
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 373d2730fcf2..4e12d22f1e04 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1236,6 +1236,7 @@ const char * const vmstat_text[] = {
>  	"nr_foll_pin_acquired",
>  	"nr_foll_pin_released",
>  	"nr_kernel_stack",
> +	"nr_unaccepted",
>  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
>  	"nr_shadow_call_stack",
>  #endif


LGTM

-- 
Thanks,

David / dhildenb

