Return-Path: <linux-efi+bounces-5759-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55439C9BB8E
	for <lists+linux-efi@lfdr.de>; Tue, 02 Dec 2025 15:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE66E4E3E56
	for <lists+linux-efi@lfdr.de>; Tue,  2 Dec 2025 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D672C32144F;
	Tue,  2 Dec 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EVim6Nfv"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF0320CCE
	for <linux-efi@vger.kernel.org>; Tue,  2 Dec 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684637; cv=none; b=Bc71212r3k6EFMTrMOv2QrbToGaW1fEoBbtj67lMbnaRapKX7w3qT5w6vfgAGAhBushgTWYHmRqI5Xlg86iF+NNcNCgEQCLR8X6oFEUJhfe3Y7a+J/vTDEo6XLaOAKSiRJAmVulinw4kcSz+mSq56FekgsOKBfBc2xHYIoBnJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684637; c=relaxed/simple;
	bh=UniXPVSI5dlm167LfP6iBAeSUGrJ/CNUQoIOUZbCSd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSsMwpLd7xFHsOCY9jIdxiG5cITTQaZf/Cg4+TmG7jaY69VqHvWdOg58YvcFLXkCcKEFh3rj1SQyyfWuY5Ynzd4uxJ6ztRjBxiFAyLls+Yvhnl/nw/YcdvNuAlFmGLrJaZAzN/CVolYgmGWRz5hIgDxdCC+5mtCNpbeU/9D8jN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EVim6Nfv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OlP8m+kzevU9xahYSTI/925PcHdM1FKqtz757IA2WjE=; b=EVim6Nfvfc0Uqp4vuEwIiDW8Su
	FSkuR9xl2mCc3+EOxrHynSpLtn+OnchGYfZ5kc9EyXIeK3rCQ1uoNeaalyCOEmfmHbx6uwgVlQ0yi
	1tCEp0wXKnXxarhX8FX3zvStj0L/N9CGr7symdf4ITHWKhFYY/dysEldEnC43vdIy3qfClYFAIQMk
	9aOWjfTUK4lk0AddbfagVUWvnBYoSJePCEvYDDt8APzcDIE+7xHeKn/LiyoihwdWHnBKnBS94i3my
	43G87o85fWcZaktyvQeNvpou6RrIa5qVPCwriI1vPPrLLym7Wma96+Zv0xxT6th7m9Toe8Kb1BG2t
	ouURlYLg==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vQR5I-007pdL-F0; Tue, 02 Dec 2025 15:10:28 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH 2/3] efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
Date: Tue,  2 Dec 2025 14:10:24 +0000
Message-ID: <20251202141025.723-3-tvrtko.ursulin@igalia.com>
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
index 1d8b6966731c..2dea98395784 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -358,7 +358,9 @@ __init void sysfb_apply_efi_quirks(void)
 	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
 	    dmi_check_system(efifb_dmi_swap_width_height)) {
 		swap(screen_info.lfb_width, screen_info.lfb_height);
-		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
+		screen_info.lfb_linelength = (unsigned)screen_info.lfb_depth *
+					     screen_info.lfb_width /
+					     BITS_PER_BYTE;
 	}
 }
 
-- 
2.51.1


