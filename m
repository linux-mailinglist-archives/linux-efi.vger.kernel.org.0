Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208096D4A35
	for <lists+linux-efi@lfdr.de>; Mon,  3 Apr 2023 16:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjDCOpE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Apr 2023 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjDCOos (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Apr 2023 10:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEBF280DA
        for <linux-efi@vger.kernel.org>; Mon,  3 Apr 2023 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680532993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eYb2XMUpR9VXDleQG1dvUeP259a87ERPUWeMJE/H5g=;
        b=Elevh4Zd3aW7+wpa9VK2FHEI4B1i1v4uVsKQt7PwTv6OJy7yI1x2xZNv8AdRoqhH23ZUfF
        T5cW4lhrpW7cj//V7iNAoLB7qpzuVT8yIbRq72P3OT4yxmMFm9jMGyTbASAzMS2y/OqQKl
        j6B9l6Il6kwO2aKB41ZI5heMDF+lc+g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-bTYQZnUnMLyNBehgL1dPzQ-1; Mon, 03 Apr 2023 10:43:12 -0400
X-MC-Unique: bTYQZnUnMLyNBehgL1dPzQ-1
Received: by mail-wm1-f70.google.com with SMTP id m7-20020a05600c4f4700b003ee7e120bdfso14659019wmq.6
        for <linux-efi@vger.kernel.org>; Mon, 03 Apr 2023 07:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680532991;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eYb2XMUpR9VXDleQG1dvUeP259a87ERPUWeMJE/H5g=;
        b=bGaBw78SKAjqF7zZFHTk+36vG3FBVGz5o6PlhH98MfoGgClsnBFdBYjGHnu0apGfS+
         ckOb7I2kOxlLLWjpq8RvCQpzSzvmhgq69BzV6CQg8PKLPf6xnhJszturfGC7Id9f1oho
         MW/ir8r5/jCPurxmhh5B4yGbytUJuk+mgYM1bg8nFCnpSpilaxUrWVeGOPQMtniK/20p
         ZWVoct36fAGRzfSGSexNd5k80qYUHxOlI0gekUhzZ93srbFE1n81Wy+8F+AD1vAxD2EZ
         ESyeSgbl77D340f91I8niecw3jyL+Z5TRdY7b8zkAbMiL29wSrZnJD+Bik7sY6b337V3
         YrkA==
X-Gm-Message-State: AAQBX9fBGsRIaRb0xJ2KFvpiCW5NAB19HxVSHaSlGbKlVYkrQen1xEKK
        CE5JcRHtlZdsKzd7qBtOs1e8LxamV7FC+mLdSWCWlLHjtdweCCSfZHTP3nFwHXzoqgISr9jPkp7
        ph2Mrjx+gQJeNfbnE5+7S
X-Received: by 2002:adf:fb0d:0:b0:2e5:17a4:7d65 with SMTP id c13-20020adffb0d000000b002e517a47d65mr9852991wrr.39.1680532991155;
        Mon, 03 Apr 2023 07:43:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y08+lpc/XjAnUg5I1OrKi5tNhWj0ZeUnj6X2UCuKEr2raMcQhFTlwQjTgwu1vHm8iFtim9pA==
X-Received: by 2002:adf:fb0d:0:b0:2e5:17a4:7d65 with SMTP id c13-20020adffb0d000000b002e517a47d65mr9852963wrr.39.1680532990772;
        Mon, 03 Apr 2023 07:43:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id i17-20020a5d5591000000b002eaac3a9beesm169318wrv.8.2023.04.03.07.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:43:10 -0700 (PDT)
Message-ID: <053a9ccd-4205-7a76-70c3-c256bd995a1f@redhat.com>
Date:   Mon, 3 Apr 2023 16:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <20230330114956.20342-4-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330114956.20342-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 30.03.23 13:49, Kirill A. Shutemov wrote:
> For testing purposes, it is useful to fake unaccepted memory in the
> system. It helps to understand unaccepted memory overhead to the page
> allocator.
> 
> The patch allows to treat memory above the specified physical memory
> address as unaccepted.
> 
> The change only fakes unaccepted memory for page allocator. Memblock is
> not affected.
> 
> It also assumes that arch-provided accept_memory() on already accepted
> memory is a nop.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/page_alloc.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d62fcb2f28bd..509a93b7e5af 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7213,6 +7213,8 @@ static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
>   
>   static bool lazy_accept = true;
>   
> +static unsigned long fake_unaccepted_start = -1UL;
> +
>   static int __init accept_memory_parse(char *p)
>   {
>   	if (!strcmp(p, "lazy")) {
> @@ -7227,11 +7229,30 @@ static int __init accept_memory_parse(char *p)
>   }
>   early_param("accept_memory", accept_memory_parse);
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
>   static bool page_contains_unaccepted(struct page *page, unsigned int order)
>   {
>   	phys_addr_t start = page_to_phys(page);
>   	phys_addr_t end = start + (PAGE_SIZE << order);
>   
> +	if (start >= fake_unaccepted_start)
> +		return true;
> +
>   	return range_contains_unaccepted_memory(start, end);
>   }
>   

The "unpleasant" thing about this is, that page_contains_unaccepted() 
could not be used for sanity checks because the result is static.

For example, something like

if (page_contains_unaccepted(page, 0))
	accept_memory(page, 0);
BUG_ON(!page_contains_unaccepted(page, 0));

Would work on real hardware, however, not for the fake variant.

-- 
Thanks,

David / dhildenb

