Return-Path: <linux-efi+bounces-5762-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B124C9DBF1
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 05:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E803A83E4
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 04:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4DB275AFF;
	Wed,  3 Dec 2025 04:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="u1KQvWd2"
X-Original-To: linux-efi@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E975F27057D
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 04:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764736183; cv=none; b=fVgDcGyAZ6Z8gLOkBkxFBV4qZaiH1D0wQmn3heH7ZXWiOF1dP2xtAORkZOUxCv7vW76c9VtZrRFvCHa5YhXLbOaxWFjEfcUwAAZfMFTXSeQt0XAbEiRzgg1am421YBMMSgORQU7Jrb0BHm7P196HhoAcZYWmokZB70AfQrfNw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764736183; c=relaxed/simple;
	bh=PRKsoquST5llbW2p7IYcBfsRWWFkLjLhJ2QscrO59LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Der+vZSGCB6n4qbZvMESqEbW/sblUT8Jp0WmuD45oqol6AmvUNsHuA/BkTR/jniD4TIANTYA4gO+qoU8B6fkrQnFYOKrm5aXcRrmEhDp5xBHzi+K5lEpThDzT7Z4Gx5qA4LB+m91SAneAN9BU0YIUTT3L3T0Cz83h4NOI3UNRng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=u1KQvWd2; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1764736168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HPuG0LGeUpQwYmuvaU8Ip5v/4vYxot6m+IfFCu3J3gw=;
	b=u1KQvWd24yzXZPkBz/vFdBoVCQ8o9oRsFBx2dajCx16QXA4SmncNE2rBBY62JzcNrAQR8V
	BCZKM1dPOQpF7nNsr2v2ab3h53vOxd8/R1EUs8Tx3KMhHyeMimNy5fjDRTbXOpXnjHfzny
	aLAH4oyii0phwKBdI0WrJ+GpP/AszUmiOF0thBIWaa3rGFLM3VtiV9M9e6y9m98OggeMrR
	QvZMC9oEFoi3mjXUztMmjT/iF8GI9+kmag4SSLwcNKdigBfOF8DWgtebY53EVOY6K/66wT
	JuCAHKADdtyfCjYQZbVxOff0KzE1jc9Ve/dTLYwxENTLSj2/g++NhQpvxsbqLA==
From: Val Packett <val@packett.cool>
To: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Val Packett <val@packett.cool>,
	linux-hardening@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi: pstore: Support late setup with TEE-backed efivars ops
Date: Wed,  3 Dec 2025 01:28:29 -0300
Message-ID: <20251203042850.14210-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On some platforms, EFI variable services only become available when an
appropriate TEE driver is initialized such as qseecom, gsmi or stmm.

This would work fine when efi_pstore was built as a module and loaded
late by userspace, but with CONFIG_EFI_VARS_PSTORE=y this driver would
quit due to non-writable efivars before the necessary driver had any
chance to load.

Listen to efivar_ops_nh notifications and retry the initialization when
writable EFI variable ops become available.

Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/firmware/efi/efi-pstore.c | 32 +++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index a253b6144945..ad5192d5892e 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -253,14 +253,11 @@ static struct pstore_info efi_pstore_info = {
 	.erase		= efi_pstore_erase,
 };
 
-static int efivars_pstore_init(void)
+static int efivars_pstore_setup(void)
 {
 	if (!efivar_supports_writes())
 		return 0;
 
-	if (pstore_disable)
-		return 0;
-
 	/*
 	 * Notice that 1024 is the minimum here to prevent issues with
 	 * decompression algorithms that were spotted during tests;
@@ -285,8 +282,35 @@ static int efivars_pstore_init(void)
 	return 0;
 }
 
+static int efivars_pstore_ops_notifier(struct notifier_block *nb,
+				 unsigned long event, void *data)
+{
+	if (event == EFIVAR_OPS_RDWR && !efi_pstore_info.bufsize)
+		efivars_pstore_setup();
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block efivars_pstore_ops_notifier_block = {
+	.notifier_call = efivars_pstore_ops_notifier,
+};
+
+static int efivars_pstore_init(void)
+{
+	if (pstore_disable)
+		return 0;
+
+	blocking_notifier_chain_register(&efivar_ops_nh,
+					&efivars_pstore_ops_notifier_block);
+
+	return efivars_pstore_setup();
+}
+
 static void efivars_pstore_exit(void)
 {
+	blocking_notifier_chain_unregister(&efivar_ops_nh,
+					&efivars_pstore_ops_notifier_block);
+
 	if (!efi_pstore_info.bufsize)
 		return;
 
-- 
2.51.0


