Return-Path: <linux-efi+bounces-5822-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D724CAE1A9
	for <lists+linux-efi@lfdr.de>; Mon, 08 Dec 2025 20:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31A703026B00
	for <lists+linux-efi@lfdr.de>; Mon,  8 Dec 2025 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62A11E00B4;
	Mon,  8 Dec 2025 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fbIG9vPA"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2DA2E9EAD
	for <linux-efi@vger.kernel.org>; Mon,  8 Dec 2025 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222782; cv=none; b=OawxnBhnLaH3VquMbvDo+dXQU5tj7cW3ig1l40s0trSaTimTMUAoJdLKCNnHB8o5jqpmCc/IbVD+udG70GqFumFgJbAGZoOHj7Lc37d92/CyCUEVzSHsEuPaNjKgUw1l5SZZw/JMghNoSJUrhi+17xF/kErSjMaWU3nkvzj6s5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222782; c=relaxed/simple;
	bh=s0TbPpIU3D29j41pdExUnH5oWeHeYT+ZJvBxPJb2uO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+H+StrOI07Gzii01r9U0v8zmIHBXGH/552Zbb4LgzGRkW+5Q/PC+OjBqTM63u5MWA5Oy2WS8T+su2x+BjUMevDxKM/nLuKPnvWR1zR9B40lw3CHgomgdfn3erIlNM/+ncJtPWyDCWNVGKpArxPBvd9FJYuSFg0yRlHEquiLnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fbIG9vPA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yBe70tc0kkzwCIzI7vX/BU2M3Dh+H/+QCPhOBfOpz28=; b=fbIG9vPAltgZsetFzMEjOxfT5f
	COh7sJ3UdncPNK0/rcFOJCSRTotuqqliz7yBvRWDjxsIW8bFNbb9Rd6fb65mYaCEKO+24PcO6rCHE
	6tR8Ywn2g6xwcIW2K9X5sUPusGYyVIoYGOdawTdGKVKtvOe19m+f5Ewl3+Qmot5RRrq8A1sOnTm3W
	VYGjaoHe7RqZ2fAC4dXJ6AUf5V/eLTd2ScfqK/3ZQOdiJ3eIipEDas9a90KOWNLh2oSMvvpNeIHEq
	qPGjuyxAzYS+QZ8H/Fa1unUeahyUmG6cNKxB40ZuxLEjmrLKUnGiKhcycXpUACcUgFyxggM7W4VjV
	7QSsp2/A==;
Received: from [86.33.28.86] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vSh4z-00ACWD-RD; Mon, 08 Dec 2025 20:39:29 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v5 1/4] efi: sysfb_efi: Replace open coded swap with the macro
Date: Mon,  8 Dec 2025 20:39:22 +0100
Message-ID: <20251208193925.7449-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251208193925.7449-1-tursulin@igalia.com>
References: <20251208193925.7449-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Replace the open coded width height swap with the standard macro.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Melissa Wen <mwen@igalia.com> # v3
---
 drivers/firmware/efi/sysfb_efi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 1e509595ac03..1d8b6966731c 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -357,10 +357,7 @@ __init void sysfb_apply_efi_quirks(void)
 
 	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
 	    dmi_check_system(efifb_dmi_swap_width_height)) {
-		u16 temp = screen_info.lfb_width;
-
-		screen_info.lfb_width = screen_info.lfb_height;
-		screen_info.lfb_height = temp;
+		swap(screen_info.lfb_width, screen_info.lfb_height);
 		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
 	}
 }
-- 
2.52.0


