Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284D512F791
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgACLkc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgACLkb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:31 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA09524650;
        Fri,  3 Jan 2020 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051630;
        bh=lYUfQEsb2sfLYHb6SW9R5l7XM17hhCTRql1Wy9aMfxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibY/VsxGSoe0krM3fpAyKrhSGOTZa/kF7b5THb1suLXA0SQtnV2pnAXpF3zWPCDCw
         HQ20uN/VmKy1yOOJzAUqE+J8NSIh9Nuxwe0KAfqdz4naeNB2gmZrIwceYeHI1/DiY8
         QAsq4XbUSXbddbnORP0+IuJCWbPraAdXWXIypunY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 07/20] efi/x86: split SetVirtualAddresMap() wrappers into 32 and 64 bit versions
Date:   Fri,  3 Jan 2020 12:39:40 +0100
Message-Id: <20200103113953.9571-8-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Split the phys_efi_set_virtual_address_map() routine into 32 and 64 bit
versions, so we can simplify them individually in subsequent patches.

There is very little overlap between the logic anyway, and this has
already been factored out in prolog/epilog routines which are completely
different between 32 bit and 64 bit. So let's take it one step further,
and get rid of the overlap completely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     |  8 ++---
 arch/x86/platform/efi/efi.c    | 30 ++----------------
 arch/x86/platform/efi/efi_32.c | 21 ++++++++++---
 arch/x86/platform/efi/efi_64.c | 56 ++++++++++++++++++++++------------
 4 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 09c3fc468793..e29e5dc0b750 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -61,8 +61,6 @@ extern asmlinkage unsigned long efi_call_phys(void *, ...);
 
 extern asmlinkage u64 efi_call(void *fp, ...);
 
-#define efi_call_phys(f, args...)		efi_call((f), args)
-
 /*
  * struct efi_scratch - Scratch space used while switching to/from efi_mm
  * @phys_stack: stack used during EFI Mixed Mode
@@ -115,8 +113,6 @@ extern void __iomem *__init efi_ioremap(unsigned long addr, unsigned long size,
 extern struct efi_scratch efi_scratch;
 extern void __init efi_set_executable(efi_memory_desc_t *md, bool executable);
 extern int __init efi_memblock_x86_reserve_range(void);
-extern pgd_t * __init efi_call_phys_prolog(void);
-extern void __init efi_call_phys_epilog(pgd_t *save_pgd);
 extern void __init efi_print_memmap(void);
 extern void __init efi_memory_uc(u64 addr, unsigned long size);
 extern void __init efi_map_region(efi_memory_desc_t *md);
@@ -177,6 +173,10 @@ extern efi_status_t efi_thunk_set_virtual_address_map(
 	unsigned long descriptor_size,
 	u32 descriptor_version,
 	efi_memory_desc_t *virtual_map);
+efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
+					 unsigned long descriptor_size,
+					 u32 descriptor_version,
+					 efi_memory_desc_t *virtual_map);
 
 /* arch specific definitions used by the stub code */
 
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 3ce32c31bb61..50f8123e658a 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -54,7 +54,7 @@
 #include <asm/x86_init.h>
 #include <asm/uv/uv.h>
 
-static struct efi efi_phys __initdata;
+struct efi efi_phys __initdata;
 static efi_system_table_t efi_systab __initdata;
 
 static efi_config_table_type_t arch_tables[] __initdata = {
@@ -97,32 +97,6 @@ static int __init setup_add_efi_memmap(char *arg)
 }
 early_param("add_efi_memmap", setup_add_efi_memmap);
 
-static efi_status_t __init phys_efi_set_virtual_address_map(
-	unsigned long memory_map_size,
-	unsigned long descriptor_size,
-	u32 descriptor_version,
-	efi_memory_desc_t *virtual_map)
-{
-	efi_status_t status;
-	unsigned long flags;
-	pgd_t *save_pgd;
-
-	save_pgd = efi_call_phys_prolog();
-	if (!save_pgd)
-		return EFI_ABORTED;
-
-	/* Disable interrupts around EFI calls: */
-	local_irq_save(flags);
-	status = efi_call_phys(efi_phys.set_virtual_address_map,
-			       memory_map_size, descriptor_size,
-			       descriptor_version, virtual_map);
-	local_irq_restore(flags);
-
-	efi_call_phys_epilog(save_pgd);
-
-	return status;
-}
-
 void __init efi_find_mirror(void)
 {
 	efi_memory_desc_t *md;
@@ -1042,7 +1016,7 @@ static void __init __efi_enter_virtual_mode(void)
 	efi_sync_low_kernel_mappings();
 
 	if (!efi_is_mixed()) {
-		status = phys_efi_set_virtual_address_map(
+		status = efi_set_virtual_address_map(
 				efi.memmap.desc_size * count,
 				efi.memmap.desc_size,
 				efi.memmap.desc_version,
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 9959657127f4..185950ade0e9 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -66,9 +66,16 @@ void __init efi_map_region(efi_memory_desc_t *md)
 void __init efi_map_region_fixed(efi_memory_desc_t *md) {}
 void __init parse_efi_setup(u64 phys_addr, u32 data_len) {}
 
-pgd_t * __init efi_call_phys_prolog(void)
+extern struct efi efi_phys;
+
+efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
+						unsigned long descriptor_size,
+						u32 descriptor_version,
+						efi_memory_desc_t *virtual_map)
 {
 	struct desc_ptr gdt_descr;
+	efi_status_t status;
+	unsigned long flags;
 	pgd_t *save_pgd;
 
 	/* Current pgd is swapper_pg_dir, we'll restore it later: */
@@ -80,14 +87,18 @@ pgd_t * __init efi_call_phys_prolog(void)
 	gdt_descr.size = GDT_SIZE - 1;
 	load_gdt(&gdt_descr);
 
-	return save_pgd;
-}
+	/* Disable interrupts around EFI calls: */
+	local_irq_save(flags);
+	status = efi_call_phys(efi_phys.set_virtual_address_map,
+			       memory_map_size, descriptor_size,
+			       descriptor_version, virtual_map);
+	local_irq_restore(flags);
 
-void __init efi_call_phys_epilog(pgd_t *save_pgd)
-{
 	load_fixmap_gdt(0);
 	load_cr3(save_pgd);
 	__flush_tlb_all();
+
+	return status;
 }
 
 void __init efi_runtime_update_mappings(void)
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index a72bbabbc595..a7f11d1ff7c4 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -72,9 +72,9 @@ static void __init early_code_mapping_set_exec(int executable)
 	}
 }
 
-void __init efi_old_memmap_phys_epilog(pgd_t *save_pgd);
+static void __init efi_old_memmap_phys_epilog(pgd_t *save_pgd);
 
-pgd_t * __init efi_old_memmap_phys_prolog(void)
+static pgd_t * __init efi_old_memmap_phys_prolog(void)
 {
 	unsigned long vaddr, addr_pgd, addr_p4d, addr_pud;
 	pgd_t *save_pgd, *pgd_k, *pgd_efi;
@@ -144,7 +144,7 @@ pgd_t * __init efi_old_memmap_phys_prolog(void)
 	return NULL;
 }
 
-void __init efi_old_memmap_phys_epilog(pgd_t *save_pgd)
+static void __init efi_old_memmap_phys_epilog(pgd_t *save_pgd)
 {
 	/*
 	 * After the lock is released, the original page table is restored.
@@ -185,23 +185,6 @@ void __init efi_old_memmap_phys_epilog(pgd_t *save_pgd)
 	early_code_mapping_set_exec(0);
 }
 
-pgd_t * __init efi_call_phys_prolog(void)
-{
-	if (efi_enabled(EFI_OLD_MEMMAP))
-		return efi_old_memmap_phys_prolog();
-
-	efi_switch_mm(&efi_mm);
-	return efi_mm.pgd;
-}
-
-void __init efi_call_phys_epilog(pgd_t *save_pgd)
-{
-	if (efi_enabled(EFI_OLD_MEMMAP))
-		efi_old_memmap_phys_epilog(save_pgd);
-	else
-		efi_switch_mm(efi_scratch.prev_mm);
-}
-
 EXPORT_SYMBOL_GPL(efi_mm);
 
 /*
@@ -1018,3 +1001,36 @@ void efi_thunk_runtime_setup(void)
 	efi.query_capsule_caps = efi_thunk_query_capsule_caps;
 }
 #endif /* CONFIG_EFI_MIXED */
+
+efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
+						unsigned long descriptor_size,
+						u32 descriptor_version,
+						efi_memory_desc_t *virtual_map)
+{
+	efi_status_t status;
+	unsigned long flags;
+	pgd_t *save_pgd = NULL;
+
+	if (efi_enabled(EFI_OLD_MEMMAP)) {
+		save_pgd = efi_old_memmap_phys_prolog();
+		if (!save_pgd)
+			return EFI_ABORTED;
+	} else {
+		efi_switch_mm(&efi_mm);
+	}
+
+	/* Disable interrupts around EFI calls: */
+	local_irq_save(flags);
+	status = efi_call(efi.systab->runtime->set_virtual_address_map,
+			  memory_map_size, descriptor_size,
+			  descriptor_version, virtual_map);
+	local_irq_restore(flags);
+
+
+	if (save_pgd)
+		efi_old_memmap_phys_epilog(save_pgd);
+	else
+		efi_switch_mm(efi_scratch.prev_mm);
+
+	return status;
+}
-- 
2.20.1

