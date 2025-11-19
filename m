Return-Path: <linux-efi+bounces-5613-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAEC6E864
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 13:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 767EA4FB043
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 12:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D6935E522;
	Wed, 19 Nov 2025 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybrhDenc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC4354715
	for <linux-efi@vger.kernel.org>; Wed, 19 Nov 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555428; cv=none; b=L/jKGpNza4NmBU47hekMOQLRDx8/BsQK/vg65R7hpUE/ndGgSm/s/onVK7l1MIxxHojebDTd1KX2YcKSjL6qhE34u8PQJvOVgQm/vm6+6dlr2JKJOlDK7leibBq1VbQys44QkC2/5T2VVKCIbGmwmKN/Ygwk8bcJjsRdfeqfnbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555428; c=relaxed/simple;
	bh=sOiJLEccJubY+IlNedE4v53cBZq+vCu9Z/9uV/ZRZJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n/y4bJ2frw8gC8jjVxkBf0gk0ufBTZq1eE/0GfgDFtSaM3ffaqS9l4ARC3fHT4kiqhgh8Gqj+5jW/Xosq1zZb8ZXhLHgbdSeipTOTlea+dOk7E2kbD0Ds5iaQ7hTDEpO4jCQotAodTDgJ12hNoj+Y8GS9Uisl/NoWDs3rJSMVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ybrhDenc; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42b2ffe9335so6569076f8f.1
        for <linux-efi@vger.kernel.org>; Wed, 19 Nov 2025 04:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763555423; x=1764160223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CCZSFlWjXSemPE0c71hVyq0rOCAzcBUbpMNTNmmBAhI=;
        b=ybrhDencEo5SwqJX8xEaU6dMyZ8JVRfSwA2eH4voxK12WUFuA0h3XU3F+q9Dfidpie
         vMI+xJ0/7AscT9IAekteRSNxAa+Z3q7QMu3RhZKUp/9vmBgfij3Tz4NkqfXwsEon5dVU
         MJjA8yDUnYDV/X+brql3lge5sfBOuyrySyag5lQQ7pcQIRulDMhyyKT4RLehAQxZr3tz
         Ep2ly+N9zPyLV5tBBMnlf/TV/llyLycEi7voVNotVcTwbcJLoM9CTjivzIX/4uwQsweD
         uyoJUQaI9YMPoQJPe7Gvulx/X/WwyZa5w7obv5hloxOjYB0DheTcOijmrhwf2DxRtwQ1
         Ms0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555423; x=1764160223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCZSFlWjXSemPE0c71hVyq0rOCAzcBUbpMNTNmmBAhI=;
        b=nxTPssYUr06PNjOrUA6o5TtqDXZdhdOOQb5arVgB3PPAkO8tDUHgWVEcSstuTz+nNn
         TdHB+Ibi/LYX9iSVo2iEEKJAXIvPc25Hc9cudPVEljAMCg2cVBMCmLRCz6sPNJoyPDQy
         6u2I7EtPfyY8aaRr8NMAY/yLDdGKIlABiOHpO8Ot66ZoDzQ/Fyn+Ffr/J/Kfz7YkmJtZ
         Gj19Tk4msyeWq4vb2unyg1kQe3R17utHaln81FG09ZgwN2orRrMkrrH6mN55CuSzETp6
         a7w6rAxO71PaN6AcTezKfBysyEdQVZy5aa68aDA6a0ERFxgIgge5B1/KGtpQKdfN+vlh
         28NA==
X-Gm-Message-State: AOJu0YyCt5IOXTw67rU6uu8qLVIvJUZiMxWPs+z3DTAfYUj/Y5F9DhXi
	FUbWHIMx1y8bFKkwl4GAe9mvy76pUa690Uxx/aui9GW5xN/9o3LHRhMBjH8ivSJfsfV6X46Ss1g
	zlWgOPn9097zBRXJiWU3YdXdIbXJzjKud13IPPag6BIE6sBdEte1pL/jBRdivv/TFCnXlGlsfi9
	uvDCeBMLGY8gZiqo7R513b70HTwUQgEA==
X-Google-Smtp-Source: AGHT+IEbIoEW04wIIITxvn25xflZHV3gl+MhgBXd8EGgAT69kGiOFtZFawgeYZEZSMbsl50CtoUIe7+n
X-Received: from wros1.prod.google.com ([2002:adf:ecc1:0:b0:42b:b28a:6751])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2087:b0:42b:30d4:e401
 with SMTP id ffacd0b85a97d-42b5933e396mr21516548f8f.12.1763555422909; Wed, 19
 Nov 2025 04:30:22 -0800 (PST)
Date: Wed, 19 Nov 2025 13:30:15 +0100
In-Reply-To: <20251119123011.1187249-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119123011.1187249-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3278; i=ardb@kernel.org;
 h=from:subject; bh=qs6TD8wDZN1H8XJtFf3OJxiLamhf33ZUemAhFwhVlgo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVN2R8TU4yzi2t2Rmlu9dwhP/xcteN+L89PrhxHbnaV0N
 QRdHXd2lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImYXmZkuFpteI4laJd49Ynm
 Q++2r7HbJp5YLH/j6YnlDzVS7bffkmP4n+Fgznss+ZX/o/9Sx6PD5CfVf3hq4yamfPihvkmY2yU NfgA=
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119123011.1187249-8-ardb+git@google.com>
Subject: [PATCH 3/3] efi: Add FIRMWARE_EDID support
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Add support to non-x86 EFI systems for passing the EDID information
discovered by the EFI stub to the kernel proper.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi-init.c         | 8 ++++++++
 drivers/firmware/efi/libstub/efi-stub.c | 7 ++++++-
 drivers/firmware/efi/libstub/efistub.h  | 3 ---
 drivers/video/Kconfig                   | 2 +-
 include/linux/efi.h                     | 4 ++++
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index 5896f4e699a1..d70bd0ec154f 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -64,6 +64,14 @@ struct efi_screen_info efi_screen_info __section(".data");
 
 extern struct screen_info screen_info __alias(efi_screen_info);
 EXPORT_SYMBOL_GPL(screen_info);
+
+#ifdef CONFIG_FIRMWARE_EDID
+const u8 *get_edid_info(void)
+{
+       return efi_screen_info.edid_info.dummy;
+}
+EXPORT_SYMBOL_GPL(get_edid_info);
+#endif
 #endif
 
 static void __init init_screen_info(void)
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index fe77c285a547..20b606d1cbf0 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -54,8 +54,13 @@ void __weak free_screen_info(struct efi_screen_info *si)
 static struct efi_screen_info *setup_graphics(void)
 {
 	struct efi_screen_info *si, tmp = {};
+	struct edid_info *edid_info = NULL;
 
-	if (efi_setup_graphics(&tmp, NULL) != EFI_SUCCESS)
+#ifdef CONFIG_FIRMWARE_EDID
+	edid_info = &tmp.edid_info;
+#endif
+
+	if (efi_setup_graphics(&tmp.screen_info, edid_info) != EFI_SUCCESS)
 		return NULL;
 
 	si = alloc_screen_info();
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index bdeb28d42a1a..93940592e88e 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -34,9 +34,6 @@
 #define EFI_ALLOC_LIMIT		ULONG_MAX
 #endif
 
-struct edid_info;
-struct screen_info;
-
 extern bool efi_no5lvl;
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index d51777df12d1..6526827fbc55 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -63,7 +63,7 @@ endif # HAS_IOMEM
 
 config FIRMWARE_EDID
 	bool "Enable firmware EDID"
-	depends on X86
+	depends on X86 || EFI_GENERIC_STUB
 	help
 	  This enables access to the EDID transferred from the firmware.
 	  On x86, this is from the VESA BIOS. DRM display drivers will
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 75d05dc1b4ee..8d8228d73585 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -28,6 +28,7 @@
 #include <asm/page.h>
 
 #include <linux/screen_info.h>
+#include <video/edid.h>
 
 #define EFI_SUCCESS		0
 #define EFI_LOAD_ERROR		( 1 | (1UL << (BITS_PER_LONG-1)))
@@ -1363,6 +1364,9 @@ void efivars_generic_ops_unregister(void);
 
 struct efi_screen_info {
 	struct screen_info	screen_info;
+#ifdef CONFIG_FIRMWARE_EDID
+	struct edid_info	edid_info;
+#endif
 };
 
 #endif /* _LINUX_EFI_H */
-- 
2.52.0.rc1.455.g30608eb744-goog


