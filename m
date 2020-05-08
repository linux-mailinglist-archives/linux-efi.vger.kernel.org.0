Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E6E1CB683
	for <lists+linux-efi@lfdr.de>; Fri,  8 May 2020 20:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgEHSCb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 May 2020 14:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgEHSCa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 May 2020 14:02:30 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE92D24955;
        Fri,  8 May 2020 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960950;
        bh=aX7noN0CE3VZISjBSblgX/mv+dJHPf/z31kzvo4mAK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3GfqbOUIUq3iwQXdxzX9boYtPcdBdZvDFAREN8j5894lgWAJHNwhnI4VSfTRTjtL
         aYzmk/+od3X7Rb10GFTu/pdzKZAj/Y2tmJqISjF86+nF7N2+kqWnolKJT6nrp3FUxy
         ytMcpU0fhhKVypXOqksnJTBC3JpatfYHwpk9LqnE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 04/15] efi/x86: Use efi_err for error messages
Date:   Fri,  8 May 2020 20:01:46 +0200
Message-Id: <20200508180157.1816-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508180157.1816-1-ardb@kernel.org>
References: <20200508180157.1816-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Use efi_err instead of bare efi_printk for error messages.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200430182843.2510180-5-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f91d4aab0156..3800eb22232e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -49,7 +49,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
 			     (void **)&rom);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to allocate memory for 'rom'\n");
+		efi_err("Failed to allocate memory for 'rom'\n");
 		return status;
 	}
 
@@ -65,7 +65,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 				PCI_VENDOR_ID, 1, &rom->vendor);
 
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to read rom->vendor\n");
+		efi_err("Failed to read rom->vendor\n");
 		goto free_struct;
 	}
 
@@ -73,7 +73,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 				PCI_DEVICE_ID, 1, &rom->devid);
 
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to read rom->devid\n");
+		efi_err("Failed to read rom->devid\n");
 		goto free_struct;
 	}
 
@@ -118,7 +118,7 @@ static void setup_efi_pci(struct boot_params *params)
 				     (void **)&pci_handle);
 
 		if (status != EFI_SUCCESS) {
-			efi_printk("Failed to allocate memory for 'pci_handle'\n");
+			efi_err("Failed to allocate memory for 'pci_handle'\n");
 			return;
 		}
 
@@ -172,7 +172,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 		return;
 
 	if (efi_table_attr(p, version) != 0x10000) {
-		efi_printk("Unsupported properties proto version\n");
+		efi_err("Unsupported properties proto version\n");
 		return;
 	}
 
@@ -185,7 +185,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 				     size + sizeof(struct setup_data),
 				     (void **)&new);
 		if (status != EFI_SUCCESS) {
-			efi_printk("Failed to allocate memory for 'properties'\n");
+			efi_err("Failed to allocate memory for 'properties'\n");
 			return;
 		}
 
@@ -372,7 +372,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	status = efi_bs_call(handle_protocol, handle, &proto, (void **)&image);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
+		efi_err("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
 		efi_exit(handle, status);
 	}
 
@@ -382,7 +382,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	status = efi_allocate_pages(sizeof(struct boot_params),
 				    (unsigned long *)&boot_params, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to allocate lowmem for boot params\n");
+		efi_err("Failed to allocate lowmem for boot params\n");
 		efi_exit(handle, status);
 	}
 
@@ -749,7 +749,7 @@ unsigned long efi_main(efi_handle_t handle,
 					     hdr->kernel_alignment,
 					     LOAD_PHYSICAL_ADDR);
 		if (status != EFI_SUCCESS) {
-			efi_printk("efi_relocate_kernel() failed!\n");
+			efi_err("efi_relocate_kernel() failed!\n");
 			goto fail;
 		}
 		/*
@@ -786,7 +786,7 @@ unsigned long efi_main(efi_handle_t handle,
 			efi_set_u64_split(size, &hdr->ramdisk_size,
 					  &boot_params->ext_ramdisk_size);
 		} else if (status != EFI_NOT_FOUND) {
-			efi_printk("efi_load_initrd_dev_path() failed!\n");
+			efi_err("efi_load_initrd_dev_path() failed!\n");
 			goto fail;
 		}
 	}
@@ -813,13 +813,13 @@ unsigned long efi_main(efi_handle_t handle,
 
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
-		efi_printk("exit_boot() failed!\n");
+		efi_err("exit_boot() failed!\n");
 		goto fail;
 	}
 
 	return bzimage_addr;
 fail:
-	efi_printk("efi_main() failed!\n");
+	efi_err("efi_main() failed!\n");
 
 	efi_exit(handle, status);
 }
-- 
2.17.1

