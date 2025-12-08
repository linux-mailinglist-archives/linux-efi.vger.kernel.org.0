Return-Path: <linux-efi+bounces-5823-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A59EECAE1AD
	for <lists+linux-efi@lfdr.de>; Mon, 08 Dec 2025 20:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6377D30393C9
	for <lists+linux-efi@lfdr.de>; Mon,  8 Dec 2025 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710B2E9EAD;
	Mon,  8 Dec 2025 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BxO4vG1A"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0695E2C21C6
	for <linux-efi@vger.kernel.org>; Mon,  8 Dec 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222783; cv=none; b=kNfEcVRPTIPioKAmxIaeTvCp5pYoZcOzDZOuxEmuKv0MyyfRYONWqGqYludVvEXQdQt8t3yLz+80u0XpOxO+TrnvQ4m62R5kr5O85CjgFTl75PVH8S208sZFm3sJf5A6ZlHzEStcbTE20Ql3ie/wscAT82mCHNufhElLEslNkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222783; c=relaxed/simple;
	bh=HY110sJQ/m5L+EFHIDGgqdfX3JeklFOXi7DQue3yERE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUHT4qzQUTAXhjJpwTqwVlIAd7UaRc8evBtswIBwUW8UZv0HK0KjLe3QqCaQ3jRNs5iOGmehD3wrnrmng2vFWizHbsEfrEawrKmvP1HxzvkkLcbrrlH9v5+ErDtEGGkmmHOl92CkHC2hflNmnsLzYei/6Skmg6r4kIdSKIxOxnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BxO4vG1A; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=U5+VXQ+aZU8D3Pl4aFUKOodXafXEEqLtRv0PWSf3//Y=; b=BxO4vG1AIzW10205xg+TYY7q5O
	H0jdhlRWTQbOtGq4R9otnxQzCHHzXbmAAOR8qrLIgM28YAE8ABgaeJd7hjDA3XbQCJNsSF+OVVu21
	AGhYYYQVh9sVYXxnt8EigwrEiIdhw5so4Z6JL473Sixdg3PGRg/mnwFIPpqCvBNrBahmx6C1Cj0QH
	Cou+TuQ/fNRS8BHgCw+e5o7vs6ZZIVfE77lZpw64m45/NsDd385MzFXDcC6NW7zeyN8w9lywHaD10
	AGa7u/UQAwJT/hAwLIOZ5oCHWXsib7oQhS2Xd+aOtQbr6yJZne0b2s7I0pdJgr1qPKPMZRVJXXsrK
	YW61aqlg==;
Received: from [86.33.28.86] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vSh51-00ACWQ-W7; Mon, 08 Dec 2025 20:39:32 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v5 3/4] efi: sysfb_efi: Convert swap width and height quirk to a callback
Date: Mon,  8 Dec 2025 20:39:24 +0100
Message-ID: <20251208193925.7449-4-tursulin@igalia.com>
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

Convert the swapping of width and height quirk to a callback.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Melissa Wen <mwen@igalia.com> # v3
---
 drivers/firmware/efi/sysfb_efi.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 60495eb3441c..85f6399d5e1f 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -231,6 +231,17 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
 	{},
 };
 
+static int __init efifb_swap_width_height(const struct dmi_system_id *id)
+{
+	u32 bpp = __screen_info_lfb_bits_per_pixel(&screen_info);
+
+	swap(screen_info.lfb_width, screen_info.lfb_height);
+	screen_info.lfb_linelength = bpp * screen_info.lfb_width /
+				     BITS_PER_BYTE;
+
+	return 1;
+}
+
 /*
  * Some devices have a portrait LCD but advertise a landscape resolution (and
  * pitch). We simply swap width and height for these devices so that we can
@@ -248,6 +259,7 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "MIIX 310-10ICR"),
 			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1HCN44WW"),
 		},
+		.callback = efifb_swap_width_height,
 	},
 	{
 		/* Lenovo MIIX 320-10ICR with 800x1280 portrait screen */
@@ -256,6 +268,7 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
 					"Lenovo MIIX 320-10ICR"),
 		},
+		.callback = efifb_swap_width_height,
 	},
 	{
 		/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
@@ -264,6 +277,7 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
 					"Lenovo ideapad D330-10IGM"),
 		},
+		.callback = efifb_swap_width_height,
 	},
 	{
 		/* Lenovo IdeaPad Duet 3 10IGL5 with 1200x1920 portrait screen */
@@ -272,6 +286,7 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
 					"IdeaPad Duet 3 10IGL5"),
 		},
+		.callback = efifb_swap_width_height,
 	},
 	{
 		/* Lenovo Yoga Book X91F / X91L */
@@ -280,6 +295,7 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 			/* Non exact match to match F + L versions */
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
 		},
+		.callback = efifb_swap_width_height,
 	},
 	{},
 };
@@ -355,14 +371,8 @@ __init void sysfb_apply_efi_quirks(void)
 	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
 		dmi_check_system(efifb_dmi_system_table);
 
-	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
-	    dmi_check_system(efifb_dmi_swap_width_height)) {
-		u32 bpp = __screen_info_lfb_bits_per_pixel(&screen_info);
-
-		swap(screen_info.lfb_width, screen_info.lfb_height);
-		screen_info.lfb_linelength = bpp * screen_info.lfb_width /
-					     BITS_PER_BYTE;
-	}
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
+		dmi_check_system(efifb_dmi_swap_width_height);
 }
 
 __init void sysfb_set_efifb_fwnode(struct platform_device *pd)
-- 
2.52.0


