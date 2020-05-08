Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41FB1CB68A
	for <lists+linux-efi@lfdr.de>; Fri,  8 May 2020 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEHSCm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 May 2020 14:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgEHSCl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 May 2020 14:02:41 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F972184D;
        Fri,  8 May 2020 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960960;
        bh=MShStUH0SyUusi3VC7mLRP+NpMvAKqWnINbb+1eHpsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLNg8ILNtEVyA7BiL2T9jQl5t/npVwReW7ccay2m5LsCZzr6REJUkHZZknpc/7xR/
         JJslzb/Izrf4sWDaAevT6SRkHYJw4t0y/fMrdb7fHx4DEHoQyrQ6igLi5XoLRH5yc2
         gDFj4fLv2SnzNhPm/SfmXp9pjPibO7RgNxmHYdis=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 08/15] efi/x86: Move command-line initrd loading to efi_main
Date:   Fri,  8 May 2020 20:01:50 +0200
Message-Id: <20200508180157.1816-9-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508180157.1816-1-ardb@kernel.org>
References: <20200508180157.1816-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Consolidate the initrd loading in efi_main.

The command line options now need to be parsed only once.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200430182843.2510180-9-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 64 ++++++++++---------------
 1 file changed, 25 insertions(+), 39 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3800eb22232e..defeb6035109 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -22,6 +22,7 @@
 
 const efi_system_table_t *efi_system_table;
 extern u32 image_offset;
+static efi_loaded_image_t *image = NULL;
 
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
@@ -355,7 +356,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 {
 	struct boot_params *boot_params;
 	struct setup_header *hdr;
-	efi_loaded_image_t *image;
 	void *image_base;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
@@ -414,30 +414,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->ramdisk_image = 0;
 	hdr->ramdisk_size = 0;
 
-	if (efi_is_native()) {
-		status = efi_parse_options(cmdline_ptr);
-		if (status != EFI_SUCCESS)
-			goto fail2;
-
-		if (!efi_noinitrd) {
-			status = efi_load_initrd(image, &ramdisk_addr,
-						 &ramdisk_size,
-						 hdr->initrd_addr_max,
-						 ULONG_MAX);
-			if (status != EFI_SUCCESS)
-				goto fail2;
-			efi_set_u64_split(ramdisk_addr, &hdr->ramdisk_image,
-					  &boot_params->ext_ramdisk_image);
-			efi_set_u64_split(ramdisk_size, &hdr->ramdisk_size,
-					  &boot_params->ext_ramdisk_size);
-		}
-	}
-
 	efi_stub_entry(handle, sys_table_arg, boot_params);
 	/* not reached */
 
-fail2:
-	efi_free(options_size, (unsigned long)cmdline_ptr);
 fail:
 	efi_free(sizeof(struct boot_params), (unsigned long)boot_params);
 
@@ -760,35 +739,42 @@ unsigned long efi_main(efi_handle_t handle,
 		image_offset = 0;
 	}
 
-	/*
-	 * efi_pe_entry() may have been called before efi_main(), in which
-	 * case this is the second time we parse the cmdline. This is ok,
-	 * parsing the cmdline multiple times does not have side-effects.
-	 */
 	cmdline_paddr = ((u64)hdr->cmd_line_ptr |
 			 ((u64)boot_params->ext_cmd_line_ptr << 32));
 	efi_parse_options((char *)cmdline_paddr);
 
 	/*
-	 * At this point, an initrd may already have been loaded, either by
-	 * the bootloader and passed via bootparams, or loaded from a initrd=
-	 * command line option by efi_pe_entry() above. In either case, we
-	 * permit an initrd loaded from the LINUX_EFI_INITRD_MEDIA_GUID device
-	 * path to supersede it.
+	 * At this point, an initrd may already have been loaded by the
+	 * bootloader and passed via bootparams. We permit an initrd loaded
+	 * from the LINUX_EFI_INITRD_MEDIA_GUID device path to supersede it.
+	 *
+	 * If the device path is not present, any command-line initrd=
+	 * arguments will be processed only if image is not NULL, which will be
+	 * the case only if we were loaded via the PE entry point.
 	 */
 	if (!efi_noinitrd) {
 		unsigned long addr, size;
 
 		status = efi_load_initrd_dev_path(&addr, &size, ULONG_MAX);
-		if (status == EFI_SUCCESS) {
-			efi_set_u64_split(addr, &hdr->ramdisk_image,
-					  &boot_params->ext_ramdisk_image);
-			efi_set_u64_split(size, &hdr->ramdisk_size,
-					  &boot_params->ext_ramdisk_size);
-		} else if (status != EFI_NOT_FOUND) {
-			efi_err("efi_load_initrd_dev_path() failed!\n");
+		if (status == EFI_NOT_FOUND) {
+			if (efi_is_native() && image != NULL) {
+				status = efi_load_initrd(image, &addr, &size,
+							 hdr->initrd_addr_max,
+							 ULONG_MAX);
+			} else {
+				addr = size = 0;
+				status = EFI_SUCCESS;
+			}
+		}
+
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to load initrd!\n");
 			goto fail;
 		}
+		efi_set_u64_split(addr, &hdr->ramdisk_image,
+				  &boot_params->ext_ramdisk_image);
+		efi_set_u64_split(size, &hdr->ramdisk_size,
+				  &boot_params->ext_ramdisk_size);
 	}
 
 	/*
-- 
2.17.1

