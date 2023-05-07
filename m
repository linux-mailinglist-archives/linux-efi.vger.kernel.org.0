Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851DA6F9CDB
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 01:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjEGXq5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 May 2023 19:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjEGXqu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 May 2023 19:46:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BB410C4;
        Sun,  7 May 2023 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683503206; x=1715039206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9TDbO3a4jRT5J+8rG9pcod0nyB+3DpMcKz9PP7HQwro=;
  b=Ua1LAgfGANEz3VoSbhneibI410Zd7/Ii8XBOBZ0j1nTL3I8qZWs7aVCw
   NqS4E0sMpRXLopNEfd9/gst366q2jJmSvZNRHJ/mGLYejK2T1Odr/SnBV
   qaYz93Ayb09MJ8WI7VK2MZlW2X9vYd6tnDcQWL27iLahdUBfm6+z6rgnp
   Asm7qDiSp5WqknePyh7wQYeYyZa9f4y2/vmEBf8Q2MmJ73E8kVVUsGTzv
   s0odiemL/oTl0qKAeL/lkSbrb8FCNYihR4jnt4y1K15SQfc7XzJ3GAS2v
   TBfzhzjgKPyZ25f3OuGfz4ijGhtPuCE2VaMLgDqN8D1uaOE5ptiuPI/CS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="349550308"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="349550308"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 16:46:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="701222812"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="701222812"
Received: from dancaspi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 16:46:32 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5EDD010D349; Mon,  8 May 2023 02:46:20 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
Subject: [PATCHv10 08/11] x86/mm: Avoid load_unaligned_zeropad() stepping into unaccepted memory
Date:   Mon,  8 May 2023 02:46:15 +0300
Message-Id: <20230507234618.18067-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

There are two parts to fix this issue and comprehensively avoid access
to unaccepted memory. Together these ensure that an extra "guard" page
is accepted in addition to the memory that needs to be used.

1. Implicitly extend the range_contains_unaccepted_memory(start, end)
   checks up to end+2M if 'end' is aligned on a 2M boundary. It may
   require checking 2M chunk beyond end of RAM. The bitmap allocation is
   modified to accommodate this.
2. Implicitly extend accept_memory(start, end) to end+2M if 'end' is
   aligned on a 2M boundary.

Side note: This leads to something strange. Pages which were accepted
	   at boot, marked by the firmware as accepted and will never
	   _need_ to be accepted might be on unaccepted_pages list
	   This is a cue to ensure that the next page is accepted
	   before 'page' can be used.

This is an actual, real-world problem which was discovered during TDX
testing.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/mm/unaccepted_memory.c         | 33 +++++++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c |  7 ++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 1df918b21469..2f38059e5b08 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -23,6 +23,32 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
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
+	 * There are two parts to fix this issue and comprehensively avoid
+	 * access to unaccepted memory. Together these ensure that an extra
+	 * "guard" page is accepted in addition to the memory that needs to be
+	 * used:
+	 *
+	 * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
+	 *    checks up to end+2M if 'end' is aligned on a 2M boundary.
+	 *
+	 * 2. Implicitly extend accept_memory(start, end) to end+2M if 'end' is
+	 *    aligned on a 2M boundary. (immediately following this comment)
+	 */
+	if (!(end % PMD_SIZE))
+		end += PMD_SIZE;
+
 	spin_lock_irqsave(&unaccepted_memory_lock, flags);
 	for_each_set_bitrange_from(range_start, range_end, bitmap,
 				   DIV_ROUND_UP(end, PMD_SIZE)) {
@@ -46,6 +72,13 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 
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
index 1643ddbde249..1afe7b5b02e1 100644
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
2.39.3

