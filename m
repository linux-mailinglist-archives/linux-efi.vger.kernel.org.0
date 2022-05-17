Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FAA52A6F6
	for <lists+linux-efi@lfdr.de>; Tue, 17 May 2022 17:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiEQPgg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 May 2022 11:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350191AbiEQPfX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 May 2022 11:35:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AE950073;
        Tue, 17 May 2022 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652801721; x=1684337721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZlxeDiZ2Ogy8lAspacIgsZZ/Yy5DPmqPGpLnxSiDxx8=;
  b=FB3Lxs8KsiDH4BjEDme3o7840QQNGTahHF3oeFq1n8yPwS9Hf4hHgSDP
   V7j0GQLafYWR1kKOHY/NC1AuiVvY7EPYfzbJj/2bsEkLDLFJ3ylO6/KKS
   u2DN2zfogtdPS2KGAjaYlGa1yVZY+1Dhc9nS36UGfErlmQjwLtysbTL/A
   B8CFyCGb5BO77zd+UsA0kfgKnn2wnzrEG8qejxCS2sRVMv2uTnjToeVKw
   00Oi01nO5w4Q16zz4fu9m3q0oEYpUVxbGJTrJtTGel+0YsZoXxUukATZZ
   ZbUfJ+UOQvaqRHh/cSNFp9ULxYKHiLX33/Y946MlHLqRYethxmZ7EE0zE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="253270621"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="253270621"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 08:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="672905589"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 May 2022 08:34:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E3A8BD7B; Tue, 17 May 2022 18:34:50 +0300 (EEST)
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 13/15] x86/tdx: Refactor try_accept_one()
Date:   Tue, 17 May 2022 18:34:42 +0300
Message-Id: <20220517153444.11195-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Rework try_accept_one() to return accepted size instead of modifying
'start' inside the helper. It makes 'start' in-only argumaent and
streamlines code on the caller side.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
---
 arch/x86/coco/tdx/tdx.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 6a62d3950619..90237700a942 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -561,18 +561,18 @@ static bool tdx_cache_flush_required(void)
 	return true;
 }
 
-static bool try_accept_one(phys_addr_t *start, unsigned long len,
-			  enum pg_level pg_level)
+static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
+				    enum pg_level pg_level)
 {
 	unsigned long accept_size = page_level_size(pg_level);
 	u64 tdcall_rcx;
 	u8 page_size;
 
-	if (!IS_ALIGNED(*start, accept_size))
-		return false;
+	if (!IS_ALIGNED(start, accept_size))
+		return 0;
 
 	if (len < accept_size)
-		return false;
+		return 0;
 
 	/*
 	 * Pass the page physical address to the TDX module to accept the
@@ -591,15 +591,14 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
 		page_size = 2;
 		break;
 	default:
-		return false;
+		return 0;
 	}
 
-	tdcall_rcx = *start | page_size;
+	tdcall_rcx = start | page_size;
 	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
-		return false;
+		return 0;
 
-	*start += accept_size;
-	return true;
+	return accept_size;
 }
 
 /*
@@ -636,21 +635,22 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	 */
 	while (start < end) {
 		unsigned long len = end - start;
+		unsigned long accept_size;
 
 		/*
 		 * Try larger accepts first. It gives chance to VMM to keep
-		 * 1G/2M SEPT entries where possible and speeds up process by
-		 * cutting number of hypercalls (if successful).
+		 * 1G/2M Secure EPT entries where possible and speeds up
+		 * process by cutting number of hypercalls (if successful).
 		 */
 
-		if (try_accept_one(&start, len, PG_LEVEL_1G))
-			continue;
-
-		if (try_accept_one(&start, len, PG_LEVEL_2M))
-			continue;
-
-		if (!try_accept_one(&start, len, PG_LEVEL_4K))
+		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
+		if (!accept_size)
+			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
+		if (!accept_size)
+			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
+		if (!accept_size)
 			return false;
+		start += accept_size;
 	}
 
 	return true;
-- 
2.35.1

