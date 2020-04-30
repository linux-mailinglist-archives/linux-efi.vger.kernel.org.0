Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392641C04BA
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD3S2z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 14:28:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43379 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgD3S2x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 14:28:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id z90so5838980qtd.10;
        Thu, 30 Apr 2020 11:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvvhYDna6EfvdTe1EFC8TykL9olBG5L6vgOZEBBbHPA=;
        b=fsHhk/1ZLgOROCTDu0v2BRMKqv0BuxF7CA5UzmgsEWfF2qH0N4eneUq/vam6qjoGJh
         35L29EzE7HkBEgfSm7VwQ/CnX8T4NWTaMB6pGY/YHDymNovQ6m9jOS1YR4E8+YgQjNSP
         88uJDIhbSN4ByqKffLacQKeUUeXDnL/skixDaqn852PEKAFvQiP/5xvXANQ51PHIGwKg
         X9q0jJh5yh+LHiZRckGswHHcllEqFC6c0UBoqAaIk3N6PE4Y3NlBgjJuPQhfElj+AmxZ
         q7oymlJfNXFx9I0a60Ppxv1aSl76N7Tzr+gz2D3rL86v4/4ctJMzngj5KPAyK1hcavm1
         4mdg==
X-Gm-Message-State: AGi0PuY6/yvrrVSwj/Zvo4Wugu5lL/xtvFAegK6ExoLDXALMJsU1v11Q
        KAZUIhcr7Hfk2frFwK10UQWXfrT2KBg=
X-Google-Smtp-Source: APiQypK6vkXxEcYpCf+PO0hSyhXr9T+JpsypsnX0kXkXiRikZsHzKnXW6dLFJNdH0q8kXMfiFkdkOQ==
X-Received: by 2002:ac8:6f66:: with SMTP id u6mr5038738qtv.201.1588271331486;
        Thu, 30 Apr 2020 11:28:51 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v27sm449785qtb.35.2020.04.30.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:28:50 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] efi/x86: Move command-line initrd loading to efi_main
Date:   Thu, 30 Apr 2020 14:28:40 -0400
Message-Id: <20200430182843.2510180-9-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430182843.2510180-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200430182843.2510180-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Consolidate the initrd loading in efi_main.

The command line options now need to be parsed only once.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
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
2.26.2

