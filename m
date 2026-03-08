Return-Path: <linux-efi+bounces-6268-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLfNIfO1rWmi6QEAu9opvQ
	(envelope-from <linux-efi+bounces-6268-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sun, 08 Mar 2026 18:46:27 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC96F23179B
	for <lists+linux-efi@lfdr.de>; Sun, 08 Mar 2026 18:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 253EE300DE06
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2026 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97D28507E;
	Sun,  8 Mar 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk1nLOOh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2E274B46
	for <linux-efi@vger.kernel.org>; Sun,  8 Mar 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772991984; cv=none; b=g0LGJ9K+yqHiFKx/rA7F6SEcbDwVPLUaCFqElx4CJHoBvoV4LTOz+DVaj0vERbQMLK2njkw6uNY6cnxv4FidDKe8S9jvDlxCOor9sZresZ8oIYD+X6St2h7bWKm7TITpz4GXwZhm1WNuQvVuoj5rZAFcQgvYvaZlBi34qOjOArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772991984; c=relaxed/simple;
	bh=XkYR/LnH9Z82Xh6PSkbuZWOP2eiK+uwpdTv0ljJgKCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QqqyrFQ7FbyAUXdp4tAmJxWzyxmA/mdUTfY6/Biu4Q0YUhZHSPBOC7OY1eHbOG4b3XF/Uw830CXNYlFZVw25OlILAJS69Ccfx2BVKGqPGYq9Cp/WpNn3IBtPzMWYwyYkrhxpzcA51Tgue+1rveWrvHpNqrBDagfoLE779ZLvjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk1nLOOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E834C2BC86;
	Sun,  8 Mar 2026 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772991984;
	bh=XkYR/LnH9Z82Xh6PSkbuZWOP2eiK+uwpdTv0ljJgKCA=;
	h=From:To:Cc:Subject:Date:From;
	b=hk1nLOOhVuqDbAUPsjlWof5tyyraPwyapbUdiG2suW5oUIq8cB/J6dkPC/2BbG6mx
	 ONwXp+w7SdVLJZzwV6r03kNtJaSOrkMwUexgrNUr70W+pMId7cPYc8RIXFpJUOOoBE
	 kqXgq9DOyWMb5TIpN/55rcze8emoIM3zE48veSMLWOS7OonymkpFH1afnMmt2GwAK/
	 N97axqoaLUi8s9RKggMfDRA1lOkNTkEMQ/8E1r/S6573bhVpO9Bqb/nBMd7e3DpuL+
	 M8Vat1Mxzjjq6bCz2VkgkAh3wGBq0/sa1R493R/MssGBEI4Ch/6b/CiOMQ1/8mlKGv
	 HhOcULhfjaGeQ==
From: Ard Biesheuvel <ardb@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v7.0 #2
Date: Sun,  8 Mar 2026 18:45:53 +0100
Message-ID: <20260308174552.104770-2-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=ardb@kernel.org; h=from:subject; bh=XkYR/LnH9Z82Xh6PSkbuZWOP2eiK+uwpdTv0ljJgKCA=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXPt1gtWMy+xMyxSlW+UC3t34O/VdZKf/f/+K/5bYWqsK vSpx+pXRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIXEtGhq6UWZXyMxy+b4u1 5P567/viBXkhfj5LT55NfbwnfHuxdywjw2brYtsT3Yfqvt3p4Xt9Weus9L2CpgUOOy9rTpOZpnJ Viw0A
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC96F23179B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6268-lists,linux-efi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello Linus,

Please pull the fix below. A more comprehensive fix is under development, but
unlikely to be suitable for -stable, so a backportable fix such as this one is
needed in any case.


The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v7.0-2

for you to fetch changes up to a4b0bf6a40f3c107c67a24fbc614510ef5719980:

  x86/efi: defer freeing of boot services memory (2026-02-25 12:02:48 +0100)

----------------------------------------------------------------
EFI fixes for v7.0 #2

Fix for the x86 EFI workaround keeping boot services code and data
regions reserved until after SetVirtualAddressMap() completes: deferred
struct page initialization may result in some of this memory to be lost
permanently.

----------------------------------------------------------------
Mike Rapoport (Microsoft) (1):
      x86/efi: defer freeing of boot services memory

 arch/x86/include/asm/efi.h          |  2 +-
 arch/x86/platform/efi/efi.c         |  2 +-
 arch/x86/platform/efi/quirks.c      | 55 +++++++++++++++++++++++++++++++++++--
 drivers/firmware/efi/mokvar-table.c |  2 +-
 4 files changed, 55 insertions(+), 6 deletions(-)

