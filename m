Return-Path: <linux-efi+bounces-5667-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04734C81B2B
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 17:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A903D4E7F01
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B686319619;
	Mon, 24 Nov 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P3YFh9Ad";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ik7ItF7I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P3YFh9Ad";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ik7ItF7I"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97AF3195EC
	for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003103; cv=none; b=V9zv8jx9/AzwpsFIhDsdrrUq1HAGK6aeHyaPC8hYE+GWcqyXfRX3qAuoeWNM9//WtLT9lzkar0tMVaGr1uQ9a2Q9O7INuonKaaiQguF24EBZ43EP9nQos6u2q9EhW/zoYjV7q6/8eEHqAhZL+fZ/tOXhhmRPOyPjFj9NvXpVCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003103; c=relaxed/simple;
	bh=q1YapmmysoLNNV0hWk47DnHWk1R3kcAszF2Pnr1xUzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf8WSXg91vgT80IzYwXNP1ldGU0wstFwMaA5sKWhX2Vgo+R+tE3/HCa/d0KzqSZErffuf21nb02teA1XgQDcAJyIDqluAH6NDfYeX5TnJ5omx4qdidhIJ6Rru/59mgA2mc+1q2dVjahxymGZZHV19g9bc3MHv/eW109/b/pCrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P3YFh9Ad; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ik7ItF7I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P3YFh9Ad; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ik7ItF7I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 299935BCFE;
	Mon, 24 Nov 2025 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4bUu16XS9Hy1d0288nImvDqun1w20DCWZYkIdGnquA=;
	b=P3YFh9AdISWEG2+szuqjs1YSg5vXN7b7bgRKidCMLjQsLwlFa9lDAnLz/qy5DJbcPqh4IT
	lul63lg+Nle7b17Dc9flzk9/kYDkQ/tR7D/FX7elZZSgIe0ZWV7hOe0aLkoC14925trkm7
	apyFxRkJ42xYjbn1/YLAsrXsiSDOOn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4bUu16XS9Hy1d0288nImvDqun1w20DCWZYkIdGnquA=;
	b=Ik7ItF7Io3QAebcBgZot27HX7fmTDMBL1yJpqJlaB5cF/XUyr4AqggtdFX3k875ev10DD3
	DaaHiHyLKHw2kTAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4bUu16XS9Hy1d0288nImvDqun1w20DCWZYkIdGnquA=;
	b=P3YFh9AdISWEG2+szuqjs1YSg5vXN7b7bgRKidCMLjQsLwlFa9lDAnLz/qy5DJbcPqh4IT
	lul63lg+Nle7b17Dc9flzk9/kYDkQ/tR7D/FX7elZZSgIe0ZWV7hOe0aLkoC14925trkm7
	apyFxRkJ42xYjbn1/YLAsrXsiSDOOn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4bUu16XS9Hy1d0288nImvDqun1w20DCWZYkIdGnquA=;
	b=Ik7ItF7Io3QAebcBgZot27HX7fmTDMBL1yJpqJlaB5cF/XUyr4AqggtdFX3k875ev10DD3
	DaaHiHyLKHw2kTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B57C03EA65;
	Mon, 24 Nov 2025 16:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gD/jKhCNJGm3GgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Nov 2025 16:51:28 +0000
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
Subject: [PATCH v2 09/10] efi: libstub: Transfer EDID to kernel
Date: Mon, 24 Nov 2025 17:40:21 +0100
Message-ID: <20251124165116.502813-10-tzimmermann@suse.de>
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
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLykjg6e7ifkwtw7jmpw7b9yio)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Replace struct screen_info with struct sysfb_display_info from the
kernel's sysfb_primary_display and rename functions accordingly.
Transfer the it to the runtime kernel using the kernel's global state
or the config-table entry LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID.

Also rename screen_info.c to primary_display.c and adapt the contained
comment according to the changes.

With CONFIG_FIRMWARE_EDID=y, libstub now transfers the GOP device's
EDID information to the kernel.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/efi/libstub/Makefile         |  2 +-
 drivers/firmware/efi/libstub/efi-stub-entry.c | 11 ++--
 drivers/firmware/efi/libstub/efi-stub.c       | 41 +++++++++-----
 drivers/firmware/efi/libstub/efistub.h        |  7 ++-
 .../firmware/efi/libstub/primary_display.c    | 56 +++++++++++++++++++
 drivers/firmware/efi/libstub/screen_info.c    | 53 ------------------
 drivers/firmware/efi/libstub/zboot.c          |  4 +-
 7 files changed, 93 insertions(+), 81 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/primary_display.c
 delete mode 100644 drivers/firmware/efi/libstub/screen_info.c

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 7d15a85d579f..e386ffd009b7 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -80,7 +80,7 @@ $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
 lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
-				   screen_info.o efi-stub-entry.o
+				   primary_display.o efi-stub-entry.o
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= kaslr.o arm64.o arm64-stub.o smbios.o
diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
index 401ecbbdf331..aa85e910fe59 100644
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -14,18 +14,15 @@ static void *kernel_image_addr(void *addr)
 	return addr + kernel_image_offset;
 }
 
-struct screen_info *alloc_screen_info(void)
+struct sysfb_display_info *alloc_primary_display(void)
 {
 	if (IS_ENABLED(CONFIG_ARM))
-		return __alloc_screen_info();
+		return __alloc_primary_display();
 
 	if (IS_ENABLED(CONFIG_X86) ||
 	    IS_ENABLED(CONFIG_EFI_EARLYCON) ||
-	    IS_ENABLED(CONFIG_SYSFB)) {
-		struct sysfb_display_info *dpy = kernel_image_addr(&sysfb_primary_display);
-
-		return &dpy->screen;
-	}
+	    IS_ENABLED(CONFIG_SYSFB))
+		return kernel_image_addr(&sysfb_primary_display);
 
 	return NULL;
 }
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 9cb814c5ba1b..42d6073bcd06 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -10,7 +10,7 @@
  */
 
 #include <linux/efi.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 #include <asm/efi.h>
 
 #include "efistub.h"
@@ -48,23 +48,33 @@
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
 static bool flat_va_mapping = (EFI_RT_VIRTUAL_OFFSET != 0);
 
-void __weak free_screen_info(struct screen_info *si)
-{
-}
+void __weak free_primary_display(struct sysfb_display_info *dpy)
+{ }
 
-static struct screen_info *setup_graphics(void)
+static struct sysfb_display_info *setup_primary_display(void)
 {
-	struct screen_info *si, tmp = {};
+	struct sysfb_display_info *dpy;
+	struct screen_info *screen = NULL;
+	struct edid_info *edid = NULL;
+	efi_status_t status;
 
-	if (efi_setup_graphics(&tmp, NULL) != EFI_SUCCESS)
+	dpy = alloc_primary_display();
+	if (!dpy)
 		return NULL;
+	screen = &dpy->screen;
+#if defined(CONFIG_FIRMWARE_EDID)
+	edid = &dpy->edid;
+#endif
 
-	si = alloc_screen_info();
-	if (!si)
-		return NULL;
+	status = efi_setup_graphics(screen, edid);
+	if (status != EFI_SUCCESS)
+		goto err_free_primary_display;
 
-	*si = tmp;
-	return si;
+	return dpy;
+
+err_free_primary_display:
+	free_primary_display(dpy);
+	return NULL;
 }
 
 static void install_memreserve_table(void)
@@ -145,14 +155,14 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 			     unsigned long image_addr,
 			     char *cmdline_ptr)
 {
-	struct screen_info *si;
+	struct sysfb_display_info *dpy;
 	efi_status_t status;
 
 	status = check_platform_features();
 	if (status != EFI_SUCCESS)
 		return status;
 
-	si = setup_graphics();
+	dpy = setup_primary_display();
 
 	efi_retrieve_eventlog();
 
@@ -172,7 +182,8 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 
 	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
 
-	free_screen_info(si);
+	free_primary_display(dpy);
+
 	return status;
 }
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b2fb0c3fa721..979a21818cc1 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -36,6 +36,7 @@
 
 struct edid_info;
 struct screen_info;
+struct sysfb_display_info;
 
 extern bool efi_no5lvl;
 extern bool efi_nochunk;
@@ -1175,9 +1176,9 @@ efi_enable_reset_attack_mitigation(void) { }
 
 void efi_retrieve_eventlog(void);
 
-struct screen_info *alloc_screen_info(void);
-struct screen_info *__alloc_screen_info(void);
-void free_screen_info(struct screen_info *si);
+struct sysfb_display_info *alloc_primary_display(void);
+struct sysfb_display_info *__alloc_primary_display(void);
+void free_primary_display(struct sysfb_display_info *dpy);
 
 void efi_cache_sync_image(unsigned long image_base,
 			  unsigned long alloc_size);
diff --git a/drivers/firmware/efi/libstub/primary_display.c b/drivers/firmware/efi/libstub/primary_display.c
new file mode 100644
index 000000000000..cdaebab26514
--- /dev/null
+++ b/drivers/firmware/efi/libstub/primary_display.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <linux/sysfb.h>
+
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+/*
+ * There are two ways of populating the core kernel's sysfb_primary_display
+ * via the stub:
+ *
+ *   - using a configuration table, which relies on the EFI init code to
+ *     locate the table and copy the contents; or
+ *
+ *   - by linking directly to the core kernel's copy of the global symbol.
+ *
+ * The latter is preferred because it makes the EFIFB earlycon available very
+ * early, but it only works if the EFI stub is part of the core kernel image
+ * itself. The zboot decompressor can only use the configuration table
+ * approach.
+ */
+
+static efi_guid_t primary_display_guid = LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID;
+
+struct sysfb_display_info *__alloc_primary_display(void)
+{
+	struct sysfb_display_info *dpy;
+	efi_status_t status;
+
+	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
+			     sizeof(*dpy), (void **)&dpy);
+
+	if (status != EFI_SUCCESS)
+		return NULL;
+
+	memset(dpy, 0, sizeof(*dpy));
+
+	status = efi_bs_call(install_configuration_table,
+			     &primary_display_guid, dpy);
+	if (status == EFI_SUCCESS)
+		return dpy;
+
+	efi_bs_call(free_pool, dpy);
+	return NULL;
+}
+
+void free_primary_display(struct sysfb_display_info *dpy)
+{
+	if (!dpy)
+		return;
+
+	efi_bs_call(install_configuration_table, &primary_display_guid, NULL);
+	efi_bs_call(free_pool, dpy);
+}
diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmware/efi/libstub/screen_info.c
deleted file mode 100644
index 5d3a1e32d177..000000000000
--- a/drivers/firmware/efi/libstub/screen_info.c
+++ /dev/null
@@ -1,53 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/efi.h>
-#include <linux/screen_info.h>
-
-#include <asm/efi.h>
-
-#include "efistub.h"
-
-/*
- * There are two ways of populating the core kernel's struct screen_info via the stub:
- * - using a configuration table, like below, which relies on the EFI init code
- *   to locate the table and copy the contents;
- * - by linking directly to the core kernel's copy of the global symbol.
- *
- * The latter is preferred because it makes the EFIFB earlycon available very
- * early, but it only works if the EFI stub is part of the core kernel image
- * itself. The zboot decompressor can only use the configuration table
- * approach.
- */
-
-static efi_guid_t screen_info_guid = LINUX_EFI_SCREEN_INFO_TABLE_GUID;
-
-struct screen_info *__alloc_screen_info(void)
-{
-	struct screen_info *si;
-	efi_status_t status;
-
-	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
-			     sizeof(*si), (void **)&si);
-
-	if (status != EFI_SUCCESS)
-		return NULL;
-
-	memset(si, 0, sizeof(*si));
-
-	status = efi_bs_call(install_configuration_table,
-			     &screen_info_guid, si);
-	if (status == EFI_SUCCESS)
-		return si;
-
-	efi_bs_call(free_pool, si);
-	return NULL;
-}
-
-void free_screen_info(struct screen_info *si)
-{
-	if (!si)
-		return;
-
-	efi_bs_call(install_configuration_table, &screen_info_guid, NULL);
-	efi_bs_call(free_pool, si);
-}
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index c47ace06f010..4b76f74c56da 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -26,9 +26,9 @@ void __weak efi_cache_sync_image(unsigned long image_base,
 	// executable code loaded into memory to be safe for execution.
 }
 
-struct screen_info *alloc_screen_info(void)
+struct sysfb_display_info *alloc_primary_display(void)
 {
-	return __alloc_screen_info();
+	return __alloc_primary_display();
 }
 
 asmlinkage efi_status_t __efiapi
-- 
2.51.1


