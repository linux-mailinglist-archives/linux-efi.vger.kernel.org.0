Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1414A2FBEF3
	for <lists+linux-efi@lfdr.de>; Tue, 19 Jan 2021 19:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbhASS2s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Jan 2021 13:28:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbhASS2m (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 Jan 2021 13:28:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB15E233FE;
        Tue, 19 Jan 2021 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611076235;
        bh=G5kPiaR5o5vrIDp4FM0/mzJ4oL5jJxHJ37HrBP1VCL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsdSg4jO5mzRX/szmu7JswpNYKWdpXntAt2/V3pfNCqt6B07zUTZUjbLruMgQgc0d
         oExMwInoylDuJPmI2ngb8NMtewWuwVWxIMy3EHDfGelbX+Giy96UewJwcL9ryjiMH0
         1xbq9ElpjH1qwItZQCsJ9cWP1QGg08forWPbLzali4Uwpo0z1Gtjfq2pGDGggDNm/i
         QzVKgmt/MgiSBa2fyl9Q1UG+MF+3dncWaSqMsjDjRDn2yepDcoyenO6khbV6A18JPk
         jMPKFp6DCyM+vCH3qgQ2pslERJM7BHRHG16QhHhS3inQGDtcp1FRFfJeBrU0SBr2nX
         eFIJgcWwBzeuQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/2] efi: x86: clean up previous struct mm switching
Date:   Tue, 19 Jan 2021 18:10:21 +0100
Message-Id: <20210119171021.27974-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210119171021.27974-1-ardb@kernel.org>
References: <20210119171021.27974-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI on x86_64 keeps track of the process's MM pointer by storing it
in a global struct called 'efi_scratch', which also used to contain
the mixed mode stack pointer. Let's clean this up a little bit, by
getting rid of the struct, and pushing the mm handling into the
callees entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     | 17 +++++------------
 arch/x86/platform/efi/efi_64.c | 27 +++++++++++++++------------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 5e37e6d63c63..1328b7959b72 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -95,20 +95,12 @@ extern asmlinkage u64 __efi_call(void *fp, ...);
 	__efi_call(__VA_ARGS__);					\
 })
 
-/*
- * struct efi_scratch - Scratch space used while switching to/from efi_mm
- * @prev_mm:    store/restore stolen mm_struct while switching to/from efi_mm
- */
-struct efi_scratch {
-	struct mm_struct	*prev_mm;
-} __packed;
-
 #define arch_efi_call_virt_setup()					\
 ({									\
 	efi_sync_low_kernel_mappings();					\
 	kernel_fpu_begin();						\
 	firmware_restrict_branch_speculation_start();			\
-	efi_switch_mm(&efi_mm);						\
+	efi_enter_mm();							\
 })
 
 #define arch_efi_call_virt(p, f, args...)				\
@@ -116,7 +108,7 @@ struct efi_scratch {
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
-	efi_switch_mm(efi_scratch.prev_mm);				\
+	efi_leave_mm();							\
 	firmware_restrict_branch_speculation_end();			\
 	kernel_fpu_end();						\
 })
@@ -135,7 +127,6 @@ struct efi_scratch {
 
 #endif /* CONFIG_X86_32 */
 
-extern struct efi_scratch efi_scratch;
 extern int __init efi_memblock_x86_reserve_range(void);
 extern void __init efi_print_memmap(void);
 extern void __init efi_map_region(efi_memory_desc_t *md);
@@ -148,10 +139,12 @@ extern void __init efi_dump_pagetable(void);
 extern void __init efi_apply_memmap_quirks(void);
 extern int __init efi_reuse_config(u64 tables, int nr_tables);
 extern void efi_delete_dummy_variable(void);
-extern void efi_switch_mm(struct mm_struct *mm);
 extern void efi_recover_from_page_fault(unsigned long phys_addr);
 extern void efi_free_boot_services(void);
 
+void efi_enter_mm(void);
+void efi_leave_mm(void);
+
 /* kexec external ABI */
 struct efi_setup_data {
 	u64 fw_vendor;
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 1d904181e6a1..62a6c8650773 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -54,10 +54,7 @@
  * 0xffff_ffff_0000_0000 and limit EFI VA mapping space to 64G.
  */
 static u64 efi_va = EFI_VA_START;
-
-struct efi_scratch efi_scratch;
-
-EXPORT_SYMBOL_GPL(efi_mm);
+static struct mm_struct *efi_prev_mm;
 
 /*
  * We need our own copy of the higher levels of the page tables
@@ -481,11 +478,17 @@ void __init efi_dump_pagetable(void)
  * can not change under us.
  * It should be ensured that there are no concurent calls to this function.
  */
-void efi_switch_mm(struct mm_struct *mm)
+void efi_enter_mm(void)
+{
+	efi_prev_mm = current->active_mm;
+	current->active_mm = &efi_mm;
+	switch_mm(efi_prev_mm, &efi_mm, NULL);
+}
+
+void efi_leave_mm(void)
 {
-	efi_scratch.prev_mm = current->active_mm;
-	current->active_mm = mm;
-	switch_mm(efi_scratch.prev_mm, mm, NULL);
+	current->active_mm = efi_prev_mm;
+	switch_mm(&efi_mm, efi_prev_mm, NULL);
 }
 
 static DEFINE_SPINLOCK(efi_runtime_lock);
@@ -549,12 +552,12 @@ efi_thunk_set_virtual_address_map(unsigned long memory_map_size,
 	efi_sync_low_kernel_mappings();
 	local_irq_save(flags);
 
-	efi_switch_mm(&efi_mm);
+	efi_enter_mm();
 
 	status = __efi_thunk(set_virtual_address_map, memory_map_size,
 			     descriptor_size, descriptor_version, virtual_map);
 
-	efi_switch_mm(efi_scratch.prev_mm);
+	efi_leave_mm();
 	local_irq_restore(flags);
 
 	return status;
@@ -848,7 +851,7 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
 							 descriptor_size,
 							 descriptor_version,
 							 virtual_map);
-	efi_switch_mm(&efi_mm);
+	efi_enter_mm();
 
 	kernel_fpu_begin();
 
@@ -864,7 +867,7 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
 	/* grab the virtually remapped EFI runtime services table pointer */
 	efi.runtime = READ_ONCE(systab->runtime);
 
-	efi_switch_mm(efi_scratch.prev_mm);
+	efi_leave_mm();
 
 	return status;
 }
-- 
2.17.1

