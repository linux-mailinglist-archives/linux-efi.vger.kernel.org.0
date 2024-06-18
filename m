Return-Path: <linux-efi+bounces-1241-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2990990CD16
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 15:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56DFB2B579
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 12:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244C21A00DB;
	Tue, 18 Jun 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVvDsq1Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04C1A00D7;
	Tue, 18 Jun 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714432; cv=none; b=GC3xx8lPYnRAh9bKMKxEt1vtvFgTtdSPSSpkehunaPrfToomp+MtqMXfrYbvztUXo+k+LRDJE3s94FYdSVleifMX3ncyJlNjBP9MfhV0IiTs77AyoRzc8AoahWRbIwzufgDIYiX2xzG1RO2LHFnX+n4jlsI+nOtEIHD5d7KoTg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714432; c=relaxed/simple;
	bh=oNCSYD22b+AHp/bvLU5Dst/3JlsBB7ZaEJbPjPmXykY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yxa8CRYwhqKVgBX+sypVzPENp6AB7RvINZlnnwPBQFalq3YlY4vjsnP28eJEK4wcXmKvOopWUxvqIB8nYxfXCluW+Mg2yzst7zPO9OQfXycEfK4UvcEZj1C89VEe775qh5IQkLC4rsZ4NUMkDkPbWK2IPvR0b1jHJsmdTyudfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVvDsq1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D57C4AF1D;
	Tue, 18 Jun 2024 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714431;
	bh=oNCSYD22b+AHp/bvLU5Dst/3JlsBB7ZaEJbPjPmXykY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVvDsq1QmXqHa139puoZ6VEQkVmvYdOJ/uCiQ6869J7GovOvsOs8FCHKFw3Z1iuBC
	 RROkKDuioEMntsmxR61THRnAJkTlZE6YeZTX7mnkRrFDuJ9NwyQF75mlvJ8MXeUd1L
	 lKo9avtGRMpIE2UhXrlTl1PZQlwuHsllUt/Gxh/jJaFFpWR5ja745t/ydTCO6CoQYB
	 LtwtXiWA6Onebn2hHl3/rU9CxqAcK/UQoo24gacZCeWnDO3k8zTugCCob1u4rWqXsn
	 9ZZBACMwbtanayYt5kTa3WKB3vvzoJiJxvheUKHyi4QJlBQw18++V4aSInYmgZ8OvW
	 5Pg6+OJuqBkLw==
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
Date: Tue, 18 Jun 2024 08:39:33 -0400
Message-ID: <20240618124018.3303162-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124018.3303162-1-sashal@kernel.org>
References: <20240618124018.3303162-1-sashal@kernel.org>
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


