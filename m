Return-Path: <linux-efi+bounces-5699-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83722C8ADED
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73FAE4ECF16
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3988C33FE24;
	Wed, 26 Nov 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YIebGvX6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dF+lI1ok";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QGiJn3kD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dVva07uz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9133F8CF
	for <linux-efi@vger.kernel.org>; Wed, 26 Nov 2025 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173365; cv=none; b=FwZfIUnZcS9O+jA++Msi04sLMSfDmxEvNsGcp04bQgy430Xz9zyR9tdb5tYHshb9kB4YU3Ae6iZ7EjIqhSRoyxh3T0neDnZEPwcT4H/vwwPfg8nJ5H2WnbSam8JWgCww2OguQdHpDsFoYaXl1c+55pUGuPvuAGVgaGWf/2t+PI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173365; c=relaxed/simple;
	bh=14pakZtIwMf+xKgbsWc6zXdEVt3YvxE4efqD8N8oMdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDZsPyloAveIhHCiSc/BM2T2BocheyNhSeoch+i665alncB77dVrZk58qcUaDmpX0Ex1BcNjIvUXg7kHEyT4oOnH42dTXJoWgVCjBMGqeh5fh2QfGU4u7olWGa5jk49WSAsJbo3uDRvEARXTBDNmGBaV1AEuXCyH/ZLtJ4fvpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YIebGvX6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dF+lI1ok; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QGiJn3kD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dVva07uz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEA165BEB2;
	Wed, 26 Nov 2025 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764173341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgp8e/ztEk3SroGbIpTtvMrgmXHBuJDU6cXbgqWVfUM=;
	b=YIebGvX6MVunmhKbKAsNi+PxznaZ+5NUp3zAGhZScxBxELF9R9O/OVfiSeFcMrVt4oYyzc
	PLEvT0/q9Tg4ovZ6aN9p+q+dBAH6COLEF3PAGgCkgyawuYhnfYwaqPXRQaNxt01sFLbZQl
	p0j6zwTzPU6h4wpmKZ4u5ZPF4bxcM6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764173341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgp8e/ztEk3SroGbIpTtvMrgmXHBuJDU6cXbgqWVfUM=;
	b=dF+lI1okdyypxFxWlTgyW+nN+tUZZ7lcoWiV/fIqv5ExoMvUOf5y5UOXDR9M9swylj+kqF
	VqZn1UczVZVG4uBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QGiJn3kD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dVva07uz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764173340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgp8e/ztEk3SroGbIpTtvMrgmXHBuJDU6cXbgqWVfUM=;
	b=QGiJn3kD/FeBxgGWZAJaiznlfqFXD46IMlOmIVJ6sFxJWdTCApBkrTmRMITbEvn9Y9onS0
	WPmKhMPplKRUmBzzz86qW3DtmPOCqqZt/odXRorgfGxlNAYwAAccmK7zAqv0DELSny657N
	d4D6jslbOZc23s5NhS/2WQoV+PmO4fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764173340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgp8e/ztEk3SroGbIpTtvMrgmXHBuJDU6cXbgqWVfUM=;
	b=dVva07uzPe/JQfQSPwGdnPsMHm837ZGVVMBumavAiogRp1Tj1Dp7w9fs4n9FnRhcXitdRh
	aB/RULljezUmTABw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74F8D3EA65;
	Wed, 26 Nov 2025 16:09:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OB0hGxwmJ2lnIgAAD6G6ig
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
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 3/9] sysfb: Add struct sysfb_display_info
Date: Wed, 26 Nov 2025 17:03:20 +0100
Message-ID: <20251126160854.553077-4-tzimmermann@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
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
X-Rspamd-Queue-Id: EEA165BEB2

Add struct sysfb_display_info to wrap display-related state. For now
it contains only the screen's video mode. Later EDID will be added as
well.

This struct will be helpful for passing display state to sysfb drivers
or from the EFI stub library.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/sysfb.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index 8527a50a5290..8b37247528bf 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/screen_info.h>
 #include <linux/types.h>
 
 #include <linux/platform_data/simplefb.h>
@@ -60,6 +61,10 @@ struct efifb_dmi_info {
 	int flags;
 };
 
+struct sysfb_display_info {
+	struct screen_info screen;
+};
+
 #ifdef CONFIG_SYSFB
 
 void sysfb_disable(struct device *dev);
-- 
2.51.1


