Return-Path: <linux-efi+bounces-5763-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5483EC9E68E
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 10:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D9794E1678
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA92D7DE1;
	Wed,  3 Dec 2025 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F2edOS9q"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9628DB46
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752838; cv=none; b=gmSBomnjFPwQkbUCxCK1NAM8NTrnIFV1Z0gna+ciQaWG3ZA+xrNz3VtB6YFCHLBY938Z4D/+f6UWV4wJqFKzPN4hcavGelOpOQrqWSwcm2FTYsgXcfqDyjk6kPToG5p261xtYkoNzm8YqKTvJTucGTSZrus4f0uSURhbSCHwFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752838; c=relaxed/simple;
	bh=j7NcVlVEEpTyFSnuixnorltXYjW7UYpAo8UryAIM5qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVmMO0iBvi6bNBMD2QdVQBqPC6yesUJ1YOgATbUnDLmbuVSIMYsadDe2hRQIctxuqb3A2dQmmV6QF3Yepq++5X98q8EJd5YmJ5i/EJRFVHzPGTsNnlkjUXxI4/M8gnYBdDRFFve7V5ko4/J8f5YTpCxyx+1mApPCv7+N4f2x/YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=F2edOS9q; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ha0ywpj/3JwjYOCczrwKYC/Pt6jKknOG54Qb0Na/Tic=; b=F2edOS9qcXspdwMHSOdzCrxf0f
	0PMDEYy1/pQC9ewx2mn8QaLTYj4uzi6jRc0ftPZ0lOCjyqE0UiOi60hmAyMVPZL6KRnysVCcbwGFG
	DPobfnDiyl6xcaa0IsNP5ZQmI2MoGyS6c5p2qphBkjMaS00r+4AmRiSzKJzGc45C92MHXWDLSTFwR
	42ikBILhNxvA2FRtqkNAW14KRczYhbtVB6ygEIj2hR/P9f1qjHHsoqFqTETAYIVw6Q572JfXXQu3T
	jBkNXE7d2GWvz65+CluRCzv/qTcSJ999tCl2ez0egjdWtpTVpkdfCwL58VjztgH5Z1JsKSNjVc/F1
	rPFzdMYg==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vQipJ-008BpR-QB; Wed, 03 Dec 2025 10:07:09 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v2 1/4] efi: sysfb_efi: Replace open coded swap with the macro
Date: Wed,  3 Dec 2025 09:07:03 +0000
Message-ID: <20251203090706.53778-2-tvrtko.ursulin@igalia.com>
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

Replace the open coded width height swap with the standard macro.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org
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


