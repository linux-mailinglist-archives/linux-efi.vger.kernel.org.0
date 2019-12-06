Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C282A1155E3
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2019 17:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfLFQ4K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Dec 2019 11:56:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfLFQ4J (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 6 Dec 2019 11:56:09 -0500
Received: from e123331-lin.cambridge.arm.com (fw-tnat-cam5.arm.com [217.140.106.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B35C24673;
        Fri,  6 Dec 2019 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575651368;
        bh=Ijm+XMa84Tu0IGDIPKJtCCsU0GxdQ8nZ5k98HefNtrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KSsdNVQpB2fAK1voA3WmB0/oJBw6nxWcBGKoUCKuCWdQcjSD8rX7RLtpzWsrHS3KV
         5snfT7qiCHg9y2/a7kOBTwi3WsCENB+Db91iVRYrAUYS3hUszab83QPa9OZYyFN7t4
         vNKoDXY0JToTbS1yG1aQ08t/SmVnHpD5s084eWSM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 4/6] efi/gop: Fix memory leak from __gop_query32/64
Date:   Fri,  6 Dec 2019 16:55:40 +0000
Message-Id: <20191206165542.31469-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206165542.31469-1-ardb@kernel.org>
References: <20191206165542.31469-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

efi_graphics_output_protocol::query_mode() returns info in
callee-allocated memory which must be freed by the caller, which
we aren't doing.

We don't actually need to call query_mode in order to obtain the
info for the current graphics mode, which is already there in
gop->mode->info, so just access it directly in the setup_gop32/64
functions.

Also nothing uses the size of the info structure, so don't update the
passed-in size (which is the size of the gop_handle table in bytes)
unnecessarily.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 66 ++++++------------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 69b2b019a1d0..b7bf1e993b8b 100644
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
2.17.1

