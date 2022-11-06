Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A6161E2C9
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 15:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiKFOyH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Nov 2022 09:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKFOyG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Nov 2022 09:54:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E1F2ADF
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 06:54:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 40568CE0C29
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 14:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984CAC433D6;
        Sun,  6 Nov 2022 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667746441;
        bh=jrLSB7umbSJr3MUaPKF5yaDwaY+gSVJWf1bGPxRxxD4=;
        h=From:To:Cc:Subject:Date:From;
        b=Tm2k1w2tafWKTNuclkjI3CiUYIzX/KXwoeJfEpAXOIWq84Saml7HNZl80oG9P/bya
         NTJXH5sxYY/7GcZfoyHCNeuQ2/pTodAxQ1HyvTG07/9OcTxalDcTMOJowAlZlsHra2
         ZMo3TagH0IDflf2NfHkZBefBi1CewuYzxvsvW/2kbNslWXFVxazPkdy5Naak8+0h+W
         6N3fUUrUpFR6gJY9PSlsXgzlsNXpZW1dpzPIOj3zWkC7rLBK9suKzBewSZfyIjYEMF
         uGt37lG4VVos9JJK9Si84fun2zB3UBL3nbZsnY3kyXVefu3297j8ZazneAY72b4gmK
         XTKcoz3jUfwPg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2] arm64: efi: Fix handling of misaligned runtime regions and drop warning
Date:   Sun,  6 Nov 2022 15:53:54 +0100
Message-Id: <20221106145354.3876410-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9329; i=ardb@kernel.org; h=from:subject; bh=jrLSB7umbSJr3MUaPKF5yaDwaY+gSVJWf1bGPxRxxD4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjZ8qBXpxntLQ1w+XZ/OV4ke1gL+t8nQezNJ8fYCa2 VpTsuEeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2fKgQAKCRDDTyI5ktmPJKjhC/ 0Ycy83Pnqzn+Ieu/k5yXaufwGlvZOb47oPOrCQ4pJqgdoQ7SKnTLm+fK3Bro4n3o5Qj52G6IC0LT7l fX109jzXiejZun3Cmq42pRLDnb5nNT74JIXSkpJV2/iejR1KgBe5zmLqhOIeUQcF7MNMzP3z2TjEND m1V0gdR3avrkUxtDORGTN0iGqCM2xHCTUNLr5Gcr9rDSR7A/+cPhHhNoCX6ETyGbtb4LVk82dONOpQ JPRe05JRQNJg2AqxIA55R6c4nKk7ld8kdFFQO3kFoQrSWJIm8FR21etcpBAP69eyPi5Fg73FSt2lZF Am9TTCzy/oSVEtLI7pd9yksUyEHwsV4vedd4WmFmpXAaM3j7n2LCnIH78xK7mrktTM0BSy9QLr5TsM HDfYZTcjNsBAvkOGEnpAW7EaO5P17PAO14DAzO3MJ+EJpipTNfV0V8qtbB2w5kq1K8eoixtFE75h8/ W6xjocks8tCisvAc+vdeurWGz1OxvuQepvrto05WenKAQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, when mapping the EFI runtime regions in the EFI page tables,
we complain about misaligned regions in a rather noisy way, using
WARN().

Not only does this produce a lot of irrelevant clutter in the log, it is
factually incorrect, as misaligned runtime regions are actually allowed
by the EFI spec as long as they don't require conflicting memory types
within the same 64k page.

So let's drop the warning, and tweak the code so that we
- take both the start and end of the region into account when checking
  for misalignment
- only revert to RWX mappings for non-code regions if misaligned code
  regions are also known to exist.

Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Tested with uboot on QEMU/mach-virt using a 64k pagesize kernel build.
More details after the patch.

 arch/arm64/kernel/efi.c | 52 +++++++++++++-------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index e1be6c429810d0d5..a908a37f03678b6b 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -12,6 +12,14 @@
 
 #include <asm/efi.h>
 
+static bool region_is_misaligned(const efi_memory_desc_t *md)
+{
+	if (PAGE_SIZE == EFI_PAGE_SIZE)
+		return false;
+	return !PAGE_ALIGNED(md->phys_addr) ||
+	       !PAGE_ALIGNED(md->num_pages << EFI_PAGE_SHIFT);
+}
+
 /*
  * Only regions of type EFI_RUNTIME_SERVICES_CODE need to be
  * executable, everything else can be mapped with the XN bits
@@ -25,14 +33,22 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
 	if (type == EFI_MEMORY_MAPPED_IO)
 		return PROT_DEVICE_nGnRE;
 
-	if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
-		      "UEFI Runtime regions are not aligned to 64 KB -- buggy firmware?"))
+	if (region_is_misaligned(md)) {
+		static bool __initdata code_is_misaligned;
+
 		/*
-		 * If the region is not aligned to the page size of the OS, we
-		 * can not use strict permissions, since that would also affect
-		 * the mapping attributes of the adjacent regions.
+		 * Regions that are not aligned to the OS page size cannot be
+		 * mapped with strict permissions, as those might interfere
+		 * with the permissions that are needed by the adjacent
+		 * region's mapping. However, if we haven't encountered any
+		 * misaligned runtime code regions so far, we can safely use
+		 * non-executable permissions for non-code regions.
 		 */
-		return pgprot_val(PAGE_KERNEL_EXEC);
+		code_is_misaligned |= (type == EFI_RUNTIME_SERVICES_CODE);
+
+		return code_is_misaligned ? pgprot_val(PAGE_KERNEL_EXEC)
+					  : pgprot_val(PAGE_KERNEL);
+	}
 
 	/* R-- */
 	if ((attr & (EFI_MEMORY_XP | EFI_MEMORY_RO)) ==
@@ -63,19 +79,16 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 	bool page_mappings_only = (md->type == EFI_RUNTIME_SERVICES_CODE ||
 				   md->type == EFI_RUNTIME_SERVICES_DATA);
 
-	if (!PAGE_ALIGNED(md->phys_addr) ||
-	    !PAGE_ALIGNED(md->num_pages << EFI_PAGE_SHIFT)) {
-		/*
-		 * If the end address of this region is not aligned to page
-		 * size, the mapping is rounded up, and may end up sharing a
-		 * page frame with the next UEFI memory region. If we create
-		 * a block entry now, we may need to split it again when mapping
-		 * the next region, and support for that is going to be removed
-		 * from the MMU routines. So avoid block mappings altogether in
-		 * that case.
-		 */
+	/*
+	 * If this region is not aligned to the page size used by the OS, the
+	 * mapping will be rounded outwards, and may end up sharing a page
+	 * frame with an adjacent runtime memory region. Given that the page
+	 * table descriptor covering the shared page will be rewritten when the
+	 * adjacent region gets mapped, we must avoid block mappings here so we
+	 * don't have to worry about splitting them when that happens.
+	 */
+	if (region_is_misaligned(md))
 		page_mappings_only = true;
-	}
 
 	create_pgd_mapping(mm, md->phys_addr, md->virt_addr,
 			   md->num_pages << EFI_PAGE_SHIFT,
@@ -102,6 +115,9 @@ int __init efi_set_mapping_permissions(struct mm_struct *mm,
 	BUG_ON(md->type != EFI_RUNTIME_SERVICES_CODE &&
 	       md->type != EFI_RUNTIME_SERVICES_DATA);
 
+	if (region_is_misaligned(md))
+		return 0;
+
 	/*
 	 * Calling apply_to_page_range() is only safe on regions that are
 	 * guaranteed to be mapped down to pages. Since we are only called
-- 
2.35.1

Output from a 64k page size kernel build booting via U-boot's EFI
implementation.

Note that the misaligned data regions are not mapped with executable
permissions with this patch applied. The code region is mapped with both
write and execute permissions, but this is unavoidable given that the
region covers statically allocated read-write data as well.

Note that these mappings are only live on a single CPU while a runtime
service call is in progress so none of this is critical in any case.


# cat /sys/kernel/debug/efi_page_tables 
---[ UEFI runtime start ]---
0x0000000000000000-0x00000000e0000000        3584M PMD
0x00000000e0000000-0x00000000ffff0000      524224K PTE
0x00000000ffff0000-0x0000000100000000          64K PTE       RW NX SHD AF NG         UXN    MEM/NORMAL
0x0000000100000000-0x0000000420000000       12800M PMD
0x0000000420000000-0x000000043dd60000      488832K PTE
0x000000043dd60000-0x000000043dd70000          64K PTE       RW NX SHD AF NG         UXN    MEM/NORMAL
0x000000043dd70000-0x000000043ddc0000         320K PTE
0x000000043ddc0000-0x000000043ddd0000          64K PTE       RW NX SHD AF NG         UXN    MEM/NORMAL
0x000000043ddd0000-0x000000043ff10000       34048K PTE
0x000000043ff10000-0x000000043ff20000          64K PTE       RW x  SHD AF NG         UXN    MEM/NORMAL
0x000000043ff20000-0x0000000440000000         896K PTE

efi: Processing EFI memory map:
efi:   0x000040000000-0x000047dfcfff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x000047dfd000-0x000048002fff [ACPI Reclaim|   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x000048003000-0x0000ffffdfff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x0000ffffe000-0x0000ffffefff [Runtime Data|RUN|  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x0000fffff000-0x0001c389ffff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x0001c38a0000-0x0001c73affff [Loader Code |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x0001c73b0000-0x0004368effff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x0004368f0000-0x00043a3fffff [Loader Code |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043a400000-0x00043db4ffff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043db50000-0x00043dd4ffff [Loader Data |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd50000-0x00043dd5bfff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd5c000-0x00043dd5cfff [Loader Data |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd5d000-0x00043dd5dfff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd5e000-0x00043dd5efff [ACPI Reclaim|   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd5f000-0x00043dd5ffff [Loader Data |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd60000-0x00043dd60fff [Runtime Data|RUN|  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd61000-0x00043dd61fff [Loader Data |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd62000-0x00043dd63fff [Boot Data   |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd64000-0x00043dd66fff [Loader Data |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd67000-0x00043dd67fff [Boot Data   |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd68000-0x00043dd97fff [Loader Data |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd98000-0x00043dd98fff [Boot Data   |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd99000-0x00043dd9bfff [Loader Data |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043dd9c000-0x00043ddb5fff [Loader Code |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043ddb6000-0x00043ddc0fff [Boot Data   |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043ddc1000-0x00043ddc1fff [Runtime Data|RUN|  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043ddc2000-0x00043ddc2fff [Boot Data   |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043ddc3000-0x00043ddc4fff [Runtime Data|RUN|  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043ddc5000-0x00043ddc5fff [Boot Data   |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043ddc6000-0x00043ddc9fff [Runtime Data|RUN|  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043ddca000-0x00043ddd2fff [Boot Data   |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043ddd3000-0x00043ff0ffff [Loader Data |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043ff10000-0x00043ff1ffff [Runtime Code|RUN|  |  |  |  |  |  |  |  |   |WB|  |  |  ]
efi:   0x00043ff20000-0x00043fffffff [Loader Data |   |  |  |  |  |  |  |  |  |   |WB|  |  |  ]

