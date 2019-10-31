Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F380BEAF7C
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 12:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfJaL4R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Oct 2019 07:56:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55495 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfJaLze (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Oct 2019 07:55:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92z-0003B7-LM; Thu, 31 Oct 2019 12:55:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 30DF41C0494;
        Thu, 31 Oct 2019 12:55:14 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:13 -0000
From:   "tip-bot2 for Kairui Song" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] x86, efi: Never relocate kernel below lowest
 acceptable address
Cc:     Kairui Song <kasong@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191029173755.27149-6-ardb@kernel.org>
References: <20191029173755.27149-6-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <157252291389.29376.11703637548575936536.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     220dd7699c46d5940115bd797b01b2ab047c87b8
Gitweb:        https://git.kernel.org/tip/220dd7699c46d5940115bd797b01b2ab047c87b8
Author:        Kairui Song <kasong@redhat.com>
AuthorDate:    Tue, 29 Oct 2019 18:37:54 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 31 Oct 2019 09:40:19 +01:00

x86, efi: Never relocate kernel below lowest acceptable address

Currently, kernel fails to boot on some HyperV VMs when using EFI.
And it's a potential issue on all x86 platforms.

It's caused by broken kernel relocation on EFI systems, when below three
conditions are met:

1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
   by the loader.
2. There isn't enough room to contain the kernel, starting from the
   default load address (eg. something else occupied part the region).
3. In the memmap provided by EFI firmware, there is a memory region
   starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
   kernel.

EFI stub will perform a kernel relocation when condition 1 is met. But
due to condition 2, EFI stub can't relocate kernel to the preferred
address, so it fallback to ask EFI firmware to alloc lowest usable memory
region, got the low region mentioned in condition 3, and relocated
kernel there.

It's incorrect to relocate the kernel below LOAD_PHYSICAL_ADDR. This
is the lowest acceptable kernel relocation address.

The first thing goes wrong is in arch/x86/boot/compressed/head_64.S.
Kernel decompression will force use LOAD_PHYSICAL_ADDR as the output
address if kernel is located below it. Then the relocation before
decompression, which move kernel to the end of the decompression buffer,
will overwrite other memory region, as there is no enough memory there.

To fix it, just don't let EFI stub relocate the kernel to any address
lower than lowest acceptable address.

[ ardb: introduce efi_low_alloc_above() to reduce the scope of the change ]

Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: https://lkml.kernel.org/r/20191029173755.27149-6-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/eboot.c               |  4 ++-
 drivers/firmware/efi/libstub/arm32-stub.c      |  2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 24 +++++++----------
 include/linux/efi.h                            | 18 +++++++++++--
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index d6662fd..82bc60c 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -13,6 +13,7 @@
 #include <asm/e820/types.h>
 #include <asm/setup.h>
 #include <asm/desc.h>
+#include <asm/boot.h>
 
 #include "../string.h"
 #include "eboot.h"
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
index ffa242a..41213bf 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -230,7 +230,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	*image_size = image->image_size;
 	status = efi_relocate_kernel(sys_table, image_addr, *image_size,
 				     *image_size,
-				     kernel_base + MAX_UNCOMP_KERNEL_SIZE, 0);
+				     kernel_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table, "Failed to relocate kernel.\n");
 		efi_free(sys_table, *reserve_size, *reserve_addr);
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3caae7f..35dbc27 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -260,11 +260,11 @@ fail:
 }
 
 /*
- * Allocate at the lowest possible address.
+ * Allocate at the lowest possible address that is not below 'min'.
  */
-efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
-			   unsigned long size, unsigned long align,
-			   unsigned long *addr)
+efi_status_t efi_low_alloc_above(efi_system_table_t *sys_table_arg,
+				 unsigned long size, unsigned long align,
+				 unsigned long *addr, unsigned long min)
 {
 	unsigned long map_size, desc_size, buff_size;
 	efi_memory_desc_t *map;
@@ -311,13 +311,8 @@ efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 		start = desc->phys_addr;
 		end = start + desc->num_pages * EFI_PAGE_SIZE;
 
-		/*
-		 * Don't allocate at 0x0. It will confuse code that
-		 * checks pointers against NULL. Skip the first 8
-		 * bytes so we start at a nice even number.
-		 */
-		if (start == 0x0)
-			start += 8;
+		if (start < min)
+			start = min;
 
 		start = round_up(start, align);
 		if ((start + size) > end)
@@ -698,7 +693,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
 				 unsigned long preferred_addr,
-				 unsigned long alignment)
+				 unsigned long alignment,
+				 unsigned long min_addr)
 {
 	unsigned long cur_image_addr;
 	unsigned long new_addr = 0;
@@ -731,8 +727,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 	 * possible.
 	 */
 	if (status != EFI_SUCCESS) {
-		status = efi_low_alloc(sys_table_arg, alloc_size, alignment,
-				       &new_addr);
+		status = efi_low_alloc_above(sys_table_arg, alloc_size,
+					     alignment, &new_addr, min_addr);
 	}
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table_arg, "Failed to allocate usable memory for kernel.\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bd38370..d87acf6 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1579,9 +1579,22 @@ char *efi_convert_cmdline(efi_system_table_t *sys_table_arg,
 efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
 				struct efi_boot_memmap *map);
 
+efi_status_t efi_low_alloc_above(efi_system_table_t *sys_table_arg,
+				 unsigned long size, unsigned long align,
+				 unsigned long *addr, unsigned long min);
+
+static inline
 efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 			   unsigned long size, unsigned long align,
-			   unsigned long *addr);
+			   unsigned long *addr)
+{
+	/*
+	 * Don't allocate at 0x0. It will confuse code that
+	 * checks pointers against NULL. Skip the first 8
+	 * bytes so we start at a nice even number.
+	 */
+	return efi_low_alloc_above(sys_table_arg, size, align, addr, 0x8);
+}
 
 efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
 			    unsigned long size, unsigned long align,
@@ -1592,7 +1605,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
 				 unsigned long preferred_addr,
-				 unsigned long alignment);
+				 unsigned long alignment,
+				 unsigned long min_addr);
 
 efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 				  efi_loaded_image_t *image,
