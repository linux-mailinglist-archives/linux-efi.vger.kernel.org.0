Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB93E18C053
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgCST31 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37177 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgCST3K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id d12so467958qtj.4;
        Thu, 19 Mar 2020 12:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yLbPkx1KOJWUINkAAWmVsrQXp7G7xl6QXWk15AcAOUU=;
        b=q05a2A1tTkOvecKUz49OEnzzO2yqZ0Lje1QwaLp5Bi7NKowBkwCVQTXEyqfA4/gXnr
         FJyxIWqV22PyYzIW+4+G/uR+YVM/kQXE1SSRA8ZW6PKgHUr3KlBygKrxMKCDT15UO5/9
         h79C0SWO9qHG4NxyYXVgd9ZBBd9NzqD7yBN8JHYPb7VWufjk1n2A4J++J1EnPizqMSMO
         vwWQzAcuXjHJeIBHHApLsHqv0r/+K6d6HDNMXGRg+1bNlIHnuqdJseYea1IO9uxDIOKf
         MCV3UW3Fh5WEyLdlTV27cqPFg/l2rwwOUmr4Rdy+JUp2uaNeDXlltuqaH6netB3tOlk3
         T/dg==
X-Gm-Message-State: ANhLgQ1rs4kZQ8v1alJnIAq0xLY8kudExxmQA6DL6Kql/isOUvScR76J
        jei/uY7QGVLzsG8ztuA4n1Q=
X-Google-Smtp-Source: ADFU+vtgfhDAduUdBX8GL/6vWENq96TfBEP/nHb0VG09kDS/aye0GrunVByLfOpvpr+o+Ox+TgNfXg==
X-Received: by 2002:ac8:1184:: with SMTP id d4mr4739801qtj.104.1584646147994;
        Thu, 19 Mar 2020 12:29:07 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:29:07 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] efi/gop: Allow specifying depth as well as resolution
Date:   Thu, 19 Mar 2020 15:28:54 -0400
Message-Id: <20200319192855.29876-14-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Extend the video mode argument to handle an optional color depth
specification of the form
	video=efifb:<xres>x<yres>[-(rgb|bgr|<bpp>)]

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 Documentation/fb/efifb.rst         |  8 +++--
 drivers/firmware/efi/libstub/gop.c | 48 ++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/Documentation/fb/efifb.rst b/Documentation/fb/efifb.rst
index 635275071307..eca38466487a 100644
--- a/Documentation/fb/efifb.rst
+++ b/Documentation/fb/efifb.rst
@@ -50,9 +50,11 @@ mode=n
         The EFI stub will set the mode of the display to mode number n if
         possible.
 
-<xres>x<yres>
+<xres>x<yres>[-(rgb|bgr|<bpp>)]
         The EFI stub will search for a display mode that matches the specified
-        horizontal and vertical resolution, and set the mode of the display to
-        it if one is found.
+        horizontal and vertical resolution, and optionally bit depth, and set
+        the mode of the display to it if one is found. The bit depth can either
+        "rgb" or "bgr" to match specifically those pixel formats, or a number
+        for a mode with matching bits per pixel.
 
 Edgar Hucek <gimli@dark-green.com>
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 2d56efaa1600..671f812e0b5a 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -27,6 +27,8 @@ static struct {
 		u32 mode;
 		struct {
 			u32 width, height;
+			int format;
+			u8 depth;
 		} res;
 	};
 } __efistub_global cmdline = { .option = EFI_CMDLINE_NONE };
@@ -50,7 +52,8 @@ static bool parse_modenum(char *option, char **next)
 
 static bool parse_res(char *option, char **next)
 {
-	u32 w, h;
+	u32 w, h, d = 0;
+	int pf = -1;
 
 	if (!isdigit(*option))
 		return false;
@@ -58,11 +61,26 @@ static bool parse_res(char *option, char **next)
 	if (*option++ != 'x' || !isdigit(*option))
 		return false;
 	h = simple_strtoull(option, &option, 10);
+	if (*option == '-') {
+		option++;
+		if (strstarts(option, "rgb")) {
+			option += strlen("rgb");
+			pf = PIXEL_RGB_RESERVED_8BIT_PER_COLOR;
+		} else if (strstarts(option, "bgr")) {
+			option += strlen("bgr");
+			pf = PIXEL_BGR_RESERVED_8BIT_PER_COLOR;
+		} else if (isdigit(*option))
+			d = simple_strtoull(option, &option, 10);
+		else
+			return false;
+	}
 	if (*option && *option++ != ',')
 		return false;
 	cmdline.option     = EFI_CMDLINE_RES;
 	cmdline.res.width  = w;
 	cmdline.res.height = h;
+	cmdline.res.format = pf;
+	cmdline.res.depth  = d;
 
 	*next = option;
 	return true;
@@ -123,6 +141,18 @@ static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
 	return cmdline.mode;
 }
 
+static u8 pixel_bpp(int pixel_format, efi_pixel_bitmask_t pixel_info)
+{
+	if (pixel_format == PIXEL_BIT_MASK) {
+		u32 mask = pixel_info.red_mask | pixel_info.green_mask |
+			   pixel_info.blue_mask | pixel_info.reserved_mask;
+		if (!mask)
+			return 0;
+		return __fls(mask) - __ffs(mask) + 1;
+	} else
+		return 32;
+}
+
 static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
 {
 	efi_status_t status;
@@ -133,16 +163,21 @@ static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
 
 	u32 max_mode, cur_mode;
 	int pf;
+	efi_pixel_bitmask_t pi;
 	u32 m, w, h;
 
 	mode = efi_table_attr(gop, mode);
 
 	cur_mode = efi_table_attr(mode, mode);
 	info = efi_table_attr(mode, info);
-	w = info->horizontal_resolution;
-	h = info->vertical_resolution;
+	pf = info->pixel_format;
+	pi = info->pixel_information;
+	w  = info->horizontal_resolution;
+	h  = info->vertical_resolution;
 
-	if (w == cmdline.res.width && h == cmdline.res.height)
+	if (w == cmdline.res.width && h == cmdline.res.height &&
+	    (cmdline.res.format < 0 || cmdline.res.format == pf) &&
+	    (!cmdline.res.depth || cmdline.res.depth == pixel_bpp(pf, pi)))
 		return cur_mode;
 
 	max_mode = efi_table_attr(mode, max_mode);
@@ -157,6 +192,7 @@ static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
 			continue;
 
 		pf = info->pixel_format;
+		pi = info->pixel_information;
 		w  = info->horizontal_resolution;
 		h  = info->vertical_resolution;
 
@@ -164,7 +200,9 @@ static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
 
 		if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX)
 			continue;
-		if (w == cmdline.res.width && h == cmdline.res.height)
+		if (w == cmdline.res.width && h == cmdline.res.height &&
+		    (cmdline.res.format < 0 || cmdline.res.format == pf) &&
+		    (!cmdline.res.depth || cmdline.res.depth == pixel_bpp(pf, pi)))
 			return m;
 	}
 
-- 
2.24.1

