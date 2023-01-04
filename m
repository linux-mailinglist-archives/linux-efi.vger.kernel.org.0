Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2382865DCDB
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 20:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbjADTfT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 14:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbjADTfS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 14:35:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A93C3AF;
        Wed,  4 Jan 2023 11:35:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10A09B818B6;
        Wed,  4 Jan 2023 19:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E819FC433EF;
        Wed,  4 Jan 2023 19:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672860914;
        bh=nBtzaERYqz1fl0bdAO7NgdUE0uQtmK9u3n6Av8noF4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZG94dIaCb9RFeCz/iBmZN53uq60BtSkPGf5lymH1RW37BYp5I/uIK7xaqHuPZzxk
         jqwDrxZN4LxxDwMTFq0fQuAdNnS3A7jk9hqsyIYl+toChVSOKl9kNqgG2THRIBqHl+
         7eOgSoGzizy8hjdYhfsuwxh0dUYV6jO0U7eOnl3rxWtoP4Dc4EsRW5UPs81KWBboul
         cfpyt/XnCV8OVbITcL7jpUfTfiB+olHJhQSuGzux3M4zWY6EmQjnxnWpnK7pk7SPl7
         K3ATjvbPmUv6A8vmO9hh6oGOeMGokKEvcPSbruIdgZPrODecyW31L8B+g4PsAnzqmC
         BUP7gcwQQzufA==
Date:   Wed, 4 Jan 2023 21:34:57 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Aaron Thompson <dev@aaront.org>
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
Message-ID: <Y7XU4Wf2ohArLtvs@kernel.org>
References: <20230104074215.2621-1-dev@aaront.org>
 <010101857bbc4d26-d9683bb4-c4f0-465b-aea6-5314dbf0aa01-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010101857bbc4d26-d9683bb4-c4f0-465b-aea6-5314dbf0aa01-000000@us-west-2.amazonses.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Wed, Jan 04, 2023 at 07:43:36AM +0000, Aaron Thompson wrote:
> If CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, memblock_free_pages()
> only releases pages to the buddy allocator if they are not in the
> deferred range. This is correct for free pages (as defined by
> for_each_free_mem_pfn_range_in_zone()) because free pages in the
> deferred range will be initialized and released as part of the deferred
> init process. memblock_free_pages() is called by memblock_free_late(),
> which is used to free reserved ranges after memblock_free_all() has
> run. memblock_free_all() initializes all pages in reserved ranges, and

To be precise, memblock_free_all() frees pages, or releases them to the
pages allocator, rather than initializes.

> accordingly, those pages are not touched by the deferred init
> process. This means that currently, if the pages that
> memblock_free_late() intends to release are in the deferred range, they
> will never be released to the buddy allocator. They will forever be
> reserved.
> 
> In addition, memblock_free_pages() calls kmsan_memblock_free_pages(),
> which is also correct for free pages but is not correct for reserved
> pages. KMSAN metadata for reserved pages is initialized by
> kmsan_init_shadow(), which runs shortly before memblock_free_all().
> 
> For both of these reasons, memblock_free_pages() should only be called
> for free pages, and memblock_free_late() should call __free_pages_core()
> directly instead.

Overall looks fine to me and I couldn't spot potential issues.

I'd appreciate if you add a paragraph about the actual issue with EFI boot
you described in the cover letter to the commit message.

> Fixes: 3a80a7fa7989 ("mm: meminit: initialise a subset of struct pages if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set")
> Signed-off-by: Aaron Thompson <dev@aaront.org>
> ---
>  mm/memblock.c                     | 2 +-
>  tools/testing/memblock/internal.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 511d4783dcf1..56a5b6086c50 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1640,7 +1640,7 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
>  	end = PFN_DOWN(base + size);
>  
>  	for (; cursor < end; cursor++) {
> -		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
> +		__free_pages_core(pfn_to_page(cursor), 0);

Please add a comment that explains why it is safe to call __free_pages_core() here.
Something like

	/*
	 * Reserved pages are always initialized by the end of
	 * memblock_free_all() either during memmap_init() or, with deferred
	 * initialization if struct page in reserve_bootmem_region()
	 */

>  		totalram_pages_inc();
>  	}
>  }
> diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
> index fdb7f5db7308..85973e55489e 100644
> --- a/tools/testing/memblock/internal.h
> +++ b/tools/testing/memblock/internal.h
> @@ -15,6 +15,10 @@ bool mirrored_kernelcore = false;
>  
>  struct page {};
>  
> +void __free_pages_core(struct page *page, unsigned int order)
> +{
> +}
> +
>  void memblock_free_pages(struct page *page, unsigned long pfn,
>  			 unsigned int order)
>  {
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
