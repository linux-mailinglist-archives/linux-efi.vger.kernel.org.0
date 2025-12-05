Return-Path: <linux-efi+bounces-5813-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F0CA855E
	for <lists+linux-efi@lfdr.de>; Fri, 05 Dec 2025 17:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C984322EB72
	for <lists+linux-efi@lfdr.de>; Fri,  5 Dec 2025 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F90A320CBE;
	Fri,  5 Dec 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="E2m0dB7W"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005B26F46E
	for <linux-efi@vger.kernel.org>; Fri,  5 Dec 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948993; cv=none; b=uerj1+/t9Dbtd4zBpGXAkbqQj0jX/4ntGi7KL7vLoBUAncCD5DbFq1+OwBF+jAOncy52U9BZUSm+sOv9KMopT286k5RliM97VbUnqEAfM62IWik4koQa4IV2JTkZXsIVpQdS3gjbD2EZH9mPR1dQ4pU8ACQOFvDwfID1voTM58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948993; c=relaxed/simple;
	bh=KaxXNJYCqNp95+2NqSiKQdmKG6aOWaxi7lR82xVyqKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGKdmw53FIlzsYjwyVfNcdhLyyW4MeIkfNVyhZMHTzzIqNCzYa8jL3+gzSH0a/fniRoXbZgiUO93tF6XcsnIL1m42XAej8TO3Onr8BIUdIdT/FwUXDJf7KJUcPOp34YOYwRn2Js+UGbHKJrBw/ma58miZF3ugGK4P7itWLNkeeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=E2m0dB7W; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uiCsFWg2dVxeZ3JOL7EmxwxUFZFnCG7YpKA+EapRms0=; b=E2m0dB7W7Z7m9NwTxfvMbaN7Yk
	1cdVToTKE3Varidwqgqy+g7O9uh6s3JzfrT8pPRlFg0ltmDkFyDiIsJ52UMpCavqfcJfe+aX9IGQ+
	P9wn4KPLnZd7QaX5Q1imHFr3KX8KFVRgBev4ZBxAm1bjqV3mOcJFD7aMZeRgZAbXbalTvzoj5FffV
	KqzrQChWX0dNgpF9bmepps8NIaZxMUjkZXKA+r5bAFm0cG3iR3TcNB5+0j2E0+98kBsU7frftBShu
	0kJqVGU036o/IKUMa8Atm/5Kq9PLpSgJiCAuc4+y3yUCl4U3zxouFsTOr4r/xXcMpKW2T+9CZmdXD
	sDZB3wXg==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vRXr1-00980O-2a; Fri, 05 Dec 2025 16:36:19 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v4 4/4] efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck
Date: Fri,  5 Dec 2025 15:36:11 +0000
Message-ID: <20251205153611.93297-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205153611.93297-1-tvrtko.ursulin@igalia.com>
References: <20251205153611.93297-1-tvrtko.ursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Valve Steam Deck has a 800x1280 portrait screen installed in a landscape
orientation. The firmware offers a software rotated 1280x800 mode which
GRUB can be made to switch to when displaying a boot menu. If this mode
was selected frame buffer drivers will see this fake mode and fbcon
rendering will be corrupted.

Lets therefore add a selective quirk inside the current "swap with and
height" handling, which will detect this exact mode and fix it up back to
the native one.

This will allow the DRM based frame buffer drivers to detect the correct
mode and, apply the existing panel orientation quirk, and render the
console in landscape mode with no corruption.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org
Tested-by: Melissa Wen <mwen@igalia.com> # v3
---
 drivers/firmware/efi/sysfb_efi.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 5c54f42d5fef..db28e11d1eb7 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -242,6 +242,33 @@ static int __init efifb_swap_width_height(const struct dmi_system_id *id)
 	return 1;
 }
 
+struct efifb_mode_fixup {
+	unsigned int width;
+	unsigned int height;
+	unsigned int linelength;
+};
+
+static int __init
+efifb_check_and_swap_width_height(const struct dmi_system_id *id)
+{
+	const struct efifb_mode_fixup *data = id->driver_data;
+
+	if (data->width == screen_info.lfb_width &&
+	    data->height == screen_info.lfb_height) {
+		swap(screen_info.lfb_width, screen_info.lfb_height);
+		screen_info.lfb_linelength = data->linelength;
+		screen_info.lfb_size = data->linelength * data->width;
+	}
+
+	return 1;
+}
+
+static const struct efifb_mode_fixup efifb_steamdeck_mode_fixup __initconst = {
+	.width = 1280,
+	.height = 800,
+	.linelength = 3328,
+};
+
 /*
  * Some devices have a portrait LCD but advertise a landscape resolution (and
  * pitch). We simply swap width and height for these devices so that we can
@@ -297,6 +324,26 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 		},
 		.callback = efifb_swap_width_height,
 	},
+	{
+		/* Valve Steam Deck (Jupiter) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
+		},
+		.callback = efifb_check_and_swap_width_height,
+		.driver_data = (void *)&efifb_steamdeck_mode_fixup,
+	},
+	{
+		/* Valve Steam Deck (Galileo) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
+		},
+		.callback = efifb_check_and_swap_width_height,
+		.driver_data = (void *)&efifb_steamdeck_mode_fixup,
+	},
 	{},
 };
 
-- 
2.51.1


