Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D458F246489
	for <lists+linux-efi@lfdr.de>; Mon, 17 Aug 2020 12:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHQKax (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Aug 2020 06:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgHQKaw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Aug 2020 06:30:52 -0400
Received: from e123331-lin.nice.arm.com (ip-213-127-60-218.ip.prioritytelecom.net [213.127.60.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECDA820786;
        Mon, 17 Aug 2020 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597660252;
        bh=W+xukYTuqlWAX8k+Glou29gp4KBbjVkcGDaCLvgHofw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kScLiQLHqtZJ7v9Y6Cr7n9X9MHqak8KsSud2xtPzq66oCLQzXZYiWGfD8e9m10n2M
         foKtkGwRARTunweg0Mjl7sdMjMIf9cCQ0g59Tu+QGFvFDI+1u9W3tgwujw2XDk1Arx
         bi3SAQAiuSfVhGVEvr+9l7l365heuOCwMZ1iJbps=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/2] efi/x86: Move 32-bit code into efi_32.c
Date:   Mon, 17 Aug 2020 12:30:43 +0200
Message-Id: <20200817103044.12163-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817103044.12163-1-ardb@kernel.org>
References: <20200817103044.12163-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that the old memmap code has been removed, some code that was left
behind in arch/x86/platform/efi/efi.c is only used for 32-bit builds,
which means it can live in efi_32.c as well. So move it over.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     |  4 --
 arch/x86/platform/efi/efi.c    | 69 --------------------
 arch/x86/platform/efi/efi_32.c | 45 +++++++++++--
 3 files changed, 38 insertions(+), 80 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index b9c2667ac46c..cff72f4f64ee 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -143,17 +143,13 @@ extern void __iomem *__init efi_ioremap(unsigned long addr, unsigned long size,
 #endif /* CONFIG_X86_32 */
 
 extern struct efi_scratch efi_scratch;
-extern void __init efi_set_executable(efi_memory_desc_t *md, bool executable);
 extern int __init efi_memblock_x86_reserve_range(void);
 extern void __init efi_print_memmap(void);
-extern void __init efi_memory_uc(u64 addr, unsigned long size);
 extern void __init efi_map_region(efi_memory_desc_t *md);
 extern void __init efi_map_region_fixed(efi_memory_desc_t *md);
 extern void efi_sync_low_kernel_mappings(void);
 extern int __init efi_alloc_page_tables(void);
 extern int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages);
-extern void __init old_map_region(efi_memory_desc_t *md);
-extern void __init runtime_code_page_mkexec(void);
 extern void __init efi_runtime_update_mappings(void);
 extern void __init efi_dump_pagetable(void);
 extern void __init efi_apply_memmap_quirks(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index f6ea8f1a9d57..d37ebe6e70d7 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -49,7 +49,6 @@
 #include <asm/efi.h>
 #include <asm/e820/api.h>
 #include <asm/time.h>
-#include <asm/set_memory.h>
 #include <asm/tlbflush.h>
 #include <asm/x86_init.h>
 #include <asm/uv/uv.h>
@@ -496,74 +495,6 @@ void __init efi_init(void)
 		efi_print_memmap();
 }
 
-#if defined(CONFIG_X86_32)
-
-void __init efi_set_executable(efi_memory_desc_t *md, bool executable)
-{
-	u64 addr, npages;
-
-	addr = md->virt_addr;
-	npages = md->num_pages;
-
-	memrange_efi_to_native(&addr, &npages);
-
-	if (executable)
-		set_memory_x(addr, npages);
-	else
-		set_memory_nx(addr, npages);
-}
-
-void __init runtime_code_page_mkexec(void)
-{
-	efi_memory_desc_t *md;
-
-	/* Make EFI runtime service code area executable */
-	for_each_efi_memory_desc(md) {
-		if (md->type != EFI_RUNTIME_SERVICES_CODE)
-			continue;
-
-		efi_set_executable(md, true);
-	}
-}
-
-void __init efi_memory_uc(u64 addr, unsigned long size)
-{
-	unsigned long page_shift = 1UL << EFI_PAGE_SHIFT;
-	u64 npages;
-
-	npages = round_up(size, page_shift) / page_shift;
-	memrange_efi_to_native(&addr, &npages);
-	set_memory_uc(addr, npages);
-}
-
-void __init old_map_region(efi_memory_desc_t *md)
-{
-	u64 start_pfn, end_pfn, end;
-	unsigned long size;
-	void *va;
-
-	start_pfn = PFN_DOWN(md->phys_addr);
-	size	  = md->num_pages << PAGE_SHIFT;
-	end	  = md->phys_addr + size;
-	end_pfn   = PFN_UP(end);
-
-	if (pfn_range_is_mapped(start_pfn, end_pfn)) {
-		va = __va(md->phys_addr);
-
-		if (!(md->attribute & EFI_MEMORY_WB))
-			efi_memory_uc((u64)(unsigned long)va, size);
-	} else
-		va = efi_ioremap(md->phys_addr, size,
-				 md->type, md->attribute);
-
-	md->virt_addr = (u64) (unsigned long) va;
-	if (!va)
-		pr_err("ioremap of 0x%llX failed!\n",
-		       (unsigned long long)md->phys_addr);
-}
-
-#endif
-
 /* Merge contiguous regions of the same type and attribute */
 static void __init efi_merge_regions(void)
 {
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 826ead67753d..25261a10c596 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -29,9 +29,36 @@
 #include <asm/io.h>
 #include <asm/desc.h>
 #include <asm/page.h>
+#include <asm/set_memory.h>
 #include <asm/tlbflush.h>
 #include <asm/efi.h>
 
+void __init efi_map_region(efi_memory_desc_t *md)
+{
+	u64 start_pfn, end_pfn, end;
+	unsigned long size;
+	void *va;
+
+	start_pfn	= PFN_DOWN(md->phys_addr);
+	size		= md->num_pages << PAGE_SHIFT;
+	end		= md->phys_addr + size;
+	end_pfn 	= PFN_UP(end);
+
+	if (pfn_range_is_mapped(start_pfn, end_pfn)) {
+		va = __va(md->phys_addr);
+
+		if (!(md->attribute & EFI_MEMORY_WB))
+			set_memory_uc((unsigned long)va, md->num_pages);
+	} else {
+		va = efi_ioremap(md->phys_addr, size,
+				 md->type, md->attribute);
+	}
+
+	md->virt_addr = (unsigned long)va;
+	if (!va)
+		pr_err("ioremap of 0x%llX failed!\n", md->phys_addr);
+}
+
 /*
  * To make EFI call EFI runtime service in physical addressing mode we need
  * prolog/epilog before/after the invocation to claim the EFI runtime service
@@ -58,11 +85,6 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	return 0;
 }
 
-void __init efi_map_region(efi_memory_desc_t *md)
-{
-	old_map_region(md);
-}
-
 void __init efi_map_region_fixed(efi_memory_desc_t *md) {}
 void __init parse_efi_setup(u64 phys_addr, u32 data_len) {}
 
@@ -107,6 +129,15 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 
 void __init efi_runtime_update_mappings(void)
 {
-	if (__supported_pte_mask & _PAGE_NX)
-		runtime_code_page_mkexec();
+	if (__supported_pte_mask & _PAGE_NX) {
+		efi_memory_desc_t *md;
+
+		/* Make EFI runtime service code area executable */
+		for_each_efi_memory_desc(md) {
+			if (md->type != EFI_RUNTIME_SERVICES_CODE)
+				continue;
+
+			set_memory_x(md->virt_addr, md->num_pages);
+		}
+	}
 }
-- 
2.17.1

