Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDEE7245E7
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbjFFO1v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 10:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjFFO1m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 10:27:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66034171D;
        Tue,  6 Jun 2023 07:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686061661; x=1717597661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LJWuKaqvYOvqAXDR1TKqUlI78Dny7nmmQ0aMOVcXkCg=;
  b=QS91vOTzgQrvE3ksU1GHsXwnCNdDMp8cAnGXa9r0gt3ybzXmqrtfpyGL
   b/6XBqncp5pNNSvlpM0QHgZEdh3rdJOFpH5W0Ih0Gms1+kE2xJOLMltoi
   UXGQBDl5DqO/cfdmX/SzcUiSm+KYoQ16p/CMcGYmnjEV9gEGYaCW3XQ4n
   pzSIcrNLuqBxR7r29ZogKZQXChcmNJZbEpBMcp+krz681sKiRPMscVQuI
   yLSFI5MEepRg668Ji5BSeecuCEIkPkho3hOUrCz1DpHVwwWVVqxMqXsIg
   8aONt2BhhdGO5gbxS/jhrHIcWGhCxQqrjlMQlS3Ss0STthYe8MIFTSQh3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="341336956"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="341336956"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="738815142"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="738815142"
Received: from rgraefe-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:26:44 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 358B910D348; Tue,  6 Jun 2023 17:26:42 +0300 (+03)
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
Subject: [PATCHv14 2/9] efi/x86: Get full memory map in allocate_e820()
Date:   Tue,  6 Jun 2023 17:26:30 +0300
Message-Id: <20230606142637.5171-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
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

