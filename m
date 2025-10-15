Return-Path: <linux-efi+bounces-5052-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A32BDF91F
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A01B1A2133F
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A99C3375CB;
	Wed, 15 Oct 2025 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z6L7NckZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gd2VZsKQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z6L7NckZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gd2VZsKQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C400D335BC4
	for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544525; cv=none; b=dlI0uq5TmHy9u2Wm1eXtKr5aPJHSmb+3bbaXVRAWapvJ6vf6yOEhFt2Z1nGGArlcVl1uxP13KKlEmh/oJa6QFIvYmCRQ9WY3+KWfn4iMGaicU2FdA+UEYS4l55tgrI9r4XoGVv0819+QM+/UMlYzHBJBekrs3FMzRQpEDYJPHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544525; c=relaxed/simple;
	bh=UB2jO09vewg6cLax49gAv1K4JPh1V+SV/eZpJldJOAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVqwXNmuZ5bocwZq73pA19QGDmYiWNb8ujRPiKkF3Wlf8Zai9djIdkZtkeQsp9KH1ve6n5SgEu/dPax21lTfSz/mfWl+UFIe5OmlT8qjxz+LZj61c5rqTw9mRhxnm3TriYQbYWWpdavPqeOQYK3fGE2S/+3WerGOCVWK8M5+QaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z6L7NckZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gd2VZsKQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z6L7NckZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gd2VZsKQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD76721B16;
	Wed, 15 Oct 2025 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760544502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AGXNzWUcc3Yh+1xeYPxIrxeW/lSX/LwtRBtEZCGcJg=;
	b=z6L7NckZhU/p/ZEWJJjQp6NAEgFyuhlmztjNzRxLQ0J6Pv4tEu1ocnisDKcykdhOiwkc0H
	q7C0LV++Edxgjd357QZbyxU6kcG22nus1JpsEHYXyw0wX3VnmgZi2X7s5UuCQSp86rxKOH
	9Bh5r7wedjUguN0/pnMG1i/BN/rMxxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760544502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AGXNzWUcc3Yh+1xeYPxIrxeW/lSX/LwtRBtEZCGcJg=;
	b=Gd2VZsKQKNRbgeTeCba8SK6AtVyiTIZ6hfR1crausgbsGsCLpGBmy6Aee3aKMnz05/AtHU
	8j5IDi0pWysD3yBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z6L7NckZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gd2VZsKQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760544502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AGXNzWUcc3Yh+1xeYPxIrxeW/lSX/LwtRBtEZCGcJg=;
	b=z6L7NckZhU/p/ZEWJJjQp6NAEgFyuhlmztjNzRxLQ0J6Pv4tEu1ocnisDKcykdhOiwkc0H
	q7C0LV++Edxgjd357QZbyxU6kcG22nus1JpsEHYXyw0wX3VnmgZi2X7s5UuCQSp86rxKOH
	9Bh5r7wedjUguN0/pnMG1i/BN/rMxxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760544502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AGXNzWUcc3Yh+1xeYPxIrxeW/lSX/LwtRBtEZCGcJg=;
	b=Gd2VZsKQKNRbgeTeCba8SK6AtVyiTIZ6hfR1crausgbsGsCLpGBmy6Aee3aKMnz05/AtHU
	8j5IDi0pWysD3yBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AADF013AE4;
	Wed, 15 Oct 2025 16:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gL5IKPbG72inaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 15 Oct 2025 16:08:22 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	jonathan@marek.ca,
	javierm@redhat.com
Cc: linux-efi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/5] efi/libstub: x86: Store EDID in boot_params
Date: Wed, 15 Oct 2025 17:56:34 +0200
Message-ID: <20251015160816.525825-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015160816.525825-1-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DD76721B16
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxjygmbcnsta4qeme9o4pgs8z)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

Retrieve the GOP device's EDID information in the kernel's boot
parameters. Makes the data avaialble to kernel graphics code and
drives, such as efidrm.

With efidrm, the EDID is now also available to user-space compositors
via standard DRM interfaces.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/efi/libstub/x86-stub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index b68dbfd1cb87..8c6ff0b49912 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -388,8 +388,9 @@ static void setup_quirks(struct boot_params *boot_params)
 static void setup_graphics(struct boot_params *boot_params)
 {
 	struct screen_info *si = memset(&boot_params->screen_info, 0, sizeof(*si));
+	struct edid_info *edid = memset(&boot_params->edid_info, 0, sizeof(*edid));
 
-	efi_setup_graphics(si, NULL);
+	efi_setup_graphics(si, edid);
 }
 
 static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
-- 
2.51.0


