Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380AB1B764F
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgDXNGl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgDXNGl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:41 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF0DE20776;
        Fri, 24 Apr 2020 13:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733600;
        bh=StI4ED6o9F1wqPlrCb6bWEv9oUdCCzUkxo4rZKLV2/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wefr3adoZ9gasbnXWH2zOPZSMYnHpfkG6TH0kQ0uAzVo3WW/HxLwyP1nHinKihfJT
         qkOrgjSnX3qyc2CRhNHWCaMLf8/NlnlLzukoKpwdVKPRKWVAsIYAV696tRGB3WRsiW
         tx+iYcA2lLvz4Niu17ASFqm6LRqq/1/o4A6vpVO8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 13/33] efi/gop: Remove unreachable code from setup_pixel_info
Date:   Fri, 24 Apr 2020 15:05:11 +0200
Message-Id: <20200424130531.30518-14-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

pixel_format must be one of
	PIXEL_RGB_RESERVED_8BIT_PER_COLOR
	PIXEL_BGR_RESERVED_8BIT_PER_COLOR
	PIXEL_BIT_MASK
since we skip PIXEL_BLT_ONLY when finding a gop.

Remove the redundant code and add another check in find_gop to skip any
pixel formats that we don't know about, in case a later version of the
UEFI spec adds one.

Reformat the code a little.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-10-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 66 ++++++++++++------------------
 1 file changed, 26 insertions(+), 40 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 8bf424f35759..2d91699e3061 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -29,49 +29,34 @@ static void
 setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 		 efi_pixel_bitmask_t pixel_info, int pixel_format)
 {
-	if (pixel_format == PIXEL_RGB_RESERVED_8BIT_PER_COLOR) {
-		si->lfb_depth = 32;
-		si->lfb_linelength = pixels_per_scan_line * 4;
-		si->red_size = 8;
-		si->red_pos = 0;
-		si->green_size = 8;
-		si->green_pos = 8;
-		si->blue_size = 8;
-		si->blue_pos = 16;
-		si->rsvd_size = 8;
-		si->rsvd_pos = 24;
-	} else if (pixel_format == PIXEL_BGR_RESERVED_8BIT_PER_COLOR) {
-		si->lfb_depth = 32;
-		si->lfb_linelength = pixels_per_scan_line * 4;
-		si->red_size = 8;
-		si->red_pos = 16;
-		si->green_size = 8;
-		si->green_pos = 8;
-		si->blue_size = 8;
-		si->blue_pos = 0;
-		si->rsvd_size = 8;
-		si->rsvd_pos = 24;
-	} else if (pixel_format == PIXEL_BIT_MASK) {
-		find_bits(pixel_info.red_mask, &si->red_pos, &si->red_size);
-		find_bits(pixel_info.green_mask, &si->green_pos,
-			  &si->green_size);
-		find_bits(pixel_info.blue_mask, &si->blue_pos, &si->blue_size);
-		find_bits(pixel_info.reserved_mask, &si->rsvd_pos,
-			  &si->rsvd_size);
+	if (pixel_format == PIXEL_BIT_MASK) {
+		find_bits(pixel_info.red_mask,
+			  &si->red_pos, &si->red_size);
+		find_bits(pixel_info.green_mask,
+			  &si->green_pos, &si->green_size);
+		find_bits(pixel_info.blue_mask,
+			  &si->blue_pos, &si->blue_size);
+		find_bits(pixel_info.reserved_mask,
+			  &si->rsvd_pos, &si->rsvd_size);
 		si->lfb_depth = si->red_size + si->green_size +
 			si->blue_size + si->rsvd_size;
 		si->lfb_linelength = (pixels_per_scan_line * si->lfb_depth) / 8;
 	} else {
-		si->lfb_depth = 4;
-		si->lfb_linelength = si->lfb_width / 2;
-		si->red_size = 0;
-		si->red_pos = 0;
-		si->green_size = 0;
-		si->green_pos = 0;
-		si->blue_size = 0;
-		si->blue_pos = 0;
-		si->rsvd_size = 0;
-		si->rsvd_pos = 0;
+		if (pixel_format == PIXEL_RGB_RESERVED_8BIT_PER_COLOR) {
+			si->red_pos   = 0;
+			si->blue_pos  = 16;
+		} else /* PIXEL_BGR_RESERVED_8BIT_PER_COLOR */ {
+			si->blue_pos  = 0;
+			si->red_pos   = 16;
+		}
+
+		si->green_pos = 8;
+		si->rsvd_pos  = 24;
+		si->red_size = si->green_size =
+			si->blue_size = si->rsvd_size = 8;
+
+		si->lfb_depth = 32;
+		si->lfb_linelength = pixels_per_scan_line * 4;
 	}
 }
 
@@ -100,7 +85,8 @@ find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 
 		mode = efi_table_attr(gop, mode);
 		info = efi_table_attr(mode, info);
-		if (info->pixel_format == PIXEL_BLT_ONLY)
+		if (info->pixel_format == PIXEL_BLT_ONLY ||
+		    info->pixel_format >= PIXEL_FORMAT_MAX)
 			continue;
 
 		/*
-- 
2.17.1

