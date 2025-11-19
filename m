Return-Path: <linux-efi+bounces-5612-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B94FC6E837
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 13:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 767934FAF64
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 12:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAD435B15E;
	Wed, 19 Nov 2025 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rd+d8Imb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2893587AC
	for <linux-efi@vger.kernel.org>; Wed, 19 Nov 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555426; cv=none; b=jnTGdrfqaGnHBvLr73yw3RTvR+44DdhLQtuImuqMNhp8XQfQyMW8K5e7TjqVUN6hLtUnjAnbthinxfrTDcoc5AbLx8/pdmYU+XRwqkXxz4fsz73lwtad1SguO1L/DL9aSmTRaJRqL71ZtQ9IJaFGhDWp+SXvoBNFpkIWLF/l8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555426; c=relaxed/simple;
	bh=byDZ3v7t+CCsOFWDfG4hKIJVO8uBoCLKg3FIfkOxduU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qyypoO5azBONxeQ5p2BW67XuLZwZsatrFnxcQmnKtQX8jDaIXfhYBVB3YvRYp5NujDYZrXjTEZ7clnDVIQvVaZ19s3xzOHhbpKZtVDdvpXQmbsy6fFEhMpe4tCvu8sBLTZrnjvl7Ua+bpf1ig+c/i5c8GozE+hdgjbkvE+75z/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rd+d8Imb; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47799717212so36387715e9.3
        for <linux-efi@vger.kernel.org>; Wed, 19 Nov 2025 04:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763555422; x=1764160222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsBDJIWJ97vXgpwIuKapIs2CJoKu+mSgcIX0r/Bn/YA=;
        b=rd+d8ImbdBrxhe2+2VD1PfJlc1kekXApVGL6Je8V9GH0sY5vUUYz9ucMncFDsWSigG
         lsZLXL/l5Q8clOFrNfy49f1wDcInVjEx95JAE0Cq62VHz4abRuT+T3x6IqC0tFvRf8xf
         9G/ol9q9a56SPUuBF6ZPJSgy7MtLJ3nbu1qb97JLbSXggNKUqIGneIVKujFV/BwlLXcR
         QK77c+0p91k63h4kiWifuBwpczF/Ji3QMO6Naj/BUynYSoxrogk5MfR8HcvsL8UOx/jC
         UaLHgNnFMijN0D8BtdQlZAxhaoQ2ByoEiVW+vjELNMfKNjFwdi5eRatGuayD4RB7nSmg
         Ombg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555422; x=1764160222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsBDJIWJ97vXgpwIuKapIs2CJoKu+mSgcIX0r/Bn/YA=;
        b=fwnKVKAF19DgFV5MOC/cWWdLX1CXu8aPTUuFSwW5DATu2Adt3bppue/sf6WnPSY3vf
         d7Bg02DxE7RnMfcaX441o0uzOLzW0k28Rikjbw80DsH7krm1qIsjcZtutRQBh9i8cb1/
         0+u+FuMJ9t6hg3gUwm0gUiadsOsyWH604lshZYwLy2ER4KpeHA+/N1InwQOnRz1WI6pF
         yOQed50TpzwhE9tCFVYEmqTjf1mXS4+Tcuelaya4bmRwvpqNKSUt+u2JQY15nmvnL9ew
         bQxNwWjLFOhzObDGdfC/rGPKoK53uvSHkXCbu0BtvJYGYKUriSMYSW3OBI3SSLKxNLgJ
         jBGQ==
X-Gm-Message-State: AOJu0YxaoOWSvXq/OEV979U3PyqVpvQqlmkpbSNWxBvC2GZGHQkoEihb
	Qhh1m5N198NNM1vODbx+favSCzCklXQ4IHTQXCns30LgpGX1SGtCSqjqbhMZzzva63Fd8UtTWoZ
	oEZL5G+HbdSj9tZJVjMDX1rXgfOFghaegHgSe7K8a04ZduzpQxdF/gFG5LB5QsoACRBtExBscEH
	rq6qWpW+sd8DZSRXsqc3lSRitE1aTf5Q==
X-Google-Smtp-Source: AGHT+IGfHs868menOEt0jF3zDpOrJd8v4sXY1quT2LiSrNKCB4Qfy3GPRP30bJNkIHh/MXZJdQvXrkMQ
X-Received: from wmbgz4.prod.google.com ([2002:a05:600c:8884:b0:477:40c1:3e61])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1f91:b0:475:dd9a:f791
 with SMTP id 5b1f17b1804b1-4778feadab1mr170191055e9.28.1763555421842; Wed, 19
 Nov 2025 04:30:21 -0800 (PST)
Date: Wed, 19 Nov 2025 13:30:14 +0100
In-Reply-To: <20251119123011.1187249-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119123011.1187249-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3657; i=ardb@kernel.org;
 h=from:subject; bh=hApARYQFN8XsOp7qFZrUlKVZ7kI6zgBzSlJESx8C/zE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVN2R/iLd8fncS9abj3Z73lP94f/ukrf2E7lHHt7OZc7t
 H/H/Lq3HaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAij0wZGV6skHpzYvf9Rib7
 sLLtbguWTGOXLXisk6MpmRJhGxXad4Lhr+SpXZxy+/fqc35618Zzp/oVTwProqUR6UsOXTogP+v zBX4A
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119123011.1187249-7-ardb+git@google.com>
Subject: [PATCH 2/3] video/edid: Use getter function for edid_info
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Avoid accessing a global writable buffer directly for edid_info, and
instead, define a getter function returning a pointer to it. And
considering that all callers access only the 'dummy' field, just
return a const u8* directly.

This will be used by non-x86 EFI systems that pass edid_info via a EFI
configuration table.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/setup.c          | 8 ++++++--
 drivers/gpu/drm/sysfb/efidrm.c   | 4 ++--
 drivers/gpu/drm/sysfb/vesadrm.c  | 4 ++--
 drivers/video/fbdev/core/fbmon.c | 4 ++--
 include/video/edid.h             | 2 +-
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd07a3e1..526c9c4553c1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -214,8 +214,12 @@ arch_initcall(init_x86_sysctl);
 struct screen_info screen_info;
 EXPORT_SYMBOL(screen_info);
 #if defined(CONFIG_FIRMWARE_EDID)
-struct edid_info edid_info;
-EXPORT_SYMBOL_GPL(edid_info);
+static struct edid_info edid_info __ro_after_init;
+const u8 *get_edid_info(void)
+{
+	return edid_info.dummy;
+}
+EXPORT_SYMBOL_GPL(get_edid_info);
 #endif
 
 extern int root_mountflags;
diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
index 1883c4a8604c..e30b93ed4264 100644
--- a/drivers/gpu/drm/sysfb/efidrm.c
+++ b/drivers/gpu/drm/sysfb/efidrm.c
@@ -203,8 +203,8 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 		&format->format, width, height, stride);
 
 #if defined(CONFIG_FIRMWARE_EDID)
-	if (drm_edid_header_is_valid(edid_info.dummy) == 8)
-		sysfb->edid = edid_info.dummy;
+	if (drm_edid_header_is_valid(get_edid_info()) == 8)
+		sysfb->edid = get_edid_info();
 #endif
 	sysfb->fb_mode = drm_sysfb_mode(width, height, 0, 0);
 	sysfb->fb_format = format;
diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index 16a4b52d45c6..a4ff78fddc0c 100644
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -469,8 +469,8 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 	}
 
 #if defined(CONFIG_FIRMWARE_EDID)
-	if (drm_edid_header_is_valid(edid_info.dummy) == 8)
-		sysfb->edid = edid_info.dummy;
+	if (drm_edid_header_is_valid(get_edid_info()) == 8)
+		sysfb->edid = get_edid_info();
 #endif
 	sysfb->fb_mode = drm_sysfb_mode(width, height, 0, 0);
 	sysfb->fb_format = format;
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 0a65bef01e3c..caa057c76a88 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1495,7 +1495,7 @@ const unsigned char *fb_firmware_edid(struct device *device)
 {
 	struct pci_dev *dev = NULL;
 	struct resource *res = NULL;
-	unsigned char *edid = NULL;
+	const unsigned char *edid = NULL;
 
 	if (device)
 		dev = to_pci_dev(device);
@@ -1504,7 +1504,7 @@ const unsigned char *fb_firmware_edid(struct device *device)
 		res = &dev->resource[PCI_ROM_RESOURCE];
 
 	if (res && res->flags & IORESOURCE_ROM_SHADOW)
-		edid = edid_info.dummy;
+		edid = get_edid_info();
 
 	return edid;
 }
diff --git a/include/video/edid.h b/include/video/edid.h
index c2b186b1933a..b8f24c4b2829 100644
--- a/include/video/edid.h
+++ b/include/video/edid.h
@@ -5,7 +5,7 @@
 #include <uapi/video/edid.h>
 
 #if defined(CONFIG_FIRMWARE_EDID)
-extern struct edid_info edid_info;
+const u8 *get_edid_info(void) __attribute_const__;
 #endif
 
 #endif /* __linux_video_edid_h__ */
-- 
2.52.0.rc1.455.g30608eb744-goog


