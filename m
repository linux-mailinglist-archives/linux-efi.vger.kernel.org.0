Return-Path: <linux-efi+bounces-2941-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2276AA5803D
	for <lists+linux-efi@lfdr.de>; Sun,  9 Mar 2025 02:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC58A7A5851
	for <lists+linux-efi@lfdr.de>; Sun,  9 Mar 2025 01:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322ADDDCD;
	Sun,  9 Mar 2025 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="yPNZGgS2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9789460;
	Sun,  9 Mar 2025 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741483678; cv=none; b=kAOK8rktVTeHVyQc03kdn8RbN8qE/O4FF8Zi49kUowcPDnbk0AwHDd4QLq+sZmtVFay7M+huMyaep8Qzi6aELF/lL7tvdm1m/F8MawRBjJkjfdbPwEslvK+3j6qWch0S+4NNJxDyHHY/tsNRpmR30sudJLCVvI3vhjuXsKSejRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741483678; c=relaxed/simple;
	bh=xJPFbbCqg6D1eGooecE45eWO6eo2FRhq7cqhpX/lTuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=owcoF3zNbbulzWIK3JbH6Qj9/4aRCMU3A/BMz4/p8p6aWRU9XsRPP+4czWNzpu9DmiQ89VvG8JB/5W9SiX5+mA6O1i4V+3fqKjOU6WpUusgi4t8DsICdi9xkPlUZAO52Rkr6zZjzVjq6jQxNftoVEexueBRvffhMJnh7JIxXjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=yPNZGgS2; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z9MpT5LQ6z9sTd;
	Sun,  9 Mar 2025 02:27:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741483666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tuC52dWg8Ua+xArW/iLzWfqJB+lNGdXuO8bhICk80qY=;
	b=yPNZGgS2P5Xhj0FZuR4IlwaaqI0vgSIw1KOnJx9YPo2OpM0jtus0XMuoK5e+vFbkeqYCNy
	HXWfI0cqPhV1rEfb8zhCEyye2+df8V8c4DF24QGgufrGl1jxnyl9zOdO5rBrfWl1DWCRyM
	oo6+aef6h8pB9kCkc5viO/c1C2fsTPtSJqE4//im+/evGsgRNMFWiBbtshD5cUfM/A9Vrs
	eWRIAGSxt00ML7+27GPZnHDSQXZCDmq5orb57AtNUC6MRlohBf/bPdW4HE7vdaBSrVVCVk
	J5Fz9+3yU3Ok5DxcCZ8/VkpbhpnjnOdairkKMzbE8Pr/HMa8Gf+nYfIM4dXVbQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 08 Mar 2025 20:27:41 -0500
Subject: [PATCH] efi: efibc: change kmalloc(size * count, ...) to
 kmalloc_array()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-efibc-kmalloc_array-v1-1-7bfc4013986f@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAIzuzGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwML3dS0zKRk3ezcxJyc/OT4xKKixErdpERzCwNL80QDcwMLJaDOgiK
 gqgqwqdGxtbUAQ0c37GUAAAA=
X-Change-ID: 20250308-efibc-kmalloc_array-ba78097a0708
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=xJPFbbCqg6D1eGooecE45eWO6eo2FRhq7cqhpX/lTuc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBKOTUxeXRlOWlmMVhiWFdsWTJicHo5ZVppYnFLS0oyCitBcWpqK0R0dE96Y3p5dldu
 WFB2S0dWaEVPTmlrQlZUWlBtZm81ejJVSE9Hd3M2L0xrMHdjMWlaUUlZd2NIRUsKd0VUVUZ6RXl
 yUGgvdzVOTDVMM3IyZnZobjdmRTdBOHB1YnJzNWk3UlY4OGkwM2RMbXljZWZzZndUMjBuMDZ4Zg
 oxcVlpOWJuM3ZxeWNWZUpmZTBrbWk2dE83cnJkeGNONzFxeXo1d0FBcE9wUkhBPT0KPXlLWGMKL
 S0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4Z9MpT5LQ6z9sTd

Open coded arithmetic in allocator arguments is discouraged. Helper
functions like kcalloc or, in this case, kmalloc_array are preferred.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/firmware/efi/efibc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 4f9fb086eab7b0e22252d22e59e5aae55865322d..0a7c764dcc614fbba3cbcd94183dc07939837a03 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -47,7 +47,7 @@ static int efibc_reboot_notifier_call(struct notifier_block *notifier,
 	if (ret || !data)
 		return NOTIFY_DONE;
 
-	wdata = kmalloc(MAX_DATA_LEN * sizeof(efi_char16_t), GFP_KERNEL);
+	wdata = kmalloc_array(MAX_DATA_LEN, sizeof(efi_char16_t), GFP_KERNEL);
 	if (!wdata)
 		return NOTIFY_DONE;
 

---
base-commit: 0a2f889128969dab41861b6e40111aa03dc57014
change-id: 20250308-efibc-kmalloc_array-ba78097a0708

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


