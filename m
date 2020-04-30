Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25C81C05F8
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 21:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgD3TMr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 15:12:47 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:40846 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD3TMr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 15:12:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id AA553180226EB;
        Thu, 30 Apr 2020 19:12:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:541:800:960:966:968:973:988:989:1260:1311:1314:1345:1359:1437:1515:1535:1605:1730:1747:1777:1792:2196:2199:2393:2559:2562:3138:3139:3140:3141:3142:3865:3866:3867:3868:3871:4050:4119:4250:4321:4385:4605:5007:6119:6261:7875:7904:8568:10004:10848:11026:11232:11473:11657:11658:11914:12043:12297:12438:12555:12663:12679:12895:12986:13894:14394:21063:21080:21212:21325:21433:21451:21627:21660:21966:21990:30003:30030:30046:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hour11_8c5d3857b5561
X-Filterd-Recvd-Size: 8645
Received: from joe-laptop.perches.com (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Apr 2020 19:12:44 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 1/2] efi/libstub: efi_info/efi_err message neatening
Date:   Thu, 30 Apr 2020 12:12:41 -0700
Message-Id: <091e3fc3bdbc5f480af7d3b3ac096d174a4480d0.1588273612.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200430182843.2510180-1-nivedita@alum.mit.edu>
References: <20200430182843.2510180-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use a standard style for these output logging messages.

Miscellanea:

o Use more common macro #defines with fmt, ##__VA_ARGS__
0 Remove trailing messages periods and odd ' uses
o Remove embedded function names and use %s, __func__

Signed-off-by: Joe Perches <joe@perches.com>
---

Perhaps these trivialities on top of this series?

 drivers/firmware/efi/libstub/arm32-stub.c | 10 +++++-----
 drivers/firmware/efi/libstub/efi-stub.c   |  2 +-
 drivers/firmware/efi/libstub/efistub.h    |  9 ++++++---
 drivers/firmware/efi/libstub/fdt.c        |  8 ++++----
 drivers/firmware/efi/libstub/pci.c        |  4 ++--
 drivers/firmware/efi/libstub/relocate.c   |  2 +-
 drivers/firmware/efi/libstub/secureboot.c |  4 ++--
 7 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index b038afe..5795781 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -120,7 +120,7 @@ static efi_status_t reserve_kernel_base(unsigned long dram_base,
 	 */
 	status = efi_get_memory_map(&map);
 	if (status != EFI_SUCCESS) {
-		efi_err("reserve_kernel_base(): Unable to retrieve memory map.\n");
+		efi_err("%s(): Unable to retrieve memory map\n", __func__);
 		return status;
 	}
 
@@ -162,7 +162,7 @@ static efi_status_t reserve_kernel_base(unsigned long dram_base,
 					     (end - start) / EFI_PAGE_SIZE,
 					     &start);
 			if (status != EFI_SUCCESS) {
-				efi_err("reserve_kernel_base(): alloc failed.\n");
+				efi_err("%s(): alloc failed\n", __func__);
 				goto out;
 			}
 			break;
@@ -219,7 +219,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 
 	status = reserve_kernel_base(kernel_base, reserve_addr, reserve_size);
 	if (status != EFI_SUCCESS) {
-		efi_err("Unable to allocate memory for uncompressed kernel.\n");
+		efi_err("Unable to allocate memory for uncompressed kernel\n");
 		return status;
 	}
 
@@ -232,7 +232,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	status = efi_relocate_kernel(image_addr, *image_size, *image_size,
 				     kernel_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to relocate kernel.\n");
+		efi_err("Failed to relocate kernel\n");
 		efi_free(*reserve_size, *reserve_addr);
 		*reserve_size = 0;
 		return status;
@@ -244,7 +244,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	 * address at which the zImage is loaded.
 	 */
 	if (*image_addr + *image_size > dram_base + ZIMAGE_OFFSET_LIMIT) {
-		efi_err("Failed to relocate kernel, no low memory available.\n");
+		efi_err("Failed to relocate kernel, no low memory available\n");
 		efi_free(*reserve_size, *reserve_addr);
 		*reserve_size = 0;
 		efi_free(*image_size, *image_addr);
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index c2484b..19b42b 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -251,7 +251,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
 	     secure_boot != efi_secureboot_mode_disabled) {
 		if (strstr(cmdline_ptr, "dtb="))
-			efi_err("Ignoring DTB from command line.\n");
+			efi_err("Ignoring DTB from command line\n");
 	} else {
 		status = efi_load_dtb(image, &fdt_addr, &fdt_size);
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 874233..369262 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -49,11 +49,14 @@ extern const efi_system_table_t *efi_system_table;
 #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
 #endif
 
-#define efi_info(msg)		do {			\
-	if (!efi_quiet) efi_printk("EFI stub: "msg);	\
+#define efi_info(fmt, ...)						\
+do {									\
+	if (!efi_quiet)							\
+		efi_printk("EFI stub: " fmt, ##__VA_ARGS__);		\
 } while (0)
 
-#define efi_err(msg) efi_printk("EFI stub: ERROR: "msg)
+#define efi_err(fmt, ...)						\
+	efi_printk("EFI stub: ERROR: " fmt, ##__VA_ARGS__)
 
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 11ecf3c..7c7257 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -270,7 +270,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	 */
 	status = efi_get_memory_map(&map);
 	if (status != EFI_SUCCESS) {
-		efi_err("Unable to retrieve UEFI memory map.\n");
+		efi_err("Unable to retrieve UEFI memory map\n");
 		return status;
 	}
 
@@ -279,7 +279,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	map.map = &memory_map;
 	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, max_addr);
 	if (status != EFI_SUCCESS) {
-		efi_err("Unable to allocate memory for new device tree.\n");
+		efi_err("Unable to allocate memory for new device tree\n");
 		goto fail;
 	}
 
@@ -296,7 +296,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 			    initrd_addr, initrd_size);
 
 	if (status != EFI_SUCCESS) {
-		efi_err("Unable to construct new device tree.\n");
+		efi_err("Unable to construct new device tree\n");
 		goto fail_free_new_fdt;
 	}
 
@@ -342,7 +342,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		return EFI_SUCCESS;
 	}
 
-	efi_err("Exit boot services failed.\n");
+	efi_err("Exit boot services failed\n");
 
 fail_free_new_fdt:
 	efi_free(MAX_FDT_SIZE, *new_fdt_addr);
diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
index 60af51b..111c44b 100644
--- a/drivers/firmware/efi/libstub/pci.c
+++ b/drivers/firmware/efi/libstub/pci.c
@@ -28,7 +28,7 @@ void efi_pci_disable_bridge_busmaster(void)
 
 	if (status != EFI_BUFFER_TOO_SMALL) {
 		if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
-			efi_err("Failed to locate PCI I/O handles'\n");
+			efi_err("Failed to locate PCI I/O handles\n");
 		return;
 	}
 
@@ -42,7 +42,7 @@ void efi_pci_disable_bridge_busmaster(void)
 	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL, &pci_proto,
 			     NULL, &pci_handle_size, pci_handle);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to locate PCI I/O handles'\n");
+		efi_err("Failed to locate PCI I/O handles\n");
 		goto free_handle;
 	}
 
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index 93c04d..62e2d6 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -157,7 +157,7 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 					     min_addr);
 	}
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate usable memory for kernel.\n");
+		efi_err("Failed to allocate usable memory for kernel\n");
 		return status;
 	}
 
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index 5efc524..796a31 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -67,10 +67,10 @@ enum efi_secureboot_mode efi_get_secureboot(void)
 		return efi_secureboot_mode_disabled;
 
 secure_boot_enabled:
-	efi_info("UEFI Secure Boot is enabled.\n");
+	efi_info("UEFI Secure Boot is enabled\n");
 	return efi_secureboot_mode_enabled;
 
 out_efi_err:
-	efi_err("Could not determine UEFI Secure Boot status.\n");
+	efi_err("Could not determine UEFI Secure Boot status\n");
 	return efi_secureboot_mode_unknown;
 }
-- 
2.26.0

