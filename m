Return-Path: <linux-efi+bounces-5701-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C0AC8AE0E
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 17:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D26194ED7B7
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4086340A41;
	Wed, 26 Nov 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SsXffjt4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O0gwtwx9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SsXffjt4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O0gwtwx9"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFCA340273
	for <linux-efi@vger.kernel.org>; Wed, 26 Nov 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173372; cv=none; b=odGJ2YN5FJPZoqiB8M/7BvUdjYh4Ofzl2h4KHm3UE5ZMMMqgYQ/ML6aUXCELynlReBZcmqOo6+KiMEn/Vbl+OeKOYiOpizdCpv+ZBrWDfRGae4gYJeJ9dXcOSuNow4lGyCg9N2IWCWhyf0oDVwtxuStPltThZvN2YkC1k+Fzrnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173372; c=relaxed/simple;
	bh=6iU3mD3vTG8JanScsrTHb9+tSgGfFO4j6PYRL7oyI8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQPF8o6lUS0KyAqP1yiZo523IEyMtEH1yDELmq+D65aKb5n9zWg3RR9Nrz3kXxGJBSEyy9Vy/7fBS4qxw4ZkHWF40q5z71m4ZbHMduWeePcRq2VvA0dDg1kdKpzmrb16SxPVC+ZGLX9CXmX9jYgPrBHlxNesfUvV1Q3LHc/rPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SsXffjt4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O0gwtwx9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SsXffjt4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O0gwtwx9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E2415BEA5;
	Wed, 26 Nov 2025 16:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764173343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkmGR33aKTjgb6kQRBytVJN0qrs/mJkqfSEDrbecCv4=;
	b=SsXffjt4e0FU5WaaOVe0pPb3Sp1cKeBnl+HW+kStFrGW/i1SkWF78HqOYaFB6l1x9zmKkn
	4SPBaRuuQvE7N6ZfjugXdzbHGUikzB1C0SAYthYC8NhDyjRqbK0raKL9vIf6UDfLRP2xID
	LlZJv/CGppOPnpwgegPKquwsA21X9P8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764173343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkmGR33aKTjgb6kQRBytVJN0qrs/mJkqfSEDrbecCv4=;
	b=O0gwtwx9ongiEC4E6G/rmRyKUr73fZvZZTppH7kBWIwloKGwL6pE5IePdz/Km+dohBWXak
	1ZahN3CYVTbtcEBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764173343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkmGR33aKTjgb6kQRBytVJN0qrs/mJkqfSEDrbecCv4=;
	b=SsXffjt4e0FU5WaaOVe0pPb3Sp1cKeBnl+HW+kStFrGW/i1SkWF78HqOYaFB6l1x9zmKkn
	4SPBaRuuQvE7N6ZfjugXdzbHGUikzB1C0SAYthYC8NhDyjRqbK0raKL9vIf6UDfLRP2xID
	LlZJv/CGppOPnpwgegPKquwsA21X9P8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764173343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkmGR33aKTjgb6kQRBytVJN0qrs/mJkqfSEDrbecCv4=;
	b=O0gwtwx9ongiEC4E6G/rmRyKUr73fZvZZTppH7kBWIwloKGwL6pE5IePdz/Km+dohBWXak
	1ZahN3CYVTbtcEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C51723EA63;
	Wed, 26 Nov 2025 16:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aP2sLh4mJ2lnIgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Nov 2025 16:09:02 +0000
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
Subject: [PATCH v3 8/9] efi: Support EDID information
Date: Wed, 26 Nov 2025 17:03:25 +0100
Message-ID: <20251126160854.553077-9-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLykjg6e7ifkwtw7jmpw7b9yio)];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO

In the EFI config table, rename LINUX_EFI_SCREEN_INFO_TABLE_GUID to
LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID. Read sysfb_primary_display
from the entry. In addition to the screen_info, the entry now also
contains EDID information.

In libstub, replace struct screen_info with struct sysfb_display_info
from the kernel's sysfb_primary_display and rename functions accordingly.
Transfer it to the runtime kernel using the kernel's global state or
the config-table entry LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID.

With CONFIG_FIRMWARE_EDID=y, libstub now transfers the GOP device's
EDID information to the kernel. If CONFIG_FIRMWARE_EDID=n, EDID
information is disabled. Make the Kconfig symbol CONFIG_FIRMWARE_EDID
available with EFI. Setting the value to 'n' disables EDID support.

Also rename screen_info.c to primary_display.c and adapt the contained
comment according to the changes.

v3:
- replace SCREEN_INFO table (Ard)
- merge libstub changes

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/loongarch/kernel/efi.c                   | 17 +++---
 drivers/firmware/efi/efi-init.c               | 17 +++---
 drivers/firmware/efi/efi.c                    |  4 +-
 drivers/firmware/efi/libstub/Makefile         |  2 +-
 drivers/firmware/efi/libstub/efi-stub-entry.c | 11 ++--
 drivers/firmware/efi/libstub/efi-stub.c       | 41 +++++++++-----
 drivers/firmware/efi/libstub/efistub.h        |  7 ++-
 .../firmware/efi/libstub/primary_display.c    | 56 +++++++++++++++++++
 drivers/firmware/efi/libstub/screen_info.c    | 53 ------------------
 drivers/firmware/efi/libstub/zboot.c          |  4 +-
 drivers/video/Kconfig                         |  8 ++-
 include/linux/efi.h                           |  9 +--
 12 files changed, 123 insertions(+), 106 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/primary_display.c
 delete mode 100644 drivers/firmware/efi/libstub/screen_info.c

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 1ef38036e8ae..342aca00d42c 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -72,7 +72,7 @@ bool efi_poweroff_required(void)
 		(acpi_gbl_reduced_hardware || acpi_no_s5);
 }
 
-unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
+unsigned long __initdata primary_display_table = EFI_INVALID_TABLE_ADDR;
 
 #if defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON)
 struct sysfb_display_info sysfb_primary_display __section(".data");
@@ -81,16 +81,17 @@ EXPORT_SYMBOL_GPL(sysfb_primary_display);
 
 static void __init init_primary_display(void)
 {
-	if (screen_info_table == EFI_INVALID_TABLE_ADDR) {
-		struct screen_info *si = early_memremap(screen_info_table, sizeof(*si));
+	if (primary_display_table != EFI_INVALID_TABLE_ADDR) {
+		struct sysfb_display_info *dpy =
+			early_memremap(primary_display_table, sizeof(*dpy));
 
-		if (!si) {
-			pr_err("Could not map screen_info config table\n");
+		if (!dpy) {
+			pr_err("Could not map primary_display config table\n");
 			return;
 		}
-		sysfb_primary_display.screen = *si;
-		memset(si, 0, sizeof(*si));
-		early_memunmap(si, sizeof(*si));
+		sysfb_primary_display = *dpy;
+		memset(dpy, 0, sizeof(*dpy));
+		early_memunmap(dpy, sizeof(*dpy));
 	} else {
 		return;
 	}
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index ca697d485116..b22e208a1aae 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -23,7 +23,7 @@
 
 #include <asm/efi.h>
 
-unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
+unsigned long __initdata primary_display_table = EFI_INVALID_TABLE_ADDR;
 
 static int __init is_memory(efi_memory_desc_t *md)
 {
@@ -67,16 +67,17 @@ EXPORT_SYMBOL_GPL(sysfb_primary_display);
 
 static void __init init_primary_display(void)
 {
-	if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
-		struct screen_info *si = early_memremap(screen_info_table, sizeof(*si));
+	if (primary_display_table != EFI_INVALID_TABLE_ADDR) {
+		struct sysfb_display_info *dpy =
+			early_memremap(primary_display_table, sizeof(*dpy));
 
-		if (!si) {
-			pr_err("Could not map screen_info config table\n");
+		if (!dpy) {
+			pr_err("Could not map primary_display config table\n");
 			return;
 		}
-		sysfb_primary_display.screen = *si;
-		memset(si, 0, sizeof(*si));
-		early_memunmap(si, sizeof(*si));
+		sysfb_primary_display = *dpy;
+		memset(dpy, 0, sizeof(*dpy));
+		early_memunmap(dpy, sizeof(*dpy));
 	} else {
 		return;
 	}
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a9070d00b833..955193691f10 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -63,7 +63,7 @@ static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata initrd = EFI_INVALID_TABLE_ADDR;
 
-extern unsigned long screen_info_table;
+extern unsigned long primary_display_table;
 
 struct mm_struct efi_mm = {
 	.mm_mt			= MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
@@ -641,7 +641,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 	{LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID,	&efi.unaccepted,	"Unaccepted"	},
 #endif
 #ifdef CONFIG_EFI_GENERIC_STUB
-	{LINUX_EFI_SCREEN_INFO_TABLE_GUID,	&screen_info_table			},
+	{LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID,	&primary_display_table			},
 #endif
 	{},
 };
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
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index d51777df12d1..f452fac90a9f 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -63,11 +63,13 @@ endif # HAS_IOMEM
 
 config FIRMWARE_EDID
 	bool "Enable firmware EDID"
-	depends on X86
+	depends on EFI || X86
 	help
 	  This enables access to the EDID transferred from the firmware.
-	  On x86, this is from the VESA BIOS. DRM display drivers will
-	  be able to export the information to userspace.
+	  On EFI systems, the EDID comes from the same device as the
+	  primary GOP. On x86 with BIOS, it comes from the VESA BIOS.
+	  DRM display drivers will be able to export the information
+	  to userspace.
 
 	  Also enable this if DDC/I2C transfers do not work for your driver
 	  and if you are using nvidiafb, i810fb or savagefb.
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2a43094e23f7..664898d09ff5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -406,11 +406,12 @@ void efi_native_runtime_setup(void);
 #define EFI_CC_FINAL_EVENTS_TABLE_GUID		EFI_GUID(0xdd4a4648, 0x2de7, 0x4665, 0x96, 0x4d, 0x21, 0xd9, 0xef, 0x5f, 0xb4, 0x46)
 
 /*
- * This GUID is used to pass to the kernel proper the struct screen_info
- * structure that was populated by the stub based on the GOP protocol instance
- * associated with ConOut
+ * This GUIDs are used to pass to the kernel proper the primary
+ * display that has been populated by the stub based on the GOP
+ * instance associated with ConOut.
  */
-#define LINUX_EFI_SCREEN_INFO_TABLE_GUID	EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
+#define LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID	EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
+
 #define LINUX_EFI_ARM_CPU_STATE_TABLE_GUID	EFI_GUID(0xef79e4aa, 0x3c3d, 0x4989,  0xb9, 0x02, 0x07, 0xa9, 0x43, 0xe5, 0x50, 0xd2)
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
-- 
2.51.1


