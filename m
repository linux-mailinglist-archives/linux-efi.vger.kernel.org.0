Return-Path: <linux-efi+bounces-5629-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD70C7A128
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 15:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C3ABF2E9EF
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D7C34D38B;
	Fri, 21 Nov 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iMKPWBQ2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Abyw+g0j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iMKPWBQ2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Abyw+g0j"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4325347BBE
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733395; cv=none; b=uX+LBB0iQlGI10ySH3Ws6mH26iKQ+zVrqivt2eUx2OmYV1PmEj3ylXURL36XeWzy+D1FT+nmdBP03Qu2/MEWzdNHzKKABcTpM8y1SQVZVFtLQNPTxlgFS0ZFpyRz53nsDXKa/3dViDcjYRN56RzHHCJZpP75bExefg9pTQHMDfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733395; c=relaxed/simple;
	bh=xym5R5yEVSDL4/KM5LMgvvTEfCR+Kft6Tnj1uH1q3FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gETERCZ0Oh2ViOjnkMRwRdoeSH/nO6Fq+HaDDYSkvu+X6IG6djBmY4RCqSrlH3kN39CPLW64TJd7pUoVsxXdVawhZg9G7BEBZWRehqrAhwITVJh1ZCa79moeGHi5oMKaGI4g7GzT6HVnqlRILWROm1GXgu81KbrHQ90ye5m7E4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iMKPWBQ2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Abyw+g0j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iMKPWBQ2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Abyw+g0j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28247218EA;
	Fri, 21 Nov 2025 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2fy6AJV5/LJmpRrj1RphVCyLdSqiM/Tki+XKx37wkHU=;
	b=iMKPWBQ2/YHLmQOMzgxyhZgL0qVKiRCtXOcpIhrGmp/kgyxlmA98lsYRipa9vkpslgCdGp
	KdwVujc9na0fwt4t97s6rd4OfBWKtXmh/kRfine8gwUkvhtdVbu9uNgzcGm9EhYGSdMrV1
	YEibxSNMD8K3yNpaFCBYQBYvBRpv3Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2fy6AJV5/LJmpRrj1RphVCyLdSqiM/Tki+XKx37wkHU=;
	b=Abyw+g0jyRAdyZfxtFfsshAV0j5bGUOXfi7JyQENaF5nTh7i2CQVizKVX7OXJuuSarUXYD
	zmJth7/Q/teZsWBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iMKPWBQ2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Abyw+g0j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2fy6AJV5/LJmpRrj1RphVCyLdSqiM/Tki+XKx37wkHU=;
	b=iMKPWBQ2/YHLmQOMzgxyhZgL0qVKiRCtXOcpIhrGmp/kgyxlmA98lsYRipa9vkpslgCdGp
	KdwVujc9na0fwt4t97s6rd4OfBWKtXmh/kRfine8gwUkvhtdVbu9uNgzcGm9EhYGSdMrV1
	YEibxSNMD8K3yNpaFCBYQBYvBRpv3Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2fy6AJV5/LJmpRrj1RphVCyLdSqiM/Tki+XKx37wkHU=;
	b=Abyw+g0jyRAdyZfxtFfsshAV0j5bGUOXfi7JyQENaF5nTh7i2CQVizKVX7OXJuuSarUXYD
	zmJth7/Q/teZsWBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B94E83EA61;
	Fri, 21 Nov 2025 13:56:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TzTPK45vIGkqdQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 21 Nov 2025 13:56:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	javierm@redhat.com,
	arnd@arndb.de
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
Subject: [PATCH 0/6] arch,sysfb: Move screen and edid info into single place
Date: Fri, 21 Nov 2025 14:36:04 +0100
Message-ID: <20251121135624.494768-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 28247218EA
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

Replace screen_info and edid_info with sysfb_primary_device of type
struct sysfb_display_info. Update all users.

Sysfb DRM drivers currently fetch the global edid_info directly, when
they should get that information together with the screen_info from their
device. Wrapping screen_info and edid_info in sysfb_primary_display and
passing this to drivers enables this.

Replacing both with sysfb_primary_display has been motivate by the EFI
stub. EFI wants to transfer EDID via config table in a single entry.
Using struct sysfb_display_info this will become easily possible. Hence
accept some churn in architecture code for the long-term improvements.

Patches 1 and 2 reduce the exposure of screen_info in EFI-related code.

Patch 3 adds struct sysfb_display_info.

Patch 4 replaces scren_info with sysfb_primary_display. This results in
several changes throught the kernel, but is really just a refactoring.

Patch 5 updates sysfb to transfer sysfb_primary_display to the related
drivers.

Patch 6 moves edid_info into sysfb_primary_display. This resolves some
drivers' reference to the global edid_info, but also makes the EDID data
available on non-x86 architectures.

The short-term benefit of this series is in patches 5 and 6. With
sysfb_primary_display in place a follow-up series will improve EFI support
for EDID as outlined in the series at [1] and [2].

[1] https://lore.kernel.org/dri-devel/20251015160816.525825-1-tzimmermann@suse.de/
[2] https://lore.kernel.org/linux-efi/20251119123011.1187249-5-ardb+git@google.com/

Thomas Zimmermann (6):
  efi: earlycon: Reduce number of references to global screen_info
  efi: sysfb_efi: Reduce number of references to global screen_info
  sysfb: Add struct sysfb_display_info
  sysfb: Replace screen_info with sysfb_primary_display
  sysfb: Pass sysfb_primary_display to devices
  sysfb: Move edid_info into sysfb_primary_display

 arch/arm64/kernel/image-vars.h                |  2 +-
 arch/loongarch/kernel/efi.c                   | 11 +--
 arch/loongarch/kernel/image-vars.h            |  2 +-
 arch/riscv/kernel/image-vars.h                |  2 +-
 arch/x86/kernel/kexec-bzimage64.c             |  4 +-
 arch/x86/kernel/setup.c                       | 16 ++--
 arch/x86/video/video-common.c                 |  4 +-
 drivers/firmware/efi/earlycon.c               | 42 +++++-----
 drivers/firmware/efi/efi-init.c               | 14 ++--
 drivers/firmware/efi/libstub/efi-stub-entry.c | 18 +++--
 drivers/firmware/efi/sysfb_efi.c              | 81 ++++++++++---------
 drivers/firmware/sysfb.c                      | 13 +--
 drivers/firmware/sysfb_simplefb.c             |  2 +-
 drivers/gpu/drm/sysfb/efidrm.c                | 14 ++--
 drivers/gpu/drm/sysfb/vesadrm.c               | 14 ++--
 drivers/hv/vmbus_drv.c                        |  6 +-
 drivers/pci/vgaarb.c                          |  4 +-
 drivers/video/Kconfig                         |  1 -
 drivers/video/fbdev/core/fbmon.c              |  8 +-
 drivers/video/fbdev/efifb.c                   | 10 ++-
 drivers/video/fbdev/vesafb.c                  | 10 ++-
 drivers/video/fbdev/vga16fb.c                 |  8 +-
 drivers/video/screen_info_pci.c               |  5 +-
 include/linux/screen_info.h                   |  2 -
 include/linux/sysfb.h                         | 23 ++++--
 include/video/edid.h                          |  4 -
 26 files changed, 177 insertions(+), 143 deletions(-)


base-commit: 57e807d4454add8b60e8807ad1cf812141f34cdb
-- 
2.51.1


