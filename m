Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AB448AC81
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbiAKLdP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 06:33:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:37638 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349514AbiAKLdN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 06:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641900793; x=1673436793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HaLasq89QiEz30QdU5oVDEDYHaeFFEnWUHw6RN/QsG4=;
  b=AQcgThPwdGjGO25u1z+I7GA4b1Ah6Ux/1ZcDVbL6un2TeWf7nI1C8T7z
   qxfAAQmKEldc5GoHkPrlbzBTCTGxocFEwzgli5NOSO43ORr1ULZanMGbB
   Duti1bqJTDog4p7jg5J80nzgCXI2XQlOjfJPGljGa8GNPEy10+cZBkkgL
   8yN3L5kp75BAHknN6UC11SCnfBxnEs6suOLbpNn41znaq5H8l+k1sEUtf
   9Mtggpo4tLrT0HO8otlTkPpXbTKWrDeNJ8ZxK88RCLyN/u5+UdjiZkldt
   i4eE8SAoqYrWs4csHRsM81WZPP4J4Oz+2lXjQ0wGNxm79Wa8rRNdGncOm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243261607"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243261607"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="490351596"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 11 Jan 2022 03:33:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 35429232; Tue, 11 Jan 2022 13:33:19 +0200 (EET)
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
Subject: [PATCHv2 2/7] efi/x86: Get full memory map in allocate_e820()
Date:   Tue, 11 Jan 2022 14:33:09 +0300
Message-Id: <20220111113314.27173-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently allocate_e820() only interested in the size of map and size of
memory descriptor to determine how many e820 entries the kernel needs.

UEFI Specification version 2.9 introduces a new memory type --
unaccepted memory. To track unaccepted memory kernel needs to allocate
a bitmap. The size of the bitmap is dependent on the maximum physical
address present in the system. A full memory map is required to find
the maximum address.

Modify allocate_e820() to get a full memory map.

This is preparation for the next patch that implements handling of
unaccepted memory in EFI stub.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 28 ++++++++++++-------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f14c4ff5839f..a0b946182b5e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -569,30 +569,28 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
 }
 
 static efi_status_t allocate_e820(struct boot_params *params,
+				  struct efi_boot_memmap *map,
 				  struct setup_data **e820ext,
 				  u32 *e820ext_size)
 {
-	unsigned long map_size, desc_size, map_key;
 	efi_status_t status;
-	__u32 nr_desc, desc_version;
+	__u32 nr_desc;
 
-	/* Only need the size of the mem map and size of each mem descriptor */
-	map_size = 0;
-	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
-			     &desc_size, &desc_version);
-	if (status != EFI_BUFFER_TOO_SMALL)
-		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
-
-	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
+	status = efi_get_memory_map(map);
+	if (status != EFI_SUCCESS)
+		return status;
 
-	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
-		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
+	nr_desc = *map->map_size / *map->desc_size;
+	if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
+		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) +
+			EFI_MMAP_NR_SLACK_SLOTS;
 
 		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
 		if (status != EFI_SUCCESS)
-			return status;
+			goto out;
 	}
-
+out:
+	efi_bs_call(free_pool, *map->map);
 	return EFI_SUCCESS;
 }
 
@@ -642,7 +640,7 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	priv.boot_params	= boot_params;
 	priv.efi		= &boot_params->efi_info;
 
-	status = allocate_e820(boot_params, &e820ext, &e820ext_size);
+	status = allocate_e820(boot_params, &map, &e820ext, &e820ext_size);
 	if (status != EFI_SUCCESS)
 		return status;
 
-- 
2.34.1

