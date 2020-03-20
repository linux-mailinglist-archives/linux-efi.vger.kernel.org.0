Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A7F18C50F
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgCTCA7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:00:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36245 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgCTCAl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so3761441qtb.3;
        Thu, 19 Mar 2020 19:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WS1iTe1ohH41U88R4+TWqTxZ3y8tLiwoA5aGAyJthd8=;
        b=O5lC3K7mbGcRe+oFmCm0L2tN8nzc1u1qZgrLBpxpHMvgUJL8ygsNO3nvElc0vFVAtI
         50qlqIvudj/UVY/1YXpYSy3AHeD5Bgrtm4dqdtz1hVYTxB3akNBAFbT141uZTbHIExn1
         YFs7+HtGS0FELmmgOONpbBo+xpjoQQX7qrHb1azmGRPPiOO7j4Saa8UysRYkrt3qoFRk
         RmukQGNokgMHtgD3lIIF7Lm2EbJZrBdQjtB3KqR0+H60EPyI2XpJciNBz8rkciHsDbkD
         q0vJVCsUK7O//Y/5KjTwPGGl93fJ4xvuyUm44lV6ZiXe0tKrLXMHQ49BI6IXHmQTYVLx
         bo9A==
X-Gm-Message-State: ANhLgQ1hnA+NYzkdePilku+Vu9aBmkwM1GrY8rdNFWY4c+m5LPUa+MdN
        w1D71c2Hycq0Ru10MfxpZJLnNDFM
X-Google-Smtp-Source: ADFU+vsbz2JkDbWmqEnG4iXDDWEdo2RadsqfvkEHsDI3BLIHRekWA+D973lDBgQI8CMM4VN4uo3RJg==
X-Received: by 2002:ac8:6d0b:: with SMTP id o11mr5943225qtt.324.1584669640577;
        Thu, 19 Mar 2020 19:00:40 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:39 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] efi/gop: Allow specifying mode by <xres>x<yres>
Date:   Thu, 19 Mar 2020 22:00:26 -0400
Message-Id: <20200320020028.1936003-13-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add the ability to choose a video mode using a command-line argument of
the form
	video=efifb:<xres>x<yres>

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 Documentation/fb/efifb.rst         |  5 ++
 drivers/firmware/efi/libstub/gop.c | 84 +++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/Documentation/fb/efifb.rst b/Documentation/fb/efifb.rst
index 367fbda2f4da..635275071307 100644
--- a/Documentation/fb/efifb.rst
+++ b/Documentation/fb/efifb.rst
@@ -50,4 +50,9 @@ mode=n
         The EFI stub will set the mode of the display to mode number n if
         possible.
 
+<xres>x<yres>
+        The EFI stub will search for a display mode that matches the specified
+        horizontal and vertical resolution, and set the mode of the display to
+        it if one is found.
+
 Edgar Hucek <gimli@dark-green.com>
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index a32b784b4577..cc84e6a82f54 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -6,6 +6,7 @@
  * ----------------------------------------------------------------------- */
 
 #include <linux/bitops.h>
+#include <linux/ctype.h>
 #include <linux/efi.h>
 #include <linux/screen_info.h>
 #include <linux/string.h>
@@ -17,11 +18,17 @@
 enum efi_cmdline_option {
 	EFI_CMDLINE_NONE,
 	EFI_CMDLINE_MODE_NUM,
+	EFI_CMDLINE_RES
 };
 
 static struct {
 	enum efi_cmdline_option option;
-	u32 mode;
+	union {
+		u32 mode;
+		struct {
+			u32 width, height;
+		} res;
+	};
 } cmdline __efistub_global = { .option = EFI_CMDLINE_NONE };
 
 static bool parse_modenum(char *option, char **next)
@@ -41,11 +48,33 @@ static bool parse_modenum(char *option, char **next)
 	return true;
 }
 
+static bool parse_res(char *option, char **next)
+{
+	u32 w, h;
+
+	if (!isdigit(*option))
+		return false;
+	w = simple_strtoull(option, &option, 10);
+	if (*option++ != 'x' || !isdigit(*option))
+		return false;
+	h = simple_strtoull(option, &option, 10);
+	if (*option && *option++ != ',')
+		return false;
+	cmdline.option     = EFI_CMDLINE_RES;
+	cmdline.res.width  = w;
+	cmdline.res.height = h;
+
+	*next = option;
+	return true;
+}
+
 void efi_parse_option_graphics(char *option)
 {
 	while (*option) {
 		if (parse_modenum(option, &option))
 			continue;
+		if (parse_res(option, &option))
+			continue;
 
 		while (*option && *option++ != ',')
 			;
@@ -94,6 +123,56 @@ static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
 	return cmdline.mode;
 }
 
+static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
+{
+	efi_status_t status;
+
+	efi_graphics_output_protocol_mode_t *mode;
+	efi_graphics_output_mode_info_t *info;
+	unsigned long info_size;
+
+	u32 max_mode, cur_mode;
+	int pf;
+	u32 m, w, h;
+
+	mode = efi_table_attr(gop, mode);
+
+	cur_mode = efi_table_attr(mode, mode);
+	info = efi_table_attr(mode, info);
+	w = info->horizontal_resolution;
+	h = info->vertical_resolution;
+
+	if (w == cmdline.res.width && h == cmdline.res.height)
+		return cur_mode;
+
+	max_mode = efi_table_attr(mode, max_mode);
+
+	for (m = 0; m < max_mode; m++) {
+		if (m == cur_mode)
+			continue;
+
+		status = efi_call_proto(gop, query_mode, m,
+					&info_size, &info);
+		if (status != EFI_SUCCESS)
+			continue;
+
+		pf = info->pixel_format;
+		w  = info->horizontal_resolution;
+		h  = info->vertical_resolution;
+
+		efi_bs_call(free_pool, info);
+
+		if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX)
+			continue;
+		if (w == cmdline.res.width && h == cmdline.res.height)
+			return m;
+	}
+
+	efi_printk("Couldn't find requested mode\n");
+
+	return cur_mode;
+}
+
 static void set_mode(efi_graphics_output_protocol_t *gop)
 {
 	efi_graphics_output_protocol_mode_t *mode;
@@ -103,6 +182,9 @@ static void set_mode(efi_graphics_output_protocol_t *gop)
 	case EFI_CMDLINE_MODE_NUM:
 		new_mode = choose_mode_modenum(gop);
 		break;
+	case EFI_CMDLINE_RES:
+		new_mode = choose_mode_res(gop);
+		break;
 	default:
 		return;
 	}
-- 
2.24.1

