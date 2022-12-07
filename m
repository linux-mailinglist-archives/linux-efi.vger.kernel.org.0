Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC542645182
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 02:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLGBun (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Dec 2022 20:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiLGBuU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Dec 2022 20:50:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57215537D7;
        Tue,  6 Dec 2022 17:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670377803; x=1701913803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tWBdt2o2/am+QkNoUeL/v5kYgnfgBeMa0WLAghCR9t0=;
  b=H+8gSLsyYq6uQQIsuLtB+dg3i+JIX5N6kCsdgRNPIkcd1vuosWBBGeor
   dWIP9yxCa7LEp2hvVqMQ5JZ+5+ZuxNdRYeKnlnN+vYFZ1HeVICrHVha7L
   jyc15OdYLBGsVlbP84s/IrlkfLVEVWJjdzKAb3xOzWDP0vSsB88ad7wvc
   ZVASh4+oY2PnKJA15PCmipMw8j2fmv+UhwSClCJrvakTX8Fyqq8Q4ApIN
   237z5170G62bYlGYQtgehDK54xyTdAoyShGKSIPJS91QCi3EkfvsV6ME2
   /AsCvwju1cXHvnZFgI/ag5xQE+/CKcSXAO7rjfgBe+opBgxJhBZkPX17e
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="315494551"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="315494551"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:50:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="646427704"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="646427704"
Received: from puneets1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.38.123])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:49:52 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 97FD3109C8E; Wed,  7 Dec 2022 04:49:39 +0300 (+03)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv8 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping into unaccepted memory
Date:   Wed,  7 Dec 2022 04:49:29 +0300
Message-Id: <20221207014933.8435-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
The unwanted loads are typically harmless. But, they might be made to
totally unrelated or even unmapped memory. load_unaligned_zeropad()
relies on exception fixup (#PF, #GP and now #VE) to recover from these
unwanted loads.

But, this approach does not work for unaccepted memory. For TDX, a load
from unaccepted memory will not lead to a recoverable exception within
the guest. The guest will exit to the VMM where the only recourse is to
terminate the guest.

There are three parts to fix this issue and comprehensively avoid access
to unaccepted memory. Together these ensure that an extra "guard" page
is accepted in addition to the memory that needs to be used.

1. Implicitly extend the range_contains_unaccepted_memory(start, end)
   checks up to end+2M if 'end' is aligned on a 2M boundary. It may
   require checking 2M chunk beyond end of RAM. The bitmap allocation is
   modified to accommodate this.
2. Implicitly extend accept_memory(start, end) to end+2M if 'end' is
   aligned on a 2M boundary.
3. Set PageUnaccepted() on both memory that itself needs to be accepted
   *and* memory where the next page needs to be accepted. Essentially,
   make PageUnaccepted(page) a marker for whether work needs to be done
   to make 'page' usable. That work might include accepting pages in
   addition to 'page' itself.

Side note: This leads to something strange. Pages which were accepted
	   at boot, marked by the firmware as accepted and will never
	   _need_ to be accepted might have PageUnaccepted() set on
	   them. PageUnaccepted(page) is a cue to ensure that the next
	   page is accepted before 'page' can be used.

This is an actual, real-world problem which was discovered during TDX
testing.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/mm/unaccepted_memory.c         | 39 +++++++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c |  7 +++++
 2 files changed, 46 insertions(+)

diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 1df918b21469..a0a58486eb74 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -23,6 +23,38 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	bitmap = __va(boot_params.unaccepted_memory);
 	range_start = start / PMD_SIZE;
 
+	/*
+	 * load_unaligned_zeropad() can lead to unwanted loads across page
+	 * boundaries. The unwanted loads are typically harmless. But, they
+	 * might be made to totally unrelated or even unmapped memory.
+	 * load_unaligned_zeropad() relies on exception fixup (#PF, #GP and now
+	 * #VE) to recover from these unwanted loads.
+	 *
+	 * But, this approach does not work for unaccepted memory. For TDX, a
+	 * load from unaccepted memory will not lead to a recoverable exception
+	 * within the guest. The guest will exit to the VMM where the only
+	 * recourse is to terminate the guest.
+	 *
+	 * There are three parts to fix this issue and comprehensively avoid
+	 * access to unaccepted memory. Together these ensure that an extra
+	 * "guard" page is accepted in addition to the memory that needs to be
+	 * used:
+	 *
+	 * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
+	 *    checks up to end+2M if 'end' is aligned on a 2M boundary.
+	 *
+	 * 2. Implicitly extend accept_memory(start, end) to end+2M if 'end' is
+	 *    aligned on a 2M boundary. (immediately following this comment)
+	 *
+	 * 3. Set PageUnaccepted() on both memory that itself needs to be
+	 *    accepted *and* memory where the next page needs to be accepted.
+	 *    Essentially, make PageUnaccepted(page) a marker for whether work
+	 *    needs to be done to make 'page' usable. That work might include
+	 *    accepting pages in addition to 'page' itself.
+	 */
+	if (!(end % PMD_SIZE))
+		end += PMD_SIZE;
+
 	spin_lock_irqsave(&unaccepted_memory_lock, flags);
 	for_each_set_bitrange_from(range_start, range_end, bitmap,
 				   DIV_ROUND_UP(end, PMD_SIZE)) {
@@ -46,6 +78,13 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 
 	bitmap = __va(boot_params.unaccepted_memory);
 
+	/*
+	 * Also consider the unaccepted state of the *next* page. See fix #1 in
+	 * the comment on load_unaligned_zeropad() in accept_memory().
+	 */
+	if (!(end % PMD_SIZE))
+		end += PMD_SIZE;
+
 	spin_lock_irqsave(&unaccepted_memory_lock, flags);
 	while (start < end) {
 		if (test_bit(start / PMD_SIZE, bitmap)) {
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 27b9eed5883b..f375ab784c78 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -715,6 +715,13 @@ static efi_status_t allocate_unaccepted_bitmap(struct boot_params *params,
 		return EFI_SUCCESS;
 	}
 
+	/*
+	 * range_contains_unaccepted_memory() may need to check one 2M chunk
+	 * beyond the end of RAM to deal with load_unaligned_zeropad(). Make
+	 * sure that the bitmap is large enough handle it.
+	 */
+	max_addr += PMD_SIZE;
+
 	/*
 	 * If unaccepted memory is present, allocate a bitmap to track what
 	 * memory has to be accepted before access.
-- 
2.38.0

