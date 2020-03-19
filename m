Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00AB18C059
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCST3j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41082 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbgCST3G (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id s11so4398172qks.8;
        Thu, 19 Mar 2020 12:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUhHlOPkJK/Ny0i92TgGsRnozqELZwVVJe4uW2CfbBQ=;
        b=hl4+7OxzmZoKh1tf52qqlmvsCIY9ioNlqZ+mBm0RkLlcVY/ybQlIKqqUrd7g6hZwSp
         iIyNmQIsQ0rqGB6qscrBKc+x+xAKCQ8DbaRsRYseWLiRIQYNc0MnHqbWt2lRP4WlMgHJ
         /nzaT+vVQUc9NWisazbFeYHW8cMBd1zy6hVjNs/mvUTdevoB7xtcBfYkwF7zybpH8AcG
         EevYO7ZcXXkgNivyjXt618KDpg+vl2hcvuYXOunXaM5vFXu2QEP4AJXvFeFTsMAOaqzx
         ZoGADzMCZXAj6wHlotv/6WBL1mSI8L6YeXIHo9FmNL6CEwcVjAz6LP574RubEYbWRu4D
         HZ9w==
X-Gm-Message-State: ANhLgQ1RfGjHsd8GHOOhVT5jKzbPtg+vb/RnrW3ebnHc270UoX3m2sVA
        jBnnc0WcjgloCVSipi7WZ+NN8MH7
X-Google-Smtp-Source: ADFU+vsEpzewUic3x58KGOidduWV+bjuNGAsTPZxvn8b9O9tA9kihumCtHGo6WbxsW0mawGmMSpt+Q==
X-Received: by 2002:a37:a484:: with SMTP id n126mr4476686qke.362.1584646145137;
        Thu, 19 Mar 2020 12:29:05 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:29:04 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] efi/gop: Remove unreachable code from setup_pixel_info
Date:   Thu, 19 Mar 2020 15:28:50 -0400
Message-Id: <20200319192855.29876-10-nivedita@alum.mit.edu>
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

