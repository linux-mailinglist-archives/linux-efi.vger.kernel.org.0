Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B61139780
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2020 18:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgAMRXf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jan 2020 12:23:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbgAMRXe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Jan 2020 12:23:34 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B9752081E;
        Mon, 13 Jan 2020 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578936214;
        bh=DA2b6/3T3fG/fQwNZi6iqo4jIIatk8iTU5FAbNaWkwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZF5bInE9tGhqX8cZA4RaJALH4SbULs0vREQE8OrKu2RwVEivp6mFSGuTVhTtQIs4Z
         HHMX5tIHpUi86qLkW1CL39vp4DwkYEpa6U1OpeCj04twnVtIIeIe+ypm3122tWB9jO
         k0YMVJ6ke1lGEJTg4jfZlmR78mJY+2mMuaUaZwT8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 12/13] efi: Fix efi_memmap_alloc() leaks
Date:   Mon, 13 Jan 2020 18:22:44 +0100
Message-Id: <20200113172245.27925-13-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113172245.27925-1-ardb@kernel.org>
References: <20200113172245.27925-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

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

[ ardb: added a comment to clarify that efi_memmap_free() does nothing when
        called from efi_clean_memmap(), i.e., with data->flags == 0x0 ]

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/memmap.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 04dfa56b994b..501672166502 100644
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
@@ -100,6 +122,9 @@ static int __init __efi_memmap_init(struct efi_memory_map_data *data)
 		return -ENOMEM;
 	}
 
+	/* NOP if data->flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB) == 0 */
+	efi_memmap_free();
+
 	map.phys_map = data->phys_map;
 	map.nr_map = data->size / data->desc_size;
 	map.map_end = map.map + data->size;
-- 
2.20.1

