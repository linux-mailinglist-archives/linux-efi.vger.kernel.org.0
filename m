Return-Path: <linux-efi+bounces-5810-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DEECA83D6
	for <lists+linux-efi@lfdr.de>; Fri, 05 Dec 2025 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2AE1305B651
	for <lists+linux-efi@lfdr.de>; Fri,  5 Dec 2025 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F85E3242BD;
	Fri,  5 Dec 2025 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FMO9ULHw"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF43112AB
	for <linux-efi@vger.kernel.org>; Fri,  5 Dec 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948991; cv=none; b=YqYweM9w7EeDVHfzK1srgc3QAI8uZmOjsP98D0UPO9FWZxTgTnrN1yJigTilG6eJRBXi4jL+oHHkG8ojaV/Yw6NNouEo6w7SwjCwxHgn58ysz+ml1fVmSP42JE+QonofHRB2cJrRyytHIJcYllMRJbYwbFvNpHZO4z7wEBFoveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948991; c=relaxed/simple;
	bh=HHRCLiZmbLrge9+5vLL/J/bgN+j24/6qB+bRAbu4D60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APF06NRlNkHkxsXtBViLj13KUExRzDTOkwuORLmTzpG/FhOxznr7rcqLG1UhetdF/TgiB0OYjCZtPx5NUR4B2+FJjl9iQg4bn09XwiEK94PeqDFdPDf/BM29Xy7E6f3RY9WlTBidjKg5M7hrdkxznwBd8XV+5T8cSB4CL96bjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FMO9ULHw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/xPqZbabg0rdXjpIummrwUKTsQ2OlB/y9SK7aM6dWiY=; b=FMO9ULHwUmThLhmWLAE1zpDI1N
	6dfU7xGjeKyNXYB/X70bqbxgTq0B3NCkxcLjzVpOoZ7HNqFZODEgzojCZJcjA+BKXO472IammjGP9
	R/5+7AUUOXtnLGlzIKvdI4nT755Osb1QZwxlHnqnnMuaQ8Tj6ysfT9vWsOMtjkxQm7EStsuuQAwJB
	7O4uUpspi252yCjXakomBwBuYwiEOs7GRBq2Pmr+Rq/Z+clYyirnCS6E3ed6dnhifFWMG65e6Dehw
	oMGmXAg1M7y3D+ZENW65QXOyRhD1JFuwMs3reAEYgBYcThGJug/+QGgvQcXoqKHQc0SXyjEr7e7Y5
	aUMuB9sA==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vRXqy-00980A-R3; Fri, 05 Dec 2025 16:36:16 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v4 1/4] efi: sysfb_efi: Replace open coded swap with the macro
Date: Fri,  5 Dec 2025 15:36:08 +0000
Message-ID: <20251205153611.93297-2-tvrtko.ursulin@igalia.com>
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

Replace the open coded width height swap with the standard macro.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Melissa Wen <mwen@igalia.com> # v3
---
 drivers/firmware/efi/sysfb_efi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 1e509595ac03..1d8b6966731c 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -357,10 +357,7 @@ __init void sysfb_apply_efi_quirks(void)
 
 	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
 	    dmi_check_system(efifb_dmi_swap_width_height)) {
-		u16 temp = screen_info.lfb_width;
-
-		screen_info.lfb_width = screen_info.lfb_height;
-		screen_info.lfb_height = temp;
+		swap(screen_info.lfb_width, screen_info.lfb_height);
 		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
 	}
 }
-- 
2.51.1


