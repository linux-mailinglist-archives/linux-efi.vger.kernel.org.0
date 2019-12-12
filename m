Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E06311D89F
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 22:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfLLVet (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 16:34:49 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45611 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731086AbfLLVes (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 16:34:48 -0500
Received: by mail-qv1-f68.google.com with SMTP id c2so1555927qvp.12
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 13:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpGt2bdKtKfrLjRuDZ2yC3atV/ywsjJlzEvYKGeYseI=;
        b=qhpgm/WwmmVnrGxW4/uSSGcUUAHy1u5A8SNi4kKEizjbbW0tQQLlqj2ALIXerJzXe9
         1/Ftd2PA7LSLD8ej4fRAa9VWuFhNtzsdycIRo1nym+VDhULFJaV6kXZNBYvVqhfWV0RE
         mcSCMENSkMP6WtKbE4VuafAr5BoHN8owsRRHVoE+jMjOTAsa3dOnwTJMg/D8C11NejEk
         LJvUB17MFgtaGbd13fet8QDpyRH35+pI5uwlHCNUMBXQ6/yXveNag0nUciS4/+EPZ0cJ
         WtLJvpB+o9z25Ks4l2yQf7oMsStzHjuNNeKXnlfAzQjcP2/m6KM/n+3AqnKuDyqaLht/
         sNSw==
X-Gm-Message-State: APjAAAVCQreuxL4JkEf5c2l0ehoMw+RS/+Keiq1MRKqWomVB6yWy0MJi
        Dy8NJjoNaZlshXo64aTSeEA=
X-Google-Smtp-Source: APXvYqwUNl4EcW9R115E6Z0mZICIm8EWLHbenIxDujhcCb4QjaSFns2vhkg2pA1V9lC9BXrPrJvF1A==
X-Received: by 2002:a05:6214:1804:: with SMTP id o4mr10135830qvw.3.1576186487336;
        Thu, 12 Dec 2019 13:34:47 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r5sm2116467qkf.44.2019.12.12.13.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:34:46 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [RFC PATCH 3/5] efi/gop: Convert GOP structures to typedef and cleanup some types
Date:   Thu, 12 Dec 2019 16:34:41 -0500
Message-Id: <20191212213443.24128-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212213443.24128-1-nivedita@alum.mit.edu>
References: <20191212213443.24128-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use typedef for the GOP structures, in anticipation of unifying
32/64-bit code. Also use more appropriate types in the non-bitness
specific structures for the framebuffer address and pointers.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
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
index 8be59ec77dee..5daac58fa675 100644
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
2.23.0

