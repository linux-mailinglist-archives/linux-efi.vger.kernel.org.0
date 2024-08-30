Return-Path: <linux-efi+bounces-1631-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2808966B46
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 23:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441F31F23005
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 21:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC11C0DF5;
	Fri, 30 Aug 2024 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3l6fKs4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70D1AF4ED;
	Fri, 30 Aug 2024 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053338; cv=none; b=YpuifAG00VQxblwB4jui/lam5CZeqdOvvDEpa6MOg/7Fss03fLVU8c1VSCWj4vSjJOzA72DPWXgEqIR/N6N/wUi4t96+YvZoUJyC0YGPMbPKsyTcpKBhHKiQzjGydgmbVO3NpDSFVkWC+qtqE7ztPKjr/zMPKBZgUzq3BXEzMPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053338; c=relaxed/simple;
	bh=xi5ypnQLc2NmRbqhUdbJqS6Xh7PZpHAyaDlsT+23K8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=asRZO1OQP43OBu8Syxh4fylpMYvxa+cbRSmUq0kxR8cXJkq3K1GF5WSTzwmq8aqU681LizNhyyvAnooJE/quFaHHBEOAehzud2Dex78a7FGK9gPEE9ZpilZanSfOdG+uuhF8YCpTF47U3CejaYurZIypelsKOuc84kfIM2iF294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3l6fKs4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a8197d82a9so53586085a.0;
        Fri, 30 Aug 2024 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725053335; x=1725658135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0EcSIrYthMSeRfaocjj9HmATPmKRqfQp0JHmuB2nzE=;
        b=J3l6fKs4SZ7X2MjJrRVJnxoiqgXoDQ8iFgmvJ/alEV4KA8J9ebe7QAvjHvhOWq179y
         rJvVVdQWBx0We3gXZBOiwPWPP5fZgaNGcduDufvq/Cu+PtvfMLBfuZRylwm3+h/RnJ+o
         PR2ZyW448N7tEjOCR/pIUWOZW5O59JZRPk0HZQM/Dza0psf/x1MFKG52Hszlgp//ZUrV
         K2nMvk3gUcw8bJTHvC1+jwQG1gJ8y4hwWTrADHEfxrUUnW+Cis3oRmWFJzVn0bMP5dBj
         p4pog9CEEHcVt0DR+aR7umbcLc+znYWBhVIyORdsxLUttYUbLjyocvlDmwowtD0xrzYd
         rH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725053335; x=1725658135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0EcSIrYthMSeRfaocjj9HmATPmKRqfQp0JHmuB2nzE=;
        b=HZFHnrwO2CdOqHtZ9CRLDqpUiQQW2IY5/viWvUMWAB9ldWSXwG0vDoamWKWDb4VRDS
         YOJuOFFXSSmlg0XtfKzz12QjrePerbvHp4uPZhsizHnFRkRwT/PS3duDee3ZhVJ2Jznz
         pnrgPYOvCohKIMjESNTeDm3EwRR2PgKH7b99+6RXUMJEDTLJAUXqsQ8pGZtvDbXIARVt
         SF0eqI3H+SkY74VpCB+ko3Hud9QXOvMADSd9nmuLnDJFTmzKrUYa8ZcVXu+zg1wV3j1R
         0q77gj5BqhSoaN8rEQqjtnOZUnhwNTJgM7VLXJeH6KKzJkW7zbiFkwPQ4VZkgMdGj9IT
         B6+g==
X-Forwarded-Encrypted: i=1; AJvYcCXM917n2iyMcVxhp0cuPyxhgHIG9GZRCHNscV28jMVxI4SGbcBARr8Rx9T87Jc1Cz1uvUEfsh9ndek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Y91FyGrCYTeqhkrTqk9IHLsd5NU8Moq7jASghYMZvPiA0DO0
	4sAfcC/26mm5SYdff8TqXAhFiu1rGvV5tU5Ju0jiDxUPXLU7YP+B
X-Google-Smtp-Source: AGHT+IG8hGztGGARS97CBWkTHiO0ttMSSdQvv9+k+V9Z8gcMiL/TJxnUtvzoTwYDR9J3UcnBM5gIHw==
X-Received: by 2002:a05:620a:2684:b0:7a4:faab:fc79 with SMTP id af79cd13be357-7a804187895mr875041885a.8.1725053335332;
        Fri, 30 Aug 2024 14:28:55 -0700 (PDT)
Received: from localhost (fwdproxy-ash-016.fbsv.net. [2a03:2880:20ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c2302csm181010985a.46.2024.08.30.14.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:28:54 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: ardb@kernel.org,
	linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	leitao@debian.org,
	gourry@gourry.net,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] efi: reserve memory for tpm_log only if TPM final events table is valid
Date: Fri, 30 Aug 2024 22:28:52 +0100
Message-ID: <20240830212852.2794145-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If efi.tpm_log is corrupted, log_tbl->size can be garbage (and
negative). This can result in a large memblock reservation, resulting
in the kernel booting without sufficient memory. Move the memblock
reservation after log_tbl->version check, and check the value of
both tbl_size and memblock_reserve.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 drivers/firmware/efi/tpm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index e8d69bd548f3..cfc6a065f441 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -59,9 +59,6 @@ int __init efi_tpm_eventlog_init(void)
 		return -ENOMEM;
 	}
 
-	tbl_size = sizeof(*log_tbl) + log_tbl->size;
-	memblock_reserve(efi.tpm_log, tbl_size);
-
 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
 		pr_info("TPM Final Events table not present\n");
 		goto out;
@@ -70,6 +67,19 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
+	tbl_size = sizeof(*log_tbl) + log_tbl->size;
+	if (tbl_size < 0) {
+		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	if (memblock_reserve(efi.tpm_log, tbl_size)) {
+		pr_err("TPM Event Log memblock reserve fails 0x%lx - %x\n",
+		       efi.tpm_log, tbl_size);
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	final_tbl = early_memremap(efi.tpm_final_log, sizeof(*final_tbl));
 
 	if (!final_tbl) {
-- 
2.43.5


