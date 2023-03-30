Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636686D03E8
	for <lists+linux-efi@lfdr.de>; Thu, 30 Mar 2023 13:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjC3LvC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Mar 2023 07:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjC3Luk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Mar 2023 07:50:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB87F8A5B;
        Thu, 30 Mar 2023 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680177031; x=1711713031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j9rCoZtseVkMxXJK20bhOG6vjoCUVN6BwYUe9lsjGyo=;
  b=jJl+1eQBQQejUCWSPKVgpFg5Jv+fiP9ujTka/dwPCrfhnD91l75vC2V8
   lYfxcAbCGvzB38MWhmthHwv9kTLOW4E3jqrYUwkMOCobSZNZOMLBvGbUC
   C3PTnNzbh+zxpI2FkevBtvAZUwgHoD/jnoo6Lh6nSqBh3LRU8O/TMQOsB
   KZB0g/YoOI8GMZMBrY7j32QTX13PuynkQPl7ZFTHRi7nY+5TnkWePUzL7
   gTeQ8IytE/wF2ZgtFjGm80AIpuo00av31vjZ84psxZaeqNmgAfpfPny0g
   tCMn6OoqodBOJ6BwqxAWgOkaHisvCpK3HJVZb4hVuzhooVm0I+WHHYzYH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="342756723"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="342756723"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="634856482"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="634856482"
Received: from ngreburx-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.209.91])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:50:02 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0612B10438E; Thu, 30 Mar 2023 14:50:00 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv9 03/14] mm/page_alloc: Fake unaccepted memory
Date:   Thu, 30 Mar 2023 14:49:45 +0300
Message-Id: <20230330114956.20342-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

For testing purposes, it is useful to fake unaccepted memory in the
system. It helps to understand unaccepted memory overhead to the page
allocator.

The patch allows to treat memory above the specified physical memory
address as unaccepted.

The change only fakes unaccepted memory for page allocator. Memblock is
not affected.

It also assumes that arch-provided accept_memory() on already accepted
memory is a nop.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_alloc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d62fcb2f28bd..509a93b7e5af 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7213,6 +7213,8 @@ static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
 
 static bool lazy_accept = true;
 
+static unsigned long fake_unaccepted_start = -1UL;
+
 static int __init accept_memory_parse(char *p)
 {
 	if (!strcmp(p, "lazy")) {
@@ -7227,11 +7229,30 @@ static int __init accept_memory_parse(char *p)
 }
 early_param("accept_memory", accept_memory_parse);
 
+static int __init fake_unaccepted_start_parse(char *p)
+{
+	if (!p)
+		return -EINVAL;
+
+	fake_unaccepted_start = memparse(p, &p);
+
+	if (*p != '\0') {
+		fake_unaccepted_start = -1UL;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+early_param("fake_unaccepted_start", fake_unaccepted_start_parse);
+
 static bool page_contains_unaccepted(struct page *page, unsigned int order)
 {
 	phys_addr_t start = page_to_phys(page);
 	phys_addr_t end = start + (PAGE_SIZE << order);
 
+	if (start >= fake_unaccepted_start)
+		return true;
+
 	return range_contains_unaccepted_memory(start, end);
 }
 
-- 
2.39.2

