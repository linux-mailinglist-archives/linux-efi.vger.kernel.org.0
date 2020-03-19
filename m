Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52ACB18C048
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgCST3D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34397 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgCST3B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id 10so2933023qtp.1;
        Thu, 19 Mar 2020 12:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qiFAu6RCpFkDkDQyLqPSk31H4M9LfMJt3s8TsvDnQxY=;
        b=jwOK4TDbewXTqnruoYxb92KFsDNz8hTCz5F+IbyjCfyiUCSFDUaBt4jUNXKRnZentu
         qY8zGEkmv8N32hQF/Sa//z2HIugTjSbzhrxBIMoam1KPi3D96+f5pvyw81SRzfCNtXM0
         DUmTqjv6CrxiSDFFzHvJjR3S3pLTaecTK9GrMN9R0iRpe4HH2opN7e7lsKqaIGkJ9LOL
         GQYzkb9gaDX602lnY2ZTKNXTzAAS7ua4DdNCcaOpCetlHXD8l3e/x8AfUqVWJpZswgr+
         ctrjc4iX6MAaXXqBudtcXu17XBXoPbPgS41B74LwJfTZdIwm4QEoiqCUpNEHVUCJL5of
         EGuw==
X-Gm-Message-State: ANhLgQ0NT9juooLJJGPh2M4At1S8FA2LVrV18gMfVmLibi3v2esO5sEn
        W+BbtM4KnLe0B8G4cqBvrF2ypUL4
X-Google-Smtp-Source: ADFU+vteTN3JcLnwiPcKbQR9WxitFNBQEMasteMrLyid5kEiyibhmVcyi0yiBiLQSgh5JO7I4LG/Cg==
X-Received: by 2002:aed:2ba2:: with SMTP id e31mr4628189qtd.286.1584646140271;
        Thu, 19 Mar 2020 12:29:00 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:28:59 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] efi/gop: Get mode information outside the loop
Date:   Thu, 19 Mar 2020 15:28:44 -0400
Message-Id: <20200319192855.29876-4-nivedita@alum.mit.edu>
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

