Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB054AFDC
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 14:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356425AbiFNMDR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356184AbiFNMCr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 08:02:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CDC1ADA2;
        Tue, 14 Jun 2022 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655208166; x=1686744166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HHc2v/294BxJnc5ewxUspD14zKyUa2q1jtot0Cq83W4=;
  b=isjgJUoUx6PI1bN/C7XG2b3uH80/fkx4V8O2WqGQSWy/QEvT2Xe1x6GC
   zYDseFvaAsAbYuVyOeieZtW5StUXkMJAGLyMtXK7R7iCgqh4WWxLQqdeO
   srIGgloGuhc0LnYJqolmxsSnBfg48rgujctrdLonCMK5ER98ek5XwxcSL
   sISI/Z+MvK8r85vMjD2fBh6FbMDJALIG2xMzjHAbGfUS9oteH7CGRnAqU
   ltF2PAq3DXpLaEhmyZfvKKA3A9gKNa4HUO7+sEfnEh3x+vZwnpsR5dUkf
   oy76LFcG6Jg9fjlNV8zkuJkcAJwb5RUBavykmWx6RnFbG+NdV5v8ZHH3v
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258432284"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="258432284"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640332830"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2022 05:02:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 02C87A17; Tue, 14 Jun 2022 15:02:32 +0300 (EEST)
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
Subject: [PATCHv7 13/14] x86/tdx: Refactor try_accept_one()
Date:   Tue, 14 Jun 2022 15:02:30 +0300
Message-Id: <20220614120231.48165-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index b75fe670032b..b10c95307f6e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -624,18 +624,18 @@ static bool tdx_cache_flush_required(void)
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
@@ -654,15 +654,14 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
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
@@ -699,21 +698,22 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
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

