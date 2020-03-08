Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876BB17D28E
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCHIKk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgCHIKj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:39 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F3B5208C3;
        Sun,  8 Mar 2020 08:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583655039;
        bh=bzyWUzT+NhCF+bkKOqxl9ChyduAJx/5Wzt4n9ZAB888=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBmoj0G4tMEy9XZYE/D8Vs2w0yHvBLQf2yB3wg7kqf1LTCX4cIHPgpSg951WA89gz
         Gzfz8YjDEPyr4zOWEbvMDq833ojDFBKfrh4d0OdTgoLamsplwVXTVppEKVClPJUdtF
         5iJJGQiCPevix2+Zm4IAdWO94QZ3RQj3Gg/6uZp8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 26/28] efi/libstub/x86: use ULONG_MAX as upper bound for all allocations
Date:   Sun,  8 Mar 2020 09:08:57 +0100
Message-Id: <20200308080859.21568-27-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
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

Link: https://lore.kernel.org/r/20200303225054.28741-1-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 064941ecc36f..bf0c3f60762a 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -376,7 +376,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	char *cmdline_ptr;
 	unsigned long ramdisk_addr;
 	unsigned long ramdisk_size;
-	bool above4g;
 
 	sys_table = sys_table_arg;
 
@@ -394,10 +393,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	image_offset = (void *)startup_32 - image_base;
 
 	hdr = &((struct boot_params *)image_base)->hdr;
-	above4g = hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G;
 
-	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params,
-				    above4g ? ULONG_MAX : UINT_MAX);
+	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate lowmem for boot params\n");
 		efi_exit(handle, status);
@@ -421,8 +418,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->type_of_loader = 0x21;
 
 	/* Convert unicode cmdline to ascii */
-	cmdline_ptr = efi_convert_cmdline(image, &options_size,
-					  above4g ? ULONG_MAX : UINT_MAX);
+	cmdline_ptr = efi_convert_cmdline(image, &options_size, ULONG_MAX);
 	if (!cmdline_ptr)
 		goto fail;
 
@@ -442,8 +438,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 			status = efi_load_initrd(image, &ramdisk_addr,
 						 &ramdisk_size,
 						 hdr->initrd_addr_max,
-						 above4g ? ULONG_MAX
-							 : hdr->initrd_addr_max);
+						 ULONG_MAX);
 			if (status != EFI_SUCCESS)
 				goto fail2;
 			hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
@@ -795,12 +790,8 @@ unsigned long efi_main(efi_handle_t handle,
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

