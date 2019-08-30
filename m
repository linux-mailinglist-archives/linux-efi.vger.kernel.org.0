Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8B0A2C9B
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2019 04:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfH3CHD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Aug 2019 22:07:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:43889 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfH3CHC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 29 Aug 2019 22:07:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 19:07:01 -0700
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; 
   d="scan'208";a="193174461"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 19:07:01 -0700
Subject: [PATCH v5 05/10] x86,
 efi: Add efi_fake_mem support for EFI_MEMORY_SP
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de, rafael.j.wysocki@intel.com
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org
Date:   Thu, 29 Aug 2019 18:52:44 -0700
Message-ID: <156712996407.1616117.11409311856083390862.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
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

The KASLR code that scans the command line looking for user-directed
memory reservations also needs to be updated to consider
"efi_fake_mem=nn@ss:0x40000" requests.

Cc: <x86@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/boot/compressed/kaslr.c    |   46 ++++++++++++++++++++---
 arch/x86/include/asm/efi.h          |    8 ++++
 arch/x86/platform/efi/efi.c         |    2 +
 drivers/firmware/efi/Makefile       |    5 ++-
 drivers/firmware/efi/fake_mem.c     |   24 ++++++------
 drivers/firmware/efi/fake_mem.h     |   10 +++++
 drivers/firmware/efi/x86-fake_mem.c |   69 +++++++++++++++++++++++++++++++++++
 7 files changed, 143 insertions(+), 21 deletions(-)
 create mode 100644 drivers/firmware/efi/fake_mem.h
 create mode 100644 drivers/firmware/efi/x86-fake_mem.c

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 093e84e28b7a..53ed3991f9a8 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -133,8 +133,14 @@ char *skip_spaces(const char *str)
 #include "../../../../lib/ctype.c"
 #include "../../../../lib/cmdline.c"
 
+enum parse_mode {
+	PARSE_MEMMAP,
+	PARSE_EFI,
+};
+
 static int
-parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
+parse_memmap(char *p, unsigned long long *start, unsigned long long *size,
+		enum parse_mode mode)
 {
 	char *oldp;
 
@@ -157,8 +163,33 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
 		*start = memparse(p + 1, &p);
 		return 0;
 	case '@':
-		/* memmap=nn@ss specifies usable region, should be skipped */
-		*size = 0;
+		if (mode == PARSE_MEMMAP) {
+			/*
+			 * memmap=nn@ss specifies usable region, should
+			 * be skipped
+			 */
+			*size = 0;
+		} else {
+			unsigned long long flags;
+
+			/*
+			 * efi_fake_mem=nn@ss:attr the attr specifies
+			 * flags that might imply a soft-reservation.
+			 */
+			*start = memparse(p + 1, &p);
+			if (p && *p == ':') {
+				p++;
+				oldp = p;
+				flags = simple_strtoull(p, &p, 0);
+				if (p == oldp)
+					*size = 0;
+				else if (flags & EFI_MEMORY_SP)
+					return 0;
+				else
+					*size = 0;
+			} else
+				*size = 0;
+		}
 		/* Fall through */
 	default:
 		/*
@@ -173,7 +204,7 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
 	return -EINVAL;
 }
 
-static void mem_avoid_memmap(char *str)
+static void mem_avoid_memmap(enum parse_mode mode, char *str)
 {
 	static int i;
 
@@ -188,7 +219,7 @@ static void mem_avoid_memmap(char *str)
 		if (k)
 			*k++ = 0;
 
-		rc = parse_memmap(str, &start, &size);
+		rc = parse_memmap(str, &start, &size, mode);
 		if (rc < 0)
 			break;
 		str = k;
@@ -239,7 +270,6 @@ static void parse_gb_huge_pages(char *param, char *val)
 	}
 }
 
-
 static void handle_mem_options(void)
 {
 	char *args = (char *)get_cmd_line_ptr();
@@ -272,7 +302,7 @@ static void handle_mem_options(void)
 		}
 
 		if (!strcmp(param, "memmap")) {
-			mem_avoid_memmap(val);
+			mem_avoid_memmap(PARSE_MEMMAP, val);
 		} else if (strstr(param, "hugepages")) {
 			parse_gb_huge_pages(param, val);
 		} else if (!strcmp(param, "mem")) {
@@ -285,6 +315,8 @@ static void handle_mem_options(void)
 				goto out;
 
 			mem_limit = mem_size;
+		} else if (!strcmp(param, "efi_fake_mem")) {
+			mem_avoid_memmap(PARSE_EFI, val);
 		}
 	}
 
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 45f853bce869..d028e9acdf1c 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -263,4 +263,12 @@ static inline void efi_reserve_boot_services(void)
 }
 #endif /* CONFIG_EFI */
 
+#ifdef CONFIG_EFI_FAKE_MEMMAP
+extern void __init efi_fake_memmap_early(void);
+#else
+static inline void efi_fake_memmap_early(void)
+{
+}
+#endif
+
 #endif /* _ASM_X86_EFI_H */
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 9cfb7f1cf25d..ac63e244ae55 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -259,6 +259,8 @@ int __init efi_memblock_x86_reserve_range(void)
 		do_add_efi_memmap(ADD_EFI_SOFT_RESERVED);
 	}
 
+	efi_fake_memmap_early();
+
 	WARN(efi.memmap.desc_version != 1,
 	     "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
 	     efi.memmap.desc_version);
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 4ac2de4dfa72..d7a6db03ea79 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -20,13 +20,16 @@ obj-$(CONFIG_UEFI_CPER)			+= cper.o
 obj-$(CONFIG_EFI_RUNTIME_MAP)		+= runtime-map.o
 obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
 obj-$(CONFIG_EFI_STUB)			+= libstub/
-obj-$(CONFIG_EFI_FAKE_MEMMAP)		+= fake_mem.o
+obj-$(CONFIG_EFI_FAKE_MEMMAP)		+= fake_map.o
 obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
 obj-$(CONFIG_EFI_TEST)			+= test/
 obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
 obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
 obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
 
+fake_map-y				+= fake_mem.o
+fake_map-$(CONFIG_X86)			+= x86-fake_mem.o
+
 arm-obj-$(CONFIG_EFI)			:= arm-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
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
diff --git a/drivers/firmware/efi/x86-fake_mem.c b/drivers/firmware/efi/x86-fake_mem.c
new file mode 100644
index 000000000000..8c369555dafe
--- /dev/null
+++ b/drivers/firmware/efi/x86-fake_mem.c
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
+	if (!efi_enabled(EFI_MEM_SOFT_RESERVE))
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
+					E820_TYPE_SOFT_RESERVED);
+			e820__update_table(e820_table);
+		}
+	}
+}

