Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA23E18C051
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCST3L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38844 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgCST3J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so4423480qke.5;
        Thu, 19 Mar 2020 12:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGk7Uv+/O2ikybvT2arJQO+plGFIej/aR9Wwj+bPPqM=;
        b=KHrFDVMFauRhvmPOfw7i7pkJa709Ioa+qNzpI2rVIpGDeY18tudMQfxqr4nDdIq8KR
         pcMyrcBps1iqjoGdTZ5z9R4Dn8ub/zQ+3pojFb1UvgNNIhWeaJyoTx8pI4IJ46hy/3FF
         MnmkymGGOxywFG5LjPmZi5lfT+v760mkTtquo9zYVAMJv3QlB/jub98YY7YdqtvJliH+
         W5UhpW3MgGbqyVgNTuR8em45CZDJtDHOax2T6tRORu51VrrMwN20BMAR3JlTGriJU8/p
         GbfuMzCEj4cVv2rv5bvR56Cmv7brV4/OpZIPDdKF3NkrisnmnyGDd5r0LuKIq9dTGzd5
         4NUA==
X-Gm-Message-State: ANhLgQ08QBmfrWGttbYv5CVARbqt7QKFENzfTYdMES4NBeErEFQ6oK25
        tGApjq9Q4xpDB/tm3iBUi9s=
X-Google-Smtp-Source: ADFU+vunSSufb+vK/Rv5oaLgv4fBhZkecOBbA75ZsTD1LDfVmUrPtBqRn3nkSrWaH2DXn0IJa3IFPw==
X-Received: by 2002:a37:4fd4:: with SMTP id d203mr4758671qkb.249.1584646148579;
        Thu, 19 Mar 2020 12:29:08 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:29:08 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] efi/gop: Allow automatically choosing the best mode
Date:   Thu, 19 Mar 2020 15:28:55 -0400
Message-Id: <20200319192855.29876-15-nivedita@alum.mit.edu>
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
index 671f812e0b5a..affdcb6cca9a 100644
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
@@ -225,6 +301,9 @@ static void set_mode(efi_graphics_output_protocol_t *gop)
 	case EFI_CMDLINE_RES:
 		new_mode = choose_mode_res(gop);
 		break;
+	case EFI_CMDLINE_AUTO:
+		new_mode = choose_mode_auto(gop);
+		break;
 	}
 
 	mode = efi_table_attr(gop, mode);
-- 
2.24.1

