Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0219A12A2D4
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLXPKv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:10:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfLXPKv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:10:51 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9D520730;
        Tue, 24 Dec 2019 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200250;
        bh=Cc5CrzKhXQw4gi2he3vnDwz0fwhp+/45TjHbFXyulW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EETZx0DpYxRmF6OEDJ80+Z7DcGolkbV/CM3E7R7VyiDQIJ2w0aLxTKnbgSPh5oRxz
         m7gnEoz1F8RXDF7VQbDHlD3ZapfQL7XrzqAEKNsWo9P6VXLAQ97ihYQOQwfeZJqH/g
         tmAA6KKPQ6nqf9KJOjG1T1DjNoYCOhC7u+chDxjY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 03/25] efi/gop: Convert GOP structures to typedef and cleanup some types
Date:   Tue, 24 Dec 2019 16:10:03 +0100
Message-Id: <20191224151025.32482-4-ardb@kernel.org>
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

Use typedef for the GOP structures, in anticipation of unifying
32/64-bit code. Also use more appropriate types in the non-bitness
specific structures for the framebuffer address and pointers.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 26 ++++++++---------
 include/linux/efi.h                | 46 +++++++++++++++---------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index b7bf1e993b8b..a0c1ef64d445 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -35,7 +35,7 @@ static void find_bits(unsigned long mask, u8 *pos, u8 *size)
 
 static void
 setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
-		 struct efi_pixel_bitmask pixel_info, int pixel_format)
+		 efi_pixel_bitmask_t pixel_info, int pixel_format)
 {
 	if (pixel_format == PIXEL_RGB_RESERVED_8BIT_PER_COLOR) {
 		si->lfb_depth = 32;
@@ -87,13 +87,13 @@ static efi_status_t
 setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
             efi_guid_t *proto, unsigned long size, void **gop_handle)
 {
-	struct efi_graphics_output_protocol_32 *gop32, *first_gop;
+	efi_graphics_output_protocol_32_t *gop32, *first_gop;
 	unsigned long nr_gops;
 	u16 width, height;
 	u32 pixels_per_scan_line;
 	u32 ext_lfb_base;
-	u64 fb_base;
-	struct efi_pixel_bitmask pixel_info;
+	efi_physical_addr_t fb_base;
+	efi_pixel_bitmask_t pixel_info;
 	int pixel_format;
 	efi_status_t status;
 	u32 *handles = (u32 *)(unsigned long)gop_handle;
@@ -104,13 +104,13 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	nr_gops = size / sizeof(u32);
 	for (i = 0; i < nr_gops; i++) {
-		struct efi_graphics_output_protocol_mode_32 *mode;
-		struct efi_graphics_output_mode_info *info = NULL;
+		efi_graphics_output_protocol_mode_32_t *mode;
+		efi_graphics_output_mode_info_t *info = NULL;
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
 		void *dummy = NULL;
 		efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
-		u64 current_fb_base;
+		efi_physical_addr_t current_fb_base;
 
 		status = efi_call_early(handle_protocol, h,
 					proto, (void **)&gop32);
@@ -184,13 +184,13 @@ static efi_status_t
 setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	    efi_guid_t *proto, unsigned long size, void **gop_handle)
 {
-	struct efi_graphics_output_protocol_64 *gop64, *first_gop;
+	efi_graphics_output_protocol_64_t *gop64, *first_gop;
 	unsigned long nr_gops;
 	u16 width, height;
 	u32 pixels_per_scan_line;
 	u32 ext_lfb_base;
-	u64 fb_base;
-	struct efi_pixel_bitmask pixel_info;
+	efi_physical_addr_t fb_base;
+	efi_pixel_bitmask_t pixel_info;
 	int pixel_format;
 	efi_status_t status;
 	u64 *handles = (u64 *)(unsigned long)gop_handle;
@@ -201,13 +201,13 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	nr_gops = size / sizeof(u64);
 	for (i = 0; i < nr_gops; i++) {
-		struct efi_graphics_output_protocol_mode_64 *mode;
-		struct efi_graphics_output_mode_info *info = NULL;
+		efi_graphics_output_protocol_mode_64_t *mode;
+		efi_graphics_output_mode_info_t *info = NULL;
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
 		void *dummy = NULL;
 		efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
-		u64 current_fb_base;
+		efi_physical_addr_t current_fb_base;
 
 		status = efi_call_early(handle_protocol, h,
 					proto, (void **)&gop64);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9ea81cfe1576..561db9deedae 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1415,69 +1415,69 @@ struct efi_simple_text_output_protocol {
 #define PIXEL_BLT_ONLY					3
 #define PIXEL_FORMAT_MAX				4
 
-struct efi_pixel_bitmask {
+typedef struct {
 	u32 red_mask;
 	u32 green_mask;
 	u32 blue_mask;
 	u32 reserved_mask;
-};
+} efi_pixel_bitmask_t;
 
-struct efi_graphics_output_mode_info {
+typedef struct {
 	u32 version;
 	u32 horizontal_resolution;
 	u32 vertical_resolution;
 	int pixel_format;
-	struct efi_pixel_bitmask pixel_information;
+	efi_pixel_bitmask_t pixel_information;
 	u32 pixels_per_scan_line;
-};
+} efi_graphics_output_mode_info_t;
 
-struct efi_graphics_output_protocol_mode_32 {
+typedef struct {
 	u32 max_mode;
 	u32 mode;
 	u32 info;
 	u32 size_of_info;
 	u64 frame_buffer_base;
 	u32 frame_buffer_size;
-};
+} efi_graphics_output_protocol_mode_32_t;
 
-struct efi_graphics_output_protocol_mode_64 {
+typedef struct {
 	u32 max_mode;
 	u32 mode;
 	u64 info;
 	u64 size_of_info;
 	u64 frame_buffer_base;
 	u64 frame_buffer_size;
-};
+} efi_graphics_output_protocol_mode_64_t;
 
-struct efi_graphics_output_protocol_mode {
+typedef struct {
 	u32 max_mode;
 	u32 mode;
-	unsigned long info;
+	efi_graphics_output_mode_info_t *info;
 	unsigned long size_of_info;
-	u64 frame_buffer_base;
+	efi_physical_addr_t frame_buffer_base;
 	unsigned long frame_buffer_size;
-};
+} efi_graphics_output_protocol_mode_t;
 
-struct efi_graphics_output_protocol_32 {
+typedef struct {
 	u32 query_mode;
 	u32 set_mode;
 	u32 blt;
 	u32 mode;
-};
+} efi_graphics_output_protocol_32_t;
 
-struct efi_graphics_output_protocol_64 {
+typedef struct {
 	u64 query_mode;
 	u64 set_mode;
 	u64 blt;
 	u64 mode;
-};
+} efi_graphics_output_protocol_64_t;
 
-struct efi_graphics_output_protocol {
-	unsigned long query_mode;
-	unsigned long set_mode;
-	unsigned long blt;
-	struct efi_graphics_output_protocol_mode *mode;
-};
+typedef struct {
+	void *query_mode;
+	void *set_mode;
+	void *blt;
+	efi_graphics_output_protocol_mode_t *mode;
+} efi_graphics_output_protocol_t;
 
 extern struct list_head efivar_sysfs_list;
 
-- 
2.20.1

