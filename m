Return-Path: <linux-efi+bounces-5663-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6426AC81AD4
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 17:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38B73AA3B0
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F943164BF;
	Mon, 24 Nov 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dcDUjCI3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gWriWF6D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dcDUjCI3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gWriWF6D"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7686E314D17
	for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003089; cv=none; b=Ez79yIaxrpqCaX5JDUSazR6Yy8kJZYcKYsw7kdAxFNToqSASnRCJ5EYFjvkRu/T1rpw7QqADaocVQWm7UKMW5wjlG92LcQ1DG4LfI1/OF7umG6l6lAapx0oRuRKa9ci5SqLcyWcxrjZa3GslCXx4OA5softRVEBOPnFELdKqFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003089; c=relaxed/simple;
	bh=L1aPOhyq8DGxlHXlPMvUQew9wYYpOFCTBbsUMdEBg7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MICr3jtEU1MS78bHw2mYnX/K+AuqcWYOmijRZsA5y4aF1J0arPF1qtMd4IM5cbJd29yS1Q9pNMEYHW2HW4cv/i61IRek+/3MqkrOv+MSTGC35zjbifZ4uW41kdr5Sfw639Ly/KXOqCphw/OJU3qlAFbDwXurN/W93hrPTxD8WZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dcDUjCI3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gWriWF6D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dcDUjCI3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gWriWF6D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 477095BCFB;
	Mon, 24 Nov 2025 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63HXk2asPcR6HKGFSmIOTJlWneEzg1F4AZ9qPy2VUyc=;
	b=dcDUjCI3uj/QmtPJnbVXTs2PBaK75kBtz5OqbM0Ly9ubTksmw4pjAKOEWb7b70uMGsWAEF
	Ripb3MiANiHw6A5S7I7KHj200WMVggKr0MXXHsBIS5MPthtJoTEKzck1aF5734yPgd73qO
	ZoC7dhAzSo4rgjJH4s0oymibQbqySro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63HXk2asPcR6HKGFSmIOTJlWneEzg1F4AZ9qPy2VUyc=;
	b=gWriWF6D8Q9+do0pE8VLw3CTkcfh5ZRwMCG4sFZAPf4FLq/ypiCgcVxDskWfrbOzAOlchX
	KN4QRHEfnqfo62Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dcDUjCI3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gWriWF6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63HXk2asPcR6HKGFSmIOTJlWneEzg1F4AZ9qPy2VUyc=;
	b=dcDUjCI3uj/QmtPJnbVXTs2PBaK75kBtz5OqbM0Ly9ubTksmw4pjAKOEWb7b70uMGsWAEF
	Ripb3MiANiHw6A5S7I7KHj200WMVggKr0MXXHsBIS5MPthtJoTEKzck1aF5734yPgd73qO
	ZoC7dhAzSo4rgjJH4s0oymibQbqySro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63HXk2asPcR6HKGFSmIOTJlWneEzg1F4AZ9qPy2VUyc=;
	b=gWriWF6D8Q9+do0pE8VLw3CTkcfh5ZRwMCG4sFZAPf4FLq/ypiCgcVxDskWfrbOzAOlchX
	KN4QRHEfnqfo62Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1CC63EA65;
	Mon, 24 Nov 2025 16:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mDQXJgyNJGm3GgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Nov 2025 16:51:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	javierm@redhat.com,
	arnd@arndb.de,
	richard.lyu@suse.com
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
Subject: [PATCH v2 01/10] efi: earlycon: Reduce number of references to global screen_info
Date: Mon, 24 Nov 2025 17:40:13 +0100
Message-ID: <20251124165116.502813-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124165116.502813-1-tzimmermann@suse.de>
References: <20251124165116.502813-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 477095BCFB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Replace usage of global screen_info with local pointers. This will
later reduce churn when screen_info is being moved.

v2:
- fix coding style

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Richard Lyu <richard.lyu@suse.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/earlycon.c | 40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index d18a1a5de144..42e3a173dac1 100644
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
+				efi_earlycon_write_char(dst + x * 4, *s, h, si);
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


