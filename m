Return-Path: <linux-efi+bounces-1238-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71C890CC6E
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547AA2861B5
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 12:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA0C16B3B0;
	Tue, 18 Jun 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jal7wAED"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3A16B3AA;
	Tue, 18 Jun 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714325; cv=none; b=lI4O+NFQljoMZ36ihkfwCPPXPUTrunHMZEWQFddyHgSghL2Z+TOwg8v8npGyB3RETqR8/pDO4P8V2rewhcVUAcENAaBJ7TobYWQDlAtA7Ek3Xo78b/I46+SQZ3pOaqOgaFyIRk9kFi7eVETfhWztvW4W4bN4nQL0aDaR1V6TVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714325; c=relaxed/simple;
	bh=DmjFNh2KZfm/OpeZUu86ZdwwMVuskNuuf73zXtlAuNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3mbNA9mFJqQYD9ojsW06gP3u0yqAwa2xMNrM1+wkRg4ZXgvEmVZURHE2Anz3GNMFncZi0f+CtuycOOjPvWYlZmyHqAymR2aBnvv9o8BcYtoXDCZdpp6U9e+Bg6SoaFyenqebVEsHJK0/frRsJUqUhqAayyzztX+pWo3I49sHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jal7wAED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4348C4AF48;
	Tue, 18 Jun 2024 12:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714325;
	bh=DmjFNh2KZfm/OpeZUu86ZdwwMVuskNuuf73zXtlAuNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jal7wAED58bGRupxegbW3xHGyno7MOhCO7TImIeDP97Xmq+sUSkuKwH7k2TS0uj7k
	 THoG3lZ7GRWmLM83Rp5lGgSfElEBSl+SCzJnDvUvP4qZ8xku08IXLTXqkTVgM5a6v+
	 0kyXUDtLr9MB2QgRNX151vlZawksJ9OnIOpQT56AqLkq5yWyZ3oVltkpF4N7x8Uh8D
	 4E52WPmoid+1JjeB8L3EgByTq145Akk8EmCk/UoShL/y4rRx4/Ligws/g47lSB3PSh
	 FP7jTXvMZyHTwn4SMyB53d9TdYLnCWEluwT0P8301aDsqqRCx/+dTcaRXbhnFu9N5T
	 wJb4ligrRFIWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kees Cook <keescook@chromium.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/35] efi: pstore: Return proper errors on UEFI failures
Date: Tue, 18 Jun 2024 08:37:27 -0400
Message-ID: <20240618123831.3302346-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
Content-Transfer-Encoding: 8bit

From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>

[ Upstream commit 7c23b186ab892088f76a3ad9dbff1685ffe2e832 ]

Right now efi-pstore either returns 0 (success) or -EIO; but we
do have a function to convert UEFI errors in different standard
error codes, helping to narrow down potential issues more accurately.

So, let's use this helper here.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/efi-pstore.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index e7b9ec6f8a86a..5669023bdd1de 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -109,7 +109,7 @@ static int efi_pstore_read_func(struct pstore_record *record,
 				     &size, record->buf);
 	if (status != EFI_SUCCESS) {
 		kfree(record->buf);
-		return -EIO;
+		return efi_status_to_err(status);
 	}
 
 	/*
@@ -154,7 +154,7 @@ static ssize_t efi_pstore_read(struct pstore_record *record)
 			return 0;
 
 		if (status != EFI_SUCCESS)
-			return -EIO;
+			return efi_status_to_err(status);
 
 		/* skip variables that don't concern us */
 		if (efi_guidcmp(guid, LINUX_EFI_CRASH_GUID))
@@ -192,7 +192,7 @@ static int efi_pstore_write(struct pstore_record *record)
 					    record->size, record->psi->buf,
 					    true);
 	efivar_unlock();
-	return status == EFI_SUCCESS ? 0 : -EIO;
+	return efi_status_to_err(status);
 };
 
 static int efi_pstore_erase(struct pstore_record *record)
@@ -203,7 +203,7 @@ static int efi_pstore_erase(struct pstore_record *record)
 				     PSTORE_EFI_ATTRIBUTES, 0, NULL);
 
 	if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
-		return -EIO;
+		return efi_status_to_err(status);
 	return 0;
 }
 
-- 
2.43.0


