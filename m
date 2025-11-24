Return-Path: <linux-efi+bounces-5672-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A39C81B8B
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 17:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4B53AEC55
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9CC3164D8;
	Mon, 24 Nov 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="USTSMD3d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p4ZEFBOZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="USTSMD3d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p4ZEFBOZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0013191A1
	for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003125; cv=none; b=C2muNWbqpa5FdMKcg7sE36mECjM1bvMgW2JmXcwjxAicjVnvnQIklDQnBQ1SaPFj62i6L2/+MpW/zToGjaZka3XJdK0pFgYlZ/5gdGC8QdGweLRSUFBySuSMLhnPQmf6qr9ZSAa71c4BUCP4FaBRUn7iAGzCuHp3hYbqwLqICGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003125; c=relaxed/simple;
	bh=Eu+t7EkpfBsJGFaAM4UiuRZvrZb9/cHj6CiV1dgLItM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4lZVHRU4nXz68QOSy2xnUOmaO7QPfLuaZSK45Fyy0dH3EDZDktEzFiFlxlYu4+cAZw0JObCqqU10+VPyYmM41eUMpkvat7inHJjPH7ehXrylefLMQ2hltBOrTAjj2s0Z1jBi3TMGYu2jC07gbkguk0/enjPzDzABRiGkD8TyyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=USTSMD3d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p4ZEFBOZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=USTSMD3d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p4ZEFBOZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3CBF6221C7;
	Mon, 24 Nov 2025 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fyql6Tx9djnJiYcyVTN9LI7S1hn01itqY+i13dgaIEA=;
	b=USTSMD3di0zWAbvMvh0U0iSxZVNHEKbe74gZb3tLNPXEhDBJzlLLdwBX8iLcN/oVLiQXxU
	jd9FuQi1MULpJJCVAoBRKEjjk/tquFNbqjqeEeccM4WMyjHLm5SE4hEsNtcoEss4PgEj+M
	sTNy2SdOSjzt1XxIOr18frXnjg278wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fyql6Tx9djnJiYcyVTN9LI7S1hn01itqY+i13dgaIEA=;
	b=p4ZEFBOZwasoIGMm1XvU+zqP7yQeyxTaq2CJ6XHD4eB6fM9QWM9yelhH0/VSigYWkkyrtM
	gMKIaq3IJ/9TTRCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=USTSMD3d;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p4ZEFBOZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764003088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fyql6Tx9djnJiYcyVTN9LI7S1hn01itqY+i13dgaIEA=;
	b=USTSMD3di0zWAbvMvh0U0iSxZVNHEKbe74gZb3tLNPXEhDBJzlLLdwBX8iLcN/oVLiQXxU
	jd9FuQi1MULpJJCVAoBRKEjjk/tquFNbqjqeEeccM4WMyjHLm5SE4hEsNtcoEss4PgEj+M
	sTNy2SdOSjzt1XxIOr18frXnjg278wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764003088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fyql6Tx9djnJiYcyVTN9LI7S1hn01itqY+i13dgaIEA=;
	b=p4ZEFBOZwasoIGMm1XvU+zqP7yQeyxTaq2CJ6XHD4eB6fM9QWM9yelhH0/VSigYWkkyrtM
	gMKIaq3IJ/9TTRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C70613EA65;
	Mon, 24 Nov 2025 16:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gKYiLw+NJGm3GgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Nov 2025 16:51:27 +0000
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
Subject: [PATCH v2 07/10] efi: Refactor init_primary_display() helpers
Date: Mon, 24 Nov 2025 17:40:19 +0100
Message-ID: <20251124165116.502813-8-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3CBF6221C7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

Rework the kernel's init_primary_display() helpers to allow for later
support of additional config-table entries and EDID information. No
functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/loongarch/kernel/efi.c     | 22 +++++++++++-----------
 drivers/firmware/efi/efi-init.c | 19 ++++++++++---------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 638a392d2cd2..1ef38036e8ae 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -81,19 +81,19 @@ EXPORT_SYMBOL_GPL(sysfb_primary_display);
 
 static void __init init_primary_display(void)
 {
-	struct screen_info *si;
-
-	if (screen_info_table == EFI_INVALID_TABLE_ADDR)
-		return;
-
-	si = early_memremap(screen_info_table, sizeof(*si));
-	if (!si) {
-		pr_err("Could not map screen_info config table\n");
+	if (screen_info_table == EFI_INVALID_TABLE_ADDR) {
+		struct screen_info *si = early_memremap(screen_info_table, sizeof(*si));
+
+		if (!si) {
+			pr_err("Could not map screen_info config table\n");
+			return;
+		}
+		sysfb_primary_display.screen = *si;
+		memset(si, 0, sizeof(*si));
+		early_memunmap(si, sizeof(*si));
+	} else {
 		return;
 	}
-	sysfb_primary_display.screen = *si;
-	memset(si, 0, sizeof(*si));
-	early_memunmap(si, sizeof(*si));
 
 	memblock_reserve(__screen_info_lfb_base(&sysfb_primary_display.screen),
 			 sysfb_primary_display.screen.lfb_size);
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index d1d418a34407..ca697d485116 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -67,10 +67,9 @@ EXPORT_SYMBOL_GPL(sysfb_primary_display);
 
 static void __init init_primary_display(void)
 {
-	struct screen_info *si;
-
 	if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
-		si = early_memremap(screen_info_table, sizeof(*si));
+		struct screen_info *si = early_memremap(screen_info_table, sizeof(*si));
+
 		if (!si) {
 			pr_err("Could not map screen_info config table\n");
 			return;
@@ -78,14 +77,16 @@ static void __init init_primary_display(void)
 		sysfb_primary_display.screen = *si;
 		memset(si, 0, sizeof(*si));
 		early_memunmap(si, sizeof(*si));
+	} else {
+		return;
+	}
 
-		if (memblock_is_map_memory(sysfb_primary_display.screen.lfb_base))
-			memblock_mark_nomap(sysfb_primary_display.screen.lfb_base,
-					    sysfb_primary_display.screen.lfb_size);
+	if (memblock_is_map_memory(sysfb_primary_display.screen.lfb_base))
+		memblock_mark_nomap(sysfb_primary_display.screen.lfb_base,
+				    sysfb_primary_display.screen.lfb_size);
 
-		if (IS_ENABLED(CONFIG_EFI_EARLYCON))
-			efi_earlycon_reprobe();
-	}
+	if (IS_ENABLED(CONFIG_EFI_EARLYCON))
+		efi_earlycon_reprobe();
 }
 
 static int __init uefi_init(u64 efi_system_table)
-- 
2.51.1


