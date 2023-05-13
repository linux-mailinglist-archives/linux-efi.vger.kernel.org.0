Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27219701A82
	for <lists+linux-efi@lfdr.de>; Sun, 14 May 2023 00:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjEMWE6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 May 2023 18:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjEMWEy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 May 2023 18:04:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281AD30D3;
        Sat, 13 May 2023 15:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684015493; x=1715551493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gRzQhhRAaTLGAt93TT2mPFzt+Xa/PSDkJomh6JXhxmM=;
  b=JKCPO3y8WHafsRVcc8rBjjeYO2gMypANbGvtZJTuZZpNNjkZH/8CFTpP
   XU3D16vOMyMyuqY+bxbVKzZHSrV+fWwg41TDTlKdGhbKnWCNg5PXro0YW
   12Q8Uxe8AkVhps14Xi4qt/TAy6IdsCOQlbkEUtEKyuAVMV3nRJi3pYAdu
   UOvtYlGby0TFWW1RRi142GR0T/Hm1kpxkdYaYtOB+7p0rbxpikXe0NPjS
   dZJOPoJOSnVttkBrKv5/hbCL4lHuYb9e7pZYOcNiI3t8jCyb7hC+cbmK8
   a3eT6fnYUvIE6SSen2eJD95stN5sr22jh3jpd7GcPD6SjcxdxMUv4xByu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="437325202"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="437325202"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="790199674"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="790199674"
Received: from sorinaau-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.62.145])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:45 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1A75810CF7C; Sun, 14 May 2023 01:04:34 +0300 (+03)
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
Subject: [PATCHv11 6/9] efi/unaccepted: Avoid load_unaligned_zeropad() stepping into unaccepted memory
Date:   Sun, 14 May 2023 01:04:15 +0300
Message-Id: <20230513220418.19357-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
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
   checks up to end+unit_size if 'end' is aligned on a unit_size
   boundary.
2. Implicitly extend accept_memory(start, end) to end+unit_size if 'end'
   is aligned on a unit_size boundary.

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
 drivers/firmware/efi/unaccepted_memory.c | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index bb91c41f76fb..3d1ca60916dd 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -37,6 +37,34 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	start -= unaccepted->phys_base;
 	end -= unaccepted->phys_base;
 
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
+	 *    checks up to end+unit_size if 'end' is aligned on a unit_size
+	 *    boundary.
+	 *
+	 * 2. Implicitly extend accept_memory(start, end) to end+unit_size if
+	 *    'end' is aligned on a unit_size boundary. (immediately following
+	 *    this comment)
+	 */
+	if (!(end % unit_size))
+		end += unit_size;
+
 	/* Make sure not to overrun the bitmap */
 	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
 		end = unaccepted->size * unit_size * BITS_PER_BYTE;
@@ -84,6 +112,13 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 	start -= unaccepted->phys_base;
 	end -= unaccepted->phys_base;
 
+	/*
+	 * Also consider the unaccepted state of the *next* page. See fix #1 in
+	 * the comment on load_unaligned_zeropad() in accept_memory().
+	 */
+	if (!(end % unit_size))
+		end += unit_size;
+
 	/* Make sure not to overrun the bitmap */
 	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
 		end = unaccepted->size * unit_size * BITS_PER_BYTE;
-- 
2.39.3

