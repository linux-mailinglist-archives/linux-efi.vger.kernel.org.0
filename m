Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B4701A7E
	for <lists+linux-efi@lfdr.de>; Sun, 14 May 2023 00:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjEMWEx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 May 2023 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEMWEr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 May 2023 18:04:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105E2D58;
        Sat, 13 May 2023 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684015486; x=1715551486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F0wEDPSvMabnYNajFJWO6701ciPheAFu0TDqu98qRss=;
  b=O5R3YRyisldaMsDxqXNnRtfuBCARy3IhcsK7HDYMDN5KsebbFv4ZF6V5
   5VWmamv/iUJPJeeW4+NhhvBMQJ1QQjhfBiL9MNPT+O5rFonEfA8Rvcq6y
   ZQ44rOX3TxbS8Ajixs9aPIZVba1s9t+C589O3Ouw9xpduL35Yf5hzOPGO
   MWpIOU1Tq5UkAefsM6hQFkmrQ/IhcJh25QAgXoLR6r2zDKHe2PlT9c/ey
   8NqrvxZZOLyq6ejjVICLI6bbfu/c/WcHDbDeDPEAxaNJdL7JdqzaevmSa
   EK54soGFQ9no4xN3yzRy3C7ek6uVNwe6qwAz/pgKHxPK+1KLA59lPMk1h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="437325185"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="437325185"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="790199649"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="790199649"
Received: from sorinaau-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.62.145])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:36 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E090C10CF78; Sun, 14 May 2023 01:04:33 +0300 (+03)
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
        Borislav Petkov <bp@suse.de>
Subject: [PATCHv11 2/9] efi/x86: Get full memory map in allocate_e820()
Date:   Sun, 14 May 2023 01:04:11 +0300
Message-Id: <20230513220418.19357-3-kirill.shutemov@linux.intel.com>
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

Currently allocate_e820() is only interested in the size of map and size
of memory descriptor to determine how many e820 entries the kernel
needs.

UEFI Specification version 2.9 introduces a new memory type --
unaccepted memory. To track unaccepted memory kernel needs to allocate
a bitmap. The size of the bitmap is dependent on the maximum physical
address present in the system. A full memory map is required to find
the maximum address.

Modify allocate_e820() to get a full memory map.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 26 +++++++++++--------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index a0bfd31358ba..fff81843169c 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -681,28 +681,24 @@ static efi_status_t allocate_e820(struct boot_params *params,
 				  struct setup_data **e820ext,
 				  u32 *e820ext_size)
 {
-	unsigned long map_size, desc_size, map_key;
+	struct efi_boot_memmap *map;
 	efi_status_t status;
-	__u32 nr_desc, desc_version;
+	__u32 nr_desc;
 
-	/* Only need the size of the mem map and size of each mem descriptor */
-	map_size = 0;
-	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
-			     &desc_size, &desc_version);
-	if (status != EFI_BUFFER_TOO_SMALL)
-		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
+	status = efi_get_memory_map(&map, false);
+	if (status != EFI_SUCCESS)
+		return status;
 
-	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
-
-	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
-		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
+	nr_desc = map->map_size / map->desc_size;
+	if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
+		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) +
+			EFI_MMAP_NR_SLACK_SLOTS;
 
 		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
-		if (status != EFI_SUCCESS)
-			return status;
 	}
 
-	return EFI_SUCCESS;
+	efi_bs_call(free_pool, map);
+	return status;
 }
 
 struct exit_boot_struct {
-- 
2.39.3

