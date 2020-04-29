Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A3D1BE580
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 19:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgD2Rls (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 13:41:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42132 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgD2Rl2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 13:41:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id b188so2860067qkd.9;
        Wed, 29 Apr 2020 10:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQn5aZZK1QUl6M8PsTtJbe8TpANyEvuWjsi+0//GA9Q=;
        b=O94nDGZeFCKGtjGaciU03RKErllX/1eQnVaSU0Im7rbZLqpo24x1PoCRxuqtqGNzJh
         pYAAbythJCHRbK9LBhL67/Wny1vLADonIKe4fVf0ITMCZygM3weX+Upa/F55uLetFsiP
         MW6abfkJZD7gIlMY/IxY0/NnAhKdg3KiSMOaGnJooSkMrzC/t6yv21kHoiMVVMVfrkC9
         ksRfLhOY7uEdigH0DdtE5n65IYmSj/UyszfynyAUIXv+XnY9JHx/zzPHGWj0xpIlp9SG
         yAe//U3pWm8UK/5siOyQ0mXu26+5VznvcugFNslIrIx/Zd7JTPQW5tJIiDUaNStxMYa5
         AgoQ==
X-Gm-Message-State: AGi0PuZ7B2I6mCFEuhx9uFX8PB4wIYkJEbb1knzjJhpAXK5Hglo5W+Jy
        7M6qRjCrzsRohmtN59NxE2COHEvhGyw=
X-Google-Smtp-Source: APiQypJzu6DBfkoLOuv3YgL5r9EH4Lm1GaVcmPyIDAROJBqNwM8YLMz2035Dtbma/Zo/sPMVJ+5ewQ==
X-Received: by 2002:a37:5102:: with SMTP id f2mr17562452qkb.18.1588182087102;
        Wed, 29 Apr 2020 10:41:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm14766448qkz.3.2020.04.29.10.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:41:26 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] efi/x86: Move command-line initrd loading to efi_main
Date:   Wed, 29 Apr 2020 13:41:16 -0400
Message-Id: <20200429174120.1497212-8-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429174120.1497212-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
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
index 933205772d8c..ee4241df4f29 100644
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
-			pr_efi_err("efi_load_initrd_dev_path() failed!\n");
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
+			pr_efi_err("Failed to load initrd!\n");
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

