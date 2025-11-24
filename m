Return-Path: <linux-efi+bounces-5666-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1EFC81B0A
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 17:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 281A14E7834
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8753191C0;
	Mon, 24 Nov 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jS1i6IfW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FhL3rF2t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OLQ6hcJa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CViN89qW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7983164D8
	for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003097; cv=none; b=a19lVHyw2CmTOsAI6BUFq4qQTo1+H1odeUO5WXbmfRGZmlSuIa3/JkbHWLaooS/g1NLsqjXh80JBJK2qpIAKH0P8vVzTvLfdA0XDSfCzlK9LcWfokIiz7Xci11FEjokSzyitCAT+0rcavoa4bhHiovCb4J2xIonEXXbFzDO6cvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003097; c=relaxed/simple;
	bh=/kuMCC5leu0oR7QSirQiv13QRdBFSZlUqZuADF+YmU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ2bqGaLdnmsg5BwJWAY007PUEdFvLt1vwc/8yh+VhEbjleYsDwh46Wywy3ce+uftG40oMW6HO63xioHGe2/U8ncsVK1cKrBpiCAe9vm8dKLZEkVLhYpKPSeQOzzc/5mfkDnqFqmMPVoVQyJJUX/xBIXsehjA+VrqbXvJLmaj8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jS1i6IfW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FhL3rF2t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OLQ6hcJa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CViN89qW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E01C02209D;
	Mon, 24 Nov 2025 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLqTeUqxHMGJ5DwnWS0LONaS0qMJkFM3aTtgypG/rBQ=;
	b=jS1i6IfWq0ZcAvss1Fup6DR74FyOX6+XfO9leC2zhmZpd5byYFvd9brUAPJV98CBywQK1f
	1vS3hthK9xuS9CP/IrX2Pqw720mWC8BTDBTQZ3Hfm2+p0+5eeIa9BoXwsGXkt5uOCVtCvp
	Ccuug6rIi/MQOIu35Aa6Wse0swD9tbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLqTeUqxHMGJ5DwnWS0LONaS0qMJkFM3aTtgypG/rBQ=;
	b=FhL3rF2tNgNjMw862AiKoenW+0dOil2wcFEZuN+XGERLizsyomFC4QHQxqd56cjGLb+946
	pJbPIdWdRfWV/TDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OLQ6hcJa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CViN89qW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLqTeUqxHMGJ5DwnWS0LONaS0qMJkFM3aTtgypG/rBQ=;
	b=OLQ6hcJaixCNRd5Bkzl5cad2pIi5gGIx/IN4o5WHnT6aNOFWvi4RsvN2A6O5ONtBrk6Iz9
	WwEANo7/afsE4mM4hHu6/Vj96K2fDX6i2mIc2YQFXNvP/G/cwl0zqmpI2FC/pQQwqnE4qR
	QeDJgMF7CuBd+uq8V/pofts70J/t4LY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLqTeUqxHMGJ5DwnWS0LONaS0qMJkFM3aTtgypG/rBQ=;
	b=CViN89qWYUrZ9ax3VCv2Gw0CnoJBmREcXW0HrHCl1K2VCsxOsFVjfvIAnK6+tjEkweBjez
	/uTg8mefD4jsYeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 770353EA63;
	Mon, 24 Nov 2025 16:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gDLXGw2NJGm3GgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Nov 2025 16:51:25 +0000
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
Subject: [PATCH v2 02/10] efi: sysfb_efi: Reduce number of references to global screen_info
Date: Mon, 24 Nov 2025 17:40:14 +0100
Message-ID: <20251124165116.502813-3-tzimmermann@suse.de>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E01C02209D
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Score: -3.01

Replace usage of global screen_info with local pointers. This will
later reduce churn when screen_info is being moved.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Richard Lyu <richard.lyu@suse.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/sysfb_efi.c  | 81 ++++++++++++++++---------------
 drivers/firmware/sysfb.c          |  4 +-
 drivers/firmware/sysfb_simplefb.c |  2 +-
 include/linux/sysfb.h             |  9 ++--
 4 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 1e509595ac03..8e0f9d08397f 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -92,7 +92,7 @@ void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 	})
 
 #ifdef CONFIG_EFI
-static int __init efifb_set_system(const struct dmi_system_id *id)
+static int __init efifb_set_system(struct screen_info *si, const struct dmi_system_id *id)
 {
 	struct efifb_dmi_info *info = id->driver_data;
 
@@ -101,14 +101,14 @@ static int __init efifb_set_system(const struct dmi_system_id *id)
 		return 0;
 
 	/* Trust the bootloader over the DMI tables */
-	if (screen_info.lfb_base == 0) {
+	if (si->lfb_base == 0) {
 #if defined(CONFIG_PCI)
 		struct pci_dev *dev = NULL;
 		int found_bar = 0;
 #endif
 		if (info->base) {
-			screen_info.lfb_base = choose_value(info->base,
-				screen_info.lfb_base, OVERRIDE_BASE,
+			si->lfb_base = choose_value(info->base,
+				si->lfb_base, OVERRIDE_BASE,
 				info->flags);
 
 #if defined(CONFIG_PCI)
@@ -135,49 +135,53 @@ static int __init efifb_set_system(const struct dmi_system_id *id)
 
 					start = pci_resource_start(dev, i);
 					end = pci_resource_end(dev, i);
-					if (screen_info.lfb_base >= start &&
-					    screen_info.lfb_base < end) {
+					if (si->lfb_base >= start && si->lfb_base < end) {
 						found_bar = 1;
 						break;
 					}
 				}
 			}
 			if (!found_bar)
-				screen_info.lfb_base = 0;
+				si->lfb_base = 0;
 #endif
 		}
 	}
-	if (screen_info.lfb_base) {
-		screen_info.lfb_linelength = choose_value(info->stride,
-			screen_info.lfb_linelength, OVERRIDE_STRIDE,
+	if (si->lfb_base) {
+		si->lfb_linelength = choose_value(info->stride,
+			si->lfb_linelength, OVERRIDE_STRIDE,
 			info->flags);
-		screen_info.lfb_width = choose_value(info->width,
-			screen_info.lfb_width, OVERRIDE_WIDTH,
+		si->lfb_width = choose_value(info->width,
+			si->lfb_width, OVERRIDE_WIDTH,
 			info->flags);
-		screen_info.lfb_height = choose_value(info->height,
-			screen_info.lfb_height, OVERRIDE_HEIGHT,
+		si->lfb_height = choose_value(info->height,
+			si->lfb_height, OVERRIDE_HEIGHT,
 			info->flags);
-		if (screen_info.orig_video_isVGA == 0)
-			screen_info.orig_video_isVGA = VIDEO_TYPE_EFI;
+		if (si->orig_video_isVGA == 0)
+			si->orig_video_isVGA = VIDEO_TYPE_EFI;
 	} else {
-		screen_info.lfb_linelength = 0;
-		screen_info.lfb_width = 0;
-		screen_info.lfb_height = 0;
-		screen_info.orig_video_isVGA = 0;
+		si->lfb_linelength = 0;
+		si->lfb_width = 0;
+		si->lfb_height = 0;
+		si->orig_video_isVGA = 0;
 		return 0;
 	}
 
 	printk(KERN_INFO "efifb: dmi detected %s - framebuffer at 0x%08x "
 			 "(%dx%d, stride %d)\n", id->ident,
-			 screen_info.lfb_base, screen_info.lfb_width,
-			 screen_info.lfb_height, screen_info.lfb_linelength);
+			 si->lfb_base, si->lfb_width,
+			 si->lfb_height, si->lfb_linelength);
 
 	return 1;
 }
 
+static int __init efifb_set_system_callback(const struct dmi_system_id *id)
+{
+	return efifb_set_system(&screen_info, id);
+}
+
 #define EFIFB_DMI_SYSTEM_ID(vendor, name, enumid)		\
 	{							\
-		efifb_set_system,				\
+		efifb_set_system_callback,			\
 		name,						\
 		{						\
 			DMI_MATCH(DMI_BIOS_VENDOR, vendor),	\
@@ -284,12 +288,13 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 	{},
 };
 
-static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
+static bool efifb_overlaps_pci_range(const struct screen_info *si,
+				     const struct of_pci_range *range)
 {
-	u64 fb_base = screen_info.lfb_base;
+	u64 fb_base = si->lfb_base;
 
-	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
+	if (si->capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		fb_base |= (u64)(unsigned long)si->ext_lfb_base << 32;
 
 	return fb_base >= range->cpu_addr &&
 	       fb_base < (range->cpu_addr + range->size);
@@ -311,7 +316,7 @@ static struct device_node *find_pci_overlap_node(void)
 		}
 
 		for_each_of_pci_range(&parser, &range)
-			if (efifb_overlaps_pci_range(&range))
+			if (efifb_overlaps_pci_range(&screen_info, &range))
 				return np;
 	}
 	return NULL;
@@ -349,25 +354,25 @@ static const struct fwnode_operations efifb_fwnode_ops = {
 
 static struct fwnode_handle efifb_fwnode;
 
-__init void sysfb_apply_efi_quirks(void)
+__init void sysfb_apply_efi_quirks(struct screen_info *si)
 {
-	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
-	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
+	if (si->orig_video_isVGA != VIDEO_TYPE_EFI ||
+	    !(si->capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
 		dmi_check_system(efifb_dmi_system_table);
 
-	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
+	if (si->orig_video_isVGA == VIDEO_TYPE_EFI &&
 	    dmi_check_system(efifb_dmi_swap_width_height)) {
-		u16 temp = screen_info.lfb_width;
+		u16 temp = si->lfb_width;
 
-		screen_info.lfb_width = screen_info.lfb_height;
-		screen_info.lfb_height = temp;
-		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
+		si->lfb_width = si->lfb_height;
+		si->lfb_height = temp;
+		si->lfb_linelength = 4 * si->lfb_width;
 	}
 }
 
-__init void sysfb_set_efifb_fwnode(struct platform_device *pd)
+__init void sysfb_set_efifb_fwnode(const struct screen_info *si, struct platform_device *pd)
 {
-	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI && IS_ENABLED(CONFIG_PCI)) {
+	if (si->orig_video_isVGA == VIDEO_TYPE_EFI && IS_ENABLED(CONFIG_PCI)) {
 		fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
 		pd->dev.fwnode = &efifb_fwnode;
 	}
diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 889e5b05c739..916b28538a29 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -155,7 +155,7 @@ static __init int sysfb_init(void)
 	if (disabled)
 		goto unlock_mutex;
 
-	sysfb_apply_efi_quirks();
+	sysfb_apply_efi_quirks(si);
 
 	parent = sysfb_parent_dev(si);
 	if (IS_ERR(parent)) {
@@ -200,7 +200,7 @@ static __init int sysfb_init(void)
 
 	pd->dev.parent = parent;
 
-	sysfb_set_efifb_fwnode(pd);
+	sysfb_set_efifb_fwnode(si, pd);
 
 	ret = platform_device_add_data(pd, si, sizeof(*si));
 	if (ret)
diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 592d8a644619..71f542e37732 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -117,7 +117,7 @@ __init struct platform_device *sysfb_create_simplefb(const struct screen_info *s
 
 	pd->dev.parent = parent;
 
-	sysfb_set_efifb_fwnode(pd);
+	sysfb_set_efifb_fwnode(si, pd);
 
 	ret = platform_device_add_resources(pd, &res, 1);
 	if (ret)
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index b449665c686a..8527a50a5290 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -82,16 +82,17 @@ static inline bool sysfb_handles_screen_info(void)
 #ifdef CONFIG_EFI
 
 extern struct efifb_dmi_info efifb_dmi_list[];
-void sysfb_apply_efi_quirks(void);
-void sysfb_set_efifb_fwnode(struct platform_device *pd);
+void sysfb_apply_efi_quirks(struct screen_info *si);
+void sysfb_set_efifb_fwnode(const struct screen_info *si, struct platform_device *pd);
 
 #else /* CONFIG_EFI */
 
-static inline void sysfb_apply_efi_quirks(void)
+static inline void sysfb_apply_efi_quirks(struct screen_info *si)
 {
 }
 
-static inline void sysfb_set_efifb_fwnode(struct platform_device *pd)
+static inline void sysfb_set_efifb_fwnode(const struct screen_info *si,
+					  struct platform_device *pd)
 {
 }
 
-- 
2.51.1


