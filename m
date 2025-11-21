Return-Path: <linux-efi+bounces-5635-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14297C79FBD
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F11F2382052
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A86B3557F0;
	Fri, 21 Nov 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HO5kGCHF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1pD1z/ul";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HO5kGCHF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1pD1z/ul"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3747921E098
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733418; cv=none; b=ECBdyFLdvaBoG+4KO1xJxxfaRowTYGFc06bdSKgUiYNmE6FxohidUFZ6KTYotXhOGzlJR0cpofFaTAjotYbcfmUmfGyEk9zC/TfB6E2gTNFd7jyjhwgxJQGD0Wk9pyPeMrc/fFaz2hJxM1m/9etTz5r1LYfIkbtg4yYcOaUBbpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733418; c=relaxed/simple;
	bh=t9mEtVfE1aghZc+niuZNGmgFFHjSj37cGdOKDB5qz6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEJFo0hRiEbfzONZVZqK1f9tlyM6fOpe7N440D7Sj0s5CAinjWCKDTZSA49SfojCIDQO8lMW6JE5mlPQ44onHZoIxjIN6lEWe6a02dD7/usK/O/ItLhkBv4BUXAJAh+bduHhuLtyxJYef9srV0DA/n6dMQ1C0SUMpzVOtqIopQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HO5kGCHF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1pD1z/ul; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HO5kGCHF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1pD1z/ul; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68BDB21018;
	Fri, 21 Nov 2025 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtghZh7eeBa0zgsffKJ3eiOL5OvyE27c0pocmVijFC4=;
	b=HO5kGCHF/D1Pc+UNPx6GzgfVmbxpF5grD3EOQWM0q0xHGH0wMn3yv3RMHjiUVNU5nico0H
	iaasSfMC/VKHi2q1hp0HDcfNhdjGaWhysg6aRDg8yirFpj3P1GVCRUE0Js3YSpD6Zm6let
	fFcLsgH15EI7B5yD5ZUd+fj6+Qavma4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtghZh7eeBa0zgsffKJ3eiOL5OvyE27c0pocmVijFC4=;
	b=1pD1z/ul2RdfgYUbYvh2lclQ3zoY14m4Wxf+MQKFaqNHcVe8UwV8qBBkn5e1AgvpdONtIE
	ryP6CP5k9FLQDUDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HO5kGCHF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="1pD1z/ul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtghZh7eeBa0zgsffKJ3eiOL5OvyE27c0pocmVijFC4=;
	b=HO5kGCHF/D1Pc+UNPx6GzgfVmbxpF5grD3EOQWM0q0xHGH0wMn3yv3RMHjiUVNU5nico0H
	iaasSfMC/VKHi2q1hp0HDcfNhdjGaWhysg6aRDg8yirFpj3P1GVCRUE0Js3YSpD6Zm6let
	fFcLsgH15EI7B5yD5ZUd+fj6+Qavma4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtghZh7eeBa0zgsffKJ3eiOL5OvyE27c0pocmVijFC4=;
	b=1pD1z/ul2RdfgYUbYvh2lclQ3zoY14m4Wxf+MQKFaqNHcVe8UwV8qBBkn5e1AgvpdONtIE
	ryP6CP5k9FLQDUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 115AD3EA61;
	Fri, 21 Nov 2025 13:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0JjBApFvIGkqdQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 21 Nov 2025 13:56:33 +0000
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
Subject: [PATCH 6/6] sysfb: Move edid_info into sysfb_primary_display
Date: Fri, 21 Nov 2025 14:36:10 +0100
Message-ID: <20251121135624.494768-7-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 68BDB21018
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

Move x86's edid_info into sysfb_primary_display as a new field named
edid. Adapt all users.

An instance of edid_info has only been defined on x86. With the move
into sysfb_primary_display, it becomes available on all architectures.
Therefore remove this contraint from CONFIG_FIRMWARE_EDID.

x86 fills the EDID data from boot_params.edid_info. DRM drivers pick
up the raw data and make it available to DRM clients. Replace the
drivers' references to edid_info and instead use the sysfb_display_info
as passed from sysfb.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/x86/kernel/setup.c          | 6 +-----
 drivers/gpu/drm/sysfb/efidrm.c   | 5 ++---
 drivers/gpu/drm/sysfb/vesadrm.c  | 5 ++---
 drivers/video/Kconfig            | 1 -
 drivers/video/fbdev/core/fbmon.c | 8 +++++---
 include/linux/sysfb.h            | 6 ++++++
 include/video/edid.h             | 4 ----
 7 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 675e4b9deb1f..d9bfe2032cd9 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -215,10 +215,6 @@ arch_initcall(init_x86_sysctl);
 
 struct sysfb_display_info sysfb_primary_display;
 EXPORT_SYMBOL(sysfb_primary_display);
-#if defined(CONFIG_FIRMWARE_EDID)
-struct edid_info edid_info;
-EXPORT_SYMBOL_GPL(edid_info);
-#endif
 
 extern int root_mountflags;
 
@@ -530,7 +526,7 @@ static void __init parse_boot_params(void)
 	ROOT_DEV = old_decode_dev(boot_params.hdr.root_dev);
 	sysfb_primary_display.screen = boot_params.screen_info;
 #if defined(CONFIG_FIRMWARE_EDID)
-	edid_info = boot_params.edid_info;
+	sysfb_primary_display.edid = boot_params.edid_info;
 #endif
 #ifdef CONFIG_X86_32
 	apm_info.bios = boot_params.apm_bios_info;
diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
index 29533ae8fbbf..50e0aeef709c 100644
--- a/drivers/gpu/drm/sysfb/efidrm.c
+++ b/drivers/gpu/drm/sysfb/efidrm.c
@@ -24,7 +24,6 @@
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
-#include <video/edid.h>
 #include <video/pixel_format.h>
 
 #include "drm_sysfb_helper.h"
@@ -207,8 +206,8 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 		&format->format, width, height, stride);
 
 #if defined(CONFIG_FIRMWARE_EDID)
-	if (drm_edid_header_is_valid(edid_info.dummy) == 8)
-		sysfb->edid = edid_info.dummy;
+	if (drm_edid_header_is_valid(dpy->edid.dummy) == 8)
+		sysfb->edid = dpy->edid.dummy;
 #endif
 	sysfb->fb_mode = drm_sysfb_mode(width, height, 0, 0);
 	sysfb->fb_format = format;
diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index 16fc223f8c5b..0680638b8131 100644
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -25,7 +25,6 @@
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
-#include <video/edid.h>
 #include <video/pixel_format.h>
 #include <video/vga.h>
 
@@ -474,8 +473,8 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 	}
 
 #if defined(CONFIG_FIRMWARE_EDID)
-	if (drm_edid_header_is_valid(edid_info.dummy) == 8)
-		sysfb->edid = edid_info.dummy;
+	if (drm_edid_header_is_valid(dpy->edid.dummy) == 8)
+		sysfb->edid = dpy->edid.dummy;
 #endif
 	sysfb->fb_mode = drm_sysfb_mode(width, height, 0, 0);
 	sysfb->fb_format = format;
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index d51777df12d1..ad55e7d62159 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -63,7 +63,6 @@ endif # HAS_IOMEM
 
 config FIRMWARE_EDID
 	bool "Enable firmware EDID"
-	depends on X86
 	help
 	  This enables access to the EDID transferred from the firmware.
 	  On x86, this is from the VESA BIOS. DRM display drivers will
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 0a65bef01e3c..07df7e98f8a3 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -32,11 +32,13 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
-#include <video/edid.h>
+#include <linux/string_choices.h>
+#include <linux/sysfb.h>
+
 #include <video/of_videomode.h>
 #include <video/videomode.h>
+
 #include "../edid.h"
-#include <linux/string_choices.h>
 
 /*
  * EDID parser
@@ -1504,7 +1506,7 @@ const unsigned char *fb_firmware_edid(struct device *device)
 		res = &dev->resource[PCI_ROM_RESOURCE];
 
 	if (res && res->flags & IORESOURCE_ROM_SHADOW)
-		edid = edid_info.dummy;
+		edid = sysfb_primary_display.edid.dummy;
 
 	return edid;
 }
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index e8bde392c690..5226efde9ad4 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -12,6 +12,8 @@
 #include <linux/screen_info.h>
 #include <linux/types.h>
 
+#include <video/edid.h>
+
 struct device;
 struct platform_device;
 struct screen_info;
@@ -62,6 +64,10 @@ struct efifb_dmi_info {
 
 struct sysfb_display_info {
 	struct screen_info screen;
+
+#if defined(CONFIG_FIRMWARE_EDID)
+	struct edid_info edid;
+#endif
 };
 
 extern struct sysfb_display_info sysfb_primary_display;
diff --git a/include/video/edid.h b/include/video/edid.h
index c2b186b1933a..52aabb706032 100644
--- a/include/video/edid.h
+++ b/include/video/edid.h
@@ -4,8 +4,4 @@
 
 #include <uapi/video/edid.h>
 
-#if defined(CONFIG_FIRMWARE_EDID)
-extern struct edid_info edid_info;
-#endif
-
 #endif /* __linux_video_edid_h__ */
-- 
2.51.1


