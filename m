Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA1F6D03DC
	for <lists+linux-efi@lfdr.de>; Thu, 30 Mar 2023 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjC3Luk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Mar 2023 07:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjC3Lu2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Mar 2023 07:50:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB3155AF;
        Thu, 30 Mar 2023 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680177026; x=1711713026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4/nsBozr9Yxm1Svh3lW2TBRBUO1KN1TDzMtK6uriOCA=;
  b=AzJPoGXX2ZepZVsKvtRD644FyKJ8pUBPSBlhjelq4SlrFY0AupvJIpdK
   U/qUBk6INCSzYt4LvSobyzVsQ8MFz5M39rODPHFMPyDdTLTI6geQbMbIs
   GGLZL3w24VzjHCnofqLkFsL1YP0dHuwNCHv0LQwizSrBzNyy1n3sY55Mr
   UpYVa7ILqOzgUoXRIHmImpkUIKRVDphyvT7GrlvQ3wDrI2CBwq+ZQz/8n
   NaAkCYCBN97wFv7FXKVdiidqwCmNIvkq9T7K++s41MB9PWOzhRSJ4uWLa
   VzcDrE603zCiM/DStDeEu7cQTTOsZ2sf/NKIirkWJwhHZ3n5yn12zdmct
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="342756691"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="342756691"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:50:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="634856368"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="634856368"
Received: from ngreburx-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.209.91])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:50:02 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 105B310438F; Thu, 30 Mar 2023 14:50:00 +0300 (+03)
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
Subject: [PATCHv9 04/14] mm/page_alloc: Add sysfs handle to accept accept_memory
Date:   Thu, 30 Mar 2023 14:49:46 +0300
Message-Id: <20230330114956.20342-5-kirill.shutemov@linux.intel.com>
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

Write amount of memory to accept into the new sysfs handle
/sys/kernel/mm/page_alloc/accept_memory.

Write 'all' to the handle to accept all memory in the system.

It can be used to implement background memory accepting from userspace.
It is also useful for debugging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_alloc.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 509a93b7e5af..07e16e9b49c4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7343,6 +7343,45 @@ static bool __free_unaccepted(struct page *page)
 	return true;
 }
 
+static ssize_t accept_memory_store(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    const char *buf, size_t count)
+{
+	unsigned long to_accept = 0;
+	struct zone *zone;
+	char *retptr;
+
+	if (sysfs_streq(buf, "all")) {
+		to_accept = ULONG_MAX;
+	} else {
+		to_accept = memparse(buf, &retptr);
+
+		/* Get rid of trailing whitespace, including '\n' */
+		retptr = skip_spaces(retptr);
+
+		if (*retptr != 0 || to_accept == 0)
+			return -EINVAL;
+	}
+
+	for_each_populated_zone(zone) {
+		while (try_to_accept_memory_one(zone)) {
+			if (to_accept <= PAGE_SIZE << MAX_ORDER)
+				return count;
+
+			to_accept -= PAGE_SIZE << MAX_ORDER;
+		}
+	}
+
+	return count;
+}
+
+static struct kobj_attribute accept_memory_attr = __ATTR_WO(accept_memory);
+
+static struct attribute *page_alloc_attr[] = {
+	&accept_memory_attr.attr,
+	NULL
+};
+
 #else
 
 static bool page_contains_unaccepted(struct page *page, unsigned int order)
@@ -7366,3 +7405,28 @@ static bool __free_unaccepted(struct page *page)
 }
 
 #endif /* CONFIG_UNACCEPTED_MEMORY */
+
+static const struct attribute_group page_alloc_attr_group = {
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	.attrs = page_alloc_attr,
+#endif
+};
+
+static int __init page_alloc_init_sysfs(void)
+{
+	struct kobject *page_alloc_kobj;
+	int err;
+
+	page_alloc_kobj = kobject_create_and_add("page_alloc", mm_kobj);
+	if (!page_alloc_kobj)
+		return -ENOMEM;
+
+	err = sysfs_create_group(page_alloc_kobj, &page_alloc_attr_group);
+	if (err) {
+		kobject_put(page_alloc_kobj);
+		return err;
+	}
+
+	return 0;
+}
+late_initcall(page_alloc_init_sysfs);
-- 
2.39.2

