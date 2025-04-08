Return-Path: <linux-efi+bounces-3230-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8C8A7F951
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 11:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FF71892EC9
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD5264A9D;
	Tue,  8 Apr 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AlfGEawZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JDqy/Ac4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AlfGEawZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JDqy/Ac4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E702641C7
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104142; cv=none; b=YKlh9dJRToa4ScxhJgJr5dLQUGu0n+7SfV0FInbv6eBRMYiSbHgZ7d+AM/AsOdX74NJYS4Y7YFVqnQnY+0eBBfcg70+GMFpLdG8yqtowAXdoUyExCuG9MH0Y7O7yLYqwqlFdv2ratn8u3WB9KMtPjsBvpxzvRYBBRyqcs47uxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104142; c=relaxed/simple;
	bh=cAKtXc8sOgbu2TgBzAsp5eUs0aT1jGtzJCquJr8KXns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLjNcZOV8Bz0YE8HG4xwCsGX/5OQAR6nTdCV7aqmsWgwpWPWjttiuMFH0azg/cbKjB3klLTr353awXWMiiCZyqNj2BRMrLECHduyKoPg8sqVdx6FefRoIq8RB61s2cpsXr7Zg7+eSwTlV6z49immjpy9wJXDlS6RFpjXQv6s7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AlfGEawZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JDqy/Ac4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AlfGEawZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JDqy/Ac4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12AC021197;
	Tue,  8 Apr 2025 09:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744104133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93kpx/ZGI++2csJBmSbKAqr+tGDBQ3bZFA8m8yj33TE=;
	b=AlfGEawZvbP3ewqqemExCQ7PNOSaaeT3hOBzDjQFDUxrJqQtsrTBSqxnBP9CqkmDE2ZMGJ
	KDu/xS6kha6I4ofRtcBT6CCrc0b1197B7I0C2WKWpNz2nO2QaDKlUeF0Nrytq5wpnoRdZ2
	9Ki0Zra9I7fa0LRTZFAiq1RivAzXi6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744104133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93kpx/ZGI++2csJBmSbKAqr+tGDBQ3bZFA8m8yj33TE=;
	b=JDqy/Ac4oZcPSojQ3EDtFcKIaM5U1Lfo1TDLCNyY9loJI+T73/b72OUK3HNt+mvm6FsLXb
	IfeLdiVDb3ub3pBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AlfGEawZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="JDqy/Ac4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744104133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93kpx/ZGI++2csJBmSbKAqr+tGDBQ3bZFA8m8yj33TE=;
	b=AlfGEawZvbP3ewqqemExCQ7PNOSaaeT3hOBzDjQFDUxrJqQtsrTBSqxnBP9CqkmDE2ZMGJ
	KDu/xS6kha6I4ofRtcBT6CCrc0b1197B7I0C2WKWpNz2nO2QaDKlUeF0Nrytq5wpnoRdZ2
	9Ki0Zra9I7fa0LRTZFAiq1RivAzXi6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744104133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93kpx/ZGI++2csJBmSbKAqr+tGDBQ3bZFA8m8yj33TE=;
	b=JDqy/Ac4oZcPSojQ3EDtFcKIaM5U1Lfo1TDLCNyY9loJI+T73/b72OUK3HNt+mvm6FsLXb
	IfeLdiVDb3ub3pBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC76513A84;
	Tue,  8 Apr 2025 09:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ID6tMMTq9Gf2YgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 08 Apr 2025 09:22:12 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	javierm@redhat.com,
	linux-efi@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/2] drm/sysfb: efidrm: Support module builds
Date: Tue,  8 Apr 2025 11:17:05 +0200
Message-ID: <20250408091837.407401-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408091837.407401-1-tzimmermann@suse.de>
References: <20250408091837.407401-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12AC021197
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Make CONFIG_DRM_EFIDRM a tristate to enable module builds.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/sysfb/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/Kconfig b/drivers/gpu/drm/sysfb/Kconfig
index 5ac71d5ff8edf..9c9884c7efc6c 100644
--- a/drivers/gpu/drm/sysfb/Kconfig
+++ b/drivers/gpu/drm/sysfb/Kconfig
@@ -8,8 +8,8 @@ config DRM_SYSFB_HELPER
 	depends on DRM
 
 config DRM_EFIDRM
-	bool "EFI framebuffer driver"
-	depends on (DRM=y) && MMU && EFI && (!SYSFB_SIMPLEFB || COMPILE_TEST)
+	tristate "EFI framebuffer driver"
+	depends on DRM && MMU && EFI && (!SYSFB_SIMPLEFB || COMPILE_TEST)
 	select APERTURE_HELPERS
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
-- 
2.49.0


