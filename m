Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9283B48AC87
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 12:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349630AbiAKLdh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 06:33:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:37650 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349553AbiAKLdT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 06:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641900799; x=1673436799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hyOD0iOzQ3OdcyuSvPELW4e2F6ocBQ3s5Blwr9IqDVU=;
  b=UQ9mjWbR+pCIH+8JdoyKKi7x42HyQAKrR+0etELonfdVlW/4rFPKfU4N
   03O2y3zRnHVbNDtLNNAD1kghcxpOdmaSQf9WeimTgM/RVWa7RWSzy2CFQ
   DxLwylAjGgccAMZQRgWm5/N705cwTeKXjufzseDVgHQ2psTzUpiWvQnCX
   geQ8byxKOeROVl33pRrZIXXL3o9fg4vqZ14l7ZIc1lk9ZajUw/EltX2SA
   Vy8XHf7MtPUJZFfqnxJqhIkj/S95cFKOjbH0Wx4qDBOsePsVhMoiX1us2
   52eOJ6nZBTlAJlxIQF/z6UaKewStCuA1hXDnAvEDfmS91f+rXaWZu4FL3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243261638"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243261638"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:33:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="623042894"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2022 03:33:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5F7974AC; Tue, 11 Jan 2022 13:33:19 +0200 (EET)
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
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 5/7] x86/mm: Reserve unaccepted memory bitmap
Date:   Tue, 11 Jan 2022 14:33:12 +0300
Message-Id: <20220111113314.27173-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Unaccepted memory bitmap is allocated during decompression stage and
handed over to main kernel image via boot_params. The bitmap is used to
track if memory has been accepted.

Reserve unaccepted memory bitmap has to prevent reallocating memory for
other means.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/e820.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f0deed..dc9048e2d421 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1290,6 +1290,16 @@ void __init e820__memory_setup(void)
 
 	pr_info("BIOS-provided physical RAM map:\n");
 	e820__print_table(who);
+
+	/* Mark unaccepted memory bitmap reserved */
+	if (boot_params.unaccepted_memory) {
+		unsigned long size;
+
+		/* One bit per 2MB */
+		size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
+				    PMD_SIZE * BITS_PER_BYTE);
+		memblock_reserve(boot_params.unaccepted_memory, size);
+	}
 }
 
 void __init e820__memblock_setup(void)
-- 
2.34.1

