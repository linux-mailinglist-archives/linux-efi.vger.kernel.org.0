Return-Path: <linux-efi+bounces-5764-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05310C9E665
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 10:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73A43A656A
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344A52D7DED;
	Wed,  3 Dec 2025 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NkdyvTKi"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2D2D7386
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752838; cv=none; b=D1hjKNXolaDgIAST9TBp1n7sUxKT27HohS1+U+8Zurh4Ab9vj2B44NR3jXZX958CCyz1yoCE3bk3g+kU3vP230tMq/W6vasokF7lm1u6yap0RwfxZ6LhzSMBq4uSGzbaNtsUWDVqMJr7GnxW5Ib2y1hxaDumkib+hedLznAekY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752838; c=relaxed/simple;
	bh=ron9Z0yLFDr166XSuaSfKRCJ6kYuH2WDmX83Q6ecr7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/joYR9X6j0PNWC/rPiFMYtugFUZNFpIh9Fa+pPnfhqrf+EJnC+hgIKFtM+CM+FsoT7gfOkiXDIy+RrwG5kMzo7YWNl6v5dzifv1rSphJSmaImRt3LW1z8B0PiQC3+bKYPVlMcWMu273wCVqs/sASG/7/c0qSeRNrs2BdG9LAFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NkdyvTKi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lKGn1CzxAhdrGZVszVj9FBDrL6gSkSoPWkxyoNvNpvw=; b=NkdyvTKio1N6sUq48yCwwlkRcZ
	hDam83s4uoWbiJZoZZAAfSdqh1O9HZI1qAfKeMEwY2DDTpgVdAR8jTL2q503kGOOQupUb/sbqvkcn
	4o5rb0sjcT774wsIz6c+4GQxRIFDyqLDESFjT2z43U5zRPibYhl2CWfHcX/3eCxsQtIL4mg1H8hxw
	NUHaP/H2qZrArUwrzPRFi1RJZ/S6/ARoU5pst74kgoB38lOrMfdSe5YtdlOwAfX7gGYQesbLS2p3o
	vGdQC2AKn90qDFmt1acMciWEo4g88+1XBlWrpMRIwZC4x7czVEhsPueczfuDHSEreSZsdZbJtOyv3
	Jx94l6Rg==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vQipK-008Bpb-Kd; Wed, 03 Dec 2025 10:07:10 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v2 2/4] efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
Date: Wed,  3 Dec 2025 09:07:04 +0000
Message-ID: <20251203090706.53778-3-tvrtko.ursulin@igalia.com>
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


