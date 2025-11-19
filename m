Return-Path: <linux-efi+bounces-5611-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4835C6E84F
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 13:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 259F24EDF2D
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 12:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C1835CB97;
	Wed, 19 Nov 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nnw1+J6X"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB735A937
	for <linux-efi@vger.kernel.org>; Wed, 19 Nov 2025 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555426; cv=none; b=OTGO6kHJpVpeWkMtT8vjZ0vRf+yOFrvD9iyWhF1FfKimEmz3HcXE8HtbBU9Z982XBibNA4z7O/vlLfjWy+3ZPj07lFxJnAnToIX12C1ru3asxmlgGTFbn+/LhWp77yd6bHbqE8nqa0t8hK6Qg8bcZphY7qUDmYN71+ozqXUBEs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555426; c=relaxed/simple;
	bh=TA/i17Wc7R978mqCKogUp9xiyjvcSBcL5TkdOt9LVgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=su8qmHvLgneOQPpZxK5vZsaDPnPc6ifMCBwhz5TswuSihaYs0O6nATzhXlGPLhhdZnYzW/V+c2U0DHR5BlEkzJczo1854qzgrkbyAA5KGtPgWUSaC988d5WaOftl2vWCW7JyyNftkjWE6RuVaDOf+N43BvVwoIEShuWMI0h9J7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nnw1+J6X; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47777158a85so57916935e9.3
        for <linux-efi@vger.kernel.org>; Wed, 19 Nov 2025 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763555421; x=1764160221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBcg4cW+Fyl+51clDdaiGPMj2fI7AHh6peqeu95tb9Y=;
        b=Nnw1+J6XnIyFiED5quCFF0lp1BHOsY/cQ3XQb+atdz3PjfxtRCNmg83OVDkKqQMQ0f
         rqbliSs6giJ8ITA0AsuoPEyRMlfqezjA0RGft56vOQaaWE16j1loRhJILh2OwUlgukFm
         ZIjW5Gkd7H5Z8OVXrSmJVGJjmHcAe7fDPSsIr67wlJJvV9sbpgKADlg7vVeg4AMjzl0z
         KGGVSzE3IUl1qHP0ikry4Ysriv5VJ6g4e0r0BSA0dUr6aEZ3O5VlWfOKOdBBL4PHb6Ts
         YGLeAlBkgSeMKYPsauxCymMHmFpCU7LNQxi5AeohF0GC3V+KiE5pjgGcWF/NEfpRR4jW
         X1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555421; x=1764160221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBcg4cW+Fyl+51clDdaiGPMj2fI7AHh6peqeu95tb9Y=;
        b=Si49zKYKxw1Lb9fIFev+lZStOTRIVUPtgqOcqFUwwQsQREsycLX4jc6JM5jJEJA5AU
         8IFHSq4V7ntGexaKOC66XRz8RcvvpeF5w1Mks0u6TWjar3nLAO0KptOdJn47ebBdiDrA
         rYQ1jzaJnBe5oEcdfZX9auTj7EiUdiKwxlzTNM+fXG1+21LhoqALxbLLwB7FydZB99fn
         TiZs2Vsa5dXuJ/nA5JlBSCRGO/2oeCX7x2e1xFo1KNGhL/cXhDNHpWLFTqV8rZgEdDgl
         jl/+aDlkmT83t1JMx120HgPhxQnMPTJ9DgICsuNmue5iFNjRWUhlsZu+LrYNt93h2Cfj
         E8Vw==
X-Gm-Message-State: AOJu0YzbcuGfo0w2nAYNVFUtPJGMFZSxu/Cszfk3EtlVBK8U6JmK2mbS
	bJ++Y272TJGuGs6I1a5snvKfMOS6y9EPlt/F6XiC3EZGT4H59YNjSvGU9ET+uDKoAyoKfOJZlGF
	sh2G1rbO/h+utBdLX7ZQBhr5Xap/APDlFpQ4BzmFMILx387Hqeuf3TfnVmGeUK8gmtlTocwkzs9
	qN4h4vRhHTsb75Is/nimEw2YS+546tHA==
X-Google-Smtp-Source: AGHT+IHIU5JM8aPAQkX43sPIm9FRIUcbtqqW7DYxT0FNPjjFH/q4e5q2X7SHQsQXEYDHfbvhiLNYFSZb
X-Received: from wmmr12.prod.google.com ([2002:a05:600c:424c:b0:477:9c96:9fb9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c4a2:b0:477:c37:2ea7
 with SMTP id 5b1f17b1804b1-4778fe9ac28mr182388985e9.21.1763555421191; Wed, 19
 Nov 2025 04:30:21 -0800 (PST)
Date: Wed, 19 Nov 2025 13:30:13 +0100
In-Reply-To: <20251119123011.1187249-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119123011.1187249-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8249; i=ardb@kernel.org;
 h=from:subject; bh=f7i7AmKvznI5qoe+nE17mQh0HeBGMvSPz57uv3lycqw=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVN2R5j8Y8tOjcu87I8yVm7eaTJh11Tdsvybjpnxq1YHW
 UbExx3uKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO5OYXhN8uEZSmvRfcqOpys
 n9J1deMFR8tXbUIHL78W+ZLQub7n1A+G/xlLmXxergvd68w4Z6GWgLPzvY4lM1+4//GerP130qO XOjwA
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119123011.1187249-6-ardb+git@google.com>
Subject: [PATCH 1/3] efi: Wrap screen_info in efi_screen_info so edid_info can
 be added later
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Prepare for adding support to the EFI stub to pass edid_info discovered
using EFI boot services to the kernel proper via a EFI configuration
table. Instead of passing struct screen_info directly, define a new
struct efi_screen_info that encapsulates it. struct edid_info will be
added there later.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/earlycon.c               |  1 -
 drivers/firmware/efi/efi-init.c               | 11 ++++++-----
 drivers/firmware/efi/libstub/efi-stub-entry.c |  3 +--
 drivers/firmware/efi/libstub/efi-stub.c       |  9 ++++-----
 drivers/firmware/efi/libstub/efistub.h        |  6 +++---
 drivers/firmware/efi/libstub/gop.c            |  1 -
 drivers/firmware/efi/libstub/screen_info.c    |  7 +++----
 drivers/firmware/efi/libstub/zboot.c          |  2 +-
 drivers/firmware/efi/sysfb_efi.c              |  1 -
 include/linux/efi.h                           |  6 +++++-
 10 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index d18a1a5de144..23fb23867b56 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -9,7 +9,6 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/serial_core.h>
-#include <linux/screen_info.h>
 #include <linux/string.h>
 
 #include <asm/early_ioremap.h>
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index a65c2d5b9e7b..5896f4e699a1 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -19,7 +19,6 @@
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/platform_device.h>
-#include <linux/screen_info.h>
 
 #include <asm/efi.h>
 
@@ -61,13 +60,15 @@ extern __weak const efi_config_table_type_t efi_arch_tables[];
  * everything else can get it from here.
  */
 #if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON))
-struct screen_info screen_info __section(".data");
+struct efi_screen_info efi_screen_info __section(".data");
+
+extern struct screen_info screen_info __alias(efi_screen_info);
 EXPORT_SYMBOL_GPL(screen_info);
 #endif
 
 static void __init init_screen_info(void)
 {
-	struct screen_info *si;
+	struct efi_screen_info *si;
 
 	if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
 		si = early_memremap(screen_info_table, sizeof(*si));
@@ -75,8 +76,8 @@ static void __init init_screen_info(void)
 			pr_err("Could not map screen_info config table\n");
 			return;
 		}
-		screen_info = *si;
-		memset(si, 0, sizeof(*si));
+		efi_screen_info = *si;
+		si->screen_info = (struct screen_info){};
 		early_memunmap(si, sizeof(*si));
 
 		if (memblock_is_map_memory(screen_info.lfb_base))
diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
index a6c049835190..520f5ea31cfd 100644
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/efi.h>
-#include <linux/screen_info.h>
 
 #include <asm/efi.h>
 
@@ -9,7 +8,7 @@
 
 static unsigned long screen_info_offset;
 
-struct screen_info *alloc_screen_info(void)
+struct efi_screen_info *alloc_screen_info(void)
 {
 	if (IS_ENABLED(CONFIG_ARM))
 		return __alloc_screen_info();
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 9cb814c5ba1b..fe77c285a547 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/efi.h>
-#include <linux/screen_info.h>
 #include <asm/efi.h>
 
 #include "efistub.h"
@@ -48,13 +47,13 @@
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
 static bool flat_va_mapping = (EFI_RT_VIRTUAL_OFFSET != 0);
 
-void __weak free_screen_info(struct screen_info *si)
+void __weak free_screen_info(struct efi_screen_info *si)
 {
 }
 
-static struct screen_info *setup_graphics(void)
+static struct efi_screen_info *setup_graphics(void)
 {
-	struct screen_info *si, tmp = {};
+	struct efi_screen_info *si, tmp = {};
 
 	if (efi_setup_graphics(&tmp, NULL) != EFI_SUCCESS)
 		return NULL;
@@ -145,7 +144,7 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 			     unsigned long image_addr,
 			     char *cmdline_ptr)
 {
-	struct screen_info *si;
+	struct efi_screen_info *si;
 	efi_status_t status;
 
 	status = check_platform_features();
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b2fb0c3fa721..bdeb28d42a1a 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1175,9 +1175,9 @@ efi_enable_reset_attack_mitigation(void) { }
 
 void efi_retrieve_eventlog(void);
 
-struct screen_info *alloc_screen_info(void);
-struct screen_info *__alloc_screen_info(void);
-void free_screen_info(struct screen_info *si);
+struct efi_screen_info *alloc_screen_info(void);
+struct efi_screen_info *__alloc_screen_info(void);
+void free_screen_info(struct efi_screen_info *si);
 
 void efi_cache_sync_image(unsigned long image_base,
 			  unsigned long alloc_size);
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 72d74436a7a4..db80f2ad2871 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -8,7 +8,6 @@
 #include <linux/bitops.h>
 #include <linux/ctype.h>
 #include <linux/efi.h>
-#include <linux/screen_info.h>
 #include <linux/string.h>
 #include <asm/efi.h>
 #include <asm/setup.h>
diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmware/efi/libstub/screen_info.c
index 5d3a1e32d177..189da1efb7b2 100644
--- a/drivers/firmware/efi/libstub/screen_info.c
+++ b/drivers/firmware/efi/libstub/screen_info.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/efi.h>
-#include <linux/screen_info.h>
 
 #include <asm/efi.h>
 
@@ -21,9 +20,9 @@
 
 static efi_guid_t screen_info_guid = LINUX_EFI_SCREEN_INFO_TABLE_GUID;
 
-struct screen_info *__alloc_screen_info(void)
+struct efi_screen_info *__alloc_screen_info(void)
 {
-	struct screen_info *si;
+	struct efi_screen_info *si;
 	efi_status_t status;
 
 	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
@@ -43,7 +42,7 @@ struct screen_info *__alloc_screen_info(void)
 	return NULL;
 }
 
-void free_screen_info(struct screen_info *si)
+void free_screen_info(struct efi_screen_info *si)
 {
 	if (!si)
 		return;
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index c47ace06f010..86f4814cfd47 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -26,7 +26,7 @@ void __weak efi_cache_sync_image(unsigned long image_base,
 	// executable code loaded into memory to be safe for execution.
 }
 
-struct screen_info *alloc_screen_info(void)
+struct efi_screen_info *alloc_screen_info(void)
 {
 	return __alloc_screen_info();
 }
diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 1e509595ac03..092c19771e17 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -22,7 +22,6 @@
 #include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
-#include <linux/screen_info.h>
 #include <linux/sysfb.h>
 #include <video/vga.h>
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a01f3fe20dab..75d05dc1b4ee 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -27,7 +27,7 @@
 
 #include <asm/page.h>
 
-struct screen_info;
+#include <linux/screen_info.h>
 
 #define EFI_SUCCESS		0
 #define EFI_LOAD_ERROR		( 1 | (1UL << (BITS_PER_LONG-1)))
@@ -1361,4 +1361,8 @@ extern struct blocking_notifier_head efivar_ops_nh;
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);
 
+struct efi_screen_info {
+	struct screen_info	screen_info;
+};
+
 #endif /* _LINUX_EFI_H */
-- 
2.52.0.rc1.455.g30608eb744-goog


