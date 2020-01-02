Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE4612E259
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 05:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgABE3g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jan 2020 23:29:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:12925 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgABE3g (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 1 Jan 2020 23:29:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 20:29:35 -0800
X-IronPort-AV: E=Sophos;i="5.69,385,1571727600"; 
   d="scan'208";a="369228461"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 20:29:35 -0800
Subject: [PATCH v3 3/4] efi: Fix efi_memmap_alloc() leaks
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org
Date:   Wed, 01 Jan 2020 20:13:33 -0800
Message-ID: <157793841381.977550.3798473750871197840.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157793839827.977550.7845382457971215205.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157793839827.977550.7845382457971215205.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
updated and replaced multiple times. When that happens a previous
dynamically allocated efi memory map can be garbage collected. Use the
new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
allocated memory map is being replaced.

Debug statements in efi_memmap_free() reveal:

 efi: __efi_memmap_free:37: phys: 0x23ffdd580 size: 2688 flags: 0x2
 efi: __efi_memmap_free:37: phys: 0x9db00 size: 2640 flags: 0x2
 efi: __efi_memmap_free:37: phys: 0x9e580 size: 2640 flags: 0x2

...a savings of 7968 bytes on a qemu boot with 2 entries specified to
efi_fake_mem=.

Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/efi/memmap.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 2b81ee6858a9..46c8b4056cc1 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -29,6 +29,28 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
 	return PFN_PHYS(page_to_pfn(p));
 }
 
+static void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
+{
+	if (flags & EFI_MEMMAP_MEMBLOCK) {
+		if (slab_is_available())
+			memblock_free_late(phys, size);
+		else
+			memblock_free(phys, size);
+	} else if (flags & EFI_MEMMAP_SLAB) {
+		struct page *p = pfn_to_page(PHYS_PFN(phys));
+		unsigned int order = get_order(size);
+
+		free_pages((unsigned long) page_address(p), order);
+	}
+}
+
+static void __init efi_memmap_free(void)
+{
+	__efi_memmap_free(efi.memmap.phys_map,
+			efi.memmap.desc_size * efi.memmap.nr_map,
+			efi.memmap.flags);
+}
+
 /**
  * efi_memmap_alloc - Allocate memory for the EFI memory map
  * @num_entries: Number of entries in the allocated map.
@@ -90,6 +112,8 @@ __efi_memmap_init(struct efi_memory_map_data *data, unsigned long flags)
 		return -ENOMEM;
 	}
 
+	efi_memmap_free();
+
 	map.phys_map = data->phys_map;
 	map.nr_map = data->size / data->desc_size;
 	map.map_end = map.map + data->size;

