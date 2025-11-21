Return-Path: <linux-efi+bounces-5633-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3662C79F84
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 15:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 591A734B6BA
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4E53546FA;
	Fri, 21 Nov 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xF0kHtiX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tyYedpPu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xF0kHtiX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tyYedpPu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76483538BB
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733409; cv=none; b=sFykVcvB2zh3n2oSiXIg5DYRvtFUFJXUBtdcGZDRJEGoLGei9mO45FiH25vRT+DqyoIN8MStBAwCeEpakcRyU4E3gJKxQTJq8cMB7uLbWmZqy4gApe3erIVnFkz+zWb61jpovRpEof2IiEvlmS/sBGGMsk5UCsoEehzvHphj8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733409; c=relaxed/simple;
	bh=xoNIWNSUV/uDL4BBy48KwbBEoKm/wZM4qdvmi0LlHLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhVvpk02ifQQd6Omj+1fMK3jsogKA3E+XBzV5vrwvmSg3yqAaiOPwWZJcAOx4esnKWLfRUY4zr7IBGlKq75Pli1se0mTR/55x2VGhgemtvPmSpRaO+0jt/eKPeSTT45FZfeIr7C16xo9T1+deFWp4Vi5kvfXpOy4nLInuoQehHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xF0kHtiX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tyYedpPu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xF0kHtiX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tyYedpPu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09C31218F4;
	Fri, 21 Nov 2025 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IyiIhaEl6CE8qIj09KectGI7dNfK8v13xrzuko4YKY=;
	b=xF0kHtiXXUWoN3S5ekmTQP/UJV8Ahv4IoX9tnPUJUqVbCgTNiQXJU2C0eww4V2tWqgTN+f
	bSwHpJIF5DohvIL4WU1g7FIo8ga4OrAx+cuXjCq4xUJISpwzm8BfZDg7AxdHZ1NLedVrJg
	WYoiqTJfeiWf61nHGAFBeHeYZOzOW6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IyiIhaEl6CE8qIj09KectGI7dNfK8v13xrzuko4YKY=;
	b=tyYedpPucuXO1lZdE8/02tWRAq0Bho4DVmILep2/MImDmBvh/X4HJmm7tnKlNEszl6mIEE
	cNfjF5lXojC3g1BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IyiIhaEl6CE8qIj09KectGI7dNfK8v13xrzuko4YKY=;
	b=xF0kHtiXXUWoN3S5ekmTQP/UJV8Ahv4IoX9tnPUJUqVbCgTNiQXJU2C0eww4V2tWqgTN+f
	bSwHpJIF5DohvIL4WU1g7FIo8ga4OrAx+cuXjCq4xUJISpwzm8BfZDg7AxdHZ1NLedVrJg
	WYoiqTJfeiWf61nHGAFBeHeYZOzOW6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IyiIhaEl6CE8qIj09KectGI7dNfK8v13xrzuko4YKY=;
	b=tyYedpPucuXO1lZdE8/02tWRAq0Bho4DVmILep2/MImDmBvh/X4HJmm7tnKlNEszl6mIEE
	cNfjF5lXojC3g1BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6A703EA62;
	Fri, 21 Nov 2025 13:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2Dx9J5BvIGkqdQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 21 Nov 2025 13:56:32 +0000
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
Subject: [PATCH 5/6] sysfb: Pass sysfb_primary_display to devices
Date: Fri, 21 Nov 2025 14:36:09 +0100
Message-ID: <20251121135624.494768-6-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLykjg6e7ifkwtw7jmpw7b9yio)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Instead of screen_info, store a copy of sysfb_primary_display as
device data. Pick it up in drivers. Later changes will add additional
data to the display info, such as EDID information.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
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
index a81df8865143..10d3d9ae73aa 100644
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
index eedab14c7d51..7853d84f10df 100644
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


