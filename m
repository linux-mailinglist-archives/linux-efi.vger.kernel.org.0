Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816231B7654
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgDXNGx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgDXNGv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:51 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A6792087E;
        Fri, 24 Apr 2020 13:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733611;
        bh=SRMy+oO2EF/+CFJMY2bNfExRnH7AZOgojjnqMOddHOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qe92GNKjj35bLagCXbhoTzNSSioHVDp7YxRHpIlR6QD/CCiNeZWrUAawhXXxH/QN3
         yaaCkJ4md+Hg8c0jI6zx9OMA1q8V5Qdm4Zvoc8Oa4kxv2xUV6jgqQV4t8SV1aRAUNO
         fB9KTJPbhlHqB/3vdqkiHl2PUeXwwYZISYrGZQa4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 18/33] efi/gop: Allow automatically choosing the best mode
Date:   Fri, 24 Apr 2020 15:05:16 +0200
Message-Id: <20200424130531.30518-19-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Add the ability to automatically pick the highest resolution video mode
(defined as the product of vertical and horizontal resolution) by using
a command-line argument of the form
	video=efifb:auto

If there are multiple modes with the highest resolution, pick one with
the highest color depth.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200328160601.378299-2-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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
2.17.1

