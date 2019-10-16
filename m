Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB3ED854E
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2019 03:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390589AbfJPBOL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Oct 2019 21:14:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:43979 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbfJPBOK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Oct 2019 21:14:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 18:14:10 -0700
X-IronPort-AV: E=Sophos;i="5.67,301,1566889200"; 
   d="scan'208";a="198801760"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 18:14:09 -0700
Subject: [PATCH v7 05/12] x86/efi: EFI soft reservation to E820 enumeration
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kbuild test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        vishal.l.verma@intel.com, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Tue, 15 Oct 2019 17:59:52 -0700
Message-ID: <157118759239.2063440.5291889084389032512.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
interpretation of the EFI Memory Types as "reserved for a specific
purpose".

The proposed Linux behavior for specific purpose memory is that it is
reserved for direct-access (device-dax) by default and not available for
any kernel usage, not even as an OOM fallback.  Later, through udev
scripts or another init mechanism, these device-dax claimed ranges can
be reconfigured and hot-added to the available System-RAM with a unique
node identifier. This device-dax management scheme implements "soft" in
the "soft reserved" designation by allowing some or all of the
reservation to be recovered as typical memory. This policy can be
disabled at compile-time with CONFIG_EFI_SOFT_RESERVE=n, or runtime with
efi=nosoftreserve.

This patch introduces 2 new concepts at once given the entanglement
between early boot enumeration relative to memory that can optionally be
reserved from the kernel page allocator by default. The new concepts
are:

- E820_TYPE_SOFT_RESERVED: Upon detecting the EFI_MEMORY_SP
  attribute on EFI_CONVENTIONAL memory, update the E820 map with this
  new type. Only perform this classification if the
  CONFIG_EFI_SOFT_RESERVE=y policy is enabled, otherwise treat it as
  typical ram.

- IORES_DESC_SOFT_RESERVED: Add a new I/O resource descriptor for
  a device driver to search iomem resources for application specific
  memory. Teach the iomem code to identify such ranges as "Soft Reserved".

Note that the comment for do_add_efi_memmap() needed refreshing since it
seemed to imply that the efi map might overflow the e820 table, but that
is not an issue as of commit 7b6e4ba3cb1f "x86/boot/e820: Clean up the
E820_X_MAX definition" that removed the 128 entry limit for
e820__range_add().

A follow-on change integrates parsing of the ACPI HMAT to identify the
node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
now, just identify and reserve memory of this type.

Cc: <x86@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/boot/compressed/eboot.c  |    6 ++++-
 arch/x86/boot/compressed/kaslr.c  |    4 +++
 arch/x86/include/asm/e820/types.h |    8 ++++++
 arch/x86/kernel/e820.c            |   12 ++++++++-
 arch/x86/platform/efi/efi.c       |   49 ++++++++++++++++++++++++++++++++++---
 include/linux/ioport.h            |    1 +
 6 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index d6662fdef300..f3b03229c44c 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -553,7 +553,11 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 		case EFI_BOOT_SERVICES_CODE:
 		case EFI_BOOT_SERVICES_DATA:
 		case EFI_CONVENTIONAL_MEMORY:
-			e820_type = E820_TYPE_RAM;
+			if (efi_soft_reserve_enabled() &&
+			    (d->attribute & EFI_MEMORY_SP))
+				e820_type = E820_TYPE_SOFT_RESERVED;
+			else
+				e820_type = E820_TYPE_RAM;
 			break;
 
 		case EFI_ACPI_MEMORY_NVS:
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 2e53c056ba20..ff6fa81949cd 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -760,6 +760,10 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 		if (md->type != EFI_CONVENTIONAL_MEMORY)
 			continue;
 
+		if (efi_soft_reserve_enabled() &&
+		    (md->attribute & EFI_MEMORY_SP))
+			continue;
+
 		if (efi_mirror_found &&
 		    !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
 			continue;
diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
index c3aa4b5e49e2..314f75d886d0 100644
--- a/arch/x86/include/asm/e820/types.h
+++ b/arch/x86/include/asm/e820/types.h
@@ -28,6 +28,14 @@ enum e820_type {
 	 */
 	E820_TYPE_PRAM		= 12,
 
+	/*
+	 * Special-purpose memory is indicated to the system via the
+	 * EFI_MEMORY_SP attribute. Define an e820 translation of this
+	 * memory type for the purpose of reserving this range and
+	 * marking it with the IORES_DESC_SOFT_RESERVED designation.
+	 */
+	E820_TYPE_SOFT_RESERVED	= 0xefffffff,
+
 	/*
 	 * Reserved RAM used by the kernel itself if
 	 * CONFIG_INTEL_TXT=y is enabled, memory of this type
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 7da2bcd2b8eb..9976106b57ec 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -190,6 +190,7 @@ static void __init e820_print_type(enum e820_type type)
 	case E820_TYPE_RAM:		/* Fall through: */
 	case E820_TYPE_RESERVED_KERN:	pr_cont("usable");			break;
 	case E820_TYPE_RESERVED:	pr_cont("reserved");			break;
+	case E820_TYPE_SOFT_RESERVED:	pr_cont("soft reserved");		break;
 	case E820_TYPE_ACPI:		pr_cont("ACPI data");			break;
 	case E820_TYPE_NVS:		pr_cont("ACPI NVS");			break;
 	case E820_TYPE_UNUSABLE:	pr_cont("unusable");			break;
@@ -1037,6 +1038,7 @@ static const char *__init e820_type_to_string(struct e820_entry *entry)
 	case E820_TYPE_PRAM:		return "Persistent Memory (legacy)";
 	case E820_TYPE_PMEM:		return "Persistent Memory";
 	case E820_TYPE_RESERVED:	return "Reserved";
+	case E820_TYPE_SOFT_RESERVED:	return "Soft Reserved";
 	default:			return "Unknown E820 type";
 	}
 }
@@ -1052,6 +1054,7 @@ static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
 	case E820_TYPE_PRAM:		/* Fall-through: */
 	case E820_TYPE_PMEM:		/* Fall-through: */
 	case E820_TYPE_RESERVED:	/* Fall-through: */
+	case E820_TYPE_SOFT_RESERVED:	/* Fall-through: */
 	default:			return IORESOURCE_MEM;
 	}
 }
@@ -1064,6 +1067,7 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
 	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
 	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
 	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
+	case E820_TYPE_SOFT_RESERVED:	return IORES_DESC_SOFT_RESERVED;
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		/* Fall-through: */
 	case E820_TYPE_UNUSABLE:	/* Fall-through: */
@@ -1078,11 +1082,12 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
 		return true;
 
 	/*
-	 * Treat persistent memory like device memory, i.e. reserve it
-	 * for exclusive use of a driver
+	 * Treat persistent memory and other special memory ranges like
+	 * device memory, i.e. reserve it for exclusive use of a driver
 	 */
 	switch (type) {
 	case E820_TYPE_RESERVED:
+	case E820_TYPE_SOFT_RESERVED:
 	case E820_TYPE_PRAM:
 	case E820_TYPE_PMEM:
 		return false;
@@ -1285,6 +1290,9 @@ void __init e820__memblock_setup(void)
 		if (end != (resource_size_t)end)
 			continue;
 
+		if (entry->type == E820_TYPE_SOFT_RESERVED)
+			memblock_reserve(entry->addr, entry->size);
+
 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
 			continue;
 
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 0bb58eb33ca0..0336d481b826 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -148,14 +148,18 @@ void __init efi_find_mirror(void)
 
 /*
  * Tell the kernel about the EFI memory map.  This might include
- * more than the max 128 entries that can fit in the e820 legacy
- * (zeropage) memory map.
+ * more than the max 128 entries that can fit in the passed in e820
+ * legacy (zeropage) memory map, but the kernel's e820 table can hold
+ * E820_MAX_ENTRIES.
  */
 
 static void __init do_add_efi_memmap(void)
 {
 	efi_memory_desc_t *md;
 
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
 		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
@@ -167,7 +171,10 @@ static void __init do_add_efi_memmap(void)
 		case EFI_BOOT_SERVICES_CODE:
 		case EFI_BOOT_SERVICES_DATA:
 		case EFI_CONVENTIONAL_MEMORY:
-			if (md->attribute & EFI_MEMORY_WB)
+			if (efi_soft_reserve_enabled()
+			    && (md->attribute & EFI_MEMORY_SP))
+				e820_type = E820_TYPE_SOFT_RESERVED;
+			else if (md->attribute & EFI_MEMORY_WB)
 				e820_type = E820_TYPE_RAM;
 			else
 				e820_type = E820_TYPE_RESERVED;
@@ -193,11 +200,36 @@ static void __init do_add_efi_memmap(void)
 			e820_type = E820_TYPE_RESERVED;
 			break;
 		}
+
 		e820__range_add(start, size, e820_type);
 	}
 	e820__update_table(e820_table);
 }
 
+/*
+ * Given add_efi_memmap defaults to 0 and there there is no alternative
+ * e820 mechanism for soft-reserved memory, import the full EFI memory
+ * map if soft reservations are present and enabled. Otherwise, the
+ * mechanism to disable the kernel's consideration of EFI_MEMORY_SP is
+ * the efi=nosoftreserve option.
+ */
+static bool do_efi_soft_reserve(void)
+{
+	efi_memory_desc_t *md;
+
+	if (!efi_enabled(EFI_MEMMAP))
+		return false;
+
+	if (!efi_soft_reserve_enabled())
+		return false;
+
+	for_each_efi_memory_desc(md)
+		if (md->type == EFI_CONVENTIONAL_MEMORY &&
+		    (md->attribute & EFI_MEMORY_SP))
+			return true;
+	return false;
+}
+
 int __init efi_memblock_x86_reserve_range(void)
 {
 	struct efi_info *e = &boot_params.efi_info;
@@ -227,7 +259,7 @@ int __init efi_memblock_x86_reserve_range(void)
 	if (rv)
 		return rv;
 
-	if (add_efi_memmap)
+	if (add_efi_memmap || do_efi_soft_reserve())
 		do_add_efi_memmap();
 
 	WARN(efi.memmap.desc_version != 1,
@@ -781,6 +813,15 @@ static bool should_map_region(efi_memory_desc_t *md)
 	if (IS_ENABLED(CONFIG_X86_32))
 		return false;
 
+	/*
+	 * EFI specific purpose memory may be reserved by default
+	 * depending on kernel config and boot options.
+	 */
+	if (md->type == EFI_CONVENTIONAL_MEMORY &&
+	    efi_soft_reserve_enabled() &&
+	    (md->attribute & EFI_MEMORY_SP))
+		return false;
+
 	/*
 	 * Map all of RAM so that we can access arguments in the 1:1
 	 * mapping when making EFI runtime calls.
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 7bddddfc76d6..a9b9170b5dd2 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -134,6 +134,7 @@ enum {
 	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
 	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
 	IORES_DESC_RESERVED			= 7,
+	IORES_DESC_SOFT_RESERVED		= 8,
 };
 
 /*

