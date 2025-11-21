Return-Path: <linux-efi+bounces-5632-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F37C79E16
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 15:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2CF722DD74
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3A93538BD;
	Fri, 21 Nov 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PXxsvoLn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xiNwnwC0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VuZsKvkN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/i6cUpgR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B96353896
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733406; cv=none; b=mDtNPpHBWdwKBou7NBEJSLDDoAT2HG+vcauU2Hx+WgQVQG8AU3zLsj750F0nfvpzT0zffSy7GytOapzaQB1xJnsz0L48vxqR4fEy8tfGtxSEGnAOvh5q23/zJU1C+LHIelC7ib6nT2CrqNNvNkjALqbBzemee8fwfN1GUjI1XsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733406; c=relaxed/simple;
	bh=ZJ6BvPR0fHILQF9XVXs/a3Xs1Pc+VJJS0/v87kZl9kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mze5Vg6ObOInYvbsLlFI0X2uZuibBmbJrGAt8EC1wB7p1U1IyqBROHIFXfegWhqaQX4DeISFddkap95zP6BxONhGZd3cx0StvU2Rhpk77cSk0Ua3M0DeyPZUeb5eQCfI0Z9n8ImsH5KfAk1QZtJGlUKbVEyiC/qY/2xVQpOGMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PXxsvoLn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xiNwnwC0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VuZsKvkN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/i6cUpgR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D834E21012;
	Fri, 21 Nov 2025 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZXUsIR6RvsH5PBhIGZuxkOFQliZwoE1yD/zx5nRUL0=;
	b=PXxsvoLnWhEA6EomcGLILPXPLL8d0dAHWjanncspOziO6IRsUUOjAcNhGcK7fIDxe8P1YA
	Bcv9LDpayW1wCNcG7LOmreN9hFpYwV9ALKHwCVxSlizFHE1CaGguTx+toIlY1Kgm/rJAtl
	1N0paaW8rOqR5hnUS4SWjbh0jgloX2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZXUsIR6RvsH5PBhIGZuxkOFQliZwoE1yD/zx5nRUL0=;
	b=xiNwnwC0yBpKwSbP5pGj1waiDdf/k42cJUoeltMLqv7qicZlCMn0HUMW8YSpzbl5hn5Zgj
	RHJokR3mbzK1oVCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VuZsKvkN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/i6cUpgR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZXUsIR6RvsH5PBhIGZuxkOFQliZwoE1yD/zx5nRUL0=;
	b=VuZsKvkNbddM4Vn5NWOP30oNDj9ElxbarYM3MMCBEWB1QYnJ0irH2vE5jnpUD2DBurHP3N
	7DFeOcVlE4SwaO1Vs+jaXkjGSMr/bL5n2DCe9WbtchZFhmqRmdh1X054MAY70oaV8sV8mg
	E/VL4KP4ninhXPUu/zbl00UP2oJIKjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZXUsIR6RvsH5PBhIGZuxkOFQliZwoE1yD/zx5nRUL0=;
	b=/i6cUpgRAngqEaVYm+v8TnpHvEV726Fzs7yY6sE3ivx4oT9sqvRgNm0sY5Vm9i6pWCZlTC
	cxfYYQGk+lIIT/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80CB53EA61;
	Fri, 21 Nov 2025 13:56:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +PL7HY9vIGkqdQAAD6G6ig
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
Subject: [PATCH 2/6] efi: sysfb_efi: Reduce number of references to global screen_info
Date: Fri, 21 Nov 2025 14:36:06 +0100
Message-ID: <20251121135624.494768-3-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: D834E21012
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtfyjk8sg4x43ngtem9djprcp)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Replace usage of global screen_info with local pointers. This will
later reduce churn when screen_info is being moved.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
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


