Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6364E12BDEA
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 16:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfL1PWF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 10:22:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfL1PWF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 28 Dec 2019 10:22:05 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498F520838;
        Sat, 28 Dec 2019 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577546524;
        bh=BInWfiUHX2x6GGHHhiUJKYH36/MbavfVPwcBASvSYCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfYrE3kRNki7cKkF2TQ8PXWPo+R0jhc66eSo9/nOEOCf7Ce7Wh22mNUSnxy/CNqvv
         Q8yXMH5rISPRRK6i4Q5NsJNjljD++ft0dgZrE88MlTxZzsS6W0UafG3CvysQzGwVUs
         RoCoSujqKKq3nAT6n/z13PiMif5bx6DSdo99ZZvs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6/7] efi/x86: merge two near identical versions of efi_runtime_init()
Date:   Sat, 28 Dec 2019 16:21:08 +0100
Message-Id: <20191228152109.6301-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191228152109.6301-1-ardb@kernel.org>
References: <20191228152109.6301-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The routines efi_runtime_init32() and efi_runtime_init64() are
almost indistinguishable, and the only relevant difference is
the offset in the runtime struct from where to obtain the address
of the SetVirtualAddressMap() routine. Let's collapse them into
one, and get rid of some unnecessary casts by switching to a
native vs mixed distinction instead, reusing the helper from the
EFI stub.

While at it, move the variable where we keep the physical address
of the SetVirtualAddressMap() EFI runtime service out of struct efi,
where it doesn't belong given that we only call it once (if ever)
during early boot.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c    | 83 ++++++--------------
 arch/x86/platform/efi/efi_64.c |  5 ++
 include/linux/efi.h            | 19 -----
 3 files changed, 27 insertions(+), 80 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 3ce32c31bb61..aa6d9438fa89 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -56,6 +56,7 @@
 
 static struct efi efi_phys __initdata;
 static efi_system_table_t efi_systab __initdata;
+static efi_set_virtual_address_map_t __efiapi *set_virtual_address_map __initdata;
 
 static efi_config_table_type_t arch_tables[] __initdata = {
 #ifdef CONFIG_X86_UV
@@ -113,7 +114,7 @@ static efi_status_t __init phys_efi_set_virtual_address_map(
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
-	status = efi_call_phys(efi_phys.set_virtual_address_map,
+	status = efi_call_phys(set_virtual_address_map,
 			       memory_map_size, descriptor_size,
 			       descriptor_version, virtual_map);
 	local_irq_restore(flags);
@@ -455,57 +456,9 @@ static int __init efi_systab_init(void *phys)
 	return 0;
 }
 
-static int __init efi_runtime_init32(void)
-{
-	efi_runtime_services_32_t *runtime;
-
-	runtime = early_memremap((unsigned long)efi.systab->runtime,
-			sizeof(efi_runtime_services_32_t));
-	if (!runtime) {
-		pr_err("Could not map the runtime service table!\n");
-		return -ENOMEM;
-	}
-
-	/*
-	 * We will only need *early* access to the SetVirtualAddressMap
-	 * EFI runtime service. All other runtime services will be called
-	 * via the virtual mapping.
-	 */
-	efi_phys.set_virtual_address_map =
-			(efi_set_virtual_address_map_t *)
-			(unsigned long)runtime->set_virtual_address_map;
-	early_memunmap(runtime, sizeof(efi_runtime_services_32_t));
-
-	return 0;
-}
-
-static int __init efi_runtime_init64(void)
-{
-	efi_runtime_services_64_t *runtime;
-
-	runtime = early_memremap((unsigned long)efi.systab->runtime,
-			sizeof(efi_runtime_services_64_t));
-	if (!runtime) {
-		pr_err("Could not map the runtime service table!\n");
-		return -ENOMEM;
-	}
-
-	/*
-	 * We will only need *early* access to the SetVirtualAddressMap
-	 * EFI runtime service. All other runtime services will be called
-	 * via the virtual mapping.
-	 */
-	efi_phys.set_virtual_address_map =
-			(efi_set_virtual_address_map_t *)
-			(unsigned long)runtime->set_virtual_address_map;
-	early_memunmap(runtime, sizeof(efi_runtime_services_64_t));
-
-	return 0;
-}
-
 static int __init efi_runtime_init(void)
 {
-	int rv;
+	efi_runtime_services_t *runtime;
 
 	/*
 	 * Check out the runtime services table. We need to map
@@ -522,13 +475,25 @@ static int __init efi_runtime_init(void)
 	 */
 
 	if (!efi_enabled(EFI_PARAVIRT)) {
-		if (efi_enabled(EFI_64BIT))
-			rv = efi_runtime_init64();
-		else
-			rv = efi_runtime_init32();
+		int size = !efi_is_mixed() ? sizeof(efi_runtime_services_t)
+					   : sizeof(efi_runtime_services_32_t);
+
+		runtime = early_memremap_ro((unsigned long)efi.systab->runtime,
+					    size);
+		if (!runtime) {
+			pr_err("Could not map the runtime service table!\n");
+			return -ENOMEM;
+		}
 
-		if (rv)
-			return rv;
+		/*
+		 * We will only need *early* access to the SetVirtualAddressMap
+		 * EFI runtime service. All other runtime services will be
+		 * called via the virtual mapping.
+		 */
+		set_virtual_address_map = efi_table_attr(runtime,
+							 set_virtual_address_map);
+
+		early_memunmap(runtime, size);
 	}
 
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
@@ -960,8 +925,6 @@ static void __init kexec_enter_virtual_mode(void)
 
 	efi_native_runtime_setup();
 
-	efi.set_virtual_address_map = NULL;
-
 	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
 		runtime_code_page_mkexec();
 #endif
@@ -1049,7 +1012,7 @@ static void __init __efi_enter_virtual_mode(void)
 				(efi_memory_desc_t *)pa);
 	} else {
 		status = efi_thunk_set_virtual_address_map(
-				efi_phys.set_virtual_address_map,
+				set_virtual_address_map,
 				efi.memmap.desc_size * count,
 				efi.memmap.desc_size,
 				efi.memmap.desc_version,
@@ -1077,8 +1040,6 @@ static void __init __efi_enter_virtual_mode(void)
 	else
 		efi_thunk_runtime_setup();
 
-	efi.set_virtual_address_map = NULL;
-
 	/*
 	 * Apply more restrictive page table mapping attributes now that
 	 * SVAM() has been called and the firmware has performed all
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 03c2ed3c645c..8c4f90eb909e 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -57,6 +57,11 @@ static u64 efi_va = EFI_VA_START;
 
 struct efi_scratch efi_scratch;
 
+__pure bool efi_is_64bit(void)
+{
+	return efi_enabled(EFI_64BIT);
+}
+
 static void __init early_code_mapping_set_exec(int executable)
 {
 	efi_memory_desc_t *md;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 952c1659dfd9..ee68ea6f85ff 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -539,24 +539,6 @@ typedef struct {
 	u32 query_variable_info;
 } efi_runtime_services_32_t;
 
-typedef struct {
-	efi_table_hdr_t hdr;
-	u64 get_time;
-	u64 set_time;
-	u64 get_wakeup_time;
-	u64 set_wakeup_time;
-	u64 set_virtual_address_map;
-	u64 convert_pointer;
-	u64 get_variable;
-	u64 get_next_variable;
-	u64 set_variable;
-	u64 get_next_high_mono_count;
-	u64 reset_system;
-	u64 update_capsule;
-	u64 query_capsule_caps;
-	u64 query_variable_info;
-} efi_runtime_services_64_t;
-
 typedef efi_status_t efi_get_time_t (efi_time_t *tm, efi_time_cap_t *tc);
 typedef efi_status_t efi_set_time_t (efi_time_t *tm);
 typedef efi_status_t efi_get_wakeup_time_t (efi_bool_t *enabled, efi_bool_t *pending,
@@ -946,7 +928,6 @@ extern struct efi {
 	efi_query_capsule_caps_t *query_capsule_caps;
 	efi_get_next_high_mono_count_t *get_next_high_mono_count;
 	efi_reset_system_t *reset_system;
-	efi_set_virtual_address_map_t *set_virtual_address_map;
 	struct efi_memory_map memmap;
 	unsigned long flags;
 } efi;
-- 
2.17.1

