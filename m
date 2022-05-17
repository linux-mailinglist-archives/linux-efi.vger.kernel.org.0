Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910DB52A6E3
	for <lists+linux-efi@lfdr.de>; Tue, 17 May 2022 17:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350049AbiEQPfT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 May 2022 11:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345240AbiEQPfI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 May 2022 11:35:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699964FC60;
        Tue, 17 May 2022 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652801707; x=1684337707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yWrGuxKKjQPoN2agiveNwFxbSi1odWGF+uMe0iktT3E=;
  b=B9EI4nIc83c9enBwtfofqUPmRVWTMndulvKrHibubhqjGpSSFDhKk2pt
   XZppK0Z59lLcbb1EtRecd7r1uizrzYqAzKMy6aNpdacnJe0IJi69TMt4v
   6BD3RYwKFILsvd1/KrPnNhSdtH/Fw2E/cxPN0ioNz1YWGuQxhSLWr4jv7
   L/aVybSD016KZ8PeT6DOHTsY7CGB4wIxscbo3XBOcPmijoQlQGMjc44uZ
   Z4wTZqm8SRFwY9avdkqdrDCPJ+w8sVxBRlQa02beAvrE59Ildzo80+WMK
   s9QNAVLC+bMQ1g8Z6fdqprzNIhuzS6teFX0BP/d2uAe28lEYMDag4oKjJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="331837231"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="331837231"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 08:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="574566798"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 17 May 2022 08:34:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8050C719; Tue, 17 May 2022 18:34:50 +0300 (EEST)
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 05/15] efi/x86: Implement support for unaccepted memory
Date:   Tue, 17 May 2022 18:34:34 +0300
Message-Id: <20220517153444.11195-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

The implementation requires some basic helpers in boot stub. They
provided by linux/ includes in the main kernel image, but is not present
in boot stub. Create copy of required functionality in the boot stub.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/x86/zero-page.rst          |  1 +
 arch/x86/boot/compressed/Makefile        |  1 +
 arch/x86/boot/compressed/mem.c           | 68 ++++++++++++++++++++++++
 arch/x86/include/asm/unaccepted_memory.h | 10 ++++
 arch/x86/include/uapi/asm/bootparam.h    |  2 +-
 drivers/firmware/efi/Kconfig             | 14 +++++
 drivers/firmware/efi/efi.c               |  1 +
 drivers/firmware/efi/libstub/x86-stub.c  | 68 ++++++++++++++++++++++++
 include/linux/efi.h                      |  3 +-
 9 files changed, 166 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/boot/compressed/mem.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h

diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
index 45aa9cceb4f1..f21905e61ade 100644
--- a/Documentation/x86/zero-page.rst
+++ b/Documentation/x86/zero-page.rst
@@ -20,6 +20,7 @@ Offset/Size	Proto	Name			Meaning
 060/010		ALL	ist_info		Intel SpeedStep (IST) BIOS support information
 						(struct ist_info)
 070/008		ALL	acpi_rsdp_addr		Physical address of ACPI RSDP table
+078/008		ALL	unaccepted_memory	Bitmap of unaccepted memory (1bit == 2M)
 080/010		ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
 090/010		ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
 0A0/010		ALL	sys_desc_table		System description table (struct sys_desc_table),
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 19e1905dcbf6..67732478323f 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -102,6 +102,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
+vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
new file mode 100644
index 000000000000..415df0d3bc81
--- /dev/null
+++ b/arch/x86/boot/compressed/mem.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "../cpuflags.h"
+#include "bitmap.h"
+#include "error.h"
+#include "math.h"
+
+#define PMD_SHIFT	21
+#define PMD_SIZE	(_AC(1, UL) << PMD_SHIFT)
+#define PMD_MASK	(~(PMD_SIZE - 1))
+
+static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/* Platform-specific memory-acceptance call goes here */
+	error("Cannot accept memory");
+}
+
+/*
+ * The accepted memory bitmap only works at PMD_SIZE granularity. If a request
+ * comes in to mark memory as unaccepted which is not PMD_SIZE-aligned, simply
+ * accept the memory now since it can not be *marked* as unaccepted.
+ */
+void process_unaccepted_memory(struct boot_params *params, u64 start, u64 end)
+{
+	/*
+	 * Accept small regions that might not be able to be represented
+	 * in the bitmap.  This is a bit imprecise and may accept some
+	 * areas that could have been represented in the bitmap instead.
+	 *
+	 * Consider case like this:
+	 *
+	 * | 4k | 2044k |    2048k   |
+	 * ^ 0x0        ^ 2MB        ^ 4MB
+	 *
+	 * all memory in the range is unaccepted, except for the first 4k.
+	 * The second 2M can be represented in the bitmap, but kernel accept it
+	 * right away. The imprecision makes the code simpler by ensuring that
+	 * at least one bit will be set int the bitmap below.
+	 */
+	if (end - start < 2 * PMD_SIZE) {
+		__accept_memory(start, end);
+		return;
+	}
+
+	/*
+	 * No matter how the start and end are aligned, at least one unaccepted
+	 * PMD_SIZE area will remain.
+	 */
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
index 000000000000..df0736d32858
--- /dev/null
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 Intel Corporation */
+#ifndef _ASM_X86_UNACCEPTED_MEMORY_H
+#define _ASM_X86_UNACCEPTED_MEMORY_H
+
+struct boot_params;
+
+void process_unaccepted_memory(struct boot_params *params, u64 start, u64 num);
+
+#endif
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index bea5cdcdf532..c62f6ee4b6f0 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -180,7 +180,7 @@ struct boot_params {
 	__u64  tboot_addr;				/* 0x058 */
 	struct ist_info ist_info;			/* 0x060 */
 	__u64 acpi_rsdp_addr;				/* 0x070 */
-	__u8  _pad3[8];					/* 0x078 */
+	__u64 unaccepted_memory;			/* 0x078 */
 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
 	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..80d0e802107f 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -243,6 +243,20 @@ config EFI_DISABLE_PCI_DMA
 	  options "efi=disable_early_pci_dma" or "efi=no_disable_early_pci_dma"
 	  may be used to override this option.
 
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
 endmenu
 
 config EFI_EMBEDDED_FIRMWARE
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5502e176d51b..2c055afb1b11 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -747,6 +747,7 @@ static __initdata char memory_type_name[][13] = {
 	"MMIO Port",
 	"PAL Code",
 	"Persistent",
+	"Unaccepted",
 };
 
 char * __init efi_md_typeattr_format(char *buf, size_t size,
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 252ee222ca1e..ec14a9a6436b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -15,6 +15,7 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/unaccepted_memory.h>
 
 #include "efistub.h"
 
@@ -504,6 +505,17 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 			e820_type = E820_TYPE_PMEM;
 			break;
 
+		case EFI_UNACCEPTED_MEMORY:
+			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
+				efi_warn_once("The system has unaccepted memory,"
+					     " but kernel does not support it\n");
+				efi_warn_once("Consider enabling CONFIG_UNACCEPTED_MEMORY\n");
+				continue;
+			}
+			e820_type = E820_TYPE_RAM;
+			process_unaccepted_memory(params, d->phys_addr,
+						  d->phys_addr + PAGE_SIZE * d->num_pages);
+			break;
 		default:
 			continue;
 		}
@@ -568,6 +580,59 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
 	return status;
 }
 
+static efi_status_t allocate_unaccepted_memory(struct boot_params *params,
+					       __u32 nr_desc,
+					       struct efi_boot_memmap *map)
+{
+	unsigned long *mem = NULL;
+	u64 size, max_addr = 0;
+	efi_status_t status;
+	bool found = false;
+	int i;
+
+	/* Check if there's any unaccepted memory and find the max address */
+	for (i = 0; i < nr_desc; i++) {
+		efi_memory_desc_t *d;
+
+		d = efi_early_memdesc_ptr(*map->map, *map->desc_size, i);
+		if (d->type == EFI_UNACCEPTED_MEMORY)
+			found = true;
+		if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
+			max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
+	}
+
+	if (!found) {
+		params->unaccepted_memory = 0;
+		return EFI_SUCCESS;
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
+	 * TODO: handle situation if params->unaccepted_memory is already set.
+	 * It's required to deal with kexec.
+	 *
+	 * The bitmap will be populated in setup_e820() according to the memory
+	 * map after efi_exit_boot_services().
+	 */
+	size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
+	status = efi_allocate_pages(size, (unsigned long *)&mem, ULONG_MAX);
+	if (status == EFI_SUCCESS) {
+		memset(mem, 0, size);
+		params->unaccepted_memory = (unsigned long)mem;
+	}
+
+	return status;
+}
+
 static efi_status_t allocate_e820(struct boot_params *params,
 				  struct efi_boot_memmap *map,
 				  struct setup_data **e820ext,
@@ -588,6 +653,9 @@ static efi_status_t allocate_e820(struct boot_params *params,
 		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
 	}
 
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) && status == EFI_SUCCESS)
+		status = allocate_unaccepted_memory(params, nr_desc, map);
+
 	efi_bs_call(free_pool, *map->map);
 	return status;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 984aa688997a..8b03dc37bc29 100644
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
2.35.1

