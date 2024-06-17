Return-Path: <linux-efi+bounces-1227-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A1990B092
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 15:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8B3B2ED8A
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1881419D075;
	Mon, 17 Jun 2024 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSHwkmXV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81119D06B;
	Mon, 17 Jun 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630461; cv=none; b=j5YnWdnQpRV0G2Z9/guBx+SyJSxicxvp8yLkhG/5/ePLlXSPBOOOvVqCYxd3dJ0q8w2kaTa9VXhNESpSD+cet9CP8PY4rnlP1GgdJrX0kc+xLFWW7zytPBT0bhyKNaeU5eqIqFK6n6FkDTQB4Qpx66fBeCjVx0tRd1kn/hcMq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630461; c=relaxed/simple;
	bh=3qO/bu8qgfFKtr3pb9LarfRM3RiaqcXJaOV4kYQdtXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADHNuVW1F5o/fj+DGyx+i2I4tI6LvzM/hn/J3io8zOwvH6EoQOpJhyANH8yiRitI2kHScg4SZ4Jsw49aMsXDQklmaHygnQUwaGwPdybG7HJTpiNE0xY5llXSlrr4DDqCX7pGGX7w1CZuis6LGjZ7GhB+Myk/A7LtDZdJN4O5Tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSHwkmXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AA8C4AF1C;
	Mon, 17 Jun 2024 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630460;
	bh=3qO/bu8qgfFKtr3pb9LarfRM3RiaqcXJaOV4kYQdtXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSHwkmXVvEoA83ZS3eSg3Iq6h5uFKt7K2mIV6gX4Cj+5wFcKDH+vuJ8QoxBcx/MIB
	 xYTTBdg15YY6q80/s2lH6DAtbdB/b+HWXTzasTWq53SN4UH1seGNjzHIR9h0l98Os5
	 oh1CXi0zX9A/yRN7Z8wYxjU78kNcEl9vTzpHAuXpY69IvNcAlDyl+6txGY5ZpYJ/it
	 erjyuxDahduDuHGcP5tiZh4r0CmANoYA0FhAznJ0Gr8Zw7mMvWqUp3GiM88uy8pUom
	 mIekHaU8vI3rEaMyau3SwTawZHtTmyYFrHTxRiAUqatRdkM01K7oCOK/D6NDj+iAs0
	 vy017xnJA/2Pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kees Cook <keescook@chromium.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 07/44] efi: pstore: Return proper errors on UEFI failures
Date: Mon, 17 Jun 2024 09:19:20 -0400
Message-ID: <20240617132046.2587008-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index 833cbb995dd3f..194fdbd600ad1 100644
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
2.43.0


