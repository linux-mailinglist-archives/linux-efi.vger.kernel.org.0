Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA48111B21
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 22:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfLCVrb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 16:47:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44469 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfLCVrb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 16:47:31 -0500
Received: by mail-qk1-f193.google.com with SMTP id i18so5037260qkl.11
        for <linux-efi@vger.kernel.org>; Tue, 03 Dec 2019 13:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45fsQqQAC5RlmUOhoqqjnShpX/3637BMGiCpvCQp00Q=;
        b=bNSPB80NlABWs4NCIH0ZlRfGGh3vsu8XY5HBR4Pnqz8duEuCc25ftvISu6FTuqD+ax
         uy0MdNsuPJbEOl2bKlwt94vG/GhO7pDMhGop1rNTqakA9E3nktkoWWiqtKPOsKZtFjga
         vpLT7iL7nDgqIvTuxQXveeQqrEUWvqXYxIJ+5z6JbT1f0+9r3wOWv8X/9hfWbBcCKvpi
         wOdPzlGM2/U5ntf+0qoH/j052xr6nuJ0Kw6bV8dQ/4Ff8MLWhZZ4UusHq/g3ectWjL1r
         +XjK3I8u4pCl0LLr7i7vPZ861osiRPO3lGrnpQEr4SWNgMKfkV5xOEOsMGtSdsBkiVti
         zuvQ==
X-Gm-Message-State: APjAAAVQREypYHIjYegGu+oJs+kJMaqGhJCLVIFEdVlAgotA+oEgIie5
        qdMx+3+3TLoAaVpJ9xepLLAeJgf/lME=
X-Google-Smtp-Source: APXvYqzM7CY37gjeCNiJ3pUf0qBP4wV7cE1XHWLaq9a6SuF7iGiJEmdPliHYZ0eidjKqzsKFoDe5zQ==
X-Received: by 2002:ae9:e30e:: with SMTP id v14mr7398358qkf.344.1575409650160;
        Tue, 03 Dec 2019 13:47:30 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j89sm2491188qte.72.2019.12.03.13.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 13:47:29 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH 2/2] efi/gop: Fix memory leak in __gop_query32/64
Date:   Tue,  3 Dec 2019 16:47:28 -0500
Message-Id: <20191203214728.19264-2-nivedita@alum.mit.edu>
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
freed by the caller.

We don't actually need to call it in order to obtain the info for the
current graphics mode, which is already there in gop->mode->info, so
just access it directly.

Also nothing uses the size of the info structure, so remove the
argument.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 48 ++++++++----------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 235a98797105..c8a39cd89b47 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -83,28 +83,17 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 	}
 }
 
-static efi_status_t
+static void
 __gop_query32(efi_system_table_t *sys_table_arg,
 	      struct efi_graphics_output_protocol_32 *gop32,
 	      struct efi_graphics_output_mode_info **info,
-	      unsigned long *size, u64 *fb_base)
+	      u64 *fb_base)
 {
 	struct efi_graphics_output_protocol_mode_32 *mode;
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
 
+	mode = (void *)(unsigned long)gop32->mode;
+	*info = (void *)(unsigned long)mode->info;
 	*fb_base = mode->frame_buffer_base;
-	return status;
 }
 
 static efi_status_t
@@ -145,9 +134,8 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 		if (status == EFI_SUCCESS)
 			conout_found = true;
 
-		status = __gop_query32(sys_table_arg, gop32, &info, &size,
-				       &current_fb_base);
-		if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
+		__gop_query32(sys_table_arg, gop32, &info, &current_fb_base);
+		if ((!first_gop || conout_found) &&
 		    info->pixel_format != PIXEL_BLT_ONLY) {
 			/*
 			 * Systems that use the UEFI Console Splitter may
@@ -201,28 +189,17 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	return EFI_SUCCESS;
 }
 
-static efi_status_t
+static void
 __gop_query64(efi_system_table_t *sys_table_arg,
 	      struct efi_graphics_output_protocol_64 *gop64,
 	      struct efi_graphics_output_mode_info **info,
-	      unsigned long *size, u64 *fb_base)
+	      u64 *fb_base)
 {
 	struct efi_graphics_output_protocol_mode_64 *mode;
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
 
+	mode = (void *)(unsigned long)gop64->mode;
+	*info = (void *)(unsigned long)mode->info;
 	*fb_base = mode->frame_buffer_base;
-	return status;
 }
 
 static efi_status_t
@@ -263,9 +240,8 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 		if (status == EFI_SUCCESS)
 			conout_found = true;
 
-		status = __gop_query64(sys_table_arg, gop64, &info, &size,
-				       &current_fb_base);
-		if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
+		__gop_query64(sys_table_arg, gop64, &info, &current_fb_base);
+		if ((!first_gop || conout_found) &&
 		    info->pixel_format != PIXEL_BLT_ONLY) {
 			/*
 			 * Systems that use the UEFI Console Splitter may
-- 
2.23.0

