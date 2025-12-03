Return-Path: <linux-efi+bounces-5772-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86516C9E849
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 10:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D9A3A8D46
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C423921CFF6;
	Wed,  3 Dec 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F3xoZBSl"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02C2D5A16
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754806; cv=none; b=kdsDSqEMQPAhZY1rq98cuLaeQEBe+fJjBCNC2DXh06MSUzRFRaTi4Aty90ET8i3BrRyLbbQYWyM/9XP7h+5RDSWSs840WrZu8JaCpEoNCbOm5mgwF82GPk4D4+4vsvEynJUNF9qtjoHeCJ3xL/iJr7GAzWs2PkWK5zC82xBuZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754806; c=relaxed/simple;
	bh=3tdM8cIEzEMnVCxOvhgbEkZExjrHWFB5On0G1klLgNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQQbDmtQ5qEgkQJFO1eGLVCdp60FDd2iePSgeQcGkxwAaYIEeDd2MlQrGTM24n+avlrGJD95WrsdGJyqgbSOcOn7EIYMTeJhCsTOqlINzGJ7LEdALCFmQI/zvABKk6NZwLoPMraYjFa8c6aJ7+1ny7cecTBFPwsSAVKELg1h62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=F3xoZBSl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=geAmDXMRqhQ+gdMoGprBaCwF+ySmBL0jg60roBzAD8k=; b=F3xoZBSlJndJLe4c+kKNfmjw/U
	jyvLm38PZ0T3WnqkNUZ+K69yCxeQsgsiVWHGnBBpqF0SSvAXAyESereLBpJ9gjRQp3LsKsjPITohM
	qLr8+QILQvHKa9WphZNNdiEH3xjqw1rauqhS3cOW+gPXhs+4JNY2bWuj3ecyK6a4K27V6Nb39xUd+
	MzuyOfDk3SuwGxvDs7Tts8vVjiazk7C76uObM1KW4dYuSSPxKTgWx6O+MP61XPisZK8h+LP2hPpEj
	ct0kmykL0um1M0OlxCnNuwiAqklMxIubXZdLc4Nmn2hPurl3EbU5xtg0FcHJXVp9gbt5YPTEQDF5e
	GV/4j2Sw==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vQjL4-008CW4-Lo; Wed, 03 Dec 2025 10:39:58 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v3 3/4] efi: sysfb_efi: Convert swap width and height quirk to a callback
Date: Wed,  3 Dec 2025 09:39:47 +0000
Message-ID: <20251203093948.54296-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251203093948.54296-1-tvrtko.ursulin@igalia.com>
References: <20251203093948.54296-1-tvrtko.ursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the swapping of width and height quirk to a callback.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/sysfb_efi.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 14b61414c33a..eacf9a50eab2 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -231,6 +231,16 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
 	{},
 };
 
+static int __init efifb_swap_width_height(const struct dmi_system_id *id)
+{
+	swap(screen_info.lfb_width, screen_info.lfb_height);
+	screen_info.lfb_linelength = (unsigned int)screen_info.lfb_depth *
+				     screen_info.lfb_width /
+				     BITS_PER_BYTE;
+
+	return 1;
+}
+
 /*
  * Some devices have a portrait LCD but advertise a landscape resolution (and
  * pitch). We simply swap width and height for these devices so that we can
@@ -248,6 +258,7 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "MIIX 310-10ICR"),
 			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1HCN44WW"),
 		},
+		.callback = efifb_swap_width_height,
 	},
 	{
 		/* Lenovo MIIX 320-10ICR with 800x1280 portrait screen */
@@ -256,6 +267,7 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
 					"Lenovo MIIX 320-10ICR"),
 		},
+		.callback = efifb_swap_width_height,
 	},
 	{
 		/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
@@ -264,6 +276,7 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
 					"Lenovo ideapad D330-10IGM"),
 		},
+		.callback = efifb_swap_width_height,
 	},
 	{
 		/* Lenovo IdeaPad Duet 3 10IGL5 with 1200x1920 portrait screen */
@@ -272,6 +285,7 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
 					"IdeaPad Duet 3 10IGL5"),
 		},
+		.callback = efifb_swap_width_height,
 	},
 	{
 		/* Lenovo Yoga Book X91F / X91L */
@@ -280,6 +294,7 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 			/* Non exact match to match F + L versions */
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
 		},
+		.callback = efifb_swap_width_height,
 	},
 	{},
 };
@@ -355,13 +370,8 @@ __init void sysfb_apply_efi_quirks(void)
 	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
 		dmi_check_system(efifb_dmi_system_table);
 
-	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
-	    dmi_check_system(efifb_dmi_swap_width_height)) {
-		swap(screen_info.lfb_width, screen_info.lfb_height);
-		screen_info.lfb_linelength = (unsigned int)screen_info.lfb_depth *
-					     screen_info.lfb_width /
-					     BITS_PER_BYTE;
-	}
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
+		dmi_check_system(efifb_dmi_swap_width_height);
 }
 
 __init void sysfb_set_efifb_fwnode(struct platform_device *pd)
-- 
2.51.1


