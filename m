Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021F5701A7D
	for <lists+linux-efi@lfdr.de>; Sun, 14 May 2023 00:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjEMWEx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 May 2023 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjEMWEs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 May 2023 18:04:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D968E2D6B;
        Sat, 13 May 2023 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684015485; x=1715551485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y0D+C8PlVRLLZHr4n5LbwmcxN7HFDk6t7kYP66WxeG4=;
  b=WnkXBMVC5dKNVvyM5Zue5Js6uOLl3ia9keCHIxjmdMrI8M+Ty01WycFd
   jsGGrmJ7SbtB2EEo/12yeeOoqfEtkkYE27mbtahrYqmwOa194c4kQMBst
   zP4ho2dOifs3fMkT2FHS3B6hswohrm8j0w5eY+phVbboQrpdKxzgC5c1n
   oPlLKVlv6eQX4s5xLOW9BQrjJpyehAfa0F/yq52BJ2kdarbGoye1Gnmj8
   FkWHnwGml2hG6hYvnmtgXxAN4vkdnRVYMZBw75izAJlgFOtwO4cQulZXM
   2rK29EnJGiiPeBhvCuqxpDmfypn31LLbttPU+OVxRT60i+3oNY1rHMSoH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="437325169"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="437325169"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="790199646"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="790199646"
Received: from sorinaau-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.62.145])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:36 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id ED07F10CF79; Sun, 14 May 2023 01:04:33 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv11 3/9] efi/libstub: Implement support for unaccepted memory
Date:   Sun, 14 May 2023 01:04:12 +0300
Message-Id: <20230513220418.19357-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
the kernel: e820 (or whatever the arch uses) has to be modified on every
page acceptance. It leads to table fragmentation and there's a limited
number of entries in the e820 table.

Another option is to mark such memory as usable in e820 and track if the
range has been accepted in a bitmap. One bit in the bitmap represents a
naturally aligned power-2-sized region of address space -- unit.

For x86, unit size is 2MiB: 4k of the bitmap is enough to track 64GiB or
physical address space.

In the worst-case scenario -- a huge hole in the middle of the
address space -- It needs 256MiB to handle 4PiB of the address
space.

Any unaccepted memory that is not aligned to unit_size gets accepted
upfront.

The bitmap is allocated and constructed in the EFI stub and passed down
to the kernel via EFI configuration table. allocate_e820() allocates the
bitmap if unaccepted memory is present, according to the size of
unaccepted region.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile             |   1 +
 arch/x86/boot/compressed/mem.c                |   9 +
 arch/x86/include/asm/efi.h                    |   2 +
 drivers/firmware/efi/Kconfig                  |  14 ++
 drivers/firmware/efi/efi.c                    |   1 +
 drivers/firmware/efi/libstub/Makefile         |   2 +
 drivers/firmware/efi/libstub/bitmap.c         |  41 ++++
 drivers/firmware/efi/libstub/efistub.h        |   6 +
 drivers/firmware/efi/libstub/find.c           |  43 ++++
 .../firmware/efi/libstub/unaccepted_memory.c  | 222 ++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c       |  13 +
 include/linux/efi.h                           |  12 +-
 12 files changed, 365 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/boot/compressed/mem.c
 create mode 100644 drivers/firmware/efi/libstub/bitmap.c
 create mode 100644 drivers/firmware/efi/libstub/find.c
 create mode 100644 drivers/firmware/efi/libstub/unaccepted_memory.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b6cfe607bdb..cc4978123c30 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,6 +107,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
+vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
new file mode 100644
index 000000000000..67594fcb11d9
--- /dev/null
+++ b/arch/x86/boot/compressed/mem.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "error.h"
+
+void arch_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/* Platform-specific memory-acceptance call goes here */
+	error("Cannot accept memory");
+}
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 419280d263d2..8b4be7cecdb8 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -31,6 +31,8 @@ extern unsigned long efi_mixed_mode_stack_pa;
 
 #define ARCH_EFI_IRQ_FLAGS_MASK	X86_EFLAGS_IF
 
+#define EFI_UNACCEPTED_UNIT_SIZE PMD_SIZE
+
 /*
  * The EFI services are called through variadic functions in many cases. These
  * functions are implemented in assembler and support only a fixed number of
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 043ca31c114e..231f1c70d1db 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -269,6 +269,20 @@ config EFI_COCO_SECRET
 	  virt/coco/efi_secret module to access the secrets, which in turn
 	  allows userspace programs to access the injected secrets.
 
+config UNACCEPTED_MEMORY
+	bool
+	depends on EFI_STUB
+	help
+	   Some Virtual Machine platforms, such as Intel TDX, require
+	   some memory to be "accepted" by the guest before it can be used.
+	   This mechanism helps prevent malicious hosts from making changes
+	   to guest memory.
+
+	   UEFI specification v2.9 introduced EFI_UNACCEPTED_MEMORY memory type.
+
+	   This option adds support for unaccepted memory and makes such memory
+	   usable by the kernel.
+
 config EFI_EMBEDDED_FIRMWARE
 	bool
 	select CRYPTO_LIB_SHA256
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index abeff7dc0b58..7dce06e419c5 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -843,6 +843,7 @@ static __initdata char memory_type_name[][13] = {
 	"MMIO Port",
 	"PAL Code",
 	"Persistent",
+	"Unaccepted",
 };
 
 char * __init efi_md_typeattr_format(char *buf, size_t size,
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 3abb2b357482..16d64a34d1e1 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -96,6 +96,8 @@ CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 zboot-obj-$(CONFIG_RISCV)	:= lib-clz_ctz.o lib-ashldi3.o
 lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o $(zboot-obj-y)
 
+lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
+
 extra-y				:= $(lib-y)
 lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
 
diff --git a/drivers/firmware/efi/libstub/bitmap.c b/drivers/firmware/efi/libstub/bitmap.c
new file mode 100644
index 000000000000..5c9bba0d549b
--- /dev/null
+++ b/drivers/firmware/efi/libstub/bitmap.c
@@ -0,0 +1,41 @@
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
+
+void __bitmap_clear(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_clear >= 0) {
+		*p &= ~mask_to_clear;
+		len -= bits_to_clear;
+		bits_to_clear = BITS_PER_LONG;
+		mask_to_clear = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		*p &= ~mask_to_clear;
+	}
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 67d5a20802e0..8659a01664b8 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1133,4 +1133,10 @@ const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
 void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 		     unsigned long code_size);
 
+efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
+					struct efi_boot_memmap *map);
+void process_unaccepted_memory(u64 start, u64 end);
+void accept_memory(phys_addr_t start, phys_addr_t end);
+void arch_accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/find.c b/drivers/firmware/efi/libstub/find.c
new file mode 100644
index 000000000000..4e7740d28987
--- /dev/null
+++ b/drivers/firmware/efi/libstub/find.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bitmap.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+
+/*
+ * Common helper for find_next_bit() function family
+ * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
+ * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
+ * @size: The bitmap size in bits
+ * @start: The bitnumber to start searching at
+ */
+#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)				\
+({										\
+	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
+										\
+	if (unlikely(__start >= sz))						\
+		goto out;							\
+										\
+	mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));				\
+	idx = __start / BITS_PER_LONG;						\
+										\
+	for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {			\
+		if ((idx + 1) * BITS_PER_LONG >= sz)				\
+			goto out;						\
+		idx++;								\
+	}									\
+										\
+	sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(tmp)), sz);			\
+out:										\
+	sz;									\
+})
+
+unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
+}
+
+unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
+					 unsigned long start)
+{
+	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
+}
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
new file mode 100644
index 000000000000..f4642c4f25dd
--- /dev/null
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include "efistub.h"
+
+static struct efi_unaccepted_memory *unaccepted_table;
+
+efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
+					struct efi_boot_memmap *map)
+{
+	efi_guid_t unaccepted_table_guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
+	u64 unaccepted_start = ULLONG_MAX, unaccepted_end = 0, bitmap_size;
+	efi_status_t status;
+	int i;
+
+	/* Check if the table is already installed */
+	unaccepted_table = get_efi_config_table(unaccepted_table_guid);
+	if (unaccepted_table) {
+		if (unaccepted_table->version != 1) {
+			efi_err("Unknown version of unaccepted memory table\n");
+			return EFI_UNSUPPORTED;
+		}
+		return EFI_SUCCESS;
+	}
+
+	/* Check if there's any unaccepted memory and find the max address */
+	for (i = 0; i < nr_desc; i++) {
+		efi_memory_desc_t *d;
+		unsigned long m = (unsigned long)map->map;
+
+		d = efi_early_memdesc_ptr(m, map->desc_size, i);
+		if (d->type != EFI_UNACCEPTED_MEMORY)
+			continue;
+
+		unaccepted_start = min(unaccepted_start, d->phys_addr);
+		unaccepted_end = max(unaccepted_end,
+				     d->phys_addr + d->num_pages * PAGE_SIZE);
+	}
+
+	if (unaccepted_start == ULLONG_MAX)
+		return EFI_SUCCESS;
+
+	unaccepted_start = round_down(unaccepted_start,
+				      EFI_UNACCEPTED_UNIT_SIZE);
+	unaccepted_end = round_up(unaccepted_end, EFI_UNACCEPTED_UNIT_SIZE);
+
+	/*
+	 * If unaccepted memory is present, allocate a bitmap to track what
+	 * memory has to be accepted before access.
+	 *
+	 * One bit in the bitmap represents 2MiB in the address space:
+	 * A 4k bitmap can track 64GiB of physical address space.
+	 *
+	 * In the worst case scenario -- a huge hole in the middle of the
+	 * address space -- It needs 256MiB to handle 4PiB of the address
+	 * space.
+	 *
+	 * The bitmap will be populated in setup_e820() according to the memory
+	 * map after efi_exit_boot_services().
+	 */
+	bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
+				   EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     sizeof(*unaccepted_table) + bitmap_size,
+			     (void **)&unaccepted_table);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to allocate unaccepted memory config table\n");
+		return status;
+	}
+
+	unaccepted_table->version = 1;
+	unaccepted_table->unit_size = EFI_UNACCEPTED_UNIT_SIZE;
+	unaccepted_table->phys_base = unaccepted_start;
+	unaccepted_table->size = bitmap_size;
+	memset(unaccepted_table->bitmap, 0, bitmap_size);
+
+	status = efi_bs_call(install_configuration_table,
+			     &unaccepted_table_guid, unaccepted_table);
+	if (status != EFI_SUCCESS) {
+		efi_bs_call(free_pool, unaccepted_table);
+		efi_err("Failed to install unaccepted memory config table!\n");
+	}
+
+	return status;
+}
+
+/*
+ * The accepted memory bitmap only works at unit_size granularity.  Take
+ * unaligned start/end addresses and either:
+ *  1. Accepts the memory immediately and in its entirety
+ *  2. Accepts unaligned parts, and marks *some* aligned part unaccepted
+ *
+ * The function will never reach the bitmap_set() with zero bits to set.
+ */
+void process_unaccepted_memory(u64 start, u64 end)
+{
+	u64 unit_size = unaccepted_table->unit_size;
+	u64 unit_mask = unaccepted_table->unit_size - 1;
+	u64 bitmap_size = unaccepted_table->size;
+
+	/*
+	 * Ensure that at least one bit will be set in the bitmap by
+	 * immediately accepting all regions under 2*unit_size.  This is
+	 * imprecise and may immediately accept some areas that could
+	 * have been represented in the bitmap.  But, results in simpler
+	 * code below
+	 *
+	 * Consider case like this (assuming unit_size == 2MB):
+	 *
+	 * | 4k | 2044k |    2048k   |
+	 * ^ 0x0        ^ 2MB        ^ 4MB
+	 *
+	 * Only the first 4k has been accepted. The 0MB->2MB region can not be
+	 * represented in the bitmap. The 2MB->4MB region can be represented in
+	 * the bitmap. But, the 0MB->4MB region is <2*unit_size and will be
+	 * immediately accepted in its entirety.
+	 */
+	if (end - start < 2 * unit_size) {
+		arch_accept_memory(start, end);
+		return;
+	}
+
+	/*
+	 * No matter how the start and end are aligned, at least one unaccepted
+	 * unit_size area will remain to be marked in the bitmap.
+	 */
+
+	/* Immediately accept a <unit_size piece at the start: */
+	if (start & unit_mask) {
+		arch_accept_memory(start, round_up(start, unit_size));
+		start = round_up(start, unit_size);
+	}
+
+	/* Immediately accept a <unit_size piece at the end: */
+	if (end & unit_mask) {
+		arch_accept_memory(round_down(end, unit_size), end);
+		end = round_down(end, unit_size);
+	}
+
+	/*
+	 * Accept part of the range that before phys_base and cannot be recorded
+	 * into the bitmap.
+	 */
+	if (start < unaccepted_table->phys_base) {
+		arch_accept_memory(start,
+				   min(unaccepted_table->phys_base, end));
+		start = unaccepted_table->phys_base;
+	}
+
+	/* Nothing to record */
+	if (end < unaccepted_table->phys_base)
+		return;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted_table->phys_base;
+	end -= unaccepted_table->phys_base;
+
+	/* Accept memory that doesn't fit into bitmap */
+	if (end > bitmap_size * unit_size * BITS_PER_BYTE) {
+		unsigned long phys_start, phys_end;
+
+		phys_start = bitmap_size * unit_size * BITS_PER_BYTE +
+			     unaccepted_table->phys_base;
+		phys_end = end + unaccepted_table->phys_base;
+
+		arch_accept_memory(phys_start, phys_end);
+		end = bitmap_size * unit_size * BITS_PER_BYTE;
+	}
+
+	/*
+	 * 'start' and 'end' are now both unit_size-aligned.
+	 * Record the range as being unaccepted:
+	 */
+	bitmap_set(unaccepted_table->bitmap,
+		   start / unit_size, (end - start) / unit_size);
+}
+
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long range_start, range_end;
+	unsigned long bitmap_size;
+	u64 unit_size;
+
+	if (!unaccepted_table)
+		return;
+
+	unit_size = unaccepted_table->unit_size;
+
+	/*
+	 * Only care for the part of the range that is represented
+	 * in the bitmap.
+	 */
+	if (start < unaccepted_table->phys_base)
+		start = unaccepted_table->phys_base;
+	if (end < unaccepted_table->phys_base)
+		return;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted_table->phys_base;
+	end -= unaccepted_table->phys_base;
+
+	/* Make sure not to overrun the bitmap */
+	if (end > unaccepted_table->size * unit_size * BITS_PER_BYTE)
+		end = unaccepted_table->size * unit_size * BITS_PER_BYTE;
+
+	range_start = start / unit_size;
+	bitmap_size = DIV_ROUND_UP(end, unit_size);
+
+	for_each_set_bitrange_from(range_start, range_end,
+				   unaccepted_table->bitmap, bitmap_size) {
+		unsigned long phys_start, phys_end;
+
+		phys_start = range_start * unit_size + unaccepted_table->phys_base;
+		phys_end = range_end * unit_size + unaccepted_table->phys_base;
+
+		arch_accept_memory(phys_start, phys_end);
+		bitmap_clear(unaccepted_table->bitmap,
+			     range_start, range_end - range_start);
+	}
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index fff81843169c..8d17cee8b98e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -613,6 +613,16 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 			e820_type = E820_TYPE_PMEM;
 			break;
 
+		case EFI_UNACCEPTED_MEMORY:
+			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
+				efi_warn_once(
+"The system has unaccepted memory,  but kernel does not support it\nConsider enabling CONFIG_UNACCEPTED_MEMORY\n");
+				continue;
+			}
+			e820_type = E820_TYPE_RAM;
+			process_unaccepted_memory(d->phys_addr,
+						  d->phys_addr + PAGE_SIZE * d->num_pages);
+			break;
 		default:
 			continue;
 		}
@@ -697,6 +707,9 @@ static efi_status_t allocate_e820(struct boot_params *params,
 		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
 	}
 
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) && status == EFI_SUCCESS)
+		status = allocate_unaccepted_bitmap(nr_desc, map);
+
 	efi_bs_call(free_pool, map);
 	return status;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7aa62c92185f..29cc622910da 100644
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
@@ -417,6 +418,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
 #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
 #define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
+#define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 
@@ -534,6 +536,14 @@ struct efi_boot_memmap {
 	efi_memory_desc_t	map[];
 };
 
+struct efi_unaccepted_memory {
+	u32 version;
+	u32 unit_size;
+	u64 phys_base;
+	u64 size;
+	unsigned long bitmap[];
+};
+
 /*
  * Architecture independent structure for describing a memory map for the
  * benefit of efi_memmap_init_early(), and for passing context between
-- 
2.39.3

