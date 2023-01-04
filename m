Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B396665CDD9
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 08:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjADHuK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 02:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjADHuK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 02:50:10 -0500
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 23:50:08 PST
Received: from a27-57.smtp-out.us-west-2.amazonses.com (a27-57.smtp-out.us-west-2.amazonses.com [54.240.27.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5FC193E9;
        Tue,  3 Jan 2023 23:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ude52klaz7ukvnrchdbsicqdl2lnui6h; d=aaront.org; t=1672818216;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=drHjpr0LHopx3HmqATFGIrCQSSTGv27hzya8Ew0g6V0=;
        b=UE067h7LNAsgokFSAm1nEPCePx7WT8g/3bIOD+y6aOOanycNXzF3g6NhqJ+TdMfu
        Z0dE+5Jf9HY1gf1C0KaIXCKQQNJiZzp8ivVv76+e9lUkq1AmGCqI7XdTaeQahAvQPju
        M7QpFzzlH4xGPzUIeTqAW60oWuliPe9JERUaJptc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1672818216;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=drHjpr0LHopx3HmqATFGIrCQSSTGv27hzya8Ew0g6V0=;
        b=MPGVIN0AEOZB7CFSj53TUjTMTZg4ynawBP8navibhP2eOfgrQHo4atsokw6fpbCC
        GgW/16MjUdZi0cWtdJWDhl506FC61j4wNehQP0ThYihw+sPk3Q25fYFet7q0Jb0F8VC
        MZ9HXdWgTT4yEiRziU6w6idRY0BNZnRlVyeWdmgc=
From:   Aaron Thompson <dev@aaront.org>
To:     linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
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
        x86@kernel.org, Aaron Thompson <dev@aaront.org>
Subject: [PATCH 1/1] mm: Always release pages to the buddy allocator in memblock_free_late().
Date:   Wed, 4 Jan 2023 07:43:36 +0000
Message-ID: <010101857bbc4d26-d9683bb4-c4f0-465b-aea6-5314dbf0aa01-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230104074215.2621-1-dev@aaront.org>
References: <20230104074215.2621-1-dev@aaront.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.us-west-2.OwdjDcIoZWY+bZWuVZYzryiuW455iyNkDEZFeL97Dng=:AmazonSES
X-SES-Outgoing: 2023.01.04-54.240.27.57
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, memblock_free_pages()
only releases pages to the buddy allocator if they are not in the
deferred range. This is correct for free pages (as defined by
for_each_free_mem_pfn_range_in_zone()) because free pages in the
deferred range will be initialized and released as part of the deferred
init process. memblock_free_pages() is called by memblock_free_late(),
which is used to free reserved ranges after memblock_free_all() has
run. memblock_free_all() initializes all pages in reserved ranges, and
accordingly, those pages are not touched by the deferred init
process. This means that currently, if the pages that
memblock_free_late() intends to release are in the deferred range, they
will never be released to the buddy allocator. They will forever be
reserved.

In addition, memblock_free_pages() calls kmsan_memblock_free_pages(),
which is also correct for free pages but is not correct for reserved
pages. KMSAN metadata for reserved pages is initialized by
kmsan_init_shadow(), which runs shortly before memblock_free_all().

For both of these reasons, memblock_free_pages() should only be called
for free pages, and memblock_free_late() should call __free_pages_core()
directly instead.

Fixes: 3a80a7fa7989 ("mm: meminit: initialise a subset of struct pages if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set")
Signed-off-by: Aaron Thompson <dev@aaront.org>
---
 mm/memblock.c                     | 2 +-
 tools/testing/memblock/internal.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 511d4783dcf1..56a5b6086c50 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1640,7 +1640,7 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 	end = PFN_DOWN(base + size);
 
 	for (; cursor < end; cursor++) {
-		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
+		__free_pages_core(pfn_to_page(cursor), 0);
 		totalram_pages_inc();
 	}
 }
diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index fdb7f5db7308..85973e55489e 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -15,6 +15,10 @@ bool mirrored_kernelcore = false;
 
 struct page {};
 
+void __free_pages_core(struct page *page, unsigned int order)
+{
+}
+
 void memblock_free_pages(struct page *page, unsigned long pfn,
 			 unsigned int order)
 {
-- 
2.30.2

