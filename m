Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3406C1B766E
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgDXNHw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbgDXNHD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:07:03 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691942084D;
        Fri, 24 Apr 2020 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733622;
        bh=AUIhmBrwWQvg0vpZYTLhZ9VphUoWGT7eDzR6HRlUqCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzPk+3RuUPCwUi+pruyNZDaPaEjC3YYFHJXFhjoEp+HiI8lPsnXuXnPeBtA9Bj2/R
         VHiczgapVnNO4tyczrSWu6aQMVSu+TEifJkoCA/BpjVWhhmpdPuDazRxcf8n4mwauk
         nJ+e7HUJsmrMDRSP4k8wF956bhXxO9RyoovajNJk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 23/33] efi/libstub: Add API function to allocate aligned memory
Date:   Fri, 24 Apr 2020 15:05:21 +0200
Message-Id: <20200424130531.30518-24-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Break out the code to create an aligned page allocation from mem.c
and move it into a function efi_allocate_pages_aligned() in alignedmem.c.
Update efi_allocate_pages() to invoke it unless the minimum alignment
equals the EFI page size (4 KB), in which case the ordinary page
allocator is sufficient. This way, efi_allocate_pages_aligned() will
only be pulled into the build if it is actually being used (which will
be on arm64 only in the immediate future)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile     |  3 +-
 drivers/firmware/efi/libstub/alignedmem.c | 57 +++++++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h    |  3 ++
 drivers/firmware/efi/libstub/mem.c        | 25 ++++------
 4 files changed, 71 insertions(+), 17 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/alignedmem.c

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 75cb2c3a1519..bb8af2b16c49 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -42,7 +42,8 @@ KCOV_INSTRUMENT			:= n
 
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
-				   skip_spaces.o lib-cmdline.o lib-ctype.o
+				   skip_spaces.o lib-cmdline.o lib-ctype.o \
+				   alignedmem.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
new file mode 100644
index 000000000000..cc89c4d6196f
--- /dev/null
+++ b/drivers/firmware/efi/libstub/alignedmem.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+/**
+ * efi_allocate_pages_aligned() - Allocate memory pages
+ * @size:	minimum number of bytes to allocate
+ * @addr:	On return the address of the first allocated page. The first
+ *		allocated page has alignment EFI_ALLOC_ALIGN which is an
+ *		architecture dependent multiple of the page size.
+ * @max:	the address that the last allocated memory page shall not
+ *		exceed
+ * @align:	minimum alignment of the base of the allocation
+ *
+ * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned according
+ * to @align, which should be >= EFI_ALLOC_ALIGN. The last allocated page will
+ * not exceed the address given by @max.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
+					unsigned long max, unsigned long align)
+{
+	efi_physical_addr_t alloc_addr;
+	efi_status_t status;
+	int slack;
+
+	if (align < EFI_ALLOC_ALIGN)
+		align = EFI_ALLOC_ALIGN;
+
+	alloc_addr = ALIGN_DOWN(max + 1, align) - 1;
+	size = round_up(size, EFI_ALLOC_ALIGN);
+	slack = align / EFI_PAGE_SIZE - 1;
+
+	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
+			     EFI_LOADER_DATA, size / EFI_PAGE_SIZE + slack,
+			     &alloc_addr);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	*addr = ALIGN((unsigned long)alloc_addr, align);
+
+	if (slack > 0) {
+		int l = (alloc_addr % align) / EFI_PAGE_SIZE;
+
+		if (l) {
+			efi_bs_call(free_pages, alloc_addr, slack - l + 1);
+			slack = l - 1;
+		}
+		if (slack)
+			efi_bs_call(free_pages, *addr + size, slack);
+	}
+	return EFI_SUCCESS;
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 9af65be3b278..baa0bc166074 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -657,6 +657,9 @@ efi_status_t efi_low_alloc(unsigned long size, unsigned long align,
 efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 				unsigned long max);
 
+efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
+					unsigned long max, unsigned long align);
+
 efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 869a79c8946f..0020b0fa9587 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -93,31 +93,24 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
 efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 				unsigned long max)
 {
-	efi_physical_addr_t alloc_addr = ALIGN_DOWN(max + 1, EFI_ALLOC_ALIGN) - 1;
-	int slack = EFI_ALLOC_ALIGN / EFI_PAGE_SIZE - 1;
+	efi_physical_addr_t alloc_addr;
 	efi_status_t status;
 
-	size = round_up(size, EFI_ALLOC_ALIGN);
+	if (EFI_ALLOC_ALIGN > EFI_PAGE_SIZE)
+		return efi_allocate_pages_aligned(size, addr, max,
+						  EFI_ALLOC_ALIGN);
+
+	alloc_addr = ALIGN_DOWN(max + 1, EFI_ALLOC_ALIGN) - 1;
 	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
-			     EFI_LOADER_DATA, size / EFI_PAGE_SIZE + slack,
+			     EFI_LOADER_DATA, DIV_ROUND_UP(size, EFI_PAGE_SIZE),
 			     &alloc_addr);
 	if (status != EFI_SUCCESS)
 		return status;
 
-	*addr = ALIGN((unsigned long)alloc_addr, EFI_ALLOC_ALIGN);
-
-	if (slack > 0) {
-		int l = (alloc_addr % EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
-
-		if (l) {
-			efi_bs_call(free_pages, alloc_addr, slack - l + 1);
-			slack = l - 1;
-		}
-		if (slack)
-			efi_bs_call(free_pages, *addr + size, slack);
-	}
+	*addr = alloc_addr;
 	return EFI_SUCCESS;
 }
+
 /**
  * efi_low_alloc_above() - allocate pages at or above given address
  * @size:	size of the memory area to allocate
-- 
2.17.1

