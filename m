Return-Path: <linux-efi+bounces-5673-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399FEC81BA0
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 17:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC023AF789
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27C031B131;
	Mon, 24 Nov 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BCy4+1uf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VSFfIL5I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BCy4+1uf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VSFfIL5I"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B331B12D
	for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003131; cv=none; b=hWY1JabbdT8o39ApVTg6gfBRjufiLAaUlnvnD31zVX8j66JfEmPeeEjFofjF47xdY28ELa29RkdKc5g7JGb+qT+C6urqVF6Z5NjHvOmDFl3LL5RYmaWTFbYNn+2TdeYs/1DnKYhg8XZqI7OS0xwGVxjSM9Qt1iFV3kcJ8G8pbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003131; c=relaxed/simple;
	bh=t/wT11mC600svjUMsNAKjDjxrRdx+HmoxstrKKSZNC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4dyk/6vJj43ow9lgcROlW/kMJpEAg0gVdRBn4QMP/GDz0SR9C6P6DOEigGtwzMfAviWxjByCU9Z8Zvf9FW4FHpHBk7D8NMJ0j7SRKVpKJzpsymhULceC0Uq/ocGKjqLUCr/QKDwS7I/lGPd1uv1PyQ7i3uAosF2daAgjSLOB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BCy4+1uf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VSFfIL5I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BCy4+1uf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VSFfIL5I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD4C6221CE;
	Mon, 24 Nov 2025 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q40PbJMg7A3dUZZLVKq6MPnz1PxTO2HWYwqFK0YitdQ=;
	b=BCy4+1ufcI1NkjODbnYhuMAOzcigiwRTmHDqNuxJy3rmU9ByXtpGEEeCJXcJemvR5BFPyI
	UFJuryqur64wIBAXPD0VrNiqpRm4DaourWfHkrh/EvEVeS9VzSMoWb9S6lNWyG+JI3IYaS
	FKN6kLhtnq161eIUh4hqpmPT7lh3o4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q40PbJMg7A3dUZZLVKq6MPnz1PxTO2HWYwqFK0YitdQ=;
	b=VSFfIL5IYfeInDs7imxSPtmf5WKE6avLzawrzpuR/CgvO15yRmLlak1S8j3/GyM1ZpiEwS
	uIt5OkLRe+mDtCCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q40PbJMg7A3dUZZLVKq6MPnz1PxTO2HWYwqFK0YitdQ=;
	b=BCy4+1ufcI1NkjODbnYhuMAOzcigiwRTmHDqNuxJy3rmU9ByXtpGEEeCJXcJemvR5BFPyI
	UFJuryqur64wIBAXPD0VrNiqpRm4DaourWfHkrh/EvEVeS9VzSMoWb9S6lNWyG+JI3IYaS
	FKN6kLhtnq161eIUh4hqpmPT7lh3o4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q40PbJMg7A3dUZZLVKq6MPnz1PxTO2HWYwqFK0YitdQ=;
	b=VSFfIL5IYfeInDs7imxSPtmf5WKE6avLzawrzpuR/CgvO15yRmLlak1S8j3/GyM1ZpiEwS
	uIt5OkLRe+mDtCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 441CC3EA63;
	Mon, 24 Nov 2025 16:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sAVADxCNJGm3GgAAD6G6ig
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
Subject: [PATCH v2 08/10] efi: Support EDID information
Date: Mon, 24 Nov 2025 17:40:20 +0100
Message-ID: <20251124165116.502813-9-tzimmermann@suse.de>
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

Add LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID to the list of config-table
UUIDs. Read sysfb_primary_display from the entry. The UUID has been
generated with uuidgen.

Still support LINUX_EFI_SCREEN_INFO_TABLE_GUID as fallback in case an
older boot loader invokes the kernel.

If CONFIG_FIRMWARE_EDID=n, EDID information is disabled.

Make the Kconfig symbol CONFIG_FIRMWARE_EDID available with EFI. Setting
the value to 'n' disables EDID support.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/loongarch/kernel/efi.c     | 14 +++++++++++++-
 drivers/firmware/efi/efi-init.c | 14 +++++++++++++-
 drivers/firmware/efi/efi.c      |  2 ++
 drivers/video/Kconfig           |  8 +++++---
 include/linux/efi.h             |  8 +++++---
 5 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 1ef38036e8ae..2d90758e5037 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -72,6 +72,7 @@ bool efi_poweroff_required(void)
 		(acpi_gbl_reduced_hardware || acpi_no_s5);
 }
 
+unsigned long __initdata primary_display_table = EFI_INVALID_TABLE_ADDR;
 unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
 
 #if defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON)
@@ -81,7 +82,18 @@ EXPORT_SYMBOL_GPL(sysfb_primary_display);
 
 static void __init init_primary_display(void)
 {
-	if (screen_info_table == EFI_INVALID_TABLE_ADDR) {
+	if (primary_display_table != EFI_INVALID_TABLE_ADDR) {
+		struct sysfb_display_info *dpy =
+			early_memremap(primary_display_table, sizeof(*dpy));
+
+		if (!dpy) {
+			pr_err("Could not map primary_display config table\n");
+			return;
+		}
+		sysfb_primary_display = *dpy;
+		memset(dpy, 0, sizeof(*dpy));
+		early_memunmap(dpy, sizeof(*dpy));
+	} else if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
 		struct screen_info *si = early_memremap(screen_info_table, sizeof(*si));
 
 		if (!si) {
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index ca697d485116..0f167c0e058e 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -23,6 +23,7 @@
 
 #include <asm/efi.h>
 
+unsigned long __initdata primary_display_table = EFI_INVALID_TABLE_ADDR;
 unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
 
 static int __init is_memory(efi_memory_desc_t *md)
@@ -67,7 +68,18 @@ EXPORT_SYMBOL_GPL(sysfb_primary_display);
 
 static void __init init_primary_display(void)
 {
-	if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
+	if (primary_display_table != EFI_INVALID_TABLE_ADDR) {
+		struct sysfb_display_info *dpy =
+			early_memremap(primary_display_table, sizeof(*dpy));
+
+		if (!dpy) {
+			pr_err("Could not map primary_display config table\n");
+			return;
+		}
+		sysfb_primary_display = *dpy;
+		memset(dpy, 0, sizeof(*dpy));
+		early_memunmap(dpy, sizeof(*dpy));
+	} else if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
 		struct screen_info *si = early_memremap(screen_info_table, sizeof(*si));
 
 		if (!si) {
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a9070d00b833..c07f0878a4d6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -63,6 +63,7 @@ static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata initrd = EFI_INVALID_TABLE_ADDR;
 
+extern unsigned long primary_display_table;
 extern unsigned long screen_info_table;
 
 struct mm_struct efi_mm = {
@@ -641,6 +642,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 	{LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID,	&efi.unaccepted,	"Unaccepted"	},
 #endif
 #ifdef CONFIG_EFI_GENERIC_STUB
+	{LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID,	&primary_display_table			},
 	{LINUX_EFI_SCREEN_INFO_TABLE_GUID,	&screen_info_table			},
 #endif
 	{},
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
index 2a43094e23f7..f645bcc66ee2 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -406,11 +406,13 @@ void efi_native_runtime_setup(void);
 #define EFI_CC_FINAL_EVENTS_TABLE_GUID		EFI_GUID(0xdd4a4648, 0x2de7, 0x4665, 0x96, 0x4d, 0x21, 0xd9, 0xef, 0x5f, 0xb4, 0x46)
 
 /*
- * This GUID is used to pass to the kernel proper the struct screen_info
- * structure that was populated by the stub based on the GOP protocol instance
- * associated with ConOut
+ * These GUIDs are used to pass to the kernel proper the info
+ * structures that were populated by the stub based on the GOP
+ * instance associated with ConOut.
  */
+#define LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID	EFI_GUID(0x8700a405, 0xcda4, 0x46d4,  0xb8, 0xc3, 0x04, 0xe5, 0xcd, 0xb4, 0x30, 0x21)
 #define LINUX_EFI_SCREEN_INFO_TABLE_GUID	EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
+
 #define LINUX_EFI_ARM_CPU_STATE_TABLE_GUID	EFI_GUID(0xef79e4aa, 0x3c3d, 0x4989,  0xb9, 0x02, 0x07, 0xa9, 0x43, 0xe5, 0x50, 0xd2)
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
-- 
2.51.1


