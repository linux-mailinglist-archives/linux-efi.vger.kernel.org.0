Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C07F12A2B4
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLXPKx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfLXPKx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:10:53 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E048320706;
        Tue, 24 Dec 2019 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200252;
        bh=2LqubldA/xLGAvFQQfAhdaya73C8SjRNy5vCIkvhBqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/xGjvWxh2kkq9e6Sm0RlN9mKkF21Psx8PNuyeKy4qXU5aedsHQJXrqsJfk+hli98
         IPVINwTQ846dEbvVOY5mc8FBPpusK0MswjaepjQ2T524afZ5eiypYD2PkpjCWLvJa6
         OzJA982qlBBCrsUASP74xBs8l96rglILH/sNvgsE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 04/25] efi/gop: Unify 32/64-bit functions
Date:   Tue, 24 Dec 2019 16:10:04 +0100
Message-Id: <20191224151025.32482-5-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Use efi_table_attr macro to deal with 32/64-bit firmware using the same
source code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 134 ++++-------------------------
 1 file changed, 18 insertions(+), 116 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index a0c1ef64d445..94045ab7dd3d 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -83,108 +83,14 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 	}
 }
 
-static efi_status_t
-setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
-            efi_guid_t *proto, unsigned long size, void **gop_handle)
-{
-	efi_graphics_output_protocol_32_t *gop32, *first_gop;
-	unsigned long nr_gops;
-	u16 width, height;
-	u32 pixels_per_scan_line;
-	u32 ext_lfb_base;
-	efi_physical_addr_t fb_base;
-	efi_pixel_bitmask_t pixel_info;
-	int pixel_format;
-	efi_status_t status;
-	u32 *handles = (u32 *)(unsigned long)gop_handle;
-	int i;
-
-	first_gop = NULL;
-	gop32 = NULL;
-
-	nr_gops = size / sizeof(u32);
-	for (i = 0; i < nr_gops; i++) {
-		efi_graphics_output_protocol_mode_32_t *mode;
-		efi_graphics_output_mode_info_t *info = NULL;
-		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
-		bool conout_found = false;
-		void *dummy = NULL;
-		efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
-		efi_physical_addr_t current_fb_base;
-
-		status = efi_call_early(handle_protocol, h,
-					proto, (void **)&gop32);
-		if (status != EFI_SUCCESS)
-			continue;
-
-		status = efi_call_early(handle_protocol, h,
-					&conout_proto, &dummy);
-		if (status == EFI_SUCCESS)
-			conout_found = true;
-
-		mode = (void *)(unsigned long)gop32->mode;
-		info = (void *)(unsigned long)mode->info;
-		current_fb_base = mode->frame_buffer_base;
-
-		if ((!first_gop || conout_found) &&
-		    info->pixel_format != PIXEL_BLT_ONLY) {
-			/*
-			 * Systems that use the UEFI Console Splitter may
-			 * provide multiple GOP devices, not all of which are
-			 * backed by real hardware. The workaround is to search
-			 * for a GOP implementing the ConOut protocol, and if
-			 * one isn't found, to just fall back to the first GOP.
-			 */
-			width = info->horizontal_resolution;
-			height = info->vertical_resolution;
-			pixel_format = info->pixel_format;
-			pixel_info = info->pixel_information;
-			pixels_per_scan_line = info->pixels_per_scan_line;
-			fb_base = current_fb_base;
-
-			/*
-			 * Once we've found a GOP supporting ConOut,
-			 * don't bother looking any further.
-			 */
-			first_gop = gop32;
-			if (conout_found)
-				break;
-		}
-	}
-
-	/* Did we find any GOPs? */
-	if (!first_gop)
-		return EFI_NOT_FOUND;
-
-	/* EFI framebuffer */
-	si->orig_video_isVGA = VIDEO_TYPE_EFI;
-
-	si->lfb_width = width;
-	si->lfb_height = height;
-	si->lfb_base = fb_base;
-
-	ext_lfb_base = (u64)(unsigned long)fb_base >> 32;
-	if (ext_lfb_base) {
-		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
-		si->ext_lfb_base = ext_lfb_base;
-	}
-
-	si->pages = 1;
-
-	setup_pixel_info(si, pixels_per_scan_line, pixel_info, pixel_format);
-
-	si->lfb_size = si->lfb_linelength * si->lfb_height;
-
-	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
-
-	return EFI_SUCCESS;
-}
+#define efi_gop_attr(table, attr, instance) \
+	(efi_table_attr(efi_graphics_output_protocol##table, attr, instance))
 
 static efi_status_t
-setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
-	    efi_guid_t *proto, unsigned long size, void **gop_handle)
+setup_gop(efi_system_table_t *sys_table_arg, struct screen_info *si,
+	  efi_guid_t *proto, unsigned long size, void **handles)
 {
-	efi_graphics_output_protocol_64_t *gop64, *first_gop;
+	efi_graphics_output_protocol_t *gop, *first_gop;
 	unsigned long nr_gops;
 	u16 width, height;
 	u32 pixels_per_scan_line;
@@ -193,24 +99,26 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	efi_pixel_bitmask_t pixel_info;
 	int pixel_format;
 	efi_status_t status;
-	u64 *handles = (u64 *)(unsigned long)gop_handle;
 	int i;
+	bool is64 = efi_is_64bit();
 
 	first_gop = NULL;
-	gop64 = NULL;
+	gop = NULL;
 
-	nr_gops = size / sizeof(u64);
+	nr_gops = size / (is64 ? sizeof(u64) : sizeof(u32));
 	for (i = 0; i < nr_gops; i++) {
-		efi_graphics_output_protocol_mode_64_t *mode;
+		efi_graphics_output_protocol_mode_t *mode;
 		efi_graphics_output_mode_info_t *info = NULL;
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
 		void *dummy = NULL;
-		efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
+		efi_handle_t h = (efi_handle_t)(unsigned long)
+				 (is64 ? ((u64 *)handles)[i]
+				       : ((u32 *)handles)[i]);
 		efi_physical_addr_t current_fb_base;
 
 		status = efi_call_early(handle_protocol, h,
-					proto, (void **)&gop64);
+					proto, (void **)&gop);
 		if (status != EFI_SUCCESS)
 			continue;
 
@@ -219,9 +127,9 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 		if (status == EFI_SUCCESS)
 			conout_found = true;
 
-		mode = (void *)(unsigned long)gop64->mode;
-		info = (void *)(unsigned long)mode->info;
-		current_fb_base = mode->frame_buffer_base;
+		mode = (void *)(unsigned long)efi_gop_attr(, mode, gop);
+		info = (void *)(unsigned long)efi_gop_attr(_mode, info, mode);
+		current_fb_base = efi_gop_attr(_mode, frame_buffer_base, mode);
 
 		if ((!first_gop || conout_found) &&
 		    info->pixel_format != PIXEL_BLT_ONLY) {
@@ -243,7 +151,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 			 * Once we've found a GOP supporting ConOut,
 			 * don't bother looking any further.
 			 */
-			first_gop = gop64;
+			first_gop = gop;
 			if (conout_found)
 				break;
 		}
@@ -298,13 +206,7 @@ efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
 	if (status != EFI_SUCCESS)
 		goto free_handle;
 
-	if (efi_is_64bit()) {
-		status = setup_gop64(sys_table_arg, si, proto, size,
-				     gop_handle);
-	} else {
-		status = setup_gop32(sys_table_arg, si, proto, size,
-				     gop_handle);
-	}
+	status = setup_gop(sys_table_arg, si, proto, size, gop_handle);
 
 free_handle:
 	efi_call_early(free_pool, gop_handle);
-- 
2.20.1

