Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0552A6DF
	for <lists+linux-efi@lfdr.de>; Tue, 17 May 2022 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350164AbiEQPfE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 May 2022 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343688AbiEQPfA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 May 2022 11:35:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512E15044C;
        Tue, 17 May 2022 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652801697; x=1684337697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/DvWvoUGI84WnbT8SvQg0KISEoV8wlnpcbdutvGK/n8=;
  b=HSFILJ6/kQHcbmZ7SB+ingaQwJYLdUvmNU3ghSGO/gKH4pfieEw6u4Vj
   gMcUyqlIXDfpM805j69KYc5Zixz/7NRqBuB1plCQcC5MSPVLKG1eoQv+s
   +hGibOnG6nVLZGl5YjJMtd0W0rasD0MXj1b32mJ5FqlkZZfas9hAbkhEK
   LFdhmpER4Q9WUwpQka8rmpYjwiul+1PjKdgVMC/0u8ZUql08GsZXFJgH5
   2VzP2ooKTNJTOTyWYJFAR1SZdR7zVqXNrLWh4UzCC5iZjq3w6K8+uRUVS
   L1XqxbyMCUFtMMuSot3/FwnxlddJkvXopWzAKgE21SBYdJys1Rhz0NH5O
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251732976"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251732976"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 08:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="897725525"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 May 2022 08:34:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 69F50646; Tue, 17 May 2022 18:34:50 +0300 (EEST)
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
Subject: [PATCHv6 03/15] efi/x86: Get full memory map in allocate_e820()
Date:   Tue, 17 May 2022 18:34:32 +0300
Message-Id: <20220517153444.11195-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/firmware/efi/libstub/x86-stub.c | 28 +++++++++++--------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 01ddd4502e28..252ee222ca1e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -569,31 +569,27 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
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
-		if (status != EFI_SUCCESS)
-			return status;
 	}
 
-	return EFI_SUCCESS;
+	efi_bs_call(free_pool, *map->map);
+	return status;
 }
 
 struct exit_boot_struct {
@@ -642,7 +638,7 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	priv.boot_params	= boot_params;
 	priv.efi		= &boot_params->efi_info;
 
-	status = allocate_e820(boot_params, &e820ext, &e820ext_size);
+	status = allocate_e820(boot_params, &map, &e820ext, &e820ext_size);
 	if (status != EFI_SUCCESS)
 		return status;
 
-- 
2.35.1

