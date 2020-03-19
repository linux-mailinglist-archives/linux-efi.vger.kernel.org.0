Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7118C04C
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCST3I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33786 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgCST3I (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id p6so4460249qkm.0;
        Thu, 19 Mar 2020 12:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxLwvZ3842OAdja5sBtS3wfM/U0zOIFbMLzWSk+6Qy4=;
        b=jDWorchE23OSEe8Ys7zvCSyNkUQ3pvMPGysovuV3XwjOi2rIhqQTifaqY/0HFTX0EP
         Oux174LmFNfFIIKPV+Gnd/3CvbTBPJARn7BXQdLZmVTQPHL7C5vCH8PywOmOWnJhSf05
         7RJDF4+eYGto4h3Jmn1uTiktus8UB3TtmrtXedOBjsSp4+ncx9sHPM6aPxUKh8SQJAwp
         /RCidVfQ5SFMVHBxEr8v+KjOrcuiGKjOcSyN+IoN2OKL5NDXJ5QLPSTHr0E59z8OsakD
         bkMM37i/9w2xj8PxRkugr9BjzFQAu9NxLNmdN+52k8ssbBAFbUDji0MzGj8E/N/9cQpv
         22Mw==
X-Gm-Message-State: ANhLgQ2rG4l3xAMvJ6WqVPfa7WB6aG7PtqGKpXYgrUWf3qJhL1BtiA14
        f6mmHdJFhHMdt0P/bRJU+hg=
X-Google-Smtp-Source: ADFU+vvLtCid55BOMHxIN1fIj0nXZif36I6ctwgRYJt3upVXnJbdfkijIZ28trGlDidXwZZT2024Mg==
X-Received: by 2002:a37:92c4:: with SMTP id u187mr4414667qkd.466.1584646147440;
        Thu, 19 Mar 2020 12:29:07 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:29:07 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] efi/gop: Allow specifying mode by <xres>x<yres>
Date:   Thu, 19 Mar 2020 15:28:53 -0400
Message-Id: <20200319192855.29876-13-nivedita@alum.mit.edu>
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
index 34b55715d372..2d56efaa1600 100644
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
 } __efistub_global cmdline = { .option = EFI_CMDLINE_NONE };
 
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
@@ -105,6 +184,9 @@ static void set_mode(efi_graphics_output_protocol_t *gop)
 	case EFI_CMDLINE_MODE_NUM:
 		new_mode = choose_mode_modenum(gop);
 		break;
+	case EFI_CMDLINE_RES:
+		new_mode = choose_mode_res(gop);
+		break;
 	}
 
 	mode = efi_table_attr(gop, mode);
-- 
2.24.1

