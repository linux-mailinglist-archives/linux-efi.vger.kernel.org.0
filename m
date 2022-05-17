Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8380152A6DB
	for <lists+linux-efi@lfdr.de>; Tue, 17 May 2022 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350154AbiEQPfK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 May 2022 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350185AbiEQPfH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 May 2022 11:35:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320BF4F9E1;
        Tue, 17 May 2022 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652801706; x=1684337706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZtxSqO4KIAh0ipO8K6wy8wKDprGI920JXd4BfH9/jE=;
  b=NzISyU43lkVJSQxsKDicFgVaDysEqMw4Yl/mCdZr6HDwVcVWdzltkMKV
   J7AQ0+W8VR7wXV0MK0NCrjr8i+zl1+zoGeLkFT42khnmDdyJVFWEM/cF+
   dlCxwR0YOstoylAFePNyFFmCCgqQEcXTuWka/mS1uso5A6oKIzWEw3G5m
   oZ+AFys80dHI5MfuqASsWpgx9AcPp3PUfqiZcXwwETDkQVCWcoR2U5xAS
   /HC2Y/RQXBKwFWvfhlduDHkBMElwPBip40YBJha5A0mmNhWgfZnVlcQVC
   wnHkWbWUzdmuizTX2QG/joVAEDS6CwQkLUmT5p4vJP9Os/CGO0kmeHCWN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="258783173"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="258783173"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 08:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="605408170"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 17 May 2022 08:34:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id AE7C5B80; Tue, 17 May 2022 18:34:50 +0300 (EEST)
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
Subject: [PATCHv6 09/15] x86/mm: Avoid load_unaligned_zeropad() stepping into unaccepted memory
Date:   Tue, 17 May 2022 18:34:38 +0300
Message-Id: <20220517153444.11195-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
to unaccepted memory. Together these ensure that an extra “guard” page
is accepted in addition to the memory that needs to be used.

1. Implicitly extend the memory_is_unaccepted(start, end) checks up to
   end+2M if ‘end’ is aligned on a 2M boundary.
2. Implicitly extend accept_memory(start, end) to end+2M if ‘end’ is
   aligned on a 2M boundary.
3. Set PageUnaccepted() on both memory that itself needs to be accepted
   *and* memory where the next page needs to be accepted. Essentially,
   make PageUnaccepted(page) a marker for whether work needs to be done
   to make ‘page’ usable. That work might include accepting pages in
   addition to ‘page’ itself.

Side note: This leads to something strange. Pages which were accepted
	   at boot, marked by the firmware as accepted and will never
	   _need_ to be accepted might have PageUnaccepted() set on
	   them. PageUnaccepted(page) is a cue to ensure that the next
	   page is accepted before ‘page’ can be used.

This is an actual, real-world problem which was discovered during TDX
testing.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/unaccepted_memory.c         | 36 +++++++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c |  7 +++++
 2 files changed, 43 insertions(+)

diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 0a86380b2478..33bf70592a46 100644
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
+	 * “guard” page is accepted in addition to the memory that needs to be
+	 * used:
+	 *
+	 * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
+	 *    checks up to end+2M if ‘end’ is aligned on a 2M boundary.
+	 *
+	 * 2. Implicitly extend accept_memory(start, end) to end+2M if ‘end’ is
+	 *    aligned on a 2M boundary.
+	 *
+	 * 3. Set PageUnaccepted() on both memory that itself needs to be
+	 *    accepted *and* memory where the next page needs to be accepted.
+	 *    Essentially, make PageUnaccepted(page) a marker for whether work
+	 *    needs to be done to make ‘page’ usable. That work might include
+	 *    accepting pages in addition to ‘page’ itself.
+	 */
+	if (!(end % PMD_SIZE))
+		end += PMD_SIZE;
+
 	spin_lock_irqsave(&unaccepted_memory_lock, flags);
 	for_each_set_bitrange_from(range_start, range_end, bitmap,
 				   DIV_ROUND_UP(end, PMD_SIZE)) {
@@ -41,6 +73,10 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 	unsigned long flags;
 	bool ret = false;
 
+	/* See comment on load_unaligned_zeropad() in accept_memory() */
+	if (!(end % PMD_SIZE))
+		end += PMD_SIZE;
+
 	spin_lock_irqsave(&unaccepted_memory_lock, flags);
 	while (start < end) {
 		if (test_bit(start / PMD_SIZE, bitmap)) {
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index ec14a9a6436b..89705ae69cbf 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -606,6 +606,13 @@ static efi_status_t allocate_unaccepted_memory(struct boot_params *params,
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
 	 * If unaccepted memory is present allocate a bitmap to track what
 	 * memory has to be accepted before access.
-- 
2.35.1

