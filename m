Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9AEAE78F
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2019 12:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405587AbfIJKES (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Sep 2019 06:04:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405459AbfIJKES (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Sep 2019 06:04:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 768C620EC;
        Tue, 10 Sep 2019 10:04:17 +0000 (UTC)
Received: from wlc-trust-99.pek2.redhat.com (wlc-trust-99.pek2.redhat.com [10.72.3.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3FF55D9DC;
        Tue, 10 Sep 2019 10:04:10 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH] x86, efi: never relocate the kernel below LOAD_PHYSICAL_ADDR
Date:   Tue, 10 Sep 2019 18:03:50 +0800
Message-Id: <20190910100350.32537-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 10 Sep 2019 10:04:17 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

For efi boot, loader may load the kernel to anywhere, and if kernel is not
loaded at pref_address (LOAD_PHYSICAL_ADDR), efi_relocate_kernel will try
to relocate kernel to a position that is suitable for boot. Currently it
will try to relocate the kernel to pref_address and fallback to reserve
as low as possible. Thing could go wrong with the fallback case. As later
when calculating the decompressed kernel start address, kernel will force
use LOAD_PHYSICAL_ADDR if the current address is lower than
LOAD_PHYSICAL_ADDR. This can not guarantee the new chosen load address
is usable as it is not allocated from EFI firmware and may caused
unexpected behavior.

On some HyperV machine when booting with EFI, and have a INIT_SIZE value
within certain range, the efi_relocate_kernel will fail to reserve
preferred address as the load address, and fallback to alloc as low as
possible, result in an address lower than LOAD_PHYSICAL_ADDR. And this
problem caused the system to reset when booting up.

A more detail process based on the problem occurred on that HyperV
machine:

- kernel (INIT_SIZE: 56820K) got loaded at 0x3c881000 (not aligned,
  and not equal to pref_address 0x1000000), need to relocate.

- efi_relocate_kernel is called, try to allocate INIT_SIZE of memory
  at pref_address, failed, something else occupied this region.

- efi_relocate_kernel call efi_low_alloc as fallback, and got the address
  0x800000 (Below 0x1000000)

- Later in arch/x86/boot/compressed/head_64.S:108, LOAD_PHYSICAL_ADDR is
  force used as the new load address as the current address is lower than
  that. Then kernel try relocate to 0x1000000.

- However the memory starting from 0x1000000 is not allocated from EFI
  firmware, writing to this region caused the system to reset.

To fix it, let efi_low_alloc accept an extra min_addr argument, to restrict
the lower bound of an allocation. And don't relocate the kernel lower
than LOAD_PHYSICAL_ADDR when failed to reserve the preferred address.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/boot/compressed/eboot.c               |  8 +++++---
 drivers/firmware/efi/libstub/arm32-stub.c      |  2 +-
 drivers/firmware/efi/libstub/arm64-stub.c      |  2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 12 ++++++++----
 include/linux/efi.h                            |  5 +++--
 5 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index d6662fdef300..e89e84b66527 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -13,6 +13,7 @@
 #include <asm/e820/types.h>
 #include <asm/setup.h>
 #include <asm/desc.h>
+#include <asm/boot.h>
 
 #include "../string.h"
 #include "eboot.h"
@@ -413,7 +414,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	}
 
 	status = efi_low_alloc(sys_table, 0x4000, 1,
-			       (unsigned long *)&boot_params);
+			       (unsigned long *)&boot_params, 0);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table, "Failed to allocate lowmem for boot params\n");
 		return NULL;
@@ -798,7 +799,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 
 	gdt->size = 0x800;
 	status = efi_low_alloc(sys_table, gdt->size, 8,
-			   (unsigned long *)&gdt->address);
+			       (unsigned long *)&gdt->address, 0);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table, "Failed to allocate memory for 'gdt'\n");
 		goto fail;
@@ -813,7 +814,8 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 		status = efi_relocate_kernel(sys_table, &bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
-					     hdr->kernel_alignment);
+					     hdr->kernel_alignment,
+					     LOAD_PHYSICAL_ADDR);
 		if (status != EFI_SUCCESS) {
 			efi_printk(sys_table, "efi_relocate_kernel() failed!\n");
 			goto fail;
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index e8f7aefb6813..bf6f954d6afe 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -220,7 +220,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	*image_size = image->image_size;
 	status = efi_relocate_kernel(sys_table, image_addr, *image_size,
 				     *image_size,
-				     dram_base + MAX_UNCOMP_KERNEL_SIZE, 0);
+				     dram_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table, "Failed to relocate kernel.\n");
 		efi_free(sys_table, *reserve_size, *reserve_addr);
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 1550d244e996..3d2e517e10f4 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -140,7 +140,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 	if (status != EFI_SUCCESS) {
 		*reserve_size = kernel_memsize + TEXT_OFFSET;
 		status = efi_low_alloc(sys_table_arg, *reserve_size,
-				       MIN_KIMG_ALIGN, reserve_addr);
+				       MIN_KIMG_ALIGN, reserve_addr, 0);
 
 		if (status != EFI_SUCCESS) {
 			pr_efi_err(sys_table_arg, "Failed to relocate kernel\n");
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3caae7f2cf56..00b00a2562aa 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -260,11 +260,11 @@ efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
 }
 
 /*
- * Allocate at the lowest possible address.
+ * Allocate at the lowest possible address that is not below 'min'.
  */
 efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 			   unsigned long size, unsigned long align,
-			   unsigned long *addr)
+			   unsigned long *addr, unsigned long min)
 {
 	unsigned long map_size, desc_size, buff_size;
 	efi_memory_desc_t *map;
@@ -311,6 +311,9 @@ efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 		start = desc->phys_addr;
 		end = start + desc->num_pages * EFI_PAGE_SIZE;
 
+		if (start < min)
+			start = min;
+
 		/*
 		 * Don't allocate at 0x0. It will confuse code that
 		 * checks pointers against NULL. Skip the first 8
@@ -698,7 +701,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
 				 unsigned long preferred_addr,
-				 unsigned long alignment)
+				 unsigned long alignment,
+				 unsigned long min_addr)
 {
 	unsigned long cur_image_addr;
 	unsigned long new_addr = 0;
@@ -732,7 +736,7 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 	 */
 	if (status != EFI_SUCCESS) {
 		status = efi_low_alloc(sys_table_arg, alloc_size, alignment,
-				       &new_addr);
+				       &new_addr, min_addr);
 	}
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table_arg, "Failed to allocate usable memory for kernel.\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index f87fabea4a85..cc947c0f3e06 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1587,7 +1587,7 @@ efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
 
 efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 			   unsigned long size, unsigned long align,
-			   unsigned long *addr);
+			   unsigned long *addr, unsigned long min);
 
 efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
 			    unsigned long size, unsigned long align,
@@ -1598,7 +1598,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
 				 unsigned long preferred_addr,
-				 unsigned long alignment);
+				 unsigned long alignment,
+				 unsigned long min_addr);
 
 efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 				  efi_loaded_image_t *image,
-- 
2.21.0

