Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5F1B763B
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgDXNGa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgDXNG2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:28 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07A6A20728;
        Fri, 24 Apr 2020 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733587;
        bh=pu4nNtpFvlHWmAifLdoiNo0VpGFj6y8BelfVro5QV50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHEug1FriO9dL5c2YHDDNoBvCKNw36+25x8ujpkTzQj4n/nBYGNYaeWWeke7mNs3/
         phPIodaUkc7t8sGAFu0hCuLqbOrTXkizqWm07Xj9i+7UgAypNkfQYKQZo64d1QHUJh
         1Icun+Y5MwrzWTGENwMU/IhTov4ezuuvry8SEeM0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 07/33] efi/gop: Get mode information outside the loop
Date:   Fri, 24 Apr 2020 15:05:05 +0200
Message-Id: <20200424130531.30518-8-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Move extraction of the mode information parameters outside the loop to
find the gop, and eliminate some redundant variables.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-4-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 38 +++++++++++-------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 201b66970b2b..d692b8c65813 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -89,12 +89,9 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 			      unsigned long size, void **handles)
 {
 	efi_graphics_output_protocol_t *gop, *first_gop;
-	u16 width, height;
-	u32 pixels_per_scan_line;
-	u32 ext_lfb_base;
+	efi_graphics_output_protocol_mode_t *mode;
+	efi_graphics_output_mode_info_t *info = NULL;
 	efi_physical_addr_t fb_base;
-	efi_pixel_bitmask_t pixel_info;
-	int pixel_format;
 	efi_status_t status;
 	efi_handle_t h;
 	int i;
@@ -103,8 +100,6 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 	gop = NULL;
 
 	for_each_efi_handle(h, handles, size, i) {
-		efi_graphics_output_protocol_mode_t *mode;
-		efi_graphics_output_mode_info_t *info = NULL;
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
 		void *dummy = NULL;
@@ -129,15 +124,7 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 			 * backed by real hardware. The workaround is to search
 			 * for a GOP implementing the ConOut protocol, and if
 			 * one isn't found, to just fall back to the first GOP.
-			 */
-			width = info->horizontal_resolution;
-			height = info->vertical_resolution;
-			pixel_format = info->pixel_format;
-			pixel_info = info->pixel_information;
-			pixels_per_scan_line = info->pixels_per_scan_line;
-			fb_base = efi_table_attr(mode, frame_buffer_base);
-
-			/*
+			 *
 			 * Once we've found a GOP supporting ConOut,
 			 * don't bother looking any further.
 			 */
@@ -152,21 +139,24 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 		return EFI_NOT_FOUND;
 
 	/* EFI framebuffer */
+	mode = efi_table_attr(first_gop, mode);
+	info = efi_table_attr(mode, info);
+
 	si->orig_video_isVGA = VIDEO_TYPE_EFI;
 
-	si->lfb_width = width;
-	si->lfb_height = height;
-	si->lfb_base = fb_base;
+	si->lfb_width  = info->horizontal_resolution;
+	si->lfb_height = info->vertical_resolution;
 
-	ext_lfb_base = (u64)(unsigned long)fb_base >> 32;
-	if (ext_lfb_base) {
+	fb_base		 = efi_table_attr(mode, frame_buffer_base);
+	si->lfb_base	 = fb_base;
+	si->ext_lfb_base = (u64)(unsigned long)fb_base >> 32;
+	if (si->ext_lfb_base)
 		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
-		si->ext_lfb_base = ext_lfb_base;
-	}
 
 	si->pages = 1;
 
-	setup_pixel_info(si, pixels_per_scan_line, pixel_info, pixel_format);
+	setup_pixel_info(si, info->pixels_per_scan_line,
+			     info->pixel_information, info->pixel_format);
 
 	si->lfb_size = si->lfb_linelength * si->lfb_height;
 
-- 
2.17.1

