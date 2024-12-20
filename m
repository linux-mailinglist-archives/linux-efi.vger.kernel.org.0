Return-Path: <linux-efi+bounces-2421-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD759F910F
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 12:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8892188B7CB
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1061C5F27;
	Fri, 20 Dec 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0Gx189z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8B1C5F11
	for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693768; cv=none; b=u3bGXnxsENb6eLgqNfjfHFh19e9aXO2E3CzkUJla8LpZCafl8Wwvd/w7P0FfDQpQ/Bif71ZmrZxv3WYOVFPqpmcRYCrQxUaBkS61reV75QKxH9r84ktRYcrsaaPTIYtAxdXH1+H8on+mfqsjqgz/UAiTIjv/l1j68iTcI4wsr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693768; c=relaxed/simple;
	bh=SGrSiYKH1Bc7AsR64Qp4yCfTjgTd1Def+HVGEElIkAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AISi6w2dKtuH7kn/avXq+Uxf3eHFtAj6PBbvcpgFUQ/4v6+05vp4aX4/+AV5/zQ++H8pNVl4oTDbiANn9NsBQaKf0TAUovYroFyIYdPvoOBRq9dPOcWkfeyxWx/xWA3jp8HsEuIQggEUpJledHx2NWwWZzptiujG4C/LwvJN4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q0Gx189z; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so14084185e9.3
        for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 03:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734693765; x=1735298565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KivZZf0CGt5YZd1N5rZVDN/3bZWGDmqhLF0VCWNrGlI=;
        b=Q0Gx189zFX12xNCOP/UbaQycAJiNiZ2jkRn/VYyRkLrKPq35hmL+fduAjXW/NTPkRA
         3yCMKSjb7CWMjfdy2i+A26ty+NJ6NuZe+ZH6byNlZgmz6HOHqqfbbhlx3XAervWsbQu2
         oOg2X7qG1WiocgX/oBul4OuTrMgYtuh9kZAZ31ntc4VScrCu5wqikqRAbvbxld1uuBqL
         b8Z+q1MR7sV2uv4S1IkwpLeW7o6bJOJct9IJGCSF4+Sh+AQrB+zJfhz2IT5ug01yGuEb
         k1XueW7+n2SYI8C8PSSkzLO7EVVezHIA59hGWF+fOEVsnTDs/Vw2wNoPS5aYbhdDjSCi
         n8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734693765; x=1735298565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KivZZf0CGt5YZd1N5rZVDN/3bZWGDmqhLF0VCWNrGlI=;
        b=I70DSiRcTs46NfrhjzCTwUPlYqanVOk2qQyG83Ko7PhzO7dY42kCb6VpfW/unD61XX
         lnYUxZxT1CO6TGy4fJDOR6pKoWbiZ/73cuGWQvuNQfZYv7XX8NF9xo19uxo473FG/IhO
         VU+pYRaSEEGWRXhoilW2WDYQmJGvELNxxNycEqTrYB1aaiI3akeC4Xl/8zBFXGY6JuYp
         Clk0VMr1MPEjD7njNAxCc+vFSewbGXW9rFuV6SlLV48QnF+mjKaHJOQpS7vZsS18W604
         h7/MbhNU99SSBmBDm/WMtXzNJMwMLj8BXewck6+v9lHHa0cWRlamygKM5qZGKKDkbv7Q
         LRnA==
X-Gm-Message-State: AOJu0YyoGhcXAxMfoN4RSIHJkcRKBqvMXfxJRRTnIYa1SfRnIv+qH+C6
	8fWXIsLKzMMXyJlqBd9DhvL3qJfLdfliSLJNrn3Nf/jPjybh7ns9IUqvQEzlWJtY03EP+1F0eEs
	9Ouz4JqpTeNYQUTcWjHUGrmHuDIMmMRoNOydQzAndTHMrdNYZPWU6qV4WPtz4P0lsHoOMA9YfY6
	cRtLOj1qPNpd2u2y6xZ2e6n8UnGQ==
X-Google-Smtp-Source: AGHT+IHC2StE8w43211zdACLPVBjHL2cKB1h4Sdbs6jqqq4BEWyOvYApZkjHXnA7nXifadO5sC+79YM5
X-Received: from wmbay20.prod.google.com ([2002:a05:600c:1e14:b0:436:1995:1888])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:294c:b0:436:51bb:7a53
 with SMTP id 5b1f17b1804b1-43668643ba9mr22260165e9.12.1734693764897; Fri, 20
 Dec 2024 03:22:44 -0800 (PST)
Date: Fri, 20 Dec 2024 12:22:19 +0100
In-Reply-To: <20241220112214.2598872-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241220112214.2598872-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=10137; i=ardb@kernel.org;
 h=from:subject; bh=Ic6NiX9fQ6lT7lNuflzIZfufNkdIR4/g+eMpwHkmBdc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT01ODfiYuCGtftmZ942vuz2cdP/xeusj0hMTtz4cra2Z
 dPG6CdTO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBETuczMsyuMvhQYLVNZkng
 8h3p2t47ndYyWW+vfvjt1stfE5/Jrq5l+Kce9Hnd05LQCMFDj97+/BPu+1BffzHbrRuJ678u/BM suZIXAA==
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241220112214.2598872-13-ardb+git@google.com>
Subject: [PATCH 4/7] efi/libstub: Refactor and cleanup GOP resolution picker code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI stub implements various ways of setting the resolution of the
EFI framebuffer at boot, which duplicate a lot of boilerplate for
iterating over the supported modes and extracting the resolution and
color depth.

Refactor this into a single helper that takes a callback, and use it for
the 'auto', 'list' and 'res' selection methods.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 265 ++++++++------------
 1 file changed, 103 insertions(+), 162 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index fce28488c76c..1e1ec0113904 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -133,13 +133,11 @@ void efi_parse_option_graphics(char *option)
 
 static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
 {
-	efi_status_t status;
-
+	efi_graphics_output_mode_info_t *info __free(efi_pool) = NULL;
 	efi_graphics_output_protocol_mode_t *mode;
-	efi_graphics_output_mode_info_t *info;
 	unsigned long info_size;
-
 	u32 max_mode, cur_mode;
+	efi_status_t status;
 	int pf;
 
 	mode = efi_table_attr(gop, mode);
@@ -154,17 +152,13 @@ static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
 		return cur_mode;
 	}
 
-	status = efi_call_proto(gop, query_mode, cmdline.mode,
-				&info_size, &info);
+	status = efi_call_proto(gop, query_mode, cmdline.mode, &info_size, &info);
 	if (status != EFI_SUCCESS) {
 		efi_err("Couldn't get mode information\n");
 		return cur_mode;
 	}
 
 	pf = info->pixel_format;
-
-	efi_bs_call(free_pool, info);
-
 	if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX) {
 		efi_err("Invalid PixelFormat\n");
 		return cur_mode;
@@ -173,6 +167,28 @@ static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
 	return cmdline.mode;
 }
 
+static u32 choose_mode(efi_graphics_output_protocol_t *gop,
+		       bool (*match)(const efi_graphics_output_mode_info_t *, u32, void *),
+		       void *ctx)
+{
+	efi_graphics_output_protocol_mode_t *mode = efi_table_attr(gop, mode);
+	u32 max_mode = efi_table_attr(mode, max_mode);
+
+	for (u32 m = 0; m < max_mode; m++) {
+		efi_graphics_output_mode_info_t *info __free(efi_pool) = NULL;
+		unsigned long info_size;
+		efi_status_t status;
+
+		status = efi_call_proto(gop, query_mode, m, &info_size, &info);
+		if (status != EFI_SUCCESS)
+			continue;
+
+		if (match(info, m, ctx))
+			return m;
+	}
+	return (unsigned long)ctx;
+}
+
 static u8 pixel_bpp(int pixel_format, efi_pixel_bitmask_t pixel_info)
 {
 	if (pixel_format == PIXEL_BIT_MASK) {
@@ -185,192 +201,117 @@ static u8 pixel_bpp(int pixel_format, efi_pixel_bitmask_t pixel_info)
 		return 32;
 }
 
-static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
+static bool match_res(const efi_graphics_output_mode_info_t *info, u32 mode, void *ctx)
 {
-	efi_status_t status;
+	efi_pixel_bitmask_t pi = info->pixel_information;
+	int pf = info->pixel_format;
 
-	efi_graphics_output_protocol_mode_t *mode;
-	efi_graphics_output_mode_info_t *info;
-	unsigned long info_size;
-
-	u32 max_mode, cur_mode;
-	int pf;
-	efi_pixel_bitmask_t pi;
-	u32 m, w, h;
+	if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX)
+		return false;
 
-	mode = efi_table_attr(gop, mode);
+	return cmdline.res.width == info->horizontal_resolution &&
+	       cmdline.res.height == info->vertical_resolution &&
+	       (cmdline.res.format < 0 || cmdline.res.format == pf) &&
+	       (!cmdline.res.depth || cmdline.res.depth == pixel_bpp(pf, pi));
+}
 
-	cur_mode = efi_table_attr(mode, mode);
-	info = efi_table_attr(mode, info);
-	pf = info->pixel_format;
-	pi = info->pixel_information;
-	w  = info->horizontal_resolution;
-	h  = info->vertical_resolution;
+static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
+{
+	efi_graphics_output_protocol_mode_t *mode = efi_table_attr(gop, mode);
+	unsigned long cur_mode = efi_table_attr(mode, mode);
 
-	if (w == cmdline.res.width && h == cmdline.res.height &&
-	    (cmdline.res.format < 0 || cmdline.res.format == pf) &&
-	    (!cmdline.res.depth || cmdline.res.depth == pixel_bpp(pf, pi)))
+	if (match_res(efi_table_attr(mode, info), cur_mode, NULL))
 		return cur_mode;
 
-	max_mode = efi_table_attr(mode, max_mode);
-
-	for (m = 0; m < max_mode; m++) {
-		if (m == cur_mode)
-			continue;
-
-		status = efi_call_proto(gop, query_mode, m,
-					&info_size, &info);
-		if (status != EFI_SUCCESS)
-			continue;
+	return choose_mode(gop, match_res, (void *)cur_mode);
+}
 
-		pf = info->pixel_format;
-		pi = info->pixel_information;
-		w  = info->horizontal_resolution;
-		h  = info->vertical_resolution;
+struct match {
+	u32	mode;
+	u32	area;
+	u8	depth;
+};
 
-		efi_bs_call(free_pool, info);
+static bool match_auto(const efi_graphics_output_mode_info_t *info, u32 mode, void *ctx)
+{
+	u32 area = info->horizontal_resolution * info->vertical_resolution;
+	efi_pixel_bitmask_t pi = info->pixel_information;
+	int pf = info->pixel_format;
+	u8 depth = pixel_bpp(pf, pi);
+	struct match *m = ctx;
 
-		if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX)
-			continue;
-		if (w == cmdline.res.width && h == cmdline.res.height &&
-		    (cmdline.res.format < 0 || cmdline.res.format == pf) &&
-		    (!cmdline.res.depth || cmdline.res.depth == pixel_bpp(pf, pi)))
-			return m;
-	}
+	if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX)
+		return false;
 
-	efi_err("Couldn't find requested mode\n");
+	if (area > m->area || (area == m->area && depth > m->depth))
+		*m = (struct match){ mode, area, depth };
 
-	return cur_mode;
+	return false;
 }
 
 static u32 choose_mode_auto(efi_graphics_output_protocol_t *gop)
 {
-	efi_status_t status;
+	struct match match = {};
 
-	efi_graphics_output_protocol_mode_t *mode;
-	efi_graphics_output_mode_info_t *info;
-	unsigned long info_size;
+	choose_mode(gop, match_auto, &match);
 
-	u32 max_mode, cur_mode, best_mode, area;
-	u8 depth;
-	int pf;
-	efi_pixel_bitmask_t pi;
-	u32 m, w, h, a;
-	u8 d;
-
-	mode = efi_table_attr(gop, mode);
-
-	cur_mode = efi_table_attr(mode, mode);
-	max_mode = efi_table_attr(mode, max_mode);
-
-	info = efi_table_attr(mode, info);
-
-	pf = info->pixel_format;
-	pi = info->pixel_information;
-	w  = info->horizontal_resolution;
-	h  = info->vertical_resolution;
-
-	best_mode = cur_mode;
-	area = w * h;
-	depth = pixel_bpp(pf, pi);
-
-	for (m = 0; m < max_mode; m++) {
-		if (m == cur_mode)
-			continue;
-
-		status = efi_call_proto(gop, query_mode, m,
-					&info_size, &info);
-		if (status != EFI_SUCCESS)
-			continue;
+	return match.mode;
+}
 
-		pf = info->pixel_format;
-		pi = info->pixel_information;
-		w  = info->horizontal_resolution;
-		h  = info->vertical_resolution;
+static bool match_list(const efi_graphics_output_mode_info_t *info, u32 mode, void *ctx)
+{
+	efi_pixel_bitmask_t pi = info->pixel_information;
+	u32 cur_mode = (unsigned long)ctx;
+	int pf = info->pixel_format;
+	const char *dstr;
+	bool valid;
+	u8 depth;
 
-		efi_bs_call(free_pool, info);
+	valid = !(pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX);
 
-		if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX)
-			continue;
-		a = w * h;
-		if (a < area)
-			continue;
-		d = pixel_bpp(pf, pi);
-		if (a > area || d > depth) {
-			best_mode = m;
-			area = a;
-			depth = d;
-		}
+	switch (pf) {
+	case PIXEL_RGB_RESERVED_8BIT_PER_COLOR:
+		dstr = "rgb";
+		break;
+	case PIXEL_BGR_RESERVED_8BIT_PER_COLOR:
+		dstr = "bgr";
+		break;
+	case PIXEL_BIT_MASK:
+		dstr = "";
+		depth = pixel_bpp(pf, pi);
+		break;
+	case PIXEL_BLT_ONLY:
+		dstr = "blt";
+		break;
+	default:
+		dstr = "xxx";
+		break;
 	}
 
-	return best_mode;
+	efi_printk("Mode %3u %c%c: Resolution %ux%u-%s%.0hhu\n",
+		    mode,
+		    (mode == cur_mode) ? '*' : ' ',
+		    !valid ? '-' : ' ',
+		    info->horizontal_resolution,
+		    info->vertical_resolution,
+		    dstr, depth);
+
+	return false;
 }
 
 static u32 choose_mode_list(efi_graphics_output_protocol_t *gop)
 {
-	efi_status_t status;
-
-	efi_graphics_output_protocol_mode_t *mode;
-	efi_graphics_output_mode_info_t *info;
-	unsigned long info_size;
-
-	u32 max_mode, cur_mode;
-	int pf;
-	efi_pixel_bitmask_t pi;
-	u32 m, w, h;
-	u8 d;
-	const char *dstr;
-	bool valid;
+	efi_graphics_output_protocol_mode_t *mode = efi_table_attr(gop, mode);
+	unsigned long cur_mode = efi_table_attr(mode, mode);
+	u32 max_mode = efi_table_attr(mode, max_mode);
 	efi_input_key_t key;
-
-	mode = efi_table_attr(gop, mode);
-
-	cur_mode = efi_table_attr(mode, mode);
-	max_mode = efi_table_attr(mode, max_mode);
+	efi_status_t status;
 
 	efi_printk("Available graphics modes are 0-%u\n", max_mode-1);
 	efi_puts("  * = current mode\n"
 		 "  - = unusable mode\n");
-	for (m = 0; m < max_mode; m++) {
-		status = efi_call_proto(gop, query_mode, m,
-					&info_size, &info);
-		if (status != EFI_SUCCESS)
-			continue;
 
-		pf = info->pixel_format;
-		pi = info->pixel_information;
-		w  = info->horizontal_resolution;
-		h  = info->vertical_resolution;
-
-		efi_bs_call(free_pool, info);
-
-		valid = !(pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX);
-		d = 0;
-		switch (pf) {
-		case PIXEL_RGB_RESERVED_8BIT_PER_COLOR:
-			dstr = "rgb";
-			break;
-		case PIXEL_BGR_RESERVED_8BIT_PER_COLOR:
-			dstr = "bgr";
-			break;
-		case PIXEL_BIT_MASK:
-			dstr = "";
-			d = pixel_bpp(pf, pi);
-			break;
-		case PIXEL_BLT_ONLY:
-			dstr = "blt";
-			break;
-		default:
-			dstr = "xxx";
-			break;
-		}
-
-		efi_printk("Mode %3u %c%c: Resolution %ux%u-%s%.0hhu\n",
-			   m,
-			   m == cur_mode ? '*' : ' ',
-			   !valid ? '-' : ' ',
-			   w, h, dstr, d);
-	}
+	choose_mode(gop, match_list, (void *)cur_mode);
 
 	efi_puts("\nPress any key to continue (or wait 10 seconds)\n");
 	status = efi_wait_for_key(10 * EFI_USEC_PER_SEC, &key);
-- 
2.47.1.613.gc27f4b7a9f-goog


