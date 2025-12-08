Return-Path: <linux-efi+bounces-5821-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC8CAE1A6
	for <lists+linux-efi@lfdr.de>; Mon, 08 Dec 2025 20:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF66A3026AB3
	for <lists+linux-efi@lfdr.de>; Mon,  8 Dec 2025 19:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C639B2EA169;
	Mon,  8 Dec 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eyGl2x4l"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069EB2E7BD2
	for <linux-efi@vger.kernel.org>; Mon,  8 Dec 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222781; cv=none; b=iznW8yb9zeNYvh9wSlBPQ7GtwULxOkvK1DkLsTS/GoPRXegoZ92UlFiVKntALTZ/C+wDjBwkzkXXvkaNOcEgcbA7wqV/ZU4U8Q91UK7AXe8rFC9juHwg5cajRz0OoMAPNB/4O8BigN20+qxh+nfR9jio09/8H3ZnGzAyAVsmjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222781; c=relaxed/simple;
	bh=Hn3iIB5i67PIjdR6J9R9fo8QBNDCG+nT5H6Q2PQKLho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPIuHkLeWFPhr/oHN+JvD4gOwQ5FEKJKYa5LQE383lQwSygMhjyodsoc3nwqaX7LgHPiw6q4PjqETN7BZg3unoSHLgVhGYAgVDp/gbG1x7Pb00ZZPWWWZbXaY7xMb1CTcIT4XNZOJM4sDURXgPssK+IXf84CsVftuXKgSNmM3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eyGl2x4l; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CeXnkFmcSV7aJ4YLd2lWrv0j8cYu4uCZ7dlnGo+QfgI=; b=eyGl2x4llRoFNFQZW0a3VLEa44
	/xesk3cUkQ3V4Mw0uXZ5JTW/9f0UzpggCFS2FI/vM/+p3K7KuY2JAhwhMzwPjKRN3MDj7BM9uBxrp
	HbwomcJaNzhG56o/NbkG2XLDxjvwl3aqks7qcU1uqi/14Y+1RqMkWXTww2iiAjRHkVvlJW4u1ux9T
	RYl7g7drJgUarieA1rBkmjefUJQGW3tsqjGZ7mqSKBfLKrIgz0Pndw9N7baTJgsUwDChP/9zXQ27+
	meNp5ZwsShqLr7TRxpjqqRsB5yO1rIJ1JoIWz7ieEpyREJPly2iFpex3VldM3CcPt7yWiPcYJE6t7
	Gp58HkMQ==;
Received: from [86.33.28.86] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vSh4y-00ACWB-Pw; Mon, 08 Dec 2025 20:39:28 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v5 0/4] EFI fbcon fixes etc
Date: Mon,  8 Dec 2025 20:39:21 +0100
Message-ID: <20251208193925.7449-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Two generic fixes split out for easy review, one refactoring as requested, and
then the last patch is the panel/mode quirk to allow for corruption free fbcon
with simpledrmfb and efidrmfb on the Valve Steam Deck.

v2:
 * s/unsigned/unsigned int/
 * s/pitch/linelength/
 * Removed comment explaining the Steam Deck quirk.
 * Added patch to refactor quirk application via callbacks.

v3:
 * Added forgotten __initconst.
 * Use separate callback for the fixup quirk.

v4:
 * Use __screen_info_lfb_bits_per_pixel() instead of accessing lfb_depth directly.

v5:
 * s/lfb_width/bpp/.
 * Grammar and typo tidy in the last patch.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org

Tvrtko Ursulin (4):
  efi: sysfb_efi: Replace open coded swap with the macro
  efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
  efi: sysfb_efi: Convert swap width and height quirk to a callback
  efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck

 drivers/firmware/efi/sysfb_efi.c | 73 ++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 8 deletions(-)

-- 
2.52.0


