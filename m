Return-Path: <linux-efi+bounces-3228-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EA9A7F94C
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 11:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2000B3A2D6B
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 09:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3FB264A8C;
	Tue,  8 Apr 2025 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YWfAk01K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fHA8B0n+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YWfAk01K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fHA8B0n+"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD962641C7
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104136; cv=none; b=p5OM73sHyhtJlycj7TCfcyxG86xKIyT5fpno8rJCsBOG6NE/mBNeU4S5xYddvg92uXYL7HwVJKdDjiU4lOm4D9fcqiGrM7v1qnZpaYIMM4Rsd0QzT/0/3V8ccc6O/uzmuAslUzaxxtdtX5dK7OSyASqLBiBsyCGcnkIpX1HrEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104136; c=relaxed/simple;
	bh=xK6GP/2zFL76o5bNapO3g4n+Paip8Hf8gO183FcCBfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4z2CZyLLtfwvfyCDdBMMCAdoYD9sQh7HXuub12y6K5JOAkhjbxJxty8v02oKb+lrNB2aG0rdPQ3I38/7OZ4Jx40522g/msGNyiOUpi2f0KstwksVC0Ks132A/p6Xx91KJaXNOudKeR9KMdyOnQhHYUPheBuB/ilSvgMiPPVLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YWfAk01K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fHA8B0n+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YWfAk01K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fHA8B0n+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 955E421193;
	Tue,  8 Apr 2025 09:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744104132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eXUWYOngjVNirHR8qiPBC2izVuooBo+1CpyPJkcFs+k=;
	b=YWfAk01K2jf+aC/IAdiXNA3PkEPfucUGyzYT7T/TKT1EWF5WU9mpPjzI6Doh/HKLjc+yxR
	7DtcHtoYlpZtGB7Ln1ztnfwN6Pb1RLFoTtYzkZ2MnZ7fxq3NhfmyqbdkpyI2OTRNfDZGO6
	FAnw8ikmxSfeZzWRCnqs7MqZwxZoCYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744104132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eXUWYOngjVNirHR8qiPBC2izVuooBo+1CpyPJkcFs+k=;
	b=fHA8B0n+CdXop8lYLCAdPFAK5HhVFd8ELirxCkxh/C+1WLCV0j8LovUjicxYNtiHWleQpO
	mFsKr0F1NvCEdhDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YWfAk01K;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fHA8B0n+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744104132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eXUWYOngjVNirHR8qiPBC2izVuooBo+1CpyPJkcFs+k=;
	b=YWfAk01K2jf+aC/IAdiXNA3PkEPfucUGyzYT7T/TKT1EWF5WU9mpPjzI6Doh/HKLjc+yxR
	7DtcHtoYlpZtGB7Ln1ztnfwN6Pb1RLFoTtYzkZ2MnZ7fxq3NhfmyqbdkpyI2OTRNfDZGO6
	FAnw8ikmxSfeZzWRCnqs7MqZwxZoCYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744104132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eXUWYOngjVNirHR8qiPBC2izVuooBo+1CpyPJkcFs+k=;
	b=fHA8B0n+CdXop8lYLCAdPFAK5HhVFd8ELirxCkxh/C+1WLCV0j8LovUjicxYNtiHWleQpO
	mFsKr0F1NvCEdhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5189513691;
	Tue,  8 Apr 2025 09:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gnFuEsTq9Gf2YgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 08 Apr 2025 09:22:12 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	javierm@redhat.com,
	linux-efi@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] drm,efi: Export efi_mem_desc_lookup for efidrm
Date: Tue,  8 Apr 2025 11:17:03 +0200
Message-ID: <20250408091837.407401-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 955E421193
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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

Efidrm invokes efi_mem_desc_lookup(). Export the symbol to enable
module builds of efidrm.

Thomas Zimmermann (2):
  efi: Export symbol efi_mem_desc_lookup
  drm/sysfb: efidrm: Support module builds

 drivers/firmware/efi/efi.c    | 1 +
 drivers/gpu/drm/sysfb/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.49.0


