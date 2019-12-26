Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2177912AB71
	for <lists+linux-efi@lfdr.de>; Thu, 26 Dec 2019 10:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLZJzO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Dec 2019 04:55:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfLZJzO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Dec 2019 04:55:14 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C94F82080D;
        Thu, 26 Dec 2019 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577354112;
        bh=7nwMqRrGk2ZEkMZcnwVXh45rtaOV5zuV0TEjXaSmyz8=;
        h=From:To:Cc:Subject:Date:From;
        b=oT0xGHdgoNf4y79ayNmItFWoC2V4e8u3bU4LHcvIXkq+xi4L05+rev5ZoPN5fQyZe
         5G5DaD+VFioS2c/9BqtAShcsCUV1Oeq35n3JghufFgic/gBdT/LCWBsJ/U+FBNXxRe
         LGyBRoDEW3LtWz6l10ThduVw9qKiOeM9n3WrpI1Y=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
Subject: [RFC PATCH] efi/x86: limit EFI old memory map to SGI UV1 machines
Date:   Thu, 26 Dec 2019 10:55:10 +0100
Message-Id: <20191226095510.20017-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
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
all the time if there are no other users. So let's refactor it a bit
to make it depend on CONFIG_X86_UV, and remove the ability to enable
it by hand.

Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Hedi Berriche <hedi.berriche@hpe.com> 
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +---
 arch/x86/include/asm/efi.h                      | 21 ++++++++------
 arch/x86/kernel/kexec-bzimage64.c               |  2 +-
 arch/x86/platform/efi/efi.c                     | 30 ++++----------------
 arch/x86/platform/efi/efi_64.c                  | 18 ++++++------
 arch/x86/platform/efi/quirks.c                  | 11 ++-----
 arch/x86/platform/uv/bios_uv.c                  |  2 +-
 7 files changed, 32 insertions(+), 57 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..fbcf8d1eb3ee 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1164,11 +1164,8 @@
 			Format: {"off" | "on" | "skip[mbr]"}
 
 	efi=		[EFI]
-			Format: { "old_map", "nochunk", "noruntime", "debug",
+			Format: { "nochunk", "noruntime", "debug",
 				  "nosoftreserve" }
-			old_map [X86-64]: switch to the old ioremap-based EFI
-			runtime services mapping. 32-bit still uses this one by
-			default.
 			nochunk: disable reading files in "chunks" in the EFI
 			boot stub, as chunking can cause problems with some
 			firmware implementations.
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 8f4727a8a658..be40110bbee2 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -19,13 +19,16 @@
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
+#define EFI_UV1_MEMMAP		EFI_ARCH_1
+
+static inline bool efi_have_uv1_memmap(void)
+{
+	return IS_ENABLED(CONFIG_X86_UV) && efi_enabled(EFI_UV1_MEMMAP);
+}
 
 #define EFI32_LOADER_SIGNATURE	"EL32"
 #define EFI64_LOADER_SIGNATURE	"EL64"
@@ -75,7 +78,7 @@ struct efi_scratch {
 	kernel_fpu_begin();						\
 	firmware_restrict_branch_speculation_start();			\
 									\
-	if (!efi_enabled(EFI_OLD_MEMMAP))				\
+	if (!efi_have_uv1_memmap())					\
 		efi_switch_mm(&efi_mm);					\
 })
 
@@ -84,7 +87,7 @@ struct efi_scratch {
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
-	if (!efi_enabled(EFI_OLD_MEMMAP))				\
+	if (!efi_have_uv1_memmap())					\
 		efi_switch_mm(efi_scratch.prev_mm);			\
 									\
 	firmware_restrict_branch_speculation_end();			\
@@ -156,7 +159,7 @@ static inline bool efi_runtime_supported(void)
 	if (!efi_is_mixed())
 		return true;
 
-	if (!efi_enabled(EFI_OLD_MEMMAP))
+	if (!efi_have_uv1_memmap())
 		return true;
 
 	return false;
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
index b14b1c1f21bd..cabaf3de3821 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -789,7 +789,7 @@ static inline void *efi_map_next_entry_reverse(void *entry)
  */
 static void *efi_map_next_entry(void *entry)
 {
-	if (!efi_enabled(EFI_OLD_MEMMAP) && efi_enabled(EFI_64BIT)) {
+	if (!efi_have_uv1_memmap() && efi_enabled(EFI_64BIT)) {
 		/*
 		 * Starting in UEFI v2.5 the EFI_PROPERTIES_TABLE
 		 * config table feature requires us to map all entries
@@ -921,11 +921,11 @@ static void __init kexec_enter_virtual_mode(void)
 
 	/*
 	 * We don't do virtual mode, since we don't do runtime services, on
-	 * non-native EFI. With efi=old_map, we don't do runtime services in
+	 * non-native EFI. With UV1 memmap, we don't do runtime services in
 	 * kexec kernel because in the initial boot something else might
 	 * have been mapped at these virtual addresses.
 	 */
-	if (efi_is_mixed() || efi_enabled(EFI_OLD_MEMMAP)) {
+	if (efi_is_mixed() || efi_have_uv1_memmap()) {
 		efi_memmap_unmap();
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
@@ -983,7 +983,7 @@ static void __init kexec_enter_virtual_mode(void)
 
 	efi.set_virtual_address_map = NULL;
 
-	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
+	if (efi_have_uv1_memmap() && (__supported_pte_mask & _PAGE_NX))
 		runtime_code_page_mkexec();
 #endif
 }
@@ -994,13 +994,7 @@ static void __init kexec_enter_virtual_mode(void)
  * has the runtime attribute bit set in its memory descriptor into the
  * efi_pgd page table.
  *
- * The old method which used to update that memory descriptor with the
- * virtual address obtained from ioremap() is still supported when the
- * kernel is booted with efi=old_map on its command line. Same old
- * method enabled the runtime services to be called without having to
- * thunk back into physical mode for every invocation.
- *
- * The new method does a pagetable switch in a preemption-safe manner
+ * This method does a pagetable switch in a preemption-safe manner
  * so that we're in a different address space when calling a runtime
  * function. For function arguments passing we do copy the PUDs of the
  * kernel page table into efi_pgd prior to each call.
@@ -1124,20 +1118,6 @@ void __init efi_enter_virtual_mode(void)
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
index 3690df1d31c6..aed13d68313b 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -82,7 +82,7 @@ pgd_t * __init efi_call_phys_prolog(void)
 	int pgd;
 	int n_pgds, i, j;
 
-	if (!efi_enabled(EFI_OLD_MEMMAP)) {
+	if (!efi_have_uv1_memmap()) {
 		efi_switch_mm(&efi_mm);
 		kernel_fpu_begin();
 		return efi_mm.pgd;
@@ -96,7 +96,7 @@ pgd_t * __init efi_call_phys_prolog(void)
 		return NULL;
 
 	/*
-	 * Build 1:1 identity mapping for efi=old_map usage. Note that
+	 * Build 1:1 identity mapping for UV1 memmap usage. Note that
 	 * PAGE_OFFSET is PGDIR_SIZE aligned when KASLR is disabled, while
 	 * it is PUD_SIZE ALIGNED with KASLR enabled. So for a given physical
 	 * address X, the pud_index(X) != pud_index(__va(X)), we can only copy
@@ -162,7 +162,7 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
 
 	kernel_fpu_end();
 
-	if (!efi_enabled(EFI_OLD_MEMMAP)) {
+	if (!efi_have_uv1_memmap()) {
 		efi_switch_mm(efi_scratch.prev_mm);
 		return;
 	}
@@ -215,7 +215,7 @@ int __init efi_alloc_page_tables(void)
 	pud_t *pud;
 	gfp_t gfp_mask;
 
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		return 0;
 
 	gfp_mask = GFP_KERNEL | __GFP_ZERO;
@@ -256,7 +256,7 @@ void efi_sync_low_kernel_mappings(void)
 	pud_t *pud_k, *pud_efi;
 	pgd_t *efi_pgd = efi_mm.pgd;
 
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		return;
 
 	/*
@@ -350,7 +350,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	unsigned npages;
 	pgd_t *pgd = efi_mm.pgd;
 
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		return 0;
 
 	/*
@@ -438,7 +438,7 @@ void __init efi_map_region(efi_memory_desc_t *md)
 	unsigned long size = md->num_pages << PAGE_SHIFT;
 	u64 pa = md->phys_addr;
 
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		return old_map_region(md);
 
 	/*
@@ -563,7 +563,7 @@ void __init efi_runtime_update_mappings(void)
 {
 	efi_memory_desc_t *md;
 
-	if (efi_enabled(EFI_OLD_MEMMAP)) {
+	if (efi_have_uv1_memmap()) {
 		if (__supported_pte_mask & _PAGE_NX)
 			runtime_code_page_mkexec();
 		return;
@@ -617,7 +617,7 @@ void __init efi_runtime_update_mappings(void)
 void __init efi_dump_pagetable(void)
 {
 #ifdef CONFIG_EFI_PGT_DUMP
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		ptdump_walk_pgd_level(NULL, swapper_pg_dir);
 	else
 		ptdump_walk_pgd_level(NULL, efi_mm.pgd);
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index eb421cb35108..b5ce1c41246b 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -382,12 +382,7 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
 	u64 pa = md->phys_addr;
 	u64 va = md->virt_addr;
 
-	/*
-	 * To Do: Remove this check after adding functionality to unmap EFI boot
-	 * services code/data regions from direct mapping area because
-	 * "efi=old_map" maps EFI regions in swapper_pg_dir.
-	 */
-	if (efi_enabled(EFI_OLD_MEMMAP))
+	if (efi_have_uv1_memmap())
 		return;
 
 	/*
@@ -582,7 +577,7 @@ void __init efi_apply_memmap_quirks(void)
 
 	/* UV2+ BIOS has a fix for this issue.  UV1 still needs the quirk. */
 	if (dmi_check_system(sgi_uv1_dmi))
-		set_bit(EFI_OLD_MEMMAP, &efi.flags);
+		set_bit(EFI_UV1_MEMMAP, &efi.flags);
 }
 
 /*
@@ -720,7 +715,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	/*
 	 * Make sure that an efi runtime service caused the page fault.
 	 * "efi_mm" cannot be used to check if the page fault had occurred
-	 * in the firmware context because efi=old_map doesn't use efi_pgd.
+	 * in the firmware context because UV1 memmap doesn't use efi_pgd.
 	 */
 	if (efi_rts_work.efi_rts_id == EFI_NONE)
 		return;
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 5c0e2eb5d87c..b6c33deb8f0c 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -34,7 +34,7 @@ static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 	 * If EFI_OLD_MEMMAP is set, we need to fall back to using our old EFI
 	 * callback method, which uses efi_call() directly, with the kernel page tables:
 	 */
-	if (unlikely(efi_enabled(EFI_OLD_MEMMAP))) {
+	if (unlikely(efi_enabled(EFI_UV1_MEMMAP))) {
 		kernel_fpu_begin();
 		ret = efi_call((void *)__va(tab->function), (u64)which, a1, a2, a3, a4, a5);
 		kernel_fpu_end();
-- 
2.17.1

