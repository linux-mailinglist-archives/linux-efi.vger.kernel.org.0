Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACED41CB67F
	for <lists+linux-efi@lfdr.de>; Fri,  8 May 2020 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgEHSC0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 May 2020 14:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgEHSCZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 May 2020 14:02:25 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 187B724958;
        Fri,  8 May 2020 18:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960945;
        bh=e6Hs7bNLnqIWQZ4zxYn+0Q671EfGoEWmTIN2Fe06C/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJ78MAsCEtHlkL6rgG/AT6iI5jsEqHVQabf4kApxxhq92quOZ/LNjobuO9/m08F85
         HxH91r7KkEeE9OVZ36YrpYGVtK68t5PWEAfklV0IZbMfOU/OH9yijlf6n/d9mJRmgr
         EIpLDNEpQPXNkviVeeE+pfOHVD4ofvnSrVcJALo0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 02/15] efi/libstub: Add a helper function to split 64-bit values
Date:   Fri,  8 May 2020 20:01:44 +0200
Message-Id: <20200508180157.1816-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508180157.1816-1-ardb@kernel.org>
References: <20200508180157.1816-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

In several places 64-bit values need to be split up into two 32-bit
fields, in order to be backward-compatible with the old 32-bit ABIs.

Instead of open-coding this, add a helper function to set a 64-bit value
as two 32-bit fields.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200430182843.2510180-3-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h  |  7 ++++++
 drivers/firmware/efi/libstub/gop.c      |  6 ++---
 drivers/firmware/efi/libstub/x86-stub.c | 32 +++++++++++--------------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 5ff63230a1f1..e8aa70ba08d5 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -87,6 +87,13 @@ extern const efi_system_table_t *efi_system_table;
 		((handle = efi_get_handle_at((array), i)) || true);	\
 	     i++)
 
+static inline
+void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
+{
+	*lo = lower_32_bits(data);
+	*hi = upper_32_bits(data);
+}
+
 /*
  * Allocation types for calls to boottime->allocate_pages.
  */
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 216327d0b034..64cee0febae0 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -422,7 +422,6 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 	efi_graphics_output_protocol_t *gop;
 	efi_graphics_output_protocol_mode_t *mode;
 	efi_graphics_output_mode_info_t *info;
-	efi_physical_addr_t fb_base;
 
 	gop = find_gop(proto, size, handles);
 
@@ -442,9 +441,8 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 	si->lfb_width  = info->horizontal_resolution;
 	si->lfb_height = info->vertical_resolution;
 
-	fb_base		 = efi_table_attr(mode, frame_buffer_base);
-	si->lfb_base	 = lower_32_bits(fb_base);
-	si->ext_lfb_base = upper_32_bits(fb_base);
+	efi_set_u64_split(efi_table_attr(mode, frame_buffer_base),
+			  &si->lfb_base, &si->ext_lfb_base);
 	if (si->ext_lfb_base)
 		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index d4bafd7f6f9f..f91d4aab0156 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -408,9 +408,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (!cmdline_ptr)
 		goto fail;
 
-	hdr->cmd_line_ptr = (unsigned long)cmdline_ptr;
-	/* Fill in upper bits of command line address, NOP on 32 bit  */
-	boot_params->ext_cmd_line_ptr = (u64)(unsigned long)cmdline_ptr >> 32;
+	efi_set_u64_split((unsigned long)cmdline_ptr,
+			  &hdr->cmd_line_ptr, &boot_params->ext_cmd_line_ptr);
 
 	hdr->ramdisk_image = 0;
 	hdr->ramdisk_size = 0;
@@ -427,10 +426,10 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 						 ULONG_MAX);
 			if (status != EFI_SUCCESS)
 				goto fail2;
-			hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
-			hdr->ramdisk_size  = ramdisk_size & 0xffffffff;
-			boot_params->ext_ramdisk_image = (u64)ramdisk_addr >> 32;
-			boot_params->ext_ramdisk_size  = (u64)ramdisk_size >> 32;
+			efi_set_u64_split(ramdisk_addr, &hdr->ramdisk_image,
+					  &boot_params->ext_ramdisk_image);
+			efi_set_u64_split(ramdisk_size, &hdr->ramdisk_size,
+					  &boot_params->ext_ramdisk_size);
 		}
 	}
 
@@ -639,17 +638,14 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 				   : EFI32_LOADER_SIGNATURE;
 	memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
 
-	p->efi->efi_systab		= (unsigned long)efi_system_table;
+	efi_set_u64_split((unsigned long)efi_system_table,
+			  &p->efi->efi_systab, &p->efi->efi_systab_hi);
 	p->efi->efi_memdesc_size	= *map->desc_size;
 	p->efi->efi_memdesc_version	= *map->desc_ver;
-	p->efi->efi_memmap		= (unsigned long)*map->map;
+	efi_set_u64_split((unsigned long)*map->map,
+			  &p->efi->efi_memmap, &p->efi->efi_memmap_hi);
 	p->efi->efi_memmap_size		= *map->map_size;
 
-#ifdef CONFIG_X86_64
-	p->efi->efi_systab_hi		= (unsigned long)efi_system_table >> 32;
-	p->efi->efi_memmap_hi		= (unsigned long)*map->map >> 32;
-#endif
-
 	return EFI_SUCCESS;
 }
 
@@ -785,10 +781,10 @@ unsigned long efi_main(efi_handle_t handle,
 
 		status = efi_load_initrd_dev_path(&addr, &size, ULONG_MAX);
 		if (status == EFI_SUCCESS) {
-			hdr->ramdisk_image		= (u32)addr;
-			hdr->ramdisk_size 		= (u32)size;
-			boot_params->ext_ramdisk_image	= (u64)addr >> 32;
-			boot_params->ext_ramdisk_size 	= (u64)size >> 32;
+			efi_set_u64_split(addr, &hdr->ramdisk_image,
+					  &boot_params->ext_ramdisk_image);
+			efi_set_u64_split(size, &hdr->ramdisk_size,
+					  &boot_params->ext_ramdisk_size);
 		} else if (status != EFI_NOT_FOUND) {
 			efi_printk("efi_load_initrd_dev_path() failed!\n");
 			goto fail;
-- 
2.17.1

