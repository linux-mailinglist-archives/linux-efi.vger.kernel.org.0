Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1B54A026A
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 21:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbiA1U7J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 15:59:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:32249 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242188AbiA1U7H (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 15:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643403547; x=1674939547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EVxP+tVgUt3Q0kvGKPKUL92rSGKWs6mASPcTJlKaCzI=;
  b=O/RVXqyRA9b4618r751JsSuFwY7iSm+n8y1jFrSYxB6jPHiyq+WqLNu5
   iSBMCfxo4tcB2y84wuWcbIoX5CAEmsYa7QvkHG7wCH3LT1JqqUYLYvhtm
   d7z6GkG0hrrPB+hmmqYeJaqcaxYGXkxLDitEUGLZa68QbizykOq4RAZ0e
   WjPkR9d46WqbWwgLEyOZYbIKkaQUL+LOOxc6ziR1oSPk8yAbYtLCxtGpm
   V5TSJNKcXcbCGdOCPTkFtxlhENeQDHE5V6V7fIwxq1QqL5d3sNZmw4sk3
   iTixpeYNQkkRfKPzpWYDVA3lD/V8kkfaFiQPPl/YLrnwqXtz/OfCWMpIm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="307926110"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="307926110"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 12:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="618832821"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 12:58:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id AC0BE40C; Fri, 28 Jan 2022 22:59:09 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 3/7] efi/x86: Implement support for unaccepted memory
Date:   Fri, 28 Jan 2022 23:59:02 +0300
Message-Id: <20220128205906.27503-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
References: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI Specification version 2.9 introduces the concept of memory
acceptance: Some Virtual Machine platforms, such as Intel TDX or AMD
SEV-SNP, requiring memory to be accepted before it can be used by the
guest. Accepting happens via a protocol specific for the Virtual
Machine platform.

Accepting memory is costly and it makes VMM allocate memory for the
accepted guest physical address range. It's better to postpone memory
acceptance until memory is needed. It lowers boot time and reduces
memory overhead.

The kernel needs to know what memory has been accepted. Firmware
communicates this information via memory map: a new memory type --
EFI_UNACCEPTED_MEMORY -- indicates such memory.

Range-based tracking works fine for firmware, but it gets bulky for
the kernel: e820 has to be modified on every page acceptance. It leads
to table fragmentation, but there's a limited number of entries in the
e820 table

Another option is to mark such memory as usable in e820 and track if the
range has been accepted in a bitmap. One bit in the bitmap represents
2MiB in the address space: one 4k page is enough to track 64GiB or
physical address space.

In the worst-case scenario -- a huge hole in the middle of the
address space -- It needs 256MiB to handle 4PiB of the address
space.

Any unaccepted memory that is not aligned to 2M gets accepted upfront.

The bitmap is allocated and constructed in the EFI stub and passed down
to the kernel via boot_params. allocate_e820() allocates the bitmap if
unaccepted memory is present, according to the maximum address in the
memory map.

The same boot_params.unaccepted_memory can be used to pass the bitmap
between two kernels on kexec, but the use-case is not yet implemented.
Make KEXEC and UNACCEPTED_MEMORY mutually exclusive for now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/x86/zero-page.rst              |  1 +
 arch/x86/boot/compressed/Makefile            |  1 +
 arch/x86/boot/compressed/bitmap.c            | 24 ++++++++
 arch/x86/boot/compressed/unaccepted_memory.c | 53 +++++++++++++++++
 arch/x86/include/asm/unaccepted_memory.h     | 12 ++++
 arch/x86/include/uapi/asm/bootparam.h        |  3 +-
 drivers/firmware/efi/Kconfig                 | 15 +++++
 drivers/firmware/efi/efi.c                   |  1 +
 drivers/firmware/efi/libstub/x86-stub.c      | 62 +++++++++++++++++++-
 include/linux/efi.h                          |  3 +-
 10 files changed, 172 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/boot/compressed/bitmap.c
 create mode 100644 arch/x86/boot/compressed/unaccepted_memory.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h

diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
index f088f5881666..8e3447a4b373 100644
--- a/Documentation/x86/zero-page.rst
+++ b/Documentation/x86/zero-page.rst
@@ -42,4 +42,5 @@ Offset/Size	Proto	Name			Meaning
 2D0/A00		ALL	e820_table		E820 memory map table
 						(array of struct e820_entry)
 D00/1EC		ALL	eddbuf			EDD data (array of struct edd_info)
+ECC/008		ALL	unaccepted_memory	Bitmap of unaccepted memory (1bit == 2M)
 ===========	=====	=======================	=================================================
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 8fd0e6ae2e1f..09993797efa2 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -102,6 +102,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
+vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/unaccepted_memory.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/bitmap.c b/arch/x86/boot/compressed/bitmap.c
new file mode 100644
index 000000000000..bf58b259380a
--- /dev/null
+++ b/arch/x86/boot/compressed/bitmap.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Taken from lib/string.c */
+
+#include <linux/bitmap.h>
+
+void __bitmap_set(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_set >= 0) {
+		*p |= mask_to_set;
+		len -= bits_to_set;
+		bits_to_set = BITS_PER_LONG;
+		mask_to_set = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_set &= BITMAP_LAST_WORD_MASK(size);
+		*p |= mask_to_set;
+	}
+}
diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
new file mode 100644
index 000000000000..35090793fc12
--- /dev/null
+++ b/arch/x86/boot/compressed/unaccepted_memory.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "error.h"
+#include "misc.h"
+
+static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/* Platform-specific memory-acceptance call goes here */
+	error("Cannot accept memory");
+}
+
+void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
+{
+	/*
+	 * The accepted memory bitmap only works at PMD_SIZE granularity.
+	 * If a request comes in to mark memory as unaccepted which is not
+	 * PMD_SIZE-aligned, simply accept the memory now since it can not be
+	 * *marked* as unaccepted.
+	 */
+
+	/*
+	 * Accept small regions that might not be able to be represented
+	 * in the bitmap:
+	 */
+	if (end - start < 2 * PMD_SIZE) {
+		__accept_memory(start, end);
+		return;
+	}
+
+	/*
+	 * No matter how the start and end are aligned, at least one unaccepted
+	 * PMD_SIZE area will remain.
+         */
+
+	/* Immediately accept a <PMD_SIZE piece at the start: */
+	if (start & ~PMD_MASK) {
+		__accept_memory(start, round_up(start, PMD_SIZE));
+		start = round_up(start, PMD_SIZE);
+	}
+
+	/* Immediately accept a <PMD_SIZE piece at the end: */
+	if (end & ~PMD_MASK) {
+		__accept_memory(round_down(end, PMD_SIZE), end);
+		end = round_down(end, PMD_SIZE);
+	}
+
+	/*
+	 * 'start' and 'end' are now both PMD-aligned.
+	 * Record the range as being unaccepted:
+	 */
+	bitmap_set((unsigned long *)params->unaccepted_memory,
+		   start / PMD_SIZE, (end - start) / PMD_SIZE);
+}
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
new file mode 100644
index 000000000000..cbc24040b853
--- /dev/null
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 Intel Corporation */
+#ifndef _ASM_X86_UNACCEPTED_MEMORY_H
+#define _ASM_X86_UNACCEPTED_MEMORY_H
+
+#include <linux/types.h>
+
+struct boot_params;
+
+void mark_unaccepted(struct boot_params *params, u64 start, u64 num);
+
+#endif
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index b25d3f82c2f3..16bc686a198d 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -217,7 +217,8 @@ struct boot_params {
 	struct boot_e820_entry e820_table[E820_MAX_ENTRIES_ZEROPAGE]; /* 0x2d0 */
 	__u8  _pad8[48];				/* 0xcd0 */
 	struct edd_info eddbuf[EDDMAXNR];		/* 0xd00 */
-	__u8  _pad9[276];				/* 0xeec */
+	__u64 unaccepted_memory;			/* 0xeec */
+	__u8  _pad9[268];				/* 0xef4 */
 } __attribute__((packed));
 
 /**
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..b17ceec757d0 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -243,6 +243,21 @@ config EFI_DISABLE_PCI_DMA
 	  options "efi=disable_early_pci_dma" or "efi=no_disable_early_pci_dma"
 	  may be used to override this option.
 
+config UNACCEPTED_MEMORY
+	bool
+	depends on EFI_STUB
+	depends on !KEXEC_CORE
+	help
+	   Some Virtual Machine platforms, such as Intel TDX, require
+	   some memory to be "accepted" by the guest before it can be used.
+	   This mechanism helps prevent malicious hosts from making changes
+	   to guest memory.
+
+	   UEFI specification v2.9 introduced EFI_UNACCEPTED_MEMORY memory type.
+
+	   This option adds support for unaccepted memory and makes such memory
+	   usable by kernel.
+
 endmenu
 
 config EFI_EMBEDDED_FIRMWARE
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ae79c3300129..abe862c381b6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -740,6 +740,7 @@ static __initdata char memory_type_name[][13] = {
 	"MMIO Port",
 	"PAL Code",
 	"Persistent",
+	"Unaccepted",
 };
 
 char * __init efi_md_typeattr_format(char *buf, size_t size,
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index d18cac8ab436..e7601fd612aa 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -9,12 +9,14 @@
 #include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/stddef.h>
+#include <linux/bitmap.h>
 
 #include <asm/efi.h>
 #include <asm/e820/types.h>
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/unaccepted_memory.h>
 
 #include "efistub.h"
 
@@ -504,6 +506,13 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 			e820_type = E820_TYPE_PMEM;
 			break;
 
+		case EFI_UNACCEPTED_MEMORY:
+			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+				continue;
+			e820_type = E820_TYPE_RAM;
+			mark_unaccepted(params, d->phys_addr,
+					d->phys_addr + PAGE_SIZE * d->num_pages);
+			break;
 		default:
 			continue;
 		}
@@ -575,6 +584,9 @@ static efi_status_t allocate_e820(struct boot_params *params,
 {
 	efi_status_t status;
 	__u32 nr_desc;
+	bool unaccepted_memory_present = false;
+	u64 max_addr = 0;
+	int i;
 
 	status = efi_get_memory_map(map);
 	if (status != EFI_SUCCESS)
@@ -589,9 +601,57 @@ static efi_status_t allocate_e820(struct boot_params *params,
 		if (status != EFI_SUCCESS)
 			goto out;
 	}
+
+	if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+		goto out;
+
+	/* Check if there's any unaccepted memory and find the max address */
+	for (i = 0; i < nr_desc; i++) {
+		efi_memory_desc_t *d;
+
+		d = efi_early_memdesc_ptr(*map->map, *map->desc_size, i);
+		if (d->type == EFI_UNACCEPTED_MEMORY)
+			unaccepted_memory_present = true;
+		if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
+			max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
+	}
+
+	/*
+	 * If unaccepted memory is present allocate a bitmap to track what
+	 * memory has to be accepted before access.
+	 *
+	 * One bit in the bitmap represents 2MiB in the address space:
+	 * A 4k bitmap can track 64GiB of physical address space.
+	 *
+	 * In the worst case scenario -- a huge hole in the middle of the
+	 * address space -- It needs 256MiB to handle 4PiB of the address
+	 * space.
+	 *
+	 * TODO: handle situation if params->unaccepted_memory has already set.
+	 * It's required to deal with kexec.
+	 *
+	 * The bitmap will be populated in setup_e820() according to the memory
+	 * map after efi_exit_boot_services().
+	 */
+	if (unaccepted_memory_present) {
+		unsigned long *unaccepted_memory = NULL;
+		u64 size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
+
+		status = efi_allocate_pages(size,
+					    (unsigned long *)&unaccepted_memory,
+					    ULONG_MAX);
+		if (status != EFI_SUCCESS)
+			goto out;
+		memset(unaccepted_memory, 0, size);
+		params->unaccepted_memory = (unsigned long)unaccepted_memory;
+	} else {
+		params->unaccepted_memory = 0;
+	}
+
 out:
 	efi_bs_call(free_pool, *map->map);
-	return EFI_SUCCESS;
+	return status;
+
 }
 
 struct exit_boot_struct {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccd4d3f91c98..b0240fdcaf5b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -108,7 +108,8 @@ typedef	struct {
 #define EFI_MEMORY_MAPPED_IO_PORT_SPACE	12
 #define EFI_PAL_CODE			13
 #define EFI_PERSISTENT_MEMORY		14
-#define EFI_MAX_MEMORY_TYPE		15
+#define EFI_UNACCEPTED_MEMORY		15
+#define EFI_MAX_MEMORY_TYPE		16
 
 /* Attribute values: */
 #define EFI_MEMORY_UC		((u64)0x0000000000000001ULL)	/* uncached */
-- 
2.34.1

