Return-Path: <linux-efi+bounces-6106-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kORNAR8simkjIAAAu9opvQ
	(envelope-from <linux-efi+bounces-6106-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Feb 2026 19:49:03 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5263A113D37
	for <lists+linux-efi@lfdr.de>; Mon, 09 Feb 2026 19:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F1B43017263
	for <lists+linux-efi@lfdr.de>; Mon,  9 Feb 2026 18:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0110371063;
	Mon,  9 Feb 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAE9OAE5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76C33B6EF
	for <linux-efi@vger.kernel.org>; Mon,  9 Feb 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662917; cv=none; b=lT3/H3kwGaFIunZ/seZacXW1JcvFWH0BY6miysVPRoAUP+nJy8YvaJJ5ILTOAa5wBlXwZ1edQAl1PiWGkwR0WJYbino5c5VVhXeb7PzOs3syZNa6RU2sa/NiuzM9sGKF1P1ksVTwFPTkgPJ3we+UQ8C/OtonyqYOBOPBvQuG+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662917; c=relaxed/simple;
	bh=cQTA5GR7n3+XNPWYkTlVAypwpnzgCRmsQagDVsHu3iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQs88KO3lJS6L54+S59xiY5qrSZvExf0RICJ5KYfLvRwNjFFz2vpu+a6g8S9k60KiTToLKPknHTg0GNhIiMsZvonZoWNKWoCgIdwbwL0uzQ5K2ZFckPqkyeXk5JvlQHDwy10BnEla7KeCJgEjU8fvgfbM3UZtjm0IltDz8FgJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAE9OAE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797E1C116C6;
	Mon,  9 Feb 2026 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770662917;
	bh=cQTA5GR7n3+XNPWYkTlVAypwpnzgCRmsQagDVsHu3iw=;
	h=From:To:Cc:Subject:Date:From;
	b=rAE9OAE5uaB6hGr4/6cbxutXKkK9TAjU+QPcNtZO687FJsiCCa/Znh/hBAH2tsWP+
	 tyl6QXNsNgGE3OKxwvraaYbDlBgR0jffDAT3QcHgSJO422gycKO7RYVyDbP4vYLqjB
	 3Nask6hD987QkKFb8s9Il1IpAu1r0zHKz4jZWl5NsTuganSvuHb6oRtmFr1rI8bKGV
	 d45NF/IBgxLtO/83/3gldgplYo7BpIgq0lvtrxEvttZeVedU04WMVPPzgBZeH7vHeE
	 DzFv/QlKwQivECGSA2o1FpcVhR09vYWXzl64TDpdk2GzYuT66iDUZPFLh3QXip7eLD
	 pOuIEcNM5bIcA==
From: Ard Biesheuvel <ardb@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI updates for v7.0
Date: Mon,  9 Feb 2026 19:48:05 +0100
Message-ID: <20260209184805.556296-1-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6106-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5263A113D37
X-Rspamd-Action: no action

Hi Linus,

Some work going on in the EFI framebuffer area this cycle. Please pull.


The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v7.0

for you to fetch changes up to c5a8f13f1e476c90f4bc184a58751d3e7ff88f2b:

  efi: Support EDID information (2025-12-16 14:40:51 +0100)

----------------------------------------------------------------
EFI updates for v7.0

- Quirk the broken EFI framebuffer geometry on the Valve Steam Deck

- Capture the EDID information of the primary display also on non-x86
  EFI systems when booting via the EFI stub.

----------------------------------------------------------------
Thomas Zimmermann (7):
      efi: earlycon: Reduce number of references to global screen_info
      efi: sysfb_efi: Reduce number of references to global screen_info
      sysfb: Add struct sysfb_display_info
      sysfb: Replace screen_info with sysfb_primary_display
      sysfb: Pass sysfb_primary_display to devices
      sysfb: Move edid_info into sysfb_primary_display
      efi: Support EDID information

Tvrtko Ursulin (4):
      efi: sysfb_efi: Replace open coded swap with the macro
      efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
      efi: sysfb_efi: Convert swap width and height quirk to a callback
      efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck

 arch/arm64/kernel/image-vars.h                 |   2 +-
 arch/loongarch/kernel/efi.c                    |  31 +++---
 arch/loongarch/kernel/image-vars.h             |   2 +-
 arch/riscv/kernel/image-vars.h                 |   2 +-
 arch/x86/kernel/kexec-bzimage64.c              |   4 +-
 arch/x86/kernel/setup.c                        |  16 ++-
 arch/x86/video/video-common.c                  |   4 +-
 drivers/firmware/efi/earlycon.c                |  42 ++++----
 drivers/firmware/efi/efi-init.c                |  38 +++----
 drivers/firmware/efi/efi.c                     |   4 +-
 drivers/firmware/efi/libstub/Makefile          |   2 +-
 drivers/firmware/efi/libstub/efi-stub-entry.c  |  17 +--
 drivers/firmware/efi/libstub/efi-stub.c        |  41 ++++---
 drivers/firmware/efi/libstub/efistub.h         |   7 +-
 drivers/firmware/efi/libstub/primary_display.c |  56 ++++++++++
 drivers/firmware/efi/libstub/screen_info.c     |  53 ---------
 drivers/firmware/efi/libstub/zboot.c           |   4 +-
 drivers/firmware/efi/sysfb_efi.c               | 144 ++++++++++++++++++-------
 drivers/firmware/sysfb.c                       |  13 +--
 drivers/firmware/sysfb_simplefb.c              |   2 +-
 drivers/gpu/drm/sysfb/efidrm.c                 |  14 +--
 drivers/gpu/drm/sysfb/vesadrm.c                |  14 +--
 drivers/hv/vmbus_drv.c                         |   6 +-
 drivers/pci/vgaarb.c                           |   4 +-
 drivers/video/Kconfig                          |   8 +-
 drivers/video/fbdev/core/fbmon.c               |   8 +-
 drivers/video/fbdev/efifb.c                    |  10 +-
 drivers/video/fbdev/vesafb.c                   |  10 +-
 drivers/video/fbdev/vga16fb.c                  |   8 +-
 drivers/video/screen_info_pci.c                |   5 +-
 include/linux/efi.h                            |   9 +-
 include/linux/screen_info.h                    |   2 -
 include/linux/sysfb.h                          |  23 +++-
 include/video/edid.h                           |   4 -
 34 files changed, 358 insertions(+), 251 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/primary_display.c
 delete mode 100644 drivers/firmware/efi/libstub/screen_info.c

