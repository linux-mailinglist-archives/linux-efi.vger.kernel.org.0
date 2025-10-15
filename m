Return-Path: <linux-efi+bounces-5048-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37506BDF8FE
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 18:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE2634F474A
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 16:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1DB335BB9;
	Wed, 15 Oct 2025 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rviJWD5m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IGcxhY2T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rviJWD5m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IGcxhY2T"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E322FE59F
	for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544506; cv=none; b=UAiLSoMlm4nIcq2/WxhyQ/gCrQYQp+bskmqs+2UnNYmDp2991TTD/IR2PzW+lgQjge9QrjsR6k0WAUdE8pAV97Q2/dALlLdwffY4sBm6aRA92YRnPZBtQMHhYRS85K6wt3eYQK1MoZUUtHXkp8mwADV693UHTcj2XUJj1O6yzwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544506; c=relaxed/simple;
	bh=cyTs8NmGKw2C0HrHEVYxrosP3aG8KyV74Z2pTfrlQs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjAPW+TaY0+2jR2VZVnXD7sah+9pi5EyXz4sDTn8dqv3hCHsnrZ7cTeOvbGti79tr5tUhsteJui3A8CMPHQLYs1qSZ3KyUG497/2fyY0kCkQH9bCAU1L/kKGaKsQsuCgM5zMH7vhonpKjcYCdu7ccTQMOTZHZiaUJuLgjhWc8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rviJWD5m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IGcxhY2T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rviJWD5m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IGcxhY2T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCC16210BC;
	Wed, 15 Oct 2025 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760544501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6HC34ynM7vkAu7jEV4VW5DKYsiWRFE7jXY5VSzf7m0=;
	b=rviJWD5mjmjwJOaz/8D5xuvSt/85uAin+kAd0KZk8xdmrBqcu4klm1Xuixj2x21d2Qjfdj
	BbY47t8Fu2HjH/VnYq5V3zx4qAoO+SGUfydob4rgMA01M3t301PS4VBqHGnZzw6hAvUKbj
	Dd9jH7Q1v3Vug9OnKcoV6t/KQokhZvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760544501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6HC34ynM7vkAu7jEV4VW5DKYsiWRFE7jXY5VSzf7m0=;
	b=IGcxhY2T6nh7g7ZF8TTnHtyvhg18E42Dr/MjuAiDMe5brUQpgwYfInnkUO8SjwO/YSHnUl
	lFBcZ2K/gatHbMAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rviJWD5m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IGcxhY2T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760544501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6HC34ynM7vkAu7jEV4VW5DKYsiWRFE7jXY5VSzf7m0=;
	b=rviJWD5mjmjwJOaz/8D5xuvSt/85uAin+kAd0KZk8xdmrBqcu4klm1Xuixj2x21d2Qjfdj
	BbY47t8Fu2HjH/VnYq5V3zx4qAoO+SGUfydob4rgMA01M3t301PS4VBqHGnZzw6hAvUKbj
	Dd9jH7Q1v3Vug9OnKcoV6t/KQokhZvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760544501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6HC34ynM7vkAu7jEV4VW5DKYsiWRFE7jXY5VSzf7m0=;
	b=IGcxhY2T6nh7g7ZF8TTnHtyvhg18E42Dr/MjuAiDMe5brUQpgwYfInnkUO8SjwO/YSHnUl
	lFBcZ2K/gatHbMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A511D13AE4;
	Wed, 15 Oct 2025 16:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDHkJvXG72inaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 15 Oct 2025 16:08:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	jonathan@marek.ca,
	javierm@redhat.com
Cc: linux-efi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/5] efi: Fix trailing whitespace in header file
Date: Wed, 15 Oct 2025 17:56:30 +0200
Message-ID: <20251015160816.525825-2-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: DCC16210BC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Resolve an issue with the coding style.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index a98cc39e7aaa..544498c89ced 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -290,7 +290,7 @@ typedef efi_status_t efi_get_variable_t (efi_char16_t *name, efi_guid_t *vendor,
 					 unsigned long *data_size, void *data);
 typedef efi_status_t efi_get_next_variable_t (unsigned long *name_size, efi_char16_t *name,
 					      efi_guid_t *vendor);
-typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_t *vendor, 
+typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_t *vendor,
 					 u32 attr, unsigned long data_size,
 					 void *data);
 typedef efi_status_t efi_get_next_high_mono_count_t (u32 *count);
-- 
2.51.0


