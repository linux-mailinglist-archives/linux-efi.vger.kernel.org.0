Return-Path: <linux-efi+bounces-518-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A4852417
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 01:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB20E1C23553
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 00:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B362142;
	Tue, 13 Feb 2024 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYhrh7oW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241D66169C;
	Tue, 13 Feb 2024 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783689; cv=none; b=YxiW8dBezehvZYe75OaN/7YNOY9Yb6/quYOnce5skHHnyeovyrzcEyx+K2ZtTpHV3tHytPDAZ524WJVEtIVXv+zECFwuTm8q5JEPzyRSRE/JNSjlZTppLc1ohhMpyllUnicweZHELCqUfixteOQagqBu4xSP1oJoilO9APt+XmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783689; c=relaxed/simple;
	bh=Bf2Uhyq3nooeixg4duw6eP93tFcckfvUqcOeJHnFPv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q76+EgjRJzARsgjTU3x2q4e0M7Iod9YHBHVEmw2xkEVuloBR5FNiMQNRWghvDmRnrIRY6r2zkdtRMblpyu0+9zM2+zepzHXkLMYTGKnI1su7f1ZCbfvYFYi+FXWiNWOQnLV2/9DPwOOC1eJxDKXda5h3aL3j8A7pFmE0fF9ZOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYhrh7oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA2FC43390;
	Tue, 13 Feb 2024 00:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783688;
	bh=Bf2Uhyq3nooeixg4duw6eP93tFcckfvUqcOeJHnFPv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYhrh7oWNDkVvMVXNZIONWd52TO8cjz8xUZxQyKc92HLJpO6aRA7/AEINkWmYMNvy
	 KiV56E17j77rL/HWwsTVcbk9hILxqF757mrElmDeApIliI+jh9uGn3qMXLy40c5NPq
	 WBpVHPrxG4GELs3iMq7vC0zU5L2TnDn0npDnCil931Z7IxXGRHdLj+FvrSEqRt62Hb
	 i1w6mfzL8rZ4K5nedKIsCxG+Nf2lPK4uRfHs6RpQ1HuUrd7Uo7oVFXh/v15z9voIg3
	 IphSWjxcTlbVD0LisHuMTKC3gk+dFSOmCC30fWHmgJtV08V0L9bHwm+a0pZo01QIOb
	 O/IPXhUXvHvaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Bresticker <abrestic@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 28/51] efi: Don't add memblocks for soft-reserved memory
Date: Mon, 12 Feb 2024 19:20:05 -0500
Message-ID: <20240213002052.670571-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Andrew Bresticker <abrestic@rivosinc.com>

[ Upstream commit 0bcff59ef7a652fcdc6d535554b63278c2406c8f ]

Adding memblocks for soft-reserved regions prevents them from later being
hotplugged in by dax_kmem.

Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/efi-init.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index ef0820f1a924..59b0d7197b68 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -134,15 +134,6 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
 	case EFI_BOOT_SERVICES_DATA:
 	case EFI_CONVENTIONAL_MEMORY:
 	case EFI_PERSISTENT_MEMORY:
-		/*
-		 * Special purpose memory is 'soft reserved', which means it
-		 * is set aside initially, but can be hotplugged back in or
-		 * be assigned to the dax driver after boot.
-		 */
-		if (efi_soft_reserve_enabled() &&
-		    (md->attribute & EFI_MEMORY_SP))
-			return false;
-
 		/*
 		 * According to the spec, these regions are no longer reserved
 		 * after calling ExitBootServices(). However, we can only use
@@ -187,6 +178,16 @@ static __init void reserve_regions(void)
 		size = npages << PAGE_SHIFT;
 
 		if (is_memory(md)) {
+			/*
+			 * Special purpose memory is 'soft reserved', which
+			 * means it is set aside initially. Don't add a memblock
+			 * for it now so that it can be hotplugged back in or
+			 * be assigned to the dax driver after boot.
+			 */
+			if (efi_soft_reserve_enabled() &&
+			    (md->attribute & EFI_MEMORY_SP))
+				continue;
+
 			early_init_dt_add_memory_arch(paddr, size);
 
 			if (!is_usable_memory(md))
-- 
2.43.0


