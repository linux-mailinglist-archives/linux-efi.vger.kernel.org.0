Return-Path: <linux-efi+bounces-5929-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F0FCE83E0
	for <lists+linux-efi@lfdr.de>; Mon, 29 Dec 2025 22:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 339C43013946
	for <lists+linux-efi@lfdr.de>; Mon, 29 Dec 2025 21:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0EC30FF31;
	Mon, 29 Dec 2025 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bc1Uuj/d"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB930F7E3
	for <linux-efi@vger.kernel.org>; Mon, 29 Dec 2025 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767045561; cv=none; b=f2hEiPw7KgmcXphsaDO0ZCHVcquNpdfDTGhpGaItfratKHA4A/blv27pxCrFX4MsljqVOhXK3eRkuWsQVMtm0M9xvSbXcAibfk8HTbolHwgiW4Mlvo8J5JEs/xMXqYAoQHpLOlDHs91dntOUsGjPDWguz2IhXDReqxttLuS0+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767045561; c=relaxed/simple;
	bh=BcBsQxJIQJJlqTuvgYwuQeVrGVdbVN2Bv4pHjjNssq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEMPpwCrxEZEwZPeID6SgMSBK9vWlK53u+tkWOLjmo/azo15Hq3K6IJgvXiVSKTPPlnjDjc1ce3RdhHaCj0dT+8xrLSB1u7ld/L5YntIx9coA6+DcysZjfkTOsMmn6HAmBeFOty+t3mqcd8aAK3w6AHTYlxhpwd9s39YZGOywlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bc1Uuj/d; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8888a1c50e8so127224456d6.0
        for <linux-efi@vger.kernel.org>; Mon, 29 Dec 2025 13:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767045558; x=1767650358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJWRKQHrZ65aEzUoFIqsgm/0iuuS/awy21jyOivXLQY=;
        b=DMSKeXWgpBQWLRjEqIO/PSHZnoC8WdxzE8UIM9S4SLU+SHww5QNRjuaJTESfvLd2JQ
         eydsef6nR0XuxjO+vTZbCPcWt+QULM4oa6OiN6wnLXGVUowSm8g6M0TY0RV5Z6cOSFjK
         8NbcurIK6FUjGjO0/OOcxsznLn74qrQqwJnJEo6z+2AAizEI8F4QLRlwruYOF9S7n3Bk
         Iz0aR1kbltVfz9yTMip1XVffvni2uvBT6X9pZKoi8OwAm2yZBeE6GX2RRm3Wosgl571C
         qVUwhej765EH4Yfv6jorXm4Tt1FBgOcnerNXQJ8+C6iWpNk1PFK2RlIrGKT7qiGaqx3y
         KmuA==
X-Forwarded-Encrypted: i=1; AJvYcCWiqRZk0ZBQ0+CdxY8jTiQpaX46in04at6a3A3V/8D93NFFhlCg1WTtsSIc53F3iN3lGdLUCicPXe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQx+quw9TuFN+DnHaw4izE3V/J6D0ajj1vNhWjQZsATRLAvK6d
	uf3VcYBDAO7suH5VMaFqIFcJilQW99hhxjHfgoYOUfeWxlFN2lGtT3Li14lAxwJUmNUHdGiv1+l
	lb9c/JFQ2ijm67L5Y4pM7ULtj/V3BKZ9gygIqnW67yfSzto8ayUwL2adxFC40LC6RKwOJTMpQH6
	0TBr8qefl0I3zNRr0NhOuBfgpk7E8IVBcmSrxN9CHgxuLZVz4ip2Amd5yHxTIBkY1JmFD44aark
	4mg9SflRySu
X-Gm-Gg: AY/fxX5Kilfe3eEjpWZKjqD2b5zgLxuAuy5zIRPY8OkeXmTcFbxqW0vS65V67TKoEM4
	nhwiVwJC65tobV8fDdgRSj50BakfB9vHFogAHgU/bOyYKYqRcckMlym4oRXtRDIE94Q6j9N4cpd
	dPeDXIYneDTelHMwSO6YvUV3kNzl+Ks1SEVIiy9RxeCvmkXxPHcaCL5q4cbq/flR86mxb88qnJH
	w4igVQ/dXqVH4Yrhyl/xTKw69ef9JhHRIBH/gC/cbg2jXhuap3i3AQ1Tf0z0ZiYYTqRXbiTsVR8
	0T1RUj6GiqTB/Su/aK49YlWN2096QFts176s3rjXbqpDb4RqqBrwQKjsp67g7K9JtpsL2nCjbER
	dPaI2CzQeLxVbSDgJ43XCIubZnoU86hYRUwnsrEgIuNPin9trX7VdfOdae6e53LuKvb+zwQ+FpM
	gTVf8ok3L/79+HAAHVKeZODLLCx0QZh5J3nCoCU8Xpy1vm
X-Google-Smtp-Source: AGHT+IHwPYzPktmwpP4EVI5x/7hhR7IwtnJCss33fnwMbzB3wtUcSwhCdmWD+CHCRMHVXFPPWSBcc9OWXxqv
X-Received: by 2002:ad4:5a48:0:b0:88a:41d9:23d7 with SMTP id 6a1803df08f44-88d84536c34mr325161116d6.39.1767045558539;
        Mon, 29 Dec 2025 13:59:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d950c2d3asm42274486d6.7.2025.12.29.13.59.15
        for <linux-efi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Dec 2025 13:59:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a3a4af701so256268636d6.1
        for <linux-efi@vger.kernel.org>; Mon, 29 Dec 2025 13:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767045554; x=1767650354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJWRKQHrZ65aEzUoFIqsgm/0iuuS/awy21jyOivXLQY=;
        b=Bc1Uuj/dibZ/HmiHHL0ZIZvqwRX7tTy1XPZmhMWQyhK41iDOJEJZOs7P6oggFO/QiT
         dmuD3GiBh5uQEW46ior9RFuWdJUG6j4TDSN/izULpcsdcqaxegjwXMoSv7ZN0M3xp1oV
         mJxPl0hYyBsSm7wjiYvNjjaxMAbn+ai5xaYuE=
X-Forwarded-Encrypted: i=1; AJvYcCW+CToU2yg5eYgcFbpcxjhoplduJzB2gRbtqV+235Fs5cBlt+N0shX7RmV6d0XjMiCD9FMhFlt7wDc=@vger.kernel.org
X-Received: by 2002:a05:6214:419b:b0:88f:fbcf:e7cb with SMTP id 6a1803df08f44-88ffbcfeeabmr183064776d6.51.1767045554115;
        Mon, 29 Dec 2025 13:59:14 -0800 (PST)
X-Received: by 2002:a05:6214:419b:b0:88f:fbcf:e7cb with SMTP id 6a1803df08f44-88ffbcfeeabmr183064626d6.51.1767045553722;
        Mon, 29 Dec 2025 13:59:13 -0800 (PST)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9759f164sm231530026d6.24.2025.12.29.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 13:59:11 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Helge Deller <deller@gmx.de>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 01/12] video/aperture: Add sysfb restore on DRM probe failure
Date: Mon, 29 Dec 2025 16:58:07 -0500
Message-ID: <20251229215906.3688205-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251229215906.3688205-1-zack.rusin@broadcom.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When a DRM driver calls aperture_remove_conflicting_pci_devices(), the
firmware framebuffer (EFI, VESA, etc.) is disabled and its platform
device is unregistered. If the DRM driver's probe subsequently fails,
the user is left with no display output.

Add sysfb_restore() to re-enable the Generic System Framebuffers
support and re-create the platform device that was previously
unregistered by sysfb_disable().

Add devm_aperture_remove_conflicting_pci_devices() which wraps the
existing function and registers a devm action to automatically call
sysfb_restore() if the driver's probe fails or the driver is unloaded.
Drivers can call devm_aperture_remove_conflicting_pci_devices_done()
after successful probe to cancel the automatic restore.

Refactor sysfb_init() to use a shared __sysfb_create_device() helper
that can be called from both sysfb_init() and sysfb_restore(). Add a
quirks_applied flag to handle the edge case where a driver calls
sysfb_disable() before sysfb_init() runs, in this case sysfb_restore()
defers device creation to sysfb_init() since the __init quirk functions
cannot be called after init memory is freed.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/firmware/efi/sysfb_efi.c  |   2 +-
 drivers/firmware/sysfb.c          | 191 +++++++++++++++++++-----------
 drivers/firmware/sysfb_simplefb.c |  10 +-
 drivers/video/aperture.c          |  54 +++++++++
 include/linux/aperture.h          |  14 +++
 include/linux/sysfb.h             |   6 +
 6 files changed, 201 insertions(+), 76 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 1e509595ac03..3fe7c57ad849 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -365,7 +365,7 @@ __init void sysfb_apply_efi_quirks(void)
 	}
 }
 
-__init void sysfb_set_efifb_fwnode(struct platform_device *pd)
+void sysfb_set_efifb_fwnode(struct platform_device *pd)
 {
 	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI && IS_ENABLED(CONFIG_PCI)) {
 		fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 889e5b05c739..c45b6f487103 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -38,6 +38,7 @@
 static struct platform_device *pd;
 static DEFINE_MUTEX(disable_lock);
 static bool disabled;
+static bool quirks_applied;
 
 static struct device *sysfb_parent_dev(const struct screen_info *si);
 
@@ -79,6 +80,121 @@ void sysfb_disable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(sysfb_disable);
 
+/* Caller must hold disable_lock */
+static int __sysfb_create_device(bool restore)
+{
+	struct screen_info *si = &screen_info;
+	struct device *parent;
+	unsigned int type;
+	struct simplefb_platform_data mode;
+	const char *name;
+	bool compatible;
+	int ret = 0;
+
+	if (!IS_ERR_OR_NULL(pd))
+		return 0;
+
+	/*
+	 * If quirks haven't been applied yet, sysfb_init() hasn't run.
+	 * Don't create the device now - let sysfb_init() do it after
+	 * applying the necessary fixups and quirks. We can't call
+	 * sysfb_apply_efi_quirks() here because it's __init.
+	 */
+	if (!quirks_applied)
+		return 0;
+
+	parent = sysfb_parent_dev(si);
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
+
+	type = screen_info_video_type(si);
+
+	/* try to create a simple-framebuffer device */
+	compatible = sysfb_parse_mode(si, &mode);
+	if (compatible) {
+		pd = sysfb_create_simplefb(si, &mode, parent);
+		if (!IS_ERR(pd)) {
+			if (restore)
+				pr_info("sysfb: restored simple-framebuffer device\n");
+			goto put_device;
+		}
+	}
+
+	/* if the FB is incompatible, create a legacy framebuffer device */
+	switch (type) {
+	case VIDEO_TYPE_EGAC:
+		name = "ega-framebuffer";
+		break;
+	case VIDEO_TYPE_VGAC:
+		name = "vga-framebuffer";
+		break;
+	case VIDEO_TYPE_VLFB:
+		name = "vesa-framebuffer";
+		break;
+	case VIDEO_TYPE_EFI:
+		name = "efi-framebuffer";
+		break;
+	default:
+		name = "platform-framebuffer";
+		break;
+	}
+
+	pd = platform_device_alloc(name, 0);
+	if (!pd) {
+		ret = -ENOMEM;
+		goto put_device;
+	}
+
+	pd->dev.parent = parent;
+
+	sysfb_set_efifb_fwnode(pd);
+
+	ret = platform_device_add_data(pd, si, sizeof(*si));
+	if (ret)
+		goto err;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		goto err;
+
+	if (restore)
+		pr_info("sysfb: restored %s device\n", name);
+	goto put_device;
+err:
+	platform_device_put(pd);
+	pd = NULL;
+put_device:
+	put_device(parent);
+	return ret;
+}
+
+/**
+ * sysfb_restore() - restore the Generic System Framebuffer
+ *
+ * This function re-enables the Generic System Framebuffers support and
+ * re-creates the platform device that was previously unregistered by
+ * sysfb_disable(). This is intended for use by DRM drivers that need to
+ * restore the fallback framebuffer when their probe fails after having
+ * called aperture_remove_conflicting_devices() or similar.
+ *
+ * Context: The function can sleep. A @disable_lock mutex is acquired.
+ *
+ * Returns:
+ * 0 on success, or a negative errno value otherwise.
+ */
+int sysfb_restore(void)
+{
+	int ret;
+
+	mutex_lock(&disable_lock);
+	disabled = false;
+	ret = __sysfb_create_device(true);
+	mutex_unlock(&disable_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sysfb_restore);
+
 /**
  * sysfb_handles_screen_info() - reports if sysfb handles the global screen_info
  *
@@ -141,82 +257,17 @@ static struct device *sysfb_parent_dev(const struct screen_info *si)
 
 static __init int sysfb_init(void)
 {
-	struct screen_info *si = &screen_info;
-	struct device *parent;
-	unsigned int type;
-	struct simplefb_platform_data mode;
-	const char *name;
-	bool compatible;
 	int ret = 0;
 
 	screen_info_apply_fixups();
-
-	mutex_lock(&disable_lock);
-	if (disabled)
-		goto unlock_mutex;
-
 	sysfb_apply_efi_quirks();
 
-	parent = sysfb_parent_dev(si);
-	if (IS_ERR(parent)) {
-		ret = PTR_ERR(parent);
-		goto unlock_mutex;
-	}
-
-	/* try to create a simple-framebuffer device */
-	compatible = sysfb_parse_mode(si, &mode);
-	if (compatible) {
-		pd = sysfb_create_simplefb(si, &mode, parent);
-		if (!IS_ERR(pd))
-			goto put_device;
-	}
-
-	type = screen_info_video_type(si);
-
-	/* if the FB is incompatible, create a legacy framebuffer device */
-	switch (type) {
-	case VIDEO_TYPE_EGAC:
-		name = "ega-framebuffer";
-		break;
-	case VIDEO_TYPE_VGAC:
-		name = "vga-framebuffer";
-		break;
-	case VIDEO_TYPE_VLFB:
-		name = "vesa-framebuffer";
-		break;
-	case VIDEO_TYPE_EFI:
-		name = "efi-framebuffer";
-		break;
-	default:
-		name = "platform-framebuffer";
-		break;
-	}
-
-	pd = platform_device_alloc(name, 0);
-	if (!pd) {
-		ret = -ENOMEM;
-		goto put_device;
-	}
-
-	pd->dev.parent = parent;
-
-	sysfb_set_efifb_fwnode(pd);
-
-	ret = platform_device_add_data(pd, si, sizeof(*si));
-	if (ret)
-		goto err;
-
-	ret = platform_device_add(pd);
-	if (ret)
-		goto err;
-
-	goto put_device;
-err:
-	platform_device_put(pd);
-put_device:
-	put_device(parent);
-unlock_mutex:
+	mutex_lock(&disable_lock);
+	quirks_applied = true;
+	if (!disabled)
+		ret = __sysfb_create_device(false);
 	mutex_unlock(&disable_lock);
+
 	return ret;
 }
 
diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 592d8a644619..6fcbc3ae17d5 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -24,8 +24,8 @@ static const char simplefb_resname[] = "BOOTFB";
 static const struct simplefb_format formats[] = SIMPLEFB_FORMATS;
 
 /* try parsing screen_info into a simple-framebuffer mode struct */
-__init bool sysfb_parse_mode(const struct screen_info *si,
-			     struct simplefb_platform_data *mode)
+bool sysfb_parse_mode(const struct screen_info *si,
+		      struct simplefb_platform_data *mode)
 {
 	__u8 type;
 	u32 bits_per_pixel;
@@ -61,9 +61,9 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 	return false;
 }
 
-__init struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
-						     const struct simplefb_platform_data *mode,
-						     struct device *parent)
+struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
+					      const struct simplefb_platform_data *mode,
+					      struct device *parent)
 {
 	struct platform_device *pd;
 	struct resource res;
diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 2b5a1e666e9b..4de6dc04a3fd 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -372,3 +372,57 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 
 }
 EXPORT_SYMBOL(aperture_remove_conflicting_pci_devices);
+
+static void devm_aperture_restore_sysfb(void *unused)
+{
+	sysfb_restore();
+}
+
+/**
+ * devm_aperture_remove_conflicting_pci_devices - remove existing framebuffers
+ *                                                with sysfb restore on failure
+ * @pdev: PCI device
+ * @name: a descriptive name of the requesting driver
+ *
+ * This function removes devices that own apertures within any of @pdev's
+ * memory bars, similar to aperture_remove_conflicting_pci_devices().
+ *
+ * Additionally, it registers a devm action that will restore the system
+ * framebuffer if the driver's probe fails or the driver is unloaded. This
+ * ensures the user doesn't lose display output if the DRM driver probe fails
+ * after removing the firmware framebuffer.
+ *
+ * This function should be called early in the driver's probe function. The
+ * driver must call devm_aperture_remove_conflicting_pci_devices_done() after
+ * successfully completing probe to cancel the automatic restore.
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise
+ */
+int devm_aperture_remove_conflicting_pci_devices(struct pci_dev *pdev,
+						 const char *name)
+{
+	int ret;
+
+	ret = aperture_remove_conflicting_pci_devices(pdev, name);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&pdev->dev, devm_aperture_restore_sysfb,
+					NULL);
+}
+EXPORT_SYMBOL(devm_aperture_remove_conflicting_pci_devices);
+
+/**
+ * devm_aperture_remove_conflicting_pci_devices_done - cancel sysfb restore
+ * @pdev: PCI device
+ *
+ * Cancels the automatic sysfb restore action registered by
+ * devm_aperture_remove_conflicting_pci_devices(). Call this after the
+ * driver has successfully completed probe and registered its display.
+ */
+void devm_aperture_remove_conflicting_pci_devices_done(struct pci_dev *pdev)
+{
+	devm_remove_action(&pdev->dev, devm_aperture_restore_sysfb, NULL);
+}
+EXPORT_SYMBOL(devm_aperture_remove_conflicting_pci_devices_done);
diff --git a/include/linux/aperture.h b/include/linux/aperture.h
index 1a9a88b11584..ea0ece7f777e 100644
--- a/include/linux/aperture.h
+++ b/include/linux/aperture.h
@@ -19,6 +19,10 @@ int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t si
 int __aperture_remove_legacy_vga_devices(struct pci_dev *pdev);
 
 int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *name);
+
+int devm_aperture_remove_conflicting_pci_devices(struct pci_dev *pdev,
+						 const char *name);
+void devm_aperture_remove_conflicting_pci_devices_done(struct pci_dev *pdev);
 #else
 static inline int devm_aperture_acquire_for_platform_device(struct platform_device *pdev,
 							    resource_size_t base,
@@ -42,6 +46,16 @@ static inline int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev,
 {
 	return 0;
 }
+
+static inline int devm_aperture_remove_conflicting_pci_devices(struct pci_dev *pdev,
+							       const char *name)
+{
+	return 0;
+}
+
+static inline void devm_aperture_remove_conflicting_pci_devices_done(struct pci_dev *pdev)
+{
+}
 #endif
 
 /**
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index b449665c686a..c0ade38bcf99 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -63,6 +63,7 @@ struct efifb_dmi_info {
 #ifdef CONFIG_SYSFB
 
 void sysfb_disable(struct device *dev);
+int sysfb_restore(void);
 
 bool sysfb_handles_screen_info(void);
 
@@ -72,6 +73,11 @@ static inline void sysfb_disable(struct device *dev)
 {
 }
 
+static inline int sysfb_restore(void)
+{
+	return -ENODEV;
+}
+
 static inline bool sysfb_handles_screen_info(void)
 {
 	return false;
-- 
2.48.1


