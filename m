Return-Path: <linux-efi+bounces-5050-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985CDBDF90D
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 18:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFBC400D29
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3AC3375A7;
	Wed, 15 Oct 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bgvFNA9a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="52fjVt4M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bgvFNA9a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="52fjVt4M"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84945335BAF
	for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544513; cv=none; b=AO9SDioP6VMISIUZ0j9sqsfxRyl8E8zs1I9hZoYEnLUS4ZQ/4/imvu63kWiIh45AcEKctEKw0F+BY5hwhCn2t+onTWq7S27hADrcooPl+PygPqIq0wzRGFh2Xm2J/beULzf+dQcwoUyk6qnljbJ+ogoyvlyFvIT5bFnb+94mhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544513; c=relaxed/simple;
	bh=Z5C8e0XiSxAjnpxu2bSEtV+3exrcivSCS10a+Exawng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etFUTKa1XMbofOKkS7/+XZFxkZ39k0JwIAwvJeCHKcQexnIb+z9sxunmfgK28GWLSB6YmAnXJG4rYJgMZnFmD+vZLe7dXjcp1r2Od1uS/Ep9fjAKEb8p6eid6LFzVp2O22cPjyzEYtXGakZ542kMsWvjN8SF9SJZYa48ZCcOinU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bgvFNA9a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=52fjVt4M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bgvFNA9a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=52fjVt4M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65FEC2119A;
	Wed, 15 Oct 2025 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760544502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JI/tzd589AP9VmmQUX88anLh/JqoSsRu/o/hT6jUtjc=;
	b=bgvFNA9aWqxSOLSEOdrPvQcVQ75uf7tfm7EZkBfjiue9x7g9nZYUeTe8hR+smvHDJNLOOP
	rHdoX6KBBMXWuVCnvKdESpD3QqVKpurjRNMlCBvnTya+Y9XXcJPUtPvSl8GeBfc/cW/HYK
	QMsbbVXE105TzT28EoMZeYaTybrBVBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760544502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JI/tzd589AP9VmmQUX88anLh/JqoSsRu/o/hT6jUtjc=;
	b=52fjVt4MZnWZuBLcgc8uqp4y+jw0rLka0xR5IB1aT9/1pQP6NAcU8KVzZlg4tWRR8AZSD1
	DtxrHMfrnxmer0CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bgvFNA9a;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=52fjVt4M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760544502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JI/tzd589AP9VmmQUX88anLh/JqoSsRu/o/hT6jUtjc=;
	b=bgvFNA9aWqxSOLSEOdrPvQcVQ75uf7tfm7EZkBfjiue9x7g9nZYUeTe8hR+smvHDJNLOOP
	rHdoX6KBBMXWuVCnvKdESpD3QqVKpurjRNMlCBvnTya+Y9XXcJPUtPvSl8GeBfc/cW/HYK
	QMsbbVXE105TzT28EoMZeYaTybrBVBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760544502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JI/tzd589AP9VmmQUX88anLh/JqoSsRu/o/hT6jUtjc=;
	b=52fjVt4MZnWZuBLcgc8uqp4y+jw0rLka0xR5IB1aT9/1pQP6NAcU8KVzZlg4tWRR8AZSD1
	DtxrHMfrnxmer0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AF2B13AE4;
	Wed, 15 Oct 2025 16:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sEJFCfbG72inaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 15 Oct 2025 16:08:22 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	jonathan@marek.ca,
	javierm@redhat.com
Cc: linux-efi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/5] efi/libstub: gop: Initialize screen_info in helper function
Date: Wed, 15 Oct 2025 17:56:32 +0200
Message-ID: <20251015160816.525825-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015160816.525825-1-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 65FEC2119A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxjygmbcnsta4qeme9o4pgs8z)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

Move initialization of screen_info into a single helper function.
Frees up space in the main setup helper for adding EDID support.
No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/efi/libstub/gop.c | 76 +++++++++++++-----------------
 1 file changed, 33 insertions(+), 43 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index fd32be8dd146..02459ef0f18c 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -367,24 +367,31 @@ static void find_bits(u32 mask, u8 *pos, u8 *size)
 	*size = __fls(mask) - *pos + 1;
 }
 
-static void
-setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
-		 efi_pixel_bitmask_t pixel_info, int pixel_format)
+static void setup_screen_info(struct screen_info *si, const efi_graphics_output_protocol_t *gop)
 {
-	if (pixel_format == PIXEL_BIT_MASK) {
-		find_bits(pixel_info.red_mask,
-			  &si->red_pos, &si->red_size);
-		find_bits(pixel_info.green_mask,
-			  &si->green_pos, &si->green_size);
-		find_bits(pixel_info.blue_mask,
-			  &si->blue_pos, &si->blue_size);
-		find_bits(pixel_info.reserved_mask,
-			  &si->rsvd_pos, &si->rsvd_size);
-		si->lfb_depth = si->red_size + si->green_size +
-			si->blue_size + si->rsvd_size;
-		si->lfb_linelength = (pixels_per_scan_line * si->lfb_depth) / 8;
+	const efi_graphics_output_protocol_mode_t *mode = efi_table_attr(gop, mode);
+	const efi_graphics_output_mode_info_t *info = efi_table_attr(mode, info);
+
+	si->orig_video_isVGA = VIDEO_TYPE_EFI;
+
+	si->lfb_width  = info->horizontal_resolution;
+	si->lfb_height = info->vertical_resolution;
+
+	efi_set_u64_split(efi_table_attr(mode, frame_buffer_base),
+			  &si->lfb_base, &si->ext_lfb_base);
+	if (si->ext_lfb_base)
+		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
+	si->pages = 1;
+
+	if (info->pixel_format == PIXEL_BIT_MASK) {
+		find_bits(info->pixel_information.red_mask, &si->red_pos, &si->red_size);
+		find_bits(info->pixel_information.green_mask, &si->green_pos, &si->green_size);
+		find_bits(info->pixel_information.blue_mask, &si->blue_pos, &si->blue_size);
+		find_bits(info->pixel_information.reserved_mask, &si->rsvd_pos, &si->rsvd_size);
+		si->lfb_depth = si->red_size + si->green_size + si->blue_size + si->rsvd_size;
+		si->lfb_linelength = (info->pixels_per_scan_line * si->lfb_depth) / 8;
 	} else {
-		if (pixel_format == PIXEL_RGB_RESERVED_8BIT_PER_COLOR) {
+		if (info->pixel_format == PIXEL_RGB_RESERVED_8BIT_PER_COLOR) {
 			si->red_pos   = 0;
 			si->blue_pos  = 16;
 		} else /* PIXEL_BGR_RESERVED_8BIT_PER_COLOR */ {
@@ -394,12 +401,16 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 
 		si->green_pos = 8;
 		si->rsvd_pos  = 24;
-		si->red_size = si->green_size =
-			si->blue_size = si->rsvd_size = 8;
-
+		si->red_size = 8;
+		si->green_size = 8;
+		si->blue_size = 8;
+		si->rsvd_size = 8;
 		si->lfb_depth = 32;
-		si->lfb_linelength = pixels_per_scan_line * 4;
+		si->lfb_linelength = info->pixels_per_scan_line * 4;
 	}
+
+	si->lfb_size = si->lfb_linelength * si->lfb_height;
+	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
 }
 
 static efi_handle_t find_handle_with_primary_gop(unsigned long num, const efi_handle_t handles[],
@@ -462,8 +473,6 @@ efi_status_t efi_setup_gop(struct screen_info *si)
 {
 	efi_handle_t *handles __free(efi_pool) = NULL;
 	efi_handle_t handle;
-	efi_graphics_output_protocol_mode_t *mode;
-	efi_graphics_output_mode_info_t *info;
 	efi_graphics_output_protocol_t *gop;
 	efi_status_t status;
 	unsigned long num;
@@ -482,27 +491,8 @@ efi_status_t efi_setup_gop(struct screen_info *si)
 	set_mode(gop);
 
 	/* EFI framebuffer */
-	mode = efi_table_attr(gop, mode);
-	info = efi_table_attr(mode, info);
-
-	si->orig_video_isVGA = VIDEO_TYPE_EFI;
-
-	si->lfb_width  = info->horizontal_resolution;
-	si->lfb_height = info->vertical_resolution;
-
-	efi_set_u64_split(efi_table_attr(mode, frame_buffer_base),
-			  &si->lfb_base, &si->ext_lfb_base);
-	if (si->ext_lfb_base)
-		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
-
-	si->pages = 1;
-
-	setup_pixel_info(si, info->pixels_per_scan_line,
-			     info->pixel_information, info->pixel_format);
-
-	si->lfb_size = si->lfb_linelength * si->lfb_height;
-
-	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
+	if (si)
+		setup_screen_info(si, gop);
 
 	return EFI_SUCCESS;
 }
-- 
2.51.0


