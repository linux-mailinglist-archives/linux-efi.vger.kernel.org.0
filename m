Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5BD1785EF
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 23:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgCCWu7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 17:50:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgCCWu7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Mar 2020 17:50:59 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBB51206D5;
        Tue,  3 Mar 2020 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583275858;
        bh=kD3TgwpfeB4BdM3BVdG6yiF3l66qoxKOPWlfE5Llr7I=;
        h=From:To:Cc:Subject:Date:From;
        b=JmXJYQu32b3MEF5ZwjMTrWVwQIUpdvvJ8LOQ+0T5XzG7ekAYx7MWfugIVboupNCLQ
         kbYFRse77UDXFWme7NqNmJMRiAQyG9f5COlunhg/zfBX8bY9e1OCZGArzNFpPZuPSf
         S9w07KcQTtLotkhNitZ8rsoM3qbCetKn+PQbjsdA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nivedita@alum.mit.edu, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/libstub/x86: use ULONG_MAX as upper bound for all allocations
Date:   Tue,  3 Mar 2020 23:50:54 +0100
Message-Id: <20200303225054.28741-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The header flag XLF_CAN_BE_LOADED_ABOVE_4G will inform us whether
allocations above 4 GiB for kernel, command line, etc are permitted,
so we take it into account when calling efi_allocate_pages() etc.

However, CONFIG_EFI_STUB implies CONFIG_RELOCATABLE, and so the flag
is guaranteed to be set on x86_64 builds, whereas i386 builds are
guaranteed to run under firmware that will not allocate above 4 GB
in the first place.

So drop the check, and just pass ULONG_MAX as the upper bound for
all allocations.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index c774b97c9820..e4817579d96b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -375,7 +375,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	char *cmdline_ptr;
 	unsigned long ramdisk_addr;
 	unsigned long ramdisk_size;
-	bool above4g;
 
 	sys_table = sys_table_arg;
 
@@ -393,10 +392,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	image_offset = (void *)startup_32 - image_base;
 
 	hdr = &((struct boot_params *)image_base)->hdr;
-	above4g = hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G;
 
-	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params,
-				    above4g ? ULONG_MAX : UINT_MAX);
+	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate lowmem for boot params\n");
 		efi_exit(handle, status);
@@ -420,8 +417,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->type_of_loader = 0x21;
 
 	/* Convert unicode cmdline to ascii */
-	cmdline_ptr = efi_convert_cmdline(image, &options_size,
-					  above4g ? ULONG_MAX : UINT_MAX);
+	cmdline_ptr = efi_convert_cmdline(image, &options_size, ULONG_MAX);
 	if (!cmdline_ptr)
 		goto fail;
 
@@ -441,8 +437,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 			status = efi_load_initrd(image, &ramdisk_addr,
 						 &ramdisk_size,
 						 hdr->initrd_addr_max,
-						 above4g ? ULONG_MAX
-							 : hdr->initrd_addr_max);
+						 ULONG_MAX);
 			if (status != EFI_SUCCESS)
 				goto fail2;
 			hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
@@ -794,12 +789,8 @@ unsigned long efi_main(efi_handle_t handle,
 	 */
 	if (!noinitrd()) {
 		unsigned long addr, size;
-		unsigned long max_addr = hdr->initrd_addr_max;
 
-		if (hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G)
-			max_addr = ULONG_MAX;
-
-		status = efi_load_initrd_dev_path(&addr, &size, max_addr);
+		status = efi_load_initrd_dev_path(&addr, &size, ULONG_MAX);
 		if (status == EFI_SUCCESS) {
 			hdr->ramdisk_image		= (u32)addr;
 			hdr->ramdisk_size 		= (u32)size;
-- 
2.17.1

