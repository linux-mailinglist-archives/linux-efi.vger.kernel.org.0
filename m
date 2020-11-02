Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8AE2A30E2
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 18:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgKBRHF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 12:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbgKBRHE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Nov 2020 12:07:04 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 848CC223B0;
        Mon,  2 Nov 2020 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604336823;
        bh=s+iJ6y9MdKA72ntr91x9rtfCZuHxY1/uKKB+tbv+MCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOs8KS08qOI0YzxHFdm/h8QHRlaDA9H7p/YaIgPrP8a1tKf7nrFRvzpISO6FHg1Xe
         ud3QamHcT9dpELCbwJD5cg+DgAu1bZEbaQfclOZscM8dXn0O+0unzP6vCrY/7b8Fl0
         owA/ClOdD8EcqQDI9pss4cb4f0EZf3HulAuiIVUk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 6/7] efi/libstub: consolidate initrd handling across architectures
Date:   Mon,  2 Nov 2020 18:06:33 +0100
Message-Id: <20201102170634.20575-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102170634.20575-1-ardb@kernel.org>
References: <20201102170634.20575-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Before adding TPM measurement of the initrd contents, refactor the
initrd handling slightly to be more self-contained and consistent.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 13 +++++++---
 drivers/firmware/efi/libstub/efi-stub.c        | 10 ++------
 drivers/firmware/efi/libstub/efistub.h         |  1 -
 drivers/firmware/efi/libstub/x86-stub.c        | 26 ++++++++------------
 4 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index aa8da0a49829..72a7e7c4d403 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -20,10 +20,10 @@
 
 bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
-bool efi_noinitrd;
 int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 bool efi_novamap;
 
+static bool efi_noinitrd;
 static bool efi_nosoftreserve;
 static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
@@ -643,8 +643,10 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 {
 	efi_status_t status;
 
-	if (!load_addr || !load_size)
-		return EFI_INVALID_PARAMETER;
+	if (efi_noinitrd) {
+		*load_addr = *load_size = 0;
+		return EFI_SUCCESS;
+	}
 
 	status = efi_load_initrd_dev_path(load_addr, load_size, hard_limit);
 	if (status == EFI_SUCCESS) {
@@ -655,7 +657,10 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 		if (status == EFI_SUCCESS && *load_size > 0)
 			efi_info("Loaded initrd from command line option\n");
 	}
-
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to load initrd: 0x%lx\n", status);
+		*load_addr = *load_size = 0;
+	}
 	return status;
 }
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 914a343c7785..ccc4e6f10ae6 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -122,7 +122,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	enum efi_secureboot_mode secure_boot;
 	struct screen_info *si;
 	efi_properties_table_t *prop_tbl;
-	unsigned long max_addr;
 
 	efi_system_table = sys_table_arg;
 
@@ -228,13 +227,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (!fdt_addr)
 		efi_info("Generating empty DTB\n");
 
-	if (!efi_noinitrd) {
-		max_addr = efi_get_max_initrd_addr(image_addr);
-		status = efi_load_initrd(image, &initrd_addr, &initrd_size,
-					 ULONG_MAX, max_addr);
-		if (status != EFI_SUCCESS)
-			efi_err("Failed to load initrd!\n");
-	}
+	efi_load_initrd(image, &initrd_addr, &initrd_size, ULONG_MAX,
+			efi_get_max_initrd_addr(image_addr));
 
 	efi_random_get_seed();
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c96085133648..a8f08bf2cbb5 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -31,7 +31,6 @@
 
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
-extern bool efi_noinitrd;
 extern int efi_loglevel;
 extern bool efi_novamap;
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3672539cb96e..1b4c15489bd6 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -673,6 +673,7 @@ unsigned long efi_main(efi_handle_t handle,
 	unsigned long bzimage_addr = (unsigned long)startup_32;
 	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
+	unsigned long addr, size;
 	efi_status_t status;
 
 	efi_system_table = sys_table_arg;
@@ -758,22 +759,15 @@ unsigned long efi_main(efi_handle_t handle,
 	 * arguments will be processed only if image is not NULL, which will be
 	 * the case only if we were loaded via the PE entry point.
 	 */
-	if (!efi_noinitrd) {
-		unsigned long addr, size;
-
-		status = efi_load_initrd(image, &addr, &size,
-					 hdr->initrd_addr_max, ULONG_MAX);
-
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to load initrd!\n");
-			goto fail;
-		}
-		if (size > 0) {
-			efi_set_u64_split(addr, &hdr->ramdisk_image,
-					  &boot_params->ext_ramdisk_image);
-			efi_set_u64_split(size, &hdr->ramdisk_size,
-					  &boot_params->ext_ramdisk_size);
-		}
+	status = efi_load_initrd(image, &addr, &size, hdr->initrd_addr_max,
+				 ULONG_MAX);
+	if (status != EFI_SUCCESS)
+		goto fail;
+	if (size > 0) {
+		efi_set_u64_split(addr, &hdr->ramdisk_image,
+				  &boot_params->ext_ramdisk_image);
+		efi_set_u64_split(size, &hdr->ramdisk_size,
+				  &boot_params->ext_ramdisk_size);
 	}
 
 	/*
-- 
2.17.1

