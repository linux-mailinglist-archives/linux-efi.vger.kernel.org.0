Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC87F64353D
	for <lists+linux-efi@lfdr.de>; Mon,  5 Dec 2022 21:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiLEUFM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Dec 2022 15:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiLEUFM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Dec 2022 15:05:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475DF1E3E5
        for <linux-efi@vger.kernel.org>; Mon,  5 Dec 2022 12:05:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1472B8120C
        for <linux-efi@vger.kernel.org>; Mon,  5 Dec 2022 20:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCCAC433C1;
        Mon,  5 Dec 2022 20:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670270707;
        bh=Oc39xjpYngzrLZzPeKqSOHCEh0T+bl346k4NirLoWHE=;
        h=From:To:Cc:Subject:Date:From;
        b=HepGbTwgQmBEHqt7cfI8KHwKx4OtxELIiNduPphrd+gOIKMIQiiEmzSsG9x3VutBY
         FYvZN1QF0lCQFaSh1jL1e5/Z7SwI6N2WdOzvfBVts1fTsPb/XwRgr3IlkNfdqDCrtc
         ILCas34cTxsgFrq1T/qiJP/6+0PRyAm7SWr8V0EKmC5IVWWe/BkLwct2cQ5jr1jqw1
         /KqC8pKWjfEVqbKexy0Vn0/1luBCJ2Q1M48viNf8V/3IJsg2J2YsWtVokXsclCYGz1
         6QoC88sNHFwoq7x1ursA3qyjLmo/zSNgVG4UzGsQiB5Z12ACD/dJclLOq1DAC2P+64
         nPstakdE2GsXA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jose Marinho <Jose.Marinho@arm.com>
Subject: [PATCH] arm64: efi: Limit allocations to 48-bit addressable physical region
Date:   Mon,  5 Dec 2022 21:05:00 +0100
Message-Id: <20221205200500.463661-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3897; i=ardb@kernel.org; h=from:subject; bh=Oc39xjpYngzrLZzPeKqSOHCEh0T+bl346k4NirLoWHE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjjk7rORs+EFGXjOWAwQIBPSSMvC2Wfb8HZ2XwWJnq 45Zk1gaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY45O6wAKCRDDTyI5ktmPJLbtC/ 4iG/Wke/VEbD7+F/lRAk3uQew+N2CrySYRnR3m0BN9LJA1oNyOiQLoN+NXxip0h8iZ4xmiAcqoZBz0 fY5Gvffejr2BSbNm/Gf7ik/lHS6Pm3khMDXcWIPMLhrPXUG0zZQiOqpUYfiQv8DV6+OATzKo/abI95 rMkM2udNtQtZ2YgLyvb8SQ5NJJXdAXweTIPclJ88U7e7/aHsUXyhTjfWZOZuwjp4DnNhR+Sy+1lCLi r3oF3/OPqNF+1D4dRCe504a/ioJ5+N768SKQC+aJirzBtsEtBLbxfK9lfYnvAtgjK12LYPhaR+4lTk fgooAd0ETpIaPVt8uu+DWoJFvf3o4LOkC33FwNdKfeOA4Io4pFwHEm9vrZebX8zbdnC5EodRZ6HYi4 FqMH5atwVDp9JdsMBGvLbjEhvNEnFdPtOLpfegTZTnzccDEPclP/0dQQ2bjoRMZaa62V4gfTKI2QPo 0EHxebacLRNjh0TYMPGh7SCLaR9GuQLB0g8E1zxiX5Wxw=
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

The UEFI spec does not mention or reason about the configured size of
the virtual address space at all, but it does mention that all memory
should be identity mapped using a page size of 4 KiB.

This means that a LPA2 capable system that has any system memory outside
of the 48-bit addressable physical range and follows the spec to the
letter may serve page allocation requests from regions of memory that
the kernel cannot access unless it was built with LPA2 support and
enables it at runtime.

So let's ensure that all page allocations are limited to the 48-bit
range.

Cc: Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Cc: Jose Marinho <Jose.Marinho@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h              | 1 +
 drivers/firmware/efi/libstub/alignedmem.c | 2 ++
 drivers/firmware/efi/libstub/arm64-stub.c | 5 +++--
 drivers/firmware/efi/libstub/efistub.h    | 4 ++++
 drivers/firmware/efi/libstub/mem.c        | 2 ++
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 108b115dbf5b7436..7c12e01c2b312e7b 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -92,6 +92,7 @@ static inline unsigned long efi_get_kimg_min_align(void)
 }
 
 #define EFI_ALLOC_ALIGN		SZ_64K
+#define EFI_ALLOC_LIMIT		((1UL << 48) - 1)
 
 /*
  * On ARM systems, virtually remapped UEFI runtime services are set up in two
diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
index 174832661251e846..6b83c492c3b8260d 100644
--- a/drivers/firmware/efi/libstub/alignedmem.c
+++ b/drivers/firmware/efi/libstub/alignedmem.c
@@ -29,6 +29,8 @@ efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
 	efi_status_t status;
 	int slack;
 
+	max = min(max, EFI_ALLOC_LIMIT);
+
 	if (align < EFI_ALLOC_ALIGN)
 		align = EFI_ALLOC_ALIGN;
 
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 7f0aab3a8ab302d6..7327b98d8e3fe961 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -113,10 +113,11 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	if (status != EFI_SUCCESS) {
 		if (!check_image_region((u64)_text, kernel_memsize)) {
 			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
-		} else if (IS_ALIGNED((u64)_text, min_kimg_align)) {
+		} else if (IS_ALIGNED((u64)_text, min_kimg_align) &&
+			   (u64)_end < EFI_ALLOC_LIMIT) {
 			/*
 			 * Just execute from wherever we were loaded by the
-			 * UEFI PE/COFF loader if the alignment is suitable.
+			 * UEFI PE/COFF loader if the placement is suitable.
 			 */
 			*image_addr = (u64)_text;
 			*reserve_size = 0;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index ed405f8d09a83765..5b8f2c411ed82be5 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -29,6 +29,10 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
+#ifndef EFI_ALLOC_LIMIT
+#define EFI_ALLOC_LIMIT		ULONG_MAX
+#endif
+
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern int efi_loglevel;
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 03d147f17185b329..4f1fa302234d880f 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -89,6 +89,8 @@ efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 	efi_physical_addr_t alloc_addr;
 	efi_status_t status;
 
+	max = min(max, EFI_ALLOC_LIMIT);
+
 	if (EFI_ALLOC_ALIGN > EFI_PAGE_SIZE)
 		return efi_allocate_pages_aligned(size, addr, max,
 						  EFI_ALLOC_ALIGN,
-- 
2.35.1

