Return-Path: <linux-efi+bounces-5760-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CA2C9BB91
	for <lists+linux-efi@lfdr.de>; Tue, 02 Dec 2025 15:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C8A94E38B2
	for <lists+linux-efi@lfdr.de>; Tue,  2 Dec 2025 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7032143C;
	Tue,  2 Dec 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WwaRc6/w"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7031ED8B
	for <linux-efi@vger.kernel.org>; Tue,  2 Dec 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684637; cv=none; b=ON7v3uy2+MYNjNH6HN00WCmqMPZMCvz7AGaweSbnBLgCMmTgIydQPqRB8oAvPkEXHJCeLfPCl3OqIO/5Gc/AV/UH2mOBe5v7cxZrwZ+pLpgp3a9tLM2ZVTeHiFrIrYYvgN0oJzlQcW5luZPuCn+J2lfoOlXZvFjibGhDVcrJ3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684637; c=relaxed/simple;
	bh=hhrd1Hl1LqoxnIc3zh2+Z9CppDhWRbbWjY5BplQcrd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2pGqmUAyN0i8lz5i2PIkLRcUEapbqjKPqIwHGKc8mDQImZFvtx3h4wkPodYoptTBpzIRpPXilm1oZlh+z58VurMwQUdi6YQw2EbJGhBF9yr2S/a1Wt5qiz82z02IzuQdkYN5Dbl8pJrtXltGR/V06mCt5B0kcHwTCvO2kLEs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WwaRc6/w; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UmPzuO7M8OArSeoNELwTFDCITbLXcyLL06ejoAa4Ut4=; b=WwaRc6/wwkQ0bg23iTddvu0J3A
	3BIAyN0f05R/vPxGcX1dBRAhHAGxY9Lt3VtLPjBE7tECTGanePubt19SjhIBsJB1GpMcga5jcCOYa
	VBtAdGf0eP6U8iPKRtvUPvYWBqW0N7W+HLdCr+aE5bjBOvXWEO6W3V84IipUbU0b4Xy53R21WYCUP
	LmPB2dKIUWoFbxmYLzsOI5eMz3m1eKrT8UkK0/UnziiCZ2xPtTt+7AKjhSUUHKlNNgSFWOj9vmles
	BHkZIIg4C2PloyciDuboPfhey41Ra+A+SFgNuolWOcB6G/hiE0l+AVjFilC1H4uYwE4mFAhBMjDJY
	pYuiBUgg==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vQR5J-007pdP-5F; Tue, 02 Dec 2025 15:10:29 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH 3/3] efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck
Date: Tue,  2 Dec 2025 14:10:25 +0000
Message-ID: <20251202141025.723-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251202141025.723-1-tvrtko.ursulin@igalia.com>
References: <20251202141025.723-1-tvrtko.ursulin@igalia.com>
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
---
 drivers/firmware/efi/sysfb_efi.c | 69 +++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 2dea98395784..6458b3193093 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -231,6 +231,27 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
 	{},
 };
 
+struct efifb_mode_fixup {
+	unsigned int width;
+	unsigned int height;
+	unsigned int pitch;
+};
+
+static const struct efifb_mode_fixup efifb_steamdeck_mode_fixup = {
+	/*
+	 * Valve Steam Deck has a 800x1280 portrait screen installed in a
+	 * landscape orientation. The firmware offers a software rotated
+	 * 1280x800 mode which GRUB can be made to switch to when displaying a
+	 * boot menu. If this mode was selected we need to fix it up back to the
+	 * native mode so frame buffer drivers can correctly probe, detect the
+	 * panel orientation quirk based on it, and the console renders with no
+	 * corruption in the software rotated mode.
+	 */
+	.width = 1280,
+	.height = 800,
+	.pitch = 3328,
+};
+
 /*
  * Some devices have a portrait LCD but advertise a landscape resolution (and
  * pitch). We simply swap width and height for these devices so that we can
@@ -281,6 +302,24 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
 		},
 	},
+	{
+		/* Valve Steam Deck (Jupiter) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
+		},
+		.driver_data = (void *)&efifb_steamdeck_mode_fixup,
+	},
+	{
+		/* Valve Steam Deck (Galileo) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
+		},
+		.driver_data = (void *)&efifb_steamdeck_mode_fixup,
+	},
 	{},
 };
 
@@ -351,16 +390,34 @@ static struct fwnode_handle efifb_fwnode;
 
 __init void sysfb_apply_efi_quirks(void)
 {
+	const struct dmi_system_id *match;
+
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
 	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
 		dmi_check_system(efifb_dmi_system_table);
 
-	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
-	    dmi_check_system(efifb_dmi_swap_width_height)) {
-		swap(screen_info.lfb_width, screen_info.lfb_height);
-		screen_info.lfb_linelength = (unsigned)screen_info.lfb_depth *
-					     screen_info.lfb_width /
-					     BITS_PER_BYTE;
+	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
+		return;
+
+	for (match = dmi_first_match(efifb_dmi_swap_width_height);
+	     match;
+	     match = dmi_first_match(match + 1)) {
+		const struct efifb_mode_fixup *data = match->driver_data;
+
+		if (!data ||
+		    (data->width == screen_info.lfb_width &&
+		     data->height == screen_info.lfb_height)) {
+			swap(screen_info.lfb_width, screen_info.lfb_height);
+
+			if (data && data->pitch) {
+				screen_info.lfb_linelength = data->pitch;
+				screen_info.lfb_size = data->pitch * data->width;
+			} else {
+				screen_info.lfb_linelength = (unsigned)screen_info.lfb_depth *
+							     screen_info.lfb_width /
+							     BITS_PER_BYTE;
+			}
+		}
 	}
 }
 
-- 
2.51.1


