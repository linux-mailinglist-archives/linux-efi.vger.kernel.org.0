Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30C613977E
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2020 18:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgAMRXb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jan 2020 12:23:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728923AbgAMRXa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Jan 2020 12:23:30 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5D5A214AF;
        Mon, 13 Jan 2020 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578936209;
        bh=x9TTkFxU4CKU8Ii3qVXXqis0Dv6loWv7+lGjAMLiEKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/l4VOs2PDhOyMyZ4NGBzwr6Aa7MMMG41hkZuZpAxozyYqiJ1/BO/K3u10aYJ5jyE
         7puKV3Md6Q8cCSSMp7xYYK+qvYv9qhpd8WBLug263n7BQhpwYvIPXP2Yqb1xbSFeLX
         vi+4a0y3qkDfuiQ9AE+h3kS9FVxUDEe0BQNHCzwA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 10/13] efi: Add a flags parameter to efi_memory_map
Date:   Mon, 13 Jan 2020 18:22:42 +0100
Message-Id: <20200113172245.27925-11-ardb@kernel.org>
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

In preparation for garbage collecting dynamically allocated efi memory
maps, where the allocation method of memblock vs slab needs to be
recalled, convert the existing 'late' flag into a 'flags' bitmask.

Arrange for the flag to be passed via 'struct efi_memory_map_data'. This
structure grows additional flags in follow-on changes.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/memmap.c | 31 +++++++++++++++++--------------
 include/linux/efi.h           |  4 +++-
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 38b686c67b17..4f98eb12c172 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -52,21 +52,20 @@ phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
 /**
  * __efi_memmap_init - Common code for mapping the EFI memory map
  * @data: EFI memory map data
- * @late: Use early or late mapping function?
  *
  * This function takes care of figuring out which function to use to
  * map the EFI memory map in efi.memmap based on how far into the boot
  * we are.
  *
- * During bootup @late should be %false since we only have access to
- * the early_memremap*() functions as the vmalloc space isn't setup.
- * Once the kernel is fully booted we can fallback to the more robust
- * memremap*() API.
+ * During bootup EFI_MEMMAP_LATE in data->flags should be clear since we
+ * only have access to the early_memremap*() functions as the vmalloc
+ * space isn't setup.  Once the kernel is fully booted we can fallback
+ * to the more robust memremap*() API.
  *
  * Returns zero on success, a negative error code on failure.
  */
 static int __init
-__efi_memmap_init(struct efi_memory_map_data *data, bool late)
+__efi_memmap_init(struct efi_memory_map_data *data)
 {
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
@@ -76,7 +75,7 @@ __efi_memmap_init(struct efi_memory_map_data *data, bool late)
 
 	phys_map = data->phys_map;
 
-	if (late)
+	if (data->flags & EFI_MEMMAP_LATE)
 		map.map = memremap(phys_map, data->size, MEMREMAP_WB);
 	else
 		map.map = early_memremap(phys_map, data->size);
@@ -92,7 +91,7 @@ __efi_memmap_init(struct efi_memory_map_data *data, bool late)
 
 	map.desc_version = data->desc_version;
 	map.desc_size = data->desc_size;
-	map.late = late;
+	map.flags = data->flags;
 
 	set_bit(EFI_MEMMAP, &efi.flags);
 
@@ -111,9 +110,10 @@ __efi_memmap_init(struct efi_memory_map_data *data, bool late)
 int __init efi_memmap_init_early(struct efi_memory_map_data *data)
 {
 	/* Cannot go backwards */
-	WARN_ON(efi.memmap.late);
+	WARN_ON(efi.memmap.flags & EFI_MEMMAP_LATE);
 
-	return __efi_memmap_init(data, false);
+	data->flags = 0;
+	return __efi_memmap_init(data);
 }
 
 void __init efi_memmap_unmap(void)
@@ -121,7 +121,7 @@ void __init efi_memmap_unmap(void)
 	if (!efi_enabled(EFI_MEMMAP))
 		return;
 
-	if (!efi.memmap.late) {
+	if (!(efi.memmap.flags & EFI_MEMMAP_LATE)) {
 		unsigned long size;
 
 		size = efi.memmap.desc_size * efi.memmap.nr_map;
@@ -162,13 +162,14 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 	struct efi_memory_map_data data = {
 		.phys_map = addr,
 		.size = size,
+		.flags = EFI_MEMMAP_LATE,
 	};
 
 	/* Did we forget to unmap the early EFI memmap? */
 	WARN_ON(efi.memmap.map);
 
 	/* Were we already called? */
-	WARN_ON(efi.memmap.late);
+	WARN_ON(efi.memmap.flags & EFI_MEMMAP_LATE);
 
 	/*
 	 * It makes no sense to allow callers to register different
@@ -178,7 +179,7 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 	data.desc_version = efi.memmap.desc_version;
 	data.desc_size = efi.memmap.desc_size;
 
-	return __efi_memmap_init(&data, true);
+	return __efi_memmap_init(&data);
 }
 
 /**
@@ -195,6 +196,7 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
 {
 	struct efi_memory_map_data data;
+	unsigned long flags;
 
 	efi_memmap_unmap();
 
@@ -202,8 +204,9 @@ int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
 	data.size = efi.memmap.desc_size * nr_map;
 	data.desc_version = efi.memmap.desc_version;
 	data.desc_size = efi.memmap.desc_size;
+	data.flags = efi.memmap.flags & EFI_MEMMAP_LATE;
 
-	return __efi_memmap_init(&data, efi.memmap.late);
+	return __efi_memmap_init(&data);
 }
 
 /**
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7e8e25b1d11c..f117d68c314e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -767,6 +767,7 @@ struct efi_memory_map_data {
 	unsigned long size;
 	unsigned long desc_version;
 	unsigned long desc_size;
+	unsigned long flags;
 };
 
 struct efi_memory_map {
@@ -776,7 +777,8 @@ struct efi_memory_map {
 	int nr_map;
 	unsigned long desc_version;
 	unsigned long desc_size;
-	bool late;
+#define EFI_MEMMAP_LATE (1UL << 0)
+	unsigned long flags;
 };
 
 struct efi_mem_range {
-- 
2.20.1

