Return-Path: <linux-efi+bounces-5820-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1432CAE1A3
	for <lists+linux-efi@lfdr.de>; Mon, 08 Dec 2025 20:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F8463027CE2
	for <lists+linux-efi@lfdr.de>; Mon,  8 Dec 2025 19:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614B2EA14E;
	Mon,  8 Dec 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iZW2eBoe"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068CA1E00B4
	for <linux-efi@vger.kernel.org>; Mon,  8 Dec 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222781; cv=none; b=IOhv64Jy9vlMZbnsFA1kq1IUSS7zM43exfsHtlcAZSSXXMzE4VvzVEqGegKKKAXdaZ+XK90aJbXSm8IBbtTPv1QuQ8rM7fIssbQeyKNjiGQs8tZN2ptbJ+hPuTwdIqGmLNHdnQu/r8lgnFIADWF5mX3+i3ImThUjRhxdL1eM49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222781; c=relaxed/simple;
	bh=/sU2Io6qjHxOUqTAGztBvvZp2svp1uNdx3C2QsLCz4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lja/y46yy7YRYB+90u+I0YVxi/Iv7FYvA0XEXqYjXd5oi1VbH9tJW7TQ/7bgN4XQ7ymI8dR5NiwYve1p3guJufO6bsKluOKlQFRjkhGyBlEiisWXxtG6GshzCUnodPdlTz57wUs45nnXIkbncNvnZs22ryWHwdZWXAbhLiBLMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iZW2eBoe; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KTIuRTewkuzSQ9je0CoEli3jdeXpIu120zMiWsjPZ9I=; b=iZW2eBoeUCtAwMjMmOssE0bax9
	5x+prD/UffgxeDxP8C0jFKOJsevt6C44eLT+OtisKM6TQGhrsnEZKNIUC6x6mx+PJMrtBnLAnzJhV
	EMMdcKWzMO28hrmOx7XgvxyNC1VZra9v+WEVC/ITh4rkRWFtF6ea1RaEvRnE1fehcThJIBxFs81d0
	oTeONoS/Uii7BvusA0aTcss2MVE5wC3ztBsLNzsP7WnVy8FO/fhDoF/E3pnhPvP2vWU3vv66CVOa6
	PrBYCbZlZEKT1kxBqKtu3yjt8Aqqk3aKCHUxHDE49rT2qX9YBWqS+mXsoHK9l5ThqjZStfr+TKgFW
	diSHRmTQ==;
Received: from [86.33.28.86] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vSh53-00ACWb-3c; Mon, 08 Dec 2025 20:39:33 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v5 4/4] efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck
Date: Mon,  8 Dec 2025 20:39:25 +0100
Message-ID: <20251208193925.7449-5-tursulin@igalia.com>
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

Valve Steam Deck has a 800x1280 portrait screen installed in a landscape
orientation. The firmware offers a software-rotated 1280x800 mode, which
GRUB can be made to switch to when displaying a boot menu. If this mode
was selected frame buffer drivers will see this fake mode and fbcon
rendering will be corrupted.

Let us therefore add a selective quirk inside the current "swap with and
height" handling, which will detect this exact mode and fix it up back to
the native one.

This will allow the DRM-based framebuffer drivers to detect the correct
mode, apply the existing panel orientation quirk, and render the console
in landscape mode with no corruption.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org
Tested-by: Melissa Wen <mwen@igalia.com> # v3
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/efi/sysfb_efi.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 85f6399d5e1f..88e4fd4b0a3f 100644
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
2.52.0


