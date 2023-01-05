Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B818765E4BD
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jan 2023 05:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjAEEl4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 23:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAEElz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 23:41:55 -0500
X-Greylist: delayed 1520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 20:41:52 PST
Received: from a27-43.smtp-out.us-west-2.amazonses.com (a27-43.smtp-out.us-west-2.amazonses.com [54.240.27.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD632035;
        Wed,  4 Jan 2023 20:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ude52klaz7ukvnrchdbsicqdl2lnui6h; d=aaront.org; t=1672891368;
        h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:Content-Transfer-Encoding;
        bh=UaVZxhaholgYXRv1rnjX2lEzJ1yj5wIkBR8OS8N2qdE=;
        b=A2eIR5Z+ZuwTZpmlUW6p3X7w1442qVqEfxphxcVa4f8BWgZS0GCAeSQGiy9WoZnw
        mcQpE4Qu9yWk9uVQ5MWvV4mNWWf+rDULMlHvYdFTRmabXYTd4L0gws9010zGZxX5hin
        fPHaRGjS4NAX5B1Yl9o/wrTepjvNri3mgKf3dvH0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1672891368;
        h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=UaVZxhaholgYXRv1rnjX2lEzJ1yj5wIkBR8OS8N2qdE=;
        b=BsiWU+dJSpdLMh9mVDhNN5url3xV6w8RpkkvzVRJJjx8wL3BwOJJl5m7wmd1ikJZ
        zu9baddo9xz4TCGrCiVOvr5I7X9kChQH+9haBjHMpUFWMNW064IG+KHd5YgBxTUfIdJ
        EO1D4OH5rLYYcS/x4VpkzScGIMFt3SzjPuZFTMRY=
MIME-Version: 1.0
Date:   Thu, 5 Jan 2023 04:02:47 +0000
From:   Aaron Thompson <dev@aaront.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/1] mm: Always release pages to the buddy allocator in
 memblock_free_late().
In-Reply-To: <Y7XU4Wf2ohArLtvs@kernel.org>
References: <20230104074215.2621-1-dev@aaront.org>
 <010101857bbc4d26-d9683bb4-c4f0-465b-aea6-5314dbf0aa01-000000@us-west-2.amazonses.com>
 <Y7XU4Wf2ohArLtvs@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <01010185801881b4-2dd5c952-d967-414b-9dc6-7edb04436342-000000@us-west-2.amazonses.com>
X-Sender: dev@aaront.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.us-west-2.OwdjDcIoZWY+bZWuVZYzryiuW455iyNkDEZFeL97Dng=:AmazonSES
X-SES-Outgoing: 2023.01.05-54.240.27.43
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Mike,

On 2023-01-04 11:34, Mike Rapoport wrote:
> Hi,
> 
> On Wed, Jan 04, 2023 at 07:43:36AM +0000, Aaron Thompson wrote:
>> If CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, memblock_free_pages()
>> only releases pages to the buddy allocator if they are not in the
>> deferred range. This is correct for free pages (as defined by
>> for_each_free_mem_pfn_range_in_zone()) because free pages in the
>> deferred range will be initialized and released as part of the 
>> deferred
>> init process. memblock_free_pages() is called by memblock_free_late(),
>> which is used to free reserved ranges after memblock_free_all() has
>> run. memblock_free_all() initializes all pages in reserved ranges, and
> 
> To be precise, memblock_free_all() frees pages, or releases them to the
> pages allocator, rather than initializes.

As you mentioned in the comment below, whether memblock_free_all() does 
any
initializing depends on the particular deferred init situation.
memblock_free_all() does ultimately call init_reserved_page() for every 
reserved
page (via reserve_bootmem_region()), but that only actually initializes 
the page
if it's in the deferred range. In either case, all I was trying to say 
here is
that we can be certain that all reserved pages have been initialized 
after
memblock_free_all() has run, so I'll rephrase that.

>> accordingly, those pages are not touched by the deferred init
>> process. This means that currently, if the pages that
>> memblock_free_late() intends to release are in the deferred range, 
>> they
>> will never be released to the buddy allocator. They will forever be
>> reserved.
>> 
>> In addition, memblock_free_pages() calls kmsan_memblock_free_pages(),
>> which is also correct for free pages but is not correct for reserved
>> pages. KMSAN metadata for reserved pages is initialized by
>> kmsan_init_shadow(), which runs shortly before memblock_free_all().
>> 
>> For both of these reasons, memblock_free_pages() should only be called
>> for free pages, and memblock_free_late() should call 
>> __free_pages_core()
>> directly instead.
> 
> Overall looks fine to me and I couldn't spot potential issues.
> 
> I'd appreciate if you add a paragraph about the actual issue with EFI 
> boot
> you described in the cover letter to the commit message.

Sure, will do.

>> Fixes: 3a80a7fa7989 ("mm: meminit: initialise a subset of struct pages 
>> if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set")
>> Signed-off-by: Aaron Thompson <dev@aaront.org>
>> ---
>>  mm/memblock.c                     | 2 +-
>>  tools/testing/memblock/internal.h | 4 ++++
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 511d4783dcf1..56a5b6086c50 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1640,7 +1640,7 @@ void __init memblock_free_late(phys_addr_t base, 
>> phys_addr_t size)
>>  	end = PFN_DOWN(base + size);
>> 
>>  	for (; cursor < end; cursor++) {
>> -		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
>> +		__free_pages_core(pfn_to_page(cursor), 0);
> 
> Please add a comment that explains why it is safe to call
> __free_pages_core() here.
> Something like
> 
> 	/*
> 	 * Reserved pages are always initialized by the end of
> 	 * memblock_free_all() either during memmap_init() or, with deferred
> 	 * initialization if struct page in reserve_bootmem_region()
> 	 */

Will do. Thanks for the review.

>>  		totalram_pages_inc();
>>  	}
>>  }
>> diff --git a/tools/testing/memblock/internal.h 
>> b/tools/testing/memblock/internal.h
>> index fdb7f5db7308..85973e55489e 100644
>> --- a/tools/testing/memblock/internal.h
>> +++ b/tools/testing/memblock/internal.h
>> @@ -15,6 +15,10 @@ bool mirrored_kernelcore = false;
>> 
>>  struct page {};
>> 
>> +void __free_pages_core(struct page *page, unsigned int order)
>> +{
>> +}
>> +
>>  void memblock_free_pages(struct page *page, unsigned long pfn,
>>  			 unsigned int order)
>>  {
>> --
>> 2.30.2
>> 

Thanks,
-- Aaron
