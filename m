Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0209318C519
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgCTCAg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:00:36 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36570 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCTCAf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:35 -0400
Received: by mail-qv1-f66.google.com with SMTP id z13so2221656qvw.3;
        Thu, 19 Mar 2020 19:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qiFAu6RCpFkDkDQyLqPSk31H4M9LfMJt3s8TsvDnQxY=;
        b=r03NkPCWvMV9UMIWe/FM4JZ/mJ6WuEeWPP+KwLSYidyB3vXy0X3SkjAUrcLjBUM8pn
         ohDnkqcvTAu1eytOARDm0UEf2y7vs6hwE1wneYpHLusI00NCVOsCi1jSSL4UbSMoqDVB
         +ISZJWL6OAemtDXqzbFqmq0MX9fu17vL9hmWdtLr5Afk3Kn+JsNcTP+nEtmcUTofr3QG
         TgLtbDUq9pv0pN9+S3KMykc3I0p8TxwsG1VjS4yk3pS6hnuH3o3pUtw+qmo+/abbDQb3
         FMoqrvtKzvb63RxPJJTHU8XLUprimYl7PAUirtcSwGWNKAu5kqu6f479fODqwArarIYj
         q4eQ==
X-Gm-Message-State: ANhLgQ32BlEZuy55ICnmwMFbexvFxmxTSKSz4lJCYnKznPQoYB2oM7Vy
        YK+DRYBpdF7+pJdqMiThcUiSwKMr
X-Google-Smtp-Source: ADFU+vvjtars2q97nf5gys6HrTmRdaqdQl/jGd8CKzf5xE5Pc+mdawTipvEG+wFgnAcFt6V59qeh/Q==
X-Received: by 2002:a0c:c60a:: with SMTP id v10mr5971086qvi.140.1584669632957;
        Thu, 19 Mar 2020 19:00:32 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:32 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/14] efi/gop: Get mode information outside the loop
Date:   Thu, 19 Mar 2020 22:00:17 -0400
Message-Id: <20200320020028.1936003-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move extraction of the mode information parameters outside the loop to
find the gop, and eliminate some redundant variables.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
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
2.24.1

