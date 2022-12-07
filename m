Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB547645179
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 02:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLGBuT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Dec 2022 20:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLGBuJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Dec 2022 20:50:09 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1722532C6;
        Tue,  6 Dec 2022 17:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670377799; x=1701913799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oBiSIOxE3eoLPk40ExcpaFUWqTkEiCbV0j2bGnDI4n8=;
  b=dJ6Kf+p7pq7OVLXdCIMJbKhO9G4PToMylfvLhXRMcImC4dSLwgiQDvhd
   Z0seE+3buo/iSbVFIOo/gZeLrKziE4t137pa1bvvaiyO7P9x45Y0ONGUY
   096PCQQJMYEgrstWbWbk0GKICCr0FclPRydatuMaUMKl8zLrlQjhY2xBD
   qy9TIy3BMD97sdAFUHwW1vejSQGKz+ooqfBJ+gscqzvoJRfMMxuoms13N
   NZJ0djf7YePuHBTCulncAjGncCgFVhDU0JRFHWQjjFAFHjUIEP+wLDFWh
   QUAlV4yXyz9Ag9d60Cjd/UY86bXGc8zIutJZtQisCM+36Q6ZFW88i4hhz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="316794419"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="316794419"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:49:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="640082279"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="640082279"
Received: from puneets1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.38.123])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:49:51 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 814A0109C8C; Wed,  7 Dec 2022 04:49:39 +0300 (+03)
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
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCHv8 08/14] x86/mm: Reserve unaccepted memory bitmap
Date:   Wed,  7 Dec 2022 04:49:27 +0300
Message-Id: <20221207014933.8435-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A given page of memory can only be accepted once. The kernel has to
accept memory both in the early decompression stage and during normal
runtime.

A bitmap is used to communicate the acceptance state of each page
between the decompression stage and normal runtime.

boot_params is used to communicate location of the bitmap throughout
the boot. The bitmap is allocated and initially populated in EFI stub.
Decompression stage accepts pages required for kernel/initrd and marks
these pages accordingly in the bitmap. The main kernel picks up the
bitmap from the same boot_params and uses it to determine what has to
be accepted on allocation.

In the runtime kernel, reserve the bitmap's memory to ensure nothing
overwrites it.

The size of bitmap is determined with e820__end_of_ram_pfn() which
relies on setup_e820() marking unaccepted memory as E820_TYPE_RAM.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/kernel/e820.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 9dac24680ff8..62068956bb76 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1316,6 +1316,23 @@ void __init e820__memblock_setup(void)
 	int i;
 	u64 end;
 
+	/*
+	 * Mark unaccepted memory bitmap reserved.
+	 *
+	 * This kind of reservation usually done from early_reserve_memory(),
+	 * but early_reserve_memory() called before e820__memory_setup(), so
+	 * e820_table is not finalized and e820__end_of_ram_pfn() cannot be
+	 * used to get correct RAM size.
+	 */
+	if (boot_params.unaccepted_memory) {
+		unsigned long size;
+
+		/* One bit per 2MB */
+		size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
+				    PMD_SIZE * BITS_PER_BYTE);
+		memblock_reserve(boot_params.unaccepted_memory, size);
+	}
+
 	/*
 	 * The bootstrap memblock region count maximum is 128 entries
 	 * (INIT_MEMBLOCK_REGIONS), but EFI might pass us more E820 entries
-- 
2.38.0

