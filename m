Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159E01B7653
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgDXNGt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgDXNGs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:48 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54EDE21582;
        Fri, 24 Apr 2020 13:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733607;
        bh=ti7o2wvzWD5uBibPRB7wXDoilnMCRc5lKbVwQ8cbNqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hx/VQchmd0UR/Xu7wr3nMZ8zuY6xlm6+TL0pIIYA4Y904Ebf2sZNMkAFxU8dr5Faf
         MGWB9CHQ2HyJRO7I2955vuz+AbSM388Db5H6seD5jVL3OwHiGOgg3bZ2gbDTbSApkb
         kjdCeQSyilRVTsAD+A1O3g9bY7zh/NJp8h6hMTKM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 16/33] efi/gop: Allow specifying mode by <xres>x<yres>
Date:   Fri, 24 Apr 2020 15:05:14 +0200
Message-Id: <20200424130531.30518-17-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Add the ability to choose a video mode using a command-line argument of
the form
	video=efifb:<xres>x<yres>

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-13-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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
2.17.1

