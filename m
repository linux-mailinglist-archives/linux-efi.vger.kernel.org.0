Return-Path: <linux-efi+bounces-1233-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570F790B273
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3EFAB286F4
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6001F16849D;
	Mon, 17 Jun 2024 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+HXZI3s"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397B168492;
	Mon, 17 Jun 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630710; cv=none; b=AV1Ze0F/1wOtO1rLb+xJYcBvsVezFRWnaCXh1fmjrlzcArEDE0QNfvhIY7v48CkLUgtB70j2mKF/b8yX/JojKxF7vhfTCBXDP1vMbb99wEF75JsGvOh9UUArENkktQJmvHEfH3Wfq7HvwDw59NsBMJfsnRv7k/Hd6OkByFagFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630710; c=relaxed/simple;
	bh=oNCSYD22b+AHp/bvLU5Dst/3JlsBB7ZaEJbPjPmXykY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9bhlctbJPSQx0yRcUfbxGczkNv/A7bnPQz7oGflplxvKa0poTsg5p2DLE5EUPu+yUmJt6cQ/eolOK5MSm7BrDIhloChMP0FwkdpP07AK07HCKZ/+g9G8V9I2n7ZnAY8Oc6/CFhpByJn50ALqlYq+AuQkyPDXhUW5ufx27PV7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+HXZI3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1886C2BD10;
	Mon, 17 Jun 2024 13:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630709;
	bh=oNCSYD22b+AHp/bvLU5Dst/3JlsBB7ZaEJbPjPmXykY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G+HXZI3s8jWvL82LDVyRq22DKQdHJ158QLl5AYP/2688CNxNxpx8QRwpqRJ6AOwl7
	 gOtd7L+0LF6Zh4NyRm+ptuvRZhnkoKMXArDHOken40YBGnW+F/Ie3IzIsCgUnlnuqJ
	 x8ywtbZDA9jgeybnJGH5b1xzVvEjMuAc3PeN/BQlhG9lK/MdLvJ6ZGK3/fkDqHjY5K
	 mxXv1m4rNsWXfcPfTiuqbc09GZkOs+4z20KdZ9Fh2i2oY54nBxwvTTf6CIN9cKSZL5
	 PFwe0V9I3V0tf+Q1g6lqwHz/l2kP541voCv1gZ7FYFdP4HMckgwERtB+xfX6dr1a2i
	 YkIiw6I1KGn3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kees Cook <keescook@chromium.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/29] efi: pstore: Return proper errors on UEFI failures
Date: Mon, 17 Jun 2024 09:24:11 -0400
Message-ID: <20240617132456.2588952-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
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
index 3bddc152fcd43..8b2a9fc436a3f 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -107,7 +107,7 @@ static int efi_pstore_read_func(struct pstore_record *record,
 				     &size, record->buf);
 	if (status != EFI_SUCCESS) {
 		kfree(record->buf);
-		return -EIO;
+		return efi_status_to_err(status);
 	}
 
 	/*
@@ -152,7 +152,7 @@ static ssize_t efi_pstore_read(struct pstore_record *record)
 			return 0;
 
 		if (status != EFI_SUCCESS)
-			return -EIO;
+			return efi_status_to_err(status);
 
 		/* skip variables that don't concern us */
 		if (efi_guidcmp(guid, LINUX_EFI_CRASH_GUID))
@@ -190,7 +190,7 @@ static int efi_pstore_write(struct pstore_record *record)
 					    record->size, record->psi->buf,
 					    true);
 	efivar_unlock();
-	return status == EFI_SUCCESS ? 0 : -EIO;
+	return efi_status_to_err(status);
 };
 
 static int efi_pstore_erase(struct pstore_record *record)
@@ -201,7 +201,7 @@ static int efi_pstore_erase(struct pstore_record *record)
 				     PSTORE_EFI_ATTRIBUTES, 0, NULL);
 
 	if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
-		return -EIO;
+		return efi_status_to_err(status);
 	return 0;
 }
 
-- 
2.43.0


