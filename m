Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E3C131CE9
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 01:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgAGA4q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jan 2020 19:56:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:26789 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbgAGA4q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Jan 2020 19:56:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 16:56:45 -0800
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="222404183"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 16:56:45 -0800
Subject: [PATCH v4 4/4] efi: Fix handling of multiple efi_fake_mem= entries
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Dave Young <dyoung@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Date:   Mon, 06 Jan 2020 16:40:43 -0800
Message-ID: <157835764298.1456824.224151767362114611.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dave noticed that when specifying multiple efi_fake_mem= entries only
the last entry was successfully being reflected in the efi memory map.
This is due to the fact that the efi_memmap_insert() is being called
multiple times, but on successive invocations the insertion should be
applied to the last new memmap rather than the original map at
efi_fake_memmap() entry.

Rework efi_fake_memmap() to install the new memory map after each
efi_fake_mem= entry is parsed.

This also fixes an issue in efi_fake_memmap() that caused it to litter
emtpy entries into the end of the efi memory map. An empty entry causes
efi_memmap_insert() to attempt more memmap splits / copies than
efi_memmap_split_count() accounted for when sizing the new map. When
that happens efi_memmap_insert() may overrun its allocation, and if you
are lucky will spill over to an unmapped page leading to crash
signature like the following rather than silent corruption:

    BUG: unable to handle page fault for address: ffffffffff281000
    [..]
    RIP: 0010:efi_memmap_insert+0x11d/0x191
    [..]
    Call Trace:
     ? bgrt_init+0xbe/0xbe
     ? efi_arch_mem_reserve+0x1cb/0x228
     ? acpi_parse_bgrt+0xa/0xd
     ? acpi_table_parse+0x86/0xb8
     ? acpi_boot_init+0x494/0x4e3
     ? acpi_parse_x2apic+0x87/0x87
     ? setup_acpi_sci+0xa2/0xa2
     ? setup_arch+0x8db/0x9e1
     ? start_kernel+0x6a/0x547
     ? secondary_startup_64+0xb6/0xc0

Commit af1648984828 "x86/efi: Update e820 with reserved EFI boot
services data to fix kexec breakage" is listed in Fixes: since it
introduces more occurrences where efi_memmap_insert() is invoked after
an efi_fake_mem= configuration has been parsed. Previously the side
effects of vestigial empty entries were benign, but with commit
af1648984828 that follow-on efi_memmap_insert() invocation triggers
efi_memmap_insert() overruns.

Fixes: 0f96a99dab36 ("efi: Add 'efi_fake_mem' boot option")
Fixes: af1648984828 ("x86/efi: Update e820 with reserved EFI boot services...")
Link: https://lore.kernel.org/r/20191231014630.GA24942@dhcp-128-65.nay.redhat.com
Reported-by: Dave Young <dyoung@redhat.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Michael Weiser <michael@weiser.dinsnail.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/efi/fake_mem.c |   31 ++++++++++++++++---------------
 drivers/firmware/efi/memmap.c   |    2 +-
 include/linux/efi.h             |    2 ++
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index a8d20568d532..6e0f34a38171 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -34,25 +34,16 @@ static int __init cmp_fake_mem(const void *x1, const void *x2)
 	return 0;
 }
 
-void __init efi_fake_memmap(void)
+static void __init efi_fake_range(struct efi_mem_range *efi_range)
 {
 	struct efi_memory_map_data data = { 0 };
 	int new_nr_map = efi.memmap.nr_map;
 	efi_memory_desc_t *md;
 	void *new_memmap;
-	int i;
-
-	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
-		return;
 
 	/* count up the number of EFI memory descriptor */
-	for (i = 0; i < nr_fake_mem; i++) {
-		for_each_efi_memory_desc(md) {
-			struct range *r = &efi_fake_mems[i].range;
-
-			new_nr_map += efi_memmap_split_count(md, r);
-		}
-	}
+	for_each_efi_memory_desc(md)
+		new_nr_map += efi_memmap_split_count(md, &efi_range->range);
 
 	/* allocate memory for new EFI memmap */
 	if (efi_memmap_alloc(new_nr_map, &data) != 0)
@@ -61,17 +52,27 @@ void __init efi_fake_memmap(void)
 	/* create new EFI memmap */
 	new_memmap = early_memremap(data.phys_map, data.size);
 	if (!new_memmap) {
-		memblock_free(data.phys_map, data.size);
+		__efi_memmap_free(data.phys_map, data.size, data.flags);
 		return;
 	}
 
-	for (i = 0; i < nr_fake_mem; i++)
-		efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
+	efi_memmap_insert(&efi.memmap, new_memmap, efi_range);
 
 	/* swap into new EFI memmap */
 	early_memunmap(new_memmap, data.size);
 
 	efi_memmap_install(&data);
+}
+
+void __init efi_fake_memmap(void)
+{
+	int i;
+
+	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
+		return;
+
+	for (i = 0; i < nr_fake_mem; i++)
+		efi_fake_range(&efi_fake_mems[i]);
 
 	/* print new EFI memmap */
 	efi_print_memmap();
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index bffa320d2f9a..1b6a4aa78a09 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -29,7 +29,7 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
 	return PFN_PHYS(page_to_pfn(p));
 }
 
-static void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
+void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
 {
 	if (flags & EFI_MEMMAP_MEMBLOCK) {
 		if (slab_is_available())
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 416eac01b1a1..539e81c942dc 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1062,6 +1062,8 @@ extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
 extern int __init efi_memmap_alloc(unsigned int num_entries,
 				   struct efi_memory_map_data *data);
+extern void __efi_memmap_free(u64 phys, unsigned long size,
+			      unsigned long flags);
 extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
 extern void __init efi_memmap_unmap(void);

