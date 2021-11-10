Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73F144BF43
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 11:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhKJK7k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 05:59:40 -0500
Received: from mail.ispras.ru ([83.149.199.84]:53932 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231444AbhKJK7i (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 05:59:38 -0500
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3868A40A2BC8;
        Wed, 10 Nov 2021 10:47:02 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/5] libstub: build temporary page table without NX-bit
Date:   Wed, 10 Nov 2021 13:46:11 +0300
Message-Id: <20211110104613.23881-4-baskov@ispras.ru>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110104613.23881-1-baskov@ispras.ru>
References: <20211110104613.23881-1-baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some UEFI implementations restrict execution of memory regions expected
by the kernel to be executable. E.g. first MiB of physical addresses
and memory regions allocated by libstub via efi boot services
as loader data.

Build temporary page table containing address ranges with code execution
allowed required for the kernel to boot on x86_64.

This new page table is set immediately after the return from
efi_main().

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>
---
 drivers/firmware/efi/libstub/Makefile         |   2 +
 .../firmware/efi/libstub/efi-stub-helper.c    |   3 +
 drivers/firmware/efi/libstub/efistub.h        |  10 +
 drivers/firmware/efi/libstub/temp-pgtable.c   | 190 ++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c       |   8 +-
 5 files changed, 211 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/temp-pgtable.c

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..3eb2cfc370f4 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -142,3 +142,5 @@ quiet_cmd_stubcopy = STUBCPY $@
 		/bin/false;						\
 	fi;								\
 	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
+
+lib-$(CONFIG_EFI_STRICT_PGTABLE)	+= temp-pgtable.o
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index d489bdc645fe..ccd6d98753c7 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -23,6 +23,7 @@ bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
 bool efi_noinitrd;
 int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 bool efi_novamap;
+bool efi_temppt = IS_ENABLED(CONFIG_EFI_STRICT_PGTABLE);
 
 static bool efi_nosoftreserve;
 static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
@@ -227,6 +228,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 				efi_disable_pci_dma = true;
 			if (parse_option_str(val, "no_disable_early_pci_dma"))
 				efi_disable_pci_dma = false;
+			if (parse_option_str(val, "notemppt"))
+				efi_temppt = false;
 			if (parse_option_str(val, "debug"))
 				efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
 		} else if (!strcmp(param, "video") &&
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cde0a2ef507d..9e40c486c564 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -34,6 +34,7 @@ extern bool efi_nokaslr;
 extern bool efi_noinitrd;
 extern int efi_loglevel;
 extern bool efi_novamap;
+extern bool efi_temppt;
 
 extern const efi_system_table_t *efi_system_table;
 
@@ -858,4 +859,13 @@ efi_enable_reset_attack_mitigation(void) { }
 
 void efi_retrieve_tpm2_eventlog(void);
 
+#if defined(CONFIG_EFI_STRICT_PGTABLE) && defined(CONFIG_X86_64)
+void efi_build_temp_pgtable(struct boot_params *boot_params,
+			    unsigned long bzimage_addr);
+#else
+static inline void
+efi_build_temp_pgtable(struct boot_params *boot_params,
+		       unsigned long image_base) { }
+#endif
+
 #endif
diff --git a/drivers/firmware/efi/libstub/temp-pgtable.c b/drivers/firmware/efi/libstub/temp-pgtable.c
new file mode 100644
index 000000000000..9fb74f7b2bef
--- /dev/null
+++ b/drivers/firmware/efi/libstub/temp-pgtable.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <linux/stddef.h>
+
+#include <asm/boot.h>
+#include <asm/efi.h>
+#include <asm/init.h>
+#include <asm/setup.h>
+
+#include "efistub.h"
+
+#ifdef CONFIG_X86_64
+
+/*
+ * The top level page table entry pointer.
+ * Used in head_64.S to load temporary page tables
+ */
+
+extern unsigned long efi_temp_pgtable;
+
+#ifdef CONFIG_X86_5LEVEL
+extern unsigned int __pgtable_l5_enabled;
+#else
+unsigned int __pgtable_l5_enabled;
+#endif
+
+void startup_32(struct boot_params *boot_params);
+extern u32 image_offset;
+
+#define TRAMPOLINE_PLACEMENT_MAX 0x100000
+
+/*
+ * Same as in latter boot page table,
+ * but with 5th level and a few extra pages
+ * just to be future proof, since we only store
+ * addresses and not whole pages.
+ */
+#define MAX_TEMP_PAGE_TABLE_PAGES (BOOT_PGT_SIZE+7)
+
+static unsigned long temppt_pages[MAX_TEMP_PAGE_TABLE_PAGES];
+static size_t temppt_page_count;
+
+static void *allocate_pt_page(void *ctx)
+{
+	efi_status_t status;
+	unsigned long res;
+
+	(void)ctx;
+
+	/*
+	 * We need to allocate above 1MB boundary, so
+	 * page table won't be overwritten by trampoline code
+	 */
+	status = efi_low_alloc_above(PAGE_SIZE, PAGE_SIZE,
+				     &res, TRAMPOLINE_PLACEMENT_MAX);
+	if (status != EFI_SUCCESS)
+		return NULL;
+
+	/* Track allocations to free them in error path */
+	if (temppt_page_count < MAX_TEMP_PAGE_TABLE_PAGES) {
+		temppt_pages[temppt_page_count++] = res;
+	} else {
+		efi_warn("Exceeded number of allocated pages\n");
+		efi_free(PAGE_SIZE, res);
+		return NULL;
+	}
+
+	memset((void *)res, 0, PAGE_SIZE);
+
+	return (void *)res;
+}
+
+static int add_identity_map(struct x86_mapping_info *info,
+			    unsigned long start, unsigned long end)
+{
+	/* Align boundary to 2M. */
+	start = round_down(start, PMD_SIZE);
+	end = round_up(end, PMD_SIZE);
+	if (start >= end)
+		return 0;
+
+	/* This function is included into compressed kernel */
+	return kernel_ident_mapping_init(info, (pgd_t *)efi_temp_pgtable,
+					 start, end);
+}
+
+void efi_build_temp_pgtable(struct boot_params *boot_params,
+			    unsigned long bzimage_addr)
+{
+	struct setup_data *it;
+	unsigned long buffer_size, image_addr, buffer_addr;
+	unsigned long cmdline;
+
+	/*
+	 * We need to override this variable to build
+	 * the same amount of page table levels as
+	 * currently used by EFI page tables since
+	 * switching number of page table levels
+	 * is not possible without leaving long mode.
+	 * This variable is used inside kernel_ident_mapping_init().
+	 * (from arch/x86/boot/compressed/ident_map_64.c)
+	 */
+
+	__pgtable_l5_enabled = !!(native_read_cr4() & X86_CR4_LA57);
+
+	image_addr = (unsigned long)&startup_32;
+	buffer_addr = bzimage_addr - image_offset;
+	buffer_size = ALIGN(buffer_addr, boot_params->hdr.kernel_alignment) +
+		boot_params->hdr.init_size + bzimage_addr;
+
+	struct x86_mapping_info info = {
+		.alloc_pgt_page = allocate_pt_page,
+		.page_flag = __PAGE_KERNEL_LARGE_EXEC,
+		.kernpg_flag = _KERNPG_TABLE_NOENC,
+	};
+
+	efi_temp_pgtable = (unsigned long)allocate_pt_page(NULL);
+	if (!efi_temp_pgtable)
+		return;
+
+	/*
+	 * First MiB of memory is used for trampoline placement
+	 * while switching page tables in head_64.S
+	 */
+
+	if (add_identity_map(&info, 0, TRAMPOLINE_PLACEMENT_MAX))
+		goto error;
+
+	/*
+	 * Relocated compressed kernel image and
+	 * buffer for decompression
+	 */
+
+	if (add_identity_map(&info, buffer_addr,
+			     buffer_addr + buffer_size))
+		goto error;
+
+	/*
+	 * Original placement of compressed kernel image
+	 * is  required to be mapped to prevent
+	 * from segfaulting during page table switching
+	 */
+
+	if (image_addr != buffer_addr + image_offset) {
+		if (add_identity_map(&info, image_addr, (unsigned long)_end))
+			goto error;
+	}
+
+	/*
+	 * Boot parameters ("zero page") and kernel command line
+	 * are also used by early boot code
+	 */
+
+	if (add_identity_map(&info, (unsigned long)boot_params,
+			     (unsigned long)(boot_params + 1)))
+		goto error;
+
+	it = (struct setup_data *)boot_params->hdr.setup_data;
+	while (it) {
+		if (add_identity_map(&info, (unsigned long)it,
+				     (unsigned long)sizeof(*it) + it->len))
+			goto error;
+		it = (struct setup_data *)it->next;
+	}
+
+	cmdline = boot_params->hdr.cmd_line_ptr;
+	cmdline |= (u64)boot_params->ext_cmd_line_ptr << 32;
+	if (add_identity_map(&info, cmdline, cmdline + COMMAND_LINE_SIZE))
+		goto error;
+
+	__pgtable_l5_enabled = 0;
+	return;
+
+error:
+	/*
+	 * If an error occurred, we have nothing better to do than
+	 * pretend that nothing happened and leave current
+	 * page table as is.
+	 */
+	__pgtable_l5_enabled = 0;
+	efi_temp_pgtable = 0;
+
+	while (temppt_page_count > 0)
+		efi_free(PAGE_SIZE, temppt_pages[--temppt_page_count]);
+
+	efi_warn("Termporary page table allocation failed\n");
+}
+
+#endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f14c4ff5839f..244b49c8d226 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -622,7 +622,8 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 	return EFI_SUCCESS;
 }
 
-static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
+static efi_status_t exit_boot(struct boot_params *boot_params,
+			      unsigned long bzimage_addr, void *handle)
 {
 	unsigned long map_sz, key, desc_size, buff_size;
 	efi_memory_desc_t *mem_map;
@@ -642,6 +643,9 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	priv.boot_params	= boot_params;
 	priv.efi		= &boot_params->efi_info;
 
+	if (efi_temppt)
+		efi_build_temp_pgtable(boot_params, bzimage_addr);
+
 	status = allocate_e820(boot_params, &e820ext, &e820ext_size);
 	if (status != EFI_SUCCESS)
 		return status;
@@ -799,7 +803,7 @@ unsigned long efi_main(efi_handle_t handle,
 
 	setup_quirks(boot_params);
 
-	status = exit_boot(boot_params, handle);
+	status = exit_boot(boot_params, bzimage_addr, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("exit_boot() failed!\n");
 		goto fail;
-- 
2.33.1

