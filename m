Return-Path: <linux-efi+bounces-5694-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0766EC8AD95
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 17:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2DC3B7A87
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7499633D6F9;
	Wed, 26 Nov 2025 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DKdVIS/5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sbeogGZA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DKdVIS/5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sbeogGZA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2233C538
	for <linux-efi@vger.kernel.org>; Wed, 26 Nov 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173346; cv=none; b=HLxGQEkTGQ0jsLmU3EKzSj2tL318mKrmTRYk5i3at3uZyZ1dlxmCnOwXqqU0CBvDEwsvRIBwkk31IsLx8BLdAlqzdApvbLInfbJcMWCT/vXG5elWW6lbEU7IK5ZKFbTwljwuTy7QBt3Peu55mu1qct6NK5m3ru4krIeZvkdefQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173346; c=relaxed/simple;
	bh=3WwWbTlIlPj1FcNDjJw2A4/LVrs2vR+KyOMtOBaSlBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mz5EYqOSZdP1WYwg6qI7jfMQpDgKSB/ft0SVaAs/AZHgxrQ2+vCVUgkdPdtSa5XQFx6FDDqgYxw6xnTJdSz1izY9Qnmj/XRcS99peRyVn4PwC5v4E97RASIFl/GQvcNuteCAyOTyc5b9CdRm6oBXxigcmgO9pnnqv/673LY9akI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DKdVIS/5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sbeogGZA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DKdVIS/5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sbeogGZA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62F32336D7;
	Wed, 26 Nov 2025 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764173341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRIf2ShRONaKGm+iQwPVVgZrf+M8pVG5Np77UOpTWeg=;
	b=DKdVIS/5AKTshXzRccAZLyvAbRSNk74MrQQcA+heDuKWh92JgyuFHLJUFTSijL2ZSsK7Lx
	krjGsH1o0rqrAvP9SWKIE66fjy79EnLtF4CJqfYbTTRs/ue0/UPadL6E7xqCfc+9frFwhd
	hT8G/v9ctMbUt0HPhT+2NQaj0NCUvds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764173341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRIf2ShRONaKGm+iQwPVVgZrf+M8pVG5Np77UOpTWeg=;
	b=sbeogGZAkKwluO5rdD4VLhgw5BMWr2NoTSYfdBAeQJ6cmZ2x7PMqeZpN5jJx7xkPVj5l43
	KPSYGd+jX+aesICQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="DKdVIS/5";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sbeogGZA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764173341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRIf2ShRONaKGm+iQwPVVgZrf+M8pVG5Np77UOpTWeg=;
	b=DKdVIS/5AKTshXzRccAZLyvAbRSNk74MrQQcA+heDuKWh92JgyuFHLJUFTSijL2ZSsK7Lx
	krjGsH1o0rqrAvP9SWKIE66fjy79EnLtF4CJqfYbTTRs/ue0/UPadL6E7xqCfc+9frFwhd
	hT8G/v9ctMbUt0HPhT+2NQaj0NCUvds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764173341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRIf2ShRONaKGm+iQwPVVgZrf+M8pVG5Np77UOpTWeg=;
	b=sbeogGZAkKwluO5rdD4VLhgw5BMWr2NoTSYfdBAeQJ6cmZ2x7PMqeZpN5jJx7xkPVj5l43
	KPSYGd+jX+aesICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB4703EA63;
	Wed, 26 Nov 2025 16:09:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YIQ4OBwmJ2lnIgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Nov 2025 16:09:00 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 4/9] sysfb: Replace screen_info with sysfb_primary_display
Date: Wed, 26 Nov 2025 17:03:21 +0100
Message-ID: <20251126160854.553077-5-tzimmermann@suse.de>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtfyjk8sg4x43ngtem9djprcp)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 62F32336D7

Replace the global screen_info with sysfb_primary_display of type
struct sysfb_display_info. Adapt all users of screen_info.

Instances of screen_info are defined for x86, loongarch and EFI,
with only one instance compiled into a specific build. Replace all
of them with sysfb_primary_display.

All existing users of screen_info are updated by pointing them to
sysfb_primary_display.screen instead. This introduces some churn to
the code, but has no impact on functionality.

Boot parameters and EFI config tables are unchanged. They transfer
screen_info as before. The logic in EFI's alloc_screen_info() changes
slightly, as it now returns the screen field of sysfb_primary_display.

v2:
- update comment
- rename init_screen_info() to init_primary_display()

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/
---
 arch/arm64/kernel/image-vars.h                |  2 +-
 arch/loongarch/kernel/efi.c                   | 15 +++++++------
 arch/loongarch/kernel/image-vars.h            |  2 +-
 arch/riscv/kernel/image-vars.h                |  2 +-
 arch/x86/kernel/kexec-bzimage64.c             |  4 +++-
 arch/x86/kernel/setup.c                       | 10 +++++----
 arch/x86/video/video-common.c                 |  4 ++--
 drivers/firmware/efi/earlycon.c               |  8 +++----
 drivers/firmware/efi/efi-init.c               | 22 +++++++++----------
 drivers/firmware/efi/libstub/efi-stub-entry.c | 18 ++++++++++-----
 drivers/firmware/efi/sysfb_efi.c              |  4 ++--
 drivers/firmware/sysfb.c                      |  6 ++---
 drivers/hv/vmbus_drv.c                        |  6 ++---
 drivers/pci/vgaarb.c                          |  4 ++--
 drivers/video/screen_info_pci.c               |  5 +++--
 include/linux/screen_info.h                   |  2 --
 include/linux/sysfb.h                         |  5 +++--
 17 files changed, 66 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 85bc629270bd..d7b0d12b1015 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -38,7 +38,7 @@ PROVIDE(__efistub__end			= _end);
 PROVIDE(__efistub___inittext_end       	= __inittext_end);
 PROVIDE(__efistub__edata		= _edata);
 #if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
-PROVIDE(__efistub_screen_info		= screen_info);
+PROVIDE(__efistub_sysfb_primary_display	= sysfb_primary_display);
 #endif
 PROVIDE(__efistub__ctype		= _ctype);
 
diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 860a3bc030e0..638a392d2cd2 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -18,7 +18,7 @@
 #include <linux/kobject.h>
 #include <linux/memblock.h>
 #include <linux/reboot.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 #include <linux/uaccess.h>
 
 #include <asm/early_ioremap.h>
@@ -75,11 +75,11 @@ bool efi_poweroff_required(void)
 unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
 
 #if defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON)
-struct screen_info screen_info __section(".data");
-EXPORT_SYMBOL_GPL(screen_info);
+struct sysfb_display_info sysfb_primary_display __section(".data");
+EXPORT_SYMBOL_GPL(sysfb_primary_display);
 #endif
 
-static void __init init_screen_info(void)
+static void __init init_primary_display(void)
 {
 	struct screen_info *si;
 
@@ -91,11 +91,12 @@ static void __init init_screen_info(void)
 		pr_err("Could not map screen_info config table\n");
 		return;
 	}
-	screen_info = *si;
+	sysfb_primary_display.screen = *si;
 	memset(si, 0, sizeof(*si));
 	early_memunmap(si, sizeof(*si));
 
-	memblock_reserve(__screen_info_lfb_base(&screen_info), screen_info.lfb_size);
+	memblock_reserve(__screen_info_lfb_base(&sysfb_primary_display.screen),
+			 sysfb_primary_display.screen.lfb_size);
 }
 
 void __init efi_init(void)
@@ -127,7 +128,7 @@ void __init efi_init(void)
 	set_bit(EFI_CONFIG_TABLES, &efi.flags);
 
 	if (IS_ENABLED(CONFIG_EFI_EARLYCON) || IS_ENABLED(CONFIG_SYSFB))
-		init_screen_info();
+		init_primary_display();
 
 	if (boot_memmap == EFI_INVALID_TABLE_ADDR)
 		return;
diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
index 41ddcf56d21c..e557ebd46c2b 100644
--- a/arch/loongarch/kernel/image-vars.h
+++ b/arch/loongarch/kernel/image-vars.h
@@ -12,7 +12,7 @@ __efistub_kernel_entry		= kernel_entry;
 __efistub_kernel_asize		= kernel_asize;
 __efistub_kernel_fsize		= kernel_fsize;
 #if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
-__efistub_screen_info		= screen_info;
+__efistub_sysfb_primary_display	= sysfb_primary_display;
 #endif
 
 #endif
diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index 3df30dd1c458..3bd9d06a8b8f 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -29,7 +29,7 @@ __efistub__end			= _end;
 __efistub__edata		= _edata;
 __efistub___init_text_end	= __init_text_end;
 #if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
-__efistub_screen_info		= screen_info;
+__efistub_sysfb_primary_display	= sysfb_primary_display;
 #endif
 
 #endif
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index c3244ac680d1..7508d0ccc740 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -20,6 +20,7 @@
 #include <linux/of_fdt.h>
 #include <linux/efi.h>
 #include <linux/random.h>
+#include <linux/sysfb.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -303,7 +304,8 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	params->hdr.hardware_subarch = boot_params.hdr.hardware_subarch;
 
 	/* Copying screen_info will do? */
-	memcpy(&params->screen_info, &screen_info, sizeof(struct screen_info));
+	memcpy(&params->screen_info, &sysfb_primary_display.screen,
+	       sizeof(sysfb_primary_display.screen));
 
 	/* Fill in memsize later */
 	params->screen_info.ext_mem_k = 0;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd07a3e1..675e4b9deb1f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -22,6 +22,7 @@
 #include <linux/random.h>
 #include <linux/root_dev.h>
 #include <linux/static_call.h>
+#include <linux/sysfb.h>
 #include <linux/swiotlb.h>
 #include <linux/tboot.h>
 #include <linux/usb/xhci-dbgp.h>
@@ -211,8 +212,9 @@ arch_initcall(init_x86_sysctl);
 /*
  * Setup options
  */
-struct screen_info screen_info;
-EXPORT_SYMBOL(screen_info);
+
+struct sysfb_display_info sysfb_primary_display;
+EXPORT_SYMBOL(sysfb_primary_display);
 #if defined(CONFIG_FIRMWARE_EDID)
 struct edid_info edid_info;
 EXPORT_SYMBOL_GPL(edid_info);
@@ -526,7 +528,7 @@ static void __init parse_setup_data(void)
 static void __init parse_boot_params(void)
 {
 	ROOT_DEV = old_decode_dev(boot_params.hdr.root_dev);
-	screen_info = boot_params.screen_info;
+	sysfb_primary_display.screen = boot_params.screen_info;
 #if defined(CONFIG_FIRMWARE_EDID)
 	edid_info = boot_params.edid_info;
 #endif
@@ -1254,7 +1256,7 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	if (!efi_enabled(EFI_BOOT) || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
-		vgacon_register_screen(&screen_info);
+		vgacon_register_screen(&sysfb_primary_display.screen);
 #endif
 #endif
 	x86_init.oem.banner();
diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
index e0aeee99bc99..152789f00fcd 100644
--- a/arch/x86/video/video-common.c
+++ b/arch/x86/video/video-common.c
@@ -9,7 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 #include <linux/vgaarb.h>
 
 #include <asm/video.h>
@@ -29,7 +29,7 @@ EXPORT_SYMBOL(pgprot_framebuffer);
 bool video_is_primary_device(struct device *dev)
 {
 #ifdef CONFIG_SCREEN_INFO
-	struct screen_info *si = &screen_info;
+	struct screen_info *si = &sysfb_primary_display.screen;
 	struct resource res[SCREEN_INFO_MAX_RESOURCES];
 	ssize_t i, numres;
 #endif
diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index 42e3a173dac1..3d060d59968c 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -9,7 +9,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/serial_core.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 #include <linux/string.h>
 
 #include <asm/early_ioremap.h>
@@ -32,7 +32,7 @@ static void *efi_fb;
  */
 static int __init efi_earlycon_remap_fb(void)
 {
-	const struct screen_info *si = &screen_info;
+	const struct screen_info *si = &sysfb_primary_display.screen;
 
 	/* bail if there is no bootconsole or it was unregistered already */
 	if (!earlycon_console || !console_is_registered(earlycon_console))
@@ -147,7 +147,7 @@ static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h,
 static void
 efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 {
-	const struct screen_info *si = &screen_info;
+	const struct screen_info *si = &sysfb_primary_display.screen;
 	u32 cur_efi_x = efi_x;
 	unsigned int len;
 	const char *s;
@@ -227,7 +227,7 @@ void __init efi_earlycon_reprobe(void)
 static int __init efi_earlycon_setup(struct earlycon_device *device,
 				     const char *opt)
 {
-	const struct screen_info *si = &screen_info;
+	const struct screen_info *si = &sysfb_primary_display.screen;
 	u16 xres, yres;
 	u32 i;
 
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index a65c2d5b9e7b..d1d418a34407 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -19,7 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/platform_device.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 
 #include <asm/efi.h>
 
@@ -57,15 +57,15 @@ static phys_addr_t __init efi_to_phys(unsigned long addr)
 extern __weak const efi_config_table_type_t efi_arch_tables[];
 
 /*
- * x86 defines its own screen_info and uses it even without EFI,
- * everything else can get it from here.
+ * x86 defines its own instance of sysfb_primary_display and uses
+ * it even without EFI, everything else can get them from here.
  */
 #if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON))
-struct screen_info screen_info __section(".data");
-EXPORT_SYMBOL_GPL(screen_info);
+struct sysfb_display_info sysfb_primary_display __section(".data");
+EXPORT_SYMBOL_GPL(sysfb_primary_display);
 #endif
 
-static void __init init_screen_info(void)
+static void __init init_primary_display(void)
 {
 	struct screen_info *si;
 
@@ -75,13 +75,13 @@ static void __init init_screen_info(void)
 			pr_err("Could not map screen_info config table\n");
 			return;
 		}
-		screen_info = *si;
+		sysfb_primary_display.screen = *si;
 		memset(si, 0, sizeof(*si));
 		early_memunmap(si, sizeof(*si));
 
-		if (memblock_is_map_memory(screen_info.lfb_base))
-			memblock_mark_nomap(screen_info.lfb_base,
-					    screen_info.lfb_size);
+		if (memblock_is_map_memory(sysfb_primary_display.screen.lfb_base))
+			memblock_mark_nomap(sysfb_primary_display.screen.lfb_base,
+					    sysfb_primary_display.screen.lfb_size);
 
 		if (IS_ENABLED(CONFIG_EFI_EARLYCON))
 			efi_earlycon_reprobe();
@@ -274,5 +274,5 @@ void __init efi_init(void)
 	if (IS_ENABLED(CONFIG_X86) ||
 	    IS_ENABLED(CONFIG_SYSFB) ||
 	    IS_ENABLED(CONFIG_EFI_EARLYCON))
-		init_screen_info();
+		init_primary_display();
 }
diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
index a6c049835190..401ecbbdf331 100644
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -1,13 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/efi.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 
 #include <asm/efi.h>
 
 #include "efistub.h"
 
-static unsigned long screen_info_offset;
+static unsigned long kernel_image_offset;
+
+static void *kernel_image_addr(void *addr)
+{
+	return addr + kernel_image_offset;
+}
 
 struct screen_info *alloc_screen_info(void)
 {
@@ -16,8 +21,11 @@ struct screen_info *alloc_screen_info(void)
 
 	if (IS_ENABLED(CONFIG_X86) ||
 	    IS_ENABLED(CONFIG_EFI_EARLYCON) ||
-	    IS_ENABLED(CONFIG_SYSFB))
-		return (void *)&screen_info + screen_info_offset;
+	    IS_ENABLED(CONFIG_SYSFB)) {
+		struct sysfb_display_info *dpy = kernel_image_addr(&sysfb_primary_display);
+
+		return &dpy->screen;
+	}
 
 	return NULL;
 }
@@ -73,7 +81,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		return status;
 	}
 
-	screen_info_offset = image_addr - (unsigned long)image->image_base;
+	kernel_image_offset = image_addr - (unsigned long)image->image_base;
 
 	status = efi_stub_common(handle, image, image_addr, cmdline_ptr);
 
diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 8e0f9d08397f..46ad95084b50 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -176,7 +176,7 @@ static int __init efifb_set_system(struct screen_info *si, const struct dmi_syst
 
 static int __init efifb_set_system_callback(const struct dmi_system_id *id)
 {
-	return efifb_set_system(&screen_info, id);
+	return efifb_set_system(&sysfb_primary_display.screen, id);
 }
 
 #define EFIFB_DMI_SYSTEM_ID(vendor, name, enumid)		\
@@ -316,7 +316,7 @@ static struct device_node *find_pci_overlap_node(void)
 		}
 
 		for_each_of_pci_range(&parser, &range)
-			if (efifb_overlaps_pci_range(&screen_info, &range))
+			if (efifb_overlaps_pci_range(&sysfb_primary_display.screen, &range))
 				return np;
 	}
 	return NULL;
diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 916b28538a29..1f671f9219b0 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -66,7 +66,7 @@ static bool sysfb_unregister(void)
  */
 void sysfb_disable(struct device *dev)
 {
-	struct screen_info *si = &screen_info;
+	struct screen_info *si = &sysfb_primary_display.screen;
 	struct device *parent;
 
 	mutex_lock(&disable_lock);
@@ -92,7 +92,7 @@ EXPORT_SYMBOL_GPL(sysfb_disable);
  */
 bool sysfb_handles_screen_info(void)
 {
-	const struct screen_info *si = &screen_info;
+	const struct screen_info *si = &sysfb_primary_display.screen;
 
 	return !!screen_info_video_type(si);
 }
@@ -141,7 +141,7 @@ static struct device *sysfb_parent_dev(const struct screen_info *si)
 
 static __init int sysfb_init(void)
 {
-	struct screen_info *si = &screen_info;
+	struct screen_info *si = &sysfb_primary_display.screen;
 	struct device *parent;
 	unsigned int type;
 	struct simplefb_platform_data mode;
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a53af6fe81a6..9c937190be81 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -29,7 +29,7 @@
 #include <linux/delay.h>
 #include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 #include <linux/efi.h>
 #include <linux/random.h>
 #include <linux/kernel.h>
@@ -2340,8 +2340,8 @@ static void __maybe_unused vmbus_reserve_fb(void)
 	if (efi_enabled(EFI_BOOT)) {
 		/* Gen2 VM: get FB base from EFI framebuffer */
 		if (IS_ENABLED(CONFIG_SYSFB)) {
-			start = screen_info.lfb_base;
-			size = max_t(__u32, screen_info.lfb_size, 0x800000);
+			start = sysfb_primary_display.screen.lfb_base;
+			size = max_t(__u32, sysfb_primary_display.screen.lfb_size, 0x800000);
 		}
 	} else {
 		/* Gen1 VM: get FB base from PCI */
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 436fa7f4c387..805be9ea4a34 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -26,7 +26,7 @@
 #include <linux/poll.h>
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
-#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 #include <linux/vt.h>
 #include <linux/console.h>
 #include <linux/acpi.h>
@@ -557,7 +557,7 @@ EXPORT_SYMBOL(vga_put);
 static bool vga_is_firmware_default(struct pci_dev *pdev)
 {
 #if defined CONFIG_X86
-	return pdev == screen_info_pci_dev(&screen_info);
+	return pdev == screen_info_pci_dev(&sysfb_primary_display.screen);
 #else
 	return false;
 #endif
diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
index 66bfc1d0a6dc..8f34d8a74f09 100644
--- a/drivers/video/screen_info_pci.c
+++ b/drivers/video/screen_info_pci.c
@@ -4,6 +4,7 @@
 #include <linux/printk.h>
 #include <linux/screen_info.h>
 #include <linux/string.h>
+#include <linux/sysfb.h>
 
 static struct pci_dev *screen_info_lfb_pdev;
 static size_t screen_info_lfb_bar;
@@ -26,7 +27,7 @@ static bool __screen_info_relocation_is_valid(const struct screen_info *si, stru
 
 void screen_info_apply_fixups(void)
 {
-	struct screen_info *si = &screen_info;
+	struct screen_info *si = &sysfb_primary_display.screen;
 
 	if (screen_info_lfb_pdev) {
 		struct resource *pr = &screen_info_lfb_pdev->resource[screen_info_lfb_bar];
@@ -75,7 +76,7 @@ static void screen_info_fixup_lfb(struct pci_dev *pdev)
 		.flags = IORESOURCE_MEM,
 	};
 	const struct resource *pr;
-	const struct screen_info *si = &screen_info;
+	const struct screen_info *si = &sysfb_primary_display.screen;
 
 	if (screen_info_lfb_pdev)
 		return; // already found
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
index 1690706206e8..c022403c599a 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -151,6 +151,4 @@ static inline struct pci_dev *screen_info_pci_dev(const struct screen_info *si)
 }
 #endif
 
-extern struct screen_info screen_info;
-
 #endif /* _SCREEN_INFO_H */
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index 8b37247528bf..e8bde392c690 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -8,11 +8,10 @@
  */
 
 #include <linux/err.h>
+#include <linux/platform_data/simplefb.h>
 #include <linux/screen_info.h>
 #include <linux/types.h>
 
-#include <linux/platform_data/simplefb.h>
-
 struct device;
 struct platform_device;
 struct screen_info;
@@ -65,6 +64,8 @@ struct sysfb_display_info {
 	struct screen_info screen;
 };
 
+extern struct sysfb_display_info sysfb_primary_display;
+
 #ifdef CONFIG_SYSFB
 
 void sysfb_disable(struct device *dev);
-- 
2.51.1


