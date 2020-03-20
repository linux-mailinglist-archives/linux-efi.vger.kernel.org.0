Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62018C50A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCTCAu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:00:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39454 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgCTCAn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id f20so3752238qtq.6;
        Thu, 19 Mar 2020 19:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4YH7wJccvNqVFE+7bT0TKJxmG8zeAsHJ4GcERZ/wlKc=;
        b=teyfFaOem6a5hD75en75DpZoj/B/l+MKz16SFNmU5hg7a8xdUNRP/drrmXheY/z3xT
         lluPe13RrfwAfgUrhvV83aZFZs1b46nXGN8oJf/VP2BjpKPYQQgHjLvwiG+KqKX8G/A6
         yA9oeqGdemuHs4ZUO/P5SYirmHmMIWr0pKHph/Sk04B22s1BdWFRpix0+GjQFQlA0rFE
         tcD46VLlJYieDYjWsb55gEMIApPy2DBb2O7jdhYdtwWSFJEaffkhlYneSBXSp9uol9rh
         a9g3o/73jIdbnUu490DjppTyai8727S7r+pZmP3kGZY5pJT90jRr8Tas2q9GXYRNNU7j
         LMpQ==
X-Gm-Message-State: ANhLgQ1Gavb55RUt2fnPBDZi7Yx/BwjeL0I0AN1XH1VTm5zxzvgNpGSQ
        esRxHYl5M83tkgDQvAsodJG9qYrN
X-Google-Smtp-Source: ADFU+vuTr6ZlixHu3JoYrdNMUBJeVR0GPX+xzDoKKz3XM8edAmDOijqlF1q5f1AOO3lk38q5vh7tDA==
X-Received: by 2002:ac8:65d0:: with SMTP id t16mr6001354qto.154.1584669642250;
        Thu, 19 Mar 2020 19:00:42 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:41 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/14] efi/gop: Allow automatically choosing the best mode
Date:   Thu, 19 Mar 2020 22:00:28 -0400
Message-Id: <20200320020028.1936003-15-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
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
 drivers/firmware/efi/libstub/gop.c | 81 +++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

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
index 848cb605a9c4..0882c07a9f54 100644
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
@@ -211,6 +227,66 @@ static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
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
@@ -223,6 +299,9 @@ static void set_mode(efi_graphics_output_protocol_t *gop)
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

