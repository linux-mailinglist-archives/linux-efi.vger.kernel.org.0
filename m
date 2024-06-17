Return-Path: <linux-efi+bounces-1230-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 192DA90AFBF
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 15:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B581F21471
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF0F1BC06E;
	Mon, 17 Jun 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtvxmD2S"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9E1BC069;
	Mon, 17 Jun 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630603; cv=none; b=fYZXgP1qlxvfJVHMwdV7edrFmP2T4zcvpyLiKfSXy80cXdAcfdq06gNzaHgTEMEiuRM247LWaz3kcn8qz00RqFApQ+4iWnis/NoyAD58RHDYJaoXEsqIVCwlbMafegGWg5zA/ln6x8wqEwtQtHtOjUqSZWBRNM48Xexfn6PijhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630603; c=relaxed/simple;
	bh=DmjFNh2KZfm/OpeZUu86ZdwwMVuskNuuf73zXtlAuNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBo18VCJWgTx66W6mU2vippiU72ZAE+kwEDqRh6/5wjXv4Xfp4Z5g0Scu9+yH9YF00KAD5a972pUjitZAzu+VcoK1QAivGwCE77qDV3DsqXasEZCkdGRYyGkEdnUGa0FibI1EzfDIJ6RbREmsKd1d+y58N4RHp93L9g0Vb/U4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtvxmD2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4300AC4AF48;
	Mon, 17 Jun 2024 13:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630603;
	bh=DmjFNh2KZfm/OpeZUu86ZdwwMVuskNuuf73zXtlAuNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtvxmD2Sxpa8VL/os7yHD+AaegZrq3I1KT24FPBy5UksTwu6BvBFV7ccvehUOK9hy
	 AKCDcR+bvC/CGcDhhzsi7aIIB6cKLCbV/7ivrcBxPOat9NReeS/6Psur5qiHnDauGa
	 WyllNpoa477kyIyHGnfka1F9u2OzLSB/ZMdNlGnwgMWlcQYNxVvfdHdryEgMkRMdNu
	 kSvq1q72zYzrZs813UGkdTqARQ6c81xbMjzXPFzo7yrbvL5LA/9jXoypWD7XRyQp2A
	 pXb4l+osCJVYqKhmg0yb66u+JSYQMh3OLweS+CbPAurYYL8Vj8VPtqazYz9bE+jkLK
	 swFF/5w//xkQw==
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
Date: Mon, 17 Jun 2024 09:22:05 -0400
Message-ID: <20240617132309.2588101-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
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


