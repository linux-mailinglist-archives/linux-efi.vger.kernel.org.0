Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06B54A0270
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 21:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbiA1U7R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 15:59:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:58018 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245606AbiA1U7L (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 15:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643403551; x=1674939551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=koK/VhFGViq6NfT00njMUR21vAbvfWnplJSVKWqjHls=;
  b=DMZz88ulMgMt4U1/7BlzfPVOmcARqLrdIAFhNTH82ykYOJabpDBWNBso
   fRmO1Fo5X6CsNd5Ngcwm5WjQuvDM/uJjad4yxxewQ8OviPfN+71TYA9sA
   W5GxYn+sYJYk3lb7EL/AsUfbadhhqQTmBojnk+gTtQRc2I/RTNJC/4VEV
   P2SO73ZfLL4tcsSyHZCreNHJLbBbtXbZJXAY2jJEUAVREDwLVK1cc62Xl
   PI2ikQM4wfN0zC2B5oPyyULMFYZkXDzojUR3ebBpiUza9fe9g6IRbjD64
   TRub8UKh3flJZsoB0FF2rm29ujpq0xk6LBeZ0CnWHBovBDUgs0SLMGfap
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247417211"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="247417211"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 12:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="533622715"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2022 12:59:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C5335477; Fri, 28 Jan 2022 22:59:09 +0200 (EET)
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 5/7] x86/mm: Reserve unaccepted memory bitmap
Date:   Fri, 28 Jan 2022 23:59:04 +0300
Message-Id: <20220128205906.27503-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
References: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A given page of memory can only be accepted once.  The kernel has a need
to accept memory both in the early decompression stage and during normal
runtime.

Use a bitmap to communicate the acceptance state of each page between
the decompression stage and normal runtime.  This eliminates the
possibility of attempting to double-accept a page.

Allocate the bitmap during decompression stage and hand it over to the
main kernel image via boot_params.

In the runtime kernel, reserve the bitmap's memory to ensure nothing
overwrites it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/e820.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f0deed..3905bd1ca41d 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1297,6 +1297,16 @@ void __init e820__memblock_setup(void)
 	int i;
 	u64 end;
 
+	/* Mark unaccepted memory bitmap reserved */
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
2.34.1

