Return-Path: <linux-efi+bounces-5693-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51882C8AD8C
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 17:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FFD3B2B7B
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA630BB96;
	Wed, 26 Nov 2025 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ezr4vDnI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4GbyUUUq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ezr4vDnI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4GbyUUUq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9033CEB9
	for <linux-efi@vger.kernel.org>; Wed, 26 Nov 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173344; cv=none; b=klfNj6f2z6+1PVdQGSnqBE/7iFSYX3jgUHaB0kS2/Y3xEVb1ElOrXWC41VRTVzDypXjG8CkJgvjC0QKz4tKXlkMXuPw64rZmJYqcNI2wCsOw1tOyRGIWkttaHOSVatEwW/Ew65a95OKHiJkaVVD8VM7TWs9NMWJ+urN1w3Rgzj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173344; c=relaxed/simple;
	bh=xb7tPH9H1MBueB0fLpet0KsBSzM+SJdYe4tV78sVjoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbHRp/rYOMoroGVsxnhdMobd5YW2OBbJiKrV+ep4I+J17OoFB30kSS0M8hxUBWuKLxG5wBxwny8apNcwCYkngxYYPQjM/ae/tYszptYp/UkupfeCd6fQZmKI0Hq/DDD91uMaYuFNa4t6qR5yW4Ny8JHl4Lc4vjkxOXoiX+/SxlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ezr4vDnI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4GbyUUUq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ezr4vDnI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4GbyUUUq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 748EC5BE77;
	Wed, 26 Nov 2025 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764173339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YbYJIoS8CSkYSEky1xzQmHacWnGGr8CQaD7k/OTeboQ=;
	b=ezr4vDnI9BlOLnc26FkABd8no3L8/SawwvPCTI6IVIlvPOhxdDOyv8d39UuPjMNL8Mmfx5
	3jkxeMZmGZWaT2voSsFqhEkuiv5g54zsRyY+5P9CG5e4TZNyO8fPgdKuAaBnCuxgXxFgPP
	jaadOykargHYJDRdfNNzH3GLgzyOzGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764173339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YbYJIoS8CSkYSEky1xzQmHacWnGGr8CQaD7k/OTeboQ=;
	b=4GbyUUUqAKT4zSGNS8PWVY06FymL7ZhyflSM/4I6eu0Khvd0nJ9Pjkq868uBdTDOPVn0Cb
	7qh/+SPNAeDd9HDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ezr4vDnI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4GbyUUUq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764173339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YbYJIoS8CSkYSEky1xzQmHacWnGGr8CQaD7k/OTeboQ=;
	b=ezr4vDnI9BlOLnc26FkABd8no3L8/SawwvPCTI6IVIlvPOhxdDOyv8d39UuPjMNL8Mmfx5
	3jkxeMZmGZWaT2voSsFqhEkuiv5g54zsRyY+5P9CG5e4TZNyO8fPgdKuAaBnCuxgXxFgPP
	jaadOykargHYJDRdfNNzH3GLgzyOzGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764173339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YbYJIoS8CSkYSEky1xzQmHacWnGGr8CQaD7k/OTeboQ=;
	b=4GbyUUUqAKT4zSGNS8PWVY06FymL7ZhyflSM/4I6eu0Khvd0nJ9Pjkq868uBdTDOPVn0Cb
	7qh/+SPNAeDd9HDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05E093EA63;
	Wed, 26 Nov 2025 16:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DH6WOxomJ2lnIgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Nov 2025 16:08:58 +0000
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
Subject: [PATCH v3 0/9] arch,sysfb,efi: Support EDID on non-x86 EFI systems
Date: Wed, 26 Nov 2025 17:03:17 +0100
Message-ID: <20251126160854.553077-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.1
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 748EC5BE77

Replace screen_info and edid_info with sysfb_primary_device of type
struct sysfb_display_info. Update all users. Then implement EDID support
in the kernel EFI code.

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

Patches 7 and 8 add support for EDID transfers on non-x86 EFI systems.

Patch 9 cleans up the config-table allocation to be easier to understand.

v3:
- replace SCREEN_INFO table entry (Ard)
- merge libstub patch into kernel patch
v2:
- combine v1 of the series at [1] plus changes from [2] and [3].

[1] https://lore.kernel.org/dri-devel/20251121135624.494768-1-tzimmermann@suse.de/
[2] https://lore.kernel.org/dri-devel/20251015160816.525825-1-tzimmermann@suse.de/
[3] https://lore.kernel.org/linux-efi/20251119123011.1187249-5-ardb+git@google.com/

Thomas Zimmermann (9):
  efi: earlycon: Reduce number of references to global screen_info
  efi: sysfb_efi: Reduce number of references to global screen_info
  sysfb: Add struct sysfb_display_info
  sysfb: Replace screen_info with sysfb_primary_display
  sysfb: Pass sysfb_primary_display to devices
  sysfb: Move edid_info into sysfb_primary_display
  efi: Refactor init_primary_display() helpers
  efi: Support EDID information
  efi: libstub: Simplify interfaces for primary_display

 arch/arm64/kernel/image-vars.h                |  2 +-
 arch/loongarch/kernel/efi.c                   | 38 ++++-----
 arch/loongarch/kernel/image-vars.h            |  2 +-
 arch/riscv/kernel/image-vars.h                |  2 +-
 arch/x86/kernel/kexec-bzimage64.c             |  4 +-
 arch/x86/kernel/setup.c                       | 16 ++--
 arch/x86/video/video-common.c                 |  4 +-
 drivers/firmware/efi/earlycon.c               | 42 +++++-----
 drivers/firmware/efi/efi-init.c               | 46 ++++++-----
 drivers/firmware/efi/efi.c                    |  4 +-
 drivers/firmware/efi/libstub/Makefile         |  2 +-
 drivers/firmware/efi/libstub/efi-stub-entry.c | 36 +++++++--
 drivers/firmware/efi/libstub/efi-stub.c       | 49 +++++++----
 drivers/firmware/efi/libstub/efistub.h        |  7 +-
 .../firmware/efi/libstub/primary_display.c    | 41 ++++++++++
 drivers/firmware/efi/libstub/screen_info.c    | 53 ------------
 drivers/firmware/efi/libstub/zboot.c          |  6 +-
 drivers/firmware/efi/sysfb_efi.c              | 81 ++++++++++---------
 drivers/firmware/sysfb.c                      | 13 +--
 drivers/firmware/sysfb_simplefb.c             |  2 +-
 drivers/gpu/drm/sysfb/efidrm.c                | 14 ++--
 drivers/gpu/drm/sysfb/vesadrm.c               | 14 ++--
 drivers/hv/vmbus_drv.c                        |  6 +-
 drivers/pci/vgaarb.c                          |  4 +-
 drivers/video/Kconfig                         |  8 +-
 drivers/video/fbdev/core/fbmon.c              |  8 +-
 drivers/video/fbdev/efifb.c                   | 10 ++-
 drivers/video/fbdev/vesafb.c                  | 10 ++-
 drivers/video/fbdev/vga16fb.c                 |  8 +-
 drivers/video/screen_info_pci.c               |  5 +-
 include/linux/efi.h                           |  9 ++-
 include/linux/screen_info.h                   |  2 -
 include/linux/sysfb.h                         | 23 ++++--
 include/video/edid.h                          |  4 -
 34 files changed, 321 insertions(+), 254 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/primary_display.c
 delete mode 100644 drivers/firmware/efi/libstub/screen_info.c


base-commit: d724c6f85e80a23ed46b7ebc6e38b527c09d64f5
-- 
2.51.1


