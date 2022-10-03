Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C475F2F94
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 13:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJCL0p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 07:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJCL0n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 07:26:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0435411C16
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 04:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E473B8105A
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 11:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3ECC4347C;
        Mon,  3 Oct 2022 11:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664796397;
        bh=ZjDr14OxWTrew0/fwyFI+XUBboCoGDstHicLfif2Djw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxY/bRfjhtxLaZp+RLCj8LsBeH7rHezBCOV0B0BosD9Voq51KCp6mICHNQZ5Ug4lI
         fukIwRaNQit/mbut/F+dmvt07Pbuanyh5ido7DTpsVSXiX/SGgnxx7OyTPsF1lxU2W
         WJ2FQ4K0Bf2lg64zbnlGBEWb8U/xZkt5fxKrmmmedFuW2CY2PpZIlZwR54Zse2l6kV
         wd6LXmtYDCLfh7Zd+voJ6uPiUqaHhylCrSUSomr0erOhQTtmUnvFvzLr1MmVyoMJwi
         bJF8A1MWl8fxpuXoc7j2iCZnP2pZmVJy8Uw4cYU25gqBrSZj9i5tQlem3iuh5mTo5j
         SPvnR6hX5M1jA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: [PATCH v2 2/6] efi: memmap: Move manipulation routines into x86 arch tree
Date:   Mon,  3 Oct 2022 13:26:21 +0200
Message-Id: <20221003112625.972646-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221003112625.972646-1-ardb@kernel.org>
References: <20221003112625.972646-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17368; i=ardb@kernel.org; h=from:subject; bh=ZjDr14OxWTrew0/fwyFI+XUBboCoGDstHicLfif2Djw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjOsbYg6dqX0FgOlAp0B3+vbe93/8K1X6EJXBcxSer Yrj6+geJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzrG2AAKCRDDTyI5ktmPJP2YC/ 9WT0L6a3hxPwo9zokLU/i5YXQBAxRuRvN1iiXsD2aWDn0MhaURJXR3BtmTvAOwnKdqu5D3aHBk8VZC zjpzyBOyo/dufs4+tx0LAO8RBRUU8VSHa0/UlkIG8xJXui8s2LcA/EF4ym62OyVqD5f4N+KtKVo9wL BWW+axOJ1KnRj2Su2S8XYoK4Wn0DRaUQJsfAKAmZZnRBe+gE2hXrv71b3zQErfaGF/eSOKWncDym8+ 7LKamaAPo1+dWZP7QZyURbypNI03XyQb4AuE8cUlDjqDVNrZORmTubs2PZqrkj9febHXtteZYEKuCH nr4mvsF0o+VDcOcmY5/ZMWlAjdEgQBopSt514lEBdVphFBuqoa3OA1FIbZhDUnjfOAzlY2QhWVnOrM msyBu3Wnb8obJtr7j2lbmyS48g/Mi7qTNJZa59ZzYW3J0QrwSDAGnfSke2ax4D7ayknBRkBIOq5KKC ZEahyULh4jtcvHic9eggO6E77OtHGkgR4/Ht1dgz/4bfA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI memory map is a description of the memory layout as provided by
the firmware, and only x86 manipulates it in various different ways for
its own memory bookkeeping. So let's move the memmap routines that are
only used by x86 into the x86 arch tree.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     |  11 +
 arch/x86/platform/efi/Makefile |   3 +-
 arch/x86/platform/efi/memmap.c | 235 ++++++++++++++++++++
 drivers/firmware/efi/memmap.c  | 221 +-----------------
 include/linux/efi.h            |  10 +-
 5 files changed, 251 insertions(+), 229 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 68414d924332..1fb4686f3d12 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -415,6 +415,17 @@ static inline void efi_fake_memmap(void)
 }
 #endif
 
+extern int __init efi_memmap_alloc(unsigned int num_entries,
+				   struct efi_memory_map_data *data);
+extern void __efi_memmap_free(u64 phys, unsigned long size,
+			      unsigned long flags);
+
+extern int __init efi_memmap_install(struct efi_memory_map_data *data);
+extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
+					 struct range *range);
+extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
+				     void *buf, struct efi_mem_range *mem);
+
 #define arch_ima_efi_boot_mode	\
 	({ extern struct boot_params boot_params; boot_params.secure_boot; })
 
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index b481719b16cc..ed5502a5185d 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -2,6 +2,7 @@
 KASAN_SANITIZE := n
 GCOV_PROFILE := n
 
-obj-$(CONFIG_EFI) 		+= quirks.o efi.o efi_$(BITS).o efi_stub_$(BITS).o
+obj-$(CONFIG_EFI) 		+= memmap.o quirks.o efi.o efi_$(BITS).o \
+				   efi_stub_$(BITS).o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
 obj-$(CONFIG_EFI_FAKE_MEMMAP)	+= fake_mem.o
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
new file mode 100644
index 000000000000..44b886acf301
--- /dev/null
+++ b/arch/x86/platform/efi/memmap.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common EFI memory map functions.
+ */
+
+#define pr_fmt(fmt) "efi: " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/efi.h>
+#include <linux/io.h>
+#include <asm/early_ioremap.h>
+#include <linux/memblock.h>
+#include <linux/slab.h>
+
+static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
+{
+	return memblock_phys_alloc(size, SMP_CACHE_BYTES);
+}
+
+static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
+{
+	unsigned int order = get_order(size);
+	struct page *p = alloc_pages(GFP_KERNEL, order);
+
+	if (!p)
+		return 0;
+
+	return PFN_PHYS(page_to_pfn(p));
+}
+
+void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
+{
+	if (flags & EFI_MEMMAP_MEMBLOCK) {
+		if (slab_is_available())
+			memblock_free_late(phys, size);
+		else
+			memblock_phys_free(phys, size);
+	} else if (flags & EFI_MEMMAP_SLAB) {
+		struct page *p = pfn_to_page(PHYS_PFN(phys));
+		unsigned int order = get_order(size);
+
+		free_pages((unsigned long) page_address(p), order);
+	}
+}
+
+/**
+ * efi_memmap_alloc - Allocate memory for the EFI memory map
+ * @num_entries: Number of entries in the allocated map.
+ * @data: efi memmap installation parameters
+ *
+ * Depending on whether mm_init() has already been invoked or not,
+ * either memblock or "normal" page allocation is used.
+ *
+ * Returns zero on success, a negative error code on failure.
+ */
+int __init efi_memmap_alloc(unsigned int num_entries,
+		struct efi_memory_map_data *data)
+{
+	/* Expect allocation parameters are zero initialized */
+	WARN_ON(data->phys_map || data->size);
+
+	data->size = num_entries * efi.memmap.desc_size;
+	data->desc_version = efi.memmap.desc_version;
+	data->desc_size = efi.memmap.desc_size;
+	data->flags &= ~(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK);
+	data->flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
+
+	if (slab_is_available()) {
+		data->flags |= EFI_MEMMAP_SLAB;
+		data->phys_map = __efi_memmap_alloc_late(data->size);
+	} else {
+		data->flags |= EFI_MEMMAP_MEMBLOCK;
+		data->phys_map = __efi_memmap_alloc_early(data->size);
+	}
+
+	if (!data->phys_map)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * efi_memmap_install - Install a new EFI memory map in efi.memmap
+ * @ctx: map allocation parameters (address, size, flags)
+ *
+ * Unlike efi_memmap_init_*(), this function does not allow the caller
+ * to switch from early to late mappings. It simply uses the existing
+ * mapping function and installs the new memmap.
+ *
+ * Returns zero on success, a negative error code on failure.
+ */
+int __init efi_memmap_install(struct efi_memory_map_data *data)
+{
+	efi_memmap_unmap();
+
+	return __efi_memmap_init(data);
+}
+
+/**
+ * efi_memmap_split_count - Count number of additional EFI memmap entries
+ * @md: EFI memory descriptor to split
+ * @range: Address range (start, end) to split around
+ *
+ * Returns the number of additional EFI memmap entries required to
+ * accommodate @range.
+ */
+int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
+{
+	u64 m_start, m_end;
+	u64 start, end;
+	int count = 0;
+
+	start = md->phys_addr;
+	end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+	/* modifying range */
+	m_start = range->start;
+	m_end = range->end;
+
+	if (m_start <= start) {
+		/* split into 2 parts */
+		if (start < m_end && m_end < end)
+			count++;
+	}
+
+	if (start < m_start && m_start < end) {
+		/* split into 3 parts */
+		if (m_end < end)
+			count += 2;
+		/* split into 2 parts */
+		if (end <= m_end)
+			count++;
+	}
+
+	return count;
+}
+
+/**
+ * efi_memmap_insert - Insert a memory region in an EFI memmap
+ * @old_memmap: The existing EFI memory map structure
+ * @buf: Address of buffer to store new map
+ * @mem: Memory map entry to insert
+ *
+ * It is suggested that you call efi_memmap_split_count() first
+ * to see how large @buf needs to be.
+ */
+void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
+			      struct efi_mem_range *mem)
+{
+	u64 m_start, m_end, m_attr;
+	efi_memory_desc_t *md;
+	u64 start, end;
+	void *old, *new;
+
+	/* modifying range */
+	m_start = mem->range.start;
+	m_end = mem->range.end;
+	m_attr = mem->attribute;
+
+	/*
+	 * The EFI memory map deals with regions in EFI_PAGE_SIZE
+	 * units. Ensure that the region described by 'mem' is aligned
+	 * correctly.
+	 */
+	if (!IS_ALIGNED(m_start, EFI_PAGE_SIZE) ||
+	    !IS_ALIGNED(m_end + 1, EFI_PAGE_SIZE)) {
+		WARN_ON(1);
+		return;
+	}
+
+	for (old = old_memmap->map, new = buf;
+	     old < old_memmap->map_end;
+	     old += old_memmap->desc_size, new += old_memmap->desc_size) {
+
+		/* copy original EFI memory descriptor */
+		memcpy(new, old, old_memmap->desc_size);
+		md = new;
+		start = md->phys_addr;
+		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+		if (m_start <= start && end <= m_end)
+			md->attribute |= m_attr;
+
+		if (m_start <= start &&
+		    (start < m_end && m_end < end)) {
+			/* first part */
+			md->attribute |= m_attr;
+			md->num_pages = (m_end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+			/* latter part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_end + 1;
+			md->num_pages = (end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+		}
+
+		if ((start < m_start && m_start < end) && m_end < end) {
+			/* first part */
+			md->num_pages = (m_start - md->phys_addr) >>
+				EFI_PAGE_SHIFT;
+			/* middle part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->attribute |= m_attr;
+			md->phys_addr = m_start;
+			md->num_pages = (m_end - m_start + 1) >>
+				EFI_PAGE_SHIFT;
+			/* last part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_end + 1;
+			md->num_pages = (end - m_end) >>
+				EFI_PAGE_SHIFT;
+		}
+
+		if ((start < m_start && m_start < end) &&
+		    (end <= m_end)) {
+			/* first part */
+			md->num_pages = (m_start - md->phys_addr) >>
+				EFI_PAGE_SHIFT;
+			/* latter part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_start;
+			md->num_pages = (end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+			md->attribute |= m_attr;
+		}
+	}
+}
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 6ec7970dbd40..3501d3814f22 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -13,35 +13,8 @@
 #include <linux/memblock.h>
 #include <linux/slab.h>
 
-static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
+void __weak __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
 {
-	return memblock_phys_alloc(size, SMP_CACHE_BYTES);
-}
-
-static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
-{
-	unsigned int order = get_order(size);
-	struct page *p = alloc_pages(GFP_KERNEL, order);
-
-	if (!p)
-		return 0;
-
-	return PFN_PHYS(page_to_pfn(p));
-}
-
-void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
-{
-	if (flags & EFI_MEMMAP_MEMBLOCK) {
-		if (slab_is_available())
-			memblock_free_late(phys, size);
-		else
-			memblock_phys_free(phys, size);
-	} else if (flags & EFI_MEMMAP_SLAB) {
-		struct page *p = pfn_to_page(PHYS_PFN(phys));
-		unsigned int order = get_order(size);
-
-		free_pages((unsigned long) page_address(p), order);
-	}
 }
 
 static void __init efi_memmap_free(void)
@@ -51,41 +24,6 @@ static void __init efi_memmap_free(void)
 			efi.memmap.flags);
 }
 
-/**
- * efi_memmap_alloc - Allocate memory for the EFI memory map
- * @num_entries: Number of entries in the allocated map.
- * @data: efi memmap installation parameters
- *
- * Depending on whether mm_init() has already been invoked or not,
- * either memblock or "normal" page allocation is used.
- *
- * Returns zero on success, a negative error code on failure.
- */
-int __init efi_memmap_alloc(unsigned int num_entries,
-		struct efi_memory_map_data *data)
-{
-	/* Expect allocation parameters are zero initialized */
-	WARN_ON(data->phys_map || data->size);
-
-	data->size = num_entries * efi.memmap.desc_size;
-	data->desc_version = efi.memmap.desc_version;
-	data->desc_size = efi.memmap.desc_size;
-	data->flags &= ~(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK);
-	data->flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
-
-	if (slab_is_available()) {
-		data->flags |= EFI_MEMMAP_SLAB;
-		data->phys_map = __efi_memmap_alloc_late(data->size);
-	} else {
-		data->flags |= EFI_MEMMAP_MEMBLOCK;
-		data->phys_map = __efi_memmap_alloc_early(data->size);
-	}
-
-	if (!data->phys_map)
-		return -ENOMEM;
-	return 0;
-}
-
 /**
  * __efi_memmap_init - Common code for mapping the EFI memory map
  * @data: EFI memory map data
@@ -101,7 +39,7 @@ int __init efi_memmap_alloc(unsigned int num_entries,
  *
  * Returns zero on success, a negative error code on failure.
  */
-static int __init __efi_memmap_init(struct efi_memory_map_data *data)
+int __init __efi_memmap_init(struct efi_memory_map_data *data)
 {
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
@@ -220,158 +158,3 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 
 	return __efi_memmap_init(&data);
 }
-
-/**
- * efi_memmap_install - Install a new EFI memory map in efi.memmap
- * @ctx: map allocation parameters (address, size, flags)
- *
- * Unlike efi_memmap_init_*(), this function does not allow the caller
- * to switch from early to late mappings. It simply uses the existing
- * mapping function and installs the new memmap.
- *
- * Returns zero on success, a negative error code on failure.
- */
-int __init efi_memmap_install(struct efi_memory_map_data *data)
-{
-	efi_memmap_unmap();
-
-	return __efi_memmap_init(data);
-}
-
-/**
- * efi_memmap_split_count - Count number of additional EFI memmap entries
- * @md: EFI memory descriptor to split
- * @range: Address range (start, end) to split around
- *
- * Returns the number of additional EFI memmap entries required to
- * accommodate @range.
- */
-int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
-{
-	u64 m_start, m_end;
-	u64 start, end;
-	int count = 0;
-
-	start = md->phys_addr;
-	end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
-
-	/* modifying range */
-	m_start = range->start;
-	m_end = range->end;
-
-	if (m_start <= start) {
-		/* split into 2 parts */
-		if (start < m_end && m_end < end)
-			count++;
-	}
-
-	if (start < m_start && m_start < end) {
-		/* split into 3 parts */
-		if (m_end < end)
-			count += 2;
-		/* split into 2 parts */
-		if (end <= m_end)
-			count++;
-	}
-
-	return count;
-}
-
-/**
- * efi_memmap_insert - Insert a memory region in an EFI memmap
- * @old_memmap: The existing EFI memory map structure
- * @buf: Address of buffer to store new map
- * @mem: Memory map entry to insert
- *
- * It is suggested that you call efi_memmap_split_count() first
- * to see how large @buf needs to be.
- */
-void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
-			      struct efi_mem_range *mem)
-{
-	u64 m_start, m_end, m_attr;
-	efi_memory_desc_t *md;
-	u64 start, end;
-	void *old, *new;
-
-	/* modifying range */
-	m_start = mem->range.start;
-	m_end = mem->range.end;
-	m_attr = mem->attribute;
-
-	/*
-	 * The EFI memory map deals with regions in EFI_PAGE_SIZE
-	 * units. Ensure that the region described by 'mem' is aligned
-	 * correctly.
-	 */
-	if (!IS_ALIGNED(m_start, EFI_PAGE_SIZE) ||
-	    !IS_ALIGNED(m_end + 1, EFI_PAGE_SIZE)) {
-		WARN_ON(1);
-		return;
-	}
-
-	for (old = old_memmap->map, new = buf;
-	     old < old_memmap->map_end;
-	     old += old_memmap->desc_size, new += old_memmap->desc_size) {
-
-		/* copy original EFI memory descriptor */
-		memcpy(new, old, old_memmap->desc_size);
-		md = new;
-		start = md->phys_addr;
-		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
-
-		if (m_start <= start && end <= m_end)
-			md->attribute |= m_attr;
-
-		if (m_start <= start &&
-		    (start < m_end && m_end < end)) {
-			/* first part */
-			md->attribute |= m_attr;
-			md->num_pages = (m_end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-			/* latter part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_end + 1;
-			md->num_pages = (end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-		}
-
-		if ((start < m_start && m_start < end) && m_end < end) {
-			/* first part */
-			md->num_pages = (m_start - md->phys_addr) >>
-				EFI_PAGE_SHIFT;
-			/* middle part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->attribute |= m_attr;
-			md->phys_addr = m_start;
-			md->num_pages = (m_end - m_start + 1) >>
-				EFI_PAGE_SHIFT;
-			/* last part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_end + 1;
-			md->num_pages = (end - m_end) >>
-				EFI_PAGE_SHIFT;
-		}
-
-		if ((start < m_start && m_start < end) &&
-		    (end <= m_end)) {
-			/* first part */
-			md->num_pages = (m_start - md->phys_addr) >>
-				EFI_PAGE_SHIFT;
-			/* latter part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_start;
-			md->num_pages = (end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-			md->attribute |= m_attr;
-		}
-	}
-}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a6dbf354d2c3..256e70e42114 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -707,18 +707,10 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
 #endif
 extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
-extern int __init efi_memmap_alloc(unsigned int num_entries,
-				   struct efi_memory_map_data *data);
-extern void __efi_memmap_free(u64 phys, unsigned long size,
-			      unsigned long flags);
+extern int __init __efi_memmap_init(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
 extern void __init efi_memmap_unmap(void);
-extern int __init efi_memmap_install(struct efi_memory_map_data *data);
-extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
-					 struct range *range);
-extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
-				     void *buf, struct efi_mem_range *mem);
 
 #ifdef CONFIG_EFI_ESRT
 extern void __init efi_esrt_init(void);
-- 
2.35.1

