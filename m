Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7A06616DB
	for <lists+linux-efi@lfdr.de>; Sun,  8 Jan 2023 17:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjAHQvL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Jan 2023 11:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjAHQvJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 8 Jan 2023 11:51:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9790E646F;
        Sun,  8 Jan 2023 08:51:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A61EB80B57;
        Sun,  8 Jan 2023 16:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8226CC433D2;
        Sun,  8 Jan 2023 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673196661;
        bh=Qe/eO9zN1m73qj2kFmidTrQ9cFufjLEB3fslciiYZs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtebHmmqrThyQ1nswpd1Xn9WtSyyL3ea2mf1WfLNjmglnsJNbDmuWJ6ko1LEgYmXC
         PZ4OT6gM2JbWCL67GifNyHhySNe7V3TQ5y8K8/YQHKflYi5khRP52dymRfHWnBcPtk
         y8YO9CM10bkbTkpZABs3BAQgkdk3nGyPPT97DsyFmfiqF4rSQfVCX1e8HCPaOcsVek
         bPbh2R+rcX57lUzndqdcxEgM1wFtyKEMjanSZcTBDNzw+cm1L4KCX6rpWr+bRXvPBJ
         uKS13hWoKkLm8qUTBCwlyNwENMJJgH4SauhiBw0fDEQZfTCVQbA589gPZAZfIOnz0O
         owXuZ6ha7SgoA==
Date:   Sun, 8 Jan 2023 18:50:45 +0200
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
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3 1/1] mm: Always release pages to the buddy allocator
 in memblock_free_late().
Message-ID: <Y7r0ZRlwvCK0xOnQ@kernel.org>
References: <20230106222222.1024-1-dev@aaront.org>
 <01010185892de53e-e379acfb-7044-4b24-b30a-e2657c1ba989-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01010185892de53e-e379acfb-7044-4b24-b30a-e2657c1ba989-000000@us-west-2.amazonses.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 06, 2023 at 10:22:44PM +0000, Aaron Thompson wrote:
> If CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, memblock_free_pages()
> only releases pages to the buddy allocator if they are not in the
> deferred range. This is correct for free pages (as defined by
> for_each_free_mem_pfn_range_in_zone()) because free pages in the
> deferred range will be initialized and released as part of the deferred
> init process. memblock_free_pages() is called by memblock_free_late(),
> which is used to free reserved ranges after memblock_free_all() has
> run. All pages in reserved ranges have been initialized at that point,
> and accordingly, those pages are not touched by the deferred init
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
> 
> One case where this issue can occur in the wild is EFI boot on
> x86_64. The x86 EFI code reserves all EFI boot services memory ranges
> via memblock_reserve() and frees them later via memblock_free_late()
> (efi_reserve_boot_services() and efi_free_boot_services(),
> respectively). If any of those ranges happens to fall within the
> deferred init range, the pages will not be released and that memory will
> be unavailable.
> 
> For example, on an Amazon EC2 t3.micro VM (1 GB) booting via EFI:
> 
> v6.2-rc2:
>   # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
>   Node 0, zone      DMA
>           spanned  4095
>           present  3999
>           managed  3840
>   Node 0, zone    DMA32
>           spanned  246652
>           present  245868
>           managed  178867
> 
> v6.2-rc2 + patch:
>   # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
>   Node 0, zone      DMA
>           spanned  4095
>           present  3999
>           managed  3840
>   Node 0, zone    DMA32
>           spanned  246652
>           present  245868
>           managed  222816   # +43,949 pages
> 
> Fixes: 3a80a7fa7989 ("mm: meminit: initialise a subset of struct pages if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set")
> Signed-off-by: Aaron Thompson <dev@aaront.org>

Applied, thanks!

> ---
>  mm/memblock.c                     | 8 +++++++-
>  tools/testing/memblock/internal.h | 4 ++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 511d4783dcf1..fc3d8fbd2060 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1640,7 +1640,13 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
>  	end = PFN_DOWN(base + size);
>  
>  	for (; cursor < end; cursor++) {
> -		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
> +		/*
> +		 * Reserved pages are always initialized by the end of
> +		 * memblock_free_all() (by memmap_init() and, if deferred
> +		 * initialization is enabled, memmap_init_reserved_pages()), so
> +		 * these pages can be released directly to the buddy allocator.
> +		 */
> +		__free_pages_core(pfn_to_page(cursor), 0);
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
