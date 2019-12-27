Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E157012B7AB
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 18:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfL0Rua (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 12:50:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfL0RoN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Dec 2019 12:44:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75DE620740;
        Fri, 27 Dec 2019 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468652;
        bh=Dpq8wuZ0aaFZMU+WnK22+ipxpSbe3i1U4BrVYFSNTiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/jQp1Oyxdf9hmb3+uur5gpzfQ3XdoTRgf4hteRJC7lEqaGntJijP1+l8dqkiZRI0
         uuWzByuP8aXZVyibQswUdK692Bjs2wVDvESmFIEzJkF0fJ2vO9C3h2iuqoh4rdsurn
         YhRDmNDc6guZMLn0lP+m9iTjX3q0ani0nJsEqM7w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 15/84] efi/gop: Fix memory leak in __gop_query32/64()
Date:   Fri, 27 Dec 2019 12:42:43 -0500
Message-Id: <20191227174352.6264-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

[ Upstream commit ff397be685e410a59c34b21ce0c55d4daa466bb7 ]

efi_graphics_output_protocol::query_mode() returns info in
callee-allocated memory which must be freed by the caller, which
we aren't doing.

We don't actually need to call query_mode() in order to obtain the
info for the current graphics mode, which is already there in
gop->mode->info, so just access it directly in the setup_gop32/64()
functions.

Also nothing uses the size of the info structure, so don't update the
passed-in size (which is the size of the gop_handle table in bytes)
unnecessarily.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Cc: linux-efi@vger.kernel.org
Link: https://lkml.kernel.org/r/20191206165542.31469-5-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 66 ++++++------------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 81ffda5d1e48..fd8053f9556e 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -85,30 +85,6 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
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
@@ -130,6 +106,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	nr_gops = size / sizeof(u32);
 	for (i = 0; i < nr_gops; i++) {
+		struct efi_graphics_output_protocol_mode_32 *mode;
 		struct efi_graphics_output_mode_info *info = NULL;
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
@@ -147,9 +124,11 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
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
@@ -203,30 +182,6 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
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
@@ -248,6 +203,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	nr_gops = size / sizeof(u64);
 	for (i = 0; i < nr_gops; i++) {
+		struct efi_graphics_output_protocol_mode_64 *mode;
 		struct efi_graphics_output_mode_info *info = NULL;
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
@@ -265,9 +221,11 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
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
2.20.1

