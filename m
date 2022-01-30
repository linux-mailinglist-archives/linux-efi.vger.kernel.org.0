Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150F04A37C5
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jan 2022 17:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiA3QsW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jan 2022 11:48:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:23706 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355610AbiA3QsW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 30 Jan 2022 11:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643561302; x=1675097302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nSSz3PwT9pAlklbcpqd0bHWy9ItvvFudWk2pwJNvLyg=;
  b=dxX9jwd8INQ+Rg/+HZRaoKupL2nNRJ1ljfE7lv/wHYDP60IcAZ4C7lPS
   aOsLYFG9ofAlUCvroXY//kDF0cNUI25sNTpsycBRDuBWCFbHJ3MHHzLOd
   Jfa9uHUDZ1tJOArRX1zjDnWqJtv9MdnPmWig78odBdMbF8hPJBwkbeuyQ
   r20UxozRYxgxHkqY0OpUP6QuHc2BLJHbnTrhotucVmJBMxZ+cqyLSyms7
   TA1kh831aaNK7F7gXkj7w4koRlCht0amouQPeRSd4lMNzDM3AHCkxOY3Z
   U7+70EY+2/lhRpvT+9zm8BUifpulD7l/DRxoHMtwH72z9BZYxtkLPl/wj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="247579427"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="247579427"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 08:48:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="629634558"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2022 08:48:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 83CFC176; Sun, 30 Jan 2022 18:48:28 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     rppt@kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org, ardb@kernel.org,
        bp@alien8.de, brijesh.singh@amd.com, dave.hansen@intel.com,
        david@redhat.com, dfaggioli@suse.com, jroedel@suse.de,
        kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org, rientjes@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, thomas.lendacky@amd.com, varad.gautam@suse.com,
        vbabka@suse.cz, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCHv3.1 5/7] x86/mm: Reserve unaccepted memory bitmap
Date:   Sun, 30 Jan 2022 19:48:23 +0300
Message-Id: <20220130164823.40470-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YfZJQedck2YxZcWA@kernel.org>
References: <YfZJQedck2YxZcWA@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A given page of memory can only be accepted once.  The kernel has a need
to accept memory both in the early decompression stage and during normal
runtime.

A bitmap used to communicate the acceptance state of each page between the
decompression stage and normal runtime.  This eliminates the possibility of
attempting to double-accept a page.

The bitmap is allocated in EFI stub, decompression stage updates the state
of pages used for the kernel and initrd and hands the bitmap over to the
main kernel image via boot_params.

In the runtime kernel, reserve the bitmap's memory to ensure nothing
overwrites it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
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

