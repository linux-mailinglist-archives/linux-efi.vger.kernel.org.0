Return-Path: <linux-efi+bounces-5049-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F56BDF90A
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 18:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A2AC355C65
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4947335BDE;
	Wed, 15 Oct 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hqo147/p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2F3VxCDC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hqo147/p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2F3VxCDC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A75335BDF
	for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544512; cv=none; b=rfaOk4acVIyy3SH14zgjR5gIHUytrdgix/C1YVH/Jfi4h89Vr743LOiTZBEUjZCczOjMsoQJeicyh6oiyeSe6/lGJZlO7j7eG5qPdU8xtiKz2zFnLh8O3Lj/aWuI1AfH7blkR+OtywKOwGv7JCHjUCbZ61UXV6XPm1exnrulxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544512; c=relaxed/simple;
	bh=vuRKO/cugdJISeHatmOkDyu6JqwV6pkCpQczWDEm6P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUECMXaoa8e9/s7YNxuQHS2iZ3v3r2iBcJLFXd8uRk8afUZtnMNpCOHxN6mUxyJW6W+clVv+/o3eND76izzlX1efjEOvGyCGc+yQ8tG6/ZLkxCy0nmwQ+TU/05oylvRfvGvCwO5F8DgSKHJY51OKLcbkcRVQBRCwqO/rclCZOzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hqo147/p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2F3VxCDC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hqo147/p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2F3VxCDC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24928210BD;
	Wed, 15 Oct 2025 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760544502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9o6wbaGBzG+1WYts7/O+R79Vl4+tBO2OwLz1IXi4EM=;
	b=Hqo147/pGWeC14HMFrWF5ewq9M+xmzKxspSuUhzL0YJDkLSnmDmzbdclBEF5FDkBkr4CnS
	VqfRXwCU061wkZARWza8PcOFazfXB8Ru1Es7mKWwLOwYb1iwb/vccbuG0YGYYpx9PzdRAl
	RBck3VUzhIXFEEYi1lt/B/KpEBK6/kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760544502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9o6wbaGBzG+1WYts7/O+R79Vl4+tBO2OwLz1IXi4EM=;
	b=2F3VxCDCzbCzVlCNIT9W1z5Kkquhptt/Qw4Sztiy45ccUSycFlKC5haHM9gH4upP2aoyg8
	zWPZIfY0rELOpaBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Hqo147/p";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2F3VxCDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760544502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9o6wbaGBzG+1WYts7/O+R79Vl4+tBO2OwLz1IXi4EM=;
	b=Hqo147/pGWeC14HMFrWF5ewq9M+xmzKxspSuUhzL0YJDkLSnmDmzbdclBEF5FDkBkr4CnS
	VqfRXwCU061wkZARWza8PcOFazfXB8Ru1Es7mKWwLOwYb1iwb/vccbuG0YGYYpx9PzdRAl
	RBck3VUzhIXFEEYi1lt/B/KpEBK6/kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760544502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9o6wbaGBzG+1WYts7/O+R79Vl4+tBO2OwLz1IXi4EM=;
	b=2F3VxCDCzbCzVlCNIT9W1z5Kkquhptt/Qw4Sztiy45ccUSycFlKC5haHM9gH4upP2aoyg8
	zWPZIfY0rELOpaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E38DB13A42;
	Wed, 15 Oct 2025 16:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kGlcNvXG72inaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 15 Oct 2025 16:08:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	jonathan@marek.ca,
	javierm@redhat.com
Cc: linux-efi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/5] efi/libstub: gop: Find GOP handle instead of GOP data
Date: Wed, 15 Oct 2025 17:56:31 +0200
Message-ID: <20251015160816.525825-3-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 24928210BD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

The device handle of the GOP device is required to retrieve the
correct EDID data. Find the handle instead of the GOP data. Still
return the GOP data in the function arguments, as we already looked
it up.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/efi/libstub/gop.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 3785fb4986b4..fd32be8dd146 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -402,12 +402,13 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 	}
 }
 
-static efi_graphics_output_protocol_t *find_gop(unsigned long num,
-						const efi_handle_t handles[])
+static efi_handle_t find_handle_with_primary_gop(unsigned long num, const efi_handle_t handles[],
+						 efi_graphics_output_protocol_t **found_gop)
 {
 	efi_graphics_output_protocol_t *first_gop;
-	efi_handle_t h;
+	efi_handle_t h, first_gop_handle;
 
+	first_gop_handle = NULL;
 	first_gop = NULL;
 
 	for_each_efi_handle(h, handles, num) {
@@ -442,19 +443,25 @@ static efi_graphics_output_protocol_t *find_gop(unsigned long num,
 		 */
 		status = efi_bs_call(handle_protocol, h,
 				     &EFI_CONSOLE_OUT_DEVICE_GUID, &dummy);
-		if (status == EFI_SUCCESS)
-			return gop;
-
-		if (!first_gop)
+		if (status == EFI_SUCCESS) {
+			if (found_gop)
+				*found_gop = gop;
+			return h;
+		} else if (!first_gop_handle) {
+			first_gop_handle = h;
 			first_gop = gop;
+		}
 	}
 
-	return first_gop;
+	if (found_gop)
+		*found_gop = first_gop;
+	return first_gop_handle;
 }
 
 efi_status_t efi_setup_gop(struct screen_info *si)
 {
 	efi_handle_t *handles __free(efi_pool) = NULL;
+	efi_handle_t handle;
 	efi_graphics_output_protocol_mode_t *mode;
 	efi_graphics_output_mode_info_t *info;
 	efi_graphics_output_protocol_t *gop;
@@ -467,8 +474,8 @@ efi_status_t efi_setup_gop(struct screen_info *si)
 	if (status != EFI_SUCCESS)
 		return status;
 
-	gop = find_gop(num, handles);
-	if (!gop)
+	handle = find_handle_with_primary_gop(num, handles, &gop);
+	if (!handle)
 		return EFI_NOT_FOUND;
 
 	/* Change mode if requested */
-- 
2.51.0


