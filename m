Return-Path: <linux-efi+bounces-3229-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E30A7F94E
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 11:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EF11892DC9
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 09:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685B264A97;
	Tue,  8 Apr 2025 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZAIa0Pwd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q2Fl7x5p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZAIa0Pwd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q2Fl7x5p"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1B264A99
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104136; cv=none; b=WrjpV0Y6TL7VztS4rJ8Ug6AkxgheugVFoe5rt2gLfwQGXSG5v+n7Y8k9+FVWKVoC8mkMyOl/SV235/G1SuYHPxHPaB8hrK39jfGqQ+GTjCAIp2O+mJ78oAEePzU//ei3RKHSeR7GsUi0dU3cXp1vbRy1dnW0j2/vAc/3eG/WaAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104136; c=relaxed/simple;
	bh=xn3/gw9Fw0pnx9kfI62DNSn6ORKGNUe6sdO9CtvRSD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIY0L0A4ZYMrgIed3AfjcYkbQlL/VkFipekfCxvN7V5g/J7avMMpX0mSSUA1NiVAhMAeInpvkjJG2l8I/oLg7pZZQ84EPG/VU7yrEZDw2A1TbofbqjKkdEMMvlMKZnis8uQMpd+4T+j7mrYt/bgmr8lc35g8XbQ2sfCJkjZOmMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZAIa0Pwd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q2Fl7x5p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZAIa0Pwd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q2Fl7x5p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C98F91F38E;
	Tue,  8 Apr 2025 09:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744104132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBiOrKmQ9pPCpIu9/vbRegRSviNMRIR6x2GYG+7EEis=;
	b=ZAIa0Pwd86LZz9f1jl4Xc1C1J5EfPa+3DbPHZYGHAWx8cKTqAm+dzDOf2/5RGlirRqzKFk
	eCEbfZ5qiRM9kAU4dK6KphXLValvadKt35mYinLRmiMZOKWaGSj1ovqJXdyxuKtZj/5pHu
	vSP0sn7quQHqK/9kIDkXb6Fq4lPcSWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744104132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBiOrKmQ9pPCpIu9/vbRegRSviNMRIR6x2GYG+7EEis=;
	b=Q2Fl7x5pqT6+TqiCNHdOAzDcBIwHLk/d2lCAjUFiKo+MyEx9JSBGp9clffNj1smKl6uBJV
	aa+X9fK77DU1/aCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744104132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBiOrKmQ9pPCpIu9/vbRegRSviNMRIR6x2GYG+7EEis=;
	b=ZAIa0Pwd86LZz9f1jl4Xc1C1J5EfPa+3DbPHZYGHAWx8cKTqAm+dzDOf2/5RGlirRqzKFk
	eCEbfZ5qiRM9kAU4dK6KphXLValvadKt35mYinLRmiMZOKWaGSj1ovqJXdyxuKtZj/5pHu
	vSP0sn7quQHqK/9kIDkXb6Fq4lPcSWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744104132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBiOrKmQ9pPCpIu9/vbRegRSviNMRIR6x2GYG+7EEis=;
	b=Q2Fl7x5pqT6+TqiCNHdOAzDcBIwHLk/d2lCAjUFiKo+MyEx9JSBGp9clffNj1smKl6uBJV
	aa+X9fK77DU1/aCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90F4413A80;
	Tue,  8 Apr 2025 09:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UEcZIsTq9Gf2YgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 08 Apr 2025 09:22:12 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	javierm@redhat.com,
	linux-efi@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] efi: Export symbol efi_mem_desc_lookup
Date: Tue,  8 Apr 2025 11:17:04 +0200
Message-ID: <20250408091837.407401-2-tzimmermann@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Building efidrm as module requires efi_mem_desc_lookup(). Export
the symbol.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/efi/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7309394b8fc98..e57bff702b5f4 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -558,6 +558,7 @@ int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 
 extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 	__weak __alias(__efi_mem_desc_lookup);
+EXPORT_SYMBOL_GPL(efi_mem_desc_lookup);
 
 /*
  * Calculate the highest address of an efi memory descriptor.
-- 
2.49.0


