Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C9157F67
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgBJQD0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgBJQD0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:26 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC3F2467B;
        Mon, 10 Feb 2020 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350605;
        bh=JmxN+QByh25YY+an/+C8asdfGCNNoif4mUIvCTyf8Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZHK4ypjCnjLbYNABZnl3XGunqU88zbBcSabD1qhOsuS4CNf/JQsJTeUCZmSQp3S5
         /Cop5/7Tu82t2QOpFcJWIXTS9ctel6iPFqp+h34kYEqp2Hlo7htj0BCm3TGa7juKwI
         XB+Xe478sTE+ACYrZHcOj4bDPVvxg+LVe4MJvXj0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 16/19] efi/libstub: Take soft and hard memory limits into account for initrd loading
Date:   Mon, 10 Feb 2020 17:02:45 +0100
Message-Id: <20200210160248.4889-17-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On x86, the preferred load address of the initrd is still below 4 GB,
even though in some cases, we can cope with an initrd that is loaded
above that.

To simplify the code, and to make it more straightforward to introduce
other ways to load the initrd, pass the soft and hard memory limits at
the same time, and let the code handling the initrd= command line option
deal with this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm-stub.c |  2 +-
 drivers/firmware/efi/libstub/efistub.h  |  3 ++-
 drivers/firmware/efi/libstub/file.c     | 21 ++++++++++++++------
 drivers/firmware/efi/libstub/x86-stub.c | 11 ++--------
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 9b12f9b19533..2edc673ea06c 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -258,7 +258,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	if (!fdt_addr)
 		pr_efi("Generating empty DTB\n");
 
-	status = efi_load_initrd(image, &initrd_addr, &initrd_size,
+	status = efi_load_initrd(image, &initrd_addr, &initrd_size, ULONG_MAX,
 				 efi_get_max_initrd_addr(dram_base, *image_addr));
 	if (status != EFI_SUCCESS)
 		pr_efi_err("Failed initrd from command line!\n");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 60d929469b8b..d282d907cd33 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -619,6 +619,7 @@ efi_status_t efi_load_dtb(efi_loaded_image_t *image,
 efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long *load_addr,
 			     unsigned long *load_size,
-			     unsigned long max_addr);
+			     unsigned long soft_limit,
+			     unsigned long hard_limit);
 
 #endif
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 0d67432ed067..be78f64f8d80 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -123,7 +123,8 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
 static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 					 const efi_char16_t *optstr,
 					 int optstr_size,
-					 unsigned long max_addr,
+					 unsigned long soft_limit,
+					 unsigned long hard_limit,
 					 unsigned long *load_addr,
 					 unsigned long *load_size)
 {
@@ -179,8 +180,15 @@ static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 		    round_up(alloc_size, EFI_ALLOC_ALIGN)) {
 			unsigned long old_addr = alloc_addr;
 
-			status = efi_allocate_pages(alloc_size + size, &alloc_addr,
-						    max_addr);
+			status = EFI_OUT_OF_RESOURCES;
+			if (soft_limit < hard_limit)
+				status = efi_allocate_pages(alloc_size + size,
+							    &alloc_addr,
+							    soft_limit);
+			if (status == EFI_OUT_OF_RESOURCES)
+				status = efi_allocate_pages(alloc_size + size,
+							    &alloc_addr,
+							    hard_limit);
 			if (status != EFI_SUCCESS) {
 				pr_efi_err("Failed to reallocate memory for files\n");
 				goto err_close_file;
@@ -236,14 +244,15 @@ efi_status_t efi_load_dtb(efi_loaded_image_t *image,
 			  unsigned long *load_size)
 {
 	return handle_cmdline_files(image, L"dtb=", sizeof(L"dtb=") - 2,
-				    ULONG_MAX, load_addr, load_size);
+				    ULONG_MAX, ULONG_MAX, load_addr, load_size);
 }
 
 efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long *load_addr,
 			     unsigned long *load_size,
-			     unsigned long max_addr)
+			     unsigned long soft_limit,
+			     unsigned long hard_limit)
 {
 	return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
-				    max_addr, load_addr, load_size);
+				    soft_limit, hard_limit, load_addr, load_size);
 }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 39d04735f1c5..52a1a2df2071 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -422,15 +422,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		goto fail2;
 
 	status = efi_load_initrd(image, &ramdisk_addr, &ramdisk_size,
-				 hdr->initrd_addr_max);
-
-	if (status != EFI_SUCCESS &&
-	    hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G) {
-		efi_printk("Trying to load files to higher address\n");
-		status = efi_load_initrd(image, &ramdisk_addr, &ramdisk_size,
-					 ULONG_MAX);
-	}
-
+				 hdr->initrd_addr_max,
+				 above4g ? ULONG_MAX : hdr->initrd_addr_max);
 	if (status != EFI_SUCCESS)
 		goto fail2;
 	hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
-- 
2.17.1

