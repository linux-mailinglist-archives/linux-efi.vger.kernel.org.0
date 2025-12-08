Return-Path: <linux-efi+bounces-5824-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E3ACAE1AC
	for <lists+linux-efi@lfdr.de>; Mon, 08 Dec 2025 20:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7E9C302F69B
	for <lists+linux-efi@lfdr.de>; Mon,  8 Dec 2025 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3E2C21C6;
	Mon,  8 Dec 2025 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gIJ6ilS8"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0E2EA473
	for <linux-efi@vger.kernel.org>; Mon,  8 Dec 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222783; cv=none; b=l9SHPhb2bnDT0L8wc/PLzKC9p+MwjRfrYdcUBAjn32E2QgkA4qXTqmaIWxmppuoaaqWITowoYacwWzBcdeQTC7TwXX/iZ9vtfDCo2qTwzSDyZyIpkvFsDjFrS2asKOE1QUZwMQ92Y/cnhFHrN3K+gUqQ2QA0EBn3Jckp98zCGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222783; c=relaxed/simple;
	bh=Iq2mZECxIt/C+bb9VCl8tDLSoMLUMSO3Lnh7c9gWyvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH0El9jOaDIdz7e0edi/9xjtF7qcmUXcfm2pLDNAQiD1luYprUuSFNNHYA7JM634Qb6TBXRL2nokNL2LV4we+lO8neDQ+DjiOcDBfcw67aoX87V673Raq09Vjv24wMMmnE/ydBtwdwPQMZlgtkGs770g3palUHib9CbFUAcC7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gIJ6ilS8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+a0TXJulNAzCJTCRKiQoVHa0dypfRvHA2DojjuW46ew=; b=gIJ6ilS81sT7FIzZQLDDuwSBpY
	DpH8TQTQCHolMBbvRHHh7yYODdxhJa7v83W1xoufxUnkmFKM6zTUGG+LPvuAStBghQj/4L41Mi5Jc
	3NXbAHW/3o7QHroTeaRafFf9niBFVdHVkHfHGXLnrSe3uqkAbKm6NreFFRXvKaM7WDFk2rYoJU4Eo
	HHj4xewFZmsyUXCKuF3cGFHLIc1ubTAWY3uDq8YJ8yLbALaOge45OT9y2KSQ5aOghgHcfBRPlZLly
	sMa3CIDh+A4QBzW9sa6OW2mvQcT+MyhdHaBBkvSh3XNK+vFlWnilFhcRayUd68fWJ5qFYGu4U/Ef6
	+5XrwZqA==;
Received: from [86.33.28.86] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vSh50-00ACWK-TV; Mon, 08 Dec 2025 20:39:31 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v5 2/4] efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
Date: Mon,  8 Dec 2025 20:39:23 +0100
Message-ID: <20251208193925.7449-3-tursulin@igalia.com>
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

PIXEL_BIT_MASK formats can have either less or more than four bytes per
pixel so lets fix the lfb_linelenght calculation when applying the
swapped width and height quirks.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org
Tested-by: Melissa Wen <mwen@igalia.com> # v3
---
 drivers/firmware/efi/sysfb_efi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 1d8b6966731c..60495eb3441c 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -357,8 +357,11 @@ __init void sysfb_apply_efi_quirks(void)
 
 	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
 	    dmi_check_system(efifb_dmi_swap_width_height)) {
+		u32 bpp = __screen_info_lfb_bits_per_pixel(&screen_info);
+
 		swap(screen_info.lfb_width, screen_info.lfb_height);
-		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
+		screen_info.lfb_linelength = bpp * screen_info.lfb_width /
+					     BITS_PER_BYTE;
 	}
 }
 
-- 
2.52.0


