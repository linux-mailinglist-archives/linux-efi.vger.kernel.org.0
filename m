Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2758A139789
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2020 18:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAMRXw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jan 2020 12:23:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgAMRXY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Jan 2020 12:23:24 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8AD321744;
        Mon, 13 Jan 2020 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578936202;
        bh=/w8/5RBb3fzrI55IafbzON7Dyc1dfAqKKNqql/jslUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s3XuXJTbM5jB9pagoaiD0fDeg3LVQUqgF0L94/tn0wNuTjTK6Iv6eT4QkRKAHKbYW
         hZNL7VwMhqLr9B4dW7NtNNlbQ9p+JcoeI1c6W5PYGm6lBgYgyAGxWkkXCX9VpmDNOd
         ANiLPi5nvPDRed7yETXcfskWVUPs0Vo0sOJQU//Y=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 07/13] efi/x86: limit EFI old memory map to SGI UV machines
Date:   Mon, 13 Jan 2020 18:22:39 +0100
Message-Id: <20200113172245.27925-8-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113172245.27925-1-ardb@kernel.org>
References: <20200113172245.27925-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We carry a quirk in the x86 EFI code to switch back to an older
method of mapping the EFI runtime services memory regions, because
it was deemed risky at the time to implement a new method without
providing a fallback to the old method in case problems arose.

Such problems did arise, but they appear to be limited to SGI UV1
machines, and so these are the only ones for which the fallback gets
enabled automatically (via a DMI quirk). The fallback can be enabled
manually as well, by passing efi=old_map, but there is very little
evidence that suggests that this is something that is being relied
upon in the field.

Given that UV1 support is not enabled by default by the distros
(Ubuntu, Fedora), there is no point in carrying this fallback code
all the time if there are no other users. So let's move it into the
UV support code, and document that efi=old_map now requires this
support code to be enabled.

Note that efi=old_map has been used in the past on other SGI UV
machines to work around kernel regressions in production, so we
keep the option to enable it by hand, but only if the kernel was
built with UV support.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |   3 +-
 arch/x86/include/asm/efi.h                    |  26 +--
 arch/x86/kernel/kexec-bzimage64.c             |   2 +-
 arch/x86/platform/efi/efi.c                   |  30 ++--
 arch/x86/platform/efi/efi_64.c                | 166 +-----------------
 arch/x86/platform/efi/quirks.c                |  21 ++-
 arch/x86/platform/uv/bios_uv.c                | 164 ++++++++++++++++-
 7 files changed, 211 insertions(+), 201 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 994632ae48de..e5f043f0342a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1168,8 +1168,7 @@
 				  "nosoftreserve", "disable_early_pci_dma",
 				  "no_disable_early_pci_dma" }
 			old_map [X86-64]: switch to the old ioremap-based EFI
-			runtime services mapping. 32-bit still uses this one by
-			default.
+			runtime services mapping. [Needs CONFIG_X86_UV=y]
 			nochunk: disable reading files in "chunks" in the EFI
 			boot stub, as chunking can cause problems with some
 			firmware implementations.
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 0a58468a7203..86169a24b0d8 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -20,13 +20,16 @@
  * This is the main reason why we're doing stable VA mappings for RT
  * services.
  *
- * This flag is used in conjunction with a chicken bit called
- * "efi=old_map" which can be used as a fallback to the old runtime
- * services mapping method in case there's some b0rkage with a
- * particular EFI implementation (haha, it is hard to hold up the
- * sarcasm here...).
+ * SGI UV1 machines are known to be incompatible with this scheme, so we
+ * provide an opt-out for these machines via a DMI quirk that sets the
+ * attribute below.
  */
-#define EFI_OLD_MEMMAP		EFI_ARCH_1
+#define EFI_UV1_MEMMAP         EFI_ARCH_1
+
+static inline bool efi_have_uv1_memmap(void)
+{
+	return IS_ENABLED(CONFIG_X86_UV) && efi_enabled(EFI_UV1_MEMMAP);
+}
 
 #define EFI32_LOADER_SIGNATURE	"EL32"
 #define EFI64_LOADER_SIGNATURE	"EL64"
@@ -119,7 +122,7 @@ struct efi_scratch {
 	kernel_fpu_begin();						\
 	firmware_restrict_branch_speculation_start();			\
 									\
-	if (!efi_enabled(EFI_OLD_MEMMAP))				\
+	if (!efi_have_uv1_memmap())					\
 		efi_switch_mm(&efi_mm);					\
 })
 
@@ -128,7 +131,7 @@ struct efi_scratch {
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
-	if (!efi_enabled(EFI_OLD_MEMMAP))				\
+	if (!efi_have_uv1_memmap())					\
 		efi_switch_mm(efi_scratch.prev_mm);			\
 									\
 	firmware_restrict_branch_speculation_end();			\
@@ -172,6 +175,8 @@ extern void efi_delete_dummy_variable(void);
 extern void efi_switch_mm(struct mm_struct *mm);
 extern void efi_recover_from_page_fault(unsigned long phys_addr);
 extern void efi_free_boot_services(void);
+extern pgd_t * __init efi_uv1_memmap_phys_prolog(void);
+extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
 
 struct efi_setup_data {
 	u64 fw_vendor;
@@ -203,10 +208,7 @@ static inline bool efi_runtime_supported(void)
 	if (IS_ENABLED(CONFIG_X86_64) == efi_enabled(EFI_64BIT))
 		return true;
 
-	if (IS_ENABLED(CONFIG_EFI_MIXED) && !efi_enabled(EFI_OLD_MEMMAP))
-		return true;
-
-	return false;
+	return IS_ENABLED(CONFIG_EFI_MIXED);
 }
 
 extern void parse_efi_setup(u64 phys_addr, u32 data_len);
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index d2f4e706a428..f293d872602a 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -177,7 +177,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	 * acpi_rsdp=<addr> on kernel command line to make second kernel boot
 	 * without efi.
 	 */
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		return 0;
 
 	params->secure_boot = boot_params.secure_boot;
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index b931c4bea284..4e46d2d24352 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -497,6 +497,8 @@ void __init efi_init(void)
 		efi_print_memmap();
 }
 
+#if defined(CONFIG_X86_32) || defined(CONFIG_X86_UV)
+
 void __init efi_set_executable(efi_memory_desc_t *md, bool executable)
 {
 	u64 addr, npages;
@@ -561,6 +563,8 @@ void __init old_map_region(efi_memory_desc_t *md)
 		       (unsigned long long)md->phys_addr);
 }
 
+#endif
+
 /* Merge contiguous regions of the same type and attribute */
 static void __init efi_merge_regions(void)
 {
@@ -659,7 +663,7 @@ static inline void *efi_map_next_entry_reverse(void *entry)
  */
 static void *efi_map_next_entry(void *entry)
 {
-	if (!efi_enabled(EFI_OLD_MEMMAP) && efi_enabled(EFI_64BIT)) {
+	if (!efi_have_uv1_memmap() && efi_enabled(EFI_64BIT)) {
 		/*
 		 * Starting in UEFI v2.5 the EFI_PROPERTIES_TABLE
 		 * config table feature requires us to map all entries
@@ -791,11 +795,11 @@ static void __init kexec_enter_virtual_mode(void)
 
 	/*
 	 * We don't do virtual mode, since we don't do runtime services, on
-	 * non-native EFI. With efi=old_map, we don't do runtime services in
+	 * non-native EFI. With the UV1 memmap, we don't do runtime services in
 	 * kexec kernel because in the initial boot something else might
 	 * have been mapped at these virtual addresses.
 	 */
-	if (efi_is_mixed() || efi_enabled(EFI_OLD_MEMMAP)) {
+	if (efi_is_mixed() || efi_have_uv1_memmap()) {
 		efi_memmap_unmap();
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
@@ -861,9 +865,9 @@ static void __init kexec_enter_virtual_mode(void)
  *
  * The old method which used to update that memory descriptor with the
  * virtual address obtained from ioremap() is still supported when the
- * kernel is booted with efi=old_map on its command line. Same old
- * method enabled the runtime services to be called without having to
- * thunk back into physical mode for every invocation.
+ * kernel is booted on SG1 UV1 hardware. Same old method enabled the
+ * runtime services to be called without having to thunk back into
+ * physical mode for every invocation.
  *
  * The new method does a pagetable switch in a preemption-safe manner
  * so that we're in a different address space when calling a runtime
@@ -976,20 +980,6 @@ void __init efi_enter_virtual_mode(void)
 	efi_dump_pagetable();
 }
 
-static int __init arch_parse_efi_cmdline(char *str)
-{
-	if (!str) {
-		pr_warn("need at least one option\n");
-		return -EINVAL;
-	}
-
-	if (parse_option_str(str, "old_map"))
-		set_bit(EFI_OLD_MEMMAP, &efi.flags);
-
-	return 0;
-}
-early_param("efi", arch_parse_efi_cmdline);
-
 bool efi_is_table_address(unsigned long phys_addr)
 {
 	unsigned int i;
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 3eb23966e30a..8d1869ff1033 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -57,134 +57,6 @@ static u64 efi_va = EFI_VA_START;
 
 struct efi_scratch efi_scratch;
 
-static void __init early_code_mapping_set_exec(int executable)
-{
-	efi_memory_desc_t *md;
-
-	if (!(__supported_pte_mask & _PAGE_NX))
-		return;
-
-	/* Make EFI service code area executable */
-	for_each_efi_memory_desc(md) {
-		if (md->type == EFI_RUNTIME_SERVICES_CODE ||
-		    md->type == EFI_BOOT_SERVICES_CODE)
-			efi_set_executable(md, executable);
-	}
-}
-
-static void __init efi_old_memmap_phys_epilog(pgd_t *save_pgd);
-
-static pgd_t * __init efi_old_memmap_phys_prolog(void)
-{
-	unsigned long vaddr, addr_pgd, addr_p4d, addr_pud;
-	pgd_t *save_pgd, *pgd_k, *pgd_efi;
-	p4d_t *p4d, *p4d_k, *p4d_efi;
-	pud_t *pud;
-
-	int pgd;
-	int n_pgds, i, j;
-
-	early_code_mapping_set_exec(1);
-
-	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
-	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
-	if (!save_pgd)
-		return NULL;
-
-	/*
-	 * Build 1:1 identity mapping for efi=old_map usage. Note that
-	 * PAGE_OFFSET is PGDIR_SIZE aligned when KASLR is disabled, while
-	 * it is PUD_SIZE ALIGNED with KASLR enabled. So for a given physical
-	 * address X, the pud_index(X) != pud_index(__va(X)), we can only copy
-	 * PUD entry of __va(X) to fill in pud entry of X to build 1:1 mapping.
-	 * This means here we can only reuse the PMD tables of the direct mapping.
-	 */
-	for (pgd = 0; pgd < n_pgds; pgd++) {
-		addr_pgd = (unsigned long)(pgd * PGDIR_SIZE);
-		vaddr = (unsigned long)__va(pgd * PGDIR_SIZE);
-		pgd_efi = pgd_offset_k(addr_pgd);
-		save_pgd[pgd] = *pgd_efi;
-
-		p4d = p4d_alloc(&init_mm, pgd_efi, addr_pgd);
-		if (!p4d) {
-			pr_err("Failed to allocate p4d table!\n");
-			goto out;
-		}
-
-		for (i = 0; i < PTRS_PER_P4D; i++) {
-			addr_p4d = addr_pgd + i * P4D_SIZE;
-			p4d_efi = p4d + p4d_index(addr_p4d);
-
-			pud = pud_alloc(&init_mm, p4d_efi, addr_p4d);
-			if (!pud) {
-				pr_err("Failed to allocate pud table!\n");
-				goto out;
-			}
-
-			for (j = 0; j < PTRS_PER_PUD; j++) {
-				addr_pud = addr_p4d + j * PUD_SIZE;
-
-				if (addr_pud > (max_pfn << PAGE_SHIFT))
-					break;
-
-				vaddr = (unsigned long)__va(addr_pud);
-
-				pgd_k = pgd_offset_k(vaddr);
-				p4d_k = p4d_offset(pgd_k, vaddr);
-				pud[j] = *pud_offset(p4d_k, vaddr);
-			}
-		}
-		pgd_offset_k(pgd * PGDIR_SIZE)->pgd &= ~_PAGE_NX;
-	}
-
-	__flush_tlb_all();
-	return save_pgd;
-out:
-	efi_old_memmap_phys_epilog(save_pgd);
-	return NULL;
-}
-
-static void __init efi_old_memmap_phys_epilog(pgd_t *save_pgd)
-{
-	/*
-	 * After the lock is released, the original page table is restored.
-	 */
-	int pgd_idx, i;
-	int nr_pgds;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-
-	nr_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT) , PGDIR_SIZE);
-
-	for (pgd_idx = 0; pgd_idx < nr_pgds; pgd_idx++) {
-		pgd = pgd_offset_k(pgd_idx * PGDIR_SIZE);
-		set_pgd(pgd_offset_k(pgd_idx * PGDIR_SIZE), save_pgd[pgd_idx]);
-
-		if (!pgd_present(*pgd))
-			continue;
-
-		for (i = 0; i < PTRS_PER_P4D; i++) {
-			p4d = p4d_offset(pgd,
-					 pgd_idx * PGDIR_SIZE + i * P4D_SIZE);
-
-			if (!p4d_present(*p4d))
-				continue;
-
-			pud = (pud_t *)p4d_page_vaddr(*p4d);
-			pud_free(&init_mm, pud);
-		}
-
-		p4d = (p4d_t *)pgd_page_vaddr(*pgd);
-		p4d_free(&init_mm, p4d);
-	}
-
-	kfree(save_pgd);
-
-	__flush_tlb_all();
-	early_code_mapping_set_exec(0);
-}
-
 EXPORT_SYMBOL_GPL(efi_mm);
 
 /*
@@ -203,7 +75,7 @@ int __init efi_alloc_page_tables(void)
 	pud_t *pud;
 	gfp_t gfp_mask;
 
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		return 0;
 
 	gfp_mask = GFP_KERNEL | __GFP_ZERO;
@@ -244,7 +116,7 @@ void efi_sync_low_kernel_mappings(void)
 	pud_t *pud_k, *pud_efi;
 	pgd_t *efi_pgd = efi_mm.pgd;
 
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		return;
 
 	/*
@@ -338,7 +210,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	unsigned npages;
 	pgd_t *pgd = efi_mm.pgd;
 
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		return 0;
 
 	/*
@@ -439,7 +311,7 @@ void __init efi_map_region(efi_memory_desc_t *md)
 	unsigned long size = md->num_pages << PAGE_SHIFT;
 	u64 pa = md->phys_addr;
 
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		return old_map_region(md);
 
 	/*
@@ -496,26 +368,6 @@ void __init efi_map_region_fixed(efi_memory_desc_t *md)
 	__map_region(md, md->virt_addr);
 }
 
-void __iomem *__init efi_ioremap(unsigned long phys_addr, unsigned long size,
-				 u32 type, u64 attribute)
-{
-	unsigned long last_map_pfn;
-
-	if (type == EFI_MEMORY_MAPPED_IO)
-		return ioremap(phys_addr, size);
-
-	last_map_pfn = init_memory_mapping(phys_addr, phys_addr + size);
-	if ((last_map_pfn << PAGE_SHIFT) < phys_addr + size) {
-		unsigned long top = last_map_pfn << PAGE_SHIFT;
-		efi_ioremap(top, size - (top - phys_addr), type, attribute);
-	}
-
-	if (!(attribute & EFI_MEMORY_WB))
-		efi_memory_uc((u64)(unsigned long)__va(phys_addr), size);
-
-	return (void __iomem *)__va(phys_addr);
-}
-
 void __init parse_efi_setup(u64 phys_addr, u32 data_len)
 {
 	efi_setup = phys_addr + sizeof(struct setup_data);
@@ -564,7 +416,7 @@ void __init efi_runtime_update_mappings(void)
 {
 	efi_memory_desc_t *md;
 
-	if (efi_enabled(EFI_OLD_MEMMAP)) {
+	if (efi_have_uv1_memmap()) {
 		if (__supported_pte_mask & _PAGE_NX)
 			runtime_code_page_mkexec();
 		return;
@@ -618,7 +470,7 @@ void __init efi_runtime_update_mappings(void)
 void __init efi_dump_pagetable(void)
 {
 #ifdef CONFIG_EFI_PGT_DUMP
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		ptdump_walk_pgd_level(NULL, swapper_pg_dir);
 	else
 		ptdump_walk_pgd_level(NULL, efi_mm.pgd);
@@ -1045,8 +897,8 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 							 descriptor_version,
 							 virtual_map);
 
-	if (efi_enabled(EFI_OLD_MEMMAP)) {
-		save_pgd = efi_old_memmap_phys_prolog();
+	if (efi_have_uv1_memmap()) {
+		save_pgd = efi_uv1_memmap_phys_prolog();
 		if (!save_pgd)
 			return EFI_ABORTED;
 	} else {
@@ -1065,7 +917,7 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 	kernel_fpu_end();
 
 	if (save_pgd)
-		efi_old_memmap_phys_epilog(save_pgd);
+		efi_uv1_memmap_phys_epilog(save_pgd);
 	else
 		efi_switch_mm(efi_scratch.prev_mm);
 
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index eb421cb35108..fe46ddf6c761 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -384,10 +384,10 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
 
 	/*
 	 * To Do: Remove this check after adding functionality to unmap EFI boot
-	 * services code/data regions from direct mapping area because
-	 * "efi=old_map" maps EFI regions in swapper_pg_dir.
+	 * services code/data regions from direct mapping area because the UV1
+	 * memory map maps EFI regions in swapper_pg_dir.
 	 */
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		return;
 
 	/*
@@ -558,7 +558,7 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
 	return ret;
 }
 
-static const struct dmi_system_id sgi_uv1_dmi[] = {
+static const struct dmi_system_id sgi_uv1_dmi[] __initconst = {
 	{ NULL, "SGI UV1",
 		{	DMI_MATCH(DMI_PRODUCT_NAME,	"Stoutland Platform"),
 			DMI_MATCH(DMI_PRODUCT_VERSION,	"1.0"),
@@ -581,8 +581,15 @@ void __init efi_apply_memmap_quirks(void)
 	}
 
 	/* UV2+ BIOS has a fix for this issue.  UV1 still needs the quirk. */
-	if (dmi_check_system(sgi_uv1_dmi))
-		set_bit(EFI_OLD_MEMMAP, &efi.flags);
+	if (dmi_check_system(sgi_uv1_dmi)) {
+		if (IS_ENABLED(CONFIG_X86_UV)) {
+			set_bit(EFI_UV1_MEMMAP, &efi.flags);
+		} else {
+			pr_warn("EFI runtime disabled, needs CONFIG_X86_UV=y on UV1\n");
+			clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+			efi_memmap_unmap();
+		}
+	}
 }
 
 /*
@@ -720,7 +727,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	/*
 	 * Make sure that an efi runtime service caused the page fault.
 	 * "efi_mm" cannot be used to check if the page fault had occurred
-	 * in the firmware context because efi=old_map doesn't use efi_pgd.
+	 * in the firmware context because the UV1 memmap doesn't use efi_pgd.
 	 */
 	if (efi_rts_work.efi_rts_id == EFI_NONE)
 		return;
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 5c0e2eb5d87c..7c2b8c5d0b49 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -31,10 +31,10 @@ static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 		return BIOS_STATUS_UNIMPLEMENTED;
 
 	/*
-	 * If EFI_OLD_MEMMAP is set, we need to fall back to using our old EFI
+	 * If EFI_UV1_MEMMAP is set, we need to fall back to using our old EFI
 	 * callback method, which uses efi_call() directly, with the kernel page tables:
 	 */
-	if (unlikely(efi_enabled(EFI_OLD_MEMMAP))) {
+	if (unlikely(efi_enabled(EFI_UV1_MEMMAP))) {
 		kernel_fpu_begin();
 		ret = efi_call((void *)__va(tab->function), (u64)which, a1, a2, a3, a4, a5);
 		kernel_fpu_end();
@@ -217,3 +217,163 @@ int uv_bios_init(void)
 	pr_info("UV: UVsystab: Revision:%x\n", uv_systab->revision);
 	return 0;
 }
+
+static void __init early_code_mapping_set_exec(int executable)
+{
+	efi_memory_desc_t *md;
+
+	if (!(__supported_pte_mask & _PAGE_NX))
+		return;
+
+	/* Make EFI service code area executable */
+	for_each_efi_memory_desc(md) {
+		if (md->type == EFI_RUNTIME_SERVICES_CODE ||
+		    md->type == EFI_BOOT_SERVICES_CODE)
+			efi_set_executable(md, executable);
+	}
+}
+
+void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd)
+{
+	/*
+	 * After the lock is released, the original page table is restored.
+	 */
+	int pgd_idx, i;
+	int nr_pgds;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+
+	nr_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT) , PGDIR_SIZE);
+
+	for (pgd_idx = 0; pgd_idx < nr_pgds; pgd_idx++) {
+		pgd = pgd_offset_k(pgd_idx * PGDIR_SIZE);
+		set_pgd(pgd_offset_k(pgd_idx * PGDIR_SIZE), save_pgd[pgd_idx]);
+
+		if (!pgd_present(*pgd))
+			continue;
+
+		for (i = 0; i < PTRS_PER_P4D; i++) {
+			p4d = p4d_offset(pgd,
+					 pgd_idx * PGDIR_SIZE + i * P4D_SIZE);
+
+			if (!p4d_present(*p4d))
+				continue;
+
+			pud = (pud_t *)p4d_page_vaddr(*p4d);
+			pud_free(&init_mm, pud);
+		}
+
+		p4d = (p4d_t *)pgd_page_vaddr(*pgd);
+		p4d_free(&init_mm, p4d);
+	}
+
+	kfree(save_pgd);
+
+	__flush_tlb_all();
+	early_code_mapping_set_exec(0);
+}
+
+pgd_t * __init efi_uv1_memmap_phys_prolog(void)
+{
+	unsigned long vaddr, addr_pgd, addr_p4d, addr_pud;
+	pgd_t *save_pgd, *pgd_k, *pgd_efi;
+	p4d_t *p4d, *p4d_k, *p4d_efi;
+	pud_t *pud;
+
+	int pgd;
+	int n_pgds, i, j;
+
+	early_code_mapping_set_exec(1);
+
+	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
+	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
+	if (!save_pgd)
+		return NULL;
+
+	/*
+	 * Build 1:1 identity mapping for UV1 memmap usage. Note that
+	 * PAGE_OFFSET is PGDIR_SIZE aligned when KASLR is disabled, while
+	 * it is PUD_SIZE ALIGNED with KASLR enabled. So for a given physical
+	 * address X, the pud_index(X) != pud_index(__va(X)), we can only copy
+	 * PUD entry of __va(X) to fill in pud entry of X to build 1:1 mapping.
+	 * This means here we can only reuse the PMD tables of the direct mapping.
+	 */
+	for (pgd = 0; pgd < n_pgds; pgd++) {
+		addr_pgd = (unsigned long)(pgd * PGDIR_SIZE);
+		vaddr = (unsigned long)__va(pgd * PGDIR_SIZE);
+		pgd_efi = pgd_offset_k(addr_pgd);
+		save_pgd[pgd] = *pgd_efi;
+
+		p4d = p4d_alloc(&init_mm, pgd_efi, addr_pgd);
+		if (!p4d) {
+			pr_err("Failed to allocate p4d table!\n");
+			goto out;
+		}
+
+		for (i = 0; i < PTRS_PER_P4D; i++) {
+			addr_p4d = addr_pgd + i * P4D_SIZE;
+			p4d_efi = p4d + p4d_index(addr_p4d);
+
+			pud = pud_alloc(&init_mm, p4d_efi, addr_p4d);
+			if (!pud) {
+				pr_err("Failed to allocate pud table!\n");
+				goto out;
+			}
+
+			for (j = 0; j < PTRS_PER_PUD; j++) {
+				addr_pud = addr_p4d + j * PUD_SIZE;
+
+				if (addr_pud > (max_pfn << PAGE_SHIFT))
+					break;
+
+				vaddr = (unsigned long)__va(addr_pud);
+
+				pgd_k = pgd_offset_k(vaddr);
+				p4d_k = p4d_offset(pgd_k, vaddr);
+				pud[j] = *pud_offset(p4d_k, vaddr);
+			}
+		}
+		pgd_offset_k(pgd * PGDIR_SIZE)->pgd &= ~_PAGE_NX;
+	}
+
+	__flush_tlb_all();
+	return save_pgd;
+out:
+	efi_uv1_memmap_phys_epilog(save_pgd);
+	return NULL;
+}
+
+void __iomem *__init efi_ioremap(unsigned long phys_addr, unsigned long size,
+				 u32 type, u64 attribute)
+{
+	unsigned long last_map_pfn;
+
+	if (type == EFI_MEMORY_MAPPED_IO)
+		return ioremap(phys_addr, size);
+
+	last_map_pfn = init_memory_mapping(phys_addr, phys_addr + size);
+	if ((last_map_pfn << PAGE_SHIFT) < phys_addr + size) {
+		unsigned long top = last_map_pfn << PAGE_SHIFT;
+		efi_ioremap(top, size - (top - phys_addr), type, attribute);
+	}
+
+	if (!(attribute & EFI_MEMORY_WB))
+		efi_memory_uc((u64)(unsigned long)__va(phys_addr), size);
+
+	return (void __iomem *)__va(phys_addr);
+}
+
+static int __init arch_parse_efi_cmdline(char *str)
+{
+	if (!str) {
+		pr_warn("need at least one option\n");
+		return -EINVAL;
+	}
+
+	if (parse_option_str(str, "old_map"))
+		set_bit(EFI_UV1_MEMMAP, &efi.flags);
+
+	return 0;
+}
+early_param("efi", arch_parse_efi_cmdline);
-- 
2.20.1

