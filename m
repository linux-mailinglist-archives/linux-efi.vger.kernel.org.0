Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E061BE573
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgD2Rl0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 13:41:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46737 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgD2RlZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 13:41:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id g74so2842913qke.13;
        Wed, 29 Apr 2020 10:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esudLbF50xrd3X4yxmF75Z7c/P/j5/QO+86gC+Ihm+I=;
        b=eUPSb8OFFq2IV5RKikfia5EhsCnYUn92dttz/3vF4dTo0UPhO4jAdIaEv/h+EqBdpE
         YGJudFBcPqc59oHVCxpNbFgKtN7aIJbJtD/QHDjxRqljfVGkuw/NCEVDChjKwl0Rbz/k
         p8Sje/A1dcpTz6feGCwpROBy/QqeYGdDVQy7zc12vs3Aif4t4k+IdGPt/NRf1JLOQtI4
         TGnpBg/z/nHVjwNWJzy0B6x5rHtisJ78L/XZ3VJ1fTJtig2x3yFBNnqHviBAdX8+51kV
         8/mT8ezXfg6+biDNGBY67X2/i9A+tD+YQC4r05ufeP+x50Kwup18VKACXOB3rKkt8+gI
         Qutg==
X-Gm-Message-State: AGi0PuZ4ROJrGYY0wl6PffYdZthSRILzgHG7KlwlOl6j1oBdhRnQyzMB
        P+cu8F0L8ddJCur9Ev3BsIxfBjVImyM=
X-Google-Smtp-Source: APiQypInkqTX0HfGThjHulH7Fu43Los2Js/u4CzOAROOk1tAxlCH2E1pnmDqUe3E0o0i+/k5rUsQ3A==
X-Received: by 2002:ae9:ed04:: with SMTP id c4mr35152020qkg.367.1588182084734;
        Wed, 29 Apr 2020 10:41:24 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm14766448qkz.3.2020.04.29.10.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:41:24 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] efi/x86: Use pr_efi_err for error messages
Date:   Wed, 29 Apr 2020 13:41:13 -0400
Message-Id: <20200429174120.1497212-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429174120.1497212-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use pr_efi_err instead of bare efi_printk for error messages.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/x86-stub.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 677b5a1e0543..933205772d8c 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -49,7 +49,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
 			     (void **)&rom);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to allocate memory for 'rom'\n");
+		pr_efi_err("Failed to allocate memory for 'rom'\n");
 		return status;
 	}
 
@@ -65,7 +65,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 				PCI_VENDOR_ID, 1, &rom->vendor);
 
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to read rom->vendor\n");
+		pr_efi_err("Failed to read rom->vendor\n");
 		goto free_struct;
 	}
 
@@ -73,7 +73,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 				PCI_DEVICE_ID, 1, &rom->devid);
 
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to read rom->devid\n");
+		pr_efi_err("Failed to read rom->devid\n");
 		goto free_struct;
 	}
 
@@ -118,7 +118,7 @@ static void setup_efi_pci(struct boot_params *params)
 				     (void **)&pci_handle);
 
 		if (status != EFI_SUCCESS) {
-			efi_printk("Failed to allocate memory for 'pci_handle'\n");
+			pr_efi_err("Failed to allocate memory for 'pci_handle'\n");
 			return;
 		}
 
@@ -172,7 +172,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 		return;
 
 	if (efi_table_attr(p, version) != 0x10000) {
-		efi_printk("Unsupported properties proto version\n");
+		pr_efi_err("Unsupported properties proto version\n");
 		return;
 	}
 
@@ -185,7 +185,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 				     size + sizeof(struct setup_data),
 				     (void **)&new);
 		if (status != EFI_SUCCESS) {
-			efi_printk("Failed to allocate memory for 'properties'\n");
+			pr_efi_err("Failed to allocate memory for 'properties'\n");
 			return;
 		}
 
@@ -372,7 +372,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	status = efi_bs_call(handle_protocol, handle, &proto, (void **)&image);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
+		pr_efi_err("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
 		efi_exit(handle, status);
 	}
 
@@ -382,7 +382,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	status = efi_allocate_pages(sizeof(struct boot_params),
 				    (unsigned long *)&boot_params, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to allocate lowmem for boot params\n");
+		pr_efi_err("Failed to allocate lowmem for boot params\n");
 		efi_exit(handle, status);
 	}
 
@@ -749,7 +749,7 @@ unsigned long efi_main(efi_handle_t handle,
 					     hdr->kernel_alignment,
 					     LOAD_PHYSICAL_ADDR);
 		if (status != EFI_SUCCESS) {
-			efi_printk("efi_relocate_kernel() failed!\n");
+			pr_efi_err("efi_relocate_kernel() failed!\n");
 			goto fail;
 		}
 		/*
@@ -786,7 +786,7 @@ unsigned long efi_main(efi_handle_t handle,
 			efi_set_u64_split(size, &hdr->ramdisk_size,
 					  &boot_params->ext_ramdisk_size);
 		} else if (status != EFI_NOT_FOUND) {
-			efi_printk("efi_load_initrd_dev_path() failed!\n");
+			pr_efi_err("efi_load_initrd_dev_path() failed!\n");
 			goto fail;
 		}
 	}
@@ -813,13 +813,13 @@ unsigned long efi_main(efi_handle_t handle,
 
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
-		efi_printk("exit_boot() failed!\n");
+		pr_efi_err("exit_boot() failed!\n");
 		goto fail;
 	}
 
 	return bzimage_addr;
 fail:
-	efi_printk("efi_main() failed!\n");
+	pr_efi_err("efi_main() failed!\n");
 
 	efi_exit(handle, status);
 }
-- 
2.26.2

