Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B719939602
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 21:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfFGTmC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 15:42:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:15615 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729482AbfFGTmC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 7 Jun 2019 15:42:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 12:42:01 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jun 2019 12:42:01 -0700
Subject: [PATCH v3 06/10] x86,
 efi: Add efi_fake_mem support for EFI_MEMORY_SP
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-nvdimm@lists.01.org,
        x86@kernel.org, linux-efi@vger.kernel.org
Date:   Fri, 07 Jun 2019 12:27:44 -0700
Message-ID: <155993566465.3036719.8735909677370282333.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Given that EFI_MEMORY_SP is platform BIOS policy descision for marking
memory ranges as "reserved for a specific purpose" there will inevitably
be scenarios where the BIOS omits the attribute in situations where it
is desired. Unlike other attributes if the OS wants to reserve this
memory from the kernel the reservation needs to happen early in init. So
early, in fact, that it needs to happen before e820__memblock_setup()
which is a pre-requisite for efi_fake_memmap() that wants to allocate
memory for the updated table.

Introduce an x86 specific efi_fake_memmap_early() that can search for
attempts to set EFI_MEMORY_SP via efi_fake_mem and update the e820 table
accordingly.

Cc: <x86@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/efi.h          |    1 +
 arch/x86/kernel/setup.c             |    1 +
 drivers/firmware/efi/Makefile       |    5 ++-
 drivers/firmware/efi/fake_mem-x86.c |   69 +++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/fake_mem.c     |   24 ++++++------
 drivers/firmware/efi/fake_mem.h     |   10 +++++
 6 files changed, 96 insertions(+), 14 deletions(-)
 create mode 100644 drivers/firmware/efi/fake_mem-x86.c
 create mode 100644 drivers/firmware/efi/fake_mem.h

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index a8a3be68cd61..c154653880c0 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -122,6 +122,7 @@ extern struct efi_scratch efi_scratch;
 extern void __init efi_set_executable(efi_memory_desc_t *md, bool executable);
 extern int __init efi_memblock_x86_reserve_range(void);
 extern void __init efi_find_application_reserved(void);
+extern void __init efi_fake_memmap_early(void);
 extern pgd_t * __init efi_call_phys_prolog(void);
 extern void __init efi_call_phys_epilog(pgd_t *save_pgd);
 extern void __init efi_print_memmap(void);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3b9001b7c951..3a7de6d6f106 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1105,6 +1105,7 @@ void __init setup_arch(char **cmdline_p)
 	memblock_set_current_limit(ISA_END_ADDRESS);
 
 	efi_find_application_reserved();
+	efi_fake_memmap_early();
 	e820__memblock_setup();
 
 	reserve_bios_regions();
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index d2d0d2030620..7518d88ff189 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -20,12 +20,15 @@ obj-$(CONFIG_UEFI_CPER)			+= cper.o
 obj-$(CONFIG_EFI_RUNTIME_MAP)		+= runtime-map.o
 obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
 obj-$(CONFIG_EFI_STUB)			+= libstub/
-obj-$(CONFIG_EFI_FAKE_MEMMAP)		+= fake_mem.o
+obj-$(CONFIG_EFI_FAKE_MEMMAP)		+= fake_map.o
 obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
 obj-$(CONFIG_EFI_TEST)			+= test/
 obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
 obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
 
+fake_map-y				+= fake_mem.o
+fake_map-$(CONFIG_X86)			+= fake_mem-x86.o
+
 arm-obj-$(CONFIG_EFI)			:= arm-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
diff --git a/drivers/firmware/efi/fake_mem-x86.c b/drivers/firmware/efi/fake_mem-x86.c
new file mode 100644
index 000000000000..3e9a80127562
--- /dev/null
+++ b/drivers/firmware/efi/fake_mem-x86.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
+#include <linux/efi.h>
+#include <asm/e820/api.h>
+#include "fake_mem.h"
+
+void __init efi_fake_memmap_early(void)
+{
+	int i;
+
+	/*
+	 * efi_fake_mem() can handle all possibilities if EFI_MEMORY_SP
+	 * is ignored.
+	 */
+	if (!IS_ENABLED(CONFIG_EFI_APPLICATION_RESERVED))
+		return;
+
+	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
+		return;
+
+	/*
+	 * Given that efi_fake_memmap() needs to perform memblock
+	 * allocations it needs to run after e820__memblock_setup().
+	 * However, if efi_fake_mem specifies EFI_MEMORY_SP for a given
+	 * address range that potentially needs to mark the memory as
+	 * reserved prior to e820__memblock_setup(). Update e820
+	 * directly if EFI_MEMORY_SP is specified for an
+	 * EFI_CONVENTIONAL_MEMORY descriptor.
+	 */
+	for (i = 0; i < nr_fake_mem; i++) {
+		struct efi_mem_range *mem = &efi_fake_mems[i];
+		efi_memory_desc_t *md;
+		u64 m_start, m_end;
+
+		if ((mem->attribute & EFI_MEMORY_SP) == 0)
+			continue;
+
+		m_start = mem->range.start;
+		m_end = mem->range.end;
+		for_each_efi_memory_desc(md) {
+			u64 start, end;
+
+			if (md->type != EFI_CONVENTIONAL_MEMORY)
+				continue;
+
+			start = md->phys_addr;
+			end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+			if (m_start <= end && m_end >= start)
+				/* fake range overlaps descriptor */;
+			else
+				continue;
+
+			/*
+			 * Trim the boundary of the e820 update to the
+			 * descriptor in case the fake range overlaps
+			 * !EFI_CONVENTIONAL_MEMORY
+			 */
+			start = max(start, m_start);
+			end = min(end, m_end);
+
+			if (end <= start)
+				continue;
+			e820__range_update(start, end - start + 1, E820_TYPE_RAM,
+					E820_TYPE_APPLICATION_RESERVED);
+			e820__update_table(e820_table);
+		}
+	}
+}
diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index 526b45331d96..bb9fc70d0cfa 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -17,12 +17,10 @@
 #include <linux/memblock.h>
 #include <linux/types.h>
 #include <linux/sort.h>
-#include <asm/efi.h>
+#include "fake_mem.h"
 
-#define EFI_MAX_FAKEMEM CONFIG_EFI_MAX_FAKE_MEM
-
-static struct efi_mem_range fake_mems[EFI_MAX_FAKEMEM];
-static int nr_fake_mem;
+struct efi_mem_range efi_fake_mems[EFI_MAX_FAKEMEM];
+int nr_fake_mem;
 
 static int __init cmp_fake_mem(const void *x1, const void *x2)
 {
@@ -50,7 +48,7 @@ void __init efi_fake_memmap(void)
 	/* count up the number of EFI memory descriptor */
 	for (i = 0; i < nr_fake_mem; i++) {
 		for_each_efi_memory_desc(md) {
-			struct range *r = &fake_mems[i].range;
+			struct range *r = &efi_fake_mems[i].range;
 
 			new_nr_map += efi_memmap_split_count(md, r);
 		}
@@ -70,7 +68,7 @@ void __init efi_fake_memmap(void)
 	}
 
 	for (i = 0; i < nr_fake_mem; i++)
-		efi_memmap_insert(&efi.memmap, new_memmap, &fake_mems[i]);
+		efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
 
 	/* swap into new EFI memmap */
 	early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
@@ -104,22 +102,22 @@ static int __init setup_fake_mem(char *p)
 		if (nr_fake_mem >= EFI_MAX_FAKEMEM)
 			break;
 
-		fake_mems[nr_fake_mem].range.start = start;
-		fake_mems[nr_fake_mem].range.end = start + mem_size - 1;
-		fake_mems[nr_fake_mem].attribute = attribute;
+		efi_fake_mems[nr_fake_mem].range.start = start;
+		efi_fake_mems[nr_fake_mem].range.end = start + mem_size - 1;
+		efi_fake_mems[nr_fake_mem].attribute = attribute;
 		nr_fake_mem++;
 
 		if (*p == ',')
 			p++;
 	}
 
-	sort(fake_mems, nr_fake_mem, sizeof(struct efi_mem_range),
+	sort(efi_fake_mems, nr_fake_mem, sizeof(struct efi_mem_range),
 	     cmp_fake_mem, NULL);
 
 	for (i = 0; i < nr_fake_mem; i++)
 		pr_info("efi_fake_mem: add attr=0x%016llx to [mem 0x%016llx-0x%016llx]",
-			fake_mems[i].attribute, fake_mems[i].range.start,
-			fake_mems[i].range.end);
+			efi_fake_mems[i].attribute, efi_fake_mems[i].range.start,
+			efi_fake_mems[i].range.end);
 
 	return *p == '\0' ? 0 : -EINVAL;
 }
diff --git a/drivers/firmware/efi/fake_mem.h b/drivers/firmware/efi/fake_mem.h
new file mode 100644
index 000000000000..0390be13df96
--- /dev/null
+++ b/drivers/firmware/efi/fake_mem.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __EFI_FAKE_MEM_H__
+#define __EFI_FAKE_MEM_H__
+#include <asm/efi.h>
+
+#define EFI_MAX_FAKEMEM CONFIG_EFI_MAX_FAKE_MEM
+
+extern struct efi_mem_range efi_fake_mems[EFI_MAX_FAKEMEM];
+extern int nr_fake_mem;
+#endif /* __EFI_FAKE_MEM_H__ */

