Return-Path: <linux-efi+bounces-5669-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57522C81B5E
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 17:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A043AC811
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106AD31A07F;
	Mon, 24 Nov 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZuBlnnBI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LOoAZ9pM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZuBlnnBI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LOoAZ9pM"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69131987E
	for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003109; cv=none; b=jDE+PR23QkYuNvvfQjxDM3SeQQxv2ERPa4jjAgLMKZL4HaulhswpiSfRqwllFKbHIPv4e24VDj5bNqoJUImAQ660FtujzdwjP3Yav0EAi3PzG3TuqjlIiQfGEK1GSs4uKHUfv3H0/gzZgg7UXeIRhivLkUfFV/mI3Z8uYNfjltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003109; c=relaxed/simple;
	bh=CIWnpIXy2b0rOBp4vkPsIt5G3iIH1TZkuRslbfuh9wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iI1JgHBt/OoCNK+rNgNonqWA2f8ZLHzUrcHdz5YuvJ79SyZkSY50xXIxzJuyIJtDgr030F27APL5dDTfpz4ILXDn6i5YWkxlR5p8Buwq/84AMGCGcPCYVUIE8Egl1zGBZrim+PnciJfL5DU8EXdHQGaKPaCdVSREX6NwvvuyVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZuBlnnBI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LOoAZ9pM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZuBlnnBI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LOoAZ9pM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 957765BD02;
	Mon, 24 Nov 2025 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrrbJ3alRtzOMTMhYJrDntjaxvd3iXypW6GUIunVDTk=;
	b=ZuBlnnBI/FPFHvSIg3dvx5YpAZ2e9rlfCP03v1lWv1IGV0TBxVeaOGLnmMuGOUbCVEtLUa
	UxNE+PQbvs2gFLIppcuHEeD14Lx8AaQZGXTrSlVbyVkeLhfw4x8lxU7RiRYr83FFMyyuDr
	hfdDb8r30G+G746mvNOpD1X77Dv7ZOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrrbJ3alRtzOMTMhYJrDntjaxvd3iXypW6GUIunVDTk=;
	b=LOoAZ9pMNSxSfE3mgBgbTl/EXiNdf07OiOXNKducmrvAS4oyglkKv8mdayRIfuDWCPbC1i
	DFoJvSF1Le9CTnCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZuBlnnBI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LOoAZ9pM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrrbJ3alRtzOMTMhYJrDntjaxvd3iXypW6GUIunVDTk=;
	b=ZuBlnnBI/FPFHvSIg3dvx5YpAZ2e9rlfCP03v1lWv1IGV0TBxVeaOGLnmMuGOUbCVEtLUa
	UxNE+PQbvs2gFLIppcuHEeD14Lx8AaQZGXTrSlVbyVkeLhfw4x8lxU7RiRYr83FFMyyuDr
	hfdDb8r30G+G746mvNOpD1X77Dv7ZOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrrbJ3alRtzOMTMhYJrDntjaxvd3iXypW6GUIunVDTk=;
	b=LOoAZ9pMNSxSfE3mgBgbTl/EXiNdf07OiOXNKducmrvAS4oyglkKv8mdayRIfuDWCPbC1i
	DFoJvSF1Le9CTnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32C253EA63;
	Mon, 24 Nov 2025 16:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GHfoChGNJGm3GgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Nov 2025 16:51:29 +0000
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
Subject: [PATCH v2 10/10] efi: libstub: Simplify interfaces for primary_display
Date: Mon, 24 Nov 2025 17:40:22 +0100
Message-ID: <20251124165116.502813-11-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 957765BD02
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtfyjk8sg4x43ngtem9djprcp)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Rename alloc_primary_display() and __alloc_primary_display(), clarify
free semantics to make interfaces easier to understand.

Rename alloc_primary_display() to lookup_primary_display() as it
does not necessarily allocate. Then rename __alloc_primary_display()
to the new alloc_primary_display(). The helper belongs to
free_primary_display), so it should be named without underscores.

The lookup helper does not necessarily allocate, so the output
parameter needs_free to indicate when free should be called. Pass
an argument through the calls to track this state. Put the free
handling into release_primary_display() for simplificy.

Also move the comment fro primary_display.c to efi-stub-entry.c,
where it now describes lookup_primary_display().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/efi/libstub/efi-stub-entry.c | 23 +++++++++++++++++--
 drivers/firmware/efi/libstub/efi-stub.c       | 22 ++++++++++++------
 drivers/firmware/efi/libstub/efistub.h        |  2 +-
 .../firmware/efi/libstub/primary_display.c    | 17 +-------------
 drivers/firmware/efi/libstub/zboot.c          |  6 +++--
 5 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
index aa85e910fe59..3077b51fe0b2 100644
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -14,10 +14,29 @@ static void *kernel_image_addr(void *addr)
 	return addr + kernel_image_offset;
 }
 
-struct sysfb_display_info *alloc_primary_display(void)
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
+struct sysfb_display_info *lookup_primary_display(bool *needs_free)
 {
+	*needs_free = true;
+
 	if (IS_ENABLED(CONFIG_ARM))
-		return __alloc_primary_display();
+		return alloc_primary_display();
+
+	*needs_free = false;
 
 	if (IS_ENABLED(CONFIG_X86) ||
 	    IS_ENABLED(CONFIG_EFI_EARLYCON) ||
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 42d6073bcd06..dc545f62c62b 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -51,14 +51,14 @@ static bool flat_va_mapping = (EFI_RT_VIRTUAL_OFFSET != 0);
 void __weak free_primary_display(struct sysfb_display_info *dpy)
 { }
 
-static struct sysfb_display_info *setup_primary_display(void)
+static struct sysfb_display_info *setup_primary_display(bool *dpy_needs_free)
 {
 	struct sysfb_display_info *dpy;
 	struct screen_info *screen = NULL;
 	struct edid_info *edid = NULL;
 	efi_status_t status;
 
-	dpy = alloc_primary_display();
+	dpy = lookup_primary_display(dpy_needs_free);
 	if (!dpy)
 		return NULL;
 	screen = &dpy->screen;
@@ -68,15 +68,22 @@ static struct sysfb_display_info *setup_primary_display(void)
 
 	status = efi_setup_graphics(screen, edid);
 	if (status != EFI_SUCCESS)
-		goto err_free_primary_display;
+		goto err___free_primary_display;
 
 	return dpy;
 
-err_free_primary_display:
-	free_primary_display(dpy);
+err___free_primary_display:
+	if (*dpy_needs_free)
+		free_primary_display(dpy);
 	return NULL;
 }
 
+static void release_primary_display(struct sysfb_display_info *dpy, bool dpy_needs_free)
+{
+	if (dpy && dpy_needs_free)
+		free_primary_display(dpy);
+}
+
 static void install_memreserve_table(void)
 {
 	struct linux_efi_memreserve *rsv;
@@ -156,13 +163,14 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 			     char *cmdline_ptr)
 {
 	struct sysfb_display_info *dpy;
+	bool dpy_needs_free;
 	efi_status_t status;
 
 	status = check_platform_features();
 	if (status != EFI_SUCCESS)
 		return status;
 
-	dpy = setup_primary_display();
+	dpy = setup_primary_display(&dpy_needs_free);
 
 	efi_retrieve_eventlog();
 
@@ -182,7 +190,7 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 
 	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
 
-	free_primary_display(dpy);
+	release_primary_display(dpy, dpy_needs_free);
 
 	return status;
 }
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 979a21818cc1..1503ffb82903 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1176,8 +1176,8 @@ efi_enable_reset_attack_mitigation(void) { }
 
 void efi_retrieve_eventlog(void);
 
+struct sysfb_display_info *lookup_primary_display(bool *needs_free);
 struct sysfb_display_info *alloc_primary_display(void);
-struct sysfb_display_info *__alloc_primary_display(void);
 void free_primary_display(struct sysfb_display_info *dpy);
 
 void efi_cache_sync_image(unsigned long image_base,
diff --git a/drivers/firmware/efi/libstub/primary_display.c b/drivers/firmware/efi/libstub/primary_display.c
index cdaebab26514..34c54ac1e02a 100644
--- a/drivers/firmware/efi/libstub/primary_display.c
+++ b/drivers/firmware/efi/libstub/primary_display.c
@@ -7,24 +7,9 @@
 
 #include "efistub.h"
 
-/*
- * There are two ways of populating the core kernel's sysfb_primary_display
- * via the stub:
- *
- *   - using a configuration table, which relies on the EFI init code to
- *     locate the table and copy the contents; or
- *
- *   - by linking directly to the core kernel's copy of the global symbol.
- *
- * The latter is preferred because it makes the EFIFB earlycon available very
- * early, but it only works if the EFI stub is part of the core kernel image
- * itself. The zboot decompressor can only use the configuration table
- * approach.
- */
-
 static efi_guid_t primary_display_guid = LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID;
 
-struct sysfb_display_info *__alloc_primary_display(void)
+struct sysfb_display_info *alloc_primary_display(void)
 {
 	struct sysfb_display_info *dpy;
 	efi_status_t status;
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index 4b76f74c56da..c1fd1fdbcb08 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -26,9 +26,11 @@ void __weak efi_cache_sync_image(unsigned long image_base,
 	// executable code loaded into memory to be safe for execution.
 }
 
-struct sysfb_display_info *alloc_primary_display(void)
+struct sysfb_display_info *lookup_primary_display(bool *needs_free)
 {
-	return __alloc_primary_display();
+	*needs_free = true;
+
+	return alloc_primary_display();
 }
 
 asmlinkage efi_status_t __efiapi
-- 
2.51.1


