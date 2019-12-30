Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D25D012D453
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 21:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfL3UO0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 15:14:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:61436 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfL3UOZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Dec 2019 15:14:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2019 12:14:25 -0800
X-IronPort-AV: E=Sophos;i="5.69,376,1571727600"; 
   d="scan'208";a="213420200"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2019 12:14:25 -0800
Subject: [PATCH] efi: Fix handling of multiple contiguous efi_fake_mem=
 entries
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Dave Young <dyoung@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, kexec@lists.infradead.org
Date:   Mon, 30 Dec 2019 11:58:23 -0800
Message-ID: <157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A recent test of efi_fake_mem=4G@9G:0x40000,4G@13G:0x40000 crashed with
a signature of:

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

efi_memmap_insert() is attempting to insert entries past the end of the
new map. This condition is setup by efi_fake_mem() leaking empty entries
to the end of memory map, and then efi_arch_mem_reserve() trips over the
bad entry when attempting an additional efi_memmap_insert(). The empty
entry causes efi_memmap_insert() to attempt more memmap splits / copies
than efi_memmap_split_count() accounted for when sizing the new map.

Update efi_fake_memmap() to cleanup lagging empty entries.

This change is related to commit af1648984828 "x86/efi: Update e820 with
reserved EFI boot services data to fix kexec breakage" since that
introduces more occurrences where efi_memmap_insert() is invoked after
an efi_fake_mem= configuration has been parsed. Previously the side
effects of vestigial empty entries were benign, but with commit
af1648984828 that follow-on efi_memmap_insert() invocation triggers the
above crash signature.

Fixes: 0f96a99dab36 ("efi: Add 'efi_fake_mem' boot option")
Fixes: af1648984828 ("x86/efi: Update e820 with reserved EFI boot services...")
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Michael Weiser <michael@weiser.dinsnail.net>
Cc: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/efi/fake_mem.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index bb9fc70d0cfa..6df51ba93ae8 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -67,13 +67,33 @@ void __init efi_fake_memmap(void)
 		return;
 	}
 
+	memset(new_memmap, 0, efi.memmap.desc_size * new_nr_map);
 	for (i = 0; i < nr_fake_mem; i++)
 		efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
 
+	/*
+	 * efi_memmap_split_count() may over count the number of
+	 * required splits in the case when contiguous fake entries are
+	 * specified. Check that all new_nr_map entries were consumed.
+	 */
+	for (i = new_nr_map; i > 0; i--) {
+		efi_memory_desc_t *md;
+		u64 start, end;
+
+		md = new_memmap + efi.memmap.desc_size * (new_nr_map - i - 1);
+		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+		start = md->phys_addr;
+
+		if (start == 0 && end + 1 == 0)
+			continue;
+		break;
+	}
+
 	/* swap into new EFI memmap */
 	early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
 
-	efi_memmap_install(new_memmap_phy, new_nr_map);
+	/* install only the valid entries */
+	efi_memmap_install(new_memmap_phy, i);
 
 	/* print new EFI memmap */
 	efi_print_memmap();

