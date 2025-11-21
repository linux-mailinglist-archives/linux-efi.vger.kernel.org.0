Return-Path: <linux-efi+bounces-5630-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C246C79FDB
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 15:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 530DC4F2985
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F6434DCC4;
	Fri, 21 Nov 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ufT4qNYQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LvbvTzte";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ufT4qNYQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LvbvTzte"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2A34D905
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733400; cv=none; b=KagBb78nZnnxXGLM6hBDYtH40gR+2UQ2r7ClOJ6W2CzEmZsz0BybJfREP1ValU/JgDgyU0hH/4uOnvECqaWubo9Y5LYewVHcMHP9o1VauX56VdWCYjHExIgjf0q1lkXkn4eBZEjUSZaoQYkRROjlfgRwmZrD8BKnv+wpy2Qa+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733400; c=relaxed/simple;
	bh=wuLG6p1+F5v8s/6OdBkkdXwGOeyA+T7HYtlc1BahPYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTEs8rcwFGaLLvXcn3jc4vxTA+vfyUDliZlEOlIX3ziSE61EbK6yKyPVgY5s+56qfT4Af2bKawlsTkq5sh2cUWOsq/BzagCIAt8MGQf73V8FMm5ibRuz8sVnX9XGkTFDMuwy/BhttdVdsPjji7TELpEeYBuP03SV0SJprNpzp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ufT4qNYQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LvbvTzte; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ufT4qNYQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LvbvTzte; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78E4121011;
	Fri, 21 Nov 2025 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CglNUSO0kp39x0UlCguyZYGnc05enMLut11VcQSN64E=;
	b=ufT4qNYQ5gJn0P/56UGQHy4wkKsoLKl6dHn7/8Fe7GwuN8UB63Gz62eT5GritqKeK4nUxx
	ECD4KPBpQFmyvZoXuYgJiFsXCdMzpN0d9qOVswonkfLvmzWfPO/lqWWp+HIxF7/EcgJm7o
	UOXNPtEq0a0fNiJqBgLm9XOvYTzZw7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CglNUSO0kp39x0UlCguyZYGnc05enMLut11VcQSN64E=;
	b=LvbvTzte+Fr3dlDAdooCBR/Ae/Q04Tk2pCZmTBhPYR1PDQXnhsk/0RSrDP8JwGaTPBB+ss
	xeJp0/hHNxkTIsDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ufT4qNYQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LvbvTzte
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CglNUSO0kp39x0UlCguyZYGnc05enMLut11VcQSN64E=;
	b=ufT4qNYQ5gJn0P/56UGQHy4wkKsoLKl6dHn7/8Fe7GwuN8UB63Gz62eT5GritqKeK4nUxx
	ECD4KPBpQFmyvZoXuYgJiFsXCdMzpN0d9qOVswonkfLvmzWfPO/lqWWp+HIxF7/EcgJm7o
	UOXNPtEq0a0fNiJqBgLm9XOvYTzZw7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CglNUSO0kp39x0UlCguyZYGnc05enMLut11VcQSN64E=;
	b=LvbvTzte+Fr3dlDAdooCBR/Ae/Q04Tk2pCZmTBhPYR1PDQXnhsk/0RSrDP8JwGaTPBB+ss
	xeJp0/hHNxkTIsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21D133EA62;
	Fri, 21 Nov 2025 13:56:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uMELB49vIGkqdQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 21 Nov 2025 13:56:31 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	javierm@redhat.com,
	arnd@arndb.de
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/6] efi: earlycon: Reduce number of references to global screen_info
Date: Fri, 21 Nov 2025 14:36:05 +0100
Message-ID: <20251121135624.494768-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121135624.494768-1-tzimmermann@suse.de>
References: <20251121135624.494768-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 78E4121011
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtfyjk8sg4x43ngtem9djprcp)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

Replace usage of global screen_info with local pointers. This will
later reduce churn when screen_info is being moved.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/efi/earlycon.c | 40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index d18a1a5de144..fac3a295c57f 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -32,12 +32,13 @@ static void *efi_fb;
  */
 static int __init efi_earlycon_remap_fb(void)
 {
+	const struct screen_info *si = &screen_info;
+
 	/* bail if there is no bootconsole or it was unregistered already */
 	if (!earlycon_console || !console_is_registered(earlycon_console))
 		return 0;
 
-	efi_fb = memremap(fb_base, screen_info.lfb_size,
-			  fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
+	efi_fb = memremap(fb_base, si->lfb_size, fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
 
 	return efi_fb ? 0 : -ENOMEM;
 }
@@ -71,12 +72,12 @@ static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
 	early_memunmap(addr, len);
 }
 
-static void efi_earlycon_clear_scanline(unsigned int y)
+static void efi_earlycon_clear_scanline(unsigned int y, const struct screen_info *si)
 {
 	unsigned long *dst;
 	u16 len;
 
-	len = screen_info.lfb_linelength;
+	len = si->lfb_linelength;
 	dst = efi_earlycon_map(y*len, len);
 	if (!dst)
 		return;
@@ -85,7 +86,7 @@ static void efi_earlycon_clear_scanline(unsigned int y)
 	efi_earlycon_unmap(dst, len);
 }
 
-static void efi_earlycon_scroll_up(void)
+static void efi_earlycon_scroll_up(const struct screen_info *si)
 {
 	unsigned long *dst, *src;
 	u16 maxlen = 0;
@@ -99,8 +100,8 @@ static void efi_earlycon_scroll_up(void)
 	}
 	maxlen *= 4;
 
-	len = screen_info.lfb_linelength;
-	height = screen_info.lfb_height;
+	len = si->lfb_linelength;
+	height = si->lfb_height;
 
 	for (i = 0; i < height - font->height; i++) {
 		dst = efi_earlycon_map(i*len, len);
@@ -120,7 +121,8 @@ static void efi_earlycon_scroll_up(void)
 	}
 }
 
-static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
+static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h,
+				    const struct screen_info *si)
 {
 	const u32 color_black = 0x00000000;
 	const u32 color_white = 0x00ffffff;
@@ -145,13 +147,12 @@ static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
 static void
 efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 {
-	struct screen_info *si;
+	const struct screen_info *si = &screen_info;
 	u32 cur_efi_x = efi_x;
 	unsigned int len;
 	const char *s;
 	void *dst;
 
-	si = &screen_info;
 	len = si->lfb_linelength;
 
 	while (num) {
@@ -174,7 +175,7 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 			x = efi_x;
 
 			while (n-- > 0) {
-				efi_earlycon_write_char(dst + x*4, *s, h);
+				efi_earlycon_write_char(dst + x*4, *s, h, si);
 				x += font->width;
 				s++;
 			}
@@ -207,10 +208,10 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 			cur_line_y = (cur_line_y + 1) % max_line_y;
 
 			efi_y -= font->height;
-			efi_earlycon_scroll_up();
+			efi_earlycon_scroll_up(si);
 
 			for (i = 0; i < font->height; i++)
-				efi_earlycon_clear_scanline(efi_y + i);
+				efi_earlycon_clear_scanline(efi_y + i, si);
 		}
 	}
 }
@@ -226,22 +227,21 @@ void __init efi_earlycon_reprobe(void)
 static int __init efi_earlycon_setup(struct earlycon_device *device,
 				     const char *opt)
 {
-	struct screen_info *si;
+	const struct screen_info *si = &screen_info;
 	u16 xres, yres;
 	u32 i;
 
 	fb_wb = opt && !strcmp(opt, "ram");
 
-	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI) {
+	if (si->orig_video_isVGA != VIDEO_TYPE_EFI) {
 		fb_probed = true;
 		return -ENODEV;
 	}
 
-	fb_base = screen_info.lfb_base;
-	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		fb_base |= (u64)screen_info.ext_lfb_base << 32;
+	fb_base = si->lfb_base;
+	if (si->capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		fb_base |= (u64)si->ext_lfb_base << 32;
 
-	si = &screen_info;
 	xres = si->lfb_width;
 	yres = si->lfb_height;
 
@@ -266,7 +266,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
 
 	efi_y -= font->height;
 	for (i = 0; i < (yres - efi_y) / font->height; i++)
-		efi_earlycon_scroll_up();
+		efi_earlycon_scroll_up(si);
 
 	device->con->write = efi_earlycon_write;
 	earlycon_console = device->con;
-- 
2.51.1


