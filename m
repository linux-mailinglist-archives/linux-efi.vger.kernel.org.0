Return-Path: <linux-efi+bounces-4541-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A15AB229AD
	for <lists+linux-efi@lfdr.de>; Tue, 12 Aug 2025 16:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6B65609F5
	for <lists+linux-efi@lfdr.de>; Tue, 12 Aug 2025 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFEB288C9D;
	Tue, 12 Aug 2025 13:54:35 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3670288C96;
	Tue, 12 Aug 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006874; cv=none; b=phUF6k1DZGqPm9yL4a1ft9/0KMyfhSSR3ATF9hKdip9Fhr2vypFoiBVYOR9HRon+lwsoCoCbJNZrzM/C5aq/Y1vsbFRwuhEEbi8TK4Vska4SSb2oU0r83fFFel+x8dKvVl14OcnBz0UsqQ21w6/QkEVK+H24Oiazun3/pbUudgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006874; c=relaxed/simple;
	bh=gJrxZsuCamEst24Kf32qx2GybTeNB2tS7boJnCo8/uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8ceEFE1h6dZWF9VLBeQWnoCgQt0fs/KhmytEVPMobL8Yw3y/iKcSWN8MC4NHt4RkfoXqfYd4ci1BeQDgp8JuFGhNtnYLZDKyLtymDYJdzxtvCzi7ZtA7WJFMazkVHhhpS2jJ0EM6rc1LUO2b1L2Zg5n9OMS2GUEuMC6Bvh+x5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E33EC4CEFA;
	Tue, 12 Aug 2025 13:54:33 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ard Biesheuvel <ardb@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] efi: Explain OVMF acronym in OVMF_DEBUG_LOG help text
Date: Tue, 12 Aug 2025 15:54:29 +0200
Message-ID: <ed9efeafd80e9827bcc028d20a5bb20653af68e7.1755006858.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

People not very intimate with EFI may not know the meaning of the OVMF
acronym.  Write it in full, to help users with making good decisions
when configuring their kernels.

Fixes: f393a761763c5427 ("efi: add ovmf debug log driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/firmware/efi/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index d528c94c5859b5fa..29e0729299f5bd92 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -267,9 +267,10 @@ config OVMF_DEBUG_LOG
 	bool "Expose OVMF firmware debug log via sysfs"
 	depends on EFI
 	help
-	  Recent OVMF versions (edk2-stable202508 + newer) can write
-	  their debug log to a memory buffer.  This driver exposes the
-	  log content via sysfs (/sys/firmware/efi/ovmf_debug_log).
+	  Recent versions of the Open Virtual Machine Firmware
+	  (edk2-stable202508 + newer) can write their debug log to a memory
+	  buffer.  This driver exposes the log content via sysfs
+	  (/sys/firmware/efi/ovmf_debug_log).
 
 config UNACCEPTED_MEMORY
 	bool
-- 
2.43.0


