Return-Path: <linux-efi+bounces-701-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A931887003C
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227EF1F24068
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94A39AE1;
	Mon,  4 Mar 2024 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yUvVkDRE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312239AF1
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551241; cv=none; b=CnX/6UhNQe587Tian+prAncgNDdPLa3MjBIHJ8HgFIJ87/2fhS1cjj8kpIksCZYBDOFDsLzzRVzYHm2xDNfsxmgTYe6ZOC70VmY24X0m+UR/2Wus31cHildkYe2cR2wLxeih3pHUsv0uNvzrLOlbC0Z1oGnri4snTfD+P9WfevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551241; c=relaxed/simple;
	bh=iRL6np5k4d+Bf7baxUvZa7p9P2Ly29KLBbODhnqFh2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B2zKQgWJmAkjqJ+SfF/c10ERW8UqAJ7pyWLvTdQqlqI1RAUgRdW2zuQ/gcdQF8SrV+y4so6GubNBJ2LjwlMaDgxx2xO62pDNT5tcDWqVIEUdMQutDErDYzBLqCCUA1IjbPzkpLj0BqfbJ15fVHK+JIt2Z5Xwo/9a9MNlNrLxYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yUvVkDRE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608d6ffc64eso61815677b3.0
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551239; x=1710156039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxFJcYYxv2mnVbKlENPG/29RiTYOkUYXIbV8nHbWhTQ=;
        b=yUvVkDREBuK5o9U5MSna+AzCS/lW2H0efSqM6FgFVwMM9FPzCutCxVTf71HUuEWTH0
         T1gs2d7f4MnobnCRHAGupp0KbgbecYETrdcebMZMSu4E0s0pJitwdYqtrej2azO57Bxk
         TnVGTqnyxUjKWcUnnZiIG7UCeeq76PqTW0fQ/6EXWILu49vKTCR2saVsMli/GA+2OG01
         plEnzH9ApwVDTxBevZMux0gRF77MojEvKwScPbfuJuK5NqrQwi+wtQRFhLyZ3ObImd7S
         /GOwGHC67PxIFlcQbafQhqoUvYzwjAe+jj5cn0FDekd1qGW3pZZakdna0RjYgia+NkOf
         23ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551239; x=1710156039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxFJcYYxv2mnVbKlENPG/29RiTYOkUYXIbV8nHbWhTQ=;
        b=r1axs2T7N6M4PzdX6tuer/P97gYckUFuTh/0x9APm1x0Ve2Ax1/eVgevdDPI73VmsD
         Wo4lt72C9W6TZ5u3ihs89VjPMPlrDk+hc3Ymd2j6FN5pp2hiz7rwraJAbwx0DjgP/6+m
         ltAxqT5MZjQhmnaBiJX3gVNcNp8WjSZkH0q2VFH1yYzvVmVy5NnWQJWQzqn5oqyM/IL8
         R/H3TMIHfRyPXxXbJQ7MUcYtS9yL38EJuWopPrUgilqr2vdKqKXSzXBCoMiN5oS4aCXZ
         Me5BFp+wNpAJLVDeFKamZz5JwNzshiq7TqNfTPuLycHWAkkgBPDQPWhorpfAoEjxzrXK
         3ahg==
X-Gm-Message-State: AOJu0YxDB0hnpg5vT8S6Z8AmEgEdT9CnuKMuYLdMyc5fydD/oKRK9CWz
	ZDjaKw0jkkWGUH9PmJIl70RIXvW5hxF6VNn6PPEmm60Ph2xg20j6XeidTYewjX/UsBz3hQ==
X-Google-Smtp-Source: AGHT+IHM9GIsIo8y1dnzlKk7Xx2DlCLZmKykLs6qNYY4xKYXJECTRHIGBMoCjf8cYzAXCpVkcIGoujOF
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:b720:0:b0:609:3a1f:e852 with SMTP id
 v32-20020a81b720000000b006093a1fe852mr1948331ywh.2.1709551239364; Mon, 04 Mar
 2024 03:20:39 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:47 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=10082; i=ardb@kernel.org;
 h=from:subject; bh=94ckf9ZcKLXEkniML2q2Y3R7jH1pA+me1d1VmFQ4DfQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpumDPhuAVy9idbGs/XxQ0+J+0wXxNVfDmkobGbXO/8
 Ie1aIV2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIkUOjP8j2BaUneBlbv8x5/3
 cxKCDPPLGBY6Hdyx0GTv9nsWigdNXzEyzA1VYuZdkHPlWXs0a9hJ247JV+cXX/vs+GxjxqUrCx9 KsgIA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-29-ardb+git@google.com>
Subject: [PATCH stable-v6.1 09/18] x86/efistub: Perform 4/5 level paging
 switch from the stub
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit cb380000dd23cbbf8bd7d023b51896804c1f7e68 upstream ]

In preparation for updating the EFI stub boot flow to avoid the bare
metal decompressor code altogether, implement the support code for
switching between 4 and 5 levels of paging before jumping to the kernel
proper.

This reuses the newly refactored trampoline that the bare metal
decompressor uses, but relies on EFI APIs to allocate 32-bit addressable
memory and remap it with the appropriate permissions. Given that the
bare metal decompressor will no longer call into the trampoline if the
number of paging levels is already set correctly, it is no longer needed
to remove NX restrictions from the memory range where this trampoline
may end up.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile          |  1 +
 drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +
 drivers/firmware/efi/libstub/efistub.h         |  1 +
 drivers/firmware/efi/libstub/x86-5lvl.c        | 95 ++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c        | 40 +++------
 drivers/firmware/efi/libstub/x86-stub.h        | 17 ++++
 6 files changed, 130 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index b6e1dcb98a64..473ef18421db 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -84,6 +84,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o smbios.o
 lib-$(CONFIG_X86)		+= x86-stub.o
+lib-$(CONFIG_X86_64)		+= x86-5lvl.o
 lib-$(CONFIG_RISCV)		+= riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch-stub.o
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3d9b2469a0df..97744822dd95 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -216,6 +216,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
 		} else if (!strcmp(param, "noinitrd")) {
 			efi_noinitrd = true;
+		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
+			efi_no5lvl = true;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap |= parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 8a343ea1231a..4b4055877f3d 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -33,6 +33,7 @@
 #define EFI_ALLOC_LIMIT		ULONG_MAX
 #endif
 
+extern bool efi_no5lvl;
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern int efi_loglevel;
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
new file mode 100644
index 000000000000..479dd445acdc
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/efi.h>
+
+#include <asm/boot.h>
+#include <asm/desc.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+#include "x86-stub.h"
+
+bool efi_no5lvl;
+
+static void (*la57_toggle)(void *cr3);
+
+static const struct desc_struct gdt[] = {
+	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
+};
+
+/*
+ * Enabling (or disabling) 5 level paging is tricky, because it can only be
+ * done from 32-bit mode with paging disabled. This means not only that the
+ * code itself must be running from 32-bit addressable physical memory, but
+ * also that the root page table must be 32-bit addressable, as programming
+ * a 64-bit value into CR3 when running in 32-bit mode is not supported.
+ */
+efi_status_t efi_setup_5level_paging(void)
+{
+	u8 tmpl_size = (u8 *)&trampoline_ljmp_imm_offset - (u8 *)&trampoline_32bit_src;
+	efi_status_t status;
+	u8 *la57_code;
+
+	if (!efi_is_64bit())
+		return EFI_SUCCESS;
+
+	/* check for 5 level paging support */
+	if (native_cpuid_eax(0) < 7 ||
+	    !(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+		return EFI_SUCCESS;
+
+	/* allocate some 32-bit addressable memory for code and a page table */
+	status = efi_allocate_pages(2 * PAGE_SIZE, (unsigned long *)&la57_code,
+				    U32_MAX);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	la57_toggle = memcpy(la57_code, trampoline_32bit_src, tmpl_size);
+	memset(la57_code + tmpl_size, 0x90, PAGE_SIZE - tmpl_size);
+
+	/*
+	 * To avoid the need to allocate a 32-bit addressable stack, the
+	 * trampoline uses a LJMP instruction to switch back to long mode.
+	 * LJMP takes an absolute destination address, which needs to be
+	 * fixed up at runtime.
+	 */
+	*(u32 *)&la57_code[trampoline_ljmp_imm_offset] += (unsigned long)la57_code;
+
+	efi_adjust_memory_range_protection((unsigned long)la57_toggle, PAGE_SIZE);
+
+	return EFI_SUCCESS;
+}
+
+void efi_5level_switch(void)
+{
+	bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
+	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
+	bool need_toggle = want_la57 ^ have_la57;
+	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
+	u64 *cr3 = (u64 *)__native_read_cr3();
+	u64 *new_cr3;
+
+	if (!la57_toggle || !need_toggle)
+		return;
+
+	if (!have_la57) {
+		/*
+		 * 5 level paging will be enabled, so a root level page needs
+		 * to be allocated from the 32-bit addressable physical region,
+		 * with its first entry referring to the existing hierarchy.
+		 */
+		new_cr3 = memset(pgt, 0, PAGE_SIZE);
+		new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
+	} else {
+		/* take the new root table pointer from the current entry #0 */
+		new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
+
+		/* copy the new root table if it is not 32-bit addressable */
+		if ((u64)new_cr3 > U32_MAX)
+			new_cr3 = memcpy(pgt, new_cr3, PAGE_SIZE);
+	}
+
+	native_load_gdt(&(struct desc_ptr){ sizeof(gdt) - 1, (u64)gdt });
+
+	la57_toggle(new_cr3);
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 764bac6b58f9..adaddd38d97d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -17,6 +17,7 @@
 #include <asm/boot.h>
 
 #include "efistub.h"
+#include "x86-stub.h"
 
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
@@ -212,8 +213,8 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
-static void
-adjust_memory_range_protection(unsigned long start, unsigned long size)
+void efi_adjust_memory_range_protection(unsigned long start,
+					unsigned long size)
 {
 	efi_status_t status;
 	efi_gcd_memory_space_desc_t desc;
@@ -267,35 +268,14 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
 	}
 }
 
-/*
- * Trampoline takes 2 pages and can be loaded in first megabyte of memory
- * with its end placed between 128k and 640k where BIOS might start.
- * (see arch/x86/boot/compressed/pgtable_64.c)
- *
- * We cannot find exact trampoline placement since memory map
- * can be modified by UEFI, and it can alter the computed address.
- */
-
-#define TRAMPOLINE_PLACEMENT_BASE ((128 - 8)*1024)
-#define TRAMPOLINE_PLACEMENT_SIZE (640*1024 - (128 - 8)*1024)
-
 extern const u8 startup_32[], startup_64[];
 
 static void
 setup_memory_protection(unsigned long image_base, unsigned long image_size)
 {
-	/*
-	 * Allow execution of possible trampoline used
-	 * for switching between 4- and 5-level page tables
-	 * and relocated kernel image.
-	 */
-
-	adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
-				       TRAMPOLINE_PLACEMENT_SIZE);
-
 #ifdef CONFIG_64BIT
 	if (image_base != (unsigned long)startup_32)
-		adjust_memory_range_protection(image_base, image_size);
+		efi_adjust_memory_range_protection(image_base, image_size);
 #else
 	/*
 	 * Clear protection flags on a whole range of possible
@@ -305,8 +285,8 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
 	 * need to remove possible protection on relocated image
 	 * itself disregarding further relocations.
 	 */
-	adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
-				       KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
+	efi_adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
+					   KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
 #endif
 }
 
@@ -796,6 +776,12 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		efi_dxe_table = NULL;
 	}
 
+	status = efi_setup_5level_paging();
+	if (status != EFI_SUCCESS) {
+		efi_err("efi_setup_5level_paging() failed!\n");
+		goto fail;
+	}
+
 	/*
 	 * If the kernel isn't already loaded at a suitable address,
 	 * relocate it.
@@ -914,6 +900,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+	efi_5level_switch();
+
 	if (IS_ENABLED(CONFIG_X86_64))
 		bzimage_addr += startup_64 - startup_32;
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h
new file mode 100644
index 000000000000..37c5a36b9d8c
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-stub.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/efi.h>
+
+extern void trampoline_32bit_src(void *, bool);
+extern const u16 trampoline_ljmp_imm_offset;
+
+void efi_adjust_memory_range_protection(unsigned long start,
+					unsigned long size);
+
+#ifdef CONFIG_X86_64
+efi_status_t efi_setup_5level_paging(void);
+void efi_5level_switch(void);
+#else
+static inline efi_status_t efi_setup_5level_paging(void) { return EFI_SUCCESS; }
+static inline void efi_5level_switch(void) {}
+#endif
-- 
2.44.0.278.ge034bb2e1d-goog


