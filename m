Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA3113393
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 19:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfLDSRw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 13:17:52 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37523 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbfLDSRv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 13:17:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so732036qtk.4
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 10:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lRgPN3RUS73LsaIHYq45B/z4v9LWEWB5O0HdPdhSK8=;
        b=UzBdmmE3RVBvjSJin2kuT+M0+0CQa57lyVlswJJZEb3AHhb+eRwaXVVDCX+qMFhCxF
         VbTQx3Ucf7MuRMJvihmui6BlRZbp7EEAkcIJFRiVOBzXF/TMj9t/gA64BSjU65ALXm3K
         zs6rLC15jumfGkeN4OJnonQA4sFPjr2Y/FyR4GQQ/ZLFT47oRltpgluDUAeXg55Az4Kk
         Tik3lFW+vVJXc7QowUyPLbvlmSJPwUAOnZBkcYhozOZy1a5lQ1bYGC6/hGJazyDba5Dg
         ZwgsRCy4IKDUykDQSvTJw3OCUDqk4Z7uy50syMvuomRt9HF5IrH+6bwmWD/oY23zcddi
         BL1Q==
X-Gm-Message-State: APjAAAWBDNRJkSZ4UVlOcMGdLIGWpfcoJ3aVlV8+kQfAciW74HOspdQx
        AcrnljIm3ur+4rQi2dPwZ1LXYfjUhxQ=
X-Google-Smtp-Source: APXvYqyVNgFejhUnx6HvOJQkLv/deBW/iehgkQPLH3vC5IEslvcEXjFnUU8tTa7Tor9zw2B+FPUuXA==
X-Received: by 2002:aed:2d67:: with SMTP id h94mr4068358qtd.74.1575483469184;
        Wed, 04 Dec 2019 10:17:49 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c6sm4072506qka.111.2019.12.04.10.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 10:17:48 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH v2 3/3] efi/gop: Fix memory leak from __gop_query32/64
Date:   Wed,  4 Dec 2019 13:17:44 -0500
Message-Id: <20191204181744.14326-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203214728.19264-1-nivedita@alum.mit.edu>
References: <20191203214728.19264-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

gop->query_mode returns info in callee-allocated memory which must be
freed by the caller, which we aren't doing.

We don't actually need to call query_mode in order to obtain the info
for the current graphics mode, which is already there in
gop->mode->info, so just access it directly in the setup_gop32/64
functions.

Also nothing uses the size of the info structure, so don't update the
passed-in size (which is the size of the gop_handle table in bytes)
unnecessarily.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 66 ++++++------------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 245a5fbef3dc..7693ec9bbec7 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -83,30 +83,6 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 	}
 }
 
-static efi_status_t
-__gop_query32(efi_system_table_t *sys_table_arg,
-	      struct efi_graphics_output_protocol_32 *gop32,
-	      struct efi_graphics_output_mode_info **info,
-	      unsigned long *size, u64 *fb_base)
-{
-	struct efi_graphics_output_protocol_mode_32 *mode;
-	efi_graphics_output_protocol_query_mode query_mode;
-	efi_status_t status;
-	unsigned long m;
-
-	m = gop32->mode;
-	mode = (struct efi_graphics_output_protocol_mode_32 *)m;
-	query_mode = (void *)(unsigned long)gop32->query_mode;
-
-	status = __efi_call_early(query_mode, (void *)gop32, mode->mode, size,
-				  info);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	*fb_base = mode->frame_buffer_base;
-	return status;
-}
-
 static efi_status_t
 setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
             efi_guid_t *proto, unsigned long size, void **gop_handle)
@@ -128,6 +104,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	nr_gops = size / sizeof(u32);
 	for (i = 0; i < nr_gops; i++) {
+		struct efi_graphics_output_protocol_mode_32 *mode;
 		struct efi_graphics_output_mode_info *info = NULL;
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
@@ -145,9 +122,11 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 		if (status == EFI_SUCCESS)
 			conout_found = true;
 
-		status = __gop_query32(sys_table_arg, gop32, &info, &size,
-				       &current_fb_base);
-		if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
+		mode = (void *)(unsigned long)gop32->mode;
+		info = (void *)(unsigned long)mode->info;
+		current_fb_base = mode->frame_buffer_base;
+
+		if ((!first_gop || conout_found) &&
 		    info->pixel_format != PIXEL_BLT_ONLY) {
 			/*
 			 * Systems that use the UEFI Console Splitter may
@@ -201,30 +180,6 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	return EFI_SUCCESS;
 }
 
-static efi_status_t
-__gop_query64(efi_system_table_t *sys_table_arg,
-	      struct efi_graphics_output_protocol_64 *gop64,
-	      struct efi_graphics_output_mode_info **info,
-	      unsigned long *size, u64 *fb_base)
-{
-	struct efi_graphics_output_protocol_mode_64 *mode;
-	efi_graphics_output_protocol_query_mode query_mode;
-	efi_status_t status;
-	unsigned long m;
-
-	m = gop64->mode;
-	mode = (struct efi_graphics_output_protocol_mode_64 *)m;
-	query_mode = (void *)(unsigned long)gop64->query_mode;
-
-	status = __efi_call_early(query_mode, (void *)gop64, mode->mode, size,
-				  info);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	*fb_base = mode->frame_buffer_base;
-	return status;
-}
-
 static efi_status_t
 setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	    efi_guid_t *proto, unsigned long size, void **gop_handle)
@@ -246,6 +201,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	nr_gops = size / sizeof(u64);
 	for (i = 0; i < nr_gops; i++) {
+		struct efi_graphics_output_protocol_mode_64 *mode;
 		struct efi_graphics_output_mode_info *info = NULL;
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
@@ -263,9 +219,11 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 		if (status == EFI_SUCCESS)
 			conout_found = true;
 
-		status = __gop_query64(sys_table_arg, gop64, &info, &size,
-				       &current_fb_base);
-		if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
+		mode = (void *)(unsigned long)gop64->mode;
+		info = (void *)(unsigned long)mode->info;
+		current_fb_base = mode->frame_buffer_base;
+
+		if ((!first_gop || conout_found) &&
 		    info->pixel_format != PIXEL_BLT_ONLY) {
 			/*
 			 * Systems that use the UEFI Console Splitter may
-- 
2.23.0

