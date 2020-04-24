Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DCB1B7670
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgDXNH7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgDXNGt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:49 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7814E208E4;
        Fri, 24 Apr 2020 13:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733609;
        bh=1WrbrzvZ9LXmWaooz3ri6pkY4Ib9PORA1CphY5O0EtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRdN4+I17nDJhAJogCCssKFoij5s3wnqzm8l3IpgCd/W3YyXv3O6JWUHYCqls1Wvt
         uiaCwhK8fIlcBkiG87h+Z5nI0wJRj+sAws6wdD1mTA9wSIpknS7iAmhKiurnQcKg9V
         JdH8o6yWvjAq8X6f2OaotuNmxGPkijsSM49v6h3c=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 17/33] efi/gop: Allow specifying depth as well as resolution
Date:   Fri, 24 Apr 2020 15:05:15 +0200
Message-Id: <20200424130531.30518-18-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Extend the video mode argument to handle an optional color depth
specification of the form
	video=efifb:<xres>x<yres>[-(rgb|bgr|<bpp>)]

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-14-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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
index cc84e6a82f54..848cb605a9c4 100644
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
 } cmdline __efistub_global = { .option = EFI_CMDLINE_NONE };
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
2.17.1

