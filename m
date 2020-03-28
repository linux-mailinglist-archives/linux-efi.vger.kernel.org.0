Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6356219673C
	for <lists+linux-efi@lfdr.de>; Sat, 28 Mar 2020 17:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgC1QGN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Mar 2020 12:06:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45345 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgC1QGM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Mar 2020 12:06:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id c145so14253959qke.12
        for <linux-efi@vger.kernel.org>; Sat, 28 Mar 2020 09:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsBOMGhd4B883i39VT6HtO0JojABFeK8xFI0s9Tfi5k=;
        b=PeGGm8RdXbfDYoSzoEt/mERqfVPKxJBuaUIE4JnHjOTrJ4OwWLijgolYGc0FsuoyAM
         Gvt72pYvULnsDxb1gH3J7QHl2sFtuqFYtAVuDN4C49cDd0Sz8FdUNrOYHb3E57mrjGXh
         SQhQhkBHzmZAukiFkObxZLVrwmCL/Ru54zoSpQmTu7Kk1TrdDnCOV8jrehUEd9lP9azL
         HDAt0Ris3B7yoglyL7SLgfTJPwk7SJQGNXauiv1E7Tu/1ZumZXvS+IBQd1PiTtsEn8ff
         egHC2V0KnjIOF0HPuqXNdGucHrzj/xge6vRwaHduArII6qd0ocOiC2areNDVeaRs0EuI
         KFOA==
X-Gm-Message-State: ANhLgQ0AV2oHq/OBkinn62OOJIZQGUrF/keMK0iCLs0dZf5pMGjxyXDW
        I4BUOeFWoNgjSVdO0zXfa9gyBAcL
X-Google-Smtp-Source: ADFU+vtT9pbQbKSz6/poW1h3P1m+3vbWn0ioZaIAFAW3dU498jtizO0rPkO0BuKMpXGmqp6tbxDE0g==
X-Received: by 2002:a37:9e88:: with SMTP id h130mr4536897qke.145.1585411571450;
        Sat, 28 Mar 2020 09:06:11 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n142sm6115695qkn.11.2020.03.28.09.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 09:06:11 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH v3] efi/gop: Allow automatically choosing the best mode
Date:   Sat, 28 Mar 2020 12:06:01 -0400
Message-Id: <20200328160601.378299-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200328160601.378299-1-nivedita@alum.mit.edu>
References: <CAMj1kXFBB4RmokpM7nqm3jPQofDhfC89QuEurz6OwNPureVK8g@mail.gmail.com>
 <20200328160601.378299-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add the ability to automatically pick the highest resolution video mode
(defined as the product of vertical and horizontal resolution) by using
a command-line argument of the form
	video=efifb:auto

If there are multiple modes with the highest resolution, pick one with
the highest color depth.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 Documentation/fb/efifb.rst         |  6 +++
 drivers/firmware/efi/libstub/gop.c | 84 +++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/Documentation/fb/efifb.rst b/Documentation/fb/efifb.rst
index eca38466487a..519550517fd4 100644
--- a/Documentation/fb/efifb.rst
+++ b/Documentation/fb/efifb.rst
@@ -57,4 +57,10 @@ mode=n
         "rgb" or "bgr" to match specifically those pixel formats, or a number
         for a mode with matching bits per pixel.
 
+auto
+        The EFI stub will choose the mode with the highest resolution (product
+        of horizontal and vertical resolution). If there are multiple modes
+        with the highest resolution, it will choose one with the highest color
+        depth.
+
 Edgar Hucek <gimli@dark-green.com>
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 848cb605a9c4..fa05a0b0adfd 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -18,7 +18,8 @@
 enum efi_cmdline_option {
 	EFI_CMDLINE_NONE,
 	EFI_CMDLINE_MODE_NUM,
-	EFI_CMDLINE_RES
+	EFI_CMDLINE_RES,
+	EFI_CMDLINE_AUTO
 };
 
 static struct {
@@ -86,6 +87,19 @@ static bool parse_res(char *option, char **next)
 	return true;
 }
 
+static bool parse_auto(char *option, char **next)
+{
+	if (!strstarts(option, "auto"))
+		return false;
+	option += strlen("auto");
+	if (*option && *option++ != ',')
+		return false;
+	cmdline.option = EFI_CMDLINE_AUTO;
+
+	*next = option;
+	return true;
+}
+
 void efi_parse_option_graphics(char *option)
 {
 	while (*option) {
@@ -93,6 +107,8 @@ void efi_parse_option_graphics(char *option)
 			continue;
 		if (parse_res(option, &option))
 			continue;
+		if (parse_auto(option, &option))
+			continue;
 
 		while (*option && *option++ != ',')
 			;
@@ -211,6 +227,69 @@ static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
 	return cur_mode;
 }
 
+static u32 choose_mode_auto(efi_graphics_output_protocol_t *gop)
+{
+	efi_status_t status;
+
+	efi_graphics_output_protocol_mode_t *mode;
+	efi_graphics_output_mode_info_t *info;
+	unsigned long info_size;
+
+	u32 max_mode, cur_mode, best_mode, area;
+	u8 depth;
+	int pf;
+	efi_pixel_bitmask_t pi;
+	u32 m, w, h, a;
+	u8 d;
+
+	mode = efi_table_attr(gop, mode);
+
+	cur_mode = efi_table_attr(mode, mode);
+	max_mode = efi_table_attr(mode, max_mode);
+
+	info = efi_table_attr(mode, info);
+
+	pf = info->pixel_format;
+	pi = info->pixel_information;
+	w  = info->horizontal_resolution;
+	h  = info->vertical_resolution;
+
+	best_mode = cur_mode;
+	area = w * h;
+	depth = pixel_bpp(pf, pi);
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
+		pi = info->pixel_information;
+		w  = info->horizontal_resolution;
+		h  = info->vertical_resolution;
+
+		efi_bs_call(free_pool, info);
+
+		if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX)
+			continue;
+		a = w * h;
+		if (a < area)
+			continue;
+		d = pixel_bpp(pf, pi);
+		if (a > area || d > depth) {
+			best_mode = m;
+			area = a;
+			depth = d;
+		}
+	}
+
+	return best_mode;
+}
+
 static void set_mode(efi_graphics_output_protocol_t *gop)
 {
 	efi_graphics_output_protocol_mode_t *mode;
@@ -223,6 +302,9 @@ static void set_mode(efi_graphics_output_protocol_t *gop)
 	case EFI_CMDLINE_RES:
 		new_mode = choose_mode_res(gop);
 		break;
+	case EFI_CMDLINE_AUTO:
+		new_mode = choose_mode_auto(gop);
+		break;
 	default:
 		return;
 	}
-- 
2.24.1

