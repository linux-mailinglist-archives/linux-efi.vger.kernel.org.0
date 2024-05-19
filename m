Return-Path: <linux-efi+bounces-1051-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12348C9545
	for <lists+linux-efi@lfdr.de>; Sun, 19 May 2024 18:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7386F1F2151D
	for <lists+linux-efi@lfdr.de>; Sun, 19 May 2024 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD08F45026;
	Sun, 19 May 2024 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ATAka4Ng"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC26650241;
	Sun, 19 May 2024 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716136494; cv=none; b=ZeBy6diGm8JOpfDbyVwkpExYC+C9jPhzP203EMHkOwbv2MZfCYp1Fme5MiJ67lJZZucfJrkpb31sd1FOgFmrRrzrItZj/fV07En0gZVAxIbM5creKDleBtPJAujgEj6q6363NLpx+EBNuhiaxOzxCYdkx0nzA9m5GfcjqsS7ULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716136494; c=relaxed/simple;
	bh=mCQA1IsGdx643ASaZUWdJypelqP7OH63LBTlNflqXjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uN9FR+J/H+KrHMx+1B0xeqpY/I7G9/jpeD57xoo/PW74dOecwQ/1I6mZGpEHfFGjbORC3IvXtGAxzyuGC+0RfEUeBh3cppTOdyGylYhaKy544sfn83t0/z2n/ZbWwWph/sg5lkxCbWYZrWYvEO81xTb7FI09SLx4dxdhhUijaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ATAka4Ng; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Fp4z2lsA/mfZJMe1Ji/tfTnc4+8wJnR7+oStLi9YpfE=; b=ATAka4Ng3mFh3qXpcWB9pafioF
	EWvg4aYerJPw0BY7b8JTLkBIPDT9C7MApPGgjm9Lr1MYKPkKXebQrN/ya6Wh2m1+A6E3sZxeyPXuj
	4S4CbWTm6sx/VhCPYR9+/A0mZNiCtuV8Sjh8Aljm466kYFuuF40gJB7w4uOFMw8JMvo4ddtbe+8c2
	prh8zGIv8/G8e5L3ZxKk7Ma5iEt6QIAB9098tBeFtBuJ3jWdHBwRRImSiCTaJST/4ge2fZt2IW01r
	cLgwZlmhHsBHmV3IsGVc1joZTmv17Wni+pCxvrnGA7wpRIEh0TnDhhV93EgVwcdufqDclyBMfQWVC
	+o44IxdQ==;
Received: from [187.34.225.121] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1s8jUb-009y9I-61; Sun, 19 May 2024 18:34:37 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: keescook@chromium.org,
	tony.luck@intel.com,
	ardb@kernel.org,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH] efi: pstore: Return proper errors on UEFI failures
Date: Sun, 19 May 2024 13:33:53 -0300
Message-ID: <20240519163428.1148724-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now efi-pstore either returns 0 (success) or -EIO; but we
do have a function to convert UEFI errors in different standard
error codes, helping to narrow down potential issues more accurately.

So, let's use this helper here.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/firmware/efi/efi-pstore.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 833cbb995dd3..194fdbd600ad 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -136,7 +136,7 @@ static int efi_pstore_read_func(struct pstore_record *record,
 				     &size, record->buf);
 	if (status != EFI_SUCCESS) {
 		kfree(record->buf);
-		return -EIO;
+		return efi_status_to_err(status);
 	}
 
 	/*
@@ -181,7 +181,7 @@ static ssize_t efi_pstore_read(struct pstore_record *record)
 			return 0;
 
 		if (status != EFI_SUCCESS)
-			return -EIO;
+			return efi_status_to_err(status);
 
 		/* skip variables that don't concern us */
 		if (efi_guidcmp(guid, LINUX_EFI_CRASH_GUID))
@@ -219,7 +219,7 @@ static int efi_pstore_write(struct pstore_record *record)
 					    record->size, record->psi->buf,
 					    true);
 	efivar_unlock();
-	return status == EFI_SUCCESS ? 0 : -EIO;
+	return efi_status_to_err(status);
 };
 
 static int efi_pstore_erase(struct pstore_record *record)
@@ -230,7 +230,7 @@ static int efi_pstore_erase(struct pstore_record *record)
 				     PSTORE_EFI_ATTRIBUTES, 0, NULL);
 
 	if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
-		return -EIO;
+		return efi_status_to_err(status);
 	return 0;
 }
 
-- 
2.43.2


