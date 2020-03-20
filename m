Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2757618C512
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgCTCA7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:00:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35121 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgCTCAj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id v15so3772924qto.2;
        Thu, 19 Mar 2020 19:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUhHlOPkJK/Ny0i92TgGsRnozqELZwVVJe4uW2CfbBQ=;
        b=rY8qSULu7gLc+ZZ4xZu46Um4flsyD9M0nmRK5AbS7CUxT39PHKb7SLbjDAWN5CEFwp
         nxWdg8d/sQ5jWYpWh7TCF9FK1jYL2/IjdzsCBOnivm9w9gfRw+F+jZoKDabYgxn6vIF2
         FXr1k1wL8EpuGFlVzWRoI2tmFTEwVNw4l5hxgVuWWgJauFtuWXbZ2plhyMv2Byi516fO
         ModF4s9ZVCyGNvY2HEFl0H+BLlFVM1GQVIrsrUPHl8TbqJ4ovRQKDXMJsSeZvfFh/ZdL
         TI9D2vZL8Wie06rc8OZdCF8k1qaOKQP2RsXVO2a4SZm7JLIT8VTC/gA4bgd9GxPFhqma
         XjvA==
X-Gm-Message-State: ANhLgQ1KxdiLwDdpCqvGjDJbtSAIyRCbGYD7iiFbhqtmXoxzmDC2RQNy
        WO9uowds+AC3sRtvDkY0Bk8=
X-Google-Smtp-Source: ADFU+vubnWPJRFIwBxgQTgzeeyi3//do+QYpKxqBUQlzjXMr08CIvui0aOHa0UNi6BZiNVYMcggwkQ==
X-Received: by 2002:ac8:24db:: with SMTP id t27mr6181613qtt.49.1584669637823;
        Thu, 19 Mar 2020 19:00:37 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:37 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/14] efi/gop: Remove unreachable code from setup_pixel_info
Date:   Thu, 19 Mar 2020 22:00:23 -0400
Message-Id: <20200320020028.1936003-10-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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
2.24.1

