Return-Path: <linux-efi+bounces-5696-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF698C8ADD8
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 17:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4514F3B9724
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 16:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FF933D6F9;
	Wed, 26 Nov 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ST+nf0Fj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nB5dki8z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ST+nf0Fj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nB5dki8z"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43133E34E
	for <linux-efi@vger.kernel.org>; Wed, 26 Nov 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173354; cv=none; b=T3mOOC7I2QpOJ1SEdNJZTAWjDG2FNie8JedS5vNnZodtu4Yp99V58jdYoYXCRPgft7ZJw0HyNq3BTIlDelhaAiZHpLGEDVqiMroUnN/rw9WwEMfELCtTeAWR8dg8533Bf9i+9rhjbvYyAo4WlF9rFOJzX8D2OP8ukyPMaPPudLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173354; c=relaxed/simple;
	bh=sp86CpH/A0QqK5BFCqTkOcjyl+gJ5bCI/mUhLxv96bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niF/6yeZqk5NlbDyszAkFHXfK3rJKoR6JZq9YzAKfPf4X5M8MOWvCds7DxH3uzlRMqLqxliSTiirmWPKyJfUZDy70SvUZX53xn8OVh5jYHKYyW23d+huqm5qwNp5QFbiv/87d8/2CSb8//YQWA8jFNlVbHUvl+4hFV2MrvbZA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ST+nf0Fj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nB5dki8z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ST+nf0Fj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nB5dki8z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC999336E3;
	Wed, 26 Nov 2025 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764173341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPW+X7Z9Og3TIXMVS76E66zrmesV1TERYcVqY5JCDD0=;
	b=ST+nf0Fjbe1nmDFUuLkgXacfg5j/bRS3FGTUxyCeevadj9W1KtwXniDydPPbiUR4nmPNQq
	qMj0vp+kuoOF6cGnHXFv0GSASe3RmI3Dk702Q9OxiiIj/fFWr2n/pKkDEhNzAuooVfEhlh
	2oT6XQEtw5eecZGGXGXDu++dhO3CcyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764173341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPW+X7Z9Og3TIXMVS76E66zrmesV1TERYcVqY5JCDD0=;
	b=nB5dki8ztlQuQcxoenoz5eNe6yeBZco5bvp7hoiu25cfA5j0bBlyf6M51Io7RYNaUrcexN
	tfddPu8CO+18twBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ST+nf0Fj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nB5dki8z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764173341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPW+X7Z9Og3TIXMVS76E66zrmesV1TERYcVqY5JCDD0=;
	b=ST+nf0Fjbe1nmDFUuLkgXacfg5j/bRS3FGTUxyCeevadj9W1KtwXniDydPPbiUR4nmPNQq
	qMj0vp+kuoOF6cGnHXFv0GSASe3RmI3Dk702Q9OxiiIj/fFWr2n/pKkDEhNzAuooVfEhlh
	2oT6XQEtw5eecZGGXGXDu++dhO3CcyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764173341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPW+X7Z9Og3TIXMVS76E66zrmesV1TERYcVqY5JCDD0=;
	b=nB5dki8ztlQuQcxoenoz5eNe6yeBZco5bvp7hoiu25cfA5j0bBlyf6M51Io7RYNaUrcexN
	tfddPu8CO+18twBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 685413EA65;
	Wed, 26 Nov 2025 16:09:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MEdIGB0mJ2lnIgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Nov 2025 16:09:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	javierm@redhat.com,
	arnd@arndb.de,
	richard.lyu@suse.com,
	helgaas@kernel.org
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
Subject: [PATCH v3 5/9] sysfb: Pass sysfb_primary_display to devices
Date: Wed, 26 Nov 2025 17:03:22 +0100
Message-ID: <20251126160854.553077-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251126160854.553077-1-tzimmermann@suse.de>
References: <20251126160854.553077-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtfyjk8sg4x43ngtem9djprcp)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CC999336E3
X-Rspamd-Action: no action
X-Spam-Flag: NO

Instead of screen_info, store a copy of sysfb_primary_display as
device data. Pick it up in drivers. Later changes will add additional
data to the display info, such as EDID information.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/sysfb.c        |  5 +++--
 drivers/gpu/drm/sysfb/efidrm.c  |  9 ++++++---
 drivers/gpu/drm/sysfb/vesadrm.c |  9 ++++++---
 drivers/video/fbdev/efifb.c     | 10 ++++++----
 drivers/video/fbdev/vesafb.c    | 10 ++++++----
 drivers/video/fbdev/vga16fb.c   |  8 +++++---
 6 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 1f671f9219b0..8833582c1883 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -141,7 +141,8 @@ static struct device *sysfb_parent_dev(const struct screen_info *si)
 
 static __init int sysfb_init(void)
 {
-	struct screen_info *si = &sysfb_primary_display.screen;
+	struct sysfb_display_info *dpy = &sysfb_primary_display;
+	struct screen_info *si = &dpy->screen;
 	struct device *parent;
 	unsigned int type;
 	struct simplefb_platform_data mode;
@@ -202,7 +203,7 @@ static __init int sysfb_init(void)
 
 	sysfb_set_efifb_fwnode(si, pd);
 
-	ret = platform_device_add_data(pd, si, sizeof(*si));
+	ret = platform_device_add_data(pd, dpy, sizeof(*dpy));
 	if (ret)
 		goto err;
 
diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
index 1b683d55d6ea..29533ae8fbbf 100644
--- a/drivers/gpu/drm/sysfb/efidrm.c
+++ b/drivers/gpu/drm/sysfb/efidrm.c
@@ -4,7 +4,7 @@
 #include <linux/efi.h>
 #include <linux/limits.h>
 #include <linux/platform_device.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic.h>
@@ -141,6 +141,7 @@ static const struct drm_mode_config_funcs efidrm_mode_config_funcs = {
 static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 						  struct platform_device *pdev)
 {
+	const struct sysfb_display_info *dpy;
 	const struct screen_info *si;
 	const struct drm_format_info *format;
 	int width, height, stride;
@@ -160,9 +161,11 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 	size_t nformats;
 	int ret;
 
-	si = dev_get_platdata(&pdev->dev);
-	if (!si)
+	dpy = dev_get_platdata(&pdev->dev);
+	if (!dpy)
 		return ERR_PTR(-ENODEV);
+	si = &dpy->screen;
+
 	if (screen_info_video_type(si) != VIDEO_TYPE_EFI)
 		return ERR_PTR(-ENODEV);
 
diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index 7b7b5ba26317..16fc223f8c5b 100644
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -4,7 +4,7 @@
 #include <linux/ioport.h>
 #include <linux/limits.h>
 #include <linux/platform_device.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic.h>
@@ -391,6 +391,7 @@ static const struct drm_mode_config_funcs vesadrm_mode_config_funcs = {
 static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 						    struct platform_device *pdev)
 {
+	const struct sysfb_display_info *dpy;
 	const struct screen_info *si;
 	const struct drm_format_info *format;
 	int width, height, stride;
@@ -410,9 +411,11 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 	size_t nformats;
 	int ret;
 
-	si = dev_get_platdata(&pdev->dev);
-	if (!si)
+	dpy = dev_get_platdata(&pdev->dev);
+	if (!dpy)
 		return ERR_PTR(-ENODEV);
+	si = &dpy->screen;
+
 	if (screen_info_video_type(si) != VIDEO_TYPE_VLFB)
 		return ERR_PTR(-ENODEV);
 
diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 0e1bd3dba255..47ebc0107209 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -15,7 +15,7 @@
 #include <linux/fb.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 #include <video/vga.h>
 #include <asm/efi.h>
 #include <drm/drm_utils.h> /* For drm_get_panel_orientation_quirk */
@@ -345,6 +345,7 @@ ATTRIBUTE_GROUPS(efifb);
 
 static int efifb_probe(struct platform_device *dev)
 {
+	struct sysfb_display_info *dpy;
 	struct screen_info *si;
 	struct fb_info *info;
 	struct efifb_par *par;
@@ -360,10 +361,11 @@ static int efifb_probe(struct platform_device *dev)
 	 * driver. We get a copy of the attached screen_info, so that we can
 	 * modify its values without affecting later drivers.
 	 */
-	si = dev_get_platdata(&dev->dev);
-	if (!si)
+	dpy = dev_get_platdata(&dev->dev);
+	if (!dpy)
 		return -ENODEV;
-	si = devm_kmemdup(&dev->dev, si, sizeof(*si), GFP_KERNEL);
+
+	si = devm_kmemdup(&dev->dev, &dpy->screen, sizeof(*si), GFP_KERNEL);
 	if (!si)
 		return -ENOMEM;
 
diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index f135033c22fb..f84f4db244bf 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -20,7 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 #include <linux/io.h>
 
 #include <video/vga.h>
@@ -243,6 +243,7 @@ static int vesafb_setup(char *options)
 
 static int vesafb_probe(struct platform_device *dev)
 {
+	struct sysfb_display_info *dpy;
 	struct screen_info *si;
 	struct fb_info *info;
 	struct vesafb_par *par;
@@ -257,10 +258,11 @@ static int vesafb_probe(struct platform_device *dev)
 	 * driver. We get a copy of the attached screen_info, so that we can
 	 * modify its values without affecting later drivers.
 	 */
-	si = dev_get_platdata(&dev->dev);
-	if (!si)
+	dpy = dev_get_platdata(&dev->dev);
+	if (!dpy)
 		return -ENODEV;
-	si = devm_kmemdup(&dev->dev, si, sizeof(*si), GFP_KERNEL);
+
+	si = devm_kmemdup(&dev->dev, &dpy->screen, sizeof(*si), GFP_KERNEL);
 	if (!si)
 		return -ENOMEM;
 
diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index 6b81337a4909..22085d3668e8 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -21,7 +21,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 
 #include <asm/io.h>
 #include <video/vga.h>
@@ -1305,15 +1305,17 @@ static const struct fb_ops vga16fb_ops = {
 
 static int vga16fb_probe(struct platform_device *dev)
 {
+	struct sysfb_display_info *dpy;
 	struct screen_info *si;
 	struct fb_info *info;
 	struct vga16fb_par *par;
 	int i;
 	int ret = 0;
 
-	si = dev_get_platdata(&dev->dev);
-	if (!si)
+	dpy = dev_get_platdata(&dev->dev);
+	if (!dpy)
 		return -ENODEV;
+	si = &dpy->screen;
 
 	ret = check_mode_supported(si);
 	if (ret)
-- 
2.51.1


