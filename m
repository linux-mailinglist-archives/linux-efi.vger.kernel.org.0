Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0AE1C04CB
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 20:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD3S3T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 14:29:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46839 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgD3S2t (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 14:28:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id g26so2021873qtv.13;
        Thu, 30 Apr 2020 11:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcUky9yBFN6ujB2ntYpTB7VTKktGaxpi4ejrL8P/h1E=;
        b=IT/oguN7Hb5Vgqb/O42N0xDirTMQiA6lg975+g5uwDSHNND+omuwwPHnUSY6KbJAo9
         cLN+zR91REjEDwuxxpa4TYSjamk6mVdSF08suYO3MuWzS80RW29MEI06XXeCmoIsBlMX
         XrGWpBuT3wzhNe/eEIDkXMZvlgc1nFAteP2Wp2ePmBDDKgGqagF9yJ+/RlkntTIFp5Du
         8IdJkCv/Ls/itbxsjFi2iNKzqpDv5bCD+p6D/H/4L8/gzjUjMPClTK843k7crVDyIjl6
         4EIaKvGf0sepaL4PjYvxm47I7SewxBD6VsQQAsdGJqzB+MkknWponc0Gbvi8KdjSWgoa
         q71Q==
X-Gm-Message-State: AGi0PuYxZm0agi93YEB8iH88GDe4O4uAs0FVJ0zOPKMJ7jeokKYRhZJU
        +CzhoSSg+piaGxyeUC9fqI8=
X-Google-Smtp-Source: APiQypIBF4h0Sb4L6jCOjmBFl+PgKD/JDvijNoStoUeXHpCicvKNOwruxLaaUA2juYJqRgN1nFGN9w==
X-Received: by 2002:aed:34a5:: with SMTP id x34mr4852067qtd.216.1588271328308;
        Thu, 30 Apr 2020 11:28:48 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v27sm449785qtb.35.2020.04.30.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:28:47 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] efi/x86: Use efi_err for error messages
Date:   Thu, 30 Apr 2020 14:28:36 -0400
Message-Id: <20200430182843.2510180-5-nivedita@alum.mit.edu>
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

Use efi_err instead of bare efi_printk for error messages.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
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
2.26.2

