Return-Path: <linux-efi+bounces-5757-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECCDC9BB97
	for <lists+linux-efi@lfdr.de>; Tue, 02 Dec 2025 15:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F443A744B
	for <lists+linux-efi@lfdr.de>; Tue,  2 Dec 2025 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5ED322A15;
	Tue,  2 Dec 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nfA4nme2"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF23161BD
	for <linux-efi@vger.kernel.org>; Tue,  2 Dec 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684636; cv=none; b=cbmoFr+2/ZhJ9f/msWnbDdn0NsDr4ef+8wBCEeOIrSUroYJAKGnNtr+GKHDkT/vB0mTyTi8EllzfbYeemyElp9+u/gZLSsZXsQiAwoSCSbdvBi8jBfaLhfhTQNfSR1EYITgiQx2AWRIfZVDWeQWMiaSFW5Fdbs7Rv0XnA2znryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684636; c=relaxed/simple;
	bh=IIl8WVmYKFyVelpwhyUGoI84y8zwygb+zw0EA25qdqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPxXAqCdaujVUTlAdd9bxZl0yrKiO6HDbHWseEgTpo/c+DjsFZPd5BEHLWipKEbwr3oIew4MULlEg9JmbDI1gmqbf/B/ptQW4UCA9BottRhD8T/P47d5wk+3momdTS2dQgia7SX8Ts4sV2NKCXGL4GKTK1yUo9FdTF8QfO+XNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nfA4nme2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tnLHwBWjpRMBHIofHo3RsFi15CzKFM3Q+NNqO1OSwRg=; b=nfA4nme2ME32QcdyckoivE9DiZ
	oPArQhhwAQOqZEqoC4PjR6Y6NOp/GOT5p8S5oX1SUwOjAyoUOWLpcTZFkZjqDBJGR+kdxu33by8xd
	pFAYIPylvKhzNjInmSTcRi0qvJegxUbw4of1Br0dkC7LE3i9TGrMgvDzfXrMeVneaBFF0KF27nsoU
	Cr1SyfL3rymq0JihmwU64CiI1ji96KfD9Z55qVc09aX8kRqxCca82q6V2GdWPVQ0ya9Pinarw7M2t
	EAIEuExwJArPbIom1l3g6tkAsetQr1ZFptl5ObfVRTqEcw1ngxFDN24Cl/DNoom/zF20U7D7FwJO/
	YOml2psQ==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vQR5H-007pdD-2d; Tue, 02 Dec 2025 15:10:27 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH 0/3] EFI fbcon fixes
Date: Tue,  2 Dec 2025 14:10:22 +0000
Message-ID: <20251202141025.723-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two generic fixes split out for easy review and then the last patch is the
panel/mode quirk to allow for corruption free fbcon with simpledrmfb and
efidrmfb on the Valve Steam Deck.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org

Tvrtko Ursulin (3):
  efi: sysfb_efi: Replace open coded swap with the macro
  efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
  efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck

 drivers/firmware/efi/sysfb_efi.c | 68 +++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 6 deletions(-)

-- 
2.51.1


