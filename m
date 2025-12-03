Return-Path: <linux-efi+bounces-5765-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F46C9E691
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 10:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17A5B4E207C
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825332D7DF7;
	Wed,  3 Dec 2025 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="A/2HXZm6"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17782D73BA
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752838; cv=none; b=jstJharre/p88vZTyuCHulGf1P3sSr+VNmuhcwdolBj3/NVNDI5Te29zMHPRlp8YXihOc37FWNv19roaNEpY2S7/t0RmEj0n0qpUBzzwcYCma5FG2dnqOo6wTAhe/gtMcLvbNFNunepubheQKHsYIzh6oGRgMmbQkcRxh9LScqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752838; c=relaxed/simple;
	bh=3tdM8cIEzEMnVCxOvhgbEkZExjrHWFB5On0G1klLgNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkYJ3YDd8KPJPIcdRcrhA51hEjiwy3OVjSodSSpLw0GTSr9bcaGPVcrxjF1RhA0Y9vrojXv82WhUqFfQoCproseOn4/qCg1JK6xbltrz8Oz92giHqFUqflNRzgHkgqgAZr6dKiRH6gI/hrMPmjUvmLai4mIxXvrsMABMCABYrHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=A/2HXZm6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=geAmDXMRqhQ+gdMoGprBaCwF+ySmBL0jg60roBzAD8k=; b=A/2HXZm6FklqUnfV8p7qsOdqvM
	q0dKMKgzd0+hbaCyjA+/mJ13DCqjO1Vym3Va863LvqkW/iDTUpajFXZcKEDoxD8D27r0ktpAkENSl
	axO4gAOA9W/vgzSHe5ozS4vDFi4DdElQjL+KiVjOYuFKMSDXdpdSNTonlE0GdApUnoqa3CfVz41dS
	r+Aj6XngzeuT66efx0DooPs1EgVswgDo0D45Hr4Te2I64YvVPhWlCkCoTyipp/Eh2uFW9dWCn4473
	P0NqDY2DKbhEF/Vc+J6Qh+ITyDQbSzZ9I7KmR+b1HG1A+uVtoGpNWJJy36AloyPVV/e6W7VnSStdv
	oOomr1oQ==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vQipL-008Bpf-At; Wed, 03 Dec 2025 10:07:11 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v2 3/4] efi: sysfb_efi: Convert swap width and height quirk to a callback
Date: Wed,  3 Dec 2025 09:07:05 +0000
Message-ID: <20251203090706.53778-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251203090706.53778-1-tvrtko.ursulin@igalia.com>
References: <20251203090706.53778-1-tvrtko.ursulin@igalia.com>
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


