Return-Path: <linux-efi+bounces-5758-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F6C9BB82
	for <lists+linux-efi@lfdr.de>; Tue, 02 Dec 2025 15:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 802F8347FFA
	for <lists+linux-efi@lfdr.de>; Tue,  2 Dec 2025 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7913322551;
	Tue,  2 Dec 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UcBN0cZl"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707232143C
	for <linux-efi@vger.kernel.org>; Tue,  2 Dec 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684637; cv=none; b=CUlZQEwcdS3KK22JMYEzKyswInlNh6MPd7Cv5KvmVYbxkD0k/rGVF8QyuH+gFf9F1FWn2tRMAgJLgRDHXjge8sRIsq8QpNVqFbS4fuMlZkq4jNaFYQcYk7QVhyjIkd97929oPaKLbWUkyBboq9YsRyVDRt6u5WbHE6auCmM+Mn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684637; c=relaxed/simple;
	bh=j7NcVlVEEpTyFSnuixnorltXYjW7UYpAo8UryAIM5qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5M9O06m2q/2pK6hFw2JXYBH7PfDtlnvZBXw8B7gKlcznmlLnAhrPljMPSpV1ktBv6ou9DKTdwJsxLl6qBGpblyv8yZS160atFmDPBIPIDZ8kR9TVRJw7SiHWIHazxL/wK1G+ZItGnu9OXhVDE7k5VrhRW8ETdppJgZU9arGGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UcBN0cZl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ha0ywpj/3JwjYOCczrwKYC/Pt6jKknOG54Qb0Na/Tic=; b=UcBN0cZl5VGQNrhX2uTwmHGiU+
	8GHaCWJAaJuo+IepgM0MKAnUGEcFGhZtWWLe19HwnLUsHeda62YcYt3AKIaTXbYNOLSoYMflk2dTM
	Mr/ZPylLcv/SxpoX5yZfTqY6QFy2xJH2aYntCOriQtk+OZ52Q1u1l+0jyIdyhu8R/TXl7hebCukFB
	apDz0si9D/MOewPr3J0iUbcrniYe1chURxlu3dvK70B/KavzQNXxU6/cjQ1sJvyO1opTl0qK3ckfB
	0BTx7NcUfAoXUsN+W/lXv2VdNc+vEu0dCI+DUmrF7aBvCpNNREsc7jF2nMAtnT4XHicBuqAgXOqrJ
	UIG/k82g==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vQR5H-007pdF-P2; Tue, 02 Dec 2025 15:10:27 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH 1/3] efi: sysfb_efi: Replace open coded swap with the macro
Date: Tue,  2 Dec 2025 14:10:23 +0000
Message-ID: <20251202141025.723-2-tvrtko.ursulin@igalia.com>
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


