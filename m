Return-Path: <linux-efi+bounces-5774-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA50C9E84F
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 10:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F4CE4E1344
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2A62D879A;
	Wed,  3 Dec 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iyneG3zF"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B6A2C2363
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754807; cv=none; b=ZbZe8hXRRDLFYiIz0w8N74nk7tHfX4Mq4IUJ3dsvZoSEOc+qsWeSJ0agiUGLOTsdRZuwyuNpjrqjo8rhlYZ/Kz8sA7ZlA2Dftkr1uCjIAC947ramK1v7TAeQx2YFhd3ocMI0wdUaQbU6KHgVhIH6sKJ8sDT9qtaObCWOJywmkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754807; c=relaxed/simple;
	bh=ron9Z0yLFDr166XSuaSfKRCJ6kYuH2WDmX83Q6ecr7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbUVe7Hbg1zYZ2Ce2Of0K6nv0Hq5ifz1JgeUNiQiCpvQLW2IOrA64Mws1b94xhmkXoxSiKofmLGqqJMqo7eVuHNoiqReggjw/FkgC4x98bJTWYtRf7O7+OIu5tJPcgJSJAf2+dKkOAaD3Hw4HZzocFFWJgj9DMM7whI/MNVKc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iyneG3zF; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lKGn1CzxAhdrGZVszVj9FBDrL6gSkSoPWkxyoNvNpvw=; b=iyneG3zF8U7tynwnZt7yHVLOm+
	f7oxQZi6QKkyImz+XN9Z6ogxHbLFRAkXLispMJW1h7cu2nFccE1v2dSjl4C6801uO3KlYEv15tMAA
	N+ZhiE1vz/YR1V2+bC1YxbIARADQ09gfmUkS+QajblO73TBM1Rm8vOf7laqfIbXcHTJa7YYk0VNyM
	Lco2EoTXtRB9jZTTEHe9C/soRTVL45LUJA56f7yaHUyjBXR7M1qb/ImCDLaADG5/l3xaCutc0ZYgz
	yh1H70b8zASWKkDbWUyKl5lqzXopfzxNMt0FyNZKKNZEBy75XYmdfV3sfnHCN4gFhMQ7zC33ClkIE
	BbT3oFew==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vQjL3-008CVw-Vn; Wed, 03 Dec 2025 10:39:58 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v3 2/4] efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
Date: Wed,  3 Dec 2025 09:39:46 +0000
Message-ID: <20251203093948.54296-3-tvrtko.ursulin@igalia.com>
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

PIXEL_BIT_MASK formats can have either less or more than four bytes per
pixel so lets fix the lfb_linelenght calculation when applying the
swapped width and height quirks.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/sysfb_efi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 1d8b6966731c..14b61414c33a 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -358,7 +358,9 @@ __init void sysfb_apply_efi_quirks(void)
 	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
 	    dmi_check_system(efifb_dmi_swap_width_height)) {
 		swap(screen_info.lfb_width, screen_info.lfb_height);
-		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
+		screen_info.lfb_linelength = (unsigned int)screen_info.lfb_depth *
+					     screen_info.lfb_width /
+					     BITS_PER_BYTE;
 	}
 }
 
-- 
2.51.1


