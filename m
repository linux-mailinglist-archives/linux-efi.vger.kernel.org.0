Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E101854AFC8
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 14:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356341AbiFNMDC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 08:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356273AbiFNMCq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 08:02:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC00248E2;
        Tue, 14 Jun 2022 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655208163; x=1686744163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bd6faJOVW2FfIjzDQn03hQW9BQt9XmcRmtaVqSAHsus=;
  b=L7DGIs7LNsUbxlNPk7Ueu50FKg00qjzJql6VoiLHmavSxpOij0j6TOgx
   qyYoSGLZAlOkxLChHUQqlEt4GZBL2OZ5e/9GXJ0UK8Uc6RW6UVJWhVaoQ
   XksgE3NLfBmxGLZ9MoG2I+Q9zhXPlmUgSSEJm9CZa6yiIX0DtN9QME9Le
   5fH6nVL0jN0heJef0tHgSCOQOVaRvztSZsX7M9+ulRKd0adfesyLGlm52
   KPMJTRlP422AHOk1Ku/K3y+6ladQVXPNb08FN74a+gL4nGRcc6e3/eoAr
   +KQLjU9ohE67O1WOHgruV1vRfDoFemCkD3u7kAHVZbqumfJHtW8IC6hUB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="259048723"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="259048723"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="535534975"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Jun 2022 05:02:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D40B792D; Tue, 14 Jun 2022 15:02:32 +0300 (EEST)
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
Subject: [PATCHv7 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping into unaccepted memory
Date:   Tue, 14 Jun 2022 15:02:27 +0300
Message-Id: <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

1. Implicitly extend the range_contains_unaccepted_memory(start, end)
   checks up to end+2M if ‘end’ is aligned on a 2M boundary.
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
index 1df918b21469..bcd56fe82b9e 100644
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
@@ -46,6 +78,10 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 
 	bitmap = __va(boot_params.unaccepted_memory);
 
+	/* See comment on load_unaligned_zeropad() in accept_memory() */
+	if (!(end % PMD_SIZE))
+		end += PMD_SIZE;
+
 	spin_lock_irqsave(&unaccepted_memory_lock, flags);
 	while (start < end) {
 		if (test_bit(start / PMD_SIZE, bitmap)) {
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index b91c89100b2d..bc1110509de4 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -709,6 +709,13 @@ static efi_status_t allocate_unaccepted_memory(struct boot_params *params,
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

