Return-Path: <linux-efi+bounces-5811-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DACCA8438
	for <lists+linux-efi@lfdr.de>; Fri, 05 Dec 2025 16:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 171A53047D16
	for <lists+linux-efi@lfdr.de>; Fri,  5 Dec 2025 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5EB318141;
	Fri,  5 Dec 2025 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sLFLqbxY"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690482F7AD6
	for <linux-efi@vger.kernel.org>; Fri,  5 Dec 2025 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948991; cv=none; b=EO53RVoIgr+DxLaDhfJgkS16mPKognIiLvQa8k6p7g0qNM+3v/utFaYQjIA/Yml4OHtzX95GkNHblFXSkEV7pgJNJn36LVszbYBL59OKEodiuBCvnEy9V7TFPdJhR2HfT4N8hIJp/xf1sqjGQIZGyLqPdc97sSdlIE1i/iNhP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948991; c=relaxed/simple;
	bh=f0axIY4rNI67uFQ6gAAdBqc4+KRnibyIiWcHRW/6N1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVqBAcNWJbwEq8C66+J3JJXE2olSQh7s3ffKiDb4XA+Kd8mP7harwT7mOLAW1ZybaYdGlQ0ou0p3jniiHSWx15SkSDLRf02i2NamwFplrjgfl9VdN3MlQmgkF5JLokyXQn8eNWkxslXS5b0pdzZ1lm4yWkSq5ZxESKLfCqfXC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sLFLqbxY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=22l+Dg8j6XiKyT5suXswaF1GbfAE3ZV72sOuJQFEWPM=; b=sLFLqbxYJCUqdiju8ivV2bAqNM
	ESH/OhVXJ/HDg2BJsW38/08ku9Hq9N3ZiwcNTr82oCBSVpseBvSA9rDeQRNFLcVmQqhCkS205mKCl
	kv9Qv+IVvPvASDhTITmYzK1YwX4bQsWSdDH+eC4I7bbZud++HsCl52v9ehkgRF5lLwmcNK9kVTqcd
	GI33Ww/q/g5f6biQ2IqlI7F5yt8yKmYXS8ksfbcj6pInFOEDT0cyee9DQe55pinMNVOmaqKDcCp2J
	SBTRi0Rp2YD69BOM40QZxxZcUoPouDX3NVtH9ppZVcZr9jkjxzQxU8zZtqOLzWD8mo32mnD+BuY+O
	35uQrz7A==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vRXqy-009808-29; Fri, 05 Dec 2025 16:36:16 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v4 0/4] EFI fbcon fixes etc
Date: Fri,  5 Dec 2025 15:36:07 +0000
Message-ID: <20251205153611.93297-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two generic fixes split out for easy review, one refactoring as requested, and
then the last patch is the panel/mode quirk to allow for corruption free fbcon
with simpledrmfb and efidrmfb on the Valve Steam Deck.

v2:
 * s/unsigned/unsigned int/
 * s/pitch/linelength/
 * Removed comment explaining the Steam Deck quirk.
 * Added patch to refactor quirk application via callbacks.

v3:
 * Added forgotten __initconst.
 * Use separate callback for the fixup quirk.

v4:
 * Use __screen_info_lfb_bits_per_pixel() instead of accessing lfb_depth directly.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org

Tvrtko Ursulin (4):
  efi: sysfb_efi: Replace open coded swap with the macro
  efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
  efi: sysfb_efi: Convert swap width and height quirk to a callback
  efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck

 drivers/firmware/efi/sysfb_efi.c | 73 ++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 8 deletions(-)

-- 
2.51.1


